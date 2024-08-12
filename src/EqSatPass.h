#ifndef EQSATPASS_H
#define EQSATPASS_H

#include <set>
#include <map>
#include <unordered_map>

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"

class Egglog;

using AttrStringifyFunction = std::function<std::vector<std::string>(mlir::Attribute, Egglog&)>;
using AttrParseFunction = std::function<mlir::Attribute(const std::vector<std::string>&, Egglog&)>;

using TypeStringifyFunction = std::function<std::vector<std::string>(mlir::Type, Egglog&)>;
using TypeParseFunction = std::function<mlir::Type(const std::vector<std::string>&, Egglog&)>;

struct EqSatPassCustomFunctions {
    std::map<std::string, AttrStringifyFunction> attrStringifiers;
    std::map<std::string, AttrParseFunction> attrParsers;

    std::map<std::string, TypeStringifyFunction> typeStringifiers;
    std::map<std::string, TypeParseFunction> typeParsers;
};

struct EqSatPass : public mlir::PassWrapper<EqSatPass, mlir::OperationPass<mlir::func::FuncOp>> {
    const std::string egglogExecutable;
    std::string eggFilePath;
    EqSatPassCustomFunctions customFunctions;

    const std::string egglogExtractedFilename = "egg/egglog-extract.txt";
    const std::string egglogLogFilename = "egg/egglog-log.txt";

    std::vector<std::string> dialectEggFiles;
    std::set<std::string> supportedOps;
    std::set<std::string> supportedDialects;

    EqSatPass(const std::string egglogExecutable, const std::string& eggFilePath, const EqSatPassCustomFunctions& funcs);
    EqSatPass(const std::string& eggFilePath, const EqSatPassCustomFunctions& funcs);

    mlir::StringRef getArgument() const override;
    mlir::StringRef getDescription() const override;
    void runOnOperation() override;
};

#endif  //EQSATPASS_H
