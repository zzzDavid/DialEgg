#include "mlir/IR/Value.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Builders.h"
#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/IR/LinalgInterfaces.h"
#include "mlir/Dialect/Arith/IR/Arith.h"

#include "Egglog.h"
#include "Utils.h"

std::vector<std::string> Egglog::splitExpression(std::string opStr) {
    // The expression must be surrounded by parentheses
    if (opStr.front() != '(' || opStr.back() != ')') {
        llvm::outs() << "Invalid expression: " << opStr << "\n";
        exit(1);
    }

    mlir::linalg::MatmulOp

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
    } else if (customFunctions.typeParsers.find(type) != customFunctions.typeParsers.end()) {
        TypeParseFunction parseFunc = customFunctions.typeParsers.at(type);
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
    } else if (customFunctions.typeStringifiers.find(typeStr) != customFunctions.typeStringifiers.end()) {  // custom type by user
        TypeStringifyFunction stringifyFunc = customFunctions.typeStringifiers.at(typeStr);
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
        return mlir::DenseArrayAttr::get(&context, type, size, llvm::ArrayRef<char>(reinterpret_cast<const char*>(values.data()), values.size() * sizeof(int64_t)));
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
    } else if (customFunctions.attrParsers.find(attrType) != customFunctions.attrParsers.end()) {
        AttrParseFunction parseFunc = customFunctions.attrParsers.at(attrType);
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
        ss << "(FloatAttr " << value << " " << eggifyType(floatAttr.getType()) << ")";

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
            auto values = denseIntOrFPAttr.getValues<int64_t>();
            ss << "(DenseIntElementsAttr (vec-of";
            for (int64_t value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(shapedType) << ")";
        } else if (elementType.isa<mlir::FloatType>()) {
            auto values = denseIntOrFPAttr.getValues<double>();
            ss << "(DenseFPElementsAttr (vec-of";
            for (double value: values) {
                ss << " " << value;
            }
            ss << ") " << eggifyType(shapedType) << ")";
        }

    } else if (customFunctions.attrStringifiers.find(typeName) != customFunctions.attrStringifiers.end()) {  // custom attr by user
        AttrStringifyFunction stringifyFunc = customFunctions.attrStringifiers.at(typeName);
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

    // TODO add DenseArrayAttr
    // TODO add DenseIntOrFPElementsAttr
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

/**
 * Parses the given operation string into a list of MLIR operations, in order or dependency.
 * Example:
 *      (linalg_transpose (tensor_empty "tensor<3x2xf32>") (tensor_empty "tensor<2x3xf32>") "tensor<2x3xf32>")
 * Becomes:
 *      %0 = tensor.empty() : tensor<3x2xf32>
 *      %1 = tensor.empty() : tensor<2x3xf32>
 *      %2 = linalg.transpose %0, %1 : tensor<3x2xf32>, tensor<2x3xf32>
 */
mlir::Operation* Egglog::parseOperation(const std::string& newOpStr, mlir::OpBuilder& builder) {
    std::vector<std::string> split = splitExpression(newOpStr);

    std::string opName = split[0];
    ssize_t opId = std::stoll(split[1]);

    if (opId >= 0) {
        mlir::Operation* rep = ops[opId]->replacementOp;
        if (rep != nullptr) {
            return rep;
        } else {
            return ops[opId]->mlirOp;
        }
    }

    std::replace(opName.begin(), opName.end(), '_', '.');  // Replace underscores with dots
    EqSatOpInfo opInfo = opRegistry.at(opName);

    // Operands
    std::vector<mlir::Value> operands;
    for (ssize_t i = 0; i < opInfo.nOperands; i++) {
        std::string operandStr = split[i + 2];
        ssize_t operandId = nextOperationId(operandStr);

        llvm::outs() << "PARSING OPERAND: " << operandStr << " ID: " << operandId << "\n";

        if (operandStr.find("(NamedOp ") == 0) {
            EqSatOp* eqSatOperand = ops[operandId];
            operands.push_back(eqSatOperand->resultValue);
        } else if (operandId < 0) {  // new operation
            mlir::Operation* nestedOperand = parseOperation(operandStr, builder);
            mlir::Value operand = nestedOperand->getResult(0);  // TODO support multiple results?
            operands.push_back(operand);
        } else {  // existing operation, refered to by id
            mlir::Value operandReplacement = ops[operandId]->replacementOp->getResult(0);
            operands.push_back(operandReplacement);
        }
    }

    // attr
    std::vector<mlir::NamedAttribute> attributes;
    for (size_t i = 0; i < opInfo.attributes.size(); i++) {
        mlir::NamedAttribute attr = parseNamedAttribute(split[i + opInfo.nOperands + 2]);
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
        }
    } else {  // other ops that have no hidden region, thus are easy to create with OperationState
        mlir::OperationState state(mlir::UnknownLoc::get(&context), opName);
        state.addOperands(operands);
        state.addAttributes(attributes);
        state.addTypes(type);

        newOp = builder.create(state);
    }

    return newOp;
}

std::string Egglog::eggifyOperationWithLet(const EqSatOp& op) {
    // (let <resultId> <egglog>)
    std::stringstream ss;
    ss << "(let " << op.getPrintId() << " " << eggifyOperation(op) << ")";
    return ss.str();
}

std::string Egglog::eggifyOperation(const EqSatOp& op) {
    // (<op> <id> <operand1> <operand2> ... <operandN> <attr1> <attr2> ... <attrM> "<type>")

    std::stringstream ss;

    if (op.opaque) {
        ss << "(NamedOp " << op.id << " " << eggifyType(op.resultValue.getType()) << ")";
        return ss.str();
    }

    std::string cleanName = op.name;
    std::replace(cleanName.begin(), cleanName.end(), '.', '_');

    ss << "(";

    // Operation <op> <id>
    ss << cleanName << " " << op.id;

    // Operands <operand1> <operand2> ... <operandN>
    for (const EqSatOp* operand: op.operands) {
        ss << " " << operand->getPrintId();
    }

    // Attributes <attr1> <attr2> ... <attrM>
    if (op.mlirOp != nullptr) {
        for (const mlir::NamedAttribute& attr: op.mlirOp->getAttrs()) {
            ss << " " << eggifyNamedAttribute(attr);
        }
    }

    ss << " ";

    // Type "<type>"
    ss << eggifyType(op.resultValue.getType());

    ss << ")";

    return ss.str();
}