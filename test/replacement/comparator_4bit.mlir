module {
  hw.module @comparator_4bit(in %clk : i1, in %A : i4, in %B : i4, out A_greater : i1, out A_equal : i1, out A_less : i1) {
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %0 = comb.concat %false, %A_reg : i1, i4
    %1 = comb.concat %false, %B_reg : i1, i4
    %2 = comb.sub %0, %1 : i5
    %3 = comb.extract %2 from 4 {sv.namehint = "cout"} : (i5) -> i1
    %4 = comb.extract %2 from 0 {sv.namehint = "diff"} : (i5) -> i4
    %5 = comb.xor %3, %true : i1
    %6 = comb.icmp ne %4, %c0_i4 : i4
    %7 = comb.and %5, %6 : i1
    %8 = comb.icmp eq %A_reg, %B_reg : i4
    %9 = seq.to_clock %clk
    %A_reg = seq.firreg %A clock %9 : i4
    %B_reg = seq.firreg %B clock %9 : i4
    %A_greater = seq.firreg %7 clock %9 : i1
    %A_equal = seq.firreg %8 clock %9 : i1
    %A_less = seq.firreg %3 clock %9 : i1
    hw.output %A_greater, %A_equal, %A_less : i1, i1, i1
  }
}
