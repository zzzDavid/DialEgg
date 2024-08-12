#include <map>
#include <unordered_map>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <string_view>

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

#include "Utils.h"
#include "EqSatPass.h"
#include "EqSatOp.h"
#include "Egglog.h"

EqSatPass::EqSatPass(const std::string& eggFilePath, const EqSatPassCustomFunctions& funcs) {
    EqSatPass("egglog", eggFilePath, funcs);
}

EqSatPass::EqSatPass(const std::string egglogExecutable, const std::string& eggFilePath, const EqSatPassCustomFunctions& funcs)
    : egglogExecutable(egglogExecutable), eggFilePath(eggFilePath), customFunctions(funcs) {

    dialectEggFiles.push_back("egg/builtin.egg");
    dialectEggFiles.push_back("egg/arith.egg");
    dialectEggFiles.push_back("egg/math.egg");
    dialectEggFiles.push_back("egg/linalg.egg");
    dialectEggFiles.push_back("egg/tensor.egg");

    // Find supported ops from the base egg file
    for (const std::string& dialectEggFile: dialectEggFiles) {
        std::ifstream opFile(dialectEggFile);
        std::string line;

        while (std::getline(opFile, line)) {
            // format: (function [name] ([params]) Op)

            // ignore if starts with ';' - comment
            if (line[0] == ';') {
                continue;
            }

            // Check if line contains "function", "Op", and "i64"
            size_t functionPos = line.find("function");
            size_t opPos = line.find("Op");
            size_t i64Pos = line.find("i64");

            if (functionPos == std::string::npos || opPos == std::string::npos || i64Pos == std::string::npos) {
                continue;
            }

            // Get the operation name
            size_t opNameStart = line.find_first_not_of(' ', functionPos + 8);
            size_t opNameEnd = line.find_first_of('(', opNameStart) - 1;
            while (line[opNameEnd] == ' ') {  // Remove trailing spaces
                opNameEnd--;
            }

            std::string opName = line.substr(opNameStart, opNameEnd - opNameStart + 1);
            std::string cleanOpName = opName;
            std::replace(cleanOpName.begin(), cleanOpName.end(), '_', '.');

            supportedOps.insert(opName);
            supportedOps.insert(cleanOpName);

            if (opName.find('_') != std::string::npos) {
                std::string dialect = opName.substr(0, opName.find_first_of('_'));
                supportedDialects.insert(dialect);
            }
        }

        opFile.close();
    }

    // dump
    llvm::outs() << "Supported ops: ";
    for (const std::string& op: supportedOps) {
        llvm::outs() << op << ", ";
    }

    llvm::outs() << "\nSupported dialects: ";
    for (const std::string& dialect: supportedDialects) {
        llvm::outs() << dialect << ", ";
    }

    llvm::outs() << "\n\n";
}

mlir::StringRef EqSatPass::getArgument() const {
    return "eq-sat";
}

mlir::StringRef EqSatPass::getDescription() const {
    return "Performs equality saturation on each block in the given file. The language definition is egglog.";
}

void EqSatPass::runOnOperation() {
    mlir::MLIRContext& context = getContext();
    mlir::func::FuncOp rootOp = getOperation();

    // TODO add blocks to a list/queue and process them in order

    // Perform equality saturation on all operations of a block.
    // Re-create the MLIR operations in this block according to the optimization.
    for (mlir::Block& block: rootOp.getRegion().getBlocks()) {
        size_t opId = 0;
        std::vector<EqSatOp*> ops;                         // All operations in the block, index = op id
        std::map<std::string, EqSatOp*> ssaNameToBlockOp;  // Map of SSA name to EqSatOp
        std::map<std::string, EqSatOpInfo> opRegistry;     // Map of operation name to EqSatOpInfo

        for (mlir::Operation& op: block.getOperations()) {
            std::string opName = op.getName().getStringRef().str();
            bool isSupported = supportedOps.find(opName) != supportedOps.end();

            if (!isSupported && op.getNumResults() != 1) {  // ignore if not part of the supported operations
                llvm::outs() << "Ignoring unsupported operation '" << opName << "'\n";
                continue;
            } else if (!isSupported) {
                llvm::outs() << "Unsupported operation '" << opName << "' but using the result as a variable.\n";
            }

            // Regsiter the operation
            EqSatOpInfo opInfo(op, context);
            opRegistry.emplace(opName, opInfo);

            // Get the operands
            std::vector<EqSatOp*> operands;
            for (mlir::Value operand: op.getOperands()) {
                std::string operandSSAName = getSSAName(operand);
                EqSatOp* eqSatOperand = nullptr;

                if (ssaNameToBlockOp.find(operandSSAName) != ssaNameToBlockOp.end()) {
                    eqSatOperand = ssaNameToBlockOp.at(operandSSAName);
                } else {  // Create opaque value
                    eqSatOperand = new EqSatOp(opId++, "", {}, nullptr, operand, true);

                    ops.push_back(eqSatOperand);
                    ssaNameToBlockOp.emplace(operandSSAName, eqSatOperand);

                    eqSatOperand->print(llvm::outs());
                }

                // Add the operand to the operation
                operands.push_back(eqSatOperand);
            }

            mlir::Value result0 = op.getResult(0);  // TODO support multiple results

            EqSatOp* eqSatOp = new EqSatOp(opId++, opName, operands, &op, result0, !isSupported);
            ops.push_back(eqSatOp);
            ssaNameToBlockOp.emplace(eqSatOp->resultSSAName, eqSatOp);

            eqSatOp->print(llvm::outs());
        }

        // register the operations
        EqSatOpInfo::serializeOpRegistry(opRegistry, "mlir/ops.txt");

        // Prep egglog context
        Egglog egglog(context, ops, ssaNameToBlockOp, opRegistry, customFunctions);

        // Open the final egglog file
        std::ifstream eggFile(eggFilePath);
        std::vector<std::string> egglogLines;

        // Read the egglog file
        std::string target = ";; OPS HERE ;;";
        std::string endTarget = ";; END OPS ;;";

        bool insertedOps = false;
        bool insertEgglogLines = true;

        std::string line;
        while (std::getline(eggFile, line)) {
            if (insertEgglogLines && line.find("(extract") == std::string::npos) {
                egglogLines.push_back(line);
            }

            if (!insertedOps && line == target) {
                for (EqSatOp* op: ops) {  // Insert the operations
                    egglogLines.push_back(egglog.eggifyOperationWithLet(*op));

                    // Put semi-colon at the beginning of each line
                    std::string mlirStr = op->mlir();
                    std::stringstream ss(mlirStr);
                    std::string mlirLine;

                    std::getline(ss, mlirLine, '\n');
                    egglogLines.back() += " ; " + mlirLine;

                    while (std::getline(ss, mlirLine, '\n')) {
                        egglogLines.push_back("; " + mlirLine);
                    }
                }

                insertedOps = true;
                insertEgglogLines = false;
            } else if (line == endTarget) {
                egglogLines.push_back(line);
                insertEgglogLines = true;
            }
        }

        // Extract the results of the egglog run
        for (const EqSatOp* op: ops) {
            if (!op->opaque) {
                egglogLines.push_back("(extract " + op->getPrintId() + ")");
            }
        }

        eggFile.close();

        // Write the extracted egglog to a new file
        std::ofstream eggFileOut(eggFilePath);
        for (const std::string& line: egglogLines) {
            eggFileOut << line << "\n";
        }
        eggFileOut.close();

        // Run egglog and extract the results
        std::string egglogCmd = egglogExecutable + " " + eggFilePath + " --to-svg > " + egglogExtractedFilename + " 2> " + egglogLogFilename;
        llvm::outs() << "\nRunning egglog: " << egglogCmd << "\n" << "\n";
        std::system(egglogCmd.c_str());

        // dump output
        printFileContents(egglogLogFilename);
        printFileContents(egglogExtractedFilename);

        llvm::outs() << "\n\nDone running egglog\n" << "\n";

        // dump all ops
        for (EqSatOp* value: ops) {
            llvm::outs() << "ID " << value->id << "\n";
            if (value->mlirOp != nullptr) {
                llvm::outs() << "OP: ";
                value->mlirOp->print(llvm::outs());
                llvm::outs() << "\n";
            }
            llvm::outs() << "VALUE " << value->resultSSAName << " = " << value->resultValue << "\n";
            llvm::outs() << "\n";
        }

        std::ifstream file(egglogExtractedFilename);

        for (EqSatOp* eqSatOp: ops) {
            if (eqSatOp->opaque) {
                continue;
            }

            std::string line;
            std::getline(file, line);

            llvm::outs() << eqSatOp->getPrintId() << " = " << line << "\n";

            mlir::Operation* prevOp = eqSatOp->mlirOp;

            mlir::OpBuilder builder(prevOp);
            ssize_t newOpId = egglog.nextOperationId(line);
            mlir::Operation* newOp = egglog.parseOperation(line, builder);

            llvm::outs() << "NEW OPERATION " << newOpId << " : ";
            newOp->print(llvm::outs());
            llvm::outs() << "\n";

            llvm::outs() << "OLD OPERATION " << eqSatOp->id << " : ";
            prevOp->print(llvm::outs());
            llvm::outs() << "\n";

            // Check if the whole operation is different, if so, replace it
            eqSatOp->replacementOp = newOp;
            if (newOp != prevOp) {
                llvm::outs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n\n";
                prevOp->replaceAllUsesWith(newOp);
                prevOp->erase();
            }

            llvm::outs() << "\n";
        }

        file.close();
        llvm::outs() << "\n";

        // TODO cleanup
    }
}