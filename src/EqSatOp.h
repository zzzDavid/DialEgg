#ifndef EQ_SAT_OPT_EQSATOP_H
#define EQ_SAT_OPT_EQSATOP_H

#include <vector>
#include <string>
#include <iostream>
#include <fstream>

#include "mlir/IR/Operation.h"
#include "llvm/Support/raw_os_ostream.h"

#include "Utils.h"

/**
 * The Operation name, and the number of operands it takes and results it returns. Also, the attributes it has.
 * e.g. "linalg.add" takes 3 operands and returns 1 result, and has no attributes.
 */
struct EqSatOpInfo {
    std::string name;
    ssize_t nOperands;  // not stable
    ssize_t nResults;   // not stable
    std::vector<std::string> attributes;

    EqSatOpInfo(const std::string& name, ssize_t nOperands, ssize_t nResults, const std::vector<std::string>& attributes)
        : name(name), nOperands(nOperands), nResults(nResults), attributes(attributes) {}

    EqSatOpInfo(const std::string& name, ssize_t nOperands, ssize_t nResults, mlir::MLIRContext& context) : name(name), nOperands(nOperands), nResults(nResults) {
        mlir::OperationName opName(name, &context);
        llvm::ArrayRef<mlir::StringAttr> attrs = opName.getAttributeNames();

        std::vector<std::string> attributes;
        for (const mlir::StringAttr& attr: attrs) {
            attributes.emplace_back(attr.str());
        }

        this->attributes = attributes;
    }
    EqSatOpInfo(const std::string& name, mlir::MLIRContext& context) : EqSatOpInfo(name, -1, -1, context) {}
    EqSatOpInfo(mlir::Operation& op, mlir::MLIRContext& context) : EqSatOpInfo(op.getName().getStringRef().str(), op.getNumOperands(), op.getNumResults(), context) {}

    void print(std::ostream& os = std::cout) const {
        os << name << ", " << nOperands << " operands, " << nResults << " results";
        os << ", " << attributes.size() << " attributes: [";
        for (const std::string& attr: attributes) {
            os << attr << ", ";
        }

        if (!attributes.empty()) {
            os.seekp(-2, std::ios_base::end);
        }

        os << "]\n";
    }

    static void serializeOpRegistry(const std::map<std::string, EqSatOpInfo>& opRegistry, const std::string& filename) {
        std::ofstream file(filename);
        for (const auto& [name, opType]: opRegistry) {
            opType.print(file);
        }

        file.close();
    }
};

/**
 * Represents an EqSat operation, which is a node in an AST-like structure.
 * The resultId is the variable name in mlir, for easy reference.
 */
struct EqSatOp {
    size_t id;

    bool opaque;                     // If the operation is only needed for it's result value, thus the details should be hidden
    std::string name;                // name of the operation
    std::string type;                // type of the operation
    std::vector<EqSatOp*> operands;  // 0 or more operands

    mlir::Operation* mlirOp;                   // Reference to op - can be nullptr
    mlir::Operation* replacementOp = nullptr;  // Replacement operation - can be nullptr

    mlir::Value resultValue;    // result value
    std::string resultSSAName;  // SSA name of the result value

    EqSatOp(size_t id, const std::string& name, const std::string& type, const std::vector<EqSatOp*>& operands, mlir::Operation* mlirOp, mlir::Value resultValue, bool opaque = false)
        : id(id), opaque(opaque), name(name), type(type), operands(operands), mlirOp(mlirOp), resultValue(resultValue), resultSSAName(getSSAName(resultValue)) {}

    std::string getPrintId() const {
        return (opaque ? "arg" : "op") + std::to_string(id);
    }

    /** Prints the EqSatOp to the given output stream */
    void print(std::ostream& os = std::cout) const {
        llvm::raw_os_ostream ros(os);

        os << "EqSatOp " << getPrintId() << " = ";

        if (!name.empty()) {
            os << name;
        } else {
            os << resultSSAName;
        }

        // attrs
        os << " ( ";
        if (mlirOp != nullptr) {
            for (const mlir::NamedAttribute& attr: mlirOp->getAttrs()) {
                os << attr.getName().str() << " = ";
                attr.getValue().print(ros);
                ros.flush();
                os << " ";
            }
        }
        os << ")";

        // operands
        os << " [ ";
        for (const EqSatOp* operand: operands) {
            os << operand->getPrintId() << " ";
        }
        os << "]";

        // type
        os << " : " << type << "\n";
    }

    /** Returns the egglog s-expression with "let" for the given EqSatOp */
    std::string egglog() const {
        // (<op> <id> <operand1> <operand2> ... <operandN> <attr1> <attr2> ... <attrM> "<type>")

        std::stringstream ss;

        if (opaque) {
            ss << "(NamedOp " << id << " \"" << type << "\")";
            return ss.str();
        }

        std::string cleanName = name;
        std::replace(cleanName.begin(), cleanName.end(), '.', '_');

        ss << "(";

        // Operation <op> <id>
        ss << cleanName << " " << id;

        // Operands <operand1> <operand2> ... <operandN>
        for (const EqSatOp* operand: operands) {
            ss << " " << operand->getPrintId();
        }

        // Attributes <attr1> <attr2> ... <attrM>
        if (mlirOp != nullptr) {
            for (const mlir::NamedAttribute& attr: mlirOp->getAttrs()) {
                ss << " " << egglogAttr(attr);
            }
        }

        // Type "<type>"
        ss << " \"" << type << "\")";

        return ss.str();
    }

    /** Returns the egglog s-expression for the given MLIR attribute */
    std::string egglogAttr(mlir::NamedAttribute namedAttr) const {
        // (NamedAttr "<name>" <attr>)

        std::string egglogCode;
        llvm::raw_string_ostream ss(egglogCode);

        ss << "(NamedAttr ";

        // Name "<name>"
        ss << namedAttr.getName();

        // Attribute <attr>
        mlir::Attribute attr = namedAttr.getValue();
        mlir::TypeID typeId = attr.getTypeID();
        if (typeId == mlir::TypeID::get<mlir::IntegerAttr>()) {  // (IntegerAttr <int> <type>)
            mlir::IntegerAttr integerAttr = attr.cast<mlir::IntegerAttr>();
            int64_t value = integerAttr.getInt();
            ss << " (IntegerAttr " << value << " \"" << integerAttr.getType() << "\")";
        } else if (typeId == mlir::TypeID::get<mlir::FloatAttr>()) {  // (FloatAttr <float> <type>)
            mlir::FloatAttr floatAttr = attr.cast<mlir::FloatAttr>();
            double value = floatAttr.getValueAsDouble();
            ss << " (FloatAttr " << value << " \"" << floatAttr.getType() << "\")";
        } else if (typeId == mlir::TypeID::get<mlir::StringAttr>()) {  // (StringAttr "<string>")
            mlir::StringAttr stringAttr = attr.cast<mlir::StringAttr>();
            std::string value = stringAttr.getValue().str();
            ss << " (StringAttr \"" << value << "\")";
        } else {  // (OtherAttr "<attr>" "<type-name>")
            ss << " (OtherAttr \"" << attr << "\" \"" << attr.getAbstractAttribute().getName() << "\")";
        }

        ss << ")";

        ss.flush();

        return egglogCode;
    }

    /** Returns the egglog s-expression for the given EqSatOp */
    std::string egglogLet() const {
        // (let <resultId> <egglog>)
        std::stringstream ss;
        ss << "(let " << getPrintId() << " " << egglog() << ")";
        return ss.str();
    }
};

#endif  //EQ_SAT_OPT_EQSATOP_H
