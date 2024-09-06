module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @putchar(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @printf(!llvm.ptr, ...) -> i32
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
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  llvm.func @displayTime(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1.000000e+04 : f64) : f64
    %1 = llvm.sub %arg1, %arg0  : i64
    %2 = llvm.uitofp %1 : i64 to f64
    %3 = llvm.fdiv %2, %0  : f64
    %4 = llvm.mlir.addressof @time : !llvm.ptr
    %5 = llvm.call @printf(%4, %1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
    llvm.return
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(100 : index) : i64
    %1 = llvm.mlir.constant(150 : index) : i64
    %2 = llvm.mlir.constant(8 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(10 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @clock() : () -> i64
    %8 = llvm.mlir.constant(100 : index) : i64
    %9 = llvm.mlir.constant(10 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(1000 : index) : i64
    %12 = llvm.mlir.zero : !llvm.ptr
    %13 = llvm.getelementptr %12[1000] : (!llvm.ptr) -> !llvm.ptr, i64
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
    %34 = llvm.mlir.constant(10 : index) : i64
    %35 = llvm.mlir.constant(150 : index) : i64
    %36 = llvm.mlir.constant(1 : index) : i64
    %37 = llvm.mlir.constant(1500 : index) : i64
    %38 = llvm.mlir.zero : !llvm.ptr
    %39 = llvm.getelementptr %38[1500] : (!llvm.ptr) -> !llvm.ptr, i64
    %40 = llvm.ptrtoint %39 : !llvm.ptr to i64
    %41 = llvm.mlir.constant(64 : index) : i64
    %42 = llvm.add %40, %41  : i64
    %43 = llvm.call @malloc(%42) : (i64) -> !llvm.ptr
    %44 = llvm.ptrtoint %43 : !llvm.ptr to i64
    %45 = llvm.mlir.constant(1 : index) : i64
    %46 = llvm.sub %41, %45  : i64
    %47 = llvm.add %44, %46  : i64
    %48 = llvm.urem %47, %41  : i64
    %49 = llvm.sub %47, %48  : i64
    %50 = llvm.inttoptr %49 : i64 to !llvm.ptr
    %51 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %52 = llvm.insertvalue %43, %51[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %50, %52[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.mlir.constant(0 : index) : i64
    %55 = llvm.insertvalue %54, %53[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %34, %55[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %35, %56[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %35, %57[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %36, %58[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.mlir.constant(150 : index) : i64
    %61 = llvm.mlir.constant(8 : index) : i64
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.mlir.constant(1200 : index) : i64
    %64 = llvm.mlir.zero : !llvm.ptr
    %65 = llvm.getelementptr %64[1200] : (!llvm.ptr) -> !llvm.ptr, i64
    %66 = llvm.ptrtoint %65 : !llvm.ptr to i64
    %67 = llvm.mlir.constant(64 : index) : i64
    %68 = llvm.add %66, %67  : i64
    %69 = llvm.call @malloc(%68) : (i64) -> !llvm.ptr
    %70 = llvm.ptrtoint %69 : !llvm.ptr to i64
    %71 = llvm.mlir.constant(1 : index) : i64
    %72 = llvm.sub %67, %71  : i64
    %73 = llvm.add %70, %72  : i64
    %74 = llvm.urem %73, %67  : i64
    %75 = llvm.sub %73, %74  : i64
    %76 = llvm.inttoptr %75 : i64 to !llvm.ptr
    %77 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %78 = llvm.insertvalue %69, %77[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %79 = llvm.insertvalue %76, %78[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.mlir.constant(0 : index) : i64
    %81 = llvm.insertvalue %80, %79[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %82 = llvm.insertvalue %60, %81[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %83 = llvm.insertvalue %61, %82[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %84 = llvm.insertvalue %61, %83[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.insertvalue %62, %84[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %86 = llvm.mlir.constant(100 : index) : i64
    %87 = llvm.mlir.constant(8 : index) : i64
    %88 = llvm.mlir.constant(1 : index) : i64
    %89 = llvm.mlir.constant(800 : index) : i64
    %90 = llvm.mlir.zero : !llvm.ptr
    %91 = llvm.getelementptr %90[800] : (!llvm.ptr) -> !llvm.ptr, i64
    %92 = llvm.ptrtoint %91 : !llvm.ptr to i64
    %93 = llvm.mlir.constant(64 : index) : i64
    %94 = llvm.add %92, %93  : i64
    %95 = llvm.call @malloc(%94) : (i64) -> !llvm.ptr
    %96 = llvm.ptrtoint %95 : !llvm.ptr to i64
    %97 = llvm.mlir.constant(1 : index) : i64
    %98 = llvm.sub %93, %97  : i64
    %99 = llvm.add %96, %98  : i64
    %100 = llvm.urem %99, %93  : i64
    %101 = llvm.sub %99, %100  : i64
    %102 = llvm.inttoptr %101 : i64 to !llvm.ptr
    %103 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %104 = llvm.insertvalue %95, %103[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.insertvalue %102, %104[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.mlir.constant(0 : index) : i64
    %107 = llvm.insertvalue %106, %105[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.insertvalue %86, %107[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.insertvalue %87, %108[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.insertvalue %87, %109[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.insertvalue %88, %110[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.mlir.constant(10 : index) : i64
    %113 = llvm.mlir.constant(8 : index) : i64
    %114 = llvm.mlir.constant(1 : index) : i64
    %115 = llvm.mlir.constant(80 : index) : i64
    %116 = llvm.mlir.zero : !llvm.ptr
    %117 = llvm.getelementptr %116[80] : (!llvm.ptr) -> !llvm.ptr, i64
    %118 = llvm.ptrtoint %117 : !llvm.ptr to i64
    %119 = llvm.mlir.constant(64 : index) : i64
    %120 = llvm.add %118, %119  : i64
    %121 = llvm.call @malloc(%120) : (i64) -> !llvm.ptr
    %122 = llvm.ptrtoint %121 : !llvm.ptr to i64
    %123 = llvm.mlir.constant(1 : index) : i64
    %124 = llvm.sub %119, %123  : i64
    %125 = llvm.add %122, %124  : i64
    %126 = llvm.urem %125, %119  : i64
    %127 = llvm.sub %125, %126  : i64
    %128 = llvm.inttoptr %127 : i64 to !llvm.ptr
    %129 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %130 = llvm.insertvalue %121, %129[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %131 = llvm.insertvalue %128, %130[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %132 = llvm.mlir.constant(0 : index) : i64
    %133 = llvm.insertvalue %132, %131[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %134 = llvm.insertvalue %112, %133[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %135 = llvm.insertvalue %113, %134[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %136 = llvm.insertvalue %113, %135[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %137 = llvm.insertvalue %114, %136[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%5 : i64)
  ^bb1(%138: i64):  // 2 preds: ^bb0, ^bb8
    %139 = llvm.icmp "slt" %138, %4 : i64
    llvm.cond_br %139, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%5 : i64)
  ^bb3(%140: i64):  // 2 preds: ^bb2, ^bb7
    %141 = llvm.icmp "slt" %140, %2 : i64
    llvm.cond_br %141, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%5 : i64)
  ^bb5(%142: i64):  // 2 preds: ^bb4, ^bb6
    %143 = llvm.icmp "slt" %142, %1 : i64
    llvm.cond_br %143, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %144 = llvm.mlir.constant(150 : index) : i64
    %145 = llvm.mul %138, %144  : i64
    %146 = llvm.add %145, %142  : i64
    %147 = llvm.getelementptr %50[%146] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %148 = llvm.load %147 : !llvm.ptr -> i64
    %149 = llvm.mlir.constant(8 : index) : i64
    %150 = llvm.mul %142, %149  : i64
    %151 = llvm.add %150, %140  : i64
    %152 = llvm.getelementptr %76[%151] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %153 = llvm.load %152 : !llvm.ptr -> i64
    %154 = llvm.mlir.constant(8 : index) : i64
    %155 = llvm.mul %138, %154  : i64
    %156 = llvm.add %155, %140  : i64
    %157 = llvm.getelementptr %128[%156] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %158 = llvm.load %157 : !llvm.ptr -> i64
    %159 = llvm.mul %148, %153  : i64
    %160 = llvm.add %158, %159  : i64
    %161 = llvm.mlir.constant(8 : index) : i64
    %162 = llvm.mul %138, %161  : i64
    %163 = llvm.add %162, %140  : i64
    %164 = llvm.getelementptr %128[%163] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %160, %164 : i64, !llvm.ptr
    %165 = llvm.add %142, %3  : i64
    llvm.br ^bb5(%165 : i64)
  ^bb7:  // pred: ^bb5
    %166 = llvm.add %140, %3  : i64
    llvm.br ^bb3(%166 : i64)
  ^bb8:  // pred: ^bb3
    %167 = llvm.add %138, %3  : i64
    llvm.br ^bb1(%167 : i64)
  ^bb9:  // pred: ^bb1
    llvm.br ^bb10(%5 : i64)
  ^bb10(%168: i64):  // 2 preds: ^bb9, ^bb17
    %169 = llvm.icmp "slt" %168, %0 : i64
    llvm.cond_br %169, ^bb11, ^bb18
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%5 : i64)
  ^bb12(%170: i64):  // 2 preds: ^bb11, ^bb16
    %171 = llvm.icmp "slt" %170, %2 : i64
    llvm.cond_br %171, ^bb13, ^bb17
  ^bb13:  // pred: ^bb12
    llvm.br ^bb14(%5 : i64)
  ^bb14(%172: i64):  // 2 preds: ^bb13, ^bb15
    %173 = llvm.icmp "slt" %172, %4 : i64
    llvm.cond_br %173, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    %174 = llvm.mlir.constant(10 : index) : i64
    %175 = llvm.mul %168, %174  : i64
    %176 = llvm.add %175, %172  : i64
    %177 = llvm.getelementptr %24[%176] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %178 = llvm.load %177 : !llvm.ptr -> i64
    %179 = llvm.mlir.constant(8 : index) : i64
    %180 = llvm.mul %172, %179  : i64
    %181 = llvm.add %180, %170  : i64
    %182 = llvm.getelementptr %128[%181] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %183 = llvm.load %182 : !llvm.ptr -> i64
    %184 = llvm.mlir.constant(8 : index) : i64
    %185 = llvm.mul %168, %184  : i64
    %186 = llvm.add %185, %170  : i64
    %187 = llvm.getelementptr %102[%186] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %188 = llvm.load %187 : !llvm.ptr -> i64
    %189 = llvm.mul %178, %183  : i64
    %190 = llvm.add %188, %189  : i64
    %191 = llvm.mlir.constant(8 : index) : i64
    %192 = llvm.mul %168, %191  : i64
    %193 = llvm.add %192, %170  : i64
    %194 = llvm.getelementptr %102[%193] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %190, %194 : i64, !llvm.ptr
    %195 = llvm.add %172, %3  : i64
    llvm.br ^bb14(%195 : i64)
  ^bb16:  // pred: ^bb14
    %196 = llvm.add %170, %3  : i64
    llvm.br ^bb12(%196 : i64)
  ^bb17:  // pred: ^bb12
    %197 = llvm.add %168, %3  : i64
    llvm.br ^bb10(%197 : i64)
  ^bb18:  // pred: ^bb10
    %198 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%7, %198) : (i64, i64) -> ()
    %199 = llvm.extractvalue %111[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %200 = llvm.extractvalue %111[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %201 = llvm.extractvalue %111[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %202 = llvm.extractvalue %111[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %203 = llvm.extractvalue %111[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %204 = llvm.extractvalue %111[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %205 = llvm.extractvalue %111[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %206 = llvm.call @blackhole(%199, %200, %201, %202, %203, %204, %205) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    llvm.return %6 : i32
  }
}

