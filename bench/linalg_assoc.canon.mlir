module {
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @putchar(i32) -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32
  func.func @blackhole(%arg0: tensor<100x8xi64>) -> tensor<100x8xi64> {
    return %arg0 : tensor<100x8xi64>
  }
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  func.func @displayTime(%arg0: i64, %arg1: i64) {
    %cst = arith.constant 1.000000e+04 : f64
    %0 = arith.subi %arg1, %arg0 : i64
    %1 = arith.uitofp %0 : i64 to f64
    %2 = arith.divf %1, %cst : f64
    %3 = llvm.mlir.addressof @time : !llvm.ptr
    %4 = llvm.call @printf(%3, %0, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    return
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = call @clock() : () -> i64
    %1 = tensor.empty() : tensor<100x10xi64>
    %2 = tensor.empty() : tensor<10x150xi64>
    %3 = tensor.empty() : tensor<150x8xi64>
    %4 = tensor.empty() : tensor<100x150xi64>
    %5 = linalg.matmul ins(%1, %2 : tensor<100x10xi64>, tensor<10x150xi64>) outs(%4 : tensor<100x150xi64>) -> tensor<100x150xi64>
    %6 = tensor.empty() : tensor<100x8xi64>
    %7 = linalg.matmul ins(%5, %3 : tensor<100x150xi64>, tensor<150x8xi64>) outs(%6 : tensor<100x8xi64>) -> tensor<100x8xi64>
    %8 = call @clock() : () -> i64
    call @displayTime(%0, %8) : (i64, i64) -> ()
    %9 = call @blackhole(%7) : (tensor<100x8xi64>) -> tensor<100x8xi64>
    return %c0_i32 : i32
  }
}

