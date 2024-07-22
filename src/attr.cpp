#include "llvm/Support/raw_ostream.h"
#include "mlir/IR/Dialect.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Types.h"
#include "mlir/AsmParser/AsmParser.h"

int main() {
    mlir::DialectRegistry registry;
    mlir::registerAllDialects(registry);

    mlir::MLIRContext context(registry);
    context.loadAllAvailableDialects();

    mlir::Type floatType = mlir::FloatType::getF64(&context);

    // Create an float mlir attribute
    mlir::FloatAttr floatAttr = mlir::FloatAttr::get(mlir::FloatType::getF32(&context), 3.14);
    llvm::outs() << "Float attribute: " << floatAttr << "\n";

    // dense array attr
    llvm::ArrayRef<double> data = llvm::ArrayRef<double>({1.0, 2.0, 3.0});
    llvm::ArrayRef<char> rawData = llvm::ArrayRef<char>(reinterpret_cast<const char*>(data.data()), data.size() * sizeof(double));
    mlir::DenseArrayAttr denseAttr = mlir::DenseArrayAttr::get(floatType, 3, rawData);
    llvm::outs() << "Dense attribute: " << denseAttr << "\n";

    // DenseIntOrFPElementsAttr
    data = llvm::ArrayRef<double>({1.0, 2.0, 3.0, 4.0, 5.0, 6.0});
    rawData = llvm::ArrayRef<char>(reinterpret_cast<const char*>(data.data()), data.size() * sizeof(double));
    mlir::ShapedType shapedType = mlir::RankedTensorType::get({2, 3}, floatType);
    mlir::DenseElementsAttr denseIntOrFPAttr = mlir::DenseIntOrFPElementsAttr::getFromRawBuffer(shapedType, rawData);
    llvm::outs() << "Dense int or fp attribute: " << denseIntOrFPAttr << "\n";

    llvm::outs() << "\n---\n\n";

    // Now try to do the same but backwards, so we parse the attribute instead
    mlir::Attribute parsedAttr = mlir::parseAttribute("3.14", &context);
    mlir::FloatAttr floatAttr2 = parsedAttr.cast<mlir::FloatAttr>();
    llvm::outs() << "Parsed float attribute: " << floatAttr2 << "\n";

    mlir::Attribute parsedAttr2 = mlir::parseAttribute("array<f64: 1., 2., 3.>", &context);
    mlir::DenseArrayAttr denseAttr2 = parsedAttr2.cast<mlir::DenseArrayAttr>();
    llvm::outs() << "Parsed dense array attribute: " << denseAttr2 << "\n";

    mlir::Attribute parsedAttr3 = mlir::parseAttribute("dense<[[1., 2., 3.], [4., 5., 6.]]> : tensor<2x3xf64>", &context);
    mlir::DenseIntOrFPElementsAttr denseIntOrFPAttr3 = parsedAttr3.cast<mlir::DenseIntOrFPElementsAttr>();
    llvm::outs() << "Parsed dense int or fp attribute: " << denseIntOrFPAttr3 << "\n";

    mlir::Attribute parsedAttr4 = mlir::parseAttribute("f64", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr4 << "\n";

    mlir::Attribute parsedAttr5 = mlir::parseAttribute("unit", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr5 << "\n";

    mlir::TypeID typeId = parsedAttr5.getTypeID();
    if (typeId == mlir::TypeID::get<mlir::UnitAttr>()) {
        llvm::outs() << "Parsed type attribute is a unit type\n";
    }

    mlir::Attribute parsedAttr6 = mlir::parseAttribute("\"hello\"", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr6 << "\n";

    mlir::Attribute parsedAttr7 = mlir::parseAttribute("[f16, 3.14, 5, i32, \"string attribute\"]", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr7 << "\n";

    mlir::Attribute parsedAttr8 = mlir::parseAttribute("dense<[[0., 0., 0.], [0., 0., 0.]]> : tensor<2x3xf64>", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr8 << "\n";
    llvm::outs() << "Parsed type attribute: " << parsedAttr8 << " " << parsedAttr8.getAbstractAttribute().getName() << "\n";

    mlir::Attribute parsedAttr9 = mlir::parseAttribute("#arith.fastmath<none>", &context);
    llvm::outs() << "Parsed type attribute: " << parsedAttr9 << " " << parsedAttr9.getAbstractAttribute().getName() << "\n";

    return 0;
}