func.func @main() {
    %a = tensor.empty() : tensor<3x2xf32>
    %b = tensor.empty() : tensor<2x3xf32>

    %tr = linalg.transpose ins(%a: tensor<3x2xf32>)
                           outs(%0: tensor<2x3xf32>)

    %lhs = tensor.empty() : tensor<3x2xf32>
    %rhs = tensor.empty() : tensor<2x4xf32>
    %init = tensor.empty() : tensor<3x4xf32>

    %matmul = linalg.matmul ins(%lhs, %rhs: tensor<3x2xf32>, tensor<2x4xf32>)
                            outs(%init: tensor<3x4xf32>) -> tensor<3x4xf32>

    func.return
}