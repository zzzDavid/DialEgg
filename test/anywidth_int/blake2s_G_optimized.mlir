module {
  hw.module @blake2s_G(in %a : i32, in %b : i32, in %c : i32, in %d : i32, in %m0 : i32, in %m1 : i32, out a_prim : i32, out b_prim : i32, out c_prim : i32, out d_prim : i32) {
    %0 = comb.add %a, %b, %m0 : i32
    %1 = comb.xor %d, %0 : i32
    %2 = comb.extract %1 from 0 : (i32) -> i16
    %3 = comb.extract %1 from 16 : (i32) -> i16
    %4 = comb.concat %2, %3 : i16, i16
    %5 = comb.add %c, %4 : i32
    %6 = comb.xor %b, %5 : i32
    %7 = comb.extract %6 from 0 : (i32) -> i12
    %8 = comb.extract %6 from 12 : (i32) -> i20
    %9 = comb.concat %7, %8 : i12, i20
    %10 = comb.add %0, %9, %m1 : i32
    %11 = comb.xor %4, %10 : i32
    %12 = comb.extract %11 from 0 : (i32) -> i8
    %13 = comb.extract %11 from 8 : (i32) -> i24
    %14 = comb.concat %12, %13 : i8, i24
    %15 = comb.add %5, %14 : i32
    %16 = comb.xor %9, %15 : i32
    %17 = comb.extract %16 from 0 : (i32) -> i7
    %18 = comb.extract %16 from 7 : (i32) -> i25
    %19 = comb.concat %17, %18 : i7, i25
    hw.output %10, %19, %15, %14 : i32, i32, i32, i32
  }
}

