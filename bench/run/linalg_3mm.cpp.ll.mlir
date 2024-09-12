module {
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @clock() -> i64 attributes {sym_visibility = "private"}
  llvm.func @putchar(i32) -> i32 attributes {sym_visibility = "private"}
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.mlir.global external constant @time("%d us -> %f s") {addr_space = 0 : i32}
  llvm.func @displayTime(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(9.000000e+03 : f64) : f64
    %1 = llvm.sub %arg1, %arg0  : i64
    %2 = llvm.uitofp %1 : i64 to f64
    %3 = llvm.fdiv %2, %0  : f64
    %4 = llvm.mlir.addressof @time : !llvm.ptr
    %5 = llvm.call @printf(%4, %1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64, f64) -> i32
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
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(200 : index) : i64
    %1 = llvm.mlir.constant(10 : index) : i64
    %2 = llvm.mlir.constant(250 : index) : i64
    %3 = llvm.mlir.constant(150 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(175 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.call @clock() : () -> i64
    %9 = llvm.mlir.constant(200 : index) : i64
    %10 = llvm.mlir.constant(175 : index) : i64
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.mlir.constant(35000 : index) : i64
    %13 = llvm.mlir.zero : !llvm.ptr
    %14 = llvm.getelementptr %13[35000] : (!llvm.ptr) -> !llvm.ptr, i64
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
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = llvm.insertvalue %18, %26[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %9, %30[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %10, %31[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %10, %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %11, %33[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.mlir.constant(175 : index) : i64
    %36 = llvm.mlir.constant(250 : index) : i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.mlir.constant(43750 : index) : i64
    %39 = llvm.mlir.zero : !llvm.ptr
    %40 = llvm.getelementptr %39[43750] : (!llvm.ptr) -> !llvm.ptr, i64
    %41 = llvm.ptrtoint %40 : !llvm.ptr to i64
    %42 = llvm.mlir.constant(64 : index) : i64
    %43 = llvm.add %41, %42  : i64
    %44 = llvm.call @malloc(%43) : (i64) -> !llvm.ptr
    %45 = llvm.ptrtoint %44 : !llvm.ptr to i64
    %46 = llvm.mlir.constant(1 : index) : i64
    %47 = llvm.sub %42, %46  : i64
    %48 = llvm.add %45, %47  : i64
    %49 = llvm.urem %48, %42  : i64
    %50 = llvm.sub %48, %49  : i64
    %51 = llvm.inttoptr %50 : i64 to !llvm.ptr
    %52 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %53 = llvm.insertvalue %44, %52[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %51, %53[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.mlir.constant(0 : index) : i64
    %56 = llvm.insertvalue %55, %54[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %35, %56[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = llvm.insertvalue %36, %57[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %36, %58[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.insertvalue %37, %59[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.mlir.constant(250 : index) : i64
    %62 = llvm.mlir.constant(150 : index) : i64
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.mlir.constant(37500 : index) : i64
    %65 = llvm.mlir.zero : !llvm.ptr
    %66 = llvm.getelementptr %65[37500] : (!llvm.ptr) -> !llvm.ptr, i64
    %67 = llvm.ptrtoint %66 : !llvm.ptr to i64
    %68 = llvm.mlir.constant(64 : index) : i64
    %69 = llvm.add %67, %68  : i64
    %70 = llvm.call @malloc(%69) : (i64) -> !llvm.ptr
    %71 = llvm.ptrtoint %70 : !llvm.ptr to i64
    %72 = llvm.mlir.constant(1 : index) : i64
    %73 = llvm.sub %68, %72  : i64
    %74 = llvm.add %71, %73  : i64
    %75 = llvm.urem %74, %68  : i64
    %76 = llvm.sub %74, %75  : i64
    %77 = llvm.inttoptr %76 : i64 to !llvm.ptr
    %78 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %79 = llvm.insertvalue %70, %78[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.insertvalue %77, %79[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %81 = llvm.mlir.constant(0 : index) : i64
    %82 = llvm.insertvalue %81, %80[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %83 = llvm.insertvalue %61, %82[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %84 = llvm.insertvalue %62, %83[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %85 = llvm.insertvalue %62, %84[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %86 = llvm.insertvalue %63, %85[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %87 = llvm.mlir.constant(150 : index) : i64
    %88 = llvm.mlir.constant(10 : index) : i64
    %89 = llvm.mlir.constant(1 : index) : i64
    %90 = llvm.mlir.constant(1500 : index) : i64
    %91 = llvm.mlir.zero : !llvm.ptr
    %92 = llvm.getelementptr %91[1500] : (!llvm.ptr) -> !llvm.ptr, i64
    %93 = llvm.ptrtoint %92 : !llvm.ptr to i64
    %94 = llvm.mlir.constant(64 : index) : i64
    %95 = llvm.add %93, %94  : i64
    %96 = llvm.call @malloc(%95) : (i64) -> !llvm.ptr
    %97 = llvm.ptrtoint %96 : !llvm.ptr to i64
    %98 = llvm.mlir.constant(1 : index) : i64
    %99 = llvm.sub %94, %98  : i64
    %100 = llvm.add %97, %99  : i64
    %101 = llvm.urem %100, %94  : i64
    %102 = llvm.sub %100, %101  : i64
    %103 = llvm.inttoptr %102 : i64 to !llvm.ptr
    %104 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %105 = llvm.insertvalue %96, %104[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.insertvalue %103, %105[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.mlir.constant(0 : index) : i64
    %108 = llvm.insertvalue %107, %106[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.insertvalue %87, %108[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.insertvalue %88, %109[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.insertvalue %88, %110[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.insertvalue %89, %111[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.mlir.constant(175 : index) : i64
    %114 = llvm.mlir.constant(150 : index) : i64
    %115 = llvm.mlir.constant(1 : index) : i64
    %116 = llvm.mlir.constant(26250 : index) : i64
    %117 = llvm.mlir.zero : !llvm.ptr
    %118 = llvm.getelementptr %117[26250] : (!llvm.ptr) -> !llvm.ptr, i64
    %119 = llvm.ptrtoint %118 : !llvm.ptr to i64
    %120 = llvm.mlir.constant(64 : index) : i64
    %121 = llvm.add %119, %120  : i64
    %122 = llvm.call @malloc(%121) : (i64) -> !llvm.ptr
    %123 = llvm.ptrtoint %122 : !llvm.ptr to i64
    %124 = llvm.mlir.constant(1 : index) : i64
    %125 = llvm.sub %120, %124  : i64
    %126 = llvm.add %123, %125  : i64
    %127 = llvm.urem %126, %120  : i64
    %128 = llvm.sub %126, %127  : i64
    %129 = llvm.inttoptr %128 : i64 to !llvm.ptr
    %130 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %131 = llvm.insertvalue %122, %130[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %132 = llvm.insertvalue %129, %131[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %133 = llvm.mlir.constant(0 : index) : i64
    %134 = llvm.insertvalue %133, %132[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %135 = llvm.insertvalue %113, %134[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %136 = llvm.insertvalue %114, %135[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %137 = llvm.insertvalue %114, %136[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %138 = llvm.insertvalue %115, %137[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%6 : i64)
  ^bb1(%139: i64):  // 2 preds: ^bb0, ^bb8
    %140 = llvm.icmp "slt" %139, %5 : i64
    llvm.cond_br %140, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%6 : i64)
  ^bb3(%141: i64):  // 2 preds: ^bb2, ^bb7
    %142 = llvm.icmp "slt" %141, %3 : i64
    llvm.cond_br %142, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%6 : i64)
  ^bb5(%143: i64):  // 2 preds: ^bb4, ^bb6
    %144 = llvm.icmp "slt" %143, %2 : i64
    llvm.cond_br %144, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %145 = llvm.mlir.constant(250 : index) : i64
    %146 = llvm.mul %139, %145  : i64
    %147 = llvm.add %146, %143  : i64
    %148 = llvm.getelementptr %51[%147] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %149 = llvm.load %148 : !llvm.ptr -> i64
    %150 = llvm.mlir.constant(150 : index) : i64
    %151 = llvm.mul %143, %150  : i64
    %152 = llvm.add %151, %141  : i64
    %153 = llvm.getelementptr %77[%152] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %154 = llvm.load %153 : !llvm.ptr -> i64
    %155 = llvm.mlir.constant(150 : index) : i64
    %156 = llvm.mul %139, %155  : i64
    %157 = llvm.add %156, %141  : i64
    %158 = llvm.getelementptr %129[%157] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %159 = llvm.load %158 : !llvm.ptr -> i64
    %160 = llvm.mul %149, %154  : i64
    %161 = llvm.add %159, %160  : i64
    %162 = llvm.mlir.constant(150 : index) : i64
    %163 = llvm.mul %139, %162  : i64
    %164 = llvm.add %163, %141  : i64
    %165 = llvm.getelementptr %129[%164] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %161, %165 : i64, !llvm.ptr
    %166 = llvm.add %143, %4  : i64
    llvm.br ^bb5(%166 : i64)
  ^bb7:  // pred: ^bb5
    %167 = llvm.add %141, %4  : i64
    llvm.br ^bb3(%167 : i64)
  ^bb8:  // pred: ^bb3
    %168 = llvm.add %139, %4  : i64
    llvm.br ^bb1(%168 : i64)
  ^bb9:  // pred: ^bb1
    %169 = llvm.mlir.constant(175 : index) : i64
    %170 = llvm.mlir.constant(10 : index) : i64
    %171 = llvm.mlir.constant(1 : index) : i64
    %172 = llvm.mlir.constant(1750 : index) : i64
    %173 = llvm.mlir.zero : !llvm.ptr
    %174 = llvm.getelementptr %173[1750] : (!llvm.ptr) -> !llvm.ptr, i64
    %175 = llvm.ptrtoint %174 : !llvm.ptr to i64
    %176 = llvm.mlir.constant(64 : index) : i64
    %177 = llvm.add %175, %176  : i64
    %178 = llvm.call @malloc(%177) : (i64) -> !llvm.ptr
    %179 = llvm.ptrtoint %178 : !llvm.ptr to i64
    %180 = llvm.mlir.constant(1 : index) : i64
    %181 = llvm.sub %176, %180  : i64
    %182 = llvm.add %179, %181  : i64
    %183 = llvm.urem %182, %176  : i64
    %184 = llvm.sub %182, %183  : i64
    %185 = llvm.inttoptr %184 : i64 to !llvm.ptr
    %186 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %187 = llvm.insertvalue %178, %186[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %188 = llvm.insertvalue %185, %187[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %189 = llvm.mlir.constant(0 : index) : i64
    %190 = llvm.insertvalue %189, %188[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %191 = llvm.insertvalue %169, %190[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %192 = llvm.insertvalue %170, %191[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %193 = llvm.insertvalue %170, %192[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %194 = llvm.insertvalue %171, %193[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb10(%6 : i64)
  ^bb10(%195: i64):  // 2 preds: ^bb9, ^bb17
    %196 = llvm.icmp "slt" %195, %5 : i64
    llvm.cond_br %196, ^bb11, ^bb18
  ^bb11:  // pred: ^bb10
    llvm.br ^bb12(%6 : i64)
  ^bb12(%197: i64):  // 2 preds: ^bb11, ^bb16
    %198 = llvm.icmp "slt" %197, %1 : i64
    llvm.cond_br %198, ^bb13, ^bb17
  ^bb13:  // pred: ^bb12
    llvm.br ^bb14(%6 : i64)
  ^bb14(%199: i64):  // 2 preds: ^bb13, ^bb15
    %200 = llvm.icmp "slt" %199, %3 : i64
    llvm.cond_br %200, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    %201 = llvm.mlir.constant(150 : index) : i64
    %202 = llvm.mul %195, %201  : i64
    %203 = llvm.add %202, %199  : i64
    %204 = llvm.getelementptr %129[%203] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %205 = llvm.load %204 : !llvm.ptr -> i64
    %206 = llvm.mlir.constant(10 : index) : i64
    %207 = llvm.mul %199, %206  : i64
    %208 = llvm.add %207, %197  : i64
    %209 = llvm.getelementptr %103[%208] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %210 = llvm.load %209 : !llvm.ptr -> i64
    %211 = llvm.mlir.constant(10 : index) : i64
    %212 = llvm.mul %195, %211  : i64
    %213 = llvm.add %212, %197  : i64
    %214 = llvm.getelementptr %185[%213] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %215 = llvm.load %214 : !llvm.ptr -> i64
    %216 = llvm.mul %205, %210  : i64
    %217 = llvm.add %215, %216  : i64
    %218 = llvm.mlir.constant(10 : index) : i64
    %219 = llvm.mul %195, %218  : i64
    %220 = llvm.add %219, %197  : i64
    %221 = llvm.getelementptr %185[%220] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %217, %221 : i64, !llvm.ptr
    %222 = llvm.add %199, %4  : i64
    llvm.br ^bb14(%222 : i64)
  ^bb16:  // pred: ^bb14
    %223 = llvm.add %197, %4  : i64
    llvm.br ^bb12(%223 : i64)
  ^bb17:  // pred: ^bb12
    %224 = llvm.add %195, %4  : i64
    llvm.br ^bb10(%224 : i64)
  ^bb18:  // pred: ^bb10
    %225 = llvm.mlir.constant(200 : index) : i64
    %226 = llvm.mlir.constant(10 : index) : i64
    %227 = llvm.mlir.constant(1 : index) : i64
    %228 = llvm.mlir.constant(2000 : index) : i64
    %229 = llvm.mlir.zero : !llvm.ptr
    %230 = llvm.getelementptr %229[2000] : (!llvm.ptr) -> !llvm.ptr, i64
    %231 = llvm.ptrtoint %230 : !llvm.ptr to i64
    %232 = llvm.mlir.constant(64 : index) : i64
    %233 = llvm.add %231, %232  : i64
    %234 = llvm.call @malloc(%233) : (i64) -> !llvm.ptr
    %235 = llvm.ptrtoint %234 : !llvm.ptr to i64
    %236 = llvm.mlir.constant(1 : index) : i64
    %237 = llvm.sub %232, %236  : i64
    %238 = llvm.add %235, %237  : i64
    %239 = llvm.urem %238, %232  : i64
    %240 = llvm.sub %238, %239  : i64
    %241 = llvm.inttoptr %240 : i64 to !llvm.ptr
    %242 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %243 = llvm.insertvalue %234, %242[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %244 = llvm.insertvalue %241, %243[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %245 = llvm.mlir.constant(0 : index) : i64
    %246 = llvm.insertvalue %245, %244[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %247 = llvm.insertvalue %225, %246[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %248 = llvm.insertvalue %226, %247[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %249 = llvm.insertvalue %226, %248[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %250 = llvm.insertvalue %227, %249[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb19(%6 : i64)
  ^bb19(%251: i64):  // 2 preds: ^bb18, ^bb26
    %252 = llvm.icmp "slt" %251, %0 : i64
    llvm.cond_br %252, ^bb20, ^bb27
  ^bb20:  // pred: ^bb19
    llvm.br ^bb21(%6 : i64)
  ^bb21(%253: i64):  // 2 preds: ^bb20, ^bb25
    %254 = llvm.icmp "slt" %253, %1 : i64
    llvm.cond_br %254, ^bb22, ^bb26
  ^bb22:  // pred: ^bb21
    llvm.br ^bb23(%6 : i64)
  ^bb23(%255: i64):  // 2 preds: ^bb22, ^bb24
    %256 = llvm.icmp "slt" %255, %5 : i64
    llvm.cond_br %256, ^bb24, ^bb25
  ^bb24:  // pred: ^bb23
    %257 = llvm.mlir.constant(175 : index) : i64
    %258 = llvm.mul %251, %257  : i64
    %259 = llvm.add %258, %255  : i64
    %260 = llvm.getelementptr %25[%259] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %261 = llvm.load %260 : !llvm.ptr -> i64
    %262 = llvm.mlir.constant(10 : index) : i64
    %263 = llvm.mul %255, %262  : i64
    %264 = llvm.add %263, %253  : i64
    %265 = llvm.getelementptr %185[%264] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %266 = llvm.load %265 : !llvm.ptr -> i64
    %267 = llvm.mlir.constant(10 : index) : i64
    %268 = llvm.mul %251, %267  : i64
    %269 = llvm.add %268, %253  : i64
    %270 = llvm.getelementptr %241[%269] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %271 = llvm.load %270 : !llvm.ptr -> i64
    %272 = llvm.mul %261, %266  : i64
    %273 = llvm.add %271, %272  : i64
    %274 = llvm.mlir.constant(10 : index) : i64
    %275 = llvm.mul %251, %274  : i64
    %276 = llvm.add %275, %253  : i64
    %277 = llvm.getelementptr %241[%276] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %273, %277 : i64, !llvm.ptr
    %278 = llvm.add %255, %4  : i64
    llvm.br ^bb23(%278 : i64)
  ^bb25:  // pred: ^bb23
    %279 = llvm.add %253, %4  : i64
    llvm.br ^bb21(%279 : i64)
  ^bb26:  // pred: ^bb21
    %280 = llvm.add %251, %4  : i64
    llvm.br ^bb19(%280 : i64)
  ^bb27:  // pred: ^bb19
    %281 = llvm.call @clock() : () -> i64
    llvm.call @displayTime(%8, %281) : (i64, i64) -> ()
    %282 = llvm.extractvalue %250[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %283 = llvm.extractvalue %250[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %284 = llvm.extractvalue %250[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %285 = llvm.extractvalue %250[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %286 = llvm.extractvalue %250[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %287 = llvm.extractvalue %250[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %288 = llvm.extractvalue %250[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %289 = llvm.call @blackhole(%282, %283, %284, %285, %286, %287, %288) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    llvm.return %7 : i32
  }
}

