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

func.func @normalize_vector(%x: f32, %y: f32, %z: f32) -> (f32, f32, f32) {
    %c1_f32 = arith.constant 1.0 : f32

    %x_squared = arith.mulf %x, %x : f32
    %y_squared = arith.mulf %y, %y : f32
    %z_squared = arith.mulf %z, %z : f32

    %distance_squared_1 = arith.addf %x_squared, %y_squared : f32
    %distance_squared = arith.addf %distance_squared_1, %z_squared : f32 // distance_squared = x^2 + y^2 + z^2

    %distance = math.sqrt %distance_squared fastmath<fast> : f32 // distance = sqrt(x^2 + y^2 + z^2)
    %inv_distance = arith.divf %c1_f32, %distance fastmath<fast> : f32 // inv_distance = 1 / sqrt(x^2 + y^2 + z^2)

    %x_normalized = arith.mulf %x, %inv_distance : f32
    %y_normalized = arith.mulf %y, %inv_distance : f32
    %z_normalized = arith.mulf %z, %inv_distance : f32

    func.return %x_normalized, %y_normalized, %z_normalized : f32, f32, f32
}