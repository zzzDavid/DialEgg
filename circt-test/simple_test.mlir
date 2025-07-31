module {
  func.func @simple_test(%a : i4, %b : i4) -> i4 {
    %0 = arith.ori %a, %b : i4
    %1 = arith.andi %a, %0 : i4
    func.return %1 : i4
  }
} 