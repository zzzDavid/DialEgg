func.func @transpose() -> tensor<2x3xf32> {
    %a = tensor.empty() : tensor<3x2xf32>
    %b = tensor.empty() : tensor<2x3xf32>

    %c = linalg.transpose ins(%a: tensor<3x2xf32>)
                          outs(%b : tensor<2x3xf32>)
                          permutation = [1, 0]

    %d = linalg.transpose ins(%c: tensor<2x3xf32>)
                          outs(%a : tensor<3x2xf32>)
                          permutation = [1, 0]

    func.return %c : tensor<2x3xf32>
}