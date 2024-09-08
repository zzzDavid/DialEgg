module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printI64(i64) attributes {sym_visibility = "private"}
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
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
    %8 = llvm.mlir.constant(4.6566127999999998E-9 : f64) : f64
    %9 = llvm.mlir.constant(12345 : i32) : i32
    %10 = llvm.mlir.constant(1103515245 : i32) : i32
    %11 = llvm.mlir.constant(0x41DFFFFFFFC00000 : f64) : f64
    %12 = llvm.mlir.constant(-1.000000e+01 : f64) : f64
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.mlir.constant(1000000 : index) : i64
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.mlir.constant(4 : index) : i64
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
  llvm.func @blackhole(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.return %5 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @poly_eval_3(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64, %arg4: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.intr.pow(%arg4, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %3 = llvm.intr.pow(%arg4, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %4 = llvm.fmul %arg2, %arg4  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %5 = llvm.fmul %arg1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %6 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %7 = llvm.fadd %5, %6  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %8 = llvm.fadd %4, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %9 = llvm.fadd %arg3, %8  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %9 : f64
  }
  llvm.func @poly_eval_2(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg3, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %2 = llvm.fmul %arg1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %5 = llvm.fadd %arg2, %4  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %5 : f64
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1000000 : index) : i64
    %2 = llvm.mlir.constant(3 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(1000000 : index) : i64
    %8 = llvm.mlir.constant(4 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(4000000 : index) : i64
    %11 = llvm.mlir.zero : !llvm.ptr
    %12 = llvm.getelementptr %11[4000000] : (!llvm.ptr) -> !llvm.ptr, f64
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
    %66 = llvm.icmp "slt" %64, %1 : i64
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
    %107 = llvm.call @poly_eval_3(%76, %86, %96, %106, %6) : (f64, f64, f64, f64, f64) -> f64
    %108 = llvm.extractvalue %65[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %109 = llvm.getelementptr %108[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %107, %109 : f64, !llvm.ptr
    %110 = llvm.add %64, %4  : i64
    llvm.br ^bb1(%110, %65 : i64, !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>)
  ^bb3:  // pred: ^bb1
    %111 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%41, %111) : (i64, i64) -> ()
    %112 = llvm.extractvalue %65[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %113 = llvm.extractvalue %65[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %114 = llvm.extractvalue %65[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %115 = llvm.extractvalue %65[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %116 = llvm.extractvalue %65[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %117 = llvm.call @blackhole(%112, %113, %114, %115, %116) : (!llvm.ptr, !llvm.ptr, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.return %0 : i32
  }
}

