// Before optimization
func.func @example(%arg0: i32, %arg1: i32) -> i32 {
  %0 = arith.addi %arg0, %arg1 : i32
  %1 = arith.muli %arg0, %arg1 : i32
  return %1 : i32
}