func.func private @printI64(i64)
func.func private @printF64(f64)
func.func private @printComma()
func.func private @printNewline()

// sin(x) ^ 2 + cos(x) ^ 2 = 1
func.func @main() -> f32 {
    %two_f = arith.constant 2.0 : f64
    %three_f = arith.constant 3.0 : f64

    %sin_3_f = math.sin %three_f : f64
    %cos_3_f = math.cos %three_f : f64

    %sin_3_f_squared = arith.mulf %sin_3_f, %sin_3_f : f64
    %cos_3_f_squared = arith.mulf %cos_3_f, %cos_3_f : f64

    %sum = arith.addf %sin_3_f_squared, %cos_3_f_squared : f64

    func.call @printF64(%sum) : (f64) -> ()
    func.call @printNewline() : () -> ()

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}