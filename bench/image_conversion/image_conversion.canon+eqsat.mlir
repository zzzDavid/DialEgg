module {
  func.func private @printNewline()
  func.func private @clock() -> i64
  func.func private @displayTime(i64, i64)
  func.func private @printI64Tensor2D(tensor<?x?xi64>)
  func.func @blackhole4k(%arg0: tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64> {
    return %arg0 : tensor<3840x2160x3xi64>
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
    %2 = call @blackhole4k(%1) : (tensor<3840x2160x3xi64>) -> tensor<3840x2160x3xi64>
    %3 = call @clock() : () -> i64
    %4 = tensor.empty() : tensor<3840x2160xi64>
    %5 = scf.for %arg0 = %c0 to %c3840 step %c1 iter_args(%arg1 = %4) -> (tensor<3840x2160xi64>) {
      %7 = scf.for %arg2 = %c0 to %c2160 step %c1 iter_args(%arg3 = %arg1) -> (tensor<3840x2160xi64>) {
        %extracted = tensor.extract %2[%arg0, %arg2, %c0] : tensor<3840x2160x3xi64>
        %extracted_0 = tensor.extract %2[%arg0, %arg2, %c1] : tensor<3840x2160x3xi64>
        %extracted_1 = tensor.extract %2[%arg0, %arg2, %c2] : tensor<3840x2160x3xi64>
        %8 = func.call @rgb_to_grayscale(%extracted, %extracted_0, %extracted_1) : (i64, i64, i64) -> i64
        %inserted = tensor.insert %8 into %arg3[%arg0, %arg2] : tensor<3840x2160xi64>
        scf.yield %inserted : tensor<3840x2160xi64>
      }
      scf.yield %7 : tensor<3840x2160xi64>
    }
    %6 = call @clock() : () -> i64
    %cast = tensor.cast %5 : tensor<3840x2160xi64> to tensor<?x?xi64>
    call @printI64Tensor2D(%cast) : (tensor<?x?xi64>) -> ()
    call @printNewline() : () -> ()
    call @displayTime(%3, %6) : (i64, i64) -> ()
    return %c0_i64 : i64
  }
  func.func @rgb_to_grayscale(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c77_i64 = arith.constant 77 : i64
    %c150_i64 = arith.constant 150 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = arith.muli %arg0, %c77_i64 : i64
    %1 = arith.muli %arg1, %c150_i64 : i64
    %2 = arith.muli %arg2, %c29_i64 : i64
    %c8_i64 = arith.constant 8 : i64
    %3 = arith.shrsi %0, %c8_i64 : i64
    %4 = arith.shrsi %1, %c8_i64 : i64
    %5 = arith.shrsi %2, %c8_i64 : i64
    %6 = arith.addi %3, %4 : i64
    %7 = arith.addi %6, %5 : i64
    return %7 : i64
  }
}

