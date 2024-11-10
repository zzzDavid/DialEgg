module {
  func.func @rgb_to_grayscale(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c77_i64 = arith.constant 77 : i64
    %c150_i64 = arith.constant 150 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = arith.muli %arg0, %c77_i64 : i64
    %1 = arith.muli %arg1, %c150_i64 : i64
    %2 = arith.muli %arg2, %c29_i64 : i64
    %c8_i64 = arith.constant 8 : i64
    %3 = arith.shrsi %0, %c8_i64 : i64
    %4 = arith.shrsi %1, %c8_i64 : i64
    %5 = arith.shrsi %2, %c8_i64 : i64
    %6 = arith.addi %3, %4 : i64
    %7 = arith.addi %6, %5 : i64
    return %7 : i64
  }
}

