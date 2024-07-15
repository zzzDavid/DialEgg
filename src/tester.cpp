#include "llvm/Support/raw_ostream.h"
#include "mlir/IR/Dialect.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Types.h"
#include "mlir/AsmParser/AsmParser.h"

int main() {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();

    std::string op = "arith.cmpf";

    // Get all the information about the operation
    mlir::OperationName name = mlir::OperationName(op, &context);
    mlir::OperationState state(mlir::UnknownLoc::get(&context), op);

    mlir::Operation* operation = mlir::Operation::create(state);
    int numOperands = operation->getNumOperands();

    operation->destroy();

    llvm::outs() << "Operation has " << numOperands << " operands\n";

    return 0;
}
