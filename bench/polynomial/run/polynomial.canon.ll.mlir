module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @displayTime(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @printF64Tensor1D(!llvm.ptr, !llvm.ptr, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @fillRandomF64Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(4.6566127999999998E-9 : f64) : f64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(12345 : i32) : i32
    %11 = llvm.mlir.constant(1103515245 : i32) : i32
    %12 = llvm.mlir.constant(0x41DFFFFFFFC00000 : f64) : f64
    %13 = llvm.mlir.constant(-1.000000e+01 : f64) : f64
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.alloca %15 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %16, %17 : !llvm.array<2 x i64>, !llvm.ptr
    %18 = llvm.getelementptr %17[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %19 = llvm.load %18 : !llvm.ptr -> i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.alloca %20 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %21, %22 : !llvm.array<2 x i64>, !llvm.ptr
    %23 = llvm.getelementptr %22[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %24 = llvm.load %23 : !llvm.ptr -> i64
    llvm.br ^bb1(%14 : i64)
  ^bb1(%25: i64):  // 2 preds: ^bb0, ^bb5
    %26 = llvm.icmp "slt" %25, %19 : i64
    llvm.cond_br %26, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%14 : i64)
  ^bb3(%27: i64):  // 2 preds: ^bb2, ^bb4
    %28 = llvm.icmp "slt" %27, %24 : i64
    llvm.cond_br %28, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %29 = llvm.trunc %27 : i64 to i32
    %30 = llvm.trunc %25 : i64 to i32
    %31 = llvm.mul %30, %11  : i32
    %32 = llvm.add %31, %10  : i32
    %33 = llvm.add %29, %32  : i32
    %34 = llvm.mul %33, %11  : i32
    %35 = llvm.add %34, %10  : i32
    %36 = llvm.sitofp %35 : i32 to f64
    %37 = llvm.fadd %36, %12  : f64
    %38 = llvm.fmul %37, %8  : f64
    %39 = llvm.fadd %38, %13  : f64
    %40 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %41 = llvm.mul %25, %arg5  : i64
    %42 = llvm.mul %27, %arg6  : i64
    %43 = llvm.add %41, %42  : i64
    %44 = llvm.getelementptr %40[%43] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %39, %44 : f64, !llvm.ptr
    %45 = llvm.add %27, %9  : i64
    llvm.br ^bb3(%45 : i64)
  ^bb5:  // pred: ^bb3
    %46 = llvm.add %25, %9  : i64
    llvm.br ^bb1(%46 : i64)
  ^bb6:  // pred: ^bb1
    llvm.return %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(3 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(1000000 : index) : i64
    %8 = llvm.mlir.constant(1000000 : index) : i64
    %9 = llvm.mlir.constant(5 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(5000000 : index) : i64
    %12 = llvm.mlir.zero : !llvm.ptr
    %13 = llvm.getelementptr %12[5000000] : (!llvm.ptr) -> !llvm.ptr, f64
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.mlir.constant(64 : index) : i64
    %16 = llvm.add %14, %15  : i64
    %17 = llvm.call @malloc(%16) : (i64) -> !llvm.ptr
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.sub %15, %19  : i64
    %21 = llvm.add %18, %20  : i64
    %22 = llvm.urem %21, %15  : i64
    %23 = llvm.sub %21, %22  : i64
    %24 = llvm.inttoptr %23 : i64 to !llvm.ptr
    %25 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = llvm.insertvalue %17, %25[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %24, %26[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.insertvalue %28, %27[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.insertvalue %8, %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %9, %30[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %9, %31[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %10, %32[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %33[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.extractvalue %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.extractvalue %33[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.extractvalue %33[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.extractvalue %33[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.extractvalue %33[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.call @fillRandomF64Tensor2D(%34, %35, %36, %37, %38, %39, %40) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %42 = llvm.call @clock() : () -> i64
    %43 = llvm.mlir.constant(1000000 : index) : i64
    %44 = llvm.mlir.constant(1 : index) : i64
    %45 = llvm.mlir.zero : !llvm.ptr
    %46 = llvm.getelementptr %45[1000000] : (!llvm.ptr) -> !llvm.ptr, f64
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.mlir.constant(64 : index) : i64
    %49 = llvm.add %47, %48  : i64
    %50 = llvm.call @malloc(%49) : (i64) -> !llvm.ptr
    %51 = llvm.ptrtoint %50 : !llvm.ptr to i64
    %52 = llvm.mlir.constant(1 : index) : i64
    %53 = llvm.sub %48, %52  : i64
    %54 = llvm.add %51, %53  : i64
    %55 = llvm.urem %54, %48  : i64
    %56 = llvm.sub %54, %55  : i64
    %57 = llvm.inttoptr %56 : i64 to !llvm.ptr
    %58 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %59 = llvm.insertvalue %50, %58[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %60 = llvm.insertvalue %57, %59[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.mlir.constant(0 : index) : i64
    %62 = llvm.insertvalue %61, %60[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %63 = llvm.insertvalue %43, %62[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %64 = llvm.insertvalue %44, %63[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%5, %64 : i64, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb1(%65: i64, %66: !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %67 = llvm.icmp "slt" %65, %7 : i64
    llvm.cond_br %67, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %68 = llvm.extractvalue %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.extractvalue %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %70 = llvm.getelementptr %68[%69] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %71 = llvm.extractvalue %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mul %65, %71  : i64
    %73 = llvm.extractvalue %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.mul %73, %5  : i64
    %75 = llvm.add %72, %74  : i64
    %76 = llvm.getelementptr %70[%75] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %77 = llvm.load %76 : !llvm.ptr -> f64
    %78 = llvm.extractvalue %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.extractvalue %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.getelementptr %78[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %81 = llvm.extractvalue %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %82 = llvm.mul %65, %81  : i64
    %83 = llvm.extractvalue %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %84 = llvm.mul %83, %4  : i64
    %85 = llvm.add %82, %84  : i64
    %86 = llvm.getelementptr %80[%85] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %87 = llvm.load %86 : !llvm.ptr -> f64
    %88 = llvm.extractvalue %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.extractvalue %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %90 = llvm.getelementptr %88[%89] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %91 = llvm.extractvalue %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %92 = llvm.mul %65, %91  : i64
    %93 = llvm.extractvalue %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %94 = llvm.mul %93, %3  : i64
    %95 = llvm.add %92, %94  : i64
    %96 = llvm.getelementptr %90[%95] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %97 = llvm.load %96 : !llvm.ptr -> f64
    %98 = llvm.extractvalue %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.extractvalue %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %100 = llvm.getelementptr %98[%99] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %101 = llvm.extractvalue %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.mul %65, %101  : i64
    %103 = llvm.extractvalue %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %104 = llvm.mul %103, %2  : i64
    %105 = llvm.add %102, %104  : i64
    %106 = llvm.getelementptr %100[%105] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %107 = llvm.load %106 : !llvm.ptr -> f64
    %108 = llvm.extractvalue %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.extractvalue %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.getelementptr %108[%109] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %111 = llvm.extractvalue %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.mul %65, %111  : i64
    %113 = llvm.extractvalue %41[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %114 = llvm.mul %113, %1  : i64
    %115 = llvm.add %112, %114  : i64
    %116 = llvm.getelementptr %110[%115] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %117 = llvm.load %116 : !llvm.ptr -> f64
    %118 = llvm.call @poly_eval_4(%77, %87, %97, %107, %117, %6) : (f64, f64, f64, f64, f64, f64) -> f64
    %119 = llvm.extractvalue %66[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %120 = llvm.getelementptr %119[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %118, %120 : f64, !llvm.ptr
    %121 = llvm.add %65, %4  : i64
    llvm.br ^bb1(%121, %66 : i64, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb3:  // pred: ^bb1
    %122 = llvm.call @clock() : () -> i64
    %123 = llvm.extractvalue %66[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %124 = llvm.extractvalue %66[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %125 = llvm.extractvalue %66[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %126 = llvm.extractvalue %66[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %127 = llvm.extractvalue %66[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @printF64Tensor1D(%123, %124, %125, %126, %127) : (!llvm.ptr, !llvm.ptr, i64, i64, i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @displayTime(%42, %122) : (i64, i64) -> ()
    llvm.return %0 : i32
  }
  llvm.func @poly_eval_4(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64, %arg5: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.intr.pow(%arg5, %0)  : (f64, f64) -> f64
    %4 = llvm.intr.pow(%arg5, %1)  : (f64, f64) -> f64
    %5 = llvm.intr.pow(%arg5, %2)  : (f64, f64) -> f64
    %6 = llvm.fmul %arg3, %arg5  : f64
    %7 = llvm.fmul %arg2, %3  : f64
    %8 = llvm.fmul %arg1, %4  : f64
    %9 = llvm.fmul %arg0, %5  : f64
    %10 = llvm.fadd %8, %9  : f64
    %11 = llvm.fadd %7, %10  : f64
    %12 = llvm.fadd %6, %11  : f64
    %13 = llvm.fadd %arg4, %12  : f64
    llvm.return %13 : f64
  }
}

