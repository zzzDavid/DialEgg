module {
  hw.module @fir_input(in %arg0 : i16, in %arg1 : i16, in %arg2 : i16, out result : i16) {
    %c1_i16 = hw.constant 1 : i16
    %0 = comb.shl %arg1, %c1_i16 : i16
    %1 = comb.add %arg0, %0 : i16
    %2 = comb.add %1, %arg2 : i16
    hw.output %2 : i16
  }
}

