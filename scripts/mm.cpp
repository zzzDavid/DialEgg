#include <iostream>
#include "mlir/IR/Types.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Support/LogicalResult.h"
#include "llvm/Support/raw_ostream.h"

mlir::func::FuncOp buildBlackholeFunction(mlir::OpBuilder builder) {
    mlir::IntegerType i32Type = builder.getI32Type();
    mlir::RankedTensorType tensorType = mlir::RankedTensorType::get({100, 100}, i32Type);

    mlir::func::FuncOp func = builder.create<mlir::func::FuncOp>(builder.getUnknownLoc(), "blackhole", builder.getFunctionType({tensorType}, {tensorType}));
    mlir::Block* entryBlock = func.addEntryBlock();
    builder.setInsertionPointToStart(entryBlock);

    mlir::BlockArgument arg = entryBlock->getArgument(0);
    builder.create<mlir::func::ReturnOp>(builder.getUnknownLoc(), arg);

    return func;
}

/**
 * Builds a function that performs n matrix multiplications.
 * n = 2: (XY)Z
 * n = 3: ((XY)Z)W
 * n = 4: (((XY)Z)W)V
 */
mlir::func::FuncOp buildNMMFunction(mlir::OpBuilder builder, uint8_t n) {
    mlir::IntegerType i32Type = builder.getI32Type();
    mlir::RankedTensorType tensorType = mlir::RankedTensorType::get({100, 100}, i32Type);

    // Create the function inside the module.
    mlir::func::FuncOp func = builder.create<mlir::func::FuncOp>(builder.getUnknownLoc(), "main", builder.getFunctionType({}, {i32Type}));
    mlir::Block* entryBlock = func.addEntryBlock();
    builder.setInsertionPointToStart(entryBlock); // Set the insertion point to the function's entry block.

    mlir::tensor::EmptyOp x = builder.create<mlir::tensor::EmptyOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange{});
    mlir::tensor::EmptyOp y = builder.create<mlir::tensor::EmptyOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange{});

    mlir::Value xy_init = builder.create<mlir::tensor::EmptyOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange{});
    mlir::linalg::MatmulOp xy = builder.create<mlir::linalg::MatmulOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange {x, y}, xy_init);

    mlir::linalg::MatmulOp mult = xy;
    for (uint8_t i = 0; i < n - 1; i++) {
        mlir::tensor::EmptyOp z = builder.create<mlir::tensor::EmptyOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange{});
        mlir::Value xy_z_init = builder.create<mlir::tensor::EmptyOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange{});
        mlir::linalg::MatmulOp xy_z = builder.create<mlir::linalg::MatmulOp>(builder.getUnknownLoc(), tensorType, mlir::ValueRange {mult.getResult(0), z}, xy_z_init);

        mult = xy_z;
    }

    // call blackhole function with xy_z as argument
    builder.create<mlir::func::CallOp>(builder.getUnknownLoc(), "blackhole", mlir::ValueRange {mult.getResult(0)}, mlir::ValueRange {mult.getResult(0)});

    mlir::Value c0 = builder.create<mlir::arith::ConstantOp>(builder.getUnknownLoc(), i32Type, builder.getI32IntegerAttr(0));
    builder.create<mlir::func::ReturnOp>(builder.getUnknownLoc(), c0);

    return func;
}

int main() {
    int n; // Number of matrix multiplications.
    std::cin >> n;
    llvm::outs() << n << "MM \n";
    
    mlir::MLIRContext context; // Initialize an MLIR context.
    context.getOrLoadDialect<mlir::linalg::LinalgDialect>();
    context.getOrLoadDialect<mlir::tensor::TensorDialect>();
    context.getOrLoadDialect<mlir::func::FuncDialect>();

    // Create a module to hold the function.
    mlir::OpBuilder builder(&context);
    auto module = mlir::ModuleOp::create(builder.getUnknownLoc());

    auto blackholeFunction = buildBlackholeFunction(builder);
    module.push_back(blackholeFunction);

    auto NMMFunction = buildNMMFunction(builder, n);
    module.push_back(NMMFunction);

    // Open the file to write the MLIR code to.
    std::error_code EC;
    std::string file = "mm/linalg_" + std::to_string(n) + "mm.mlir";
    llvm::raw_fd_ostream outputFile(file, EC);

    if (EC) {
        llvm::errs() << "Error opening file: " << EC.message() << "\n";
        return 1;
    }

    // Print the MLIR module to the file.
    module.print(outputFile);

    // Verify the module.
    if (failed(verify(module))) {
        llvm::errs() << "Module verification failed.\n";
        return 1;
    }

    return 0;
}
