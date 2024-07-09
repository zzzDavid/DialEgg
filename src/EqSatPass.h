#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"

struct EqSatPass : public mlir::PassWrapper<EqSatPass, mlir::OperationPass<mlir::func::FuncOp>> {
    [[nodiscard]] mlir::StringRef getArgument() const override;
    [[nodiscard]] mlir::StringRef getDescription() const override;
    void runOnOperation() override;
};
