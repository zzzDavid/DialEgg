func.func private @printI64(i64)
func.func private @printF64(f64)
func.func private @printComma()
func.func private @printNewline()

// The arith dialct operations take primitive-like types as arguments.
// So a float-like type is represented as f32, f64 or any collection-type like vector<?xf32> or tensor<?xf32>.
func.func @main() -> f32 {
    // integer constants
    %zero = arith.constant 0 : i64
    %one = arith.constant 1 : i64
    %two = arith.constant 2 : i64
    %three = arith.constant 3 : i64
    %four = arith.constant 4 : i64
    %five = arith.constant 5 : i64

    // float constants
    %zero_f = arith.constant 0.0 : f64
    %half = arith.constant 0.5 : f64
    %one_f = arith.constant 1.0 : f64
    %one_point_five = arith.constant 1.5 : f64
    %two_f = arith.constant 2.0 : f64
    %three_f = arith.constant 3.0 : f64
    %four_f = arith.constant 4.0 : f64
    %five_f = arith.constant 5.0 : f64

    // Add two ints
    %c = arith.addi %one, %two : i64 // TODO eqsat constant folding
    func.call @printI64(%c) : (i64) -> () // 3
    func.call @printNewline() : () -> ()

    // Subtract two ints
    %d = arith.subi %five, %two : i64 // TODO eqsat constant folding
    func.call @printI64(%d) : (i64) -> () // 3
    func.call @printNewline() : () -> ()

    // add two floats
    %e = arith.addf %two_f, %one_point_five : f64
    func.call @printF64(%e) : (f64) -> () // 3.5
    func.call @printNewline() : () -> ()

    // subtract two floats
    %f = arith.subf %two_f, %one_point_five : f64
    func.call @printF64(%f) : (f64) -> () // 0.5
    func.call @printNewline() : () -> ()

    // And and Or
    %and = arith.andi %zero, %one : i64
    %or = arith.ori %zero, %one : i64 // TODO eqsat constant folding

    func.call @printI64(%and) : (i64) -> () // 0
    func.call @printComma() : () -> ()
    func.call @printI64(%or) : (i64) -> () // 1
    func.call @printNewline() : () -> ()

    // ceildivsi
    %ceildivsi = arith.ceildivsi %five, %two : i64
    func.call @printI64(%ceildivsi) : (i64) -> () // 3
    func.call @printNewline() : () -> ()

    // floordivsi
    %floordivsi = arith.floordivsi %five, %two : i64
    func.call @printI64(%floordivsi) : (i64) -> () // 2
    func.call @printNewline() : () -> ()

    // divf
    %divf = arith.divf %five_f, %two_f : f64
    func.call @printF64(%divf) : (f64) -> () // 2.5
    func.call @printNewline() : () -> ()

    // max
    %max = arith.maximumf %two_f, %three_f : f64
    func.call @printF64(%max) : (f64) -> () // 3
    func.call @printNewline() : () -> ()

    // min
    %min = arith.minimumf %two_f, %three_f : f64
    func.call @printF64(%min) : (f64) -> () // 2
    func.call @printNewline() : () -> ()

    // neg
    %neg = arith.negf %two_f : f64
    func.call @printF64(%neg) : (f64) -> () // -2
    func.call @printNewline() : () -> ()

    %zero_f32 = arith.constant 0.0 : f32
    func.return %zero_f32 : f32
}