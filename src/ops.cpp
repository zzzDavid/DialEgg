#include <fstream>
#include <iostream>
#include "mlir/InitAllDialects.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"

int main() {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();

    size_t mostAttributes = 0;
    std::string opWithMostAttributes;
    std::ofstream file("res/mlir/all-ops.txt");

    llvm::ArrayRef<mlir::RegisteredOperationName> allOps = context.getRegisteredOperations();
    for (const mlir::RegisteredOperationName& op: allOps) {
        llvm::ArrayRef<mlir::StringAttr> attributes = op.getAttributeNames();

        if (attributes.size() > mostAttributes) {
            mostAttributes = attributes.size();
            opWithMostAttributes = op.getStringRef().str();
        }

        file << op.getStringRef().str() << ", ";
        file << attributes.size() << " attributes: [";
        for (const mlir::StringAttr& attr: attributes) {
            file << attr.str() << ", ";
        }

        if (attributes.size() > 0) {
            file.seekp(-2, std::ios_base::end);
        }

        file << "]\n";
    }

    // Print the operation with the most attributes
    std::cout << "Operation with most attributes: " << opWithMostAttributes << " with " << mostAttributes << " attributes\n";
    
    return 0;
}