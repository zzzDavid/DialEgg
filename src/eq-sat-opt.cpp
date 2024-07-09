#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "EqSatPass.h"

int main(int argc, char** argv) {
    // Register dialects
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    // Register passes
    mlir::registerAllPasses();
    mlir::PassRegistration<EqSatPass>();

    return mlir::asMainReturnCode(mlir::MlirOptMain(argc, argv, "Equality saturated MLIR\n", registry));
}