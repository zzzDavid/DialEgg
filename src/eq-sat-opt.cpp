#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

#include "EqSatPass.h"

int main(int argc, char** argv) {
    // Register dialects
    mlir::DialectRegistry dialectRegistry;
    mlir::registerAllDialects(dialectRegistry);

    // Register passes
    mlir::registerAllPasses();
    mlir::PassRegistration<EqSatPass>();

    // Run the main MLIR opt
    mlir::LogicalResult result = mlir::MlirOptMain(argc, argv, "Equality saturated MLIR\n", dialectRegistry);
    return mlir::asMainReturnCode(result);
}