func.func @mul2(%x: tensor<4xf64>) -> tensor<4xf64> {
	%cst = stablehlo.constant dense<2.0> : tensor<4xf64>
	%res = stablehlo.multiply %x, %cst : tensor<4xf64>
	return %res : tensor<4xf64>
}
