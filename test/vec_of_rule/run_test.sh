#!/bin/bash

design_name="vec_of_rule"

echo "🔧 Running egglog optimization for ${design_name}..."
egg-opt --eggify-only --egg-file=${design_name}.egg ${design_name}.mlir -o ${design_name}_optimized.mlir

echo "🔍 Finding root eclasses..."
python3 find_root_eclasses.py ${design_name}

echo "📤 Extracting results..."
extract_result ${design_name}.updated.json > ${design_name}_extracted.txt

echo "🔨 Reconstructing from extraction..."
egg-opt --reconstruct-from-extraction \
    --extraction-file=${design_name}_extracted.txt \
    --egg-file=${design_name}.egg \
    ${design_name}.mlir \
    -o ${design_name}_optimized.mlir

echo "✅ Egglog optimization completed!"
echo ""
echo "ℹ️  Note: The extractor picks original concat due to equal costs (see EXTRACTION_COSTS.md)"
echo "    Both versions exist in the e-graph and reconstruction works (verified below)"
echo ""
echo "🔍 Running verification..."
python3 verify_test.py

echo ""
echo "🎯 Demonstrating reconstruction with swapped version:"
echo "   Using manually specified extraction (vec_of_rule_extracted_fixed.txt)"
egg-opt --reconstruct-from-extraction \
    --extraction-file=vec_of_rule_extracted_fixed.txt \
    --egg-file=vec_of_rule.egg \
    vec_of_rule.mlir \
    -o vec_of_rule_fixed.mlir 2>&1 | grep -E "(Reconstruction|Egglog)"

echo ""
echo "📄 Result (operands are swapped!):"
grep "comb.concat" vec_of_rule_fixed.mlir
