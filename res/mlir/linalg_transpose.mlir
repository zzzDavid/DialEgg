func.func @transpose() -> tensor<2x3xf64> {
    %a = arith.constant dense<[[1., 2., 3.], [4., 5., 6.]]>  : tensor<2x3xf64>
    %b = arith.constant dense<[[0., 0.], [0., 0.], [0., 0.]]> : tensor<3x2xf64>
    %aa = arith.constant dense<[[0., 0., 0.], [0., 0., 0.]]>  : tensor<2x3xf64>

    %c = linalg.transpose ins(%a: tensor<2x3xf64>)
                          outs(%b : tensor<3x2xf64>)
                          permutation = [1, 0]

    %d = linalg.transpose ins(%c: tensor<3x2xf64>)
                          outs(%aa : tensor<2x3xf64>)
                          permutation = [1, 0]

    func.return %d : tensor<2x3xf64>
}