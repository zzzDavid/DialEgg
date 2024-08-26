; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

declare ptr @malloc(i64)

declare void @printI64(i64)

declare void @printF64(double)

declare void @printComma()

declare void @printNewline()

declare i64 @clock()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

define void @displayTime(i64 %0, i64 %1) {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+06
  call void @printNewline()
  call void @printNewline()
  %6 = call i32 (ptr, ...) @printf(ptr @time, i64 %3, double %5)
  ret void
}

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

define i64 @rgb_to_grayscale(i64 %0, i64 %1, i64 %2) {
  %4 = mul i64 %0, 77
  %5 = mul i64 %1, 150
  %6 = mul i64 %2, 29
  %7 = sdiv i64 %4, 256
  %8 = sdiv i64 %5, 256
  %9 = sdiv i64 %6, 256
  %10 = add i64 %7, %8
  %11 = add i64 %10, %9
  ret i64 %11
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
}

define i64 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i64 300000000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %9, i64 10000, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %10, i64 10000, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %11, i64 3, 3, 2
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, i64 30000, 4, 0
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 3, 4, 1
  %15 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %14, i64 1, 4, 2
  br label %16

16:                                               ; preds = %36, %0
  %17 = phi i64 [ %37, %36 ], [ 0, %0 ]
  %18 = icmp slt i64 %17, 10000
  br i1 %18, label %19, label %38

19:                                               ; preds = %16
  br label %20

20:                                               ; preds = %34, %19
  %21 = phi i64 [ %35, %34 ], [ 0, %19 ]
  %22 = icmp slt i64 %21, 10000
  br i1 %22, label %23, label %36

23:                                               ; preds = %20
  br label %24

24:                                               ; preds = %27, %23
  %25 = phi i64 [ %33, %27 ], [ 0, %23 ]
  %26 = icmp slt i64 %25, 3
  br i1 %26, label %27, label %34

27:                                               ; preds = %24
  %28 = mul i64 %17, 30000
  %29 = mul i64 %21, 3
  %30 = add i64 %28, %29
  %31 = add i64 %30, %25
  %32 = getelementptr i64, ptr %6, i64 %31
  store i64 100, ptr %32, align 4
  %33 = add i64 %25, 1
  br label %24

34:                                               ; preds = %24
  %35 = add i64 %21, 1
  br label %20

36:                                               ; preds = %20
  %37 = add i64 %17, 1
  br label %16

38:                                               ; preds = %16
  %39 = call i64 @clock()
  %40 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 100000000) to i64), i64 64))
  %41 = ptrtoint ptr %40 to i64
  %42 = add i64 %41, 63
  %43 = urem i64 %42, 64
  %44 = sub i64 %42, %43
  %45 = inttoptr i64 %44 to ptr
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %40, 0
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, ptr %45, 1
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 0, 2
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 10000, 3, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 10000, 3, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 10000, 4, 0
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 1, 4, 1
  br label %53

53:                                               ; preds = %87, %38
  %54 = phi i64 [ %88, %87 ], [ 0, %38 ]
  %55 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %60, %87 ], [ %52, %38 ]
  %56 = icmp slt i64 %54, 10000
  br i1 %56, label %57, label %89

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %62, %57
  %59 = phi i64 [ %86, %62 ], [ 0, %57 ]
  %60 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %60, %62 ], [ %55, %57 ]
  %61 = icmp slt i64 %59, 10000
  br i1 %61, label %62, label %87

62:                                               ; preds = %58
  %63 = mul i64 %54, 30000
  %64 = mul i64 %59, 3
  %65 = add i64 %63, %64
  %66 = add i64 %65, 0
  %67 = getelementptr i64, ptr %6, i64 %66
  %68 = load i64, ptr %67, align 4
  %69 = mul i64 %54, 30000
  %70 = mul i64 %59, 3
  %71 = add i64 %69, %70
  %72 = add i64 %71, 1
  %73 = getelementptr i64, ptr %6, i64 %72
  %74 = load i64, ptr %73, align 4
  %75 = mul i64 %54, 30000
  %76 = mul i64 %59, 3
  %77 = add i64 %75, %76
  %78 = add i64 %77, 2
  %79 = getelementptr i64, ptr %6, i64 %78
  %80 = load i64, ptr %79, align 4
  %81 = call i64 @rgb_to_grayscale(i64 %68, i64 %74, i64 %80)
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 1
  %83 = mul i64 %54, 10000
  %84 = add i64 %83, %59
  %85 = getelementptr i64, ptr %82, i64 %84
  store i64 %81, ptr %85, align 4
  %86 = add i64 %59, 1
  br label %58

87:                                               ; preds = %58
  %88 = add i64 %54, 1
  br label %53

89:                                               ; preds = %53
  %90 = call i64 @clock()
  call void @displayTime(i64 %39, i64 %90)
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 0
  %92 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 1
  %93 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 2
  %94 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 0
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 1
  %96 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 0
  %97 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 1
  %98 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %91, ptr %92, i64 %93, i64 %94, i64 %95, i64 %96, i64 %97)
  ret i64 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
