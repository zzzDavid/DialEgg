module {
  hw.module @logic_ops(in %a : i4, in %b : i4, out out1 : i4, out out2 : i4, out out3 : i4) {
    %c0_i3 = hw.constant 0 : i3
    %c0_i4 = hw.constant 0 : i4
    %0 = comb.icmp ne %a, %c0_i4 : i4
    %1 = comb.concat %c0_i3, %0 : i3, i1
    %2 = comb.or %a, %b : i4
    %3 = comb.and %a, %2 : i4
    hw.output %1, %a, %3 : i4, i4, i4
  }
}
