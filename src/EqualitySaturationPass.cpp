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

#define DEBUG_TYPE "dialegg"

namespace {

// Egglog's vec-of is intended for ground vectors; when it contains pattern
// variables (e.g., (vec-of ?a ?b)) the engine can crash during query
// compilation. Rewrite such occurrences into a vec-push chain that is safe
// for pattern matching.
std::string desugarVecOfWithVars(std::string_view expr) {
    if (expr.size() < 2 || expr.front() != '(' || expr.back() != ')') {
        return std::string(expr);
    }

    std::vector<std::string_view> parts = Egglog::splitExpression(expr);
    if (parts.empty()) {
        return std::string(expr);
    }
    if (parts.size() == 1 && parts[0].front() == '(' && parts[0].back() == ')') {
        return "(" + desugarVecOfWithVars(parts[0]) + ")";
    }

    std::vector<std::string> rewrittenArgs;
    rewrittenArgs.reserve(parts.size() > 0 ? parts.size() - 1 : 0);
    for (size_t i = 1; i < parts.size(); i++) {
        rewrittenArgs.push_back(desugarVecOfWithVars(parts[i]));
    }

    if (parts[0] == "vec-of") {
        bool hasVar = false;
        for (size_t i = 1; i < parts.size(); i++) {
            if (parts[i].find('?') != std::string_view::npos) {
                hasVar = true;
                break;
            }
        }

        if (hasVar) {
            std::string acc = "(vec-empty)";
            for (const std::string& arg: rewrittenArgs) {
                acc = "(vec-push " + acc + " " + arg + ")";
            }
            return acc;
        }
    }

    std::string rebuilt = "(" + std::string(parts[0]);
    for (const std::string& arg: rewrittenArgs) {
        rebuilt += " " + arg;
    }
    rebuilt += ")";
    return rebuilt;
}

size_t findMatchingParen(const std::string& str, size_t openPos) {
    int depth = 0;
    bool inString = false;
    char prev = '\0';
    for (size_t i = openPos; i < str.size(); i++) {
        char c = str[i];
        if (c == '"' && prev != '\\') {
            inString = !inString;
        }
        if (inString) {
            prev = c;
            continue;
        }
        if (c == '(') {
            depth++;
        } else if (c == ')') {
            depth--;
            if (depth == 0) {
                return i;
            }
        }
        prev = c;
    }
    return std::string::npos;
}

std::string desugarVecOfInContent(const std::string& content) {
    std::string out = content;
    size_t pos = 0;
    while ((pos = out.find("(vec-of", pos)) != std::string::npos) {
        size_t end = findMatchingParen(out, pos);
        if (end == std::string::npos) {
            break;
        }

        std::string_view expr(out.data() + pos, end - pos + 1);
        std::vector<std::string_view> parts = Egglog::splitExpression(expr);

        bool hasVar = false;
        for (size_t i = 1; i < parts.size(); i++) {
            if (parts[i].find('?') != std::string_view::npos) {
                hasVar = true;
                break;
            }
        }

        if (hasVar) {
            std::string replacement = desugarVecOfWithVars(expr);
            out.replace(pos, end - pos + 1, replacement);
            pos += replacement.size();
        } else {
            pos = end + 1;
        }
    }

    return out;
}

}  // namespace

extern llvm::cl::opt<std::string> eggFileOpt;

EqualitySaturationPass::EqualitySaturationPass(const std::string& mlirFile, const EgglogCustomDefs& funcs)
    : mlirFilePath(mlirFile), eggFilePath(eggFileOpt), customFunctions(funcs) {}

void EqualitySaturationPass::runEgglog(const std::vector<EggifiedOp*>& block, const std::string& blockName) {
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
            for (const EggifiedOp* op: block) {  // Insert the operations
                egglogLines.push_back(op->egglogLet());
            }

            insertedOps = true;
        } else if (!insertedExtracts && line == extractsTarget) {
            for (const EggifiedOp* op: block) {  // Extract the results of the egglog run
                if (op->shouldBeExtracted()) {
                    // egglogLines.push_back("(extract " + op->getPrintId() + ")");
                    // print out (let root_name (RootNode op_name "op_name"))
                    egglogLines.push_back("(let root_" + op->getPrintId() + " (RootNode " + op->getPrintId() + "))");
                }
            }

            insertedExtracts = true;
        }
    }
    eggFile.close();

    // Desugar vec-of patterns containing variables into vec-push chains to
    // avoid egglog crashes when matching vectors with symbolic elements.
    std::string egglogContent;
    for (size_t i = 0; i < egglogLines.size(); i++) {
        if (i > 0) {
            egglogContent += "\n";
        }
        egglogContent += egglogLines[i];
    }
    egglogContent = desugarVecOfInContent(egglogContent);
    egglogLines.clear();
    std::stringstream egglogStream(egglogContent);
    std::string desugaredLine;
    while (std::getline(egglogStream, desugaredLine)) {
        egglogLines.push_back(desugaredLine);
    }

    // Write the extracted egglog to a new file with the same name and ext .ops.egg
    std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
    std::string opsEggFilePath = name + ".ops.egg";
    std::ofstream eggFileOut(opsEggFilePath);
    for (const std::string& line: egglogLines) {
        eggFileOut << line << "\n";
    }
    eggFileOut.close();

    auto end = std::chrono::high_resolution_clock::now();
    mlirToEgglogTime += std::chrono::duration<double>(end - start).count();

    // Run egglog and extract the results
    // std::string egglogCmd = "egglog " + opsEggFilePath + " > " + egglogExtractedFilename + " 2> " + egglogLogFilename;
    // change the command to "egglog opsEggFilePath --to-json --serialize-n-inline-leaves 1 > egglogExtractedFilename 2> egglogLogFilename"
    std::string egglogCmd = "egglog " + opsEggFilePath + " --to-json > " + egglogExtractedFilename + " 2> " + egglogLogFilename;

    LLVM_DEBUG(llvm::dbgs() << "Running egglog: " << egglogCmd << "\n");

    start = std::chrono::high_resolution_clock::now();
    int ret = std::system(egglogCmd.c_str());
    end = std::chrono::high_resolution_clock::now();

    if (ret != 0) {
        printFileContents(egglogLogFilename);
        printFileContents(egglogExtractedFilename);
        llvm::errs() << "Egglog failed\n";
        exit(1);
    }

    egglogExecTime += std::chrono::duration<double>(end - start).count();

    // dump output
    LLVM_DEBUG(printFileContents(egglogLogFilename));
    LLVM_DEBUG(printFileContents(egglogExtractedFilename));

    LLVM_DEBUG(llvm::dbgs() << "Done running egglog\n");
}

void EqualitySaturationPass::runOnBlock(mlir::Block& block, const std::string& blockName) {
    auto start = std::chrono::high_resolution_clock::now();

    // Eggify the block
    mlir::MLIRContext& context = getContext();
    Egglog egglog(context, customFunctions, supportedOps);

    // register all block arguments
    for (mlir::Value value: block.getArguments()) {
        egglog.eggifyValue(value);
        // EggifiedOp* eggifiedValue = egglog.eggifyValue(value);
        // eggifiedValue->print(llvm::outs());
    }

    for (mlir::Operation& op: block.getOperations()) {
        egglog.eggifyOperation(&op);
        // EggifiedOp* eggifiedOp = egglog.eggifyOperation(&op);
        // eggifiedOp->print(llvm::outs());
    }

    auto end = std::chrono::high_resolution_clock::now();
    mlirToEgglogTime += std::chrono::duration<double>(end - start).count();

    // dump all ops
    for (const EggifiedOp* eggOp: egglog.eggifiedBlock) {
        LLVM_DEBUG(eggOp->print(llvm::dbgs()));
    }

    runEgglog(egglog.eggifiedBlock, blockName);  // Run egglog on the block

    start = std::chrono::high_resolution_clock::now();

    std::ifstream file(egglogExtractedFilename);

    // Parse the extracted egglog file and replace the MLIR operations
    std::vector<std::string> lines;
    for (const EggifiedOp* eggOp: egglog.eggifiedBlock) {
        if (!eggOp->shouldBeExtracted()) {
            continue;
        }

        // eggOp.print(llvm::outs());

        lines.emplace_back();
        std::getline(file, lines.back());

        if (lines.back().empty()) {
            llvm::errs() << "Empty extraction line for " << eggOp->getPrintId() << ", skipping\n";
            continue;
        }

        mlir::Operation* prevOp = eggOp->mlirOp;
        mlir::OpBuilder builder(prevOp);
        mlir::Operation* newOp = egglog.parseOperation(lines.back(), builder);

        if (newOp == nullptr) {  // If the operation is an opaque value, replace it with the value
            mlir::Value value = egglog.parseValue(lines.back());
            prevOp->getResult(0).replaceAllUsesWith(value);
            prevOp->erase();
        } else if (newOp != prevOp) {  // Check if the whole operation is different, if so, replace it
            // llvm::outs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n\n";
            prevOp->replaceAllUsesWith(newOp);
            prevOp->erase();
        }

        // llvm::outs() << "\n";
    }

    end = std::chrono::high_resolution_clock::now();

    egglogToMlirTime += std::chrono::duration<double>(end - start).count();

    // dump parsed ops cache
    for (const auto& [opStr, op]: egglog.parsedOps) {
        LLVM_DEBUG(llvm::dbgs() << opStr << " : " << *op << "\n");
    }

    file.close();
    LLVM_DEBUG(llvm::dbgs() << "\n");
}

void EqualitySaturationPass::runOnFunction(mlir::func::FuncOp& func) {
    llvm::StringRef funcName = func.getName();

    LLVM_DEBUG(llvm::dbgs() << "Running on function: " << funcName << "\n");
    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");

    // Perform equality saturation on all operations of a block.
    for (mlir::Block& block: func.getRegion().getBlocks()) {
        std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
        std::string blockName = funcName.str() + "_" + parentOpName;
        runOnBlock(block, blockName);
    }


    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");
    LLVM_DEBUG(llvm::dbgs() << "Done running on function: " << funcName << "\n");
    LLVM_DEBUG(llvm::dbgs() << "mlirToEgglogTime = " << mlirToEgglogTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "egglogExecTime = " << egglogExecTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "egglogToMlirTime = " << egglogToMlirTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");
}

void EqualitySaturationPass::runOnHWModule(circt::hw::HWModuleOp& hwModule) {
    llvm::StringRef moduleName = hwModule.getName();

    LLVM_DEBUG(llvm::dbgs() << "Running on HW module: " << moduleName << "\n");
    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");

    // Perform equality saturation on all operations of a block.
    for (mlir::Block& block: hwModule.getBodyRegion().getBlocks()) {
        std::string parentOpName = block.getParentOp()->getName().getStringRef().str();
        std::string blockName = moduleName.str() + "_" + parentOpName;
        runOnBlock(block, blockName);
    }

    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");
    LLVM_DEBUG(llvm::dbgs() << "Done running on HW module: " << moduleName << "\n");
    LLVM_DEBUG(llvm::dbgs() << "mlirToEgglogTime = " << mlirToEgglogTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "egglogExecTime = " << egglogExecTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "egglogToMlirTime = " << egglogToMlirTime << "s\n");
    LLVM_DEBUG(llvm::dbgs() << "-----------------------------------------\n");
}

void EqualitySaturationPass::runOnOperation() {
    mlir::ModuleOp module = getOperation();
    
    // find all functions and hw modules in the module
    for (mlir::Operation& op: module.getOps()) {
        if (auto funcOp = llvm::dyn_cast<mlir::func::FuncOp>(&op)) {
            runOnFunction(funcOp);
        } else if (auto hwModuleOp = llvm::dyn_cast<circt::hw::HWModuleOp>(&op)) {
            runOnHWModule(hwModuleOp);
        } else {
            llvm::errs() << "Skipping non-function/non-hw-module operation: " << op.getName() << "\n";
        }
    }

    // Temporary dead code elimination (until this PR is merged: https://github.com/llvm/llvm-project/pull/99671)
    bool clean = false;
    while (!clean) {
        clean = true;

        module.walk([&](mlir::Operation* op) {
            bool deadFunctionCall = mlir::isa<mlir::func::CallOp>(op) && op->use_empty(); // we assume for our use case that function calls have no side effects (BAD)
            if (mlir::isOpTriviallyDead(op) || deadFunctionCall) {
                clean = false;
                op->erase();
            }
        });
    }
}

llvm::LogicalResult EqualitySaturationPass::initialize(mlir::MLIRContext* context) {
    // Make sure both files exist
    if (!llvm::sys::fs::exists(mlirFilePath)) {
        llvm::errs() << "MLIR file does not exist: " << mlirFilePath << "\n";
        return llvm::failure();
    }
    if (!llvm::sys::fs::exists(eggFilePath)) {
        llvm::errs() << "Egg file does not exist: " << eggFilePath << "\n";

        // try to find egg file with the same name as the mlir file (default egg file)
        std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
        eggFilePath = name + ".egg";
        if (!llvm::sys::fs::exists(eggFilePath)) {
            return llvm::failure();
        }

        llvm::errs() << "Using default egg file: " << eggFilePath << "\n";
    }

    // mlirFilePath without extension
    std::string name = mlirFilePath.substr(0, mlirFilePath.find(".mlir"));
    egglogExtractedFilename = name + "-egglog-extract.log";
    egglogLogFilename = name + "-egglog.log";

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

    // dump
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
