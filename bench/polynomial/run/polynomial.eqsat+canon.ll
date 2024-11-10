; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare void @displayTime(i64, i64)

declare void @printF64Tensor1D(ptr, ptr, i64, i64, i64)

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

define i32 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (double, ptr null, i32 5000000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 1000000, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 5, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 5, 4, 0
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
  %35 = phi i64 [ %92, %38 ], [ 0, %0 ]
  %36 = phi { ptr, ptr, i64, [1 x i64], [1 x i64] } [ %36, %38 ], [ %33, %0 ]
  %37 = icmp slt i64 %35, 1000000
  br i1 %37, label %38, label %93

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
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %80 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %81 = getelementptr double, ptr %79, i64 %80
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %83 = mul i64 %35, %82
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %85 = mul i64 %84, 4
  %86 = add i64 %83, %85
  %87 = getelementptr double, ptr %81, i64 %86
  %88 = load double, ptr %87, align 8
  %89 = call double @poly_eval_4(double %48, double %58, double %68, double %78, double %88, double 5.000000e+00)
  %90 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 1
  %91 = getelementptr double, ptr %90, i64 %35
  store double %89, ptr %91, align 8
  %92 = add i64 %35, 1
  br label %34

93:                                               ; preds = %34
  %94 = call i64 @clock()
  %95 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 0
  %96 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 1
  %97 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 2
  %98 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 3, 0
  %99 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %36, 4, 0
  call void @printF64Tensor1D(ptr %95, ptr %96, i64 %97, i64 %98, i64 %99)
  call void @printNewline()
  call void @displayTime(i64 %22, i64 %94)
  ret i32 0
}

define double @poly_eval_4(double %0, double %1, double %2, double %3, double %4, double %5) {
  %7 = fmul double %0, %5
  %8 = fadd double %1, %7
  %9 = fmul double %5, %8
  %10 = fadd double %9, %2
  %11 = fmul double %5, %10
  %12 = fadd double %3, %11
  %13 = fmul double %5, %12
  %14 = fadd double %4, %13
  ret double %14
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
