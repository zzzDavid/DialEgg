module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.mlir.global private constant @__constant_2x3xf64(dense<[[3.000000e+00, 5.000000e+00, 7.000000e+00], [9.000000e+00, 1.100000e+01, 1.300000e+01]]> : tensor<2x3xf64>) {addr_space = 0 : i32, alignment = 64 : i64} : !llvm.array<2 x array<3 x f64>>
  llvm.func @printI64(i64) attributes {sym_visibility = "private"}
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
  llvm.func @printComma() attributes {sym_visibility = "private"}
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @putchar(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @printF64Tensor1D(!llvm.ptr, !llvm.ptr, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @printF64Tensor2D(!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @displayTime(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @main() -> i64 {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(3 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(6 : index) : i64
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.getelementptr %7[6] : (!llvm.ptr) -> !llvm.ptr, f64
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    %10 = llvm.mlir.addressof @__constant_2x3xf64 : !llvm.ptr
    %11 = llvm.getelementptr %10[0, 0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2 x array<3 x f64>>
    %12 = llvm.mlir.constant(3735928559 : index) : i64
    %13 = llvm.inttoptr %12 : i64 to !llvm.ptr
    %14 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %11, %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.constant(0 : index) : i64
    %18 = llvm.insertvalue %17, %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %3, %18[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %4, %19[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %4, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %5, %21[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.call @clock() : () -> i64
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mul %0, %1  : i64
    %26 = llvm.mlir.zero : !llvm.ptr
    %27 = llvm.getelementptr %26[%25] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %28 = llvm.ptrtoint %27 : !llvm.ptr to i64
    %29 = llvm.mlir.constant(64 : index) : i64
    %30 = llvm.add %28, %29  : i64
    %31 = llvm.call @malloc(%30) : (i64) -> !llvm.ptr
    %32 = llvm.ptrtoint %31 : !llvm.ptr to i64
    %33 = llvm.mlir.constant(1 : index) : i64
    %34 = llvm.sub %29, %33  : i64
    %35 = llvm.add %32, %34  : i64
    %36 = llvm.urem %35, %29  : i64
    %37 = llvm.sub %35, %36  : i64
    %38 = llvm.inttoptr %37 : i64 to !llvm.ptr
    %39 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %40 = llvm.insertvalue %31, %39[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %41 = llvm.insertvalue %38, %40[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.mlir.constant(0 : index) : i64
    %43 = llvm.insertvalue %42, %41[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.insertvalue %1, %43[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.insertvalue %0, %44[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.insertvalue %0, %45[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %47 = llvm.insertvalue %24, %46[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.mlir.constant(1 : index) : i64
    %49 = llvm.mul %3, %48  : i64
    %50 = llvm.mul %49, %4  : i64
    %51 = llvm.mlir.zero : !llvm.ptr
    %52 = llvm.getelementptr %51[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %53 = llvm.ptrtoint %52 : !llvm.ptr to i64
    %54 = llvm.mul %50, %53  : i64
    %55 = llvm.getelementptr %11[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %56 = llvm.getelementptr %38[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    "llvm.intr.memcpy"(%56, %55, %54) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %57 = llvm.extractvalue %47[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.extractvalue %47[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.extractvalue %47[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.extractvalue %47[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.extractvalue %47[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.extractvalue %47[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %63 = llvm.extractvalue %47[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @printF64Tensor2D(%57, %58, %59, %60, %61, %62, %63) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.call @printNewline() : () -> ()
    %64 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%23, %64) : (i64, i64) -> ()
    llvm.return %2 : i64
  }
}

