module {
  hw.module @rr_arbiter(in %clk : i1, in %rst_n : i1, in %req : i4, out grant : i4) {
    %true = hw.constant true
    %c1_i4 = hw.constant 1 : i4
    %c0_i2 = hw.constant 0 : i2
    %c2_i4 = hw.constant 2 : i4
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c-1_i4 = hw.constant -1 : i4
    %c0_i28 = hw.constant 0 : i28
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %0 = comb.and %req, %mask : i4
    %1 = llhd.combinational -> i4 {
      cf.br ^bb1(%c0_i32 : i32)
    ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb4
      %7 = comb.icmp slt %6, %c4_i32 : i32
      cf.cond_br %7, ^bb2, ^bb5(%c0_i4 : i4)
    ^bb2:  // pred: ^bb1
      %8 = comb.extract %6 from 4 : (i32) -> i28
      %9 = comb.icmp eq %8, %c0_i28 : i28
      %10 = comb.extract %6 from 0 : (i32) -> i4
      %11 = comb.mux %9, %10, %c-1_i4 : i4
      %12 = comb.shru %0, %11 : i4
      %13 = comb.extract %12 from 0 : (i4) -> i1
      cf.cond_br %13, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %14 = comb.extract %6 from 2 : (i32) -> i30
      %15 = comb.icmp eq %14, %c0_i30 : i30
      %16 = comb.extract %6 from 0 : (i32) -> i2
      %17 = comb.mux %15, %16, %c-1_i2 : i2
      %18 = comb.concat %c0_i2, %17 : i2, i2
      %19 = comb.shl %c1_i4, %18 : i4
      cf.br ^bb5(%19 : i4)
    ^bb4:  // pred: ^bb2
      %20 = comb.add %6, %c1_i32 : i32
      cf.br ^bb1(%20 : i32)
    ^bb5(%21: i4):  // 2 preds: ^bb1, ^bb3
      %22 = comb.icmp eq %21, %c0_i4 : i4
      cf.cond_br %22, ^bb6(%c0_i32 : i32), ^bb10(%21 : i4)
    ^bb6(%23: i32):  // 2 preds: ^bb5, ^bb9
      %24 = comb.icmp slt %23, %c4_i32 : i32
      cf.cond_br %24, ^bb7, ^bb10(%21 : i4)
    ^bb7:  // pred: ^bb6
      %25 = comb.extract %23 from 4 : (i32) -> i28
      %26 = comb.icmp eq %25, %c0_i28 : i28
      %27 = comb.extract %23 from 0 : (i32) -> i4
      %28 = comb.mux %26, %27, %c-1_i4 : i4
      %29 = comb.shru %req, %28 : i4
      %30 = comb.extract %29 from 0 : (i4) -> i1
      cf.cond_br %30, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %31 = comb.extract %23 from 2 : (i32) -> i30
      %32 = comb.icmp eq %31, %c0_i30 : i30
      %33 = comb.extract %23 from 0 : (i32) -> i2
      %34 = comb.mux %32, %33, %c-1_i2 : i2
      %35 = comb.concat %c0_i2, %34 : i2, i2
      %36 = comb.shl %c1_i4, %35 : i4
      %37 = comb.xor bin %36, %c-1_i4 : i4
      %38 = comb.and %21, %37 : i4
      %39 = comb.or %38, %36 : i4
      cf.br ^bb10(%39 : i4)
    ^bb9:  // pred: ^bb7
      %40 = comb.add %23, %c1_i32 : i32
      cf.br ^bb6(%40 : i32)
    ^bb10(%41: i4):  // 3 preds: ^bb5, ^bb6, ^bb8
      llhd.yield %41 : i4
    }
    %2:2 = llhd.combinational -> i4, i1 {
      cf.br ^bb1(%c0_i32 : i32)
    ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb5
      %7 = comb.icmp slt %6, %c4_i32 : i32
      cf.cond_br %7, ^bb2, ^bb3(%c0_i4, %false : i4, i1)
    ^bb2:  // pred: ^bb1
      %8 = comb.extract %6 from 4 : (i32) -> i28
      %9 = comb.icmp eq %8, %c0_i28 : i28
      %10 = comb.extract %6 from 0 : (i32) -> i4
      %11 = comb.mux %9, %10, %c-1_i4 : i4
      %12 = comb.shru %1, %11 : i4
      %13 = comb.extract %12 from 0 : (i4) -> i1
      cf.cond_br %13, ^bb4, ^bb5
    ^bb3(%14: i4, %15: i1):  // 2 preds: ^bb1, ^bb4
      llhd.yield %14, %15 : i4, i1
    ^bb4:  // pred: ^bb2
      %16 = comb.extract %1 from 0 : (i4) -> i3
      %17 = comb.extract %1 from 3 : (i4) -> i1
      %18 = comb.concat %16, %17 : i3, i1
      cf.br ^bb3(%18, %true : i4, i1)
    ^bb5:  // pred: ^bb2
      %19 = comb.add %6, %c1_i32 : i32
      cf.br ^bb1(%19 : i32)
    }
    %3 = seq.to_clock %clk
    %4 = comb.xor %rst_n, %true : i1
    %5 = comb.mux bin %2#1, %2#0, %mask : i4
    %mask = seq.firreg %5 clock %3 reset async %4, %c2_i4 : i4
    hw.output %1 : i4
  }
}
