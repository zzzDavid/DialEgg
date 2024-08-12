#include "llvm/Support/raw_ostream.h"
#include "llvm/TableGen/Record.h"
#include "mlir/IR/Dialect.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Types.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/TableGen/Operator.h"
#include "mlir/TableGen/Argument.h"

#include <time.h>

int main() {
    clock_t start = clock();

    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();

    mlir::OpBuilder builder(&context);

    mlir::IntegerType i64Type = mlir::IntegerType::get(&context, 64);
    mlir::FloatType f64Type = mlir::FloatType::getF64(&context);
    mlir::TensorType tensorType = mlir::RankedTensorType::get({10, 10}, f64Type);

    // Create linalg.fill_rng_2d operation
    mlir::OperationState state(mlir::UnknownLoc::get(&context), "linalg.fill_rng_2d");
    
    mlir::Value seed = builder.create<mlir::arith::ConstantOp>(mlir::UnknownLoc::get(&context), i64Type, builder.getI64IntegerAttr(0));
    mlir::Value min = builder.create<mlir::arith::ConstantOp>(mlir::UnknownLoc::get(&context), i64Type, builder.getF64FloatAttr(-100.0));
    mlir::Value max = builder.create<mlir::arith::ConstantOp>(mlir::UnknownLoc::get(&context), i64Type, builder.getF64FloatAttr(100.0));
    mlir::tensor::EmptyOp empty = builder.create<mlir::tensor::EmptyOp>(mlir::UnknownLoc::get(&context), tensorType.getShape(), tensorType.getElementType());
    
    // mlir::linalg::FillRng2DOp fillRng2d = builder.create<mlir::linalg::FillRng2DOp>(mlir::UnknownLoc::get(&context), empty.getResult(), seed, min, max);
    mlir::linalg::FillRng2DOp::build(builder, state, llvm::ArrayRef<mlir::Value>{seed, min, max}, empty.getResult());
    mlir::Operation* fillRng2d = mlir::Operation::create(state);
    fillRng2d->print(llvm::outs());

    return 0;
}
