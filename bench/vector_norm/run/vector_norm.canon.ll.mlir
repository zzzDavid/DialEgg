module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @displayTime(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @printF32Tensor2D(!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
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
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1000000 : index) : i64
    %4 = llvm.mlir.constant(3 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(3000000 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[3000000] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.mlir.constant(64 : index) : i64
    %11 = llvm.add %9, %10  : i64
    %12 = llvm.call @malloc(%11) : (i64) -> !llvm.ptr
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.sub %10, %14  : i64
    %16 = llvm.add %13, %15  : i64
    %17 = llvm.urem %16, %10  : i64
    %18 = llvm.sub %16, %17  : i64
    %19 = llvm.inttoptr %18 : i64 to !llvm.ptr
    %20 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = llvm.insertvalue %12, %20[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %19, %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.mlir.constant(0 : index) : i64
    %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %3, %24[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %4, %25[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %4, %26[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %5, %27[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.extractvalue %28[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.extractvalue %28[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.extractvalue %28[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.extractvalue %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.extractvalue %28[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.call @fillRandomF64Tensor2D(%29, %30, %31, %32, %33, %34, %35) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.extractvalue %36[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.alloca %37 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %38, %39 : !llvm.array<2 x i64>, !llvm.ptr
    %40 = llvm.getelementptr %39[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %41 = llvm.load %40 : !llvm.ptr -> i64
    %42 = llvm.mlir.constant(1 : index) : i64
    %43 = llvm.extractvalue %36[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.alloca %42 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %43, %44 : !llvm.array<2 x i64>, !llvm.ptr
    %45 = llvm.getelementptr %44[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %46 = llvm.load %45 : !llvm.ptr -> i64
    %47 = llvm.mlir.constant(1 : index) : i64
    %48 = llvm.mul %46, %41  : i64
    %49 = llvm.mlir.zero : !llvm.ptr
    %50 = llvm.getelementptr %49[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %51 = llvm.ptrtoint %50 : !llvm.ptr to i64
    %52 = llvm.mlir.constant(64 : index) : i64
    %53 = llvm.add %51, %52  : i64
    %54 = llvm.call @malloc(%53) : (i64) -> !llvm.ptr
    %55 = llvm.ptrtoint %54 : !llvm.ptr to i64
    %56 = llvm.mlir.constant(1 : index) : i64
    %57 = llvm.sub %52, %56  : i64
    %58 = llvm.add %55, %57  : i64
    %59 = llvm.urem %58, %52  : i64
    %60 = llvm.sub %58, %59  : i64
    %61 = llvm.inttoptr %60 : i64 to !llvm.ptr
    %62 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %63 = llvm.insertvalue %54, %62[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %64 = llvm.insertvalue %61, %63[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %65 = llvm.mlir.constant(0 : index) : i64
    %66 = llvm.insertvalue %65, %64[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %67 = llvm.insertvalue %41, %66[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %68 = llvm.insertvalue %46, %67[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %69 = llvm.insertvalue %46, %68[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %70 = llvm.insertvalue %47, %69[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %71 = llvm.mlir.constant(1 : index) : i64
    %72 = llvm.extractvalue %36[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %73 = llvm.alloca %71 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %72, %73 : !llvm.array<2 x i64>, !llvm.ptr
    %74 = llvm.getelementptr %73[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %75 = llvm.load %74 : !llvm.ptr -> i64
    %76 = llvm.mlir.constant(1 : index) : i64
    %77 = llvm.extractvalue %36[3] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %78 = llvm.alloca %76 x !llvm.array<2 x i64> : (i64) -> !llvm.ptr
    llvm.store %77, %78 : !llvm.array<2 x i64>, !llvm.ptr
    %79 = llvm.getelementptr %78[0, 1] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x i64>
    %80 = llvm.load %79 : !llvm.ptr -> i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%81: i64):  // 2 preds: ^bb0, ^bb5
    %82 = llvm.icmp "slt" %81, %75 : i64
    llvm.cond_br %82, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%1 : i64)
  ^bb3(%83: i64):  // 2 preds: ^bb2, ^bb4
    %84 = llvm.icmp "slt" %83, %80 : i64
    llvm.cond_br %84, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %85 = llvm.extractvalue %36[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %86 = llvm.extractvalue %36[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.getelementptr %85[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %88 = llvm.extractvalue %36[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.mul %81, %88  : i64
    %90 = llvm.extractvalue %36[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %91 = llvm.mul %83, %90  : i64
    %92 = llvm.add %89, %91  : i64
    %93 = llvm.getelementptr %87[%92] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %94 = llvm.load %93 : !llvm.ptr -> f64
    %95 = llvm.fptrunc %94 : f64 to f32
    %96 = llvm.mul %81, %46  : i64
    %97 = llvm.add %96, %83  : i64
    %98 = llvm.getelementptr %61[%97] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %95, %98 : f32, !llvm.ptr
    %99 = llvm.add %83, %0  : i64
    llvm.br ^bb3(%99 : i64)
  ^bb5:  // pred: ^bb3
    %100 = llvm.add %81, %0  : i64
    llvm.br ^bb1(%100 : i64)
  ^bb6:  // pred: ^bb1
    %101 = llvm.call @clock() : () -> i64
    %102 = llvm.extractvalue %70[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.extractvalue %70[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %104 = llvm.extractvalue %70[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.extractvalue %70[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.extractvalue %70[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.extractvalue %70[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.extractvalue %70[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.call @normalize_distance_vectors(%102, %103, %104, %105, %106, %107, %108) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %110 = llvm.call @clock() : () -> i64
    %111 = llvm.extractvalue %109[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.extractvalue %109[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.extractvalue %109[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %114 = llvm.extractvalue %109[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %115 = llvm.extractvalue %109[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %116 = llvm.extractvalue %109[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.extractvalue %109[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @printF32Tensor2D(%111, %112, %113, %114, %115, %116, %117) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @displayTime(%101, %110) : (i64, i64) -> ()
    llvm.return %2 : i32
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
}

