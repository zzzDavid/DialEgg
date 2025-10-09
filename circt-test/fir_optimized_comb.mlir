module {
  hw.module @fir_simple_optimized(in %delay0 : i16, in %delay1 : i16, in %delay2 : i16, out result : i16) {
    %c1_i16 = hw.constant 1 : i16
    %0 = comb.shl %delay1, %c1_i16 : i16
    %1 = comb.add %delay0, %0 : i16
    %2 = comb.add %1, %delay2 : i16
    hw.output %2 : i16
  }
}

