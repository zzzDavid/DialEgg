module {
  hw.module @top_module(in %clk : i1, in %rst : i1, in %Data_In : i8, out Data_Out : i10) {
    %true = hw.constant true
    %c-1_i32 = hw.constant -1 : i32
    %c0_i10 = hw.constant 0 : i10
    %c41_i10 = hw.constant 41 : i10
    %c37_i10 = hw.constant 37 : i10
    %c30_i10 = hw.constant 30 : i10
    %c21_i10 = hw.constant 21 : i10
    %c12_i10 = hw.constant 12 : i10
    %c3_i10 = hw.constant 3 : i10
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c0_i5 = hw.constant 0 : i5
    %c1_i5 = hw.constant 1 : i5
    %c2_i5 = hw.constant 2 : i5
    %c10_i5 = hw.constant 10 : i5
    %c11_i5 = hw.constant 11 : i5
    %c12_i5 = hw.constant 12 : i5
    %c13_i5 = hw.constant 13 : i5
    %c14_i5 = hw.constant 14 : i5
    %c15_i5 = hw.constant 15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c0_i2 = hw.constant 0 : i2
    %c2_i32 = hw.constant 2 : i32
    %c1_i32 = hw.constant 1 : i32
    %c31_i32 = hw.constant 31 : i32
    %c32_i32 = hw.constant 32 : i32
    %false = hw.constant false
    %0 = comb.concat %c0_i2, %Data_In : i2, i8
    %1 = comb.mul %0, %c3_i10 : i10
    %2 = hw.array_get %FIR[%c-2_i5] : !hw.array<31xi10>, i5
    %3 = comb.extract %2 from 0 : (i10) -> i9
    %4 = comb.concat %3, %false : i9, i1
    %5 = hw.array_get %FIR[%c-3_i5] : !hw.array<31xi10>, i5
    %6 = hw.array_get %FIR[%c-11_i5] : !hw.array<31xi10>, i5
    %7 = comb.extract %6 from 0 : (i10) -> i8
    %8 = comb.concat %7, %c0_i2 : i8, i2
    %9 = hw.array_get %FIR[%c-12_i5] : !hw.array<31xi10>, i5
    %10 = comb.mul %9, %c12_i10 : i10
    %11 = hw.array_get %FIR[%c-13_i5] : !hw.array<31xi10>, i5
    %12 = comb.mul %11, %c21_i10 : i10
    %13 = hw.array_get %FIR[%c-14_i5] : !hw.array<31xi10>, i5
    %14 = comb.mul %13, %c30_i10 : i10
    %15 = hw.array_get %FIR[%c-15_i5] : !hw.array<31xi10>, i5
    %16 = comb.mul %15, %c37_i10 : i10
    %17 = hw.array_get %FIR[%c-16_i5] : !hw.array<31xi10>, i5
    %18 = comb.mul %17, %c41_i10 : i10
    %19 = hw.array_get %FIR[%c15_i5] : !hw.array<31xi10>, i5
    %20 = comb.mul %19, %c41_i10 : i10
    %21 = hw.array_get %FIR[%c14_i5] : !hw.array<31xi10>, i5
    %22 = comb.mul %21, %c37_i10 : i10
    %23 = hw.array_get %FIR[%c13_i5] : !hw.array<31xi10>, i5
    %24 = comb.mul %23, %c30_i10 : i10
    %25 = hw.array_get %FIR[%c12_i5] : !hw.array<31xi10>, i5
    %26 = comb.mul %25, %c21_i10 : i10
    %27 = hw.array_get %FIR[%c11_i5] : !hw.array<31xi10>, i5
    %28 = comb.mul %27, %c12_i10 : i10
    %29 = hw.array_get %FIR[%c10_i5] : !hw.array<31xi10>, i5
    %30 = comb.extract %29 from 0 : (i10) -> i8
    %31 = comb.concat %30, %c0_i2 : i8, i2
    %32 = hw.array_get %FIR[%c2_i5] : !hw.array<31xi10>, i5
    %33 = hw.array_get %FIR[%c1_i5] : !hw.array<31xi10>, i5
    %34 = comb.extract %33 from 0 : (i10) -> i9
    %35 = comb.concat %34, %false : i9, i1
    %36 = hw.array_get %FIR[%c0_i5] : !hw.array<31xi10>, i5
    %37 = comb.mul %36, %c3_i10 : i10
    %38 = comb.add %1, %4, %5, %8, %10, %12, %14, %16, %18, %20, %22, %24, %26, %28, %31, %32, %35, %37 : i10
    %39:4 = llhd.combinational -> i32, i1, !hw.array<31xi10>, i1 {
      cf.cond_br %rst, ^bb5(%c1_i32, %FIR, %false : i32, !hw.array<31xi10>, i1), ^bb1
    ^bb1:  // pred: ^bb0
      %43 = hw.array_inject %FIR[%c-2_i5], %0 : !hw.array<31xi10>, i5
      cf.br ^bb2(%c2_i32, %43 : i32, !hw.array<31xi10>)
    ^bb2(%44: i32, %45: !hw.array<31xi10>):  // 2 preds: ^bb1, ^bb3
      %46 = comb.icmp slt %44, %c32_i32 : i32
      cf.cond_br %46, ^bb3, ^bb4(%44, %true, %45, %true : i32, i1, !hw.array<31xi10>, i1)
    ^bb3:  // pred: ^bb2
      %47 = comb.sub %c31_i32, %44 : i32
      %48 = comb.extract %47 from 5 : (i32) -> i27
      %49 = comb.icmp eq %48, %c0_i27 : i27
      %50 = comb.extract %47 from 0 : (i32) -> i5
      %51 = comb.mux %49, %50, %c-1_i5 : i5
      %52 = comb.add %44, %c-1_i32 : i32
      %53 = comb.sub %c31_i32, %52 : i32
      %54 = comb.extract %53 from 5 : (i32) -> i27
      %55 = comb.icmp eq %54, %c0_i27 : i27
      %56 = comb.extract %53 from 0 : (i32) -> i5
      %57 = comb.mux %55, %56, %c-1_i5 : i5
      %58 = hw.array_get %FIR[%57] : !hw.array<31xi10>, i5
      %59 = hw.array_inject %45[%51], %58 : !hw.array<31xi10>, i5
      %60 = comb.add %44, %c1_i32 : i32
      cf.br ^bb2(%60, %59 : i32, !hw.array<31xi10>)
    ^bb4(%61: i32, %62: i1, %63: !hw.array<31xi10>, %64: i1):  // 2 preds: ^bb2, ^bb5
      llhd.yield %61, %62, %63, %64 : i32, i1, !hw.array<31xi10>, i1
    ^bb5(%65: i32, %66: !hw.array<31xi10>, %67: i1):  // 2 preds: ^bb0, ^bb6
      %68 = comb.icmp slt %65, %c32_i32 : i32
      cf.cond_br %68, ^bb6, ^bb4(%65, %true, %66, %67 : i32, i1, !hw.array<31xi10>, i1)
    ^bb6:  // pred: ^bb5
      %69 = comb.sub %c31_i32, %65 : i32
      %70 = comb.extract %69 from 5 : (i32) -> i27
      %71 = comb.icmp eq %70, %c0_i27 : i27
      %72 = comb.extract %69 from 0 : (i32) -> i5
      %73 = comb.mux %71, %72, %c-1_i5 : i5
      %74 = hw.array_inject %66[%73], %c0_i10 : !hw.array<31xi10>, i5
      %75 = comb.add %65, %c1_i32 : i32
      cf.br ^bb5(%75, %74, %true : i32, !hw.array<31xi10>, i1)
    }
    %40 = seq.to_clock %clk
    %41 = comb.mux bin %39#1, %39#0, %i : i32
    %i = seq.firreg %41 clock %40 : i32
    %42 = comb.mux bin %39#3, %39#2, %FIR : !hw.array<31xi10>
    %FIR = seq.firreg %42 clock %40 : !hw.array<31xi10>
    hw.output %38 : i10
  }
}
