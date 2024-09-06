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
    %cst = arith.constant 1.000000e+06 : f64
    %0 = arith.subi %arg1, %arg0 : i64
    %1 = arith.uitofp %0 : i64 to f64
    %2 = arith.divf %1, %cst : f64
    %3 = llvm.mlir.addressof @time : !llvm.ptr
    %4 = llvm.call @printf(%3, %0, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    return
  }
  func.func @printI64Tensor1D(%arg0: tensor<?xi64>) {
    %c93_i32 = arith.constant 93 : i32
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
    %1 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @printI64Tensor2D(%arg0: tensor<?x?xi64>) {
    %c93_i32 = arith.constant 93 : i32
    %c9_i32 = arith.constant 9 : i32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c91_i32 = arith.constant 91 : i32
    %0 = call @putchar(%c91_i32) : (i32) -> i32
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
    %2 = call @putchar(%c93_i32) : (i32) -> i32
    return
  }
  func.func @rgb_to_grayscale(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c77_i64 = arith.constant 77 : i64
    %c150_i64 = arith.constant 150 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = arith.muli %arg0, %c77_i64 : i64
    %1 = arith.muli %arg1, %c150_i64 : i64
    %2 = arith.muli %arg2, %c29_i64 : i64
    %3 = arith.shrsi %0, %c8_i64 : i64
    %4 = arith.shrsi %1, %c8_i64 : i64
    %5 = arith.shrsi %2, %c8_i64 : i64
    %6 = arith.addi %3, %4 : i64
    %7 = arith.addi %6, %5 : i64
    return %7 : i64
  }
  func.func @blackhole1(%arg0: tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64> {
    return %arg0 : tensor<3840x2160x3xi64>
  }
  func.func @blackhole2(%arg0: tensor<3840x2160xi64>) -> tensor<3840x2160xi64> {
    return %arg0 : tensor<3840x2160xi64>
  }
  func.func @main() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c2160 = arith.constant 2160 : index
    %c3840 = arith.constant 3840 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c100_i64 = arith.constant 100 : i64
    %0 = tensor.empty() : tensor<3840x2160x3xi64>
    %1 = linalg.fill ins(%c100_i64 : i64) outs(%0 : tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64>
    %2 = call @blackhole1(%1) : (tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64>
    %3 = call @clock() : () -> i64
    %4 = tensor.empty() : tensor<3840x2160xi64>
    %5 = scf.for %arg0 = %c0 to %c3840 step %c1 iter_args(%arg1 = %4) -> (tensor<3840x2160xi64>) {
      %8 = scf.for %arg2 = %c0 to %c2160 step %c1 iter_args(%arg3 = %arg1) -> (tensor<3840x2160xi64>) {
        %extracted = tensor.extract %2[%arg0, %arg2, %c0] : tensor<3840x2160x3xi64>
        %extracted_0 = tensor.extract %2[%arg0, %arg2, %c1] : tensor<3840x2160x3xi64>
        %extracted_1 = tensor.extract %2[%arg0, %arg2, %c2] : tensor<3840x2160x3xi64>
        %9 = func.call @rgb_to_grayscale(%extracted, %extracted_0, %extracted_1) : (i64, i64, i64) -> i64
        %inserted = tensor.insert %9 into %arg3[%arg0, %arg2] : tensor<3840x2160xi64>
        scf.yield %inserted : tensor<3840x2160xi64>
      }
      scf.yield %8 : tensor<3840x2160xi64>
    }
    %6 = call @clock() : () -> i64
    call @displayTime(%3, %6) : (i64, i64) -> ()
    %7 = call @blackhole2(%5) : (tensor<3840x2160xi64>) -> tensor<3840x2160xi64>
    return %c0_i64 : i64
  }
}

