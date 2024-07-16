func.func private @printI64(i64)
func.func private @printF64(f64)
func.func private @printComma()
func.func private @printNewline()

// C funcs
func.func private @putchar(i32) -> i32
llvm.func @printf(!llvm.ptr, ...) -> i32

func.func private @printI64Tensor1D(%tensor : tensor<?xi64>)
func.func private @printF64Tensor1D(%tensor : tensor<?xf64>)
func.func private @printI64Tensor2D(%tensor: tensor<?x?xi64>)
func.func private @printF64Tensor2D(%tensor: tensor<?x?xf64>)

// The arith dialct operations take primitive-like types as arguments.
// So a float-like type is represented as f32, f64 or any collection-type like vector<?xf32> or tensor<?xf32>.
func.func @main() -> f32 {
    // tensor constants
    %tensor0 = arith.constant dense<[[1., 2., 3.], [4., 5., 6.]]> : tensor<2x3xf64>
    %tensor1 = arith.constant dense<[[2., 3., 4.], [5., 6., 7.]]> : tensor<2x3xf64>

    // Add two tensors
    %tensor2 = arith.addf %tensor0, %tensor1 : tensor<2x3xf64>

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}