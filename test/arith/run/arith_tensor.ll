; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@__constant_2x3xf64 = private constant [2 x [3 x double]] [[3 x double] [double 3.000000e+00, double 5.000000e+00, double 7.000000e+00], [3 x double] [double 9.000000e+00, double 1.100000e+01, double 1.300000e+01]], align 64

declare ptr @malloc(i64)

declare void @printI64(i64)

declare void @printF64(double)

declare void @printComma()

declare void @printNewline()

declare i64 @clock()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

declare void @printF64Tensor1D(ptr, ptr, i64, i64, i64)

declare void @printF64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64)

declare void @displayTime(i64, i64)

define i64 @main() {
  %1 = call i64 @clock()
  %2 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i64 6) to i64), i64 64))
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = urem i64 %4, 64
  %6 = sub i64 %4, %5
  %7 = inttoptr i64 %6 to ptr
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %2, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %7, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 0, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 2, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 3, 3, 1
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 3, 4, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 1, 4, 1
  %15 = getelementptr double, ptr %7, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr %15, ptr @__constant_2x3xf64, i64 mul (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 1) to i64), i64 6), i1 false)
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 0
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 1
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 2
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 3, 0
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 3, 1
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 4, 0
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, 4, 1
  call void @printF64Tensor2D(ptr %16, ptr %17, i64 %18, i64 %19, i64 %20, i64 %21, i64 %22)
  call void @printNewline()
  %23 = call i64 @clock()
  call void @displayTime(i64 %1, i64 %23)
  ret i64 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
