#!/bin/bash

# Convenient wrapper script for running DialEgg
# Usage: ./run_dialegg.sh <mlir_file> <egg_file>

# Add egglog to PATH
export PATH="/work/global/nz264/dialegg-deps/egglog/target/release:$PATH"

# Check if we have the required arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <mlir_file> <egg_file>"
    echo ""
    echo "Example:"
    echo "  $0 test/classic/classic.mlir test/classic/classic.egg"
    exit 1
fi

MLIR_FILE=$1
EGG_FILE=$2

# Check if files exist
if [ ! -f "$MLIR_FILE" ]; then
    echo "Error: MLIR file '$MLIR_FILE' not found!"
    exit 1
fi

if [ ! -f "$EGG_FILE" ]; then
    echo "Error: Egg file '$EGG_FILE' not found!"
    exit 1
fi

echo "🚀 Running DialEgg equality saturation..."
echo "MLIR file: $MLIR_FILE"
echo "Egg file: $EGG_FILE"
echo ""

# Run DialEgg
./build-release/egg-opt --eq-sat --egg-file="$EGG_FILE" "$MLIR_FILE" 