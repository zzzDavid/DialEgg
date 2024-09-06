module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  llvm.func @fillRandomI64Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(2.3283063999999999E-9 : f64) : f64
    %9 = llvm.mlir.constant(12345 : i32) : i32
    %10 = llvm.mlir.constant(1103515245 : i32) : i32
    %11 = llvm.mlir.constant(0x41DFFFFFFFC00000 : f64) : f64
    %12 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.alloca %15 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %16, %17 : !llvm.array<2 x i64>, !llvm.ptr
    %18 = llvm.getelementptr %17[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %19 = llvm.load %18 : !llvm.ptr -> i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.alloca %20 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %21, %22 : !llvm.array<2 x i64>, !llvm.ptr
    %23 = llvm.getelementptr %22[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %24 = llvm.load %23 : !llvm.ptr -> i64
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.mul %19, %24  : i64
    %27 = llvm.mlir.zero : !llvm.ptr
    %28 = llvm.getelementptr %27[%26] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.mlir.constant(64 : index) : i64
    %31 = llvm.add %29, %30  : i64
    %32 = llvm.call @malloc(%31) : (i64) -> !llvm.ptr
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.mlir.constant(1 : index) : i64
    %35 = llvm.sub %30, %34  : i64
    %36 = llvm.add %33, %35  : i64
    %37 = llvm.urem %36, %30  : i64
    %38 = llvm.sub %36, %37  : i64
    %39 = llvm.inttoptr %38 : i64 to !llvm.ptr
    %40 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %41 = llvm.insertvalue %32, %40[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.insertvalue %39, %41[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.insertvalue %43, %42[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.insertvalue %24, %44[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.insertvalue %19, %45[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.insertvalue %19, %46[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.insertvalue %25, %47[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%13 : i64)
  ^bb1(%49: i64):  // 2 preds: ^bb0, ^bb5
    %50 = llvm.icmp "slt" %49, %24 : i64
    llvm.cond_br %50, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%13 : i64)
  ^bb3(%51: i64):  // 2 preds: ^bb2, ^bb4
    %52 = llvm.icmp "slt" %51, %19 : i64
    llvm.cond_br %52, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %53 = llvm.trunc %51 : i64 to i32
    %54 = llvm.trunc %49 : i64 to i32
    %55 = llvm.mul %54, %10  : i32
    %56 = llvm.add %55, %9  : i32
    %57 = llvm.add %53, %56  : i32
    %58 = llvm.mul %57, %10  : i32
    %59 = llvm.add %58, %9  : i32
    %60 = llvm.sitofp %59 : i32 to f64
    %61 = llvm.fadd %60, %11  : f64
    %62 = llvm.fmul %61, %8  : f64
    %63 = llvm.fadd %62, %12  : f64
    %64 = llvm.mul %49, %19  : i64
    %65 = llvm.add %64, %51  : i64
    %66 = llvm.getelementptr %39[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %63, %66 : f64, !llvm.ptr
    %67 = llvm.add %51, %14  : i64
    llvm.br ^bb3(%67 : i64)
  ^bb5:  // pred: ^bb3
    %68 = llvm.add %49, %14  : i64
    llvm.br ^bb1(%68 : i64)
  ^bb6:  // pred: ^bb1
    llvm.br ^bb7(%13 : i64)
  ^bb7(%69: i64):  // 2 preds: ^bb6, ^bb11
    %70 = llvm.icmp "slt" %69, %24 : i64
    llvm.cond_br %70, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9(%13 : i64)
  ^bb9(%71: i64):  // 2 preds: ^bb8, ^bb10
    %72 = llvm.icmp "slt" %71, %19 : i64
    llvm.cond_br %72, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %73 = llvm.mul %69, %19  : i64
    %74 = llvm.add %73, %71  : i64
    %75 = llvm.getelementptr %39[%74] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %76 = llvm.load %75 : !llvm.ptr -> f64
    %77 = llvm.intr.floor(%76)  : (f64) -> f64
    %78 = llvm.mul %69, %19  : i64
    %79 = llvm.add %78, %71  : i64
    %80 = llvm.getelementptr %39[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %77, %80 : f64, !llvm.ptr
    %81 = llvm.add %71, %14  : i64
    llvm.br ^bb9(%81 : i64)
  ^bb11:  // pred: ^bb9
    %82 = llvm.add %69, %14  : i64
    llvm.br ^bb7(%82 : i64)
  ^bb12:  // pred: ^bb7
    %83 = llvm.mlir.constant(1 : index) : i64
    %84 = llvm.mul %19, %24  : i64
    %85 = llvm.mlir.zero : !llvm.ptr
    %86 = llvm.getelementptr %85[%84] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %87 = llvm.ptrtoint %86 : !llvm.ptr to i64
    %88 = llvm.mlir.constant(64 : index) : i64
    %89 = llvm.add %87, %88  : i64
    %90 = llvm.call @malloc(%89) : (i64) -> !llvm.ptr
    %91 = llvm.ptrtoint %90 : !llvm.ptr to i64
    %92 = llvm.mlir.constant(1 : index) : i64
    %93 = llvm.sub %88, %92  : i64
    %94 = llvm.add %91, %93  : i64
    %95 = llvm.urem %94, %88  : i64
    %96 = llvm.sub %94, %95  : i64
    %97 = llvm.inttoptr %96 : i64 to !llvm.ptr
    %98 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %99 = llvm.insertvalue %90, %98[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %100 = llvm.insertvalue %97, %99[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.mlir.constant(0 : index) : i64
    %102 = llvm.insertvalue %101, %100[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.insertvalue %24, %102[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %104 = llvm.insertvalue %19, %103[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.insertvalue %19, %104[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.insertvalue %83, %105[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb13(%13 : i64)
  ^bb13(%107: i64):  // 2 preds: ^bb12, ^bb17
    %108 = llvm.icmp "slt" %107, %24 : i64
    llvm.cond_br %108, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    llvm.br ^bb15(%13 : i64)
  ^bb15(%109: i64):  // 2 preds: ^bb14, ^bb16
    %110 = llvm.icmp "slt" %109, %19 : i64
    llvm.cond_br %110, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %111 = llvm.mul %107, %19  : i64
    %112 = llvm.add %111, %109  : i64
    %113 = llvm.getelementptr %39[%112] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %114 = llvm.load %113 : !llvm.ptr -> f64
    %115 = llvm.fptosi %114 : f64 to i64
    %116 = llvm.mul %107, %19  : i64
    %117 = llvm.add %116, %109  : i64
    %118 = llvm.getelementptr %97[%117] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %115, %118 : i64, !llvm.ptr
    %119 = llvm.add %109, %14  : i64
    llvm.br ^bb15(%119 : i64)
  ^bb17:  // pred: ^bb15
    %120 = llvm.add %107, %14  : i64
    llvm.br ^bb13(%120 : i64)
  ^bb18:  // pred: ^bb13
    llvm.return %106 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @xy_z(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %arg7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %arg8, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg9, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg10, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg12, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg11, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg13, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %arg14, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %arg15, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %arg16, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %arg17, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg19, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg18, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %arg20, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(8 : index) : i64
    %25 = llvm.mlir.constant(10 : index) : i64
    %26 = llvm.mlir.constant(150 : index) : i64
    %27 = llvm.mlir.constant(1 : index) : i64
    %28 = llvm.mlir.constant(100 : index) : i64
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.mlir.constant(100 : index) : i64
    %31 = llvm.mlir.constant(150 : index) : i64
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.constant(15000 : index) : i64
    %34 = llvm.mlir.zero : !llvm.ptr
    %35 = llvm.getelementptr %34[15000] : (!llvm.ptr) -> !llvm.ptr, i64
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i64
    %37 = llvm.mlir.constant(64 : index) : i64
    %38 = llvm.add %36, %37  : i64
    %39 = llvm.call @malloc(%38) : (i64) -> !llvm.ptr
    %40 = llvm.ptrtoint %39 : !llvm.ptr to i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.sub %37, %41  : i64
    %43 = llvm.add %40, %42  : i64
    %44 = llvm.urem %43, %37  : i64
    %45 = llvm.sub %43, %44  : i64
    %46 = llvm.inttoptr %45 : i64 to !llvm.ptr
    %47 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %48 = llvm.insertvalue %39, %47[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.insertvalue %46, %48[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.mlir.constant(0 : index) : i64
    %51 = llvm.insertvalue %50, %49[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.insertvalue %30, %51[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %31, %52[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %31, %53[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %32, %54[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%29 : i64)
  ^bb1(%56: i64):  // 2 preds: ^bb0, ^bb8
    %57 = llvm.icmp "slt" %56, %28 : i64
    llvm.cond_br %57, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%29 : i64)
  ^bb3(%58: i64):  // 2 preds: ^bb2, ^bb7
    %59 = llvm.icmp "slt" %58, %26 : i64
    llvm.cond_br %59, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%29 : i64)
  ^bb5(%60: i64):  // 2 preds: ^bb4, ^bb6
    %61 = llvm.icmp "slt" %60, %25 : i64
    llvm.cond_br %61, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %62 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %63 = llvm.mul %56, %arg5  : i64
    %64 = llvm.mul %60, %arg6  : i64
    %65 = llvm.add %63, %64  : i64
    %66 = llvm.getelementptr %62[%65] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %67 = llvm.load %66 : !llvm.ptr -> i64
    %68 = llvm.getelementptr %arg8[%arg9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %69 = llvm.mul %60, %arg12  : i64
    %70 = llvm.mul %58, %arg13  : i64
    %71 = llvm.add %69, %70  : i64
    %72 = llvm.getelementptr %68[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %73 = llvm.load %72 : !llvm.ptr -> i64
    %74 = llvm.mlir.constant(150 : index) : i64
    %75 = llvm.mul %56, %74  : i64
    %76 = llvm.add %75, %58  : i64
    %77 = llvm.getelementptr %46[%76] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %78 = llvm.load %77 : !llvm.ptr -> i64
    %79 = llvm.mul %67, %73  : i64
    %80 = llvm.add %78, %79  : i64
    %81 = llvm.mlir.constant(150 : index) : i64
    %82 = llvm.mul %56, %81  : i64
    %83 = llvm.add %82, %58  : i64
    %84 = llvm.getelementptr %46[%83] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %80, %84 : i64, !llvm.ptr
    %85 = llvm.add %60, %27  : i64
    llvm.br ^bb5(%85 : i64)
  ^bb7:  // pred: ^bb5
    %86 = llvm.add %58, %27  : i64
    llvm.br ^bb3(%86 : i64)
  ^bb8:  // pred: ^bb3
    %87 = llvm.add %56, %27  : i64
    llvm.br ^bb1(%87 : i64)
  ^bb9:  // pred: ^bb1
    %88 = llvm.mlir.constant(100 : index) : i64
    %89 = llvm.mlir.constant(8 : index) : i64
    %90 = llvm.mlir.constant(1 : index) : i64
    %91 = llvm.mlir.constant(800 : index) : i64
    %92 = llvm.mlir.zero : !llvm.ptr
    %93 = llvm.getelementptr %92[800] : (!llvm.ptr) -> !llvm.ptr, i64
    %94 = llvm.ptrtoint %93 : !llvm.ptr to i64
    %95 = llvm.mlir.constant(64 : index) : i64
    %96 = llvm.add %94, %95  : i64
    %97 = llvm.call @malloc(%96) : (i64) -> !llvm.ptr
    %98 = llvm.ptrtoint %97 : !llvm.ptr to i64
    %99 = llvm.mlir.constant(1 : index) : i64
    %100 = llvm.sub %95, %99  : i64
    %101 = llvm.add %98, %100  : i64
    %102 = llvm.urem %101, %95  : i64
    %103 = llvm.sub %101, %102  : i64
    %104 = llvm.inttoptr %103 : i64 to !llvm.ptr
    %105 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %106 = llvm.insertvalue %97, %105[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.insertvalue %104, %106[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.mlir.constant(0 : index) : i64
    %109 = llvm.insertvalue %108, %107[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.insertvalue %88, %109[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.insertvalue %89, %110[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.insertvalue %89, %111[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.insertvalue %90, %112[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb10(%29 : i64)
  ^bb10(%114: i64):  // 2 preds: ^bb9, ^bb17
    %115 = llvm.icmp "slt" %114, %28 : i64
    llvm.cond_br %115, ^bb11, ^bb18
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%29 : i64)
  ^bb12(%116: i64):  // 2 preds: ^bb11, ^bb16
    %117 = llvm.icmp "slt" %116, %24 : i64
    llvm.cond_br %117, ^bb13, ^bb17
  ^bb13:  // pred: ^bb12
    llvm.br ^bb14(%29 : i64)
  ^bb14(%118: i64):  // 2 preds: ^bb13, ^bb15
    %119 = llvm.icmp "slt" %118, %26 : i64
    llvm.cond_br %119, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    %120 = llvm.mlir.constant(150 : index) : i64
    %121 = llvm.mul %114, %120  : i64
    %122 = llvm.add %121, %118  : i64
    %123 = llvm.getelementptr %46[%122] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %124 = llvm.load %123 : !llvm.ptr -> i64
    %125 = llvm.getelementptr %arg15[%arg16] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %126 = llvm.mul %118, %arg19  : i64
    %127 = llvm.mul %116, %arg20  : i64
    %128 = llvm.add %126, %127  : i64
    %129 = llvm.getelementptr %125[%128] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %130 = llvm.load %129 : !llvm.ptr -> i64
    %131 = llvm.mlir.constant(8 : index) : i64
    %132 = llvm.mul %114, %131  : i64
    %133 = llvm.add %132, %116  : i64
    %134 = llvm.getelementptr %104[%133] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %135 = llvm.load %134 : !llvm.ptr -> i64
    %136 = llvm.mul %124, %130  : i64
    %137 = llvm.add %135, %136  : i64
    %138 = llvm.mlir.constant(8 : index) : i64
    %139 = llvm.mul %114, %138  : i64
    %140 = llvm.add %139, %116  : i64
    %141 = llvm.getelementptr %104[%140] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %137, %141 : i64, !llvm.ptr
    %142 = llvm.add %118, %27  : i64
    llvm.br ^bb14(%142 : i64)
  ^bb16:  // pred: ^bb14
    %143 = llvm.add %116, %27  : i64
    llvm.br ^bb12(%143 : i64)
  ^bb17:  // pred: ^bb12
    %144 = llvm.add %114, %27  : i64
    llvm.br ^bb10(%144 : i64)
  ^bb18:  // pred: ^bb10
    llvm.return %113 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @x_yz(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %arg7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %arg8, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg9, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg10, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg12, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg11, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg13, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = llvm.insertvalue %arg14, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %arg15, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %arg16, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %arg17, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg19, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg18, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %arg20, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(100 : index) : i64
    %25 = llvm.mlir.constant(150 : index) : i64
    %26 = llvm.mlir.constant(8 : index) : i64
    %27 = llvm.mlir.constant(1 : index) : i64
    %28 = llvm.mlir.constant(10 : index) : i64
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.mlir.constant(10 : index) : i64
    %31 = llvm.mlir.constant(8 : index) : i64
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.constant(80 : index) : i64
    %34 = llvm.mlir.zero : !llvm.ptr
    %35 = llvm.getelementptr %34[80] : (!llvm.ptr) -> !llvm.ptr, i64
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i64
    %37 = llvm.mlir.constant(64 : index) : i64
    %38 = llvm.add %36, %37  : i64
    %39 = llvm.call @malloc(%38) : (i64) -> !llvm.ptr
    %40 = llvm.ptrtoint %39 : !llvm.ptr to i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.sub %37, %41  : i64
    %43 = llvm.add %40, %42  : i64
    %44 = llvm.urem %43, %37  : i64
    %45 = llvm.sub %43, %44  : i64
    %46 = llvm.inttoptr %45 : i64 to !llvm.ptr
    %47 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %48 = llvm.insertvalue %39, %47[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.insertvalue %46, %48[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.mlir.constant(0 : index) : i64
    %51 = llvm.insertvalue %50, %49[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.insertvalue %30, %51[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %31, %52[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %31, %53[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %32, %54[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%29 : i64)
  ^bb1(%56: i64):  // 2 preds: ^bb0, ^bb8
    %57 = llvm.icmp "slt" %56, %28 : i64
    llvm.cond_br %57, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%29 : i64)
  ^bb3(%58: i64):  // 2 preds: ^bb2, ^bb7
    %59 = llvm.icmp "slt" %58, %26 : i64
    llvm.cond_br %59, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%29 : i64)
  ^bb5(%60: i64):  // 2 preds: ^bb4, ^bb6
    %61 = llvm.icmp "slt" %60, %25 : i64
    llvm.cond_br %61, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %62 = llvm.getelementptr %arg8[%arg9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %63 = llvm.mul %56, %arg12  : i64
    %64 = llvm.mul %60, %arg13  : i64
    %65 = llvm.add %63, %64  : i64
    %66 = llvm.getelementptr %62[%65] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %67 = llvm.load %66 : !llvm.ptr -> i64
    %68 = llvm.getelementptr %arg15[%arg16] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %69 = llvm.mul %60, %arg19  : i64
    %70 = llvm.mul %58, %arg20  : i64
    %71 = llvm.add %69, %70  : i64
    %72 = llvm.getelementptr %68[%71] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %73 = llvm.load %72 : !llvm.ptr -> i64
    %74 = llvm.mlir.constant(8 : index) : i64
    %75 = llvm.mul %56, %74  : i64
    %76 = llvm.add %75, %58  : i64
    %77 = llvm.getelementptr %46[%76] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %78 = llvm.load %77 : !llvm.ptr -> i64
    %79 = llvm.mul %67, %73  : i64
    %80 = llvm.add %78, %79  : i64
    %81 = llvm.mlir.constant(8 : index) : i64
    %82 = llvm.mul %56, %81  : i64
    %83 = llvm.add %82, %58  : i64
    %84 = llvm.getelementptr %46[%83] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %80, %84 : i64, !llvm.ptr
    %85 = llvm.add %60, %27  : i64
    llvm.br ^bb5(%85 : i64)
  ^bb7:  // pred: ^bb5
    %86 = llvm.add %58, %27  : i64
    llvm.br ^bb3(%86 : i64)
  ^bb8:  // pred: ^bb3
    %87 = llvm.add %56, %27  : i64
    llvm.br ^bb1(%87 : i64)
  ^bb9:  // pred: ^bb1
    %88 = llvm.mlir.constant(100 : index) : i64
    %89 = llvm.mlir.constant(8 : index) : i64
    %90 = llvm.mlir.constant(1 : index) : i64
    %91 = llvm.mlir.constant(800 : index) : i64
    %92 = llvm.mlir.zero : !llvm.ptr
    %93 = llvm.getelementptr %92[800] : (!llvm.ptr) -> !llvm.ptr, i64
    %94 = llvm.ptrtoint %93 : !llvm.ptr to i64
    %95 = llvm.mlir.constant(64 : index) : i64
    %96 = llvm.add %94, %95  : i64
    %97 = llvm.call @malloc(%96) : (i64) -> !llvm.ptr
    %98 = llvm.ptrtoint %97 : !llvm.ptr to i64
    %99 = llvm.mlir.constant(1 : index) : i64
    %100 = llvm.sub %95, %99  : i64
    %101 = llvm.add %98, %100  : i64
    %102 = llvm.urem %101, %95  : i64
    %103 = llvm.sub %101, %102  : i64
    %104 = llvm.inttoptr %103 : i64 to !llvm.ptr
    %105 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %106 = llvm.insertvalue %97, %105[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.insertvalue %104, %106[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.mlir.constant(0 : index) : i64
    %109 = llvm.insertvalue %108, %107[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.insertvalue %88, %109[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.insertvalue %89, %110[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.insertvalue %89, %111[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.insertvalue %90, %112[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb10(%29 : i64)
  ^bb10(%114: i64):  // 2 preds: ^bb9, ^bb17
    %115 = llvm.icmp "slt" %114, %24 : i64
    llvm.cond_br %115, ^bb11, ^bb18
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%29 : i64)
  ^bb12(%116: i64):  // 2 preds: ^bb11, ^bb16
    %117 = llvm.icmp "slt" %116, %26 : i64
    llvm.cond_br %117, ^bb13, ^bb17
  ^bb13:  // pred: ^bb12
    llvm.br ^bb14(%29 : i64)
  ^bb14(%118: i64):  // 2 preds: ^bb13, ^bb15
    %119 = llvm.icmp "slt" %118, %28 : i64
    llvm.cond_br %119, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    %120 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %121 = llvm.mul %114, %arg5  : i64
    %122 = llvm.mul %118, %arg6  : i64
    %123 = llvm.add %121, %122  : i64
    %124 = llvm.getelementptr %120[%123] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %125 = llvm.load %124 : !llvm.ptr -> i64
    %126 = llvm.mlir.constant(8 : index) : i64
    %127 = llvm.mul %118, %126  : i64
    %128 = llvm.add %127, %116  : i64
    %129 = llvm.getelementptr %46[%128] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %130 = llvm.load %129 : !llvm.ptr -> i64
    %131 = llvm.mlir.constant(8 : index) : i64
    %132 = llvm.mul %114, %131  : i64
    %133 = llvm.add %132, %116  : i64
    %134 = llvm.getelementptr %104[%133] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %135 = llvm.load %134 : !llvm.ptr -> i64
    %136 = llvm.mul %125, %130  : i64
    %137 = llvm.add %135, %136  : i64
    %138 = llvm.mlir.constant(8 : index) : i64
    %139 = llvm.mul %114, %138  : i64
    %140 = llvm.add %139, %116  : i64
    %141 = llvm.getelementptr %104[%140] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %137, %141 : i64, !llvm.ptr
    %142 = llvm.add %118, %27  : i64
    llvm.br ^bb14(%142 : i64)
  ^bb16:  // pred: ^bb14
    %143 = llvm.add %116, %27  : i64
    llvm.br ^bb12(%143 : i64)
  ^bb17:  // pred: ^bb12
    %144 = llvm.add %114, %27  : i64
    llvm.br ^bb10(%144 : i64)
  ^bb18:  // pred: ^bb10
    llvm.return %113 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @displayTime(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1.000000e+06 : f64) : f64
    %1 = llvm.sub %arg1, %arg0  : i64
    %2 = llvm.uitofp %1 : i64 to f64
    %3 = llvm.fdiv %2, %0  : f64
    %4 = llvm.mlir.addressof @time : !llvm.ptr
    llvm.call @printNewline() : () -> ()
    llvm.call @printNewline() : () -> ()
    %5 = llvm.call @printf(%4, %1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    llvm.return
  }
  llvm.func @main() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @clock() : () -> i64
    %2 = llvm.mlir.constant(100 : index) : i64
    %3 = llvm.mlir.constant(10 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(1000 : index) : i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.getelementptr %6[1000] : (!llvm.ptr) -> !llvm.ptr, i64
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.mlir.constant(64 : index) : i64
    %10 = llvm.add %8, %9  : i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr
    %12 = llvm.ptrtoint %11 : !llvm.ptr to i64
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.sub %9, %13  : i64
    %15 = llvm.add %12, %14  : i64
    %16 = llvm.urem %15, %9  : i64
    %17 = llvm.sub %15, %16  : i64
    %18 = llvm.inttoptr %17 : i64 to !llvm.ptr
    %19 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = llvm.insertvalue %11, %19[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.insertvalue %22, %21[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %2, %23[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %3, %24[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %3, %25[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %4, %26[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.extractvalue %27[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.extractvalue %27[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.extractvalue %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.extractvalue %27[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %27[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %27[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.call @fillRandomI64Tensor2D(%28, %29, %30, %31, %32, %33, %34) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = llvm.mlir.constant(10 : index) : i64
    %37 = llvm.mlir.constant(150 : index) : i64
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.mlir.constant(1500 : index) : i64
    %40 = llvm.mlir.zero : !llvm.ptr
    %41 = llvm.getelementptr %40[1500] : (!llvm.ptr) -> !llvm.ptr, i64
    %42 = llvm.ptrtoint %41 : !llvm.ptr to i64
    %43 = llvm.mlir.constant(64 : index) : i64
    %44 = llvm.add %42, %43  : i64
    %45 = llvm.call @malloc(%44) : (i64) -> !llvm.ptr
    %46 = llvm.ptrtoint %45 : !llvm.ptr to i64
    %47 = llvm.mlir.constant(1 : index) : i64
    %48 = llvm.sub %43, %47  : i64
    %49 = llvm.add %46, %48  : i64
    %50 = llvm.urem %49, %43  : i64
    %51 = llvm.sub %49, %50  : i64
    %52 = llvm.inttoptr %51 : i64 to !llvm.ptr
    %53 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %54 = llvm.insertvalue %45, %53[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %52, %54[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.mlir.constant(0 : index) : i64
    %57 = llvm.insertvalue %56, %55[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %36, %57[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %37, %58[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.insertvalue %37, %59[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.insertvalue %38, %60[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.extractvalue %61[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %63 = llvm.extractvalue %61[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.extractvalue %61[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %65 = llvm.extractvalue %61[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %66 = llvm.extractvalue %61[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %67 = llvm.extractvalue %61[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %68 = llvm.extractvalue %61[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.call @fillRandomI64Tensor2D(%62, %63, %64, %65, %66, %67, %68) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %70 = llvm.mlir.constant(150 : index) : i64
    %71 = llvm.mlir.constant(8 : index) : i64
    %72 = llvm.mlir.constant(1 : index) : i64
    %73 = llvm.mlir.constant(1200 : index) : i64
    %74 = llvm.mlir.zero : !llvm.ptr
    %75 = llvm.getelementptr %74[1200] : (!llvm.ptr) -> !llvm.ptr, i64
    %76 = llvm.ptrtoint %75 : !llvm.ptr to i64
    %77 = llvm.mlir.constant(64 : index) : i64
    %78 = llvm.add %76, %77  : i64
    %79 = llvm.call @malloc(%78) : (i64) -> !llvm.ptr
    %80 = llvm.ptrtoint %79 : !llvm.ptr to i64
    %81 = llvm.mlir.constant(1 : index) : i64
    %82 = llvm.sub %77, %81  : i64
    %83 = llvm.add %80, %82  : i64
    %84 = llvm.urem %83, %77  : i64
    %85 = llvm.sub %83, %84  : i64
    %86 = llvm.inttoptr %85 : i64 to !llvm.ptr
    %87 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %88 = llvm.insertvalue %79, %87[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.insertvalue %86, %88[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %90 = llvm.mlir.constant(0 : index) : i64
    %91 = llvm.insertvalue %90, %89[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %92 = llvm.insertvalue %70, %91[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %93 = llvm.insertvalue %71, %92[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %94 = llvm.insertvalue %71, %93[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %95 = llvm.insertvalue %72, %94[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %96 = llvm.extractvalue %95[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %97 = llvm.extractvalue %95[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %98 = llvm.extractvalue %95[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.extractvalue %95[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %100 = llvm.extractvalue %95[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.extractvalue %95[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.extractvalue %95[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.call @fillRandomI64Tensor2D(%96, %97, %98, %99, %100, %101, %102) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %104 = llvm.extractvalue %35[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.extractvalue %35[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.extractvalue %35[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.extractvalue %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.extractvalue %35[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.extractvalue %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.extractvalue %35[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.extractvalue %69[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.extractvalue %69[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.extractvalue %69[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %114 = llvm.extractvalue %69[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %115 = llvm.extractvalue %69[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %116 = llvm.extractvalue %69[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.extractvalue %69[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %118 = llvm.extractvalue %103[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %119 = llvm.extractvalue %103[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %120 = llvm.extractvalue %103[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %121 = llvm.extractvalue %103[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %122 = llvm.extractvalue %103[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %123 = llvm.extractvalue %103[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %124 = llvm.extractvalue %103[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %125 = llvm.call @xy_z(%104, %105, %106, %107, %108, %109, %110, %111, %112, %113, %114, %115, %116, %117, %118, %119, %120, %121, %122, %123, %124) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %126 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%1, %126) : (i64, i64) -> ()
    llvm.return %0 : f32
  }
}

