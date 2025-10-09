#!/bin/bash

# Setup script for DialEgg
# This script sets up the environment and builds DialEgg

echo "🔄 Configuring DialEgg to use CIRCT's LLVM (version alignment)"
echo "=============================================================="

# Use CIRCT's LLVM instead of standalone build for version alignment
export LLVM_DIR=/work/global/aspen/circt/llvm
export BUILD_DIR=$LLVM_DIR/build
export STABLEHLO_DIR=/work/global/aspen/dialegg-deps/stablehlo

echo "📋 LLVM Version Alignment:"
echo "- CIRCT LLVM: 22.0.0git (target)"
echo "- DialEgg LLVM: Will use CIRCT's LLVM"
echo "- Path: $BUILD_DIR"
echo ""

# Check if CIRCT's LLVM build exists
if [ ! -f "$BUILD_DIR/lib/cmake/llvm/LLVMConfig.cmake" ]; then
    echo "❌ Error: CIRCT's LLVM build not found!"
    echo "Expected: $BUILD_DIR/lib/cmake/llvm/LLVMConfig.cmake"
    echo ""
    echo "Please ensure CIRCT is properly built with its LLVM."
    exit 1
fi

echo "✅ CIRCT's LLVM build found"

# Check if StableHLO directory exists (optional - we're not using it)
if [ ! -d "$STABLEHLO_DIR" ]; then
    echo "⚠️  StableHLO directory not found at $STABLEHLO_DIR (optional)"
else
    echo "✅ StableHLO directory found (optional)"
fi

echo ""
echo "🔧 Building DialEgg with CIRCT's LLVM..."

# Clean previous build to avoid conflicts
rm -rf build-release
mkdir -p build-release

# Build DialEgg with CIRCT's LLVM
cmake -S . -B build-release \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR=$BUILD_DIR/lib/cmake/llvm \
    -DMLIR_DIR=$BUILD_DIR/lib/cmake/mlir

if [ $? -ne 0 ]; then
    echo "❌ Error: CMake configuration failed!"
    echo ""
    echo "This might be due to:"
    echo "- CIRCT's LLVM build incomplete"
    echo "- Version conflicts"
    echo "- Missing dependencies"
    exit 1
fi

echo "✅ CMake configuration succeeded"
echo ""
echo "🔨 Building DialEgg..."
cmake --build build-release

if [ $? -ne 0 ]; then
    echo "❌ Error: DialEgg build failed!"
    exit 1
fi

echo ""
echo "🎉 SUCCESS! DialEgg built with CIRCT's LLVM"
echo "==========================================="
echo ""
echo "📊 Version Alignment Achieved:"
echo "- CIRCT LLVM: 22.0.0git"  
echo "- DialEgg LLVM: 22.0.0git (same as CIRCT)"
echo ""
echo "🚀 Ready for native HW/Comb dialect support!"
echo ""
echo "To test native support:"
echo "  export PATH=\"/work/global/nz264/dialegg-deps/egglog/target/release:\$PATH\""
echo "  ./build-release/egg-opt --eq-sat --egg-file=circt-test/hw_comb_native.egg circt-test/simple_hw_test.mlir"
echo ""
echo "Or use the existing conversion pipeline:"
echo "  cd circt-test && ./complete_roundtrip.sh" 