#ifndef EQSATPASS_H
#define EQSATPASS_H

#include <set>
#include <map>
#include <unordered_map>

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"

using AttrStringifyFunction = std::function<std::vector<std::string>(mlir::Attribute)>;
using AttrParseFunction = std::function<mlir::Attribute(const std::vector<std::string>&, mlir::MLIRContext&)>;

using TypeStringifyFunction = std::function<std::vector<std::string>(mlir::Type)>;
using TypeParseFunction = std::function<mlir::Type(const std::vector<std::string>&, mlir::MLIRContext&)>;

struct EqSatPassCustomFunctions {
    std::map<std::string, AttrStringifyFunction> attrStringifiers;
    std::map<std::string, AttrParseFunction> attrParsers;
    // std::map<mlir::TypeID, TypeStringifyFunction> typeStringifiers;
    // std::map<std::string, TypeParseFunction> typeParsers;
};

struct EqSatPass : public mlir::PassWrapper<EqSatPass, mlir::OperationPass<mlir::func::FuncOp>> {
    const std::string egglogExecutable;

    const std::string attrFilename = "egg/attr.egg";
    const std::string opFilename = "egg/op.egg";
    const std::string eggFilename = "egg/mlir.egg";
    const std::string egglogExtractedFilename = "egg/egglog-extract.txt";
    const std::string egglogLogFilename = "egg/egglog-log.txt";
    const std::string opRegistryFilename = "mlir/ops.txt";
    
    std::string customEggFilename;
    std::set<std::string> supportedOps;
    std::set<std::string> supportedDialects;

    EqSatPassCustomFunctions customFunctions;

    EqSatPass(const std::string egglogExecutable, const std::string& eggFile, const EqSatPassCustomFunctions& funcs);
    EqSatPass(const std::string& eggFile, const EqSatPassCustomFunctions& funcs);

    mlir::StringRef getArgument() const override;
    mlir::StringRef getDescription() const override;
    void runOnOperation() override;
};

#endif  //EQSATPASS_H
