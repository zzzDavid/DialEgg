#include "llvm/Support/FileSystem.h"
#include "llvm/Support/CommandLine.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/AsmParser/AsmParser.h"

#include "Egglog.h"
#include "EqualitySaturationPass.h"
#include "EggifyPass.h"
#include "EgglogCustomDefs.h"
#include "MatrixMultiplyAssociatePass.h"

int main(int argc, char** argv) {
    // Register dialects
    mlir::DialectRegistry dialectRegistry;
    mlir::registerAllDialects(dialectRegistry);

    // Register passes
    mlir::registerAllPasses();
    mlir::PassRegistration<EggifyPass>();
    mlir::PassRegistration<MatrixMultiplyAssociatePass>();

    // Equality Saturation Pass
    std::string egglogExecutable = "~/dev/lib/egglog/target/debug/egglog";  // Default
    std::string eggFile = "egg/egg.egg";
    
    std::string inputFilename;
    for (int i = 1; i < argc; i++) {
        if (argv[i][0] != '-') {
            inputFilename = argv[i];
            break;
        }
    }

    // If input is <DIR>/abc.mlir, then eggFile is <DIR>/abc.egg (if it exists)
    if (inputFilename.find(".mlir") != std::string::npos) {
        std::string newEggFile = inputFilename.substr(0, inputFilename.find(".mlir")) + ".egg";
        if (llvm::sys::fs::exists(newEggFile)) {
            eggFile = newEggFile;
        }
    }

    llvm::outs() << "egglogExecutable: " << egglogExecutable << "\n";
    llvm::outs() << "eggFile: " << eggFile << "\n";
    llvm::outs() << "inputFilename: " << inputFilename << "\n";
    
    std::map<std::string, AttrStringifyFunction> attrStringifiers = {
            {mlir::arith::FastMathFlagsAttr::name.str(), stringifyFastMathFlagsAttr}};
    std::map<std::string, AttrParseFunction> attrParsers = {
            {"arith_fastmath", parseFastMathFlagsAttr}};

    std::map<std::string, TypeStringifyFunction> typeStringifiers = {
            {mlir::RankedTensorType::name.str(), stringifyRankedTensorType}};
    std::map<std::string, TypeParseFunction> typeParsers = {
            {"RankedTensor", parseRankedTensorType}};

    EgglogCustomDefs funcs = {attrStringifiers, attrParsers, typeStringifiers, typeParsers};
    mlir::PassRegistration<EqualitySaturationPass>([&] { return createEqualitySaturationPass(egglogExecutable, eggFile, funcs); });

    // Run the main MLIR opt
    mlir::LogicalResult result = mlir::MlirOptMain(argc, argv, "EqSat", dialectRegistry);
    return mlir::asMainReturnCode(result);
}