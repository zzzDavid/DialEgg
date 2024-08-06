#ifndef S_EXPRESSION_PARSER_H
#define S_EXPRESSION_PARSER_H

#include "mlir/IR/Value.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Builders.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"

#include "EqSatOp.h"
#include "Utils.h"

/**
 * Splits the given egglog expression string into a list of strings: function name and parameters.
 * Example: "(linalg_add (linalg_abs (tensor_empty)) (tensor_empty))" -> ["linalg_add", "(linalg_abs (tensor_empty))", "(tensor_empty)"]
 */
std::vector<std::string> splitEgglogExpression(std::string opStr) {
    // The expression must be surrounded by parentheses
    if (opStr.front() != '(' || opStr.back() != ')') {
        std::cerr << "Invalid expression: " << opStr << "\n";
        exit(1);
    }

    // split by whitespace that is not inside parentheses, square brackets, or quotes
    std::vector<std::string> result;
    std::stringstream ss;

    int openParentheses = 0;
    bool inQuotes = false;
    for (size_t i = 1; i < opStr.size() - 1; i++) {
        char c = opStr[i];

        if (c == '(' || c == '[') {
            openParentheses++;
        } else if (c == ')' || c == ']') {
            openParentheses--;
        }

        if (c == '"' && opStr[i - 1] != '\\') {
            inQuotes = !inQuotes;
        }

        if (iswspace(c) && openParentheses == 0 && !inQuotes && !isBlank(ss.str())) {
            result.push_back(ss.str());
            ss.str("");
        } else {
            ss << c;
        }
    }

    if (!isBlank(ss.str())) {
        result.push_back(ss.str());
    }

    return result;
}

/**
 * Parses an Egglog expressions into MLIR operations.
 * The Egglog expressions are in the form of S-expressions.
 * Example: `(arith_constant (NamedAttr "value" (FloatAttr 1.0 "f64")) "f64")` -> `arith.constant 1.0 : f64`
 */
class EgglogParser {
public:
    EgglogParser(mlir::MLIRContext& context,
                 std::vector<EqSatOp*>& ops,
                 std::map<std::string, EqSatOp*>& ssaNameToBlockOp,
                 std::map<std::string, EqSatOpInfo>& opRegistry,
                 EqSatPassCustomFunctions& customFunctions)
        : context(context), ops(ops), ssaNameToBlockOp(ssaNameToBlockOp), opRegistry(opRegistry), customFunctions(customFunctions) {}

    /** Parses the given type string into an MLIR type */
    mlir::Type parseType(std::string typeStr) {
        typeStr = unwrap(typeStr, '"');
        return mlir::parseType(typeStr, &context);
    }

    /** Parses the given attribute string into an MLIR named attribute. Form (NamedAttr "<name>" <attr>) */
    mlir::NamedAttribute parseNamedAttribute(const std::string& attrStr) {
        std::vector<std::string> split = splitEgglogExpression(attrStr);

        mlir::StringAttr attrName = mlir::StringAttr::get(&context, unwrap(split[1], '"'));
        mlir::Attribute attr = parseAttribute(split[2]);
        return mlir::NamedAttribute(attrName, attr);
    }

    /** Parses the given attribute string into an MLIR attribute. Form (<type> <arg1> <arg2> ... <argN>) */
    mlir::Attribute parseAttribute(const std::string& attrStr) {
        std::vector<std::string> split = splitEgglogExpression(attrStr);

        std::string attrType = split[0];
        if (attrType == "IntegerAttr") {
            return mlir::IntegerAttr::get(parseType(split[2]), std::stoll(split[1]));
        } else if (attrType == "FloatAttr") {
            return mlir::FloatAttr::get(parseType(split[2]), std::stod(split[1]));
        } else if (attrType == "StringAttr") {
            return mlir::parseAttribute(split[1], &context);
        } else if (attrType == "OtherAttr") {
            return mlir::parseAttribute(unwrap(split[1], '"'), &context);
        } else if (customFunctions.attrParsers.find(attrType) != customFunctions.attrParsers.end()) {
            AttrParseFunction parseFunc = customFunctions.attrParsers.at(attrType);
            return parseFunc(split, context);
        } else {  // TODO custom attr here
            std::cerr << "Unsupported attribute type: " << attrType << std::endl;
            exit(1);
        }
    }

    ssize_t nextOperationId(const std::string& newOpStr) {
        std::vector<std::string> split = splitEgglogExpression(newOpStr);
        return std::stoll(split[1]);
    }

    /**
     * Parses the given operation string into a list of MLIR operations, in order or dependency.
     * Example:
     *      (linalg_transpose (tensor_empty "tensor<3x2xf32>") (tensor_empty "tensor<2x3xf32>") "tensor<2x3xf32>")
     * Becomes:
     *      %0 = tensor.empty() : tensor<3x2xf32>
     *      %1 = tensor.empty() : tensor<2x3xf32>
     *      %2 = linalg.transpose %0, %1 : tensor<3x2xf32>, tensor<2x3xf32>
     */
    mlir::Operation* parseOperation(const std::string& newOpStr, mlir::OpBuilder& builder) {
        std::vector<std::string> split = splitEgglogExpression(newOpStr);

        std::string opName = split[0];
        ssize_t opId = std::stoll(split[1]);

        if (opId >= 0) {
            mlir::Operation* rep = ops[opId]->replacementOp;
            if (rep != nullptr) {
                return rep;
            } else {
                return ops[opId]->mlirOp;
            }
        }

        std::replace(opName.begin(), opName.end(), '_', '.');  // Replace underscores with dots
        EqSatOpInfo opInfo = opRegistry.at(opName);

        // Operands
        std::vector<mlir::Value> operands;
        for (ssize_t i = 0; i < opInfo.nOperands; i++) {
            std::string operandStr = split[i + 2];
            ssize_t operandId = nextOperationId(operandStr);

            llvm::outs() << "PARSING OPERAND: " << operandStr << " ID: " << operandId << "\n";

            if (operandStr.find("(NamedOp ") == 0) {
                EqSatOp* eqSatOperand = ops[operandId];
                operands.push_back(eqSatOperand->resultValue);
            } else if (operandId < 0) {  // new operation
                mlir::Operation* nestedOperand = parseOperation(operandStr, builder);
                mlir::Value operand = nestedOperand->getResult(0);  // TODO support multiple results?
                operands.push_back(operand);
            } else {  // existing operation, refered to by id
                mlir::Value operandReplacement = ops[operandId]->replacementOp->getResult(0);
                operands.push_back(operandReplacement);
            }
        }

        // attr
        std::vector<mlir::NamedAttribute> attributes;
        for (size_t i = 0; i < opInfo.attributes.size(); i++) {
            mlir::NamedAttribute attr = parseNamedAttribute(split[i + opInfo.nOperands + 2]);
            attributes.push_back(attr);
        }

        // Return type
        mlir::Type type = parseType(split.back());

        // Create the operation
        mlir::Operation* newOp = nullptr;

        if (opName.find("linalg.") == 0) {  // custom ops
            std::string op = opName.substr(7);
            if (op == "transpose") {
                mlir::Attribute attr = attributes[0].getValue();
                newOp = builder.create<mlir::linalg::TransposeOp>(mlir::UnknownLoc::get(&context), operands[0], operands[1], attr.cast<mlir::DenseI64ArrayAttr>());
            }
        } else {  // other ops that have no hidden region, thus are easy to create with OperationState
            mlir::OperationState state(mlir::UnknownLoc::get(&context), opName);
            state.addOperands(operands);
            state.addAttributes(attributes);
            state.addTypes(type);

            newOp = builder.create(state);
        }

        return newOp;
    }

public:
    mlir::MLIRContext& context;

    std::vector<EqSatOp*>& ops;                         // All operations in the block, index = op id
    std::map<std::string, EqSatOp*>& ssaNameToBlockOp;  // Map of SSA name to EqSatOp
    std::map<std::string, EqSatOpInfo>& opRegistry;     // Map of operation name to EqSatOpInfo
    EqSatPassCustomFunctions& customFunctions;
};

#endif  //S_EXPRESSION_PARSER_H