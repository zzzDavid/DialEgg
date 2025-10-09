module {
  hw.module @fir_filter(in %clk : i1, in %rst_n : i1, in %data_in : i8, out data_out : i18) {
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %c0_i7 = hw.constant 0 : i7
    %c0_i2 = hw.constant 0 : i2
    %c0_i8 = hw.constant 0 : i8
    %false = hw.constant false
    %0 = seq.to_clock %clk
    %1 = comb.xor %rst_n, %true : i1
    %delay0 = seq.firreg %data_in clock %0 reset async %1, %c0_i8 : i8
    %delay1 = seq.firreg %delay0 clock %0 reset async %1, %c0_i8 : i8
    %delay2 = seq.firreg %delay1 clock %0 reset async %1, %c0_i8 : i8
    %delay3 = seq.firreg %delay2 clock %0 reset async %1, %c0_i8 : i8
    %2 = comb.concat %c0_i8, %delay0 : i8, i8
    %3 = comb.concat %c0_i7, %delay1, %false : i7, i8, i1
    %4 = comb.add %2, %3 : i16
    %5 = comb.concat %c0_i2, %4 : i2, i16
    %6 = comb.concat %c0_i10, %delay2 : i10, i8
    %7 = comb.add %5, %6 : i18
    hw.output %7 : i18
  }
}
