<<<<<<< HEAD
#!/bin/bash

# Add egglog to PATH
export PATH="/work/global/nz264/dialegg-deps/egglog/target/release:$PATH"

echo "🚀 Starting complete roundtrip pipeline..."

# Step 1: Parse Verilog to MLIR
echo "📥 Step 1: Parsing Verilog to MLIR..."
circt-verilog fir.v > fir.mlir

# Step 2: Run egglog optimization
echo "🔧 Step 2: Running egglog optimization..."
/work/global/nz264/dialegg/build-release/egg-opt --eq-sat --egg-file=fir.egg fir.mlir > fir_optimized.mlir

# Step 3: Generate optimized Verilog from MLIR
echo "📤 Step 3: Generating optimized Verilog from MLIR..."
circt-opt --lower-seq-to-sv fir_optimized.mlir | circt-opt --export-split-verilog --prettify-verilog

echo "🎉 Roundtrip pipeline completed!"
=======
circt-verilog fir.v | circt-opt --lower-seq-to-sv | circt-opt --export-split-verilog --prettify-verilog
>>>>>>> 2c8ee9d7d95be3f2f8dda456af0cfd703ff6b2e0
