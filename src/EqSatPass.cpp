#include <map>
#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>

#include <mlir/IR/Value.h>
#include <llvm/IR/Module.h>
#include <mlir/IR/Builders.h>
#include <llvm/ADT/Hashing.h>
#include <mlir/IR/OperationSupport.h>
#include <mlir/Dialect/Linalg/IR/Linalg.h>
#include <mlir/Dialect/Linalg/IR/LinalgInterfaces.h>
#include "mlir/AsmParser/AsmParser.h"

#include "EqSatPass.h"
#include "EqSatOp.h"

mlir::StringRef EqSatPass::getArgument() const {
    return "eq-sat";
}

mlir::StringRef EqSatPass::getDescription() const {
    return "Performs equality saturation on each block in the given file. The language definition is egglog.";
}

std::string getSSAValueName(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName;
    llvm::raw_string_ostream ssaNameStream(ssaName);
    value.printAsOperand(ssaNameStream, opPrintingFlags);
    ssaNameStream.flush();
    return ssaName;
}

std::string getTypeName(const mlir::Value& value) {
    std::string type;
    llvm::raw_string_ostream typeStream(type);
    value.getType().print(typeStream);
    typeStream.flush();
    return type;
}

std::string getSSAValueId(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName = getSSAValueName(value, opPrintingFlags);
    return "op_" + ssaName.substr(1);  // remove the % prefix
}

std::ifstream extractOps(const std::map<std::string, const EqSatOp*>& ops) {
    std::string eggFilename = "../res/linalg.egg";
    std::string stdOutFilename = "../res/linalg-egglog-extract.txt";
    std::string stdErrFilename = "../res/linalg-egglog-stderr.txt";
    std::ofstream eggFile(eggFilename, std::ios::app);

    // print egglog
    eggFile << std::endl;
    for (const auto& [resultId, eqSatOp]: ops) {
        eggFile << eqSatOp->egglogLet() << std::endl;
    }

    // run egglog
    eggFile << std::endl;
    eggFile << "(run 100000)" << std::endl;

    // Extract the results of the egglog run
    for (const auto& [resultId, eqSatOp]: ops) {
        eggFile << "(extract " << resultId << ")" << std::endl;
    }

    eggFile.close();

    // Run egglog and extract the results
    std::string egglogCmd = "../egglog " + eggFilename + " --to-svg > " + stdOutFilename + " 2> " + stdErrFilename;
    std::cout << "\nRunning egglog: " << egglogCmd << std::endl;

    std::system(egglogCmd.c_str());

    // Parse the results
    return std::ifstream(stdOutFilename);
}

/**
 * Splits the given operation string into a vector of strings.
 * Example: "(linalg_add (linalg_abs (tensor_empty)) (tensor_empty))" -> ["linalg_add", "(linalg_abs (tensor_empty))", "(tensor_empty)"]
 */
std::vector<std::string> splitOperation(std::string opStr) {
    // remove the outer parentheses
    if (opStr.front() == '(' && opStr.back() == ')') {
        opStr = opStr.substr(1, opStr.size() - 2);
    }

    // split by whitespace that is not inside parentheses
    std::vector<std::string> result;
    std::stringstream ss;

    int openParentheses = 0;
    for (char c: opStr) {
        if (c == '(') {
            openParentheses++;
        } else if (c == ')') {
            openParentheses--;
        }

        if (c == ' ' && openParentheses == 0 && !ss.str().empty()) {
            result.push_back(ss.str());
            ss.str("");
        } else {
            ss << c;
        }
    }

    if (!ss.str().empty()) {
        result.push_back(ss.str());
    }

    return result;
}

/**
 * Parses the given operation string into a list of MLIR operations, in order or dependency.
 * Example:
 *      (linalg_transpose (tensor_empty "tensor<3x2xf32>") (tensor_empty "tensor<2x3xf32>") "tensor<2x3xf32>")
 * Becomes:
 *      %0 = tensor.empty() : tensor<3x2xf32>
 *      %1 = tensor.empty() : tensor<2x3xf32>
 *      %2 = linalg.transpose %0, %1 : tensor<3x2xf32>, tensor<2x3xf32>
 */
mlir::Value parseOperation(const EqSatOp* originalOp, const std::string& newOpStr, mlir::MLIRContext& context) {
    std::vector<std::string> split = splitOperation(newOpStr);

    std::string opName = split[0];
    std::replace(opName.begin(), opName.end(), '_', '.'); // Replace underscores with dots
    mlir::OperationState state(mlir::UnknownLoc::get(&context), opName);

    // Operands
    std::vector<mlir::Value> operands;
    for (size_t i = 1; i < split.size() - 1; i++) {
        const std::string& operandStr = split[i];
        mlir::Value nestedOperand = parseOperation(nullptr, operandStr, context);
        operands.push_back(nestedOperand);
    }
    state.addOperands(operands);

    // Return type
    std::string returnType = split.back();

    if (returnType.front() == '"' && returnType.back() == '"') { // Remove surrounding quotes
        returnType = returnType.substr(1, returnType.size() - 2);
    }

    mlir::Type type = mlir::parseType(returnType, &context);
    state.addTypes(type);

    // copy attributes if the operation is the same
    if (state.name.getStringRef() == opName) {
        llvm::outs() << "Copying attributes from " << state.name << " to " << opName << "\n";
        mlir::DictionaryAttr attrs = originalOp->mlirOp.getAttrDictionary();
        for (const mlir::NamedAttribute& attr : attrs) {
            state.addAttribute(attr.getName(), attrs.get(attr.getName()));
        }
    }

    // copy regions if the operation is the same
    if (state.name.getStringRef() == opName && !originalOp->mlirOp.getRegions().empty()) {
        llvm::outs() << "Copying region from " << state.name << " to " << opName << "\n";
        mlir::Region* region = state.addRegion();
        mlir::IRMapping mapping = mlir::IRMapping();
        originalOp->mlirOp.getRegion(0).cloneInto(region, mapping);
    }

    // Create the operation
    mlir::OpBuilder builder2(&originalOp->mlirOp);
    mlir::Operation* newOp = builder2.create(state);

    llvm::outs() << "OPERATION: ";
    newOp->print(llvm::outs());
    llvm::outs() << "\n";

    originalOp->mlirOp.replaceAllUsesWith(newOp);

    return newOp->getResult(0);
}

void EqSatPass::runOnOperation() {
    mlir::MLIRContext& context = getContext();
    mlir::func::FuncOp rootOp = getOperation();

    // Perform equality saturation on all operations of a block.
    // Re-create the MLIR operations in this block according to the optimization.
    for (mlir::Block& block: rootOp.getRegion().getBlocks()) {

        std::map<std::string, const EqSatOp*> ops; // Map of result SSA value id to EqSatOp for all operations in the block
        for (mlir::Operation& op: block.getOperations()) {
            if (op.getNumResults() == 0) {  // continue if this op has no results
                continue;
            }

            // print attributes and their values
//            llvm::outs() << "Attributes: ";
//            mlir::DictionaryAttr attrs = op.getAttrDictionary();
//            for (const mlir::NamedAttribute& attr : attrs) {
//                llvm::outs() << attr.getName() << " = " << attrs.get(attr.getName()) << "  ";
//            }
//            llvm::outs() << "\n";

            // print region
//            if (!op.getRegions().empty()) {
//                llvm::outs() << "Region: ";
//                std::for_each(op.getRegion(0).begin(), op.getRegion(0).end(), [](mlir::Block& block) {
//                    block.print(llvm::outs());
//                });
//                llvm::outs() << "\n\n\n";
//            }

            std::vector<const EqSatOp*> operands;
            for (const mlir::Value& operand: op.getOperands()) {
                std::string operandId = getSSAValueId(operand, mlir::OpPrintingFlags().enableDebugInfo());
                operands.push_back(ops.at(operandId));
            }

            mlir::Value result0 = op.getResult(0);

            std::string opId = getSSAValueId(result0);
            std::string opName = op.getName().getStringRef().str();
            std::string opType = getTypeName(result0);

            EqSatOp* eqSatOp = new EqSatOp(opId, opName, opType, operands, op);
            ops.emplace(opId, eqSatOp);

            eqSatOp->print(std::cout);
        }

        std::ifstream file = extractOps(ops); // Prep egg file

        for (const auto& [resultId, eqSatOp]: ops) {
            std::string line;
            std::getline(file, line);

            std::cout << resultId << " = " << line << std::endl;

            parseOperation(eqSatOp, line, context); // breakdown the line into operations
        }

    }
}