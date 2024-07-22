#ifndef EQSATPASS_H
#define EQSATPASS_H

#include <set>

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"

struct EqSatPass : public mlir::PassWrapper<EqSatPass, mlir::OperationPass<mlir::func::FuncOp>> {
    std::string eggBaseFile = "res/egg/op.egg";
    std::set<std::string> supportedOps;
    std::set<std::string> supportedDialects;

    EqSatPass();

    mlir::StringRef getArgument() const override;
    mlir::StringRef getDescription() const override;
    void runOnOperation() override;
};

#endif //EQSATPASS_H
