module {
  func.func private @printI64(i64)
  func.func private @printF64(f64)
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
  func.func @fillRandomF64Tensor2D(%arg0: tensor<100000x4xf64>) -> tensor<100000x4xf64> {
    %c12345_i32 = arith.constant 12345 : i32
    %c1103515245_i32 = arith.constant 1103515245 : i32
    %cst = arith.constant 0x41DFFFFFFFC00000 : f64
    %cst_0 = arith.constant 2.3283063999999999E-10 : f64
    %c0_i32 = arith.constant 0 : i32
    %cst_1 = arith.constant -1.000000e+01 : f64
    %cst_2 = arith.constant 1.000000e+01 : f64
    %0 = linalg.fill_rng_2d ins(%cst_1, %cst_2, %c0_i32 : f64, f64, i32) outs(%arg0 : tensor<100000x4xf64>) -> tensor<100000x4xf64>
    return %0 : tensor<100000x4xf64>
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
  func.func @blackhole(%arg0: tensor<?xf64>) -> tensor<?xf64> {
    return %arg0 : tensor<?xf64>
  }
  func.func @poly_eval_3(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64) -> f64 {
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant 3.000000e+00 : f64
    %0 = math.powf %arg4, %cst fastmath<fast> : f64
    %1 = math.powf %arg4, %cst_0 fastmath<fast> : f64
    %2 = arith.mulf %arg2, %arg4 fastmath<fast> : f64
    %3 = arith.mulf %arg1, %0 fastmath<fast> : f64
    %4 = arith.mulf %arg0, %1 fastmath<fast> : f64
    %5 = arith.addf %3, %4 fastmath<fast> : f64
    %6 = arith.addf %2, %5 fastmath<fast> : f64
    %7 = arith.addf %arg3, %6 fastmath<fast> : f64
    return %7 : f64
  }
  func.func @poly_eval_2(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %cst = arith.constant 2.000000e+00 : f64
    %0 = math.powf %arg3, %cst fastmath<fast> : f64
    %1 = arith.mulf %arg1, %arg3 fastmath<fast> : f64
    %2 = arith.mulf %arg0, %0 fastmath<fast> : f64
    %3 = arith.addf %1, %2 fastmath<fast> : f64
    %4 = arith.addf %arg2, %3 fastmath<fast> : f64
    return %4 : f64
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c100000 = arith.constant 100000 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f64
    %0 = tensor.empty() : tensor<100000x4xf64>
    %1 = call @fillRandomF64Tensor2D(%0) : (tensor<100000x4xf64>) -> tensor<100000x4xf64>
    %2 = call @clock() : () -> i64
    %3 = tensor.empty() : tensor<100000xf64>
    %4 = scf.for %arg0 = %c0 to %c100000 step %c1 iter_args(%arg1 = %3) -> (tensor<100000xf64>) {
      %extracted = tensor.extract %1[%arg0, %c0] : tensor<100000x4xf64>
      %extracted_0 = tensor.extract %1[%arg0, %c1] : tensor<100000x4xf64>
      %extracted_1 = tensor.extract %1[%arg0, %c2] : tensor<100000x4xf64>
      %extracted_2 = tensor.extract %1[%arg0, %c3] : tensor<100000x4xf64>
      %7 = func.call @poly_eval_3(%extracted, %extracted_0, %extracted_1, %extracted_2, %cst) : (f64, f64, f64, f64, f64) -> f64
      %inserted = tensor.insert %7 into %arg1[%arg0] : tensor<100000xf64>
      scf.yield %inserted : tensor<100000xf64>
    }
    %5 = call @clock() : () -> i64
    %cast = tensor.cast %4 : tensor<100000xf64> to tensor<?xf64>
    call @printNewline() : () -> ()
    call @displayTime(%2, %5) : (i64, i64) -> ()
    %6 = call @blackhole(%cast) : (tensor<?xf64>) -> tensor<?xf64>
    return %c0_i32 : i32
  }
}

