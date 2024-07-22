func.func @add() -> tensor<3x2xf32> {
    %a = tensor.empty() : tensor<3x2xf32>
    %b = tensor.empty() : tensor<3x2xf32>
    %c = tensor.empty() : tensor<3x2xf32>

    %a_abs = linalg.abs ins(%a : tensor<3x2xf32>)
                        outs(%c : tensor<3x2xf32>) -> tensor<3x2xf32>

    %d = linalg.add ins(%a_abs, %b : tensor<3x2xf32>, tensor<3x2xf32>)
                    outs(%c : tensor<3x2xf32>) -> tensor<3x2xf32>

    func.return %c : tensor<3x2xf32>
}