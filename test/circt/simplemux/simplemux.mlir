module {
  hw.module @SimpleMux(in %a : i32, in %b : i32, in %sel : i1, out out : i32) {
    %0 = comb.mux %sel, %b, %a : i32
    hw.output %0 : i32
  }
}
