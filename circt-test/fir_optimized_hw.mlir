module {
  hw.module @fir_simple_optimized(in %delay0 : i16, in %delay1 : i16, in %delay2 : i16, out result : i16) {
    %c1_i16 = arith.constant 1 : i16
    %0 = arith.shli %delay1, %c1_i16 : i16
    %1 = arith.addi %delay0, %0 : i16
    %2 = arith.addi %1, %delay2 : i16
    hw.output %2 : i16
  }
} 