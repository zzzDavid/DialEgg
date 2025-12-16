#ifndef RECONSTRUCT_FROM_EXTRACTION_PASS_H
#define RECONSTRUCT_FROM_EXTRACTION_PASS_H

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
 * Pass that reconstructs MLIR from extraction results.
 * This is step 2 of the decoupled extraction workflow.
 * 
 * Inputs:
 * - Original MLIR file
 * - <name>.extraction-metadata.txt: Metadata about which operations to extract
 * - <name>.extracted.txt: Extraction results (S-expressions), one per line
 * 
 * The extraction file can come from any external extraction tool, as long as it
 * provides S-expressions in the same order as listed in the metadata file.
 */
class ReconstructFromExtractionPass : public mlir::PassWrapper<ReconstructFromExtractionPass, mlir::OperationPass<mlir::ModuleOp>> {
public:
    ReconstructFromExtractionPass(const std::string& mlirFile, const EgglogCustomDefs& funcs)
        : mlirFilePath(mlirFile), customFunctions(funcs) {}

    mlir::StringRef getArgument() const override { return "reconstruct-from-extraction"; }
    mlir::StringRef getDescription() const override { 
        return "Reconstructs MLIR from extraction results (step 2 of decoupled extraction)"; 
    }

    void runOnOperation() override;
    llvm::LogicalResult initialize(mlir::MLIRContext* context) override;

private:
    void runOnBlock(mlir::Block& block, const std::string& blockName, std::ifstream& extractionFile);
    
    std::string mlirFilePath;
    std::string eggFilePath;
    std::string extractionFilename;
    std::string metadataFilename;

    EgglogCustomDefs customFunctions;
    std::map<std::string, EgglogOpDef, std::less<>> supportedOps;
    std::set<std::string> supportedDialects;

    double mlirToEgglogTime = 0;
    double egglogToMlirTime = 0;
};

#endif // RECONSTRUCT_FROM_EXTRACTION_PASS_H

