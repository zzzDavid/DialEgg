func.func @concat1(%a: tensor<3x2xf32>, %b: tensor<1x2xf32>, %c: tensor<3x2xf32>, %d: tensor<1x2xf32>) -> tensor<4x2xf32> {
	%ab = stablehlo.concatenate %a, %b, dim = 0 : (tensor<3x2xf32>, tensor<1x2xf32>) -> tensor<4x2xf32>
	%cd = stablehlo.concatenate %c, %d, dim = 0 : (tensor<3x2xf32>, tensor<1x2xf32>) -> tensor<4x2xf32>
	%res = stablehlo.add %ab, %cd : tensor<4x2xf32>
	return %res : tensor<4x2xf32>
}

// func.func @concat2(%a: tensor<3x2xf32>, %b: tensor<1x2xf32>, %c: tensor<3x2xf32>, %d: tensor<1x2xf32>) -> tensor<4x2xf32> {
// 	%ac = stablehlo.add %a, %c : tensor<3x2xf32>
// 	%bd = stablehlo.add %b, %d : tensor<1x2xf32>
// 	%res = stablehlo.concatenate %ac, %bd, dim = 0 : (tensor<3x2xf32>, tensor<1x2xf32>) -> tensor<4x2xf32>
// 	return %res : tensor<4x2xf32>
// }
