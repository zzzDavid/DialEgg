//
// Created by Abd-El-Aziz Zayed on 2024-07-06.
//

#ifndef EQ_SAT_OPT_EQSATOP_H
#define EQ_SAT_OPT_EQSATOP_H

#include <vector>
#include <iostream>
#include <mlir/IR/Operation.h>
#include "mlir/IR/Types.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/IR/Dialect.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Types.h"
#include "mlir/AsmParser/AsmParser.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/raw_os_ostream.h"

struct EqSatOp;

struct EqSatOpGraph {
    std::vector<std::string> opResultIds;
    std::unordered_map<std::string, const EqSatOp*> ops;

    EqSatOpGraph() = default;

    const EqSatOp* getOp(const std::string& resultId) const {
        return ops.at(resultId);
    }

    void addOp(const std::string& resultId, const EqSatOp* op) {
        opResultIds.push_back(resultId);
        ops.emplace(resultId, op);
    }
};


/**
 * The Operation name, and the number of ins and outs it takes.
 * e.g. "linalg.add" takes 2 ins and 1 out.
 * TODO encode attributes as well in map (name -> type)
 */
struct EqSatOpType { // TODO use
    std::string name;

    size_t ins;
    std::vector<std::string> inTypes;

    size_t outs;
    std::vector<std::string> outTypes;

    std::string attrName;
};


/**
 * Represents an EqSat operation, which is a node in an AST-like structure.
 * The resultId is the variable name in mlir, for easy reference.
 */
struct EqSatOp {
    std::string resultId;                  // todo handle an op that returns multiple results, so this single id might change
    std::string name;                      // name of the operation
    std::string type;                      // type of the operation
    std::vector<const EqSatOp*> operands;  // 0 or more operands
    mlir::Operation& mlirOp;               // Reference to op

    EqSatOp(const std::string& result, const std::string& name, const std::string& type, const std::vector<const EqSatOp*>& operands, mlir::Operation& mlirOp)
        : resultId(result), name(name), type(type), operands(operands), mlirOp(mlirOp) {}

    /** Prints the EqSatOp to the given output stream */
    void print(std::ostream& os = std::cout) const {
        llvm::raw_os_ostream ros(os);
        os << "EqSatOp " << resultId << " = " << name;

        // attrs
        os << " (";
        for (const mlir::NamedAttribute& attr: mlirOp.getAttrs()) {
            os << attr.getName().str() << " = ";
            attr.getValue().print(ros);
            ros.flush();
            os << "  ";
        }
        os << ")";

        // operands
        os << " [";
        for (const EqSatOp* operand: operands) {
            os << operand->resultId << " ";
        }
        os << "]";

        // type
        os << " : " << type << "\n";
    }

    /** Returns the egglog s-expression with "let" for the given EqSatOp */
    [[nodiscard]] std::string egglog() const {
        // (<op> <operand1> <operand2> ... <operandN> <attr> "<type>")
        std::stringstream ss;

        std::string cleanName = name;
        std::replace(cleanName.begin(), cleanName.end(), '.', '_');

        ss << "(" << cleanName;
        for (const EqSatOp* operand: operands) {
            ss << " " << operand->resultId;
        }
        ss << " " << egglogAttrs();
        ss << " \"" << type << "\")";
        return ss.str();
    }

    /** Returns the egglog s-expression for the attributes of the given EqSatOp */
    [[nodiscard]] std::string egglogAttrs() const {
        llvm::ArrayRef<mlir::NamedAttribute> attrs = mlirOp.getAttrs();
        if (attrs.empty()) {
            return "";
        } else if (attrs.size() == 1) {
            return egglogAttr(attrs[0].getValue());
        } else {
            std::cerr << "Multiple attributes not supported yet for op " << name << "\n";
            exit(1);
        }
    }

    /** Returns the egglog s-expression for the given MLIR attribute */
    [[nodiscard]] std::string egglogAttr(mlir::Attribute attr) const {
        std::string egglogCode;
        llvm::raw_string_ostream ss(egglogCode);

        mlir::TypeID typeId = attr.getTypeID();
        if (typeId == mlir::TypeID::get<mlir::IntegerAttr>()) { // (IntegerAttr <int> <type>)
            mlir::IntegerAttr integerAttr = attr.cast<mlir::IntegerAttr>();
            int64_t value = integerAttr.getInt();
            ss << "(IntegerAttr " << value << " \"" << integerAttr.getType() << "\")";
        } else if (typeId == mlir::TypeID::get<mlir::FloatAttr>()) { // (FloatAttr <float> <type>)
            mlir::FloatAttr floatAttr = attr.cast<mlir::FloatAttr>();
            double value = floatAttr.getValueAsDouble();
            ss << "(FloatAttr " << value << " \"" << floatAttr.getType() << "\")";
        } else if (typeId == mlir::TypeID::get<mlir::StringAttr>()) {  // (StringAttr "<string>")
            mlir::StringAttr stringAttr = attr.cast<mlir::StringAttr>();
            std::string value = stringAttr.getValue().str();
            ss << "(StringAttr \"" << value << "\")";
        } else { // (OtherAttr "<attr>")
            ss << "(OtherAttr \"" << attr << "\")";
        }

        ss.flush();

        return egglogCode;
    }

    /** Returns the egglog s-expression for the given EqSatOp */
    [[nodiscard]] std::string egglogLet() const {
        // (let <resultId> <egglog>)
        std::stringstream ss;
        ss << "(let " << resultId << " " << egglog() << ")";
        return ss.str();
    }
};

#endif  //EQ_SAT_OPT_EQSATOP_H
