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
#include "mlir/IR/Value.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OperationSupport.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"
#include "mlir/AsmParser/AsmParser.h"

#include "Utils.h"
#include "EqSatPass.h"
#include "EqSatOp.h"
#include "EgglogParser.h"

EqSatPass::EqSatPass(const std::string& eggFile, const EqSatPassCustomFunctions& funcs) {
    EqSatPass("egglog", eggFile, funcs);
}

EqSatPass::EqSatPass(const std::string egglogExecutable, const std::string& eggFile, const EqSatPassCustomFunctions& funcs)
    : egglogExecutable(egglogExecutable), customEggFilename(eggFile), customFunctions(funcs) {

    // Find supported ops from the base egg file
    std::ifstream opFile(opFilename);
    std::string line;

    std::getline(opFile, line);  // skip first line
    while (std::getline(opFile, line)) {
        size_t lparen = line.find_first_of('(');
        if (lparen == std::string::npos) {
            continue;
        }

        size_t opNameStart = lparen + 1;
        size_t opNameEnd = line.find_first_of(' ', opNameStart);

        std::string opName = line.substr(opNameStart, opNameEnd - opNameStart);
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

    // dump
    std::cout << "Supported ops: ";
    for (const std::string& op: supportedOps) {
        std::cout << op << ", ";
    }

    std::cout << "\nSupported dialects: ";
    for (const std::string& dialect: supportedDialects) {
        std::cout << dialect << ", ";
    }

    std::cout << std::endl;
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

                    eqSatOperand->print(std::cout);
                }

                // Add the operand to the operation
                operands.push_back(eqSatOperand);
            }

            mlir::Value result0 = op.getResult(0);  // TODO support multiple results

            EqSatOp* eqSatOp = new EqSatOp(opId++, opName, operands, &op, result0, !isSupported);
            ops.push_back(eqSatOp);
            ssaNameToBlockOp.emplace(eqSatOp->resultSSAName, eqSatOp);

            eqSatOp->print(std::cout);
        }

        // register the operations
        EqSatOpInfo::serializeOpRegistry(opRegistry, opRegistryFilename);

        // Create the final egglog file
        std::ofstream eggFile(eggFilename);

        // print egglog
        eggFile << "(include \"" << attrFilename << "\")" << std::endl;
        eggFile << "(include \"" << opFilename << "\")" << std::endl;
        eggFile << "(include \"" << customEggFilename << "\")" << std::endl;
        eggFile << std::endl;

        for (const EqSatOp* op: ops) {
            eggFile << op->egglogLet(customFunctions) << " ; " << op->mlir() << std::endl;
        }

        // run egglog
        eggFile << std::endl;
        eggFile << "(run 100000)" << std::endl;

        // Extract the results of the egglog run
        for (const EqSatOp* op: ops) {
            if (!op->opaque) {
                eggFile << "(extract " << op->getPrintId() << ")" << std::endl;
            }
        }

        eggFile.close();

        // Run egglog and extract the results
        std::string egglogCmd = egglogExecutable + " " + eggFilename + " --to-svg > " + egglogExtractedFilename + " 2> " + egglogLogFilename;
        std::cout << "\nRunning egglog: " << egglogCmd << std::endl;
        std::system(egglogCmd.c_str());

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
        EgglogParser parser(context, ops, ssaNameToBlockOp, opRegistry, customFunctions);

        for (EqSatOp* eqSatOp: ops) {
            if (eqSatOp->opaque) {
                continue;
            }

            std::string line;
            std::getline(file, line);

            std::cout << eqSatOp->getPrintId() << " = " << line << std::endl;

            mlir::Operation* prevOp = eqSatOp->mlirOp;

            mlir::OpBuilder builder(prevOp);
            ssize_t newOpId = parser.nextOperationId(line);
            mlir::Operation* newOp = parser.parseOperation(line, builder);

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