#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printI64(i64)
  func.func private @printF64(f64)
  func.func private @printComma()
  func.func private @printNewline()
  func.func private @putchar(i32) -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32
  func.func @printI64Tensor1D(%arg0: tensor<?xi64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c91_i32 = arith.constant 91 : i32
    %0 = call @putchar(%c91_i32) : (i32) -> i32
    %dim = tensor.dim %arg0, %c0 : tensor<?xi64>
    scf.for %arg1 = %c0 to %dim step %c1 {
      %extracted = tensor.extract %arg0[%arg1] : tensor<?xi64>
      func.call @printI64(%extracted) : (i64) -> ()
      %2 = index.sub %dim, %c1
      %3 = index.cmp ult(%arg1, %2)
      scf.if %3 {
        func.call @printComma() : () -> ()
      }
    }
    %c93_i32 = arith.constant 93 : i32
    %1 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @printI64Tensor2D(%arg0: tensor<?x?xi64>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c91_i32 = arith.constant 91 : i32
    %0 = call @putchar(%c91_i32) : (i32) -> i32
    %c9_i32 = arith.constant 9 : i32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xi64>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xi64>
    scf.for %arg1 = %c0 to %dim step %c1 {
      %extracted_slice = tensor.extract_slice %arg0[%arg1, 0] [1, %dim_0] [1, 1] : tensor<?x?xi64> to tensor<?xi64>
      func.call @printNewline() : () -> ()
      %3 = func.call @putchar(%c9_i32) : (i32) -> i32
      func.call @printI64Tensor1D(%extracted_slice) : (tensor<?xi64>) -> ()
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
    %c93_i32 = arith.constant 93 : i32
    %2 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @fillRandomI64Tensor2D(%arg0: tensor<?x?xi64>) -> tensor<?x?xi64> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<?x?xi64>
    %dim_0 = tensor.dim %arg0, %c0 : tensor<?x?xi64>
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant 0.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+01 : f64
    %0 = tensor.empty(%dim_0, %dim) : tensor<?x?xf64>
    %1 = linalg.fill_rng_2d ins(%cst, %cst_1, %c0_i32 : f64, f64, i32) outs(%0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    %2 = linalg.floor ins(%1 : tensor<?x?xf64>) outs(%0 : tensor<?x?xf64>) -> tensor<?x?xf64>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<?x?xf64>) outs(%arg0 : tensor<?x?xi64>) {
    ^bb0(%in: f64, %out: i64):
      %4 = arith.fptosi %in : f64 to i64
      linalg.yield %4 : i64
    } -> tensor<?x?xi64>
    return %3 : tensor<?x?xi64>
  }
  func.func @xy_z(%arg0: tensor<10000x10xi64>, %arg1: tensor<10x15000xi64>, %arg2: tensor<15000x8xi64>) -> tensor<10000x8xi64> {
    %0 = tensor.empty() : tensor<10000x15000xi64>
    %1 = linalg.matmul ins(%arg0, %arg1 : tensor<10000x10xi64>, tensor<10x15000xi64>) outs(%0 : tensor<10000x15000xi64>) -> tensor<10000x15000xi64>
    %2 = tensor.empty() : tensor<10000x8xi64>
    %3 = linalg.matmul ins(%1, %arg2 : tensor<10000x15000xi64>, tensor<15000x8xi64>) outs(%2 : tensor<10000x8xi64>) -> tensor<10000x8xi64>
    return %3 : tensor<10000x8xi64>
  }
  func.func @x_yz(%arg0: tensor<10000x10xi64>, %arg1: tensor<10x15000xi64>, %arg2: tensor<15000x8xi64>) -> tensor<10000x8xi64> {
    %0 = tensor.empty() : tensor<10x8xi64>
    %1 = linalg.matmul ins(%arg1, %arg2 : tensor<10x15000xi64>, tensor<15000x8xi64>) outs(%0 : tensor<10x8xi64>) -> tensor<10x8xi64>
    %2 = tensor.empty() : tensor<10000x8xi64>
    %3 = linalg.matmul ins(%arg0, %1 : tensor<10000x10xi64>, tensor<10x8xi64>) outs(%2 : tensor<10000x8xi64>) -> tensor<10000x8xi64>
    return %3 : tensor<10000x8xi64>
  }
  func.func @main() -> f32 {
    %0 = tensor.empty() : tensor<10000x10xi64>
    %cast = tensor.cast %0 : tensor<10000x10xi64> to tensor<?x?xi64>
    %1 = call @fillRandomI64Tensor2D(%cast) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %cast_0 = tensor.cast %1 : tensor<?x?xi64> to tensor<10000x10xi64>
    %2 = tensor.empty() : tensor<10x15000xi64>
    %cast_1 = tensor.cast %2 : tensor<10x15000xi64> to tensor<?x?xi64>
    %3 = call @fillRandomI64Tensor2D(%cast_1) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %cast_2 = tensor.cast %3 : tensor<?x?xi64> to tensor<10x15000xi64>
    %4 = tensor.empty() : tensor<15000x8xi64>
    %cast_3 = tensor.cast %4 : tensor<15000x8xi64> to tensor<?x?xi64>
    %5 = call @fillRandomI64Tensor2D(%cast_3) : (tensor<?x?xi64>) -> tensor<?x?xi64>
    %cast_4 = tensor.cast %5 : tensor<?x?xi64> to tensor<15000x8xi64>
    %6 = call @xy_z(%cast_0, %cast_2, %cast_4) : (tensor<10000x10xi64>, tensor<10x15000xi64>, tensor<15000x8xi64>) -> tensor<10000x8xi64>
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
}

