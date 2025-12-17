#!/bin/bash

design_name="blake2s_G"

export PATH=/work/global/aspen/extraction-gym/target/debug:/work/global/aspen/dialegg-deps/egglog/target/release:/work/global/aspen/circt/build/bin:/work/global/aspen/dialegg/build-release:$PATH

# Step 1: Parse Verilog to MLIR
circt-verilog ${design_name}.v > ${design_name}.mlir

# # Step 2: Run egglog equality saturation
timeout 120 egg-opt --eggify-only --egg-file=${design_name}.egg ${design_name}.mlir -o ${design_name}_optimized.mlir

# # Step 3: Populate root eclasses
python3 populate_root_eclasses.py ${design_name}
cp ${design_name}.updated.json ${design_name}.egraph.json

echo "[DOCKER] Saturated e-graph for ${design_name} is saved to ${design_name}.egraph.json"