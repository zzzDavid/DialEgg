module {
  hw.module @top_module(in %clk : i1, in %rst : i1, in %Data_In : i8, out Data_Out : i10) {
    %c0_i10 = hw.constant 0 : i10
    %c41_i10 = hw.constant 41 : i10
    %c37_i10 = hw.constant 37 : i10
    %c30_i10 = hw.constant 30 : i10
    %c21_i10 = hw.constant 21 : i10
    %c12_i10 = hw.constant 12 : i10
    %c3_i10 = hw.constant 3 : i10
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %0 = comb.concat %c0_i2, %Data_In : i2, i8
    %1 = comb.mul %0, %c3_i10 : i10
    %2 = comb.extract %FIR_29 from 0 : (i10) -> i9
    %3 = comb.concat %2, %false : i9, i1
    %4 = comb.extract %FIR_20 from 0 : (i10) -> i8
    %5 = comb.concat %4, %c0_i2 : i8, i2
    %6 = comb.mul %FIR_19, %c12_i10 : i10
    %7 = comb.mul %FIR_18, %c21_i10 : i10
    %8 = comb.mul %FIR_17, %c30_i10 : i10
    %9 = comb.mul %FIR_16, %c37_i10 : i10
    %10 = comb.mul %FIR_15, %c41_i10 : i10
    %11 = comb.mul %FIR_14, %c41_i10 : i10
    %12 = comb.mul %FIR_13, %c37_i10 : i10
    %13 = comb.mul %FIR_12, %c30_i10 : i10
    %14 = comb.mul %FIR_11, %c21_i10 : i10
    %15 = comb.mul %FIR_10, %c12_i10 : i10
    %16 = comb.extract %FIR_9 from 0 : (i10) -> i8
    %17 = comb.concat %16, %c0_i2 : i8, i2
    %18 = comb.extract %FIR_0 from 0 : (i10) -> i9
    %19 = comb.concat %18, %false : i9, i1
    %20 = comb.mul %FIR, %c3_i10 : i10
    %21 = comb.add %1, %3, %FIR_28, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %17, %FIR_1, %19, %20 : i10
    %22 = comb.mux %rst, %c0_i10, %0 : i10
    %23 = comb.mux %rst, %c0_i10, %FIR_29 : i10
    %24 = comb.mux %rst, %c0_i10, %FIR_28 : i10
    %25 = comb.mux %rst, %c0_i10, %FIR_27 : i10
    %26 = comb.mux %rst, %c0_i10, %FIR_26 : i10
    %27 = comb.mux %rst, %c0_i10, %FIR_25 : i10
    %28 = comb.mux %rst, %c0_i10, %FIR_24 : i10
    %29 = comb.mux %rst, %c0_i10, %FIR_23 : i10
    %30 = comb.mux %rst, %c0_i10, %FIR_22 : i10
    %31 = comb.mux %rst, %c0_i10, %FIR_21 : i10
    %32 = comb.mux %rst, %c0_i10, %FIR_20 : i10
    %33 = comb.mux %rst, %c0_i10, %FIR_19 : i10
    %34 = comb.mux %rst, %c0_i10, %FIR_18 : i10
    %35 = comb.mux %rst, %c0_i10, %FIR_17 : i10
    %36 = comb.mux %rst, %c0_i10, %FIR_16 : i10
    %37 = comb.mux %rst, %c0_i10, %FIR_15 : i10
    %38 = comb.mux %rst, %c0_i10, %FIR_14 : i10
    %39 = comb.mux %rst, %c0_i10, %FIR_13 : i10
    %40 = comb.mux %rst, %c0_i10, %FIR_12 : i10
    %41 = comb.mux %rst, %c0_i10, %FIR_11 : i10
    %42 = comb.mux %rst, %c0_i10, %FIR_10 : i10
    %43 = comb.mux %rst, %c0_i10, %FIR_9 : i10
    %44 = comb.mux %rst, %c0_i10, %FIR_8 : i10
    %45 = comb.mux %rst, %c0_i10, %FIR_7 : i10
    %46 = comb.mux %rst, %c0_i10, %FIR_6 : i10
    %47 = comb.mux %rst, %c0_i10, %FIR_5 : i10
    %48 = comb.mux %rst, %c0_i10, %FIR_4 : i10
    %49 = comb.mux %rst, %c0_i10, %FIR_3 : i10
    %50 = comb.mux %rst, %c0_i10, %FIR_2 : i10
    %51 = comb.mux %rst, %c0_i10, %FIR_1 : i10
    %52 = comb.mux %rst, %c0_i10, %FIR_0 : i10
    %53 = seq.to_clock %clk
    %FIR = seq.firreg %22 clock %53 : i10
    %FIR_0 = seq.firreg %23 clock %53 {name = "FIR"} : i10
    %FIR_1 = seq.firreg %24 clock %53 {name = "FIR"} : i10
    %FIR_2 = seq.firreg %25 clock %53 {name = "FIR"} : i10
    %FIR_3 = seq.firreg %26 clock %53 {name = "FIR"} : i10
    %FIR_4 = seq.firreg %27 clock %53 {name = "FIR"} : i10
    %FIR_5 = seq.firreg %28 clock %53 {name = "FIR"} : i10
    %FIR_6 = seq.firreg %29 clock %53 {name = "FIR"} : i10
    %FIR_7 = seq.firreg %30 clock %53 {name = "FIR"} : i10
    %FIR_8 = seq.firreg %31 clock %53 {name = "FIR"} : i10
    %FIR_9 = seq.firreg %32 clock %53 {name = "FIR"} : i10
    %FIR_10 = seq.firreg %33 clock %53 {name = "FIR"} : i10
    %FIR_11 = seq.firreg %34 clock %53 {name = "FIR"} : i10
    %FIR_12 = seq.firreg %35 clock %53 {name = "FIR"} : i10
    %FIR_13 = seq.firreg %36 clock %53 {name = "FIR"} : i10
    %FIR_14 = seq.firreg %37 clock %53 {name = "FIR"} : i10
    %FIR_15 = seq.firreg %38 clock %53 {name = "FIR"} : i10
    %FIR_16 = seq.firreg %39 clock %53 {name = "FIR"} : i10
    %FIR_17 = seq.firreg %40 clock %53 {name = "FIR"} : i10
    %FIR_18 = seq.firreg %41 clock %53 {name = "FIR"} : i10
    %FIR_19 = seq.firreg %42 clock %53 {name = "FIR"} : i10
    %FIR_20 = seq.firreg %43 clock %53 {name = "FIR"} : i10
    %FIR_21 = seq.firreg %44 clock %53 {name = "FIR"} : i10
    %FIR_22 = seq.firreg %45 clock %53 {name = "FIR"} : i10
    %FIR_23 = seq.firreg %46 clock %53 {name = "FIR"} : i10
    %FIR_24 = seq.firreg %47 clock %53 {name = "FIR"} : i10
    %FIR_25 = seq.firreg %48 clock %53 {name = "FIR"} : i10
    %FIR_26 = seq.firreg %49 clock %53 {name = "FIR"} : i10
    %FIR_27 = seq.firreg %50 clock %53 {name = "FIR"} : i10
    %FIR_28 = seq.firreg %51 clock %53 {name = "FIR"} : i10
    %FIR_29 = seq.firreg %52 clock %53 {name = "FIR"} : i10
    hw.output %21 : i10
  }
}
