module {
  hw.module @fir_filter(in %clk : i1, in %rst_n : i1, in %data_in : i8, out data_out : i18) {
    %c0_i10 = arith.constant 0 : i10
    %true = arith.constant true
    %c0_i7 = arith.constant 0 : i7
    %c0_i2 = arith.constant 0 : i2
    %c0_i8 = arith.constant 0 : i8
    %false = arith.constant false
    %0 = seq.to_clock %clk
    %1 = arith.xori %rst_n, %true : i1
    %delay0 = seq.firreg %data_in clock %0 reset async %1, %c0_i8 : i8
    %delay1 = seq.firreg %delay0 clock %0 reset async %1, %c0_i8 : i8
    %delay2 = seq.firreg %delay1 clock %0 reset async %1, %c0_i8 : i8
    %delay3 = seq.firreg %delay2 clock %0 reset async %1, %c0_i8 : i8
    %2 = arith.extui %delay0 : i8 to i16
    %c8_i16 = arith.constant 8 : i16
    %c0_i16 = arith.constant 0 : i16
    %c0_i16_0 = arith.constant 0 : i16
    %c0_i16_1 = arith.constant 0 : i16
    %c9_i16 = arith.constant 9 : i16
    %c0_i16_2 = arith.constant 0 : i16
    %c0_i16_3 = arith.constant 0 : i16
    %c1_i16 = arith.constant 1 : i16
    %3 = arith.extui %delay1 : i8 to i16
    %4 = arith.shli %3, %c1_i16 : i16
    %5 = arith.ori %4, %c0_i16_1 : i16
    %6 = arith.addi %2, %5 : i16
    %7 = arith.extui %6 : i16 to i18
    %c16_i18 = arith.constant 16 : i18
    %c0_i18 = arith.constant 0 : i18
    %c0_i18_4 = arith.constant 0 : i18
    %8 = arith.extui %delay2 : i8 to i18
    %c8_i18 = arith.constant 8 : i18
    %c0_i18_5 = arith.constant 0 : i18
    %c0_i18_6 = arith.constant 0 : i18
    %9 = arith.addi %7, %8 : i18
    hw.output %9 : i18
  }
}

