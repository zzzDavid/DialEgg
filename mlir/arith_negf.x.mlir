module {
  func.func private @printF64(f64)
  func.func private @printNewline()
  func.func @main() -> f32 {
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant -2.000000e+00 : f64
    call @printF64(%cst_0) : (f64) -> ()
    call @printNewline() : () -> ()
    %cst_1 = arith.constant 0.000000e+00 : f32
    return %cst_1 : f32
  }
}

