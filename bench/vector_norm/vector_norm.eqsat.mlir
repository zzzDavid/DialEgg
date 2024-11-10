module {
  func.func @fast_inv_sqrt(%arg0: f32) -> f32 {
    %c1_i32 = arith.constant 1 : i32
    %cst = arith.constant 5.000000e-01 : f32
    %cst_0 = arith.constant 1.500000e+00 : f32
    %c1597463007_i32 = arith.constant 1597463007 : i32
    %0 = arith.mulf %arg0, %cst : f32
    %1 = arith.bitcast %arg0 : f32 to i32
    %2 = arith.shrsi %1, %c1_i32 : i32
    %3 = arith.subi %c1597463007_i32, %2 : i32
    %4 = arith.bitcast %3 : i32 to f32
    %5 = arith.mulf %4, %4 : f32
    %6 = arith.mulf %0, %5 : f32
    %7 = arith.subf %cst_0, %6 : f32
    %8 = arith.mulf %4, %7 : f32
    return %8 : f32
  }
  func.func @normalize_vector(%arg0: f32, %arg1: f32, %arg2: f32) -> (f32, f32, f32) {
    %0 = arith.mulf %arg0, %arg0 : f32
    %1 = arith.mulf %arg1, %arg1 : f32
    %2 = arith.mulf %arg2, %arg2 : f32
    %3 = arith.addf %0, %1 : f32
    %4 = arith.addf %3, %2 : f32
    %5 = call @fast_inv_sqrt(%4) : (f32) -> f32
    %6 = arith.mulf %arg0, %5 : f32
    %7 = arith.mulf %arg1, %5 : f32
    %8 = arith.mulf %arg2, %5 : f32
    return %6, %7, %8 : f32, f32, f32
  }
}

