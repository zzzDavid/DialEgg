#ifndef UTILS_H
#define UTILS_H

#include <string>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <limits>
#include <numbers>

#include "llvm/Support/raw_os_ostream.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Value.h"

inline std::string getSSAName(const mlir::Value& value, const mlir::OpPrintingFlags opPrintingFlags = mlir::OpPrintingFlags()) {
    std::string ssaName;
    llvm::raw_string_ostream ssaNameStream(ssaName);
    value.printAsOperand(ssaNameStream, opPrintingFlags);
    ssaNameStream.flush();
    return ssaName;
}

inline std::string getTypeName(const mlir::Value& value) {
    std::string type;
    llvm::raw_string_ostream typeStream(type);
    value.getType().print(typeStream);
    typeStream.flush();
    return type;
}

inline std::string opToString(const mlir::Operation& op) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << op;
    stream.flush();
    return str;
}

inline std::string valueToString(mlir::Value value) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << value;
    stream.flush();
    return str;
}

inline std::string typeToString(const mlir::Type& type) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << type;
    stream.flush();
    return str;
}

inline std::string locationToString(const mlir::Location& loc) {
    std::string str;
    llvm::raw_string_ostream stream(str);
    stream << loc;
    stream.flush();
    return str;
}

inline std::string doubleToString(double d) {
    std::ostringstream ss;
    ss << std::fixed << d;
    std::string str = ss.str();

    // remove trailing zeros
    size_t lastNonZero = str.find_last_not_of('0');
    if (lastNonZero != std::string::npos && str[lastNonZero] == '.') {
        lastNonZero++;
    }
    str = str.substr(0, lastNonZero + 1);
    return str;
}

inline bool opDeepEqual(mlir::Operation& a, mlir::Operation& b) {
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
inline std::string unwrap(const std::string& str, char c = ' ') {
    if (str.front() == c && str.back() == c) {
        return str.substr(1, str.size() - 2);
    }
    return str;
}

inline std::string trim(const std::string& str, char c = ' ') {
    size_t first = str.find_first_not_of(c);
    if (first == std::string::npos) {
        return "";
    }

    size_t last = str.find_last_not_of(c);
    return str.substr(first, (last - first + 1));
}

inline bool isBlank(const std::string& str) {
    return str.find_first_not_of(' ') == std::string::npos;
}

inline void printFileContents(const std::string& filename, llvm::raw_ostream& ros = llvm::outs()) {
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            ros << line << "\n";
        }
        file.close();
    }
}

inline size_t sizeOfTypeInBytes(mlir::Type type) {
    if (type.isa<mlir::IntegerType>()) {
        return type.cast<mlir::IntegerType>().getWidth();
    }

    if (type.isa<mlir::FloatType>()) {
        return type.cast<mlir::FloatType>().getWidth();
    }

    if (type.isa<mlir::IndexType>()) {
        return 64;
    }

    if (type.isa<mlir::NoneType>()) {
        return 0;
    }

    if (type.isa<mlir::TupleType>()) {
        size_t size = 0;
        for (mlir::Type subType: type.cast<mlir::TupleType>().getTypes()) {
            size += sizeOfTypeInBytes(subType);
        }
        return size;
    }

    return 0;
}

#endif //UTILS_H