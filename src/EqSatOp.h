//
// Created by Abd-El-Aziz Zayed on 2024-07-06.
//

#ifndef EQ_SAT_OPT_EQSATOP_H
#define EQ_SAT_OPT_EQSATOP_H

#include <vector>
#include <iostream>
#include <mlir/IR/Operation.h>

/**
 * The Operation name, and the number of ins and outs it takes.
 * e.g. "linalg.add" takes 2 ins and 1 out.
 * TODO encode attributes as well?
 */
struct EqSatOpType { // TODO use
    std::string name;

    size_t ins;
    std::vector<std::string> inTypes;

    size_t outs;
    std::vector<std::string> outTypes;
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
    mlir::Operation& mlirOp;         // Reference to op

    EqSatOp(const std::string& result, const std::string& name, const std::string& type, const std::vector<const EqSatOp*>& operands, mlir::Operation& mlirOp)
        : resultId(result), name(name), type(type), operands(operands), mlirOp(mlirOp) {}

    /** Returns the ins of the EqSatOp */
    [[nodiscard]] std::vector<const EqSatOp*> getInputs() const {
        if (operands.empty()) {
            return operands;
        }

        std::vector<const EqSatOp*> inputs(operands.begin(), operands.end() - 1);  // all but the last element, which is the "outs"
        return inputs;
    }

    /** Prints the EqSatOp to the given output stream */
    void print(std::ostream& os = std::cout) const {
        os << "EqSatOp " << resultId << " = " << name << "[ ";
        for (const EqSatOp* operand: operands) {
            os << operand->resultId << " ";
        }
        os << "] : " << type << "\n";
    }

    /** Returns the egglog s-expression with "let" for the given EqSatOp */
    [[nodiscard]] std::string egglog() const {
        // (<op> <resultId> <operand1> <operand2> ... <operandN> "<type>")
        std::stringstream ss;

        std::string cleanName = name;
        std::replace(cleanName.begin(), cleanName.end(), '.', '_');

        ss << "(" << cleanName << " " << resultId;
        for (const EqSatOp* operand: operands) {
            ss << " " << operand->resultId;
        }
        ss << " \"" << type << "\")";
        return ss.str();
    }

    /** Returns the egglog s-expression for the given EqSatOp */
    [[nodiscard]] std::string egglogLet() const {
        // (let <resultId> (<op> <name> <operand2> ... <operandN> "<type>"))
        std::stringstream ss;
        ss << "(let " << resultId << " " << egglog() << ")";
        return ss.str();
    }
};

#endif  //EQ_SAT_OPT_EQSATOP_H
