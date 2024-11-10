module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @displayTime(i64, i64) attributes {sym_visibility = "private"}
  llvm.func @printI64Tensor2D(!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) attributes {sym_visibility = "private"}
  llvm.func @blackhole4k(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg6, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg7, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg8, %8[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.return %9 : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
  }
  llvm.func @main() -> i64 {
    %0 = llvm.mlir.constant(3 : index) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2160 : index) : i64
    %3 = llvm.mlir.constant(3840 : index) : i64
    %4 = llvm.mlir.constant(2 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(100 : i64) : i64
    %8 = llvm.mlir.constant(3840 : index) : i64
    %9 = llvm.mlir.constant(2160 : index) : i64
    %10 = llvm.mlir.constant(3 : index) : i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.mlir.constant(6480 : index) : i64
    %13 = llvm.mlir.constant(24883200 : index) : i64
    %14 = llvm.mlir.zero : !llvm.ptr
    %15 = llvm.getelementptr %14[24883200] : (!llvm.ptr) -> !llvm.ptr, i64
    %16 = llvm.ptrtoint %15 : !llvm.ptr to i64
    %17 = llvm.mlir.constant(64 : index) : i64
    %18 = llvm.add %16, %17  : i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.ptrtoint %19 : !llvm.ptr to i64
    %21 = llvm.mlir.constant(1 : index) : i64
    %22 = llvm.sub %17, %21  : i64
    %23 = llvm.add %20, %22  : i64
    %24 = llvm.urem %23, %17  : i64
    %25 = llvm.sub %23, %24  : i64
    %26 = llvm.inttoptr %25 : i64 to !llvm.ptr
    %27 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %28 = llvm.insertvalue %19, %27[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %29 = llvm.insertvalue %26, %28[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %32 = llvm.insertvalue %8, %31[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %33 = llvm.insertvalue %9, %32[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %34 = llvm.insertvalue %10, %33[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %35 = llvm.insertvalue %12, %34[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %36 = llvm.insertvalue %10, %35[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %37 = llvm.insertvalue %11, %36[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.br ^bb1(%6 : i64)
  ^bb1(%38: i64):  // 2 preds: ^bb0, ^bb8
    %39 = llvm.icmp "slt" %38, %3 : i64
    llvm.cond_br %39, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%6 : i64)
  ^bb3(%40: i64):  // 2 preds: ^bb2, ^bb7
    %41 = llvm.icmp "slt" %40, %2 : i64
    llvm.cond_br %41, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%6 : i64)
  ^bb5(%42: i64):  // 2 preds: ^bb4, ^bb6
    %43 = llvm.icmp "slt" %42, %0 : i64
    llvm.cond_br %43, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %44 = llvm.mlir.constant(6480 : index) : i64
    %45 = llvm.mul %38, %44  : i64
    %46 = llvm.mlir.constant(3 : index) : i64
    %47 = llvm.mul %40, %46  : i64
    %48 = llvm.add %45, %47  : i64
    %49 = llvm.add %48, %42  : i64
    %50 = llvm.getelementptr %26[%49] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %7, %50 : i64, !llvm.ptr
    %51 = llvm.add %42, %5  : i64
    llvm.br ^bb5(%51 : i64)
  ^bb7:  // pred: ^bb5
    %52 = llvm.add %40, %5  : i64
    llvm.br ^bb3(%52 : i64)
  ^bb8:  // pred: ^bb3
    %53 = llvm.add %38, %5  : i64
    llvm.br ^bb1(%53 : i64)
  ^bb9:  // pred: ^bb1
    %54 = llvm.extractvalue %37[0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %55 = llvm.extractvalue %37[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %56 = llvm.extractvalue %37[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %57 = llvm.extractvalue %37[3, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %58 = llvm.extractvalue %37[3, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %59 = llvm.extractvalue %37[3, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %60 = llvm.extractvalue %37[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %61 = llvm.extractvalue %37[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %62 = llvm.extractvalue %37[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %63 = llvm.call @blackhole4k(%54, %55, %56, %57, %58, %59, %60, %61, %62) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %64 = llvm.call @clock() : () -> i64
    %65 = llvm.mlir.constant(3840 : index) : i64
    %66 = llvm.mlir.constant(2160 : index) : i64
    %67 = llvm.mlir.constant(1 : index) : i64
    %68 = llvm.mlir.constant(8294400 : index) : i64
    %69 = llvm.mlir.zero : !llvm.ptr
    %70 = llvm.getelementptr %69[8294400] : (!llvm.ptr) -> !llvm.ptr, i64
    %71 = llvm.ptrtoint %70 : !llvm.ptr to i64
    %72 = llvm.mlir.constant(64 : index) : i64
    %73 = llvm.add %71, %72  : i64
    %74 = llvm.call @malloc(%73) : (i64) -> !llvm.ptr
    %75 = llvm.ptrtoint %74 : !llvm.ptr to i64
    %76 = llvm.mlir.constant(1 : index) : i64
    %77 = llvm.sub %72, %76  : i64
    %78 = llvm.add %75, %77  : i64
    %79 = llvm.urem %78, %72  : i64
    %80 = llvm.sub %78, %79  : i64
    %81 = llvm.inttoptr %80 : i64 to !llvm.ptr
    %82 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %83 = llvm.insertvalue %74, %82[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %84 = llvm.insertvalue %81, %83[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.mlir.constant(0 : index) : i64
    %86 = llvm.insertvalue %85, %84[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.insertvalue %65, %86[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %88 = llvm.insertvalue %66, %87[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.insertvalue %66, %88[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %90 = llvm.insertvalue %67, %89[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb10(%6, %90 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb10(%91: i64, %92: !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>):  // 2 preds: ^bb9, ^bb14
    %93 = llvm.icmp "slt" %91, %3 : i64
    llvm.cond_br %93, ^bb11, ^bb15
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%6, %92 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb12(%94: i64, %95: !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>):  // 2 preds: ^bb11, ^bb13
    %96 = llvm.icmp "slt" %94, %2 : i64
    llvm.cond_br %96, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %97 = llvm.extractvalue %63[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %98 = llvm.extractvalue %63[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %99 = llvm.getelementptr %97[%98] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %100 = llvm.extractvalue %63[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %101 = llvm.mul %91, %100  : i64
    %102 = llvm.extractvalue %63[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %103 = llvm.mul %94, %102  : i64
    %104 = llvm.add %101, %103  : i64
    %105 = llvm.extractvalue %63[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %106 = llvm.mul %105, %6  : i64
    %107 = llvm.add %104, %106  : i64
    %108 = llvm.getelementptr %99[%107] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %109 = llvm.load %108 : !llvm.ptr -> i64
    %110 = llvm.extractvalue %63[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %111 = llvm.extractvalue %63[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %112 = llvm.getelementptr %110[%111] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %113 = llvm.extractvalue %63[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %114 = llvm.mul %91, %113  : i64
    %115 = llvm.extractvalue %63[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %116 = llvm.mul %94, %115  : i64
    %117 = llvm.add %114, %116  : i64
    %118 = llvm.extractvalue %63[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %119 = llvm.mul %118, %5  : i64
    %120 = llvm.add %117, %119  : i64
    %121 = llvm.getelementptr %112[%120] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %122 = llvm.load %121 : !llvm.ptr -> i64
    %123 = llvm.extractvalue %63[1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %124 = llvm.extractvalue %63[2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %125 = llvm.getelementptr %123[%124] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %126 = llvm.extractvalue %63[4, 0] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %127 = llvm.mul %91, %126  : i64
    %128 = llvm.extractvalue %63[4, 1] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %129 = llvm.mul %94, %128  : i64
    %130 = llvm.add %127, %129  : i64
    %131 = llvm.extractvalue %63[4, 2] : !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)> 
    %132 = llvm.mul %131, %4  : i64
    %133 = llvm.add %130, %132  : i64
    %134 = llvm.getelementptr %125[%133] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %135 = llvm.load %134 : !llvm.ptr -> i64
    %136 = llvm.call @rgb_to_grayscale(%109, %122, %135) : (i64, i64, i64) -> i64
    %137 = llvm.extractvalue %95[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %138 = llvm.mlir.constant(2160 : index) : i64
    %139 = llvm.mul %91, %138  : i64
    %140 = llvm.add %139, %94  : i64
    %141 = llvm.getelementptr %137[%140] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %136, %141 : i64, !llvm.ptr
    %142 = llvm.add %94, %5  : i64
    llvm.br ^bb12(%142, %95 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb14:  // pred: ^bb12
    %143 = llvm.add %91, %5  : i64
    llvm.br ^bb10(%143, %95 : i64, !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>)
  ^bb15:  // pred: ^bb10
    %144 = llvm.call @clock() : () -> i64
    %145 = llvm.extractvalue %92[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %146 = llvm.extractvalue %92[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %147 = llvm.extractvalue %92[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %148 = llvm.extractvalue %92[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %149 = llvm.extractvalue %92[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %150 = llvm.extractvalue %92[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %151 = llvm.extractvalue %92[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @printI64Tensor2D(%145, %146, %147, %148, %149, %150, %151) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @displayTime(%64, %144) : (i64, i64) -> ()
    llvm.return %1 : i64
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
}

