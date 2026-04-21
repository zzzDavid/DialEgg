#!/bin/bash
# Test script for the decoupled extraction workflow

set -e  # Exit on error

echo "=== Testing Decoupled Extraction Workflow ==="
echo ""

# Check if a test file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <mlir-file> [egg-file]"
    echo ""
    echo "Example:"
    echo "  $0 test.mlir test.egg"
    echo ""
    echo "If egg-file is not provided, it will use <mlir-file-name>.egg"
    exit 1
fi

MLIR_FILE="$1"
BASE_NAME="${MLIR_FILE%.mlir}"

if [ -n "$2" ]; then
    EGG_FILE="$2"
else
    EGG_FILE="${BASE_NAME}.egg"
fi

# Verify files exist
if [ ! -f "$MLIR_FILE" ]; then
    echo "❌ Error: MLIR file not found: $MLIR_FILE"
    exit 1
fi

if [ ! -f "$EGG_FILE" ]; then
    echo "❌ Error: Egg file not found: $EGG_FILE"
    exit 1
fi

echo "📄 Input MLIR: $MLIR_FILE"
echo "📄 Egg file: $EGG_FILE"
echo ""

# Step 1: Eggify only
echo "🔧 Step 1: Running eggify-only pass..."
egg-opt --eggify-only --egg-file="$EGG_FILE" "$MLIR_FILE" -o /dev/null

if [ $? -ne 0 ]; then
    echo "❌ Step 1 failed!"
    exit 1
fi

echo "✅ Step 1 completed!"
echo "   Generated files:"
echo "   - ${BASE_NAME}.ops.egg"
echo "   - ${BASE_NAME}.egraph.json"
echo "   - ${BASE_NAME}.extraction-metadata.txt"
echo ""

# Step 2: Simulate extraction (for testing, we'll use egglog's built-in extraction)
echo "🔧 Step 2: Running extraction (simulated with egglog)..."
echo "   Note: In practice, you would run your custom extraction tool here."

# Read metadata to create extraction commands
EXTRACTION_COMMANDS="${BASE_NAME}.extract.egg"
cp "${BASE_NAME}.ops.egg" "$EXTRACTION_COMMANDS"

# Add extraction commands from metadata
echo "" >> "$EXTRACTION_COMMANDS"
echo ";; Extraction commands" >> "$EXTRACTION_COMMANDS"

# Parse metadata and add extraction commands
grep "^op[0-9]" "${BASE_NAME}.extraction-metadata.txt" | while read -r line; do
    OP_ID=$(echo "$line" | awk '{print $1}')
    echo "(extract $OP_ID)" >> "$EXTRACTION_COMMANDS"
done

# Run egglog with extraction
egglog "$EXTRACTION_COMMANDS" > "${BASE_NAME}.extracted.txt" 2> "${BASE_NAME}-extract.log"

if [ $? -ne 0 ]; then
    echo "❌ Extraction failed!"
    cat "${BASE_NAME}-extract.log"
    exit 1
fi

echo "✅ Step 2 completed!"
echo "   Generated: ${BASE_NAME}.extracted.txt"
echo ""

# Step 3: Reconstruct MLIR
echo "🔧 Step 3: Running reconstruction pass..."
egg-opt --reconstruct-from-extraction \
        --extraction-file="${BASE_NAME}.extracted.txt" \
        --egg-file="$EGG_FILE" \
        "$MLIR_FILE" \
        -o "${BASE_NAME}_optimized.mlir"

if [ $? -ne 0 ]; then
    echo "❌ Step 3 failed!"
    exit 1
fi

echo "✅ Step 3 completed!"
echo "   Generated: ${BASE_NAME}_optimized.mlir"
echo ""

echo "=== Workflow Completed Successfully! ==="
echo ""
echo "📊 Summary:"
echo "   Input:  $MLIR_FILE"
echo "   Output: ${BASE_NAME}_optimized.mlir"
echo ""
echo "📁 Intermediate files:"
echo "   - ${BASE_NAME}.ops.egg            (Egglog program)"
echo "   - ${BASE_NAME}.egraph.json        (E-graph JSON)"
echo "   - ${BASE_NAME}.extraction-metadata.txt  (Metadata)"
echo "   - ${BASE_NAME}.extracted.txt      (Extraction results)"
echo ""
echo "🔬 To compare original vs optimized:"
echo "   diff $MLIR_FILE ${BASE_NAME}_optimized.mlir"

