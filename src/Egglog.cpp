#include <regex>

#include "mlir/IR/Value.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Builders.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"
#include "mlir/Dialect/Arith/IR/Arith.h"

#include "Egglog.h"
#include "EqualitySaturationPass.h"
#include "Utils.h"

EgglogOpDef EgglogOpDef::parseOpFunction(const std::string& opStr) {
    std::vector<std::string> split = Egglog::splitExpression(opStr);
    assert(split.size() > 0);
    assert(split[0] == "function");

    // check if the last element is "Op", otherwise the cost is the last element
    size_t cost = 1;
    if (split.back() != "Op") {
        cost = std::stoll(split.back());
        assert(split[split.size() - 3] == "Op");
    } else {
        assert(split.back() == "Op");
    }

    std::string fullName = split[1];
    std::string name = fullName.substr(fullName.find_last_of('_') + 1);
    std::string dialect = fullName.substr(0, fullName.find_first_of('_'));

    std::vector<std::string> args = Egglog::splitExpression(split[2]);

    size_t nOperands = 0;
    size_t nAttributes = 0;

    for (const std::string& arg: args) {
        if (arg == "Op") {
            nOperands++;
        } else if (arg == "AttrPair") {
            nAttributes++;
        }
    }

    bool region = std::find(args.begin(), args.end(), "MlirRegion") != args.end();

    return EgglogOpDef {
            .str = opStr,
            .fullName = fullName,
            .dialect = dialect,
            .name = name,
            .args = args,
            .nOperands = nOperands,
            .nAttributes = nAttributes,
            .region = region,
            .cost = cost};
}

bool EgglogOpDef::isOpFunction(const std::string& opStr) {
    if (opStr.empty()) {
        return false;
    } else if (opStr.front() != '(' || opStr.back() != ')') {
        return false;
    }

    std::vector<std::string> split = Egglog::splitExpression(opStr);
    return split.size() > 1 && split[0] == "function" && (split.back() == "Op" || split[split.size() - 3] == "Op");
}

std::string EggifiedOp::inlinedEgglogOp() const {
    // insert op1 and op2 into (add op1 op2)
    std::string inlinedEgglogOp = egglogOp;

    for (const EggifiedOp& operand: operands) {
        std::string operandPrintId = operand.getPrintId();

        // replace all occurrences of opPrintId with operand.egglogOp
        std::string inlinedOperandEgglogOp = operand.inlinedEgglogOp();
        inlinedEgglogOp = std::regex_replace(inlinedEgglogOp, std::regex(operandPrintId), inlinedOperandEgglogOp);
    }

    return inlinedEgglogOp;
}

std::vector<std::string> Egglog::splitExpression(std::string opStr) {
    // The expression must be surrounded by parentheses
    if (opStr.front() != '(' || opStr.back() != ')') {
        llvm::outs() << "Invalid expression: " << opStr << "\n";
        exit(1);
    }

    // split by whitespace that is not inside parentheses, square brackets, or quotes
    std::vector<std::string> result;
    std::stringstream ss;

    int openParentheses = 0;
    bool inQuotes = false;
    for (size_t i = 1; i < opStr.size() - 1; i++) {
        char c = opStr[i];

        if (c == '(' || c == '[') {
            openParentheses++;
        } else if (c == ')' || c == ']') {
            openParentheses--;
        }

        if (c == '"' && opStr[i - 1] != '\\') {
            inQuotes = !inQuotes;
        }

        if (iswspace(c) && openParentheses == 0 && !inQuotes && !isBlank(ss.str())) {
            result.push_back(ss.str());
            ss.str("");
        } else {
            ss << c;
        }
    }

    if (!isBlank(ss.str())) {
        result.push_back(ss.str());
    }

    return result;
}

/** Parses the given type string into an MLIR type Form (F16) or (Complex <type>) */
mlir::Type Egglog::parseType(std::string typeStr) {
    std::vector<std::string> split = splitExpression(typeStr);

    std::string type = split[0];
    if (type == "F16") {
        return mlir::FloatType::getF16(&context);
    } else if (type == "F32") {
        return mlir::FloatType::getF32(&context);
    } else if (type == "F64") {
        return mlir::FloatType::getF64(&context);
    } else if (type == "F80") {
        return mlir::FloatType::getF80(&context);
    } else if (type == "F128") {
        return mlir::FloatType::getF128(&context);
    } else if (type == "I1") {
        return mlir::IntegerType::get(&context, 1);
    } else if (type == "I8") {
        return mlir::IntegerType::get(&context, 8);
    } else if (type == "I16") {
        return mlir::IntegerType::get(&context, 16);
    } else if (type == "I32") {
        return mlir::IntegerType::get(&context, 32);
    } else if (type == "I64") {
        return mlir::IntegerType::get(&context, 64);
    } else if (type == "Int") {
        return mlir::IntegerType::get(&context, std::stoll(split[1]), mlir::IntegerType::SignednessSemantics::Signless);
    } else if (type == "SInt") {
        return mlir::IntegerType::get(&context, std::stoll(split[1]), mlir::IntegerType::SignednessSemantics::Signed);
    } else if (type == "UInt") {
        return mlir::IntegerType::get(&context, std::stoll(split[1]), mlir::IntegerType::SignednessSemantics::Unsigned);
    } else if (type == "OtherInt") {
        return mlir::parseType(unwrap(split[1], '"'), &context);
    } else if (type == "Index") {
        return mlir::IndexType::get(&context);
    } else if (type == "None") {
        return mlir::NoneType::get(&context);
    } else if (type == "Complex") {
        mlir::Type elementType = parseType(split[1]);
        return mlir::ComplexType::get(elementType);
    } else if (type == "Tuple") {  // (Tuple (vec-of <type1> <type2> ... <typeN>))
        std::string typeVec = split[1];
        std::vector<mlir::Type> types;

        std::vector<std::string> typeSplit = splitExpression(typeVec);
        for (size_t i = 1; i < typeSplit.size(); i++) {
            types.push_back(parseType(typeSplit[i]));
        }

        return mlir::TupleType::get(&context, types);
    } else if (type == "OtherType") {
        return mlir::parseType(unwrap(split[1], '"'), &context);
    } else if (egglogCustom.typeParsers.find(type) != egglogCustom.typeParsers.end()) {
        TypeParseFunction parseFunc = egglogCustom.typeParsers.at(type);
        return parseFunc(split, *this);
    } else {
        llvm::outs() << "Unsupported type: " << type << "\n";
        exit(1);
    }
}

std::string Egglog::eggifyType(mlir::Type type) {
    std::string egglogCode;
    llvm::raw_string_ostream ss(egglogCode);

    std::string typeStr = type.getAbstractType().getName().str();
    if (type.isF16()) {
        ss << "(F16)";
    } else if (type.isF32()) {
        ss << "(F32)";
    } else if (type.isF64()) {
        ss << "(F64)";
    } else if (type.isF80()) {
        ss << "(F80)";
    } else if (type.isF128()) {
        ss << "(F128)";
    } else if (type.isInteger(1)) {
        ss << "(I1)";
    } else if (type.isInteger(4)) {
        ss << "(I4)";
    } else if (type.isInteger(8)) {
        ss << "(I8)";
    } else if (type.isInteger(16)) {
        ss << "(I16)";
    } else if (type.isInteger(32)) {
        ss << "(I32)";
    } else if (type.isInteger(64)) {
        ss << "(I64)";
    } else if (type.isa<mlir::IntegerType>()) {
        mlir::IntegerType intType = type.cast<mlir::IntegerType>();
        size_t width = intType.getWidth();

        if (intType.isSignless()) {
            ss << "(Int" << width << ")";
        } else if (intType.isSigned()) {
            ss << "(SInt" << width << ")";
        } else if (intType.isUnsigned()) {
            ss << "(UInt" << width << ")";
        } else {
            ss << "(OtherInt \"" << type << "\")";
        }
    } else if (type.isIndex()) {
        ss << "(Index)";
    } else if (type.isa<mlir::NoneType>()) {
        ss << "(None)";
    } else if (type.isa<mlir::ComplexType>()) {
        ss << "(Complex " << type.cast<mlir::ComplexType>().getElementType() << ")";
    } else if (type.isa<mlir::TupleType>()) {
        mlir::TupleType tupleType = type.cast<mlir::TupleType>();
        ss << "(TupleType (";
        for (mlir::Type element: tupleType.getTypes()) {
            ss << " " << eggifyType(element);
        }
        ss << "))";
    } else if (egglogCustom.typeStringifiers.find(typeStr) != egglogCustom.typeStringifiers.end()) {  // custom type by user
        TypeStringifyFunction stringifyFunc = egglogCustom.typeStringifiers.at(typeStr);
        std::vector<std::string> split = stringifyFunc(type, *this);
        assert(split.size() > 0);

        ss << "(" << split[0];
        for (size_t i = 1; i < split.size(); i++) {
            ss << " " << split[i];
        }
        ss << ")";
    } else {
        ss << "(OtherType \"" << type << "\" \"" << typeStr << "\")";
    }

    ss.flush();
    return egglogCode;
}

/** Parses the given attribute string into an MLIR named attribute. Form (NamedAttr "<name>" <attr>) */
mlir::NamedAttribute Egglog::parseNamedAttribute(const std::string& attrStr) {
    std::vector<std::string> split = splitExpression(attrStr);

    mlir::StringAttr attrName = mlir::StringAttr::get(&context, unwrap(split[1], '"'));
    mlir::Attribute attr = parseAttribute(split[2]);
    return mlir::NamedAttribute(attrName, attr);
}
std::string Egglog::eggifyNamedAttribute(mlir::NamedAttribute namedAttr) {
    // (NamedAttr "<name>" <attr>)

    std::stringstream ss;

    ss << "(NamedAttr \"" << namedAttr.getName().str() << "\" ";  // name
    ss << eggifyAttribute(namedAttr.getValue()) << ")";           // value

    return ss.str();
}

/** Parses the given attribute string into an MLIR attribute. Form (<type> <arg1> <arg2> ... <argN>) */
mlir::Attribute Egglog::parseAttribute(const std::string& attrStr) {
    std::vector<std::string> split = splitExpression(attrStr);

    std::string attrType = split[0];
    if (attrType == "IntegerAttr") {
        return mlir::IntegerAttr::get(parseType(split[2]), std::stoll(split[1]));
    } else if (attrType == "FloatAttr") {
        return mlir::FloatAttr::get(parseType(split[2]), std::stod(split[1]));
    } else if (attrType == "StringAttr") {
        return mlir::parseAttribute(split[1], &context);
    } else if (attrType == "UnitAttr") {
        return mlir::UnitAttr::get(&context);
    } else if (attrType == "TypeAttr") {
        return mlir::TypeAttr::get(parseType(split[1]));
    } else if (attrType == "ArrayAttr") {  // (ArrayAttr (vec-of <attr1> <attr2> ... <attrN>))
        std::vector<mlir::Attribute> elements;
        std::vector<std::string> arraySplit = splitExpression(split[1]);
        for (size_t i = 1; i < arraySplit.size(); i++) {
            elements.push_back(parseAttribute(arraySplit[i]));
        }
        return mlir::ArrayAttr::get(&context, elements);
    } else if (attrType == "DenseIntArrayAttr") {  // (DenseIntArrayAttr N (vec-of <int1> <int2> ... <intN>) <type>)
        int64_t size = std::stoll(split[1]);
        std::vector<int64_t> values;
        std::vector<std::string> arraySplit = splitExpression(split[2]);
        for (size_t i = 1; i < arraySplit.size(); i++) {
            values.push_back(std::stoll(arraySplit[i]));
        }
        mlir::Type type = parseType(split[3]);
        size_t byteWidth = type.getIntOrFloatBitWidth() / 8;
        return mlir::DenseArrayAttr::get(&context, type, size, llvm::ArrayRef<char>(reinterpret_cast<const char*>(values.data()), values.size() * byteWidth));
    } else if (attrType == "DenseFloatArrayAttr") {  // (DenseFloatArrayAttr N (vec-of <float1> <float2> ... <floatN>) <type>)
        int64_t size = std::stoll(split[1]);
        std::vector<double> values;
        std::vector<std::string> arraySplit = splitExpression(split[2]);
        for (size_t i = 1; i < arraySplit.size(); i++) {
            values.push_back(std::stod(arraySplit[i]));
        }
        mlir::Type type = parseType(split[3]);
        return mlir::DenseArrayAttr::get(&context, type, size, llvm::ArrayRef<char>(reinterpret_cast<const char*>(values.data()), values.size() * sizeof(double)));
    } else if (attrType == "DenseIntElementsAttr") {  // (DenseIntElementsAttr (vec-of <int1> <int2> ... <intN>) <type>)
        std::vector<int64_t> values;
        std::vector<std::string> arraySplit = splitExpression(split[1]);
        for (size_t i = 1; i < arraySplit.size(); i++) {
            values.push_back(std::stoll(arraySplit[i]));
        }
        mlir::Type type = parseType(split[2]);
        mlir::ShapedType shapedType = type.cast<mlir::ShapedType>();
        return mlir::DenseIntElementsAttr::get(shapedType, values);
    } else if (attrType == "DenseFPElementsAttr") {  // (DenseFloatElementsAttr (vec-of <float1> <float2> ... <floatN>) <type>)
        std::vector<double> values;
        std::vector<std::string> arraySplit = splitExpression(split[1]);
        for (size_t i = 1; i < arraySplit.size(); i++) {
            values.push_back(std::stod(arraySplit[i]));
        }
        mlir::Type type = parseType(split[2]);
        mlir::ShapedType shapedType = type.cast<mlir::ShapedType>();
        return mlir::DenseFPElementsAttr::get(shapedType, values);
    } else if (attrType == "OtherAttr") {  // TODO add all remaining builtin attrs (check below functions)
        return mlir::parseAttribute(unwrap(split[1], '"'), &context);
    } else if (egglogCustom.attrParsers.find(attrType) != egglogCustom.attrParsers.end()) {
        AttrParseFunction parseFunc = egglogCustom.attrParsers.at(attrType);
        return parseFunc(split, *this);
    } else {
        llvm::outs() << "Unsupported attribute type: " << attrType << "\n";
        exit(1);
    }
}

std::string Egglog::eggifyAttribute(mlir::Attribute attr) {
    std::string egglogCode;
    llvm::raw_string_ostream ss(egglogCode);

    mlir::TypeID typeId = attr.getTypeID();
    std::string typeName = attr.getAbstractAttribute().getName().str();
    if (typeId == mlir::TypeID::get<mlir::IntegerAttr>()) {  // (IntegerAttr <int> <type>)
        mlir::IntegerAttr integerAttr = attr.cast<mlir::IntegerAttr>();
        int64_t value = integerAttr.getInt();
        ss << "(IntegerAttr " << value << " " << eggifyType(integerAttr.getType()) << ")";

    } else if (typeId == mlir::TypeID::get<mlir::FloatAttr>()) {  // (FloatAttr <float> <type>)
        mlir::FloatAttr floatAttr = attr.cast<mlir::FloatAttr>();
        double value = floatAttr.getValueAsDouble();
        ss << "(FloatAttr " << doubleToString(value) << " " << eggifyType(floatAttr.getType()) << ")";

    } else if (typeId == mlir::TypeID::get<mlir::StringAttr>()) {  // (StringAttr "<string>">)
        mlir::StringAttr stringAttr = attr.cast<mlir::StringAttr>();
        std::string value = stringAttr.getValue().str();
        ss << "(StringAttr \"" << value << "\")";

    } else if (typeId == mlir::TypeID::get<mlir::ArrayAttr>()) {  // (ArrayAttr (vec-of <attr1> <attr2> ... <attrN>))
        mlir::ArrayAttr arrayAttr = attr.cast<mlir::ArrayAttr>();
        ss << "(ArrayAttr (";

        if (arrayAttr.empty()) {
            ss << "vec-empty";
        } else {
            ss << "vec-of";
            for (mlir::Attribute element: arrayAttr) {
                ss << " " << eggifyAttribute(element);
            }
        }
        ss << "))";

    } else if (typeId == mlir::TypeID::get<mlir::TypeAttr>()) {  // (TypeAttr "<type>")
        mlir::TypeAttr typeAttr = attr.cast<mlir::TypeAttr>();
        mlir::Type type = typeAttr.getValue();
        ss << "(TypeAttr " << eggifyType(type) << ")";

    } else if (typeId == mlir::TypeID::get<mlir::UnitAttr>()) {  // (UnitAttr)
        ss << "(UnitAttr)";

    } else if (typeId == mlir::TypeID::get<mlir::DenseArrayAttr>()) {
        mlir::DenseArrayAttr denseArrayAttr = attr.cast<mlir::DenseArrayAttr>();
        llvm::ArrayRef<char> rawData = denseArrayAttr.getRawData();
        mlir::Type elementType = denseArrayAttr.getElementType();
        size_t size = denseArrayAttr.size();

        // if Int type, then it is a DenseIntArrayAttr
        // if Float type, then it is a DenseFloatArrayAttr

        if (elementType.isa<mlir::IntegerType>()) {
            llvm::ArrayRef<int64_t> values(reinterpret_cast<const int64_t*>(rawData.data()), size);
            ss << "(DenseIntArrayAttr " << size << " (vec-of";
            for (int64_t value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(elementType) << ")";
        } else if (elementType.isa<mlir::FloatType>()) {
            llvm::ArrayRef<double> values(reinterpret_cast<const double*>(rawData.data()), size);
            ss << "(DenseFloatArrayAttr " << size << " (vec-of";
            for (double value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(elementType) << ")";
        }

    } else if (typeId == mlir::TypeID::get<mlir::DenseIntOrFPElementsAttr>()) {
        mlir::DenseIntOrFPElementsAttr denseIntOrFPAttr = attr.cast<mlir::DenseIntOrFPElementsAttr>();
        mlir::Type elementType = denseIntOrFPAttr.getElementType();
        mlir::ShapedType shapedType = denseIntOrFPAttr.getType();

        if (elementType.isa<mlir::IntegerType>()) {
            auto values = denseIntOrFPAttr.getValues<int64_t>();  // TODO this assumes always 8 bytes per int (WRONG)
            ss << "(DenseIntElementsAttr (vec-of";
            for (int64_t value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(shapedType) << ")";
        } else if (elementType.isa<mlir::FloatType>()) {
            auto values = denseIntOrFPAttr.getValues<double>();  // TODO this assumes always 8 bytes per double (WRONG)
            ss << "(DenseFPElementsAttr (vec-of";
            for (double value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(shapedType) << ")";
        }

    } else if (egglogCustom.attrStringifiers.find(typeName) != egglogCustom.attrStringifiers.end()) {  // custom attr by user
        AttrStringifyFunction stringifyFunc = egglogCustom.attrStringifiers.at(typeName);
        std::vector<std::string> split = stringifyFunc(attr, *this);
        assert(split.size() > 0);

        ss << "(" << split[0];
        for (size_t i = 1; i < split.size(); i++) {
            ss << " " << split[i];
        }
        ss << ")";

    } else {  // (OtherAttr "<attr>" "<type-name>")
        ss << "(OtherAttr \"";
        attr.print(ss);
        ss << "\" \"" << typeName << "\")";
    }

    // TODO add DenseResourceElementsAttr
    // TODO add DenseStringElementsAttr
    // TODO add DictionaryAttr
    // TOOD add IntegerSetAttr
    // TODO add OpaqueAttr
    // TODO add SparseElementsAttr
    // TODO add SymbolRefAttr
    // TODO add StridedLayoutAttr

    ss.flush();

    // replace ".000000e+00" with "."
    // std::string::size_type n = 0;
    // while ((n = egglogCode.find(".000000e+00", n)) != std::string::npos) {
    //     egglogCode.replace(n, 11, ".0");
    // }

    return egglogCode;
}

mlir::Value Egglog::parseValue(const std::string& valueStr) {
    std::vector<std::string> split = splitExpression(valueStr);
    assert(split[0] == "Value");

    size_t id = std::stoll(split[1]);
    std::optional<EggifiedOp> eggifiedOp = findEggifiedOp(id);
    if (!eggifiedOp.has_value()) {
        llvm::outs() << "Value " << id << " not found\n";
        exit(1);
    }

    return eggifiedOp.value().mlirValue;
}

mlir::Operation* Egglog::parseOperation(const std::string& newOpStr, mlir::OpBuilder& builder) {
    llvm::outs() << "PARSING OPERATION: " << newOpStr << "\n";

    // if the string is found, then it is an existing operation
    std::optional<EggifiedOp> eggifiedOp = findEggifiedOp(newOpStr);
    if (eggifiedOp.has_value()) {
        llvm::outs() << "FOUND EGGIFIED OP: " << eggifiedOp.value().egglogOp << "\n";
        return eggifiedOp.value().mlirOp;
        // TODO the better way of doing this would be to have an AST-like structure for the egglog ops
    }

    // otherwise look in the parsed ops cache
    if (parsedOps.find(newOpStr) != parsedOps.end()) {
        llvm::outs() << "FOUND OPERATION IN CACHE: " << newOpStr << "\n";
        return parsedOps[newOpStr];
        // TODO the better way of doing this would be to have an AST-like structure for the egglog ops
    }

    std::vector<std::string> split = splitExpression(newOpStr);
    std::string opName = split[0];

    std::replace(opName.begin(), opName.end(), '_', '.');  // Replace underscores with dots
    EgglogOpDef egglogOpDef = egglogOps.at(opName);

    // Operands
    std::vector<mlir::Value> operands;
    for (size_t i = 0; i < egglogOpDef.nOperands; i++) {
        std::string operandStr = split[i + 1];

        if (operandStr.find("(Value ") == 0) {
            mlir::Value operand = parseValue(operandStr);
            operands.push_back(operand);
        } else { // new operation
            mlir::Operation* nestedOperand = parseOperation(operandStr, builder);
            mlir::Value operand = nestedOperand->getResult(0);  // TODO support multiple results?
            operands.push_back(operand);
        }
    }

    // attr
    std::vector<mlir::NamedAttribute> attributes;
    for (size_t i = 0; i < egglogOpDef.nAttributes; i++) {
        mlir::NamedAttribute attr = parseNamedAttribute(split[i + egglogOpDef.nOperands + 1]);
        attributes.push_back(attr);
    }

    // Return type
    mlir::Type type = parseType(split.back());

    // Create the operation
    mlir::Operation* newOp = nullptr;

    if (opName.find("linalg.") == 0) {  // custom ops
        std::string op = opName.substr(7);
        if (op == "transpose") {
            mlir::Attribute attr = attributes[0].getValue();
            newOp = builder.create<mlir::linalg::TransposeOp>(mlir::UnknownLoc::get(&context), operands[0], operands[1], attr.cast<mlir::DenseI64ArrayAttr>());
        } else if (op == "matmul") {
            newOp = builder.create<mlir::linalg::MatmulOp>(mlir::UnknownLoc::get(&context), operands[2].getType(), llvm::ArrayRef<mlir::Value> {operands[0], operands[1]}, operands[2]);
        }
    } else {  // other ops that have no hidden region, thus are easy to create with OperationState
        mlir::OperationState state(mlir::UnknownLoc::get(&context), opName);
        state.addOperands(operands);
        state.addAttributes(attributes);
        state.addTypes(type);

        newOp = builder.create(state);
    }

    parsedOps[newOpStr] = newOp;
    return newOp;
}

EggifiedOp Egglog::eggifyValue(mlir::Value value) {
    // (Value <id> <type>)
    std::optional<EggifiedOp> eggifiedOp = findEggifiedOp(value);
    if (eggifiedOp.has_value()) {
        return eggifiedOp.value();
    }

    std::string type = eggifyType(value.getType());
    size_t id = nextId();
    std::string egglogOp = "(Value " + std::to_string(id) + " " + type + ")";

    EggifiedOp eggifiedValue(id, egglogOp, value);
    eggifiedBlock.push_back(eggifiedValue);
    return eggifiedValue;
}

EggifiedOp Egglog::eggifyOperation(mlir::Operation* op) {
    // (<op> <operand1> <operand2> ... <operandN> <attr1> <attr2> ... <attrM> <block> <type>)

    std::optional<EggifiedOp> eggifiedOpOpt = findEggifiedOp(op);
    if (eggifiedOpOpt.has_value()) {
        return eggifiedOpOpt.value();
    }

    std::string opName = op->getName().getStringRef().str();
    bool isSupported = egglogOps.find(opName) != egglogOps.end();

    if (!isSupported) {
        llvm::outs() << "Unsupported operation '" << opName << "' but using the result as a variable.\n";
        return eggifyValue(op->getResult(0));
    }

    EgglogOpDef egglogOpDef = egglogOps.at(opName);

    op->removeAttr("linalg.memoized_indexing_maps");

    std::stringstream ss;

    std::string cleanOpName = opName;
    std::replace(cleanOpName.begin(), cleanOpName.end(), '.', '_');

    ss << "(" << cleanOpName;  // (<op>

    // <operand1> <operand2> ... <operandN>
    std::vector<EggifiedOp> operands;
    for (mlir::Value operand: op->getOperands()) {
        EggifiedOp eggifiedOperand = eggifyValue(operand);
        operands.push_back(eggifiedOperand);
        ss << " " << eggifiedOperand.getPrintId();
    }

    // <attr1> <attr2> ... <attrM>
    for (const mlir::NamedAttribute& attr: op->getAttrs()) {
        ss << " " << eggifyNamedAttribute(attr);
    }

    ss << " ";

    // block - WE ONLY SUPPORT OPERATIONS WITH A SINGLE BLOCK IN THEIR REGION
    if (op->getNumRegions() == 1 && op->getRegion(0).hasOneBlock() && (egglogOpDef.dialect != "linalg" || egglogOpDef.fullName == "linalg.generic")) {
        ss << eggifyBlock(op->getRegion(0).front());
    }

    // <type>
    ss << eggifyType(op->getResult(0).getType());

    ss << ")";

    EggifiedOp eggifiedOp(nextId(), ss.str(), operands, op);
    eggifiedBlock.push_back(eggifiedOp);
    return eggifiedOp;
}

std::vector<EggifiedOp> Egglog::eggifyOperations(const std::vector<mlir::Operation*>& ops) {
    std::vector<EggifiedOp> eggifiedOps;
    for (mlir::Operation* op: ops) {
        eggifiedOps.push_back(eggifyOperation(op));
    }
    return eggifiedOps;
}

std::string Egglog::eggifyBlock(mlir::Block& block) {
    std::stringstream ss;

    mlir::Block::OpListType& ops = block.getOperations();

    ss << "(vec-of";
    for (mlir::Operation& op: ops) {
        ss << " " << eggifyOperation(&op).egglogOp;
    }
    ss << ")";
    return ss.str();
}

std::optional<EggifiedOp> Egglog::findEggifiedOp(mlir::Operation* op) {
    for (EggifiedOp& eggifiedOp: eggifiedBlock) {
        if (eggifiedOp.mlirOp == op) {
            return std::optional<EggifiedOp>(eggifiedOp);
        }
    }
    return std::nullopt;
}
std::optional<EggifiedOp> Egglog::findEggifiedOp(mlir::Value value) {
    for (EggifiedOp& eggifiedOp: eggifiedBlock) {
        if (eggifiedOp.mlirValue == value) {
            return std::optional<EggifiedOp>(eggifiedOp);
        }
    }
    return std::nullopt;
}
std::optional<EggifiedOp> Egglog::findEggifiedOp(size_t id) {
    for (EggifiedOp& eggifiedOp: eggifiedBlock) {
        if (eggifiedOp.id == id) {
            return std::optional<EggifiedOp>(eggifiedOp);
        }
    }
    return std::nullopt;
}
std::optional<EggifiedOp> Egglog::findEggifiedOp(const std::string& egglogOp) {
    for (EggifiedOp& eggifiedOp: eggifiedBlock) {
        if (eggifiedOp.egglogOp == egglogOp) {
            return std::optional<EggifiedOp>(eggifiedOp);
        } else if (eggifiedOp.inlinedEgglogOp() == egglogOp) {
            return std::optional<EggifiedOp>(eggifiedOp);
        }
    }
    return std::nullopt;
}