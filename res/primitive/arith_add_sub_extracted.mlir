module {
  func.func private @printF64(f64)
  func.func private @printNewline()
  func.func @main() -> f32 {
    %cst = arith.constant 1.500000e+00 : f64
    %cst_0 = arith.constant 1.500000e+00 : f64
    %cst_1 = arith.constant 2.000000e+00 : f64
    %cst_2 = arith.constant 2.000000e+00 : f64
    %cst_3 = arith.constant 3.500000e+00 : f64
    %0 = arith.addf %cst_1, %cst : f64
    call @printF64(%cst_3) : (f64) -> ()
    call @printNewline() : () -> ()
    %cst_4 = arith.constant 2.000000e+00 : f64
    %cst_5 = arith.constant 1.500000e+00 : f64
    %1 = arith.subf %cst_4, %cst_5 : f64
    %2 = arith.subf %cst_1, %cst : f64
    call @printF64(%1) : (f64) -> ()
    call @printNewline() : () -> ()
    %cst_6 = arith.constant 0.000000e+00 : f32
    %cst_7 = arith.constant 0.000000e+00 : f32
    return %cst_6 : f32
  }
}

