module {
  func.func private @printI64(i64)
  func.func private @printF64(f64)
  func.func private @printComma()
  func.func private @printNewline()
  func.func @main() -> f32 {
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant 3.000000e+00 : f64
    %cst_1 = arith.constant 3.000000e+00 : f64
    %0 = math.sin %cst_1 : f64
    %cst_2 = arith.constant 3.000000e+00 : f64
    %1 = math.cos %cst_2 : f64
    %cst_3 = arith.constant 3.000000e+00 : f64
    %2 = math.sin %cst_3 : f64
    %cst_4 = arith.constant 2.000000e+00 : f64
    %3 = math.powf %2, %cst_4 : f64
    %cst_5 = arith.constant 3.000000e+00 : f64
    %4 = math.cos %cst_5 : f64
    %cst_6 = arith.constant 2.000000e+00 : f64
    %5 = math.powf %4, %cst_6 : f64
    %cst_7 = arith.constant 1.000000e+00 : f64
    call @printF64(%cst_7) : (f64) -> ()
    call @printNewline() : () -> ()
    %cst_8 = arith.constant 0.000000e+00 : f32
    return %cst_8 : f32
  }
}

