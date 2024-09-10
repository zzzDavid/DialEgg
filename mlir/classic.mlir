func.func @classic(%a: i64) -> i64 {
  %c2 = arith.constant 2 : i64
  %a2 = arith.muli %a, %c2 : i64
  %a_2 = arith.divsi %a2, %c2 : i64
  
  func.return %a_2 : i64
}