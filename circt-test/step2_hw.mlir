module {
  hw.module @fir_input(in %delay0 : i16, in %delay1 : i16, in %delay2 : i16, out result : i16) {
    %false = hw.constant false
    %0 = comb.extract %delay1 from 0 : (i16) -> i15
    %1 = comb.concat %0, %false {sv.namehint = "delay1_doubled"} : i15, i1
    %2 = comb.add %delay0, %1, %delay2 {sv.namehint = "final_result"} : i16
    hw.output %2 : i16
  }
}
