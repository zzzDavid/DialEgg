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
    %8 = llvm.mlir.constant(5 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mul %8, %7  : i64
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.mlir.constant(64 : index) : i64
    %15 = llvm.add %13, %14  : i64
    %16 = llvm.call @malloc(%15) : (i64) -> !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i64
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.sub %14, %18  : i64
    %20 = llvm.add %17, %19  : i64
    %21 = llvm.urem %20, %14  : i64
    %22 = llvm.sub %20, %21  : i64
    %23 = llvm.inttoptr %22 : i64 to !llvm.ptr
    %24 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = llvm.insertvalue %16, %24[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %23, %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.insertvalue %27, %26[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.insertvalue %7, %28[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.insertvalue %8, %29[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %8, %30[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %9, %31[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %32[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.extractvalue %32[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.extractvalue %32[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.extractvalue %32[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.extractvalue %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.extractvalue %32[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.call @fillRandomF64Tensor2D(%33, %34, %35, %36, %37, %38, %39) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %41 = llvm.call @clock() : () -> i64
    %42 = llvm.mlir.constant(1000000 : index) : i64
    %43 = llvm.mlir.constant(1 : index) : i64
    %44 = llvm.mlir.zero : !llvm.ptr
    %45 = llvm.getelementptr %44[1000000] : (!llvm.ptr) -> !llvm.ptr, f64
    %46 = llvm.ptrtoint %45 : !llvm.ptr to i64
    %47 = llvm.mlir.constant(64 : index) : i64
    %48 = llvm.add %46, %47  : i64
    %49 = llvm.call @malloc(%48) : (i64) -> !llvm.ptr
    %50 = llvm.ptrtoint %49 : !llvm.ptr to i64
    %51 = llvm.mlir.constant(1 : index) : i64
    %52 = llvm.sub %47, %51  : i64
    %53 = llvm.add %50, %52  : i64
    %54 = llvm.urem %53, %47  : i64
    %55 = llvm.sub %53, %54  : i64
    %56 = llvm.inttoptr %55 : i64 to !llvm.ptr
    %57 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %58 = llvm.insertvalue %49, %57[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %59 = llvm.insertvalue %56, %58[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %60 = llvm.mlir.constant(0 : index) : i64
    %61 = llvm.insertvalue %60, %59[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %62 = llvm.insertvalue %42, %61[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %63 = llvm.insertvalue %43, %62[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%5, %63 : i64, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb1(%64: i64, %65: !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %66 = llvm.icmp "slt" %64, %7 : i64
    llvm.cond_br %66, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %67 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %68 = llvm.extractvalue %40[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.getelementptr %67[%68] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %70 = llvm.extractvalue %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %71 = llvm.mul %64, %70  : i64
    %72 = llvm.extractvalue %40[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %73 = llvm.mul %72, %5  : i64
    %74 = llvm.add %71, %73  : i64
    %75 = llvm.getelementptr %69[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %76 = llvm.load %75 : !llvm.ptr -> f64
    %77 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %78 = llvm.extractvalue %40[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.getelementptr %77[%78] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %80 = llvm.extractvalue %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %81 = llvm.mul %64, %80  : i64
    %82 = llvm.extractvalue %40[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %83 = llvm.mul %82, %4  : i64
    %84 = llvm.add %81, %83  : i64
    %85 = llvm.getelementptr %79[%84] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %86 = llvm.load %85 : !llvm.ptr -> f64
    %87 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %88 = llvm.extractvalue %40[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.getelementptr %87[%88] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %90 = llvm.extractvalue %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %91 = llvm.mul %64, %90  : i64
    %92 = llvm.extractvalue %40[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %93 = llvm.mul %92, %3  : i64
    %94 = llvm.add %91, %93  : i64
    %95 = llvm.getelementptr %89[%94] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %96 = llvm.load %95 : !llvm.ptr -> f64
    %97 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %98 = llvm.extractvalue %40[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.getelementptr %97[%98] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %100 = llvm.extractvalue %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.mul %64, %100  : i64
    %102 = llvm.extractvalue %40[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.mul %102, %2  : i64
    %104 = llvm.add %101, %103  : i64
    %105 = llvm.getelementptr %99[%104] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %106 = llvm.load %105 : !llvm.ptr -> f64
    %107 = llvm.extractvalue %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.extractvalue %40[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.getelementptr %107[%108] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %110 = llvm.extractvalue %40[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.mul %64, %110  : i64
    %112 = llvm.extractvalue %40[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.mul %112, %1  : i64
    %114 = llvm.add %111, %113  : i64
    %115 = llvm.getelementptr %109[%114] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %116 = llvm.load %115 : !llvm.ptr -> f64
    %117 = llvm.call @poly_eval_4(%76, %86, %96, %106, %116, %6) : (f64, f64, f64, f64, f64, f64) -> f64
    %118 = llvm.extractvalue %65[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %119 = llvm.getelementptr %118[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %117, %119 : f64, !llvm.ptr
    %120 = llvm.add %64, %4  : i64
    llvm.br ^bb1(%120, %65 : i64, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb3:  // pred: ^bb1
    %121 = llvm.call @clock() : () -> i64
    %122 = llvm.extractvalue %65[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %123 = llvm.extractvalue %65[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %124 = llvm.extractvalue %65[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %125 = llvm.extractvalue %65[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %126 = llvm.extractvalue %65[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @printF64Tensor1D(%122, %123, %124, %125, %126) : (!llvm.ptr, !llvm.ptr, i64, i64, i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @displayTime(%41, %121) : (i64, i64) -> ()
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

