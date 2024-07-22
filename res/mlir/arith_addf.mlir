func.func private @printF64(f64)
func.func private @printNewline()

func.func @main(%cst : f64) -> f32 {
    // float constants
    %two_f = arith.constant 2.0 : f64

    // add two floats
    %e = arith.addf %two_f, %two_f : f64
    func.call @printF64(%e) : (f64) -> () // 3.5
    func.call @printNewline() : () -> ()

    // subtract two floats
    %f = arith.subf %two_f, %cst : f64
    func.call @printF64(%f) : (f64) -> () // 0.5
    func.call @printNewline() : () -> ()

    // add two results
    %g = arith.addf %e, %f : f64
    func.call @printF64(%g) : (f64) -> () // 4.0
    func.call @printNewline() : () -> ()

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}