#ifndef EQUALITYSATURATIONPASS_H
#define EQUALITYSATURATIONPASS_H

#include <set>
#include <map>
#include <unordered_map>

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"

#include "Egglog.h"
#include "Utils.h"

struct EqualitySaturationPass : public mlir::PassWrapper<EqualitySaturationPass, mlir::OperationPass<mlir::func::FuncOp>> {
    const std::string egglogExecutable;
    std::string eggFilePath;
    EgglogCustomDefs customFunctions;

    const std::string egglogExtractedFilename = "egg/egglog-extract.txt";
    const std::string egglogLogFilename = "egg/egglog-log.txt";

    std::map<std::string, EgglogOpDef> supportedOps;
    std::set<std::string> supportedDialects;

    EqualitySaturationPass(const std::string egglogExecutable, const std::string& eggFilePath, const EgglogCustomDefs& funcs);
    EqualitySaturationPass(const std::string& eggFilePath, const EgglogCustomDefs& funcs);

    mlir::StringRef getArgument() const override;
    mlir::StringRef getDescription() const override;
    void runOnOperation() override;
    void runOnBlock(mlir::Block& block);
    void runEgglog(const std::vector<EggifiedOp>& block);
};

#endif  // EQUALITYSATURATIONPASS_H
