#!/bin/bash

# Script to lower and run MLIR code

# Usualy the process is
# mlir-opt <FLAGS> <MLIR_FILE_PATH/MLIR_FILE_NAME.mlir> -o <MLIR_FILE_PATH/MLIR_FILE_NAME.ll.mlir>
# mlir-translate --mlir-to-llvmir <MLIR_FILE_PATH/MLIR_FILE_NAME.ll.mlir> -o <MLIR_FILE_PATH/MLIR_FILE_NAME.ll>
# lli --dlopen=/Users/aziz/dev/lib/llvm/build/lib/libmlir_c_runner_utils.dylib <MLIR_FILE_PATH/MLIR_FILE_NAME.ll>

# This script will do the above steps for you
# inputs=("$@")
# FLAGS="${inputs[@]::${#inputs[@]}-1}"
# MLIR_FILE=${inputs[@]: -1}
MLIR_FILE=$1
MLIR_FILE_PATH=$(dirname $MLIR_FILE)
MLIR_FILE_NAME=$(basename $MLIR_FILE .mlir) # filename wihtout path and extension

FLAGS="
--convert-elementwise-to-linalg
--convert-tensor-to-linalg
--convert-linalg-to-loops
--one-shot-bufferize=bufferize-function-boundaries=true
--convert-linalg-to-loops
--expand-strided-metadata
--lower-affine
--convert-index-to-llvm
--convert-math-to-llvm
--convert-scf-to-cf
--convert-cf-to-llvm
--convert-arith-to-llvm
--convert-func-to-llvm
--finalizing-bufferize
--finalize-memref-to-llvm
--reconcile-unrealized-casts
"

# Lower the MLIR code to LLVM IR
mlir_ll_file=$MLIR_FILE_PATH/$MLIR_FILE_NAME.ll.mlir
echo "Creating $mlir_ll_file"
mlir-opt $FLAGS $MLIR_FILE -o $mlir_ll_file

# Translate the MLIR code to LLVM IR
ll_file=$MLIR_FILE_PATH/$MLIR_FILE_NAME.ll
echo "Creating $ll_file"
mlir-translate --mlir-to-llvmir $mlir_ll_file -o $ll_file

# Translate the MLIR code to CPP
# cpp_file=$MLIR_FILE_PATH/$MLIR_FILE_NAME.cpp
# echo "Creating $cpp_file"
# mlir-translate --mlir-to-cpp $mlir_ll_file -o $cpp_file

# Run the LLVM IR code
echo "Running $ll_file"
echo
lli --dlopen=/Users/aziz/dev/lib/llvm/build/lib/libmlir_c_runner_utils.dylib $ll_file