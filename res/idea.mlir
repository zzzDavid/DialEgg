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
    %7 = tensor.empty() : tensor<100x100xi32>
    %8 = tensor.empty() : tensor<100x100xi32>
    %9 = tensor.empty() : tensor<100x100xi32>
    %10 = linalg.matmul ins(%9, %9 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%9 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %11 = linalg.matmul ins(%10, %9 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%9 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %12 = linalg.matmul ins(%11, %9 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%9 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %13 = call @blackhole(%12) : (tensor<100x100xi32>) -> tensor<100x100xi32>
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}

module {
  func.func @blackhole(%arg0: tensor<100x100xi32>) -> tensor<100x100xi32> {
    return %arg0 : tensor<100x100xi32>
  }
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = tensor.empty() : tensor<100x100xi32>
    %1 = linalg.matmul ins(%0, %0 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%0 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %2 = linalg.matmul ins(%1, %0 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%0 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %3 = linalg.matmul ins(%2, %0 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%0 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %4 = call @blackhole(%3) : (tensor<100x100xi32>) -> tensor<100x100xi32>
    return %c0_i32 : i32
  }
}