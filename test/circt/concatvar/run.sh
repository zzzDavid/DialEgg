#!/bin/bash

# Add egglog to PATH
export PATH="/work/global/nz264/dialegg-deps/egglog/target/release:$PATH"

egg-opt --eq-sat --egg-file=concatvar.egg concatvar.mlir -o concatvar_optimized.mlir