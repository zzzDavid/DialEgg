#include <chrono>
#include "EggifyOnlyPass.h"

#define DEBUG_TYPE "dialegg"

extern llvm::cl::opt<std::string> eggFileOpt;

void EggifyOnlyPass::runEgglog(const std::vector<EggifiedOp*>& block, const std::string& blockName) {
    std::ifstream eggFile(eggFilePath);
    std::vector<std::string> egglogLines;

    // Read the egglog file
    std::string opsTarget = ";; OPS HERE ;;";
    std::string extractsTarget = ";; EXTRACTS HERE ;;";

    bool insertedOps = false;
    bool insertedExtracts = false;

    auto start = std::chrono::high_resolution_clock::now();

    std::string line;
    while (std::getline(eggFile, line)) {
        egglogLines.push_back(line);

        if (!insertedOps && line == opsTarget) {
            egglogLines.push_back("; " + blockName);
            for (const EggifiedOp* op: block) {
                egglogLines.push_back(op->egglogLet());
            }
            insertedOps = true;
        } else if (!insertedExtracts && line == extractsTarget) {
            // Define RootNode for each operation that should be extracted
            // This marks the extraction targets in the E-graph
            for (const EggifiedOp* op: block) {
                if (op->shouldBeExtracted()) {
                    egglogLines.push_back("(let root_" + op->getPrintId() + " (RootNode " + op->getPrintId() + "))");
                }
            }
            insertedExtracts = true;
        }
    }
    eggFile.close();

    // Write the egglog program to a .ops.egg file
    std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
    std::string opsEggFilePath = name + ".ops.egg";
    std::ofstream eggFileOut(opsEggFilePath);
    for (const std::string& line: egglogLines) {
        eggFileOut << line << "\n";
    }
    eggFileOut.close();

    auto end = std::chrono::high_resolution_clock::now();
    mlirToEgglogTime += std::chrono::duration<double>(end - start).count();

    // Run egglog with --to-json to generate e-graph
    std::string egglogCmd = "egglog " + opsEggFilePath + " --to-json > " + egglogOutputFilename + " 2> " + egglogLogFilename;

    LLVM_DEBUG(llvm::dbgs() << "Running egglog: " << egglogCmd << "\n");

    start = std::chrono::high_resolution_clock::now();
    int ret = std::system(egglogCmd.c_str());
    end = std::chrono::high_resolution_clock::now();

    if (ret != 0) {
        printFileContents(egglogLogFilename);
        printFileContents(egglogOutputFilename);
        llvm::errs() << "Egglog failed\n";
        exit(1);
    }

    egglogExecTime += std::chrono::duration<double>(end - start).count();

    LLVM_DEBUG(printFileContents(egglogLogFilename));
    LLVM_DEBUG(printFileContents(egglogOutputFilename));
    LLVM_DEBUG(llvm::dbgs() << "Done running egglog\n");
}

void EggifyOnlyPass::saveExtractionMetadata(const std::vector<EggifiedOp*>& block, const std::string& blockName) {
    std::ofstream metadataFile(metadataFilename, std::ios::app);
    
    metadataFile << "BLOCK: " << blockName << "\n";
    
    for (const EggifiedOp* eggOp: block) {
        if (eggOp->shouldBeExtracted()) {
            metadataFile << eggOp->getPrintId() << "\t";
            
            // Save the MLIR operation for reference
            if (eggOp->mlirOp != nullptr) {
                std::string mlirOpStr;
                llvm::raw_string_ostream rso(mlirOpStr);
                eggOp->mlirOp->print(rso);
                metadataFile << mlirOpStr;
            }
            metadataFile << "\n";
        }
    }
    
    metadataFile << "END_BLOCK\n\n";
    metadataFile.close();
}

void EggifyOnlyPass::runOnBlock(mlir::Block& block, const std::string& blockName) {
    auto start = std::chrono::high_resolution_clock::now();

    // Eggify the block
    mlir::MLIRContext& context = getContext();
    Egglog egglog(context, customFunctions, supportedOps);

    // Register all block arguments
    for (mlir::Value value: block.getArguments()) {
        egglog.eggifyValue(value);
    }

    for (mlir::Operation& op: block.getOperations()) {
        egglog.eggifyOperation(&op);
    }

    auto end = std::chrono::high_resolution_clock::now();
    mlirToEgglogTime += std::chrono::duration<double>(end - start).count();

    // Dump all ops
    for (const EggifiedOp* eggOp: egglog.eggifiedBlock) {
        LLVM_DEBUG(eggOp->print(llvm::dbgs()));
    }

    // Run egglog to generate e-graph
    runEgglog(egglog.eggifiedBlock, blockName);

    // Save metadata about which operations should be extracted
    saveExtractionMetadata(egglog.eggifiedBlock, blockName);

    LLVM_DEBUG(llvm::dbgs() << "\n");
}

void EggifyOnlyPass::runOnOperation() {
    mlir::ModuleOp module = getOperation();
    
    // Find all functions and hw modules in the module
    for (mlir::Operation& op: module.getOps()) {
        if (auto funcOp = llvm::dyn_cast<mlir::func::FuncOp>(&op)) {
            llvm::StringRef funcName = funcOp.getName();
            LLVM_DEBUG(llvm::dbgs() << "Running on function: " << funcName << "\n");
            
            for (mlir::Block& block: funcOp.getRegion().getBlocks()) {
                std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
                std::string blockName = funcName.str() + "_" + parentOpName;
                runOnBlock(block, blockName);
            }
        } else if (auto hwModuleOp = llvm::dyn_cast<circt::hw::HWModuleOp>(&op)) {
            llvm::StringRef moduleName = hwModuleOp.getName();
            LLVM_DEBUG(llvm::dbgs() << "Running on HW module: " << moduleName << "\n");
            
            for (mlir::Block& block: hwModuleOp.getBodyRegion().getBlocks()) {
                std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
                std::string blockName = moduleName.str() + "_" + parentOpName;
                runOnBlock(block, blockName);
            }
        } else {
            llvm::errs() << "Skipping non-function/non-hw-module operation: " << op.getName() << "\n";
        }
    }

    llvm::outs() << "✅ Eggify-only pass completed!\n";
    llvm::outs() << "   - E-graph JSON: " << egglogOutputFilename << "\n";
    llvm::outs() << "   - Extraction metadata: " << metadataFilename << "\n";
    llvm::outs() << "   - MLIR→Egglog time: " << mlirToEgglogTime << "s\n";
    llvm::outs() << "   - Egglog execution time: " << egglogExecTime << "s\n";
}

llvm::LogicalResult EggifyOnlyPass::initialize(mlir::MLIRContext* context) {
    // Initialize eggFilePath from command-line option
    eggFilePath = eggFileOpt;
    
    // Make sure both files exist
    if (!llvm::sys::fs::exists(mlirFilePath)) {
        llvm::errs() << "MLIR file does not exist: " << mlirFilePath << "\n";
        return llvm::failure();
    }
    if (!llvm::sys::fs::exists(eggFilePath)) {
        llvm::errs() << "Egg file does not exist: " << eggFilePath << "\n";

        // Try to find egg file with the same name as the mlir file
        std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
        eggFilePath = name + ".egg";
        if (!llvm::sys::fs::exists(eggFilePath)) {
            return llvm::failure();
        }

        llvm::errs() << "Using default egg file: " << eggFilePath << "\n";
    }

    // Set output filenames
    std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
    egglogOutputFilename = name + "-egglog-output.log";
    egglogLogFilename = name + "-egglog.log";
    metadataFilename = name + ".extraction-metadata.txt";

    // Clear metadata file
    std::ofstream metadataFile(metadataFilename, std::ios::trunc);
    metadataFile.close();

    // Parse supported ops from egg file
    std::ifstream opFile(eggFilePath);
    std::string line;

    while (std::getline(opFile, line)) {
        if (EgglogOpDef::isOpFunction(line)) {
            EgglogOpDef parsedOp = EgglogOpDef::parseOpFunction(line);
            supportedOps.emplace(parsedOp.egglogName(), parsedOp);
            supportedDialects.insert(parsedOp.dialect);
        }
    }

    opFile.close();

    LLVM_DEBUG(llvm::dbgs() << "Supported ops: ");
    for (const auto& [op, _]: supportedOps) {
        LLVM_DEBUG(llvm::dbgs() << op << ", ");
    }

    LLVM_DEBUG(llvm::dbgs() << "\nSupported dialects: ");
    for (const std::string& dialect: supportedDialects) {
        LLVM_DEBUG(llvm::dbgs() << dialect << ", ");
    }

    LLVM_DEBUG(llvm::dbgs() << "\n\n");

    return llvm::success();
}

