func.func private @printF64(f64)
func.func private @printF32(f32)
func.func private @printNewline()

func.func @fast_inv_sqrt(%x: f32) -> f32 {
    // C code from https://en.wikipedia.org/wiki/Fast_inverse_square_root
    // float Q_rsqrt(float number) {
    //     long i;
    //     float x2, y;
    //     const float threehalfs = 1.5F;

    //     x2 = number * 0.5F;
    //     y  = number;
    //     i  = * ( long * ) &y;                       // evil floating point bit level hacking
    //     i  = 0x5f3759df - ( i >> 1 );               // what the fuck?
    //     y  = * ( float * ) &i;
    //     y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
    //     // y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed

    //     return y;
    // }

    %c1 = arith.constant 1 : i32
    %half = arith.constant 0.5 : f32
    %three_halfs = arith.constant 1.5 : f32
    %magic_number = arith.constant 0x5f3759df : i32

    %x2 = arith.mulf %x, %half : f32 // x2 = number * 0.5F
    %i = arith.bitcast %x : f32 to i32 // i = * ( long * ) &y
    %i_shifted = arith.shrsi %i, %c1 : i32 // i >> 1
    %i_subbed = arith.subi %magic_number, %i_shifted : i32 // i  = 0x5f3759df - ( i >> 1 );
    %y = arith.bitcast %i_subbed : i32 to f32 // y = * ( float * ) &i

    %y2 = arith.mulf %y, %y : f32 // y2 = y * y
    %x2y2 = arith.mulf %x2, %y2 : f32 // x2y2 = x2 * y * y
    %sub = arith.subf %three_halfs, %x2y2 : f32 // sub = threehalfs - (x2 * y * y)
    %y_it = arith.mulf %y, %sub : f32 // y_times_sub = y * (threehalfs - (x2 * y * y))

    func.return %y_it : f32
}

func.func @inv_sqrt(%x: f32) -> f32 {
    %c1 = arith.constant 1.0 : f32
    %sqrt = math.sqrt %x fastmath<fast> : f32
    %inv_sqrt = arith.divf %c1, %sqrt fastmath<fast> : f32
    func.return %inv_sqrt : f32
}

func.func @main() -> i32 {
    %x = arith.constant 9.0 : f32
    %inv_sqrt = func.call @inv_sqrt(%x) : (f32) -> f32
    func.call @printF32(%inv_sqrt) : (f32) -> ()
    func.call @printNewline() : () -> ()

    %fast_inv_sqrt = func.call @fast_inv_sqrt(%x) : (f32) -> f32
    func.call @printF32(%fast_inv_sqrt) : (f32) -> ()
    func.call @printNewline() : () -> ()

    %c0 = arith.constant 0 : i32
    func.return %c0 : i32
}