#include <chrono>
#include "ReconstructFromExtractionPass.h"

#define DEBUG_TYPE "dialegg"

extern llvm::cl::opt<std::string> eggFileOpt;
static llvm::cl::opt<std::string> extractionFileOpt("extraction-file", llvm::cl::desc("Path to extraction results file"));

void ReconstructFromExtractionPass::runOnBlock(mlir::Block& block, const std::string& blockName, std::ifstream& extractionFile) {
    auto start = std::chrono::high_resolution_clock::now();

    // Re-eggify the block to recreate the mapping
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

    start = std::chrono::high_resolution_clock::now();

    // Parse the extracted egglog file and replace the MLIR operations
    std::vector<std::string> extractedLines;
    for (const EggifiedOp* eggOp: egglog.eggifiedBlock) {
        if (!eggOp->shouldBeExtracted()) {
            continue;
        }

        extractedLines.emplace_back();
        std::getline(extractionFile, extractedLines.back());

        LLVM_DEBUG(llvm::dbgs() << "Reconstructing " << eggOp->getPrintId() << " from: " << extractedLines.back() << "\n");

        mlir::Operation* prevOp = eggOp->mlirOp;
        mlir::OpBuilder builder(prevOp);
        mlir::Operation* newOp = egglog.parseOperation(extractedLines.back(), builder);

        if (newOp == nullptr) {  // If the operation is an opaque value, replace it with the value
            mlir::Value value = egglog.parseValue(extractedLines.back());
            prevOp->getResult(0).replaceAllUsesWith(value);
            prevOp->erase();
        } else if (newOp != prevOp) {  // Check if the whole operation is different, if so, replace it
            LLVM_DEBUG(llvm::dbgs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n\n");
            prevOp->replaceAllUsesWith(newOp);
            prevOp->erase();
        }
        break;
    }

    end = std::chrono::high_resolution_clock::now();
    egglogToMlirTime += std::chrono::duration<double>(end - start).count();

    // Dump parsed ops cache
    for (const auto& [opStr, op]: egglog.parsedOps) {
        LLVM_DEBUG(llvm::dbgs() << opStr << " : " << *op << "\n");
    }

    LLVM_DEBUG(llvm::dbgs() << "\n");
}

void ReconstructFromExtractionPass::runOnOperation() {
    mlir::ModuleOp module = getOperation();
    
    // Open extraction file
    std::ifstream extractionFile(extractionFilename);
    if (!extractionFile.is_open()) {
        llvm::errs() << "Failed to open extraction file: " << extractionFilename << "\n";
        signalPassFailure();
        return;
    }
    
    // Find all functions and hw modules in the module
    for (mlir::Operation& op: module.getOps()) {
        if (auto funcOp = llvm::dyn_cast<mlir::func::FuncOp>(&op)) {
            llvm::StringRef funcName = funcOp.getName();
            LLVM_DEBUG(llvm::dbgs() << "Reconstructing function: " << funcName << "\n");
            
            for (mlir::Block& block: funcOp.getRegion().getBlocks()) {
                std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
                std::string blockName = funcName.str() + "_" + parentOpName;
                runOnBlock(block, blockName, extractionFile);
            }
        } else if (auto hwModuleOp = llvm::dyn_cast<circt::hw::HWModuleOp>(&op)) {
            llvm::StringRef moduleName = hwModuleOp.getName();
            LLVM_DEBUG(llvm::dbgs() << "Reconstructing HW module: " << moduleName << "\n");
            
            for (mlir::Block& block: hwModuleOp.getBodyRegion().getBlocks()) {
                std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
                std::string blockName = moduleName.str() + "_" + parentOpName;
                runOnBlock(block, blockName, extractionFile);
            }
        } else {
            llvm::errs() << "Skipping non-function/non-hw-module operation: " << op.getName() << "\n";
        }
    }

    extractionFile.close();

    // Temporary dead code elimination
    bool clean = false;
    while (!clean) {
        clean = true;

        module.walk([&](mlir::Operation* op) {
            bool deadFunctionCall = mlir::isa<mlir::func::CallOp>(op) && op->use_empty();
            if (mlir::isOpTriviallyDead(op) || deadFunctionCall) {
                clean = false;
                op->erase();
            }
        });
    }

    llvm::outs() << "✅ Reconstruction pass completed!\n";
    llvm::outs() << "   - Egglog→MLIR time: " << egglogToMlirTime << "s\n";
}

llvm::LogicalResult ReconstructFromExtractionPass::initialize(mlir::MLIRContext* context) {
    // Initialize eggFilePath from command-line option
    eggFilePath = eggFileOpt;
    
    // Make sure MLIR file exists
    if (!llvm::sys::fs::exists(mlirFilePath)) {
        llvm::errs() << "MLIR file does not exist: " << mlirFilePath << "\n";
        return llvm::failure();
    }

    // Check for egg file
    if (!llvm::sys::fs::exists(eggFilePath)) {
        // Try to find egg file with the same name as the mlir file
        std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
        eggFilePath = name + ".egg";
        if (!llvm::sys::fs::exists(eggFilePath)) {
            llvm::errs() << "Egg file does not exist: " << eggFilePath << "\n";
            return llvm::failure();
        }
        llvm::outs() << "Using default egg file: " << eggFilePath << "\n";
    }

    // Set filenames
    std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
    
    // Check if extraction file was specified via command line
    if (!extractionFileOpt.empty()) {
        extractionFilename = extractionFileOpt;
    } else {
        extractionFilename = name + ".extracted.txt";
    }
    
    metadataFilename = name + ".extraction-metadata.txt";

    // Make sure extraction file exists
    if (!llvm::sys::fs::exists(extractionFilename)) {
        llvm::errs() << "Extraction file does not exist: " << extractionFilename << "\n";
        llvm::errs() << "Please specify extraction file with --extraction-file=<path>\n";
        return llvm::failure();
    }

    llvm::outs() << "Using extraction file: " << extractionFilename << "\n";

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

