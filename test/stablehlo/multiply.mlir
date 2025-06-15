// RUN: %eggopt %s --egg %testsrc/stablehlo/multiply.egg --eq-sat | FileCheck %s

func.func @mul2(%x: tensor<4xf64>) -> tensor<4xf64> {
	%cst = stablehlo.constant dense<2.0> : tensor<4xf64>
	%res = stablehlo.multiply %x, %cst : tensor<4xf64>
	return %res : tensor<4xf64>
}

// CHECK: func.func @mul2(%arg0: tensor<4xf64>) -> tensor<4xf64> {
// CHECK-NEXT:    %0 = stablehlo.add %arg0, %arg0 : tensor<4xf64>
// CHECK-NEXT:    return %0 : tensor<4xf64>
// CHECK-NEXT:  }
