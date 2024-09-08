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
  %21 = icmp slt i64 %20, 4
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
  %32 = fmul double %31, 0x3E33FFFFFABBF5C5
  %33 = fadd double %32, -1.000000e+01
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

define { ptr, ptr, i64, [1 x i64], [1 x i64] } @blackhole(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4) {
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, ptr %1, 1
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, i64 %2, 2
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, i64 %3, 3, 0
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 %4, 4, 0
  ret { ptr, ptr, i64, [1 x i64], [1 x i64] } %10
}

define double @poly_eval_3(double %0, double %1, double %2, double %3, double %4) {
  %6 = fmul fast double %4, %0
  %7 = fadd fast double %1, %6
  %8 = fmul fast double %4, %7
  %9 = fadd fast double %2, %8
  %10 = fmul fast double %4, %9
  %11 = fadd fast double %3, %10
  ret double %11
}

define double @poly_eval_2(double %0, double %1, double %2, double %3) {
  %5 = fmul fast double %3, %0
  %6 = fadd fast double %1, %5
  %7 = fmul fast double %3, %6
  %8 = fadd fast double %2, %7
  ret double %8
}

define i32 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 4000000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 1000000, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 4, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 4, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 4, 1
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 0
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 1
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 2
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 0
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 1
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 0
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 1
  %21 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20)
  %22 = call i64 @clock()
  %23 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 1000000) to i64), i64 64))
  %24 = ptrtoint ptr %23 to i64
  %25 = add i64 %24, 63
  %26 = urem i64 %25, 64
  %27 = sub i64 %25, %26
  %28 = inttoptr i64 %27 to ptr
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %23, 0
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, ptr %28, 1
  %31 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, i64 0, 2
  %32 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %31, i64 1000000, 3, 0
  %33 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %32, i64 1, 4, 0
  br label %34

34:                                               ; preds = %38, %0
  %35 = phi i64 [ %82, %38 ], [ 0, %0 ]
  %36 = phi { ptr, ptr, i64, [1 x i64], [1 x i64] } [ %36, %38 ], [ %33, %0 ]
  %37 = icmp slt i64 %35, 1000000
  br i1 %37, label %38, label %83

38:                                               ; preds = %34
  %39 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %40 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %41 = getelementptr double, ptr %39, i64 %40
  %42 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %43 = mul i64 %35, %42
  %44 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %45 = mul i64 %44, 0
  %46 = add i64 %43, %45
  %47 = getelementptr double, ptr %41, i64 %46
  %48 = load double, ptr %47, align 8
  %49 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %50 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %51 = getelementptr double, ptr %49, i64 %50
  %52 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %53 = mul i64 %35, %52
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %55 = mul i64 %54, 1
  %56 = add i64 %53, %55
  %57 = getelementptr double, ptr %51, i64 %56
  %58 = load double, ptr %57, align 8
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %60 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %61 = getelementptr double, ptr %59, i64 %60
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %63 = mul i64 %35, %62
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %65 = mul i64 %64, 2
  %66 = add i64 %63, %65
  %67 = getelementptr double, ptr %61, i64 %66
  %68 = load double, ptr %67, align 8
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %71 = getelementptr double, ptr %69, i64 %70
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %73 = mul i64 %35, %72
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %75 = mul i64 %74, 3
  %76 = add i64 %73, %75
  %77 = getelementptr double, ptr %71, i64 %76
  %78 = load double, ptr %77, align 8
  %79 = call double @poly_eval_3(double %48, double %58, double %68, double %78, double 1.000000e+00)
  %80 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 1
  %81 = getelementptr double, ptr %80, i64 %35
  store double %79, ptr %81, align 8
  %82 = add i64 %35, 1
  br label %34

83:                                               ; preds = %34
  %84 = call i64 @clock()
  call void @displayTime(i64 %22, i64 %84)
  %85 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 0
  %86 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 1
  %87 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 2
  %88 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 3, 0
  %89 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 4, 0
  %90 = call { ptr, ptr, i64, [1 x i64], [1 x i64] } @blackhole(ptr %85, ptr %86, i64 %87, i64 %88, i64 %89)
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
