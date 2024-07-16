#include <map>
#include <unordered_map>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <string_view>

#include <mlir/IR/Value.h>
#include <llvm/IR/Module.h>
#include <mlir/IR/Builders.h>
#include <llvm/ADT/Hashing.h>
#include <mlir/IR/OperationSupport.h>
#include <mlir/Dialect/Linalg/IR/Linalg.h>
#include <mlir/Dialect/Linalg/IR/LinalgInterfaces.h>
#include "mlir/AsmParser/AsmParser.h"

#include "EqSatPass.h"
#include "EqSatOp.h"

mlir::StringRef EqSatPass::getArgument() const {
    return "eq-sat";
}

mlir::StringRef EqSatPass::getDescription() const {
    return "Performs equality saturation on each block in the given file. The language definition is egglog.";
}

std::string getSSAValueName(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName;
    llvm::raw_string_ostream ssaNameStream(ssaName);
    value.printAsOperand(ssaNameStream, opPrintingFlags);
    ssaNameStream.flush();
    return ssaName;
}

std::string getTypeName(const mlir::Value& value) {
    std::string type;
    llvm::raw_string_ostream typeStream(type);
    value.getType().print(typeStream);
    typeStream.flush();
    return type;
}

std::string getSSAValueId(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName = getSSAValueName(value, opPrintingFlags);
    return "op_" + ssaName.substr(1);  // remove the % prefix
}

std::ifstream extractOps(const EqSatOpGraph& ops) {
    std::string eggFilename = "../res/egg.egg";
    std::string stdOutFilename = "../res/egglog-extract.txt";
    std::string stdErrFilename = "../res/egglog-stderr.txt";

    std::ofstream eggFile(eggFilename, std::ios::app);

    // print egglog
    eggFile << std::endl;
    for (const std::string& resultId : ops.opResultIds) {
        eggFile << ops.getOp(resultId)->egglogLet() << std::endl;
    }

    // run egglog
    eggFile << std::endl;
    eggFile << "(run 100000)" << std::endl;

    // Extract the results of the egglog run
    for (const std::string& resultId : ops.opResultIds) {
        eggFile << "(extract " << resultId << ")" << std::endl;
    }

    eggFile.close();

    // Run egglog and extract the results
    std::string egglogCmd = "../egglog " + eggFilename + " --to-svg > " + stdOutFilename + " 2> " + stdErrFilename;
    std::cout << "\nRunning egglog: " << egglogCmd << std::endl;

    std::system(egglogCmd.c_str());

    // Parse the results
    return std::ifstream(stdOutFilename);
}

/**
 * Splits the given operation string into a vector of strings.
 * Example: "(linalg_add (linalg_abs (tensor_empty)) (tensor_empty))" -> ["linalg_add", "(linalg_abs (tensor_empty))", "(tensor_empty)"]
 */
std::vector<std::string> splitOperation(std::string opStr) {
    // remove the outer parentheses
    if (opStr.front() == '(' && opStr.back() == ')') {
        opStr = opStr.substr(1, opStr.size() - 2);
    }

    // split by whitespace that is not inside parentheses, sqaure brackets, or quotes
    std::vector<std::string> result;
    std::stringstream ss;

    int openParentheses = 0;
    for (char c: opStr) {
        if (c == '(' || c == '[') {
            openParentheses++;
        } else if (c == ')' || c == ']') {
            openParentheses--;
        }

        if (c == ' ' && openParentheses == 0 && !ss.str().empty()) {
            result.push_back(ss.str());
            ss.str("");
        } else {
            ss << c;
        }
    }

    if (!ss.str().empty()) {
        result.push_back(ss.str());
    }

    return result;
}

std::string stripOf(const std::string& str, char c) {
    if (str.front() == c && str.back() == c) {
        return str.substr(1, str.size() - 2);
    }
    return str;
}

/** Parses the given type string into an MLIR type */
mlir::Type parseType(std::string typeStr, mlir::MLIRContext& context) {
    if (typeStr.front() == '"' && typeStr.back() == '"') { // Remove surrounding quotes
        typeStr = typeStr.substr(1, typeStr.size() - 2);
    }

    return mlir::parseType(typeStr, &context);
}

/** Parses the given attribute string into an MLIR attribute. Form (<type> <ins>) */
mlir::Attribute parseAttribute(const std::string& attrStr, mlir::MLIRContext& context) {
    std::vector<std::string> split = splitOperation(attrStr);

    std::string attrType = split[0];
    if (attrType == "IntegerAttr") {
        int64_t value = std::stoll(split[1]);
        mlir::Type type = parseType(split[2], context);
        return mlir::IntegerAttr::get(type, value);
    } else if (attrType == "FloatAttr") {
        double value = std::stod(split[1]);
        mlir::Type type = parseType(split[2], context);
        return mlir::FloatAttr::get(type, value);
    } else if (attrType == "StringAttr") {
        std::string pAttrStr = split[1] + (split.size() > 2 ? split[2] : "") + (split.size() > 3 ? split[3] : "");
        return mlir::parseAttribute(pAttrStr, &context);
    } else if (attrType == "OtherAttr") {
        std::string pAttrStr = split[1] + (split.size() > 2 ? split[2] : "") + (split.size() > 3 ? split[3] : "");
        pAttrStr = stripOf(pAttrStr, '"');
        return mlir::parseAttribute(pAttrStr, &context);
    } else {
        std::cerr << "Unsupported attribute type: " << attrType << "\n";
        exit(1);
    }
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
mlir::Operation* createOperation(const std::string& newOpStr, mlir::MLIRContext& context, mlir::OpBuilder& builder) {
    std::vector<std::string> split = splitOperation(newOpStr);

    std::string opName = split[0];
    std::replace(opName.begin(), opName.end(), '_', '.'); // Replace underscores with dots
    mlir::OperationName mlirOpName = mlir::OperationName(opName, &context);

    // Operands
    std::vector<mlir::Value> operands;
    for (size_t i = 1; i < split.size() - 2; i++) {
        mlir::Operation* nestedOperand = createOperation(split[i], context, builder);
        mlir::Value operand = nestedOperand->getResult(0); // TODO support multiple results?
        operands.push_back(operand);
    }

    // attr
    std::string attrStr = split[split.size() - 2];
    llvm::StringRef attrName = mlirOpName.getAttributeNames()[0];
    mlir::Attribute attr = parseAttribute(attrStr, context); // TODO make it named? It's easier
    llvm::outs() << "ATTR " << attrName << " = " << attr << "\n";

    // Return type
    mlir::Type type = parseType(split.back(), context);
    llvm::outs() << "TYPE: " << type << "\n";

    // Create the operation
    mlir::Operation* newOp = nullptr;

    // custom ops
    if (opName.find("linalg.") == 0) {
        std::string op = opName.substr(7);
        if (op == "transpose") {
            newOp = builder.create<mlir::linalg::TransposeOp>(mlir::UnknownLoc::get(&context), operands[0], operands[1], attr.cast<mlir::DenseI64ArrayAttr>());
        }
    } else {
        mlir::OperationState state(mlir::UnknownLoc::get(&context), opName);
        state.addOperands(operands);
        state.addAttribute(attrName, attr); // TODO support multiple attributes
        state.addTypes(type);

        newOp = builder.create(state);
    }

    llvm::outs() << "OPERATION: ";
    newOp->print(llvm::outs());
    llvm::outs() << "\n";

    return newOp;
}

void EqSatPass::runOnOperation() {
    mlir::MLIRContext& context = getContext();
    mlir::func::FuncOp rootOp = getOperation();

    // Perform equality saturation on all operations of a block.
    // Re-create the MLIR operations in this block according to the optimization.
    for (mlir::Block& block: rootOp.getRegion().getBlocks()) {

        EqSatOpGraph ops; // Map of result SSA value id to EqSatOp for all operations in the block
        for (mlir::Operation& op: block.getOperations()) {
            if (op.getNumResults() == 0) {  // continue if this op has no results
                continue;
            }

            std::vector<const EqSatOp*> operands;
            for (const mlir::Value& operand: op.getOperands()) {
                std::string operandId = getSSAValueId(operand, mlir::OpPrintingFlags().enableDebugInfo());
                operands.push_back(ops.getOp(operandId)); // TODO support use of ops from other blocks, so we don't have the value (this is easy)
            }

            mlir::Value result0 = op.getResult(0); // TODO support multiple results (this is hard)

            std::string opId = getSSAValueId(result0);
            std::string opName = op.getName().getStringRef().str();
            std::string opType = getTypeName(result0);

            EqSatOp* eqSatOp = new EqSatOp(opId, opName, opType, operands, op);
            ops.addOp(opId, eqSatOp);

            eqSatOp->print(std::cout);
        }

        std::ifstream file = extractOps(ops); // Prep egg file

        for (const std::string& resultId : ops.opResultIds) {
            std::string line;
            std::getline(file, line);

            std::cout << resultId << " = " << line << std::endl;

            mlir::Operation& prevOp = ops.getOp(resultId)->mlirOp;
            mlir::OpBuilder builder(&prevOp);
            mlir::Operation* newOp = createOperation(line, context, builder);

            mlir::Value result = newOp->getResult(0);
            mlir::Value replaced = prevOp.getResult(0);

            llvm::outs() << "REPLACING: " << replaced << " WITH " << result << "\n";
            replaced.replaceAllUsesWith(result);

            prevOp.erase(); // remove the old op so no clutter
        }

        // TODO cleanup
    }
}