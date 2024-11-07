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

    double mlirToEgglogTime = 0.0;
    double egglogExecTime = 0.0;
    double egglogToMlirTime = 0.0;

    EqualitySaturationPass();
    EqualitySaturationPass(const std::string egglogExecutable, const std::string& eggFilePath, const EgglogCustomDefs& funcs);
    EqualitySaturationPass(const std::string& eggFilePath, const EgglogCustomDefs& funcs);

    mlir::StringRef getArgument() const override { return "eq-sat"; }
    mlir::StringRef getDescription() const override { return "Performs equality saturation on each block in the given file. The language definition is egglog."; }
    
    void runOnOperation() override;
    void runOnBlock(mlir::Block& block, const std::string& blockName);
    void runEgglog(const std::vector<EggifiedOp>& block, const std::string& blockName);
};

std::unique_ptr<mlir::Pass> createEqualitySaturationPass(const std::string& egglogExecutable, const std::string& eggFilePath, const EgglogCustomDefs& funcs);
std::unique_ptr<mlir::Pass> createEqualitySaturationPass(const std::string& eggFilePath, const EgglogCustomDefs& funcs);

#endif  // EQUALITYSATURATIONPASS_H
