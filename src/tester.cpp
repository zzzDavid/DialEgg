#include "llvm/Support/raw_ostream.h"
#include "llvm/TableGen/Record.h"
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
#include "mlir/TableGen/Operator.h"
#include "mlir/TableGen/Argument.h"

int main() {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();
    
    std::string op = "arith.cmpf";

    // Get all the information about the operation
    mlir::OperationName name = mlir::OperationName(op, &context);

    // print attrs
    llvm::ArrayRef<mlir::StringAttr> attrs = name.getAttributeNames();

    llvm::outs() << "Operation: " << op << "\n";
    for (const mlir::StringAttr& attr: attrs) {
        llvm::outs() << "attr: " << attr.str() << "\n";
    }

    return 0;
}
