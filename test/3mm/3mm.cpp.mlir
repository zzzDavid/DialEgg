module {
  func.func @_3mm(%arg0: tensor<200x175xi64>, %arg1: tensor<175x250xi64>, %arg2: tensor<250x150xi64>, %arg3: tensor<150x10xi64>) -> tensor<200x10xi64> {
    %0 = tensor.empty() : tensor<175x150xi64>
    %1 = linalg.matmul ins(%arg1, %arg2 : tensor<175x250xi64>, tensor<250x150xi64>) outs(%0 : tensor<175x150xi64>) -> tensor<175x150xi64>
    %2 = tensor.empty() : tensor<175x10xi64>
    %3 = linalg.matmul ins(%1, %arg3 : tensor<175x150xi64>, tensor<150x10xi64>) outs(%2 : tensor<175x10xi64>) -> tensor<175x10xi64>
    %4 = tensor.empty() : tensor<200x10xi64>
    %5 = linalg.matmul ins(%arg0, %3 : tensor<200x175xi64>, tensor<175x10xi64>) outs(%4 : tensor<200x10xi64>) -> tensor<200x10xi64>
    return %5 : tensor<200x10xi64>
  }
}

