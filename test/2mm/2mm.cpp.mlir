module {
  func.func @_2mm(%arg0: tensor<100x10xi64>, %arg1: tensor<10x150xi64>, %arg2: tensor<150x8xi64>) -> tensor<100x8xi64> {
    %0 = tensor.empty() : tensor<10x8xi64>
    %1 = linalg.matmul ins(%arg1, %arg2 : tensor<10x150xi64>, tensor<150x8xi64>) outs(%0 : tensor<10x8xi64>) -> tensor<10x8xi64>
    %2 = tensor.empty() : tensor<100x8xi64>
    %3 = linalg.matmul ins(%arg0, %1 : tensor<100x10xi64>, tensor<10x8xi64>) outs(%2 : tensor<100x8xi64>) -> tensor<100x8xi64>
    return %3 : tensor<100x8xi64>
  }
}

