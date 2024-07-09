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

    // Get loaded dialects
    llvm::outs() << "Loaded dialects: ";
    for (const mlir::Dialect* dialect : context.getLoadedDialects()) {
        llvm::outs() << dialect->getNamespace() << " ";
    }

    llvm::outs() << "\n--------------------------------\n";

    mlir::linalg::LinalgDialect* dialect = context.getOrLoadDialect<mlir::linalg::LinalgDialect>();

    llvm::outs() << "Dialect name: " << dialect->getNamespace() << "\n";
    llvm::outs() << "Dialect namespace: " << dialect->getNamespace() << "\n\n";

    llvm::ArrayRef<mlir::RegisteredOperationName> ops = dialect->getContext()->getRegisteredOperations();

    // print all operations in the dialect
    for (const mlir::RegisteredOperationName& op: ops) {
        llvm::StringRef name = op.getStringRef();

        if (name.starts_with("linalg.")) {
            llvm::outs() << "Operation: " << name << "\n";
            mlir::OperationState state(mlir::UnknownLoc::get(&context), name);
            mlir::Operation* op2 = mlir::Operation::create(state);

            llvm::ArrayRef<mlir::StringAttr> attrs = op.getAttributeNames();
            llvm::outs() << "Attributes: ";
            for (const mlir::StringAttr& attr: attrs) {
                llvm::outs() << attr << "  ";
            }

            llvm::outs() << "\n";

            mlir::NamedAttrList attrs2 = state.attributes;
            llvm::outs() << "Attributes: ";
            for (const mlir::NamedAttribute& attr: attrs2.getAttrs()) {
                llvm::outs() << attr.getName() << "  ";
            }

            llvm::outs() << "\n";

            llvm::outs() << "Operands: " << op2->getNumOperands() << "\n";
            llvm::outs() << "Results: " << op2->getNumResults() << "\n";


            llvm::outs() << "--------------------------------\n";
        }
    }

    llvm::outs() << "\n--------------------------------\n";

    // build a simple linalg operation
    mlir::OpBuilder builder(&context);
    llvm::SmallVector<mlir::Value, 4> dynamicDims;
    mlir::Value tensor1 = builder.create<mlir::tensor::EmptyOp>(mlir::UnknownLoc::get(&context), mlir::RankedTensorType::get({2, 3}, builder.getF32Type()), dynamicDims);
    mlir::Value tensor2 = builder.create<mlir::tensor::EmptyOp>(mlir::UnknownLoc::get(&context), mlir::RankedTensorType::get({3, 2}, builder.getF32Type()), dynamicDims);

    llvm::ArrayRef<int64_t> permutation = {1, 0};

    mlir::linalg::TransposeOp tensor3 = builder.create<mlir::linalg::TransposeOp>(mlir::UnknownLoc::get(&context), tensor1, tensor2, permutation);

    op->print(llvm::outs());
}