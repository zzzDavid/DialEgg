#include <unordered_set>
#include <map>

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

struct PlayPass : public mlir::PassWrapper<PlayPass, mlir::OperationPass<mlir::func::FuncOp>> {
    mlir::StringRef getArgument() const override { return "play"; }
    mlir::StringRef getDescription() const override { return "Playground pass."; }

    void runOnOperation() override {
        mlir::func::FuncOp rootOp = getOperation();

        // Get the name of the function
        llvm::StringRef rootOpName = rootOp.getName();

        llvm::outs() << "--------------------------------\n";
        llvm::outs() << "Function: " << rootOpName << "\n";

        std::set<mlir::Block*> blocks;

        // Get all operations in the function
        rootOp.walk([&](mlir::Operation* op) {
            mlir::Block* block = op->getBlock();

            // Make sure block parent is not a module
            if (!mlir::isa<mlir::ModuleOp>(block->getParentOp())) {
                blocks.insert(block);
            }
        });

        // Print number of blocks
        llvm::outs() << "Number of blocks: " << blocks.size() << "\n";

        // Print all blocks with op : block
        for (mlir::Block* block: blocks) {
            llvm::outs() << "Block: " << block->getParentOp()->getName() << "\n";
            block->print(llvm::outs());
            llvm::outs() << "\n\n\n\n";
        }

        llvm::outs() << "--------------------------------\n\n\n";
    }
};

int main(int argc, char** argv) {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    // Register passes
    mlir::registerAllPasses();
    mlir::PassRegistration<PlayPass>();

    mlir::LogicalResult result = mlir::MlirOptMain(argc, argv, "Playground", registry);
    return mlir::asMainReturnCode(result);
}