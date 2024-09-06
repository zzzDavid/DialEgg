; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

declare ptr @malloc(i64)

declare void @printF64(double)

declare void @printF32(float)

declare void @printComma()

declare void @printNewline()

declare i64 @clock()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

define void @displayTime(i64 %0, i64 %1) {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+08
  %6 = call i32 (ptr, ...) @printf(ptr @time, i64 %3, double %5)
  ret void
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  br label %15

15:                                               ; preds = %40, %7
  %16 = phi i64 [ %41, %40 ], [ 0, %7 ]
  %17 = icmp slt i64 %16, 100000
  br i1 %17, label %18, label %42

18:                                               ; preds = %15
  br label %19

19:                                               ; preds = %22, %18
  %20 = phi i64 [ %39, %22 ], [ 0, %18 ]
  %21 = icmp slt i64 %20, 3
  br i1 %21, label %22, label %40

22:                                               ; preds = %19
  %23 = trunc i64 %20 to i32
  %24 = trunc i64 %16 to i32
  %25 = mul i32 %24, 1103515245
  %26 = add i32 %25, 12345
  %27 = add i32 %23, %26
  %28 = mul i32 %27, 1103515245
  %29 = add i32 %28, 12345
  %30 = sitofp i32 %29 to double
  %31 = fadd double %30, 0x41DFFFFFFFC00000
  %32 = fmul double %31, 0x3F0869FFF9927183
  %33 = fadd double %32, -1.000000e+05
  %34 = getelementptr double, ptr %1, i64 %2
  %35 = mul i64 %16, %5
  %36 = mul i64 %20, %6
  %37 = add i64 %35, %36
  %38 = getelementptr double, ptr %34, i64 %37
  store double %33, ptr %38, align 8
  %39 = add i64 %20, 1
  br label %19

40:                                               ; preds = %19
  %41 = add i64 %16, 1
  br label %15

42:                                               ; preds = %15
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
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

define void @printF32Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %16 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %15, ptr %16, align 4
  %17 = getelementptr [2 x i64], ptr %16, i32 0, i32 0
  %18 = load i64, ptr %17, align 4
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %20 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %19, ptr %20, align 4
  %21 = getelementptr [2 x i64], ptr %20, i32 0, i32 1
  %22 = load i64, ptr %21, align 4
  %23 = mul i64 %22, %18
  %24 = getelementptr double, ptr null, i64 %23
  %25 = ptrtoint ptr %24 to i64
  %26 = add i64 %25, 64
  %27 = call ptr @malloc(i64 %26)
  %28 = ptrtoint ptr %27 to i64
  %29 = add i64 %28, 63
  %30 = urem i64 %29, 64
  %31 = sub i64 %29, %30
  %32 = inttoptr i64 %31 to ptr
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %27, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, ptr %32, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 0, 2
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 %18, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 %22, 3, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %22, 4, 0
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 1, 4, 1
  %40 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %41 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %40, ptr %41, align 4
  %42 = getelementptr [2 x i64], ptr %41, i32 0, i32 0
  %43 = load i64, ptr %42, align 4
  %44 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %45 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %44, ptr %45, align 4
  %46 = getelementptr [2 x i64], ptr %45, i32 0, i32 1
  %47 = load i64, ptr %46, align 4
  br label %48

48:                                               ; preds = %67, %7
  %49 = phi i64 [ %68, %67 ], [ 0, %7 ]
  %50 = icmp slt i64 %49, %43
  br i1 %50, label %51, label %69

51:                                               ; preds = %48
  br label %52

52:                                               ; preds = %55, %51
  %53 = phi i64 [ %66, %55 ], [ 0, %51 ]
  %54 = icmp slt i64 %53, %47
  br i1 %54, label %55, label %67

55:                                               ; preds = %52
  %56 = getelementptr float, ptr %1, i64 %2
  %57 = mul i64 %49, %5
  %58 = mul i64 %53, %6
  %59 = add i64 %57, %58
  %60 = getelementptr float, ptr %56, i64 %59
  %61 = load float, ptr %60, align 4
  %62 = fpext float %61 to double
  %63 = mul i64 %49, %22
  %64 = add i64 %63, %53
  %65 = getelementptr double, ptr %32, i64 %64
  store double %62, ptr %65, align 8
  %66 = add i64 %53, 1
  br label %52

67:                                               ; preds = %52
  %68 = add i64 %49, 1
  br label %48

69:                                               ; preds = %48
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 0
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 1
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 2
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 0
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 1
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 0
  %76 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 1
  call void @printF64Tensor2D(ptr %70, ptr %71, i64 %72, i64 %73, i64 %74, i64 %75, i64 %76)
  ret void
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

define float @fast_inv_sqrt(float %0) {
  %2 = fmul float %0, 5.000000e-01
  %3 = bitcast float %0 to i32
  %4 = ashr i32 %3, 1
  %5 = sub i32 1597463007, %4
  %6 = bitcast i32 %5 to float
  %7 = fmul float %6, %6
  %8 = fmul float %2, %7
  %9 = fsub float 1.500000e+00, %8
  %10 = fmul float %6, %9
  ret float %10
}

define { float, float, float } @normalize_vector(float %0, float %1, float %2) {
  %4 = fmul float %0, %0
  %5 = fmul float %1, %1
  %6 = fmul float %2, %2
  %7 = fadd float %4, %5
  %8 = fadd float %7, %6
  %9 = call fast float @llvm.sqrt.f32(float %8)
  %10 = fdiv fast float 1.000000e+00, %9
  %11 = fmul float %0, %10
  %12 = fmul float %1, %10
  %13 = fmul float %2, %10
  %14 = insertvalue { float, float, float } undef, float %11, 0
  %15 = insertvalue { float, float, float } %14, float %12, 1
  %16 = insertvalue { float, float, float } %15, float %13, 2
  ret { float, float, float } %16
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  %15 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 300000) to i64), i64 64))
  %16 = ptrtoint ptr %15 to i64
  %17 = add i64 %16, 63
  %18 = urem i64 %17, 64
  %19 = sub i64 %17, %18
  %20 = inttoptr i64 %19 to ptr
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %15, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, ptr %20, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 0, 2
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 100000, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 3, 3, 1
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 3, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 1, 4, 1
  br label %28

28:                                               ; preds = %32, %7
  %29 = phi i64 [ %67, %32 ], [ 0, %7 ]
  %30 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %30, %32 ], [ %27, %7 ]
  %31 = icmp slt i64 %29, 100000
  br i1 %31, label %32, label %68

32:                                               ; preds = %28
  %33 = getelementptr float, ptr %1, i64 %2
  %34 = mul i64 %29, %5
  %35 = mul i64 %6, 0
  %36 = add i64 %34, %35
  %37 = getelementptr float, ptr %33, i64 %36
  %38 = load float, ptr %37, align 4
  %39 = getelementptr float, ptr %1, i64 %2
  %40 = mul i64 %29, %5
  %41 = mul i64 %6, 1
  %42 = add i64 %40, %41
  %43 = getelementptr float, ptr %39, i64 %42
  %44 = load float, ptr %43, align 4
  %45 = getelementptr float, ptr %1, i64 %2
  %46 = mul i64 %29, %5
  %47 = mul i64 %6, 2
  %48 = add i64 %46, %47
  %49 = getelementptr float, ptr %45, i64 %48
  %50 = load float, ptr %49, align 4
  %51 = call { float, float, float } @normalize_vector(float %38, float %44, float %50)
  %52 = extractvalue { float, float, float } %51, 0
  %53 = extractvalue { float, float, float } %51, 1
  %54 = extractvalue { float, float, float } %51, 2
  %55 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, 1
  %56 = mul i64 %29, 3
  %57 = add i64 %56, 0
  %58 = getelementptr float, ptr %55, i64 %57
  store float %52, ptr %58, align 4
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, 1
  %60 = mul i64 %29, 3
  %61 = add i64 %60, 1
  %62 = getelementptr float, ptr %59, i64 %61
  store float %53, ptr %62, align 4
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, 1
  %64 = mul i64 %29, 3
  %65 = add i64 %64, 2
  %66 = getelementptr float, ptr %63, i64 %65
  store float %54, ptr %66, align 4
  %67 = add i64 %29, 1
  br label %28

68:                                               ; preds = %28
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %30
}

define i32 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 300000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 100000, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 3, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 3, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 4, 1
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 0
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 1
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 2
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 0
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 1
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 0
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 1
  %21 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20)
  %22 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 300000) to i64), i64 64))
  %23 = ptrtoint ptr %22 to i64
  %24 = add i64 %23, 63
  %25 = urem i64 %24, 64
  %26 = sub i64 %24, %25
  %27 = inttoptr i64 %26 to ptr
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %22, 0
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, ptr %27, 1
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, i64 0, 2
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 100000, 3, 0
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 3, 3, 1
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 3, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 1, 4, 1
  br label %35

35:                                               ; preds = %58, %0
  %36 = phi i64 [ %59, %58 ], [ 0, %0 ]
  %37 = icmp slt i64 %36, 100000
  br i1 %37, label %38, label %60

38:                                               ; preds = %35
  br label %39

39:                                               ; preds = %42, %38
  %40 = phi i64 [ %57, %42 ], [ 0, %38 ]
  %41 = icmp slt i64 %40, 3
  br i1 %41, label %42, label %58

42:                                               ; preds = %39
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %44 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %45 = getelementptr double, ptr %43, i64 %44
  %46 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %47 = mul i64 %36, %46
  %48 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %49 = mul i64 %40, %48
  %50 = add i64 %47, %49
  %51 = getelementptr double, ptr %45, i64 %50
  %52 = load double, ptr %51, align 8
  %53 = fptrunc double %52 to float
  %54 = mul i64 %36, 3
  %55 = add i64 %54, %40
  %56 = getelementptr float, ptr %27, i64 %55
  store float %53, ptr %56, align 4
  %57 = add i64 %40, 1
  br label %39

58:                                               ; preds = %39
  %59 = add i64 %36, 1
  br label %35

60:                                               ; preds = %35
  %61 = call i64 @clock()
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 0
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 1
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 2
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 3, 0
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 3, 1
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 4, 0
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 4, 1
  %69 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr %62, ptr %63, i64 %64, i64 %65, i64 %66, i64 %67, i64 %68)
  %70 = call i64 @clock()
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 0
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 1
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 2
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 3, 0
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 3, 1
  %76 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 4, 0
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %69, 4, 1
  %78 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %71, ptr %72, i64 %73, i64 %74, i64 %75, i64 %76, i64 %77)
  call void @displayTime(i64 %61, i64 %70)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
