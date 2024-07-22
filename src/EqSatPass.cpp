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
        size_t opId = 0;
        size_t valueId = 0;

        std::vector<EqSatOp*> blockOps; // All operations in the block, index = op id
        std::vector<EqSatOp*> opaqueValues; // All values from outside the block, index = value id
        std::map<std::string, EqSatOp*> ssaNameToBlockOp; // Map of SSA name to EqSatOp
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
            opRegistry.emplace(opName, opInfo);

            // Get the operands
            std::vector<EqSatOp*> operands;
            for (mlir::Value operand: op.getOperands()) {
                std::string operandSSAName = getSSAName(operand);
                EqSatOp* eqSatOperand = nullptr;

                if (ssaNameToBlockOp.find(operandSSAName) != ssaNameToBlockOp.end()) {
                    eqSatOperand = ssaNameToBlockOp.at(operandSSAName);
                } else { // Create opaque value
                    eqSatOperand = new EqSatOp(valueId++, "", getTypeName(operand), {}, operand.getDefiningOp(), operand, true);

                    opaqueValues.push_back(eqSatOperand);
                    ssaNameToBlockOp.emplace(operandSSAName, eqSatOperand);

                    eqSatOperand->print(std::cout);
                }

                // Add the operand to the operation
                operands.push_back(eqSatOperand);
            }

            mlir::Value result0 = op.getResult(0); // TODO support multiple results
            std::string opType = getTypeName(result0);

            size_t id = isSupported ? opId++ : valueId++;
            EqSatOp* eqSatOp = new EqSatOp(id, opName, opType, operands, &op, result0, !isSupported);

            if (eqSatOp->opaque) {
                opaqueValues.push_back(eqSatOp);
            } else {
                blockOps.push_back(eqSatOp);
            }
            ssaNameToBlockOp.emplace(eqSatOp->resultSSAName, eqSatOp);

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

        for (const EqSatOp* value: opaqueValues) {
            eggFile << value->egglogLet() << " ; " << valueToString(value->resultValue) << std::endl;
        }

        for (const EqSatOp* op: blockOps) {
            eggFile << op->egglogLet() << " ; " << opToString(*op->mlirOp) << std::endl;
        }

        // run egglog
        eggFile << std::endl;
        eggFile << "(run 100000)" << std::endl;

        // Extract the results of the egglog run
        for (const EqSatOp* op: blockOps) {
            eggFile << "(extract " << op->getPrintId() << ")" << std::endl;
        }

        eggFile.close();

        // Run egglog and extract the results (egglog must be on math)
        std::string egglogCmd = "./scripts/egglog-run.sh " + eggFilename + " --to-svg > " + egglogExtractedFilename + " 2> " + egglogLogFilename;
        std::cout << "\nRunning egglog: " << egglogCmd << std::endl;

        std::system(egglogCmd.c_str());

        // dump all opaques
        for (EqSatOp* value: opaqueValues) {
            llvm::outs() << "id " << value->id << "\n";
            llvm::outs() << "Opaque value: " << value->resultSSAName << " = " << value->resultValue << "\n";
            if (value->mlirOp != nullptr)
                value->mlirOp->print(llvm::outs());
            llvm::outs() << "\n";
        }

        llvm::outs() << "\n";

        for (EqSatOp* value: blockOps) {
            llvm::outs() << "id " << value->id << "\n";
            llvm::outs() << "Block value: " << value->resultSSAName << " = " << value->resultValue << "\n";
            llvm::outs() << "Op ";
            value->mlirOp->print(llvm::outs());
            llvm::outs() << "\n\n";
        }

        std::ifstream file(egglogExtractedFilename);
        EgglogParser parser(context, blockOps, opaqueValues, ssaNameToBlockOp, opRegistry);

        for (EqSatOp* eqSatOp: blockOps) {
            std::string line;
            std::getline(file, line);

            std::cout << eqSatOp->getPrintId() << " = " << line << std::endl;

            mlir::Operation* prevOp = eqSatOp->mlirOp;

            mlir::OpBuilder builder(prevOp);
            size_t newOpId = parser.nextOperationId(line);
            mlir::Operation* newOp = parser.parseOperation(line, builder);

            llvm::outs() << "NEW OPERATION " << newOpId << " : ";
            newOp->print(llvm::outs());
            llvm::outs() << "\n";

            llvm::outs() << "OLD OPERATION " << eqSatOp->id << " : ";
            prevOp->print(llvm::outs());
            llvm::outs() << "\n";

            // Check if the whole operation is different, if so, replace it
            eqSatOp->replacementOp = newOp;

            llvm::outs() << "REPLACING: (" << *prevOp << ") WITH (" << *newOp << ")\n";
            prevOp->replaceAllUsesWith(newOp);
            prevOp->erase();
        }

        // TODO cleanup
    }
}