func.func private @printF64(f64)
func.func private @printNewline()

func.func @main() -> f32 {
    // float constants
    %two_f = arith.constant 2.0 : f64

    // neg
    %neg = arith.negf %two_f : f64
    func.call @printF64(%neg) : (f64) -> () // -2
    func.call @printNewline() : () -> ()

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}