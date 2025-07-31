module {
  hw.module @simplemux(in %a : i1, in %b : i1, in %sel : i1, out out : i1) {
    %0 = arith.select %sel, %a, %b : i1
    hw.output %0 : i1
  }
}

