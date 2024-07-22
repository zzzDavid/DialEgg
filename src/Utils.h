#ifndef UTILS_H
#define UTILS_H

#include <string>

#include "llvm/Support/raw_os_ostream.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Value.h"

std::string getSSAValueName(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName;
    llvm::raw_string_ostream ssaNameStream(ssaName);
    value.printAsOperand(ssaNameStream, opPrintingFlags);
    ssaNameStream.flush();
    return ssaName;
}

std::string getTypeName(const mlir::Value& value) {
    std::string type;
    llvm::raw_string_ostream typeStream(type);
    value.getType().print(typeStream);
    typeStream.flush();
    return type;
}

std::string getSSAValueId(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName = getSSAValueName(value, opPrintingFlags);
    return "op_" + ssaName.substr(1);  // remove the % prefix
}

std::string opToString(const mlir::Operation& op) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << op;
    stream.flush();
    return str;
}

std::string valueToString(const mlir::Value& value) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << value;
    stream.flush();
    return str;
}

bool opDeepEqual(mlir::Operation& a, mlir::Operation& b) {
    if (a.getName() != b.getName()) {
        return false;
    }

    if (a.getNumOperands() != b.getNumOperands()) {
        return false;
    }

    if (a.getNumResults() != b.getNumResults()) {
        return false;
    }

    if (a.getNumRegions() != b.getNumRegions()) {
        return false;
    }

    // compare attributes
    for (const mlir::NamedAttribute& attr: a.getAttrs()) {
        mlir::StringAttr aAttr = attr.getName();
        mlir::Attribute aAttrValue = attr.getValue();

        llvm::outs() << "AT ATTR A: " << aAttr << " with value: " << aAttrValue << "\n";

        if (!b.hasAttr(aAttr)) {
            llvm::outs() << "B DOES NOT HAVE ATTR: " << aAttr << "\n";
            return false;
        }

        mlir::Attribute bAttrValue = b.getAttr(aAttr);

        llvm::outs() << "AT ATTR B: " << aAttr << " with value: " << bAttrValue << "\n";

        if (aAttrValue != bAttrValue) {
            llvm::outs() << "ATTR VALUES ARE DIFFERENT\n";
            return false;
        }
    }

    // compare operands
    for (unsigned int i = 0; i < a.getNumOperands(); i++) {
        if (a.getOperand(i) != b.getOperand(i)) {
            return false;
        }
    }

    // compare results
    // for (unsigned int i = 0; i < a.getNumResults(); i++) {
    //     if (a.getResult(i) != b.getResult(i)) {
    //         return false;
    //     }
    // }

    // TODO compare regions
    if (a.getNumRegions() > 0 || b.getNumRegions() > 0) {
        return false; // not supported yet
    }

    return true;
}

/** Returns the given string without the wrapping character */
std::string unwrap(const std::string& str, char c = ' ') {
    if (str.front() == c && str.back() == c) {
        return str.substr(1, str.size() - 2);
    }
    return str;
}

std::string trim(const std::string& str, char c = ' ') {
    size_t first = str.find_first_not_of(c);
    if (first == std::string::npos) {
        return "";
    }

    size_t last = str.find_last_not_of(c);
    return str.substr(first, (last - first + 1));
}

bool isBlank(const std::string& str) {
    return str.find_first_not_of(' ') == std::string::npos;
}

#endif //UTILS_H