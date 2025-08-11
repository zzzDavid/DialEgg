module {
  func.func @fir_input(%arg0: i16, %arg1: i16, %arg2: i16) -> i16 {
    %c1_i16 = arith.constant 1 : i16
    %0 = arith.shli %arg1, %c1_i16 : i16
    %1 = arith.addi %arg0, %0 : i16
    %2 = arith.addi %1, %arg2 : i16
    return %2 : i16
  }
}
