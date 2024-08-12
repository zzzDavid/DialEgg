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
    ssize_t nOperands, nResults;
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

    void print(llvm::raw_ostream& os = llvm::outs()) const {
        os << name << ", " << nOperands << " operands, " << nResults << " results";
        os << ", " << attributes.size() << " attributes: [";

        if (!attributes.empty()) {
            os << attributes[0];
        }
        for (size_t i = 1; i < attributes.size(); i++) {
            os << ", " << attributes[i];
        }

        os << "]\n";
    }

    static void serializeOpRegistry(const std::map<std::string, EqSatOpInfo>& opRegistry, const std::string& filename) {
        std::error_code ec;
        llvm::raw_fd_ostream file(filename, ec);
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
    std::vector<EqSatOp*> operands;  // 0 or more operands

    mlir::Operation* mlirOp;                   // Reference to op - can be nullptr
    mlir::Operation* replacementOp = nullptr;  // Replacement operation - can be nullptr

    mlir::Value resultValue;    // result value
    std::string resultSSAName;  // SSA name of the result value

    EqSatOp(size_t id,
            const std::string& name,
            const std::vector<EqSatOp*>& operands,
            mlir::Operation* mlirOp,
            mlir::Value resultValue,
            bool opaque = false)
        : id(id), opaque(opaque), name(name), operands(operands), mlirOp(mlirOp), resultValue(resultValue), resultSSAName(getSSAName(resultValue)) {}

    std::string getPrintId() const {
        return "op" + std::to_string(id);
    }

    /** Prints the EqSatOp to the given output stream */
    void print(llvm::raw_ostream& ros = llvm::outs()) const {
        ros << "EqSatOp " << getPrintId() << " = ";

        if (!name.empty()) {
            ros << name;
        } else {
            ros << resultSSAName;
        }

        // attrs
        ros << " ( ";
        if (mlirOp != nullptr) {
            for (const mlir::NamedAttribute& attr: mlirOp->getAttrs()) {
                ros << attr.getName().str() << " = " << attr.getValue() << " ";
            }
        }
        ros << ")";

        // operands
        ros << " [ ";
        for (const EqSatOp* operand: operands) {
            ros << operand->getPrintId() << " ";
        }
        ros << "]";

        // type
        ros << " : " << resultValue.getType();

        // location
        if (mlirOp != nullptr) {
            ros << " (" << mlirOp->getLoc() << ")";
        }

        ros << "\n";
    }

    std::string mlir() const {
        if (mlirOp == nullptr) {
            return valueToString(resultValue);
        } else {
            return opToString(*mlirOp);
        }
    }
};

#endif  //EQ_SAT_OPT_EQSATOP_H
