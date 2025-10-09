module {
  hw.module @top_module(in %clk : i1, in %rst : i1, in %Data_In : i8, out Data_Out : i10) {
    %c0_i10 = hw.constant 0 : i10
    %c0_i2 = hw.constant 0 : i2
    %0 = comb.concat %c0_i2, %Data_In : i2, i8
    %1 = comb.mux %rst, %c0_i10, %0 : i10
    %2 = comb.mux %rst, %c0_i10, %FIR_29 : i10
    %3 = comb.mux %rst, %c0_i10, %FIR_28 : i10
    %4 = comb.mux %rst, %c0_i10, %FIR_27 : i10
    %5 = comb.mux %rst, %c0_i10, %FIR_26 : i10
    %6 = comb.mux %rst, %c0_i10, %FIR_25 : i10
    %7 = comb.mux %rst, %c0_i10, %FIR_24 : i10
    %8 = comb.mux %rst, %c0_i10, %FIR_23 : i10
    %9 = comb.mux %rst, %c0_i10, %FIR_22 : i10
    %10 = comb.mux %rst, %c0_i10, %FIR_21 : i10
    %11 = comb.mux %rst, %c0_i10, %FIR_20 : i10
    %12 = comb.mux %rst, %c0_i10, %FIR_19 : i10
    %13 = comb.mux %rst, %c0_i10, %FIR_18 : i10
    %14 = comb.mux %rst, %c0_i10, %FIR_17 : i10
    %15 = comb.mux %rst, %c0_i10, %FIR_16 : i10
    %16 = comb.mux %rst, %c0_i10, %FIR_15 : i10
    %17 = comb.mux %rst, %c0_i10, %FIR_14 : i10
    %18 = comb.mux %rst, %c0_i10, %FIR_13 : i10
    %19 = comb.mux %rst, %c0_i10, %FIR_12 : i10
    %20 = comb.mux %rst, %c0_i10, %FIR_11 : i10
    %21 = comb.mux %rst, %c0_i10, %FIR_10 : i10
    %22 = comb.mux %rst, %c0_i10, %FIR_9 : i10
    %23 = comb.mux %rst, %c0_i10, %FIR_8 : i10
    %24 = comb.mux %rst, %c0_i10, %FIR_7 : i10
    %25 = comb.mux %rst, %c0_i10, %FIR_6 : i10
    %26 = comb.mux %rst, %c0_i10, %FIR_5 : i10
    %27 = comb.mux %rst, %c0_i10, %FIR_4 : i10
    %28 = comb.mux %rst, %c0_i10, %FIR_3 : i10
    %29 = comb.mux %rst, %c0_i10, %FIR_2 : i10
    %30 = comb.mux %rst, %c0_i10, %FIR_1 : i10
    %31 = comb.mux %rst, %c0_i10, %FIR_0 : i10
    %32 = seq.to_clock %clk
    %FIR = seq.firreg %1 clock %32 : i10
    %FIR_0 = seq.firreg %2 clock %32 {name = "FIR"} : i10
    %FIR_1 = seq.firreg %3 clock %32 {name = "FIR"} : i10
    %FIR_2 = seq.firreg %4 clock %32 {name = "FIR"} : i10
    %FIR_3 = seq.firreg %5 clock %32 {name = "FIR"} : i10
    %FIR_4 = seq.firreg %6 clock %32 {name = "FIR"} : i10
    %FIR_5 = seq.firreg %7 clock %32 {name = "FIR"} : i10
    %FIR_6 = seq.firreg %8 clock %32 {name = "FIR"} : i10
    %FIR_7 = seq.firreg %9 clock %32 {name = "FIR"} : i10
    %FIR_8 = seq.firreg %10 clock %32 {name = "FIR"} : i10
    %FIR_9 = seq.firreg %11 clock %32 {name = "FIR"} : i10
    %FIR_10 = seq.firreg %12 clock %32 {name = "FIR"} : i10
    %FIR_11 = seq.firreg %13 clock %32 {name = "FIR"} : i10
    %FIR_12 = seq.firreg %14 clock %32 {name = "FIR"} : i10
    %FIR_13 = seq.firreg %15 clock %32 {name = "FIR"} : i10
    %FIR_14 = seq.firreg %16 clock %32 {name = "FIR"} : i10
    %FIR_15 = seq.firreg %17 clock %32 {name = "FIR"} : i10
    %FIR_16 = seq.firreg %18 clock %32 {name = "FIR"} : i10
    %FIR_17 = seq.firreg %19 clock %32 {name = "FIR"} : i10
    %FIR_18 = seq.firreg %20 clock %32 {name = "FIR"} : i10
    %FIR_19 = seq.firreg %21 clock %32 {name = "FIR"} : i10
    %FIR_20 = seq.firreg %22 clock %32 {name = "FIR"} : i10
    %FIR_21 = seq.firreg %23 clock %32 {name = "FIR"} : i10
    %FIR_22 = seq.firreg %24 clock %32 {name = "FIR"} : i10
    %FIR_23 = seq.firreg %25 clock %32 {name = "FIR"} : i10
    %FIR_24 = seq.firreg %26 clock %32 {name = "FIR"} : i10
    %FIR_25 = seq.firreg %27 clock %32 {name = "FIR"} : i10
    %FIR_26 = seq.firreg %28 clock %32 {name = "FIR"} : i10
    %FIR_27 = seq.firreg %29 clock %32 {name = "FIR"} : i10
    %FIR_28 = seq.firreg %30 clock %32 {name = "FIR"} : i10
    %FIR_29 = seq.firreg %31 clock %32 {name = "FIR"} : i10
    %c3_i10 = hw.constant 3 : i10
    %33 = comb.mul %0, %c3_i10 : i10
    %34 = comb.extract %FIR_29 from 0 : (i10) -> i9
    %false = hw.constant false
    %35 = comb.concat %34, %false : i9, i1
    %36 = comb.extract %FIR_20 from 0 : (i10) -> i8
    %37 = comb.concat %36, %c0_i2 : i8, i2
    %c12_i10 = hw.constant 12 : i10
    %38 = comb.mul %FIR_19, %c12_i10 : i10
    %c21_i10 = hw.constant 21 : i10
    %39 = comb.mul %FIR_18, %c21_i10 : i10
    %c30_i10 = hw.constant 30 : i10
    %40 = comb.mul %FIR_17, %c30_i10 : i10
    %c37_i10 = hw.constant 37 : i10
    %41 = comb.mul %FIR_16, %c37_i10 : i10
    %c41_i10 = hw.constant 41 : i10
    %42 = comb.mul %FIR_15, %c41_i10 : i10
    %43 = comb.mul %FIR_14, %c41_i10 : i10
    %44 = comb.mul %FIR_13, %c37_i10 : i10
    %45 = comb.mul %FIR_12, %c30_i10 : i10
    %46 = comb.mul %FIR_11, %c21_i10 : i10
    %47 = comb.mul %FIR_10, %c12_i10 : i10
    %48 = comb.extract %FIR_9 from 0 : (i10) -> i8
    %49 = comb.concat %48, %c0_i2 : i8, i2
    %50 = comb.extract %FIR_0 from 0 : (i10) -> i9
    %51 = comb.concat %50, %false : i9, i1
    %52 = comb.mul %FIR, %c3_i10 : i10
    %53 = comb.add %33, %35, %FIR_28, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %47, %49, %FIR_1, %51, %52 : i10
    hw.output %53 : i10
  }
}

