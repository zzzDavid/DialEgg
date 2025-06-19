mlir-opt --convert-elementwise-to-linalg --convert-tensor-to-linalg \
         --convert-linalg-to-loops --one-shot-bufferize=bufferize-function-boundaries=true \
         --convert-linalg-to-loops --expand-strided-metadata --lower-affine --convert-index-to-llvm \
         --convert-math-to-llvm --convert-scf-to-cf --convert-cf-to-llvm --convert-arith-to-llvm \
         --convert-func-to-llvm --finalize-memref-to-llvm --reconcile-unrealized-casts \
         test/util/util.mlir -o test/util/util.ll.mlir

mlir-translate --mlir-to-llvmir test/util/util.ll.mlir -o test/util/util.ll

clang -dynamiclib test/util/util.ll -o test/util/libutil.dylib \
    -L/Users/aziz/dev/lib/llvm/build-debug/lib -lmlir_c_runner_utils -Wl,-rpath,/Users/aziz/dev/lib/llvm/build-debug/lib