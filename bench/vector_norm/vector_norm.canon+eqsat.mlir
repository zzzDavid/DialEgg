module {
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @displayTime(i64, i64)
  func.func private @printF32Tensor2D(tensor<?x?xf32>)
  func.func @fillRandomF64Tensor2D(%arg0: tensor<?x?xf64>) -> tensor<?x?xf64> {
    %c12345_i32 = arith.constant 12345 : i32
    %c1103515245_i32 = arith.constant 1103515245 : i32
    %cst = arith.constant 0x41DFFFFFFFC00000 : f64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %c0_i32 = arith.constant 0 : i32
    %cst_1 = arith.constant -1.000000e+01 : f64
    %cst_2 = arith.constant 1.000000e+01 : f64
    %0 = linalg.fill_rng_2d ins(%cst_1, %cst_2, %c0_i32 : f64, f64, i32) outs(%arg0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    return %0 : tensor<?x?xf64>
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
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<1000000x3xf64>
    %cast = tensor.cast %0 : tensor<1000000x3xf64> to tensor<?x?xf64>
    %1 = call @fillRandomF64Tensor2D(%cast) : (tensor<?x?xf64>) -> tensor<?x?xf64>
    %2 = arith.truncf %1 : tensor<?x?xf64> to tensor<?x?xf32>
    %cast_0 = tensor.cast %2 : tensor<?x?xf32> to tensor<1000000x3xf32>
    %3 = call @clock() : () -> i64
    %4 = call @normalize_distance_vectors(%cast_0) : (tensor<1000000x3xf32>) -> tensor<1000000x3xf32>
    %5 = call @clock() : () -> i64
    %cast_1 = tensor.cast %4 : tensor<1000000x3xf32> to tensor<?x?xf32>
    call @printF32Tensor2D(%cast_1) : (tensor<?x?xf32>) -> ()
    call @printNewline() : () -> ()
    call @displayTime(%3, %5) : (i64, i64) -> ()
    return %c0_i32 : i32
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
    %0 = arith.mulf %arg0, %arg0 : f32
    %1 = arith.mulf %arg1, %arg1 : f32
    %2 = arith.mulf %arg2, %arg2 : f32
    %3 = arith.addf %0, %1 : f32
    %4 = arith.addf %3, %2 : f32
    %5 = call @fast_inv_sqrt(%4) : (f32) -> f32
    %6 = arith.mulf %arg0, %5 : f32
    %7 = arith.mulf %arg1, %5 : f32
    %8 = arith.mulf %arg2, %5 : f32
    return %6, %7, %8 : f32, f32, f32
  }
}

