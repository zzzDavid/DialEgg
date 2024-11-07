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
    %0 = arith.subi %arg1, %arg0 : i64
    %1 = arith.uitofp %0 : i64 to f64
    %cst = arith.constant 1.000000e+06 : f64
    %2 = arith.divf %1, %cst : f64
    %3 = llvm.mlir.addressof @time : !llvm.ptr
    %4 = llvm.call @printf(%3, %0, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    return
  }
  func.func @fillRandomF64Tensor2D(%arg0: tensor<1000000x3xf64>) -> tensor<1000000x3xf64> {
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant -1.000000e+06 : f64
    %cst_0 = arith.constant 1.000000e+06 : f64
    %0 = linalg.fill_rng_2d ins(%cst, %cst_0, %c0_i32 : f64, f64, i32) outs(%arg0 : tensor<1000000x3xf64>) -> tensor<1000000x3xf64>
    return %0 : tensor<1000000x3xf64>
  }
  func.func @blackhole(%arg0: tensor<1000000x3xf32>) -> tensor<1000000x3xf32> {
    return %arg0 : tensor<1000000x3xf32>
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
  func.func @normalize_distance_vectors(%arg0: tensor<1000000x3xf32>) -> tensor<1000000x3xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c1000000 = arith.constant 1000000 : index
    %0 = tensor.empty() : tensor<1000000x3xf32>
    %1 = scf.for %arg1 = %c0 to %c1000000 step %c1 iter_args(%arg2 = %0) -> (tensor<1000000x3xf32>) {
      %extracted = tensor.extract %arg0[%arg1, %c0] : tensor<1000000x3xf32>
      %extracted_0 = tensor.extract %arg0[%arg1, %c1] : tensor<1000000x3xf32>
      %extracted_1 = tensor.extract %arg0[%arg1, %c2] : tensor<1000000x3xf32>
      %2:3 = func.call @normalize_vector(%extracted, %extracted_0, %extracted_1) : (f32, f32, f32) -> (f32, f32, f32)
      %inserted = tensor.insert %2#0 into %arg2[%arg1, %c0] : tensor<1000000x3xf32>
      %inserted_2 = tensor.insert %2#1 into %inserted[%arg1, %c1] : tensor<1000000x3xf32>
      %inserted_3 = tensor.insert %2#2 into %inserted_2[%arg1, %c2] : tensor<1000000x3xf32>
      scf.yield %inserted_3 : tensor<1000000x3xf32>
    }
    return %1 : tensor<1000000x3xf32>
  }
  func.func @main() -> i32 {
    %0 = tensor.empty() : tensor<1000000x3xf64>
    %1 = call @fillRandomF64Tensor2D(%0) : (tensor<1000000x3xf64>) -> tensor<1000000x3xf64>
    %2 = arith.truncf %1 : tensor<1000000x3xf64> to tensor<1000000x3xf32>
    %3 = call @clock() : () -> i64
    %4 = call @normalize_distance_vectors(%2) : (tensor<1000000x3xf32>) -> tensor<1000000x3xf32>
    %5 = call @clock() : () -> i64
    %6 = call @blackhole(%4) : (tensor<1000000x3xf32>) -> tensor<1000000x3xf32>
    call @displayTime(%3, %5) : (i64, i64) -> ()
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}

