module {
  func.func @transpose() -> tensor<2x3xf64> {
    %cst = arith.constant dense<[[1., 2., 3.], [4., 5., 6.]]> : tensor<2x3xf64>
    %cst_0 = arith.constant dense<0.> : tensor<3x2xf64>
    %cst_1 = arith.constant dense<0.> : tensor<2x3xf64>
    %cst_2 = arith.constant dense<[[1., 2., 3.], [4., 5., 6.]]> : tensor<2x3xf64>
    %cst_3 = arith.constant dense<0.> : tensor<3x2xf64>
    %transposed = linalg.transpose ins(%cst_2 : tensor<2x3xf64>) outs(%cst_3 : tensor<3x2xf64>) permutation = [1, 0] 
    %cst_4 = arith.constant dense<[[1., 2., 3.], [4., 5., 6.]]> : tensor<2x3xf64>
    return %cst_4 : tensor<2x3xf64>
  }
}

