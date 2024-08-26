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
    llvm.call @printNewline() : () -> ()
    llvm.call @printNewline() : () -> ()
    %5 = llvm.call @printf(%4, %1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    llvm.return
  }
  llvm.func @printI64Tensor1D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64) {
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
    %18 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %19 = llvm.mul %16, %arg4  : i64
    %20 = llvm.getelementptr %18[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %21 = llvm.load %20 : !llvm.ptr -> i64
    llvm.call @printI64(%21) : (i64) -> ()
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
  llvm.func @printI64Tensor2D(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) {
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
    llvm.call @printI64Tensor1D(%40, %41, %42, %43, %44) : (!llvm.ptr, !llvm.ptr, i64, i64, i64) -> ()
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
  llvm.func @rgb_to_grayscale(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(256 : i64) : i64
    %1 = llvm.mlir.constant(77 : i64) : i64
    %2 = llvm.mlir.constant(150 : i64) : i64
    %3 = llvm.mlir.constant(29 : i64) : i64
    %4 = llvm.mul %arg0, %1  : i64
    %5 = llvm.mul %arg1, %2  : i64
    %6 = llvm.mul %arg2, %3  : i64
    %7 = llvm.sdiv %4, %0  : i64
    %8 = llvm.sdiv %5, %0  : i64
    %9 = llvm.sdiv %6, %0  : i64
    %10 = llvm.add %7, %8  : i64
    %11 = llvm.add %10, %9  : i64
    llvm.return %11 : i64
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
  llvm.func @main() -> i64 {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(10000 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.constant(100 : i64) : i64
    %7 = llvm.mlir.constant(10000 : index) : i64
    %8 = llvm.mlir.constant(10000 : index) : i64
    %9 = llvm.mlir.constant(3 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(30000 : index) : i64
    %12 = llvm.mlir.constant(300000000 : index) : i64
    %13 = llvm.mlir.zero : !llvm.ptr
    %14 = llvm.getelementptr %13[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %15 = llvm.ptrtoint %14 : !llvm.ptr to i64
    %16 = llvm.mlir.constant(64 : index) : i64
    %17 = llvm.add %15, %16  : i64
    %18 = llvm.call @malloc(%17) : (i64) -> !llvm.ptr
    %19 = llvm.ptrtoint %18 : !llvm.ptr to i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.sub %16, %20  : i64
    %22 = llvm.add %19, %21  : i64
    %23 = llvm.urem %22, %16  : i64
    %24 = llvm.sub %22, %23  : i64
    %25 = llvm.inttoptr %24 : i64 to !llvm.ptr
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %27 = llvm.insertvalue %18, %26[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %31 = llvm.insertvalue %7, %30[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %32 = llvm.insertvalue %8, %31[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %33 = llvm.insertvalue %9, %32[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %34 = llvm.insertvalue %11, %33[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %35 = llvm.insertvalue %9, %34[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %36 = llvm.insertvalue %10, %35[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.br ^bb1(%5 : i64)
  ^bb1(%37: i64):  // 2 preds: ^bb0, ^bb8
    %38 = llvm.icmp "slt" %37, %2 : i64
    llvm.cond_br %38, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%5 : i64)
  ^bb3(%39: i64):  // 2 preds: ^bb2, ^bb7
    %40 = llvm.icmp "slt" %39, %2 : i64
    llvm.cond_br %40, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%5 : i64)
  ^bb5(%41: i64):  // 2 preds: ^bb4, ^bb6
    %42 = llvm.icmp "slt" %41, %0 : i64
    llvm.cond_br %42, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %43 = llvm.mlir.constant(30000 : index) : i64
    %44 = llvm.mul %37, %43  : i64
    %45 = llvm.mlir.constant(3 : index) : i64
    %46 = llvm.mul %39, %45  : i64
    %47 = llvm.add %44, %46  : i64
    %48 = llvm.add %47, %41  : i64
    %49 = llvm.getelementptr %25[%48] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %6, %49 : i64, !llvm.ptr
    %50 = llvm.add %41, %4  : i64
    llvm.br ^bb5(%50 : i64)
  ^bb7:  // pred: ^bb5
    %51 = llvm.add %39, %4  : i64
    llvm.br ^bb3(%51 : i64)
  ^bb8:  // pred: ^bb3
    %52 = llvm.add %37, %4  : i64
    llvm.br ^bb1(%52 : i64)
  ^bb9:  // pred: ^bb1
    %53 = llvm.call @clock() : () -> i64
    %54 = llvm.mlir.constant(10000 : index) : i64
    %55 = llvm.mlir.constant(10000 : index) : i64
    %56 = llvm.mlir.constant(1 : index) : i64
    %57 = llvm.mlir.constant(100000000 : index) : i64
    %58 = llvm.mlir.zero : !llvm.ptr
    %59 = llvm.getelementptr %58[100000000] : (!llvm.ptr) -> !llvm.ptr, i64
    %60 = llvm.ptrtoint %59 : !llvm.ptr to i64
    %61 = llvm.mlir.constant(64 : index) : i64
    %62 = llvm.add %60, %61  : i64
    %63 = llvm.call @malloc(%62) : (i64) -> !llvm.ptr
    %64 = llvm.ptrtoint %63 : !llvm.ptr to i64
    %65 = llvm.mlir.constant(1 : index) : i64
    %66 = llvm.sub %61, %65  : i64
    %67 = llvm.add %64, %66  : i64
    %68 = llvm.urem %67, %61  : i64
    %69 = llvm.sub %67, %68  : i64
    %70 = llvm.inttoptr %69 : i64 to !llvm.ptr
    %71 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %72 = llvm.insertvalue %63, %71[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %73 = llvm.insertvalue %70, %72[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %74 = llvm.mlir.constant(0 : index) : i64
    %75 = llvm.insertvalue %74, %73[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %76 = llvm.insertvalue %54, %75[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %77 = llvm.insertvalue %55, %76[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %78 = llvm.insertvalue %55, %77[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.insertvalue %56, %78[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb10(%5, %79 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb10(%80: i64, %81: !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>):  // 2 preds: ^bb9, ^bb14
    %82 = llvm.icmp "slt" %80, %2 : i64
    llvm.cond_br %82, ^bb11, ^bb15
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%5, %81 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb12(%83: i64, %84: !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>):  // 2 preds: ^bb11, ^bb13
    %85 = llvm.icmp "slt" %83, %2 : i64
    llvm.cond_br %85, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %86 = llvm.mlir.constant(30000 : index) : i64
    %87 = llvm.mul %80, %86  : i64
    %88 = llvm.mlir.constant(3 : index) : i64
    %89 = llvm.mul %83, %88  : i64
    %90 = llvm.add %87, %89  : i64
    %91 = llvm.add %90, %5  : i64
    %92 = llvm.getelementptr %25[%91] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %93 = llvm.load %92 : !llvm.ptr -> i64
    %94 = llvm.mlir.constant(30000 : index) : i64
    %95 = llvm.mul %80, %94  : i64
    %96 = llvm.mlir.constant(3 : index) : i64
    %97 = llvm.mul %83, %96  : i64
    %98 = llvm.add %95, %97  : i64
    %99 = llvm.add %98, %4  : i64
    %100 = llvm.getelementptr %25[%99] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %101 = llvm.load %100 : !llvm.ptr -> i64
    %102 = llvm.mlir.constant(30000 : index) : i64
    %103 = llvm.mul %80, %102  : i64
    %104 = llvm.mlir.constant(3 : index) : i64
    %105 = llvm.mul %83, %104  : i64
    %106 = llvm.add %103, %105  : i64
    %107 = llvm.add %106, %3  : i64
    %108 = llvm.getelementptr %25[%107] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %109 = llvm.load %108 : !llvm.ptr -> i64
    %110 = llvm.call @rgb_to_grayscale(%93, %101, %109) : (i64, i64, i64) -> i64
    %111 = llvm.extractvalue %84[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.mlir.constant(10000 : index) : i64
    %113 = llvm.mul %80, %112  : i64
    %114 = llvm.add %113, %83  : i64
    %115 = llvm.getelementptr %111[%114] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %110, %115 : i64, !llvm.ptr
    %116 = llvm.add %83, %4  : i64
    llvm.br ^bb12(%116, %84 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb14:  // pred: ^bb12
    %117 = llvm.add %80, %4  : i64
    llvm.br ^bb10(%117, %84 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb15:  // pred: ^bb10
    %118 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%53, %118) : (i64, i64) -> ()
    %119 = llvm.extractvalue %81[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %120 = llvm.extractvalue %81[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %121 = llvm.extractvalue %81[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %122 = llvm.extractvalue %81[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %123 = llvm.extractvalue %81[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %124 = llvm.extractvalue %81[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %125 = llvm.extractvalue %81[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %126 = llvm.call @blackhole(%119, %120, %121, %122, %123, %124, %125) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    llvm.return %1 : i64
  }
}

