// RUN: %eggopt %s --eq-sat --egg-file=%S/vec_of_rule.egg | FileCheck %s

module {
  hw.module @VecOfRewrite(in %a : i8, in %b : i4, in %c : i4, out out : i16) {
    %0 = comb.concat %a, %b, %c : i8, i4, i4
    hw.output %0 : i16
  }
}

// CHECK-LABEL: hw.module @VecOfRewrite
// CHECK: %[[R:.*]] = comb.concat %a, %c, %b : i8, i4, i4
// CHECK: hw.output %[[R]] : i16

