module {
  func.func @blackhole(%arg0: tensor<100x100xi32>) -> tensor<100x100xi32> {
    return %arg0 : tensor<100x100xi32>
  }
  func.func @main() -> i32 {
    %0 = tensor.empty() : tensor<100x100xi32>
    %1 = tensor.empty() : tensor<100x100xi32>
    %2 = tensor.empty() : tensor<100x100xi32>
    %3 = linalg.matmul ins(%0, %1 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%2 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %4 = tensor.empty() : tensor<100x100xi32>
    %5 = tensor.empty() : tensor<100x100xi32>
    %6 = linalg.matmul ins(%3, %4 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%5 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %7 = call @blackhole(%6) : (tensor<100x100xi32>) -> tensor<100x100xi32>
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
