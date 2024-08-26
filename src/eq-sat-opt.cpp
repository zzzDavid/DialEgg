#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/AsmParser/AsmParser.h"

#include "Egglog.h"
#include "EqualitySaturationPass.h"

/** 
 * Parse the attribute (function arith_fastmath (FastMathFlags) Attr)
 * Where (datatype FastMathFlags (none) (reassoc) (nnan) ...)
 */
mlir::Attribute parseFastMathFlagsAttr(const std::vector<std::string>& split, Egglog& egglog) {
    std::string attrType = split[0];
    assert(attrType == "arith_fastmath");

    std::string flag = split[1];
    if (flag.front() == '(' && flag.back() == ')') {
        flag = flag.substr(1, flag.size() - 2);
    }

    std::string strAttr = "#arith.fastmath<" + flag + ">";
    mlir::Attribute parsedAttr = mlir::parseAttribute(strAttr, &egglog.context);

    // dump
    llvm::outs() << "Parsing mlir::arith::FastMathFlagsAttr: " << strAttr << "\n";
    llvm::outs() << "Parsed mlir::arith::FastMathFlagsAttr: " << parsedAttr << "\n";

    return parsedAttr;
}

/**
 * Serialize the attribute (function arith_fastmath (FastMathFlags) Attr)
 * Where (datatype FastMathFlags (none) (reassoc) (nnan) ...)
 */
std::vector<std::string> stringifyFastMathFlagsAttr(mlir::Attribute attr, Egglog& egglog) {
    std::vector<std::string> split;

    split.push_back("arith_fastmath");

    mlir::arith::FastMathFlagsAttr fastMathAttr = attr.cast<mlir::arith::FastMathFlagsAttr>();
    mlir::arith::FastMathFlags flags = fastMathAttr.getValue();

    split.push_back("(" + mlir::arith::stringifyFastMathFlags(flags) + ")");

    // dump
    llvm::outs() << "Stringified mlir::arith::FastMathFlagsAttr: ";
    for (const std::string& s: split) {
        llvm::outs() << s << " , ";
    }
    llvm::outs() << "\n";

    return split;
}

/** Parse the type (function Tensor (DimVec Type) Type) */
mlir::Type parseRankedTensorType(const std::vector<std::string>& split, Egglog& egglog) {
    std::string attrType = split[0];
    assert(attrType == "RankedTensor");

    std::string dimVec = split[1];
    std::string type = split[2];

    // parse dimvec, form (vec-of <N1> <N2> ... <Nn>)
    std::vector<std::string> dimVecSplit = Egglog::splitExpression(dimVec);
    std::vector<int64_t> dims;
    for (unsigned int i = 1; i < dimVecSplit.size(); i++) {
        dims.push_back(std::stoll(dimVecSplit[i]));
    }

    mlir::Type parsedType = egglog.parseType(type);  // parse type
    return mlir::RankedTensorType::get(dims, parsedType);
}

/** Serialize the type (function Tensor (DimVec Type) Type) */
std::vector<std::string> stringifyRankedTensorType(mlir::Type type, Egglog& egglog) {
    std::vector<std::string> split;
    split.push_back("RankedTensor");

    mlir::RankedTensorType tensorType = type.cast<mlir::RankedTensorType>();
    llvm::ArrayRef<int64_t> shape = tensorType.getShape();
    mlir::Type elementType = tensorType.getElementType();

    // serialize dimvec
    std::string dimVec = "(vec-of";
    for (int64_t dim: shape) {
        dimVec += " " + std::to_string(dim);
    }
    dimVec += ")";

    split.push_back(dimVec);
    split.push_back(egglog.eggifyType(elementType));

    return split;
}

int main(int argc, char** argv) {
    // Register dialects
    mlir::DialectRegistry dialectRegistry;
    mlir::registerAllDialects(dialectRegistry);

    // Register passes
    mlir::registerAllPasses();

    std::string egglogExecutable = "~/dev/lib/egglog/target/debug/egglog";  // Change this to the path of your egglog executable
    std::string eggFile = "egg/egg.egg";                                    // Change this to the path of your egg file

    std::map<std::string, AttrStringifyFunction> attrStringifiers = {
            {mlir::arith::FastMathFlagsAttr::name.str(), stringifyFastMathFlagsAttr}};
    std::map<std::string, AttrParseFunction> attrParsers = {
            {"arith_fastmath", parseFastMathFlagsAttr}};

    std::map<std::string, TypeStringifyFunction> typeStringifiers = {
            {mlir::RankedTensorType::name.str(), stringifyRankedTensorType}};
    std::map<std::string, TypeParseFunction> typeParsers = {
            {"RankedTensor", parseRankedTensorType}};

    EgglogCustomDefs funcs = {attrStringifiers, attrParsers, typeStringifiers, typeParsers};
    mlir::PassRegistration<EqualitySaturationPass>([&] { return std::make_unique<EqualitySaturationPass>(egglogExecutable, eggFile, funcs); });

    // Run the main MLIR opt
    mlir::LogicalResult result = mlir::MlirOptMain(argc, argv, "Equality saturated MLIR\n", dialectRegistry);
    return mlir::asMainReturnCode(result);
}