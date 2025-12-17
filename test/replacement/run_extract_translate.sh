#!/bin/bash

design_name="comparator_4bit"

export PATH=/work/global/aspen/extraction-gym/target/debug:/work/global/aspen/dialegg-deps/egglog/target/release:/work/global/aspen/circt/build/bin:/work/global/aspen/dialegg/build-release:$PATH

extract_result ${design_name}.egraph.json > ${design_name}_extracted.txt

# reconstruct
timeout 120 egg-opt --reconstruct-from-extraction \
    --extraction-file=${design_name}_extracted.txt \
    --egg-file=${design_name}.egg \
    ${design_name}.mlir \
    -o ${design_name}_optimized.mlir

# # Step 3: Generate optimized Verilog from MLIR
circt-opt --lower-seq-to-sv ${design_name}_optimized.mlir | circt-opt --export-split-verilog --prettify-verilog --hw-cleanup

cp ${design_name}.sv ${design_name}_optimized.v

echo "[DOCKER] Optimized Verilog for ${design_name} is saved to ${design_name}_optimized.v"