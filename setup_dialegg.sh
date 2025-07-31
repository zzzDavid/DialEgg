#!/bin/bash

# Setup script for DialEgg
# This script sets up the environment and builds DialEgg

# Set LLVM, MLIR, and StableHLO directories
export LLVM_DIR=/work/global/nz264/dialegg-deps/llvm
export BUILD_DIR=$LLVM_DIR/build-release
export STABLEHLO_DIR=/work/global/nz264/dialegg-deps/stablehlo

# Check if LLVM build is complete
if [ ! -f "$BUILD_DIR/lib/cmake/llvm/LLVMConfig.cmake" ]; then
    echo "Error: LLVM build is not complete yet!"
    echo "Please wait for LLVM to finish building, then run this script again."
    echo "You can check build progress with:"
    echo "  ls -la $BUILD_DIR/lib/"
    exit 1
fi

# Check if StableHLO directory exists
if [ ! -d "$STABLEHLO_DIR" ]; then
    echo "Error: StableHLO directory not found at $STABLEHLO_DIR!"
    echo "Please clone StableHLO first:"
    echo "  cd ../dialegg-deps && git clone https://github.com/openxla/stablehlo.git"
    exit 1
fi

echo "LLVM build found, proceeding with DialEgg build..."

# Build DialEgg in release mode with explicit paths
mkdir -p build-release

cmake -S . -B build-release \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR=$BUILD_DIR/lib/cmake/llvm \
    -DMLIR_DIR=$BUILD_DIR/lib/cmake/mlir \
    -DSTABLEHLO_DIR=$STABLEHLO_DIR

cmake --build build-release

echo ""
echo "🎉 DialEgg build complete!"
echo ""
echo "To use DialEgg, add egglog to your PATH:"
echo "  export PATH=\"/work/global/nz264/dialegg-deps/egglog/target/release:\$PATH\""
echo ""
echo "Then test with the classic example:"
echo "  ./build-release/egg-opt --eq-sat --egg-file=test/classic/classic.egg test/classic/classic.mlir"
echo ""
echo "Expected output: The function should be optimized from (a * 2) / 2 to just returning a" 