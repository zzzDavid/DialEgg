#!/bin/bash

# Script to check LLVM build progress

LLVM_DIR=/work/global/nz264/dialegg-deps/llvm
BUILD_DIR=$LLVM_DIR/build-release

echo "Checking LLVM build progress..."
echo "Build directory: $BUILD_DIR"
echo ""

if [ ! -d "$BUILD_DIR" ]; then
    echo "Error: Build directory does not exist!"
    exit 1
fi

echo "Build directory contents:"
ls -la $BUILD_DIR/ | head -20
echo ""

echo "Number of libraries built:"
if [ -d "$BUILD_DIR/lib" ]; then
    lib_count=$(find $BUILD_DIR/lib -name "*.a" -o -name "*.so" 2>/dev/null | wc -l)
    echo "  Static/Dynamic libraries: $lib_count"
    
    mlir_count=$(find $BUILD_DIR/lib -name "*MLIR*" 2>/dev/null | wc -l)
    echo "  MLIR libraries: $mlir_count"
else
    echo "  lib directory not created yet"
fi

echo ""
echo "Key files status:"
if [ -f "$BUILD_DIR/lib/cmake/llvm/LLVMConfig.cmake" ]; then
    echo "  ✓ LLVMConfig.cmake exists"
else
    echo "  ✗ LLVMConfig.cmake missing"
fi

if [ -f "$BUILD_DIR/lib/cmake/mlir/MLIRConfig.cmake" ]; then
    echo "  ✓ MLIRConfig.cmake exists"
else
    echo "  ✗ MLIRConfig.cmake missing"
fi

echo ""
echo "Active build processes:"
ps aux | grep -E "(cmake|ninja)" | grep -v grep || echo "  No active build processes"

echo ""
if [ -f "$BUILD_DIR/lib/cmake/llvm/LLVMConfig.cmake" ] && [ -f "$BUILD_DIR/lib/cmake/mlir/MLIRConfig.cmake" ]; then
    echo "✅ LLVM build appears to be COMPLETE!"
    echo "You can now run: ./setup_dialegg.sh"
else
    echo "⏳ LLVM build is still IN PROGRESS..."
    echo "Run this script again to check progress."
fi 