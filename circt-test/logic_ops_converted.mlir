module {
  hw.module @logic_ops(in %a : i4, in %b : i4, out out1 : i4, out out2 : i4, out out3 : i4) {
    %c0_i3 = arith.constant 0 : i3
    %c0_i4 = arith.constant 0 : i4
    %0 = arith.cmpi ne, %a, %c0_i4 : i4
    %1 = arith.extui %0 : i1 to i4
    %c1_i4 = arith.constant 1 : i4
    %c0_i4_0 = arith.constant 0 : i4
    %c0_i4_1 = arith.constant 0 : i4
    %2 = arith.ori %a, %b : i4
    %3 = arith.andi %a, %2 : i4
    hw.output %1, %a, %3 : i4, i4, i4
  }
}

