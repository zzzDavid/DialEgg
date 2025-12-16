#ifndef EGGIFY_ONLY_PASS_H
#define EGGIFY_ONLY_PASS_H

#include <map>
#include <unordered_map>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>

#include "llvm/Support/FileSystem.h"
#include "mlir/IR/Value.h"
#include "mlir/IR/Builders.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "circt/Dialect/HW/HWOps.h"

#include "Utils.h"
#include "Egglog.h"
#include "EgglogCustomDefs.h"

/**
 * Pass that converts MLIR to Egglog and runs egglog to generate an E-graph JSON.
 * This is step 1 of the decoupled extraction workflow.
 * 
 * Outputs:
 * - <name>.ops.egg: The egglog program with operations
 * - <name>.egraph.json: The e-graph state from egglog --to-json
 * - <name>.extraction-metadata.txt: Metadata about which operations should be extracted
 */
class EggifyOnlyPass : public mlir::PassWrapper<EggifyOnlyPass, mlir::OperationPass<mlir::ModuleOp>> {
public:
    EggifyOnlyPass(const std::string& mlirFile, const EgglogCustomDefs& funcs)
        : mlirFilePath(mlirFile), customFunctions(funcs) {}

    mlir::StringRef getArgument() const override { return "eggify-only"; }
    mlir::StringRef getDescription() const override { 
        return "Converts MLIR to Egglog and generates E-graph JSON (step 1 of decoupled extraction)"; 
    }

    void runOnOperation() override;
    llvm::LogicalResult initialize(mlir::MLIRContext* context) override;

private:
    void runOnBlock(mlir::Block& block, const std::string& blockName);
    void runEgglog(const std::vector<EggifiedOp*>& block, const std::string& blockName);
    void saveExtractionMetadata(const std::vector<EggifiedOp*>& block, const std::string& blockName);

    std::string mlirFilePath;
    std::string eggFilePath;
    std::string egglogOutputFilename;
    std::string egglogLogFilename;
    std::string metadataFilename;

    EgglogCustomDefs customFunctions;
    std::map<std::string, EgglogOpDef, std::less<>> supportedOps;
    std::set<std::string> supportedDialects;

    double mlirToEgglogTime = 0;
    double egglogExecTime = 0;
};

#endif // EGGIFY_ONLY_PASS_H

