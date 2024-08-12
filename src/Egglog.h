#ifndef EGGLOG_H
#define EGGLOG_H

#include <map>
#include <vector>

#include "mlir/IR/MLIRContext.h"

#include "EqSatPass.h"
#include "EqSatOp.h"

/**
 * Holds all egglog informations and operations.
 * The Egglog expressions are in the form of S-expressions.
 * Example: `(arith_constant (NamedAttr "value" (FloatAttr 1.0 "f64")) "f64")` -> `arith.constant 1.0 : f64`
 */
class Egglog {
public:
    Egglog(mlir::MLIRContext& context,
           std::vector<EqSatOp*>& ops,
           std::map<std::string, EqSatOp*>& ssaNameToBlockOp,
           std::map<std::string, EqSatOpInfo>& opRegistry,
           EqSatPassCustomFunctions& customFunctions)
        : context(context), ops(ops), ssaNameToBlockOp(ssaNameToBlockOp), opRegistry(opRegistry), customFunctions(customFunctions) {}

    /**
     * Splits the given egglog expression string into a list of strings: function name and parameters.
     * Example: "(linalg_add (linalg_abs (tensor_empty)) (tensor_empty))" -> ["linalg_add", "(linalg_abs (tensor_empty))", "(tensor_empty)"]
     */
    static std::vector<std::string> splitExpression(std::string opStr);

    /** Parses the given type string into an MLIR type Form (F16) or (Complex <type>) */
    mlir::Type parseType(std::string typeStr);
    std::string eggifyType(mlir::Type type);

    /** Parses the given attribute string into an MLIR named attribute. Form (NamedAttr "<name>" <attr>) */
    mlir::NamedAttribute parseNamedAttribute(const std::string& attrStr);
    std::string eggifyNamedAttribute(mlir::NamedAttribute namedAttr);

    /** Parses the given attribute string into an MLIR attribute. Form (<type> <arg1> <arg2> ... <argN>) */
    mlir::Attribute parseAttribute(const std::string& attrStr);
    std::string eggifyAttribute(mlir::Attribute attr);

    ssize_t nextOperationId(const std::string& newOpStr) {
        std::vector<std::string> split = splitExpression(newOpStr);
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
    mlir::Operation* parseOperation(const std::string& newOpStr, mlir::OpBuilder& builder);  // TODO return EqSatOp
    /** Returns the egglog s-expression for the given EqSatOp */
    std::string eggifyOperationWithLet(const EqSatOp& op);
    /** Returns the egglog s-expression with "let" for the given EqSatOp */
    std::string eggifyOperation(const EqSatOp& op);

public:
    mlir::MLIRContext& context;

    std::vector<EqSatOp*>& ops;                         // All operations in the block, index = op id
    std::map<std::string, EqSatOp*>& ssaNameToBlockOp;  // Map of SSA name to EqSatOp
    std::map<std::string, EqSatOpInfo>& opRegistry;     // Map of operation name to EqSatOpInfo
    EqSatPassCustomFunctions& customFunctions;
};

#endif  //EGGLOG_H