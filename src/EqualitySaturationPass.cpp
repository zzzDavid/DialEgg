#include <map>
#include <unordered_map>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <string_view>
#include <thread>
#include <chrono>

#include "llvm/ADT/Hashing.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/MemoryBuffer.h"
#include "mlir/IR/Value.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OperationSupport.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/Passes.h"

#include "Utils.h"
#include "EqualitySaturationPass.h"
#include "Egglog.h"

EqualitySaturationPass::EqualitySaturationPass(const std::string& eggFilePath, const EgglogCustomDefs& funcs) {
    EqualitySaturationPass("egglog", eggFilePath, funcs);
}

EqualitySaturationPass::EqualitySaturationPass() : egglogExecutable(""), eggFilePath(""), customFunctions({}) {}  // dummy

EqualitySaturationPass::EqualitySaturationPass(const std::string egglogExecutable, const std::string& eggFilePath, const EgglogCustomDefs& funcs)
    : egglogExecutable(egglogExecutable), eggFilePath(eggFilePath), customFunctions(funcs) {

    std::ifstream opFile(eggFilePath);
    std::string line;

    while (std::getline(opFile, line)) {
        if (EgglogOpDef::isOpFunction(line)) {
            EgglogOpDef parsedOp = EgglogOpDef::parseOpFunction(line);

            supportedOps.emplace(parsedOp.dialect + "." + parsedOp.name + (parsedOp.version.empty() ? "" : "." + parsedOp.version), parsedOp);
            supportedOps.emplace(parsedOp.dialect + "_" + parsedOp.name + (parsedOp.version.empty() ? "" : "_" + parsedOp.version), parsedOp);
            supportedDialects.insert(parsedOp.dialect);
        }
    }

    opFile.close();

    // dump
    llvm::outs() << "Supported ops: ";
    for (const auto& [op, _]: supportedOps) {
        llvm::outs() << op << ", ";
    }

    llvm::outs() << "\nSupported dialects: ";
    for (const std::string& dialect: supportedDialects) {
        llvm::outs() << dialect << ", ";
    }

    llvm::outs() << "\n\n";
}

void EqualitySaturationPass::runEgglog(const std::vector<EggifiedOp>& block, const std::string& blockName) {
    std::ifstream eggFile(eggFilePath);
    std::vector<std::string> egglogLines;

    // Read the egglog file
    std::string opsTarget = ";; OPS HERE ;;";
    std::string extractsTarget = ";; EXTRACTS HERE ;;";

    bool insertedOps = false;
    bool insertedExtracts = false;

    std::string line;
    while (std::getline(eggFile, line)) {
        egglogLines.push_back(line);

        if (!insertedOps && line == opsTarget) {
            for (const EggifiedOp& op: block) {  // Insert the operations
                egglogLines.push_back(op.egglogLet());

                // Put semi-colon at the beginning of each line
                std::stringstream ss;
                ss << valueToString(op.mlirValue);
                std::string mlirLine;

                std::getline(ss, mlirLine, '\n');
                egglogLines.back() += " ; " + mlirLine;

                while (std::getline(ss, mlirLine, '\n')) {
                    egglogLines.push_back("; " + mlirLine);
                }
            }

            insertedOps = true;
        } else if (!insertedExtracts && line == extractsTarget) {
            for (const EggifiedOp& op: block) {  // Extract the results of the egglog run
                if (!op.opaque) {
                    egglogLines.push_back("(extract " + op.getPrintId() + ")");
                }
            }

            insertedExtracts = true;
        }
    }

    eggFile.close();

    // Write the extracted egglog to a new file with the same name and ext .ops.egg
    std::string opsEggFilePath = eggFilePath.substr(0, eggFilePath.find_last_of(".")) + ".ops.egg";
    std::ofstream eggFileOut(opsEggFilePath);
    for (const std::string& line: egglogLines) {
        eggFileOut << line << "\n";
    }
    eggFileOut.close();

    // Run egglog and extract the results
    std::string egglogCmd = egglogExecutable + " " + opsEggFilePath + " > " + egglogExtractedFilename + " 2> " + egglogLogFilename;

    llvm::outs() << "\nRunning egglog: " << egglogCmd << "\n"
                 << "\n";
    std::system(egglogCmd.c_str());
    // std::this_thread::sleep_for(std::chrono::milliseconds(250));

    // dump output
    printFileContents(egglogLogFilename);
    printFileContents(egglogExtractedFilename);

    llvm::outs() << "\n\nDone running egglog\n"
                 << "\n";
}

void EqualitySaturationPass::runOnBlock(mlir::Block& block, const std::string& blockName) {
    mlir::MLIRContext& context = getContext();
    Egglog egglog(context, customFunctions, supportedOps);

    // register all block arguments
    for (mlir::Value value: block.getArguments()) {
        EggifiedOp eggifiedValue = egglog.eggifyValue(value);
        eggifiedValue.print(llvm::outs());
    }

    for (mlir::Operation& op: block.getOperations()) {
        if (op.getNumResults() == 0) {  // ignore if no results
            llvm::outs() << "Skipping operation with no results: " << op.getName() << "\n";
            continue;
        } else if (op.getNumResults() > 1) {  // exit if more than one result
            llvm::outs() << "Skipping operation with more than one result: " << op.getName() << "\n";
        }

        EggifiedOp eggifiedOp = egglog.eggifyOperation(&op);
        eggifiedOp.print(llvm::outs());
    }

    // dump all ops
    for (EggifiedOp& eggOp: egglog.eggifiedBlock) {
        eggOp.print(llvm::outs());
    }

    runEgglog(egglog.eggifiedBlock, blockName);

    std::ifstream file(egglogExtractedFilename);

    for (EggifiedOp& eggOp: egglog.eggifiedBlock) {
        if (eggOp.opaque) {
            continue;
        }

        std::string line;
        std::getline(file, line);

        llvm::outs() << eggOp.getPrintId() << " = " << line << "\n";

        mlir::Operation* prevOp = eggOp.mlirOp;
        mlir::OpBuilder builder(prevOp);
        mlir::Operation* newOp = egglog.parseOperation(line, builder);

        llvm::outs() << "NEW OPERATION [ "
                     << "] : ";
        newOp->print(llvm::outs());
        llvm::outs() << "\n";

        llvm::outs() << "OLD OPERATION [" << eggOp.id << "] : ";
        prevOp->print(llvm::outs());
        llvm::outs() << "\n";

        // Check if the whole operation is different, if so, replace it
        if (newOp != prevOp) {
            llvm::outs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n\n";
            prevOp->replaceAllUsesWith(newOp);
            prevOp->erase();
        }

        llvm::outs() << "\n";
    }

    // dump parsed ops cache
    for (const auto& [opStr, op]: egglog.parsedOps) {
        llvm::outs() << opStr << " : " << *op << "\n";
    }

    file.close();
    llvm::outs() << "\n";
}

void EqualitySaturationPass::runOnOperation() {
    if (egglogExecutable.empty() || eggFilePath.empty()) {
        return;
    }

    mlir::func::FuncOp rootOp = getOperation();
    llvm::StringRef rootOpName = rootOp.getName();

    llvm::outs() << "Running on function: " << rootOpName << "\n";
    llvm::outs() << "-----------------------------------------\n";

    // TODO add blocks to a list/queue and process them in order

    // Perform equality saturation on all operations of a block.
    // Re-create the MLIR operations in this block according to the optimization.
    for (mlir::Block& block: rootOp.getRegion().getBlocks()) {
        std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
        std::string blockName = rootOpName.str() + "_" + parentOpName + "_" + getBlockName(block);
        runOnBlock(block, blockName);

        // incorrect dead code elimination (temporary until this PR is merged: https://github.com/llvm/llvm-project/pull/99671)
        block.walk([&](mlir::Operation* op) {
            if (mlir::isOpTriviallyDead(op)) {
                op->erase();
            }
        });
    }
}

std::unique_ptr<mlir::Pass> createEqualitySaturationPass(const std::string& egglogExecutable, const std::string& eggFilePath, const EgglogCustomDefs& funcs) {
    return std::make_unique<EqualitySaturationPass>(egglogExecutable, eggFilePath, funcs);
}
std::unique_ptr<mlir::Pass> createEqualitySaturationPass(const std::string& eggFilePath, const EgglogCustomDefs& funcs) {
    return std::make_unique<EqualitySaturationPass>(eggFilePath, funcs);
}