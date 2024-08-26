func.func private @printF64(f64)
func.func private @printNewline()

func.func @add(%x: f64, %y: f64) -> f64 {
    %e = arith.addf %x, %y : f64
    func.call @printF64(%e) : (f64) -> () // 3.5
    func.call @printNewline() : () -> ()

    // subtract two floats
    %f = arith.subf %e, %y : f64
    func.call @printF64(%f) : (f64) -> () // 0.5
    func.call @printNewline() : () -> ()

    func.return %e : f64
}