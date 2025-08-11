#ifndef EGGIFY_PASS_H
#define EGGIFY_PASS_H

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "mlir/Pass/Pass.h"

// TODO fix this path: we changed the output of an operation in egglog so make sure it is consistent

struct EggifyPass : public mlir::PassWrapper<EggifyPass, mlir::OperationPass<mlir::ModuleOp>> {
    mlir::StringRef getArgument() const override { return "eggify"; }
    mlir::StringRef getDescription() const override { return "Converts MLIR operations to Egglog Op variants."; }

    void runOnOperation() override {
        mlir::ModuleOp moduleOp = getOperation();

        // Walk through all operations in the module
        moduleOp.walk([&](mlir::Operation* op) {
            // Handle func.func operations
            if (auto funcOp = mlir::dyn_cast<mlir::func::FuncOp>(op)) {
                processFuncOp(funcOp);
            }
            // Handle hw.module operations  
            else if (auto hwModuleOp = mlir::dyn_cast<circt::hw::HWModuleOp>(op)) {
                processHWModuleOp(hwModuleOp);
            }
        });
    }

private:
    void processFuncOp(mlir::func::FuncOp funcOp) {
        llvm::StringRef funcName = funcOp.getName();
        
        llvm::outs() << "--------------------------------\n";
        llvm::outs() << "Function: " << funcName << "\n";
        
        // Process operations within the function
        funcOp.walk([](mlir::Operation* op) {
            if (!mlir::isa<mlir::func::FuncOp>(op)) {
                printOperationSignature(op);
            }
        });
        
        llvm::outs() << "--------------------------------\n";
    }
    
    void processHWModuleOp(circt::hw::HWModuleOp hwModuleOp) {
        llvm::StringRef moduleName = hwModuleOp.getName();
        
        llvm::outs() << "--------------------------------\n";
        llvm::outs() << "HW Module: " << moduleName << "\n";
        
        // Process operations within the hw module
        hwModuleOp.walk([](mlir::Operation* op) {
            if (!mlir::isa<circt::hw::HWModuleOp>(op)) {
                printOperationSignature(op);
            }
        });
        
        llvm::outs() << "--------------------------------\n";
    }
    
    static void printOperationSignature(mlir::Operation* op) {
        mlir::OperationName opName = op->getName();
        llvm::StringRef opNameStr = opName.getStringRef();
        size_t numOperands = op->getNumOperands();
        size_t numAttributes = opName.getAttributeNames().size();

        // Print the operation name and the number of operands, results, and attributes
        // (function <opName> (i64 [Op]*numOperands [AttrPair]*numAttributes Type) Op)
        llvm::outs() << "(function " << opNameStr << " (";  // (function <opName> (
        for (size_t i = 0; i < numOperands; i++) {
            llvm::outs() << " Op";
        }
        for (size_t i = 0; i < numAttributes; i++) {
            llvm::outs() << " AttrPair";
        }
        llvm::outs() << " Type) Op)\n";
    }
};

#endif  // EGGIFY_PASS_H