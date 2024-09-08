module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
  llvm.func @printF32(f32) attributes {sym_visibility = "private"}
  llvm.func @printComma() attributes {sym_visibility = "private"}
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @putchar(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  llvm.func @displayTime(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1.000000e+06 : f64) : f64
    %1 = llvm.sub %arg1, %arg0  : i64
    %2 = llvm.uitofp %1 : i64 to f64
    %3 = llvm.fdiv %2, %0  : f64
    %4 = llvm.mlir.addressof @time : !llvm.ptr
    %5 = llvm.call @printf(%4, %1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    llvm.return
  }
  llvm.func @fillRandomF64Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(4.6566127999999999E-4 : f64) : f64
    %9 = llvm.mlir.constant(12345 : i32) : i32
    %10 = llvm.mlir.constant(1103515245 : i32) : i32
    %11 = llvm.mlir.constant(0x41DFFFFFFFC00000 : f64) : f64
    %12 = llvm.mlir.constant(-1.000000e+06 : f64) : f64
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.mlir.constant(1000000 : index) : i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.constant(3 : index) : i64
    llvm.br ^bb1(%13 : i64)
  ^bb1(%17: i64):  // 2 preds: ^bb0, ^bb5
    %18 = llvm.icmp "slt" %17, %14 : i64
    llvm.cond_br %18, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%13 : i64)
  ^bb3(%19: i64):  // 2 preds: ^bb2, ^bb4
    %20 = llvm.icmp "slt" %19, %16 : i64
    llvm.cond_br %20, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %21 = llvm.trunc %19 : i64 to i32
    %22 = llvm.trunc %17 : i64 to i32
    %23 = llvm.mul %22, %10  : i32
    %24 = llvm.add %23, %9  : i32
    %25 = llvm.add %21, %24  : i32
    %26 = llvm.mul %25, %10  : i32
    %27 = llvm.add %26, %9  : i32
    %28 = llvm.sitofp %27 : i32 to f64
    %29 = llvm.fadd %28, %11  : f64
    %30 = llvm.fmul %29, %8  : f64
    %31 = llvm.fadd %30, %12  : f64
    %32 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %33 = llvm.mul %17, %arg5  : i64
    %34 = llvm.mul %19, %arg6  : i64
    %35 = llvm.add %33, %34  : i64
    %36 = llvm.getelementptr %32[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %31, %36 : f64, !llvm.ptr
    %37 = llvm.add %19, %15  : i64
    llvm.br ^bb3(%37 : i64)
  ^bb5:  // pred: ^bb3
    %38 = llvm.add %17, %15  : i64
    llvm.br ^bb1(%38 : i64)
  ^bb6:  // pred: ^bb1
    llvm.return %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @printF64Tensor1D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.constant(93 : i32) : i32
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.constant(91 : i32) : i32
    %10 = llvm.call @putchar(%9) : (i32) -> i32
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.extractvalue %4[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.alloca %11 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %12, %13 : !llvm.array<1 x i64>, !llvm.ptr
    %14 = llvm.getelementptr %13[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %15 = llvm.load %14 : !llvm.ptr -> i64
    llvm.br ^bb1(%7 : i64)
  ^bb1(%16: i64):  // 2 preds: ^bb0, ^bb4
    %17 = llvm.icmp "slt" %16, %15 : i64
    llvm.cond_br %17, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %18 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %19 = llvm.mul %16, %arg4  : i64
    %20 = llvm.getelementptr %18[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %21 = llvm.load %20 : !llvm.ptr -> f64
    llvm.call @printF64(%21) : (f64) -> ()
    %22 = llvm.sub %15, %8  : i64
    %23 = llvm.icmp "ult" %16, %22 : i64
    llvm.cond_br %23, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.call @printComma() : () -> ()
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %24 = llvm.add %16, %8  : i64
    llvm.br ^bb1(%24 : i64)
  ^bb5:  // pred: ^bb1
    %25 = llvm.call @putchar(%6) : (i32) -> i32
    llvm.return
  }
  llvm.func @printF64Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(93 : i32) : i32
    %9 = llvm.mlir.constant(9 : i32) : i32
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.mlir.constant(91 : i32) : i32
    %13 = llvm.call @putchar(%12) : (i32) -> i32
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.alloca %14 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %15, %16 : !llvm.array<2 x i64>, !llvm.ptr
    %17 = llvm.getelementptr %16[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %18 = llvm.load %17 : !llvm.ptr -> i64
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.alloca %19 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %20, %21 : !llvm.array<2 x i64>, !llvm.ptr
    %22 = llvm.getelementptr %21[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %23 = llvm.load %22 : !llvm.ptr -> i64
    llvm.br ^bb1(%10 : i64)
  ^bb1(%24: i64):  // 2 preds: ^bb0, ^bb4
    %25 = llvm.icmp "slt" %24, %18 : i64
    llvm.cond_br %25, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %27 = llvm.insertvalue %arg0, %26[0] : !llvm.struct<(ptr, ptr, i64)> 
    %28 = llvm.insertvalue %arg1, %27[1] : !llvm.struct<(ptr, ptr, i64)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr, ptr, i64)> 
    %31 = llvm.mul %24, %arg5  : i64
    %32 = llvm.add %arg2, %31  : i64
    %33 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %34 = llvm.insertvalue %arg0, %33[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = llvm.insertvalue %arg1, %34[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.insertvalue %32, %35[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.insertvalue %23, %36[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.insertvalue %arg6, %37[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @printNewline() : () -> ()
    %39 = llvm.call @putchar(%9) : (i32) -> i32
    %40 = llvm.extractvalue %38[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.extractvalue %38[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %42 = llvm.extractvalue %38[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.extractvalue %38[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.extractvalue %38[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @printF64Tensor1D(%40, %41, %42, %43, %44) : (!llvm.ptr, !llvm.ptr, i64, i64, i64) -> ()
    %45 = llvm.sub %18, %11  : i64
    %46 = llvm.icmp "ult" %24, %45 : i64
    llvm.cond_br %46, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.call @printComma() : () -> ()
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %47 = llvm.add %24, %11  : i64
    llvm.br ^bb1(%47 : i64)
  ^bb5:  // pred: ^bb1
    %48 = llvm.icmp "sgt" %18, %10 : i64
    llvm.cond_br %48, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.call @printNewline() : () -> ()
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    %49 = llvm.call @putchar(%8) : (i32) -> i32
    llvm.return
  }
  llvm.func @printF32Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.alloca %10 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %11, %12 : !llvm.array<2 x i64>, !llvm.ptr
    %13 = llvm.getelementptr %12[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %14 = llvm.load %13 : !llvm.ptr -> i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.alloca %15 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %16, %17 : !llvm.array<2 x i64>, !llvm.ptr
    %18 = llvm.getelementptr %17[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %19 = llvm.load %18 : !llvm.ptr -> i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mul %19, %14  : i64
    %22 = llvm.mlir.zero : !llvm.ptr
    %23 = llvm.getelementptr %22[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %24 = llvm.ptrtoint %23 : !llvm.ptr to i64
    %25 = llvm.mlir.constant(64 : index) : i64
    %26 = llvm.add %24, %25  : i64
    %27 = llvm.call @malloc(%26) : (i64) -> !llvm.ptr
    %28 = llvm.ptrtoint %27 : !llvm.ptr to i64
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.sub %25, %29  : i64
    %31 = llvm.add %28, %30  : i64
    %32 = llvm.urem %31, %25  : i64
    %33 = llvm.sub %31, %32  : i64
    %34 = llvm.inttoptr %33 : i64 to !llvm.ptr
    %35 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %36 = llvm.insertvalue %27, %35[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %34, %36[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.mlir.constant(0 : index) : i64
    %39 = llvm.insertvalue %38, %37[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.insertvalue %14, %39[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.insertvalue %19, %40[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.insertvalue %19, %41[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.insertvalue %20, %42[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.mlir.constant(1 : index) : i64
    %45 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.alloca %44 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %45, %46 : !llvm.array<2 x i64>, !llvm.ptr
    %47 = llvm.getelementptr %46[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %48 = llvm.load %47 : !llvm.ptr -> i64
    %49 = llvm.mlir.constant(1 : index) : i64
    %50 = llvm.extractvalue %6[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.alloca %49 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %50, %51 : !llvm.array<2 x i64>, !llvm.ptr
    %52 = llvm.getelementptr %51[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %53 = llvm.load %52 : !llvm.ptr -> i64
    llvm.br ^bb1(%9 : i64)
  ^bb1(%54: i64):  // 2 preds: ^bb0, ^bb5
    %55 = llvm.icmp "slt" %54, %48 : i64
    llvm.cond_br %55, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%9 : i64)
  ^bb3(%56: i64):  // 2 preds: ^bb2, ^bb4
    %57 = llvm.icmp "slt" %56, %53 : i64
    llvm.cond_br %57, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %58 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %59 = llvm.mul %54, %arg5  : i64
    %60 = llvm.mul %56, %arg6  : i64
    %61 = llvm.add %59, %60  : i64
    %62 = llvm.getelementptr %58[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %63 = llvm.load %62 : !llvm.ptr -> f32
    %64 = llvm.fpext %63 : f32 to f64
    %65 = llvm.mul %54, %19  : i64
    %66 = llvm.add %65, %56  : i64
    %67 = llvm.getelementptr %34[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %64, %67 : f64, !llvm.ptr
    %68 = llvm.add %56, %8  : i64
    llvm.br ^bb3(%68 : i64)
  ^bb5:  // pred: ^bb3
    %69 = llvm.add %54, %8  : i64
    llvm.br ^bb1(%69 : i64)
  ^bb6:  // pred: ^bb1
    %70 = llvm.extractvalue %43[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %71 = llvm.extractvalue %43[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.extractvalue %43[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %73 = llvm.extractvalue %43[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.extractvalue %43[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %75 = llvm.extractvalue %43[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %76 = llvm.extractvalue %43[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @printF64Tensor2D(%70, %71, %72, %73, %74, %75, %76) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.return
  }
  llvm.func @blackhole(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.return %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @fast_inv_sqrt(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.mlir.constant(1.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1597463007 : i32) : i32
    %4 = llvm.fmul %arg0, %1  : f32
    %5 = llvm.bitcast %arg0 : f32 to i32
    %6 = llvm.ashr %5, %0  : i32
    %7 = llvm.sub %3, %6  : i32
    %8 = llvm.bitcast %7 : i32 to f32
    %9 = llvm.fmul %8, %8  : f32
    %10 = llvm.fmul %4, %9  : f32
    %11 = llvm.fsub %2, %10  : f32
    %12 = llvm.fmul %8, %11  : f32
    llvm.return %12 : f32
  }
  llvm.func @normalize_vector(%arg0: f32, %arg1: f32, %arg2: f32) -> !llvm.struct<(f32, f32, f32)> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg1, %arg1  : f32
    %3 = llvm.fmul %arg2, %arg2  : f32
    %4 = llvm.fadd %1, %2  : f32
    %5 = llvm.fadd %4, %3  : f32
    %6 = llvm.intr.sqrt(%5)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %7 = llvm.fdiv %0, %6  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %8 = llvm.fmul %arg0, %7  : f32
    %9 = llvm.fmul %arg1, %7  : f32
    %10 = llvm.fmul %arg2, %7  : f32
    %11 = llvm.mlir.undef : !llvm.struct<(f32, f32, f32)>
    %12 = llvm.insertvalue %8, %11[0] : !llvm.struct<(f32, f32, f32)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<(f32, f32, f32)> 
    %14 = llvm.insertvalue %10, %13[2] : !llvm.struct<(f32, f32, f32)> 
    llvm.return %14 : !llvm.struct<(f32, f32, f32)>
  }
  llvm.func @normalize_distance_vectors(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(2 : index) : i64
    %11 = llvm.mlir.constant(1000000 : index) : i64
    %12 = llvm.mlir.constant(1000000 : index) : i64
    %13 = llvm.mlir.constant(3 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(3000000 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[3000000] : (!llvm.ptr) -> !llvm.ptr, f32
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.mlir.constant(64 : index) : i64
    %20 = llvm.add %18, %19  : i64
    %21 = llvm.call @malloc(%20) : (i64) -> !llvm.ptr
    %22 = llvm.ptrtoint %21 : !llvm.ptr to i64
    %23 = llvm.mlir.constant(1 : index) : i64
    %24 = llvm.sub %19, %23  : i64
    %25 = llvm.add %22, %24  : i64
    %26 = llvm.urem %25, %19  : i64
    %27 = llvm.sub %25, %26  : i64
    %28 = llvm.inttoptr %27 : i64 to !llvm.ptr
    %29 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = llvm.insertvalue %21, %29[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %28, %30[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.mlir.constant(0 : index) : i64
    %33 = llvm.insertvalue %32, %31[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %12, %33[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.insertvalue %13, %34[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %13, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %14, %36[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%8, %37 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb1(%38: i64, %39: !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>):  // 2 preds: ^bb0, ^bb2
    %40 = llvm.icmp "slt" %38, %11 : i64
    llvm.cond_br %40, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %41 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %42 = llvm.mul %38, %arg5  : i64
    %43 = llvm.mul %arg6, %8  : i64
    %44 = llvm.add %42, %43  : i64
    %45 = llvm.getelementptr %41[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %46 = llvm.load %45 : !llvm.ptr -> f32
    %47 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %48 = llvm.mul %38, %arg5  : i64
    %49 = llvm.mul %arg6, %9  : i64
    %50 = llvm.add %48, %49  : i64
    %51 = llvm.getelementptr %47[%50] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %52 = llvm.load %51 : !llvm.ptr -> f32
    %53 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %54 = llvm.mul %38, %arg5  : i64
    %55 = llvm.mul %arg6, %10  : i64
    %56 = llvm.add %54, %55  : i64
    %57 = llvm.getelementptr %53[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %58 = llvm.load %57 : !llvm.ptr -> f32
    %59 = llvm.call @normalize_vector(%46, %52, %58) : (f32, f32, f32) -> !llvm.struct<(f32, f32, f32)>
    %60 = llvm.extractvalue %59[0] : !llvm.struct<(f32, f32, f32)> 
    %61 = llvm.extractvalue %59[1] : !llvm.struct<(f32, f32, f32)> 
    %62 = llvm.extractvalue %59[2] : !llvm.struct<(f32, f32, f32)> 
    %63 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.mlir.constant(3 : index) : i64
    %65 = llvm.mul %38, %64  : i64
    %66 = llvm.add %65, %8  : i64
    %67 = llvm.getelementptr %63[%66] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %60, %67 : f32, !llvm.ptr
    %68 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.mlir.constant(3 : index) : i64
    %70 = llvm.mul %38, %69  : i64
    %71 = llvm.add %70, %9  : i64
    %72 = llvm.getelementptr %68[%71] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %61, %72 : f32, !llvm.ptr
    %73 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.mlir.constant(3 : index) : i64
    %75 = llvm.mul %38, %74  : i64
    %76 = llvm.add %75, %10  : i64
    %77 = llvm.getelementptr %73[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %62, %77 : f32, !llvm.ptr
    %78 = llvm.add %38, %9  : i64
    llvm.br ^bb1(%78, %39 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb3:  // pred: ^bb1
    llvm.return %39 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(1000000 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1000000 : index) : i64
    %6 = llvm.mlir.constant(3 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(3000000 : index) : i64
    %9 = llvm.mlir.zero : !llvm.ptr
    %10 = llvm.getelementptr %9[3000000] : (!llvm.ptr) -> !llvm.ptr, f64
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.mlir.constant(64 : index) : i64
    %13 = llvm.add %11, %12  : i64
    %14 = llvm.call @malloc(%13) : (i64) -> !llvm.ptr
    %15 = llvm.ptrtoint %14 : !llvm.ptr to i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.sub %12, %16  : i64
    %18 = llvm.add %15, %17  : i64
    %19 = llvm.urem %18, %12  : i64
    %20 = llvm.sub %18, %19  : i64
    %21 = llvm.inttoptr %20 : i64 to !llvm.ptr
    %22 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = llvm.insertvalue %14, %22[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %21, %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %5, %26[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %6, %27[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.insertvalue %6, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.insertvalue %7, %29[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.extractvalue %30[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.extractvalue %30[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %30[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %30[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.extractvalue %30[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.extractvalue %30[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.extractvalue %30[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.call @fillRandomF64Tensor2D(%31, %32, %33, %34, %35, %36, %37) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %39 = llvm.mlir.constant(1000000 : index) : i64
    %40 = llvm.mlir.constant(3 : index) : i64
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.mlir.constant(3000000 : index) : i64
    %43 = llvm.mlir.zero : !llvm.ptr
    %44 = llvm.getelementptr %43[3000000] : (!llvm.ptr) -> !llvm.ptr, f32
    %45 = llvm.ptrtoint %44 : !llvm.ptr to i64
    %46 = llvm.mlir.constant(64 : index) : i64
    %47 = llvm.add %45, %46  : i64
    %48 = llvm.call @malloc(%47) : (i64) -> !llvm.ptr
    %49 = llvm.ptrtoint %48 : !llvm.ptr to i64
    %50 = llvm.mlir.constant(1 : index) : i64
    %51 = llvm.sub %46, %50  : i64
    %52 = llvm.add %49, %51  : i64
    %53 = llvm.urem %52, %46  : i64
    %54 = llvm.sub %52, %53  : i64
    %55 = llvm.inttoptr %54 : i64 to !llvm.ptr
    %56 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %57 = llvm.insertvalue %48, %56[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %55, %57[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.mlir.constant(0 : index) : i64
    %60 = llvm.insertvalue %59, %58[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.insertvalue %39, %60[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.insertvalue %40, %61[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %63 = llvm.insertvalue %40, %62[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.insertvalue %41, %63[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%3 : i64)
  ^bb1(%65: i64):  // 2 preds: ^bb0, ^bb5
    %66 = llvm.icmp "slt" %65, %2 : i64
    llvm.cond_br %66, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%3 : i64)
  ^bb3(%67: i64):  // 2 preds: ^bb2, ^bb4
    %68 = llvm.icmp "slt" %67, %0 : i64
    llvm.cond_br %68, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %69 = llvm.extractvalue %38[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %70 = llvm.extractvalue %38[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %71 = llvm.getelementptr %69[%70] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %72 = llvm.extractvalue %38[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %73 = llvm.mul %65, %72  : i64
    %74 = llvm.extractvalue %38[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %75 = llvm.mul %67, %74  : i64
    %76 = llvm.add %73, %75  : i64
    %77 = llvm.getelementptr %71[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %78 = llvm.load %77 : !llvm.ptr -> f64
    %79 = llvm.fptrunc %78 : f64 to f32
    %80 = llvm.mlir.constant(3 : index) : i64
    %81 = llvm.mul %65, %80  : i64
    %82 = llvm.add %81, %67  : i64
    %83 = llvm.getelementptr %55[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %79, %83 : f32, !llvm.ptr
    %84 = llvm.add %67, %1  : i64
    llvm.br ^bb3(%84 : i64)
  ^bb5:  // pred: ^bb3
    %85 = llvm.add %65, %1  : i64
    llvm.br ^bb1(%85 : i64)
  ^bb6:  // pred: ^bb1
    %86 = llvm.call @clock() : () -> i64
    %87 = llvm.extractvalue %64[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %88 = llvm.extractvalue %64[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.extractvalue %64[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %90 = llvm.extractvalue %64[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %91 = llvm.extractvalue %64[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %92 = llvm.extractvalue %64[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %93 = llvm.extractvalue %64[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %94 = llvm.call @normalize_distance_vectors(%87, %88, %89, %90, %91, %92, %93) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %95 = llvm.call @clock() : () -> i64
    %96 = llvm.extractvalue %94[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %97 = llvm.extractvalue %94[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %98 = llvm.extractvalue %94[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.extractvalue %94[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %100 = llvm.extractvalue %94[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.extractvalue %94[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.extractvalue %94[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.call @blackhole(%96, %97, %98, %99, %100, %101, %102) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    llvm.call @displayTime(%86, %95) : (i64, i64) -> ()
    llvm.return %4 : i32
  }
}

