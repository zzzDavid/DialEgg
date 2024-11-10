module {
  func.func @poly_eval_2(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = arith.mulf %arg3, %arg0 : f64
    %1 = arith.addf %arg1, %0 : f64
    %2 = arith.mulf %arg3, %1 : f64
    %3 = arith.addf %arg2, %2 : f64
    return %3 : f64
  }
  func.func @poly_eval_3(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64) -> f64 {
    %0 = arith.mulf %arg4, %arg0 : f64
    %1 = arith.addf %arg1, %0 : f64
    %2 = arith.mulf %1, %arg4 : f64
    %3 = arith.addf %arg2, %2 : f64
    %4 = arith.mulf %3, %arg4 : f64
    %5 = arith.addf %arg3, %4 : f64
    return %5 : f64
  }
  func.func @poly_eval_4(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64, %arg5: f64) -> f64 {
    %0 = arith.mulf %arg0, %arg5 : f64
    %1 = arith.addf %0, %arg1 : f64
    %2 = arith.mulf %arg5, %1 : f64
    %3 = arith.addf %2, %arg2 : f64
    %4 = arith.mulf %arg5, %3 : f64
    %5 = arith.addf %arg3, %4 : f64
    %6 = arith.mulf %arg5, %5 : f64
    %7 = arith.addf %arg4, %6 : f64
    return %7 : f64
  }
}

