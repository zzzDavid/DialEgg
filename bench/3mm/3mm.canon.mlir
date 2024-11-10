module {
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @displayTime(i64, i64)
  func.func private @printI64Tensor2D(tensor<?x?xi64>)
  func.func @fillRandomI64Tensor2D(%arg0: tensor<?x?xi64>) -> tensor<?x?xi64> {
    %c12345_i32 = arith.constant 12345 : i32
    %c1103515245_i32 = arith.constant 1103515245 : i32
    %cst = arith.constant 0x41DFFFFFFFC00000 : f64
    %cst_0 = arith.constant 2.3283063999999999E-10 : f64
    %cst_1 = arith.constant 1.000000e+01 : f64
    %cst_2 = arith.constant -1.000000e+01 : f64
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<?x?xi64>
    %dim_3 = tensor.dim %arg0, %c0 : tensor<?x?xi64>
    %0 = tensor.empty(%dim_3, %dim) : tensor<?x?xf64>
    %1 = linalg.fill_rng_2d ins(%cst_2, %cst_1, %c0_i32 : f64, f64, i32) outs(%0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    %2 = linalg.floor ins(%1 : tensor<?x?xf64>) outs(%0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    %3 = arith.fptosi %2 : tensor<?x?xf64> to tensor<?x?xi64>
    return %3 : tensor<?x?xi64>
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<200x175xi64>
    %cast = tensor.cast %0 : tensor<200x175xi64> to tensor<?x?xi64>
    %1 = tensor.empty() : tensor<175x250xi64>
    %cast_0 = tensor.cast %1 : tensor<175x250xi64> to tensor<?x?xi64>
    %2 = tensor.empty() : tensor<250x150xi64>
    %cast_1 = tensor.cast %2 : tensor<250x150xi64> to tensor<?x?xi64>
    %3 = tensor.empty() : tensor<150x10xi64>
    %cast_2 = tensor.cast %3 : tensor<150x10xi64> to tensor<?x?xi64>
    %4 = call @fillRandomI64Tensor2D(%cast) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %5 = call @fillRandomI64Tensor2D(%cast_0) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %6 = call @fillRandomI64Tensor2D(%cast_1) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %7 = call @fillRandomI64Tensor2D(%cast_2) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %cast_3 = tensor.cast %4 : tensor<?x?xi64> to tensor<200x175xi64>
    %cast_4 = tensor.cast %5 : tensor<?x?xi64> to tensor<175x250xi64>
    %cast_5 = tensor.cast %6 : tensor<?x?xi64> to tensor<250x150xi64>
    %cast_6 = tensor.cast %7 : tensor<?x?xi64> to tensor<150x10xi64>
    %8 = call @clock() : () -> i64
    %9 = call @_3mm(%cast_3, %cast_4, %cast_5, %cast_6) : (tensor<200x175xi64>, tensor<175x250xi64>, tensor<250x150xi64>, tensor<150x10xi64>) -> tensor<200x10xi64>
    %10 = call @clock() : () -> i64
    %cast_7 = tensor.cast %9 : tensor<200x10xi64> to tensor<?x?xi64>
    call @printI64Tensor2D(%cast_7) : (tensor<?x?xi64>) -> ()
    call @printNewline() : () -> ()
    call @displayTime(%8, %10) : (i64, i64) -> ()
    return %c0_i32 : i32
  }
  func.func @_3mm(%arg0: tensor<200x175xi64>, %arg1: tensor<175x250xi64>, %arg2: tensor<250x150xi64>, %arg3: tensor<150x10xi64>) -> tensor<200x10xi64> {
    %0 = tensor.empty() : tensor<200x250xi64>
    %1 = linalg.matmul ins(%arg0, %arg1 : tensor<200x175xi64>, tensor<175x250xi64>) outs(%0 : tensor<200x250xi64>) -> tensor<200x250xi64>
    %2 = tensor.empty() : tensor<200x150xi64>
    %3 = linalg.matmul ins(%1, %arg2 : tensor<200x250xi64>, tensor<250x150xi64>) outs(%2 : tensor<200x150xi64>) -> tensor<200x150xi64>
    %4 = tensor.empty() : tensor<200x10xi64>
    %5 = linalg.matmul ins(%3, %arg3 : tensor<200x150xi64>, tensor<150x10xi64>) outs(%4 : tensor<200x10xi64>) -> tensor<200x10xi64>
    return %5 : tensor<200x10xi64>
  }
}

