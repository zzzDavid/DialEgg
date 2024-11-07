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
    %9 = linalg.matmul ins(%6, %7 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%8 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %10 = tensor.empty() : tensor<100x100xi32>
    %11 = tensor.empty() : tensor<100x100xi32>
    %12 = linalg.matmul ins(%9, %10 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%11 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %13 = tensor.empty() : tensor<100x100xi32>
    %14 = tensor.empty() : tensor<100x100xi32>
    %15 = linalg.matmul ins(%12, %13 : tensor<100x100xi32>, tensor<100x100xi32>) outs(%14 : tensor<100x100xi32>) -> tensor<100x100xi32>
    %16 = call @blackhole(%15) : (tensor<100x100xi32>) -> tensor<100x100xi32>
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
