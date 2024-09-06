module {
  func.func private @printF64(f64)
  func.func private @printF32(f32)
  func.func private @printComma()
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @putchar(i32) -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  func.func @displayTime(%arg0: i64, %arg1: i64) {
    %cst = arith.constant 1.000000e+08 : f64
    %0 = arith.subi %arg1, %arg0 : i64
    %1 = arith.uitofp %0 : i64 to f64
    %2 = arith.divf %1, %cst : f64
    %3 = llvm.mlir.addressof @time : !llvm.ptr
    %4 = llvm.call @printf(%3, %0, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    return
  }
  func.func @fillRandomF64Tensor2D(%arg0: tensor<100000x3xf64>) -> tensor<100000x3xf64> {
    %c12345_i32 = arith.constant 12345 : i32
    %c1103515245_i32 = arith.constant 1103515245 : i32
    %cst = arith.constant 0x41DFFFFFFFC00000 : f64
    %cst_0 = arith.constant 2.3283063999999999E-10 : f64
    %c0_i32 = arith.constant 0 : i32
    %cst_1 = arith.constant -1.000000e+05 : f64
    %cst_2 = arith.constant 1.000000e+05 : f64
    %0 = linalg.fill_rng_2d ins(%cst_1, %cst_2, %c0_i32 : f64, f64, i32) outs(%arg0 : tensor<100000x3xf64>) -> tensor<100000x3xf64>
    return %0 : tensor<100000x3xf64>
  }
  func.func @printF64Tensor1D(%arg0: tensor<?xf64>) {
    %c93_i32 = arith.constant 93 : i32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c91_i32 = arith.constant 91 : i32
    %0 = call @putchar(%c91_i32) : (i32) -> i32
    %dim = tensor.dim %arg0, %c0 : tensor<?xf64>
    scf.for %arg1 = %c0 to %dim step %c1 {
      %extracted = tensor.extract %arg0[%arg1] : tensor<?xf64>
      func.call @printF64(%extracted) : (f64) -> ()
      %2 = index.sub %dim, %c1
      %3 = index.cmp ult(%arg1, %2)
      scf.if %3 {
        func.call @printComma() : () -> ()
      }
    }
    %1 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @printF64Tensor2D(%arg0: tensor<?x?xf64>) {
    %c93_i32 = arith.constant 93 : i32
    %c9_i32 = arith.constant 9 : i32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c91_i32 = arith.constant 91 : i32
    %0 = call @putchar(%c91_i32) : (i32) -> i32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf64>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf64>
    scf.for %arg1 = %c0 to %dim step %c1 {
      %extracted_slice = tensor.extract_slice %arg0[%arg1, 0] [1, %dim_0] [1, 1] : tensor<?x?xf64> to tensor<?xf64>
      func.call @printNewline() : () -> ()
      %3 = func.call @putchar(%c9_i32) : (i32) -> i32
      func.call @printF64Tensor1D(%extracted_slice) : (tensor<?xf64>) -> ()
      %4 = index.sub %dim, %c1
      %5 = index.cmp ult(%arg1, %4)
      scf.if %5 {
        func.call @printComma() : () -> ()
      }
    }
    %1 = index.cmp sgt(%dim, %c0)
    scf.if %1 {
      func.call @printNewline() : () -> ()
    }
    %2 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @printF32Tensor2D(%arg0: tensor<?x?xf32>) {
    %0 = arith.extf %arg0 : tensor<?x?xf32> to tensor<?x?xf64>
    call @printF64Tensor2D(%0) : (tensor<?x?xf64>) -> ()
    return
  }
  func.func @blackhole(%arg0: tensor<100000x3xf32>) -> tensor<100000x3xf32> {
    return %arg0 : tensor<100000x3xf32>
  }
  func.func @fast_inv_sqrt(%arg0: f32) -> f32 {
    %c1_i32 = arith.constant 1 : i32
    %cst = arith.constant 5.000000e-01 : f32
    %cst_0 = arith.constant 1.500000e+00 : f32
    %c1597463007_i32 = arith.constant 1597463007 : i32
    %0 = arith.mulf %arg0, %cst : f32
    %1 = arith.bitcast %arg0 : f32 to i32
    %2 = arith.shrsi %1, %c1_i32 : i32
    %3 = arith.subi %c1597463007_i32, %2 : i32
    %4 = arith.bitcast %3 : i32 to f32
    %5 = arith.mulf %4, %4 : f32
    %6 = arith.mulf %0, %5 : f32
    %7 = arith.subf %cst_0, %6 : f32
    %8 = arith.mulf %4, %7 : f32
    return %8 : f32
  }
  func.func @normalize_vector(%arg0: f32, %arg1: f32, %arg2: f32) -> (f32, f32, f32) {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = arith.mulf %arg0, %arg0 : f32
    %1 = arith.mulf %arg1, %arg1 : f32
    %2 = arith.mulf %arg2, %arg2 : f32
    %3 = arith.addf %0, %1 : f32
    %4 = arith.addf %3, %2 : f32
    %5 = math.sqrt %4 fastmath<fast> : f32
    %6 = arith.divf %cst, %5 fastmath<fast> : f32
    %7 = arith.mulf %arg0, %6 : f32
    %8 = arith.mulf %arg1, %6 : f32
    %9 = arith.mulf %arg2, %6 : f32
    return %7, %8, %9 : f32, f32, f32
  }
  func.func @normalize_distance_vectors(%arg0: tensor<100000x3xf32>) -> tensor<100000x3xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c100000 = arith.constant 100000 : index
    %0 = tensor.empty() : tensor<100000x3xf32>
    %1 = scf.for %arg1 = %c0 to %c100000 step %c1 iter_args(%arg2 = %0) -> (tensor<100000x3xf32>) {
      %extracted = tensor.extract %arg0[%arg1, %c0] : tensor<100000x3xf32>
      %extracted_0 = tensor.extract %arg0[%arg1, %c1] : tensor<100000x3xf32>
      %extracted_1 = tensor.extract %arg0[%arg1, %c2] : tensor<100000x3xf32>
      %2:3 = func.call @normalize_vector(%extracted, %extracted_0, %extracted_1) : (f32, f32, f32) -> (f32, f32, f32)
      %inserted = tensor.insert %2#0 into %arg2[%arg1, %c0] : tensor<100000x3xf32>
      %inserted_2 = tensor.insert %2#1 into %inserted[%arg1, %c1] : tensor<100000x3xf32>
      %inserted_3 = tensor.insert %2#2 into %inserted_2[%arg1, %c2] : tensor<100000x3xf32>
      scf.yield %inserted_3 : tensor<100000x3xf32>
    }
    return %1 : tensor<100000x3xf32>
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<100000x3xf64>
    %1 = call @fillRandomF64Tensor2D(%0) : (tensor<100000x3xf64>) -> tensor<100000x3xf64>
    %2 = arith.truncf %1 : tensor<100000x3xf64> to tensor<100000x3xf32>
    %3 = call @clock() : () -> i64
    %4 = call @normalize_distance_vectors(%2) : (tensor<100000x3xf32>) -> tensor<100000x3xf32>
    %5 = call @clock() : () -> i64
    %6 = call @blackhole(%4) : (tensor<100000x3xf32>) -> tensor<100000x3xf32>
    call @displayTime(%3, %5) : (i64, i64) -> ()
    return %c0_i32 : i32
  }
}

