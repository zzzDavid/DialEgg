module {
  hw.module @ConcatVar(in %a : i8, in %b : i8, in %c : i8, out out : i72) {
    %0 = comb.concat %a, %b, %c, %a, %b, %c, %a, %b, %c : i8, i8, i8, i8, i8, i8, i8, i8, i8
    hw.output %0 : i72
  }
}
