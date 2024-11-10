module {
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @displayTime(i64, i64)
  func.func private @printF64Tensor1D(tensor<?xf64>)
  func.func @fillRandomF64Tensor2D(%arg0: tensor<?x?xf64>) -> tensor<?x?xf64> {
    %c12345_i32 = arith.constant 12345 : i32
    %c1103515245_i32 = arith.constant 1103515245 : i32
    %cst = arith.constant 0x41DFFFFFFFC00000 : f64
    %cst_0 = arith.constant 2.3283063999999999E-10 : f64
    %c0_i32 = arith.constant 0 : i32
    %cst_1 = arith.constant -1.000000e+01 : f64
    %cst_2 = arith.constant 1.000000e+01 : f64
    %0 = linalg.fill_rng_2d ins(%cst_1, %cst_2, %c0_i32 : f64, f64, i32) outs(%arg0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    return %0 : tensor<?x?xf64>
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 5.000000e+00 : f64
    %c1000000 = arith.constant 1000000 : index
    %0 = tensor.empty() : tensor<1000000x4xf64>
    %cast = tensor.cast %0 : tensor<1000000x4xf64> to tensor<?x?xf64>
    %1 = call @fillRandomF64Tensor2D(%cast) : (tensor<?x?xf64>) -> tensor<?x?xf64>
    %2 = call @clock() : () -> i64
    %3 = tensor.empty() : tensor<1000000xf64>
    %4 = scf.for %arg0 = %c0 to %c1000000 step %c1 iter_args(%arg1 = %3) -> (tensor<1000000xf64>) {
      %extracted = tensor.extract %1[%arg0, %c0] : tensor<?x?xf64>
      %extracted_1 = tensor.extract %1[%arg0, %c1] : tensor<?x?xf64>
      %extracted_2 = tensor.extract %1[%arg0, %c2] : tensor<?x?xf64>
      %extracted_3 = tensor.extract %1[%arg0, %c3] : tensor<?x?xf64>
      %6 = func.call @poly_eval_3(%extracted, %extracted_1, %extracted_2, %extracted_3, %cst) : (f64, f64, f64, f64, f64) -> f64
      %inserted = tensor.insert %6 into %arg1[%arg0] : tensor<1000000xf64>
      scf.yield %inserted : tensor<1000000xf64>
    }
    %5 = call @clock() : () -> i64
    %cast_0 = tensor.cast %4 : tensor<1000000xf64> to tensor<?xf64>
    call @printF64Tensor1D(%cast_0) : (tensor<?xf64>) -> ()
    call @printNewline() : () -> ()
    call @displayTime(%2, %5) : (i64, i64) -> ()
    return %c0_i32 : i32
  }
  func.func @poly_eval_3(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64) -> f64 {
    %0 = arith.mulf %arg4, %arg0 : f64
    %1 = arith.addf %arg1, %0 : f64
    %2 = arith.mulf %1, %arg4 : f64
    %3 = arith.addf %arg2, %2 : f64
    %4 = arith.mulf %3, %arg4 : f64
    %5 = arith.addf %arg3, %4 : f64
    return %5 : f64
  }
}

