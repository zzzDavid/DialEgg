func.func private @printI64(i64)
func.func private @printNewline()

func.func @main() -> f32 {
    // int constants
    %1 = arith.constant 1 : i64
    %2 = arith.constant 0 : i64

    // and two ints
    %a = arith.andi %1, %2 : i64
    func.call @printI64(%a) : (i64) -> () // 0

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}