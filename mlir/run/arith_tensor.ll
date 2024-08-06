; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@__constant_6xi64 = private constant [6 x i64] [i64 3, i64 5, i64 7, i64 9, i64 11, i64 13], align 64
@__constant_2x3xi64_0 = private constant [2 x [3 x i64]] [[3 x i64] [i64 3, i64 5, i64 7], [3 x i64] [i64 9, i64 11, i64 13]], align 64
@__constant_2x3xi64 = private constant [2 x [3 x i64]] [[3 x i64] [i64 2, i64 6, i64 12], [3 x i64] [i64 20, i64 30, i64 42]], align 64
@__constant_6xf64 = private constant [6 x double] [double 1.000000e+00, double 8.000000e+00, double 8.100000e+01, double 1.024000e+03, double 1.562500e+04, double 2.799360e+05], align 64
@__constant_2x3xf64 = private constant [2 x [3 x double]] [[3 x double] [double 1.000000e+00, double 8.000000e+00, double 8.100000e+01], [3 x double] [double 1.024000e+03, double 1.562500e+04, double 2.799360e+05]], align 64

declare void @printI64(i64)

declare void @printF64(double)

declare void @printComma()

declare void @printNewline()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

define void @printI64Tensor1D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4) {
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, ptr %1, 1
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, i64 %2, 2
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, i64 %3, 3, 0
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 %4, 4, 0
  %11 = call i32 @putchar(i32 91)
  %12 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 3
  %13 = alloca [1 x i64], i64 1, align 8
  store [1 x i64] %12, ptr %13, align 4
  %14 = getelementptr [1 x i64], ptr %13, i32 0, i32 0
  %15 = load i64, ptr %14, align 4
  br label %16

16:                                               ; preds = %27, %5
  %17 = phi i64 [ %28, %27 ], [ 0, %5 ]
  %18 = icmp slt i64 %17, %15
  br i1 %18, label %19, label %29

19:                                               ; preds = %16
  %20 = getelementptr i64, ptr %1, i64 %2
  %21 = mul i64 %17, %4
  %22 = getelementptr i64, ptr %20, i64 %21
  %23 = load i64, ptr %22, align 4
  call void @printI64(i64 %23)
  %24 = sub i64 %15, 1
  %25 = icmp ult i64 %17, %24
  br i1 %25, label %26, label %27

26:                                               ; preds = %19
  call void @printComma()
  br label %27

27:                                               ; preds = %26, %19
  %28 = add i64 %17, 1
  br label %16

29:                                               ; preds = %16
  %30 = call i32 @putchar(i32 93)
  ret void
}

define void @printF64Tensor1D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4) {
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, ptr %1, 1
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, i64 %2, 2
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, i64 %3, 3, 0
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 %4, 4, 0
  %11 = call i32 @putchar(i32 91)
  %12 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, 3
  %13 = alloca [1 x i64], i64 1, align 8
  store [1 x i64] %12, ptr %13, align 4
  %14 = getelementptr [1 x i64], ptr %13, i32 0, i32 0
  %15 = load i64, ptr %14, align 4
  br label %16

16:                                               ; preds = %27, %5
  %17 = phi i64 [ %28, %27 ], [ 0, %5 ]
  %18 = icmp slt i64 %17, %15
  br i1 %18, label %19, label %29

19:                                               ; preds = %16
  %20 = getelementptr double, ptr %1, i64 %2
  %21 = mul i64 %17, %4
  %22 = getelementptr double, ptr %20, i64 %21
  %23 = load double, ptr %22, align 8
  call void @printF64(double %23)
  %24 = sub i64 %15, 1
  %25 = icmp ult i64 %17, %24
  br i1 %25, label %26, label %27

26:                                               ; preds = %19
  call void @printComma()
  br label %27

27:                                               ; preds = %26, %19
  %28 = add i64 %17, 1
  br label %16

29:                                               ; preds = %16
  %30 = call i32 @putchar(i32 93)
  ret void
}

define void @printI64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  %15 = call i32 @putchar(i32 91)
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %17 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %16, ptr %17, align 4
  %18 = getelementptr [2 x i64], ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %21 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %20, ptr %21, align 4
  %22 = getelementptr [2 x i64], ptr %21, i32 0, i32 1
  %23 = load i64, ptr %22, align 4
  br label %24

24:                                               ; preds = %47, %7
  %25 = phi i64 [ %48, %47 ], [ 0, %7 ]
  %26 = icmp slt i64 %25, %19
  br i1 %26, label %27, label %49

27:                                               ; preds = %24
  %28 = insertvalue { ptr, ptr, i64 } undef, ptr %0, 0
  %29 = insertvalue { ptr, ptr, i64 } %28, ptr %1, 1
  %30 = insertvalue { ptr, ptr, i64 } %29, i64 0, 2
  %31 = mul i64 %25, %5
  %32 = add i64 %2, %31
  %33 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %34 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %33, ptr %1, 1
  %35 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %34, i64 %32, 2
  %36 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, i64 %23, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, i64 %6, 4, 0
  call void @printNewline()
  %38 = call i32 @putchar(i32 9)
  %39 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 0
  %40 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 1
  %41 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 2
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 3, 0
  %43 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 4, 0
  call void @printI64Tensor1D(ptr %39, ptr %40, i64 %41, i64 %42, i64 %43)
  %44 = sub i64 %19, 1
  %45 = icmp ult i64 %25, %44
  br i1 %45, label %46, label %47

46:                                               ; preds = %27
  call void @printComma()
  br label %47

47:                                               ; preds = %46, %27
  %48 = add i64 %25, 1
  br label %24

49:                                               ; preds = %24
  %50 = icmp sgt i64 %19, 0
  br i1 %50, label %51, label %52

51:                                               ; preds = %49
  call void @printNewline()
  br label %52

52:                                               ; preds = %51, %49
  %53 = call i32 @putchar(i32 93)
  ret void
}

define void @printF64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  %15 = call i32 @putchar(i32 91)
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %17 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %16, ptr %17, align 4
  %18 = getelementptr [2 x i64], ptr %17, i32 0, i32 0
  %19 = load i64, ptr %18, align 4
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %21 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %20, ptr %21, align 4
  %22 = getelementptr [2 x i64], ptr %21, i32 0, i32 1
  %23 = load i64, ptr %22, align 4
  br label %24

24:                                               ; preds = %47, %7
  %25 = phi i64 [ %48, %47 ], [ 0, %7 ]
  %26 = icmp slt i64 %25, %19
  br i1 %26, label %27, label %49

27:                                               ; preds = %24
  %28 = insertvalue { ptr, ptr, i64 } undef, ptr %0, 0
  %29 = insertvalue { ptr, ptr, i64 } %28, ptr %1, 1
  %30 = insertvalue { ptr, ptr, i64 } %29, i64 0, 2
  %31 = mul i64 %25, %5
  %32 = add i64 %2, %31
  %33 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %34 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %33, ptr %1, 1
  %35 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %34, i64 %32, 2
  %36 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, i64 %23, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, i64 %6, 4, 0
  call void @printNewline()
  %38 = call i32 @putchar(i32 9)
  %39 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 0
  %40 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 1
  %41 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 2
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 3, 0
  %43 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, 4, 0
  call void @printF64Tensor1D(ptr %39, ptr %40, i64 %41, i64 %42, i64 %43)
  %44 = sub i64 %19, 1
  %45 = icmp ult i64 %25, %44
  br i1 %45, label %46, label %47

46:                                               ; preds = %27
  call void @printComma()
  br label %47

47:                                               ; preds = %46, %27
  %48 = add i64 %25, 1
  br label %24

49:                                               ; preds = %24
  %50 = icmp sgt i64 %19, 0
  br i1 %50, label %51, label %52

51:                                               ; preds = %49
  call void @printNewline()
  br label %52

52:                                               ; preds = %51, %49
  %53 = call i32 @putchar(i32 93)
  ret void
}

define float @main() {
  call void @printI64Tensor1D(ptr inttoptr (i64 3735928559 to ptr), ptr @__constant_6xi64, i64 0, i64 6, i64 1)
  call void @printNewline()
  call void @printI64Tensor2D(ptr inttoptr (i64 3735928559 to ptr), ptr @__constant_2x3xi64_0, i64 0, i64 2, i64 3, i64 3, i64 1)
  call void @printNewline()
  call void @printI64Tensor2D(ptr inttoptr (i64 3735928559 to ptr), ptr @__constant_2x3xi64, i64 0, i64 2, i64 3, i64 3, i64 1)
  call void @printNewline()
  call void @printF64Tensor1D(ptr inttoptr (i64 3735928559 to ptr), ptr @__constant_6xf64, i64 0, i64 6, i64 1)
  call void @printNewline()
  call void @printF64Tensor2D(ptr inttoptr (i64 3735928559 to ptr), ptr @__constant_2x3xf64, i64 0, i64 2, i64 3, i64 3, i64 1)
  call void @printNewline()
  ret float 0.000000e+00
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
