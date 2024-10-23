; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

declare ptr @malloc(i64)

declare i64 @clock()

declare i32 @printf(ptr, ...)

define void @displayTime(i64 %0, i64 %1) {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+06
  %6 = call i32 (ptr, ...) @printf(ptr @time, i64 %3, double %5)
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
  %2 = fmul fast float %0, 5.000000e-01
  %3 = bitcast float %0 to i32
  %4 = ashr i32 %3, 1
  %5 = sub i32 1597463007, %4
  %6 = bitcast i32 %5 to float
  %7 = fmul fast float %6, %6
  %8 = fmul fast float %2, %7
  %9 = fsub fast float 1.500000e+00, %8
  %10 = fmul fast float %6, %9
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
  %14 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 3000000) to i64), i64 64))
  %15 = ptrtoint ptr %14 to i64
  %16 = add i64 %15, 63
  %17 = urem i64 %16, 64
  %18 = sub i64 %16, %17
  %19 = inttoptr i64 %18 to ptr
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, ptr %19, 1
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 0, 2
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 1000000, 3, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 3, 3, 1
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 3, 4, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 1, 4, 1
  br label %27

27:                                               ; preds = %44, %0
  %28 = phi i64 [ %45, %44 ], [ 0, %0 ]
  %29 = icmp slt i64 %28, 1000000
  br i1 %29, label %30, label %46

30:                                               ; preds = %27
  br label %31

31:                                               ; preds = %34, %30
  %32 = phi i64 [ %43, %34 ], [ 0, %30 ]
  %33 = icmp slt i64 %32, 3
  br i1 %33, label %34, label %44

34:                                               ; preds = %31
  %35 = mul i64 %28, 3
  %36 = add i64 %35, %32
  %37 = getelementptr double, ptr %6, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = fptrunc double %38 to float
  %40 = mul i64 %28, 3
  %41 = add i64 %40, %32
  %42 = getelementptr float, ptr %19, i64 %41
  store float %39, ptr %42, align 4
  %43 = add i64 %32, 1
  br label %31

44:                                               ; preds = %31
  %45 = add i64 %28, 1
  br label %27

46:                                               ; preds = %27
  %47 = call i64 @clock()
  %48 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 0
  %49 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 1
  %50 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 2
  %51 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 0
  %52 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 1
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 0
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 1
  %55 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr %48, ptr %49, i64 %50, i64 %51, i64 %52, i64 %53, i64 %54)
  %56 = call i64 @clock()
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 0
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 1
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 2
  %60 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 0
  %61 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 1
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 0
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 1
  %64 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %57, ptr %58, i64 %59, i64 %60, i64 %61, i64 %62, i64 %63)
  call void @displayTime(i64 %47, i64 %56)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
