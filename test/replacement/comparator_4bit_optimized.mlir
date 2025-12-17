module {
  hw.module @comparator_4bit(in %clk : i1, in %A : i4, in %B : i4, out A_greater : i1, out A_equal : i1, out A_less : i1) {
    %0 = seq.to_clock %clk
    %A_reg = seq.firreg %A clock %0 : i4
    %B_reg = seq.firreg %B clock %0 : i4
    %1 = comb.icmp slt %A_reg, %B_reg : i4
    %2 = seq.to_clock %clk
    %A_greater = seq.firreg %1 clock %2 : i1
    %3 = comb.icmp eq %A_reg, %B_reg : i4
    %A_equal = seq.firreg %3 clock %2 : i1
    %4 = comb.icmp sgt %A_reg, %B_reg : i4
    %A_less = seq.firreg %4 clock %2 : i1
    hw.output %A_greater, %A_equal, %A_less : i1, i1, i1
  }
}

