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

EqSatPass::EqSatPass() {
    // Find supported ops from the base egg file
    std::ifstream baseFile(eggBaseFile);
    std::string line;

    std::getline(baseFile, line); // skip first line
    while (std::getline(baseFile, line)) {
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

    baseFile.close();

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
        size_t id = 0;
        EqSatOpGraph ops;                               // Map of result SSA value id to EqSatOp for all operations in the block
        std::map<std::string, EqSatOpInfo> opRegistry;  // Map of operation name to EqSatOpInfo
        for (mlir::Operation& op: block.getOperations()) {
            std::string opName = op.getName().getStringRef().str();
            bool isSupported = supportedOps.find(opName) != supportedOps.end();

            if (!isSupported && op.getNumResults() != 1) { // ignore if not part of the supported operations
                llvm::outs() << "Ignoring unsupported operation '" << opName << "'\n";
                continue;
            } else if (!isSupported) {
                llvm::outs() << "Unsupported operation '" << opName << "' but using the result as a variable.\n";
            }

            // Regsiter the operation
            EqSatOpInfo opInfo(op, context);
            opRegistry.emplace(op.getName().getStringRef().str(), opInfo);

            // Get the operands
            std::vector<EqSatOp*> operands;
            for (const mlir::Value& operand: op.getOperands()) {
                std::string operandId = getSSAValueId(operand, mlir::OpPrintingFlags().enableDebugInfo());
                EqSatOp* eqSatOperand = ops.getOp(operandId);  // TODO support use of ops from other blocks, so we don't have the value (this is easy)
                operands.push_back(eqSatOperand);
            }

            // Get the result
            mlir::Value result0 = op.getResult(0);  // TODO support multiple results (this is hard)

            // Create the EqSatOp node
            std::string opId = getSSAValueId(result0);
            std::string opType = getTypeName(result0);

            EqSatOp* eqSatOp = new EqSatOp(id++, opId, opName, opType, operands, &op, result0);
            eqSatOp->opaque = !isSupported;

            ops.addOp(opId, eqSatOp);

            eqSatOp->print(std::cout);
        }

        // register the operations
        EqSatOpInfo::serializeOpRegistry(opRegistry, "res/mlir/ops.txt");

        std::string eggFilename = "res/egg/mlir.egg";
        std::string egglogExtractedFilename = "res/egg/egglog-extract.txt";
        std::string egglogLogFilename = "res/egg/egglog-log.txt";

        std::ofstream eggFile(eggFilename);

        // print egglog
        eggFile << "(include \"res/egg/attr.egg\")" << std::endl;
        eggFile << "(include \"res/egg/op.egg\")" << std::endl;
        eggFile << "(include \"res/egg/rules.egg\")" << std::endl;
        eggFile << std::endl;
        for (const std::string& resultId: ops.opResultIds) {
            eggFile << ops.getOp(resultId)->egglogLet() << std::endl;
        }

        // run egglog
        eggFile << std::endl;
        eggFile << "(run 100000)" << std::endl;

        // Extract the results of the egglog run
        for (const std::string& resultId: ops.opResultIds) {
            eggFile << "(extract " << resultId << ")" << std::endl;
        }

        eggFile.close();

        // Run egglog and extract the results (egglog must be on math)
        std::string egglogCmd = "./scripts/egglog-run.sh " + eggFilename + " --to-svg > " + egglogExtractedFilename + " 2> " + egglogLogFilename;
        std::cout << "\nRunning egglog: " << egglogCmd << std::endl;

        std::system(egglogCmd.c_str());

        std::ifstream file(egglogExtractedFilename);
        EgglogParser parser(context, ops, opRegistry);
        std::map<std::string, mlir::Value&> results;

        for (const std::string& resultId: ops.opResultIds) {
            std::string line;
            std::getline(file, line);

            std::cout << resultId << " = " << line << std::endl;

            EqSatOp* eqSatOp = ops.getOp(resultId);
            mlir::Operation* prevOp = eqSatOp->mlirOp;
            mlir::OpBuilder builder(prevOp);
            mlir::Operation* newOp = parser.parseOperation(line, builder);

            llvm::outs() << "NEW OPERATION: ";
            newOp->print(llvm::outs());
            llvm::outs() << "\n";

            llvm::outs() << "OLD OPERATION: ";
            prevOp->print(llvm::outs());
            llvm::outs() << "\n";

            // Check if the whole operation is different, if so, replace it
            eqSatOp->replacement = newOp;

            llvm::outs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n";
            prevOp->replaceAllUsesWith(newOp);
            prevOp->erase();
        }

        // TODO cleanup
    }
}