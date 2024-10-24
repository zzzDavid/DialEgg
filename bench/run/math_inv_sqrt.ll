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
  %5 = fdiv double %4, 1.000000e+06
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
  %17 = icmp slt i64 %16, 1000000
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
  %32 = fmul double %31, 0x3F3E847FF7F70DE4
  %33 = fadd double %32, -1.000000e+06
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
  %22 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 3000000) to i64), i64 64))
  %23 = ptrtoint ptr %22 to i64
  %24 = add i64 %23, 63
  %25 = urem i64 %24, 64
  %26 = sub i64 %24, %25
  %27 = inttoptr i64 %26 to ptr
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %22, 0
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, ptr %27, 1
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, i64 0, 2
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 1000000, 3, 0
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 3, 3, 1
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 3, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 1, 4, 1
  br label %35

35:                                               ; preds = %58, %0
  %36 = phi i64 [ %59, %58 ], [ 0, %0 ]
  %37 = icmp slt i64 %36, 1000000
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
