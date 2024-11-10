; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare void @displayTime(i64, i64)

declare void @printF32Tensor2D(ptr, ptr, i64, i64, i64, i64, i64)

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
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
  br label %23

23:                                               ; preds = %48, %7
  %24 = phi i64 [ %49, %48 ], [ 0, %7 ]
  %25 = icmp slt i64 %24, %18
  br i1 %25, label %26, label %50

26:                                               ; preds = %23
  br label %27

27:                                               ; preds = %30, %26
  %28 = phi i64 [ %47, %30 ], [ 0, %26 ]
  %29 = icmp slt i64 %28, %22
  br i1 %29, label %30, label %48

30:                                               ; preds = %27
  %31 = trunc i64 %28 to i32
  %32 = trunc i64 %24 to i32
  %33 = mul i32 %32, 1103515245
  %34 = add i32 %33, 12345
  %35 = add i32 %31, %34
  %36 = mul i32 %35, 1103515245
  %37 = add i32 %36, 12345
  %38 = sitofp i32 %37 to double
  %39 = fadd double %38, 0x41DFFFFFFFC00000
  %40 = fmul double %39, 0x3E33FFFFFABBF5C5
  %41 = fadd double %40, -1.000000e+01
  %42 = getelementptr double, ptr %1, i64 %2
  %43 = mul i64 %24, %5
  %44 = mul i64 %28, %6
  %45 = add i64 %43, %44
  %46 = getelementptr double, ptr %42, i64 %45
  store double %41, ptr %46, align 8
  %47 = add i64 %28, 1
  br label %27

48:                                               ; preds = %27
  %49 = add i64 %24, 1
  br label %23

50:                                               ; preds = %23
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  %15 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 3000000) to i64), i64 64))
  %16 = ptrtoint ptr %15 to i64
  %17 = add i64 %16, 63
  %18 = urem i64 %17, 64
  %19 = sub i64 %17, %18
  %20 = inttoptr i64 %19 to ptr
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %15, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, ptr %20, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 0, 2
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 1000000, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 3, 3, 1
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 3, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 1, 4, 1
  br label %28

28:                                               ; preds = %32, %7
  %29 = phi i64 [ %67, %32 ], [ 0, %7 ]
  %30 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %30, %32 ], [ %27, %7 ]
  %31 = icmp slt i64 %29, 1000000
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
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 3000000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 1000000, 3, 0
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
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3
  %23 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %22, ptr %23, align 4
  %24 = getelementptr [2 x i64], ptr %23, i32 0, i32 0
  %25 = load i64, ptr %24, align 4
  %26 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3
  %27 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %26, ptr %27, align 4
  %28 = getelementptr [2 x i64], ptr %27, i32 0, i32 1
  %29 = load i64, ptr %28, align 4
  %30 = mul i64 %29, %25
  %31 = getelementptr float, ptr null, i64 %30
  %32 = ptrtoint ptr %31 to i64
  %33 = add i64 %32, 64
  %34 = call ptr @malloc(i64 %33)
  %35 = ptrtoint ptr %34 to i64
  %36 = add i64 %35, 63
  %37 = urem i64 %36, 64
  %38 = sub i64 %36, %37
  %39 = inttoptr i64 %38 to ptr
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %34, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, ptr %39, 1
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 0, 2
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, i64 %25, 3, 0
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, i64 %29, 3, 1
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 %29, 4, 0
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, i64 1, 4, 1
  %47 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3
  %48 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %47, ptr %48, align 4
  %49 = getelementptr [2 x i64], ptr %48, i32 0, i32 0
  %50 = load i64, ptr %49, align 4
  %51 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3
  %52 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %51, ptr %52, align 4
  %53 = getelementptr [2 x i64], ptr %52, i32 0, i32 1
  %54 = load i64, ptr %53, align 4
  br label %55

55:                                               ; preds = %78, %0
  %56 = phi i64 [ %79, %78 ], [ 0, %0 ]
  %57 = icmp slt i64 %56, %50
  br i1 %57, label %58, label %80

58:                                               ; preds = %55
  br label %59

59:                                               ; preds = %62, %58
  %60 = phi i64 [ %77, %62 ], [ 0, %58 ]
  %61 = icmp slt i64 %60, %54
  br i1 %61, label %62, label %78

62:                                               ; preds = %59
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %65 = getelementptr double, ptr %63, i64 %64
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %67 = mul i64 %56, %66
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %69 = mul i64 %60, %68
  %70 = add i64 %67, %69
  %71 = getelementptr double, ptr %65, i64 %70
  %72 = load double, ptr %71, align 8
  %73 = fptrunc double %72 to float
  %74 = mul i64 %56, %29
  %75 = add i64 %74, %60
  %76 = getelementptr float, ptr %39, i64 %75
  store float %73, ptr %76, align 4
  %77 = add i64 %60, 1
  br label %59

78:                                               ; preds = %59
  %79 = add i64 %56, 1
  br label %55

80:                                               ; preds = %55
  %81 = call i64 @clock()
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 0
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 1
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 2
  %85 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 3, 0
  %86 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 3, 1
  %87 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 4, 0
  %88 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, 4, 1
  %89 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr %82, ptr %83, i64 %84, i64 %85, i64 %86, i64 %87, i64 %88)
  %90 = call i64 @clock()
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 0
  %92 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 1
  %93 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 2
  %94 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 3, 0
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 3, 1
  %96 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 4, 0
  %97 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %89, 4, 1
  call void @printF32Tensor2D(ptr %91, ptr %92, i64 %93, i64 %94, i64 %95, i64 %96, i64 %97)
  call void @printNewline()
  call void @displayTime(i64 %81, i64 %90)
  ret i32 0
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
