; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare void @displayTime(i64, i64)

declare void @printI64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64)

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) {
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
  %17 = getelementptr [2 x i64], ptr %16, i32 0, i32 1
  %18 = load i64, ptr %17, align 4
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3
  %20 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %19, ptr %20, align 4
  %21 = getelementptr [2 x i64], ptr %20, i32 0, i32 0
  %22 = load i64, ptr %21, align 4
  %23 = mul i64 %18, %22
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
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 %22, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 %18, 3, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %18, 4, 0
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 1, 4, 1
  br label %40

40:                                               ; preds = %63, %7
  %41 = phi i64 [ %64, %63 ], [ 0, %7 ]
  %42 = icmp slt i64 %41, %22
  br i1 %42, label %43, label %65

43:                                               ; preds = %40
  br label %44

44:                                               ; preds = %47, %43
  %45 = phi i64 [ %62, %47 ], [ 0, %43 ]
  %46 = icmp slt i64 %45, %18
  br i1 %46, label %47, label %63

47:                                               ; preds = %44
  %48 = trunc i64 %45 to i32
  %49 = trunc i64 %41 to i32
  %50 = mul i32 %49, 1103515245
  %51 = add i32 %50, 12345
  %52 = add i32 %48, %51
  %53 = mul i32 %52, 1103515245
  %54 = add i32 %53, 12345
  %55 = sitofp i32 %54 to double
  %56 = fadd double %55, 0x41DFFFFFFFC00000
  %57 = fmul double %56, 0x3E33FFFFFABBF5C5
  %58 = fadd double %57, -1.000000e+01
  %59 = mul i64 %41, %18
  %60 = add i64 %59, %45
  %61 = getelementptr double, ptr %32, i64 %60
  store double %58, ptr %61, align 8
  %62 = add i64 %45, 1
  br label %44

63:                                               ; preds = %44
  %64 = add i64 %41, 1
  br label %40

65:                                               ; preds = %40
  br label %66

66:                                               ; preds = %83, %65
  %67 = phi i64 [ %84, %83 ], [ 0, %65 ]
  %68 = icmp slt i64 %67, %22
  br i1 %68, label %69, label %85

69:                                               ; preds = %66
  br label %70

70:                                               ; preds = %73, %69
  %71 = phi i64 [ %82, %73 ], [ 0, %69 ]
  %72 = icmp slt i64 %71, %18
  br i1 %72, label %73, label %83

73:                                               ; preds = %70
  %74 = mul i64 %67, %18
  %75 = add i64 %74, %71
  %76 = getelementptr double, ptr %32, i64 %75
  %77 = load double, ptr %76, align 8
  %78 = call double @llvm.floor.f64(double %77)
  %79 = mul i64 %67, %18
  %80 = add i64 %79, %71
  %81 = getelementptr double, ptr %32, i64 %80
  store double %78, ptr %81, align 8
  %82 = add i64 %71, 1
  br label %70

83:                                               ; preds = %70
  %84 = add i64 %67, 1
  br label %66

85:                                               ; preds = %66
  %86 = mul i64 %18, %22
  %87 = getelementptr i64, ptr null, i64 %86
  %88 = ptrtoint ptr %87 to i64
  %89 = add i64 %88, 64
  %90 = call ptr @malloc(i64 %89)
  %91 = ptrtoint ptr %90 to i64
  %92 = add i64 %91, 63
  %93 = urem i64 %92, 64
  %94 = sub i64 %92, %93
  %95 = inttoptr i64 %94 to ptr
  %96 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %90, 0
  %97 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %96, ptr %95, 1
  %98 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %97, i64 0, 2
  %99 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %98, i64 %22, 3, 0
  %100 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %99, i64 %18, 3, 1
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %100, i64 %18, 4, 0
  %102 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, i64 1, 4, 1
  br label %103

103:                                              ; preds = %120, %85
  %104 = phi i64 [ %121, %120 ], [ 0, %85 ]
  %105 = icmp slt i64 %104, %22
  br i1 %105, label %106, label %122

106:                                              ; preds = %103
  br label %107

107:                                              ; preds = %110, %106
  %108 = phi i64 [ %119, %110 ], [ 0, %106 ]
  %109 = icmp slt i64 %108, %18
  br i1 %109, label %110, label %120

110:                                              ; preds = %107
  %111 = mul i64 %104, %18
  %112 = add i64 %111, %108
  %113 = getelementptr double, ptr %32, i64 %112
  %114 = load double, ptr %113, align 8
  %115 = fptosi double %114 to i64
  %116 = mul i64 %104, %18
  %117 = add i64 %116, %108
  %118 = getelementptr i64, ptr %95, i64 %117
  store i64 %115, ptr %118, align 4
  %119 = add i64 %108, 1
  br label %107

120:                                              ; preds = %107
  %121 = add i64 %104, 1
  br label %103

122:                                              ; preds = %103
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %102
}

define i32 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i64 1000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 100, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 10, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 10, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 4, 1
  %14 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i64 1500) to i64), i64 64))
  %15 = ptrtoint ptr %14 to i64
  %16 = add i64 %15, 63
  %17 = urem i64 %16, 64
  %18 = sub i64 %16, %17
  %19 = inttoptr i64 %18 to ptr
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, ptr %19, 1
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 0, 2
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 10, 3, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 150, 3, 1
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 150, 4, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 1, 4, 1
  %27 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i64 1200) to i64), i64 64))
  %28 = ptrtoint ptr %27 to i64
  %29 = add i64 %28, 63
  %30 = urem i64 %29, 64
  %31 = sub i64 %29, %30
  %32 = inttoptr i64 %31 to ptr
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %27, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, ptr %32, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 0, 2
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 150, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 8, 3, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 8, 4, 0
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 1, 4, 1
  %40 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 0
  %41 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 1
  %42 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 2
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 0
  %44 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 1
  %45 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 0
  %46 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 1
  %47 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %40, ptr %41, i64 %42, i64 %43, i64 %44, i64 %45, i64 %46)
  %48 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 0
  %49 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 1
  %50 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 2
  %51 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 0
  %52 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 1
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 0
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 1
  %55 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %48, ptr %49, i64 %50, i64 %51, i64 %52, i64 %53, i64 %54)
  %56 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 0
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 1
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 2
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 0
  %60 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 1
  %61 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 0
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 1
  %63 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %56, ptr %57, i64 %58, i64 %59, i64 %60, i64 %61, i64 %62)
  %64 = call i64 @clock()
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 0
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 1
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 2
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 3, 0
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 3, 1
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 4, 0
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, 4, 1
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 0
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 1
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 2
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 0
  %76 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 1
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 0
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 1
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 0
  %80 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 1
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 2
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 3, 0
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 3, 1
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 0
  %85 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 1
  %86 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @_2mm(ptr %65, ptr %66, i64 %67, i64 %68, i64 %69, i64 %70, i64 %71, ptr %72, ptr %73, i64 %74, i64 %75, i64 %76, i64 %77, i64 %78, ptr %79, ptr %80, i64 %81, i64 %82, i64 %83, i64 %84, i64 %85)
  %87 = call i64 @clock()
  %88 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 0
  %89 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 1
  %90 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 2
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 3, 0
  %92 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 3, 1
  %93 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 4, 0
  %94 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %86, 4, 1
  call void @printI64Tensor2D(ptr %88, ptr %89, i64 %90, i64 %91, i64 %92, i64 %93, i64 %94)
  call void @printNewline()
  call void @displayTime(i64 %64, i64 %87)
  ret i32 0
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @_2mm(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, ptr %1, 1
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 %2, 2
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 %3, 3, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 %5, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 %4, 3, 1
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 %6, 4, 1
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %7, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %8, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %9, 2
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 %10, 3, 0
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 %12, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %11, 3, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %13, 4, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %15, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %16, 2
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %17, 3, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %19, 4, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %18, 3, 1
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %20, 4, 1
  %43 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 15000) to i64), i64 64))
  %44 = ptrtoint ptr %43 to i64
  %45 = add i64 %44, 63
  %46 = urem i64 %45, 64
  %47 = sub i64 %45, %46
  %48 = inttoptr i64 %47 to ptr
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %43, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, ptr %48, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 0, 2
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 100, 3, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 150, 3, 1
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 150, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 1, 4, 1
  br label %56

56:                                               ; preds = %92, %21
  %57 = phi i64 [ %93, %92 ], [ 0, %21 ]
  %58 = icmp slt i64 %57, 100
  br i1 %58, label %59, label %94

59:                                               ; preds = %56
  br label %60

60:                                               ; preds = %90, %59
  %61 = phi i64 [ %91, %90 ], [ 0, %59 ]
  %62 = icmp slt i64 %61, 150
  br i1 %62, label %63, label %92

63:                                               ; preds = %60
  br label %64

64:                                               ; preds = %67, %63
  %65 = phi i64 [ %89, %67 ], [ 0, %63 ]
  %66 = icmp slt i64 %65, 10
  br i1 %66, label %67, label %90

67:                                               ; preds = %64
  %68 = getelementptr i64, ptr %1, i64 %2
  %69 = mul i64 %57, %5
  %70 = mul i64 %65, %6
  %71 = add i64 %69, %70
  %72 = getelementptr i64, ptr %68, i64 %71
  %73 = load i64, ptr %72, align 4
  %74 = getelementptr i64, ptr %8, i64 %9
  %75 = mul i64 %65, %12
  %76 = mul i64 %61, %13
  %77 = add i64 %75, %76
  %78 = getelementptr i64, ptr %74, i64 %77
  %79 = load i64, ptr %78, align 4
  %80 = mul i64 %57, 150
  %81 = add i64 %80, %61
  %82 = getelementptr i64, ptr %48, i64 %81
  %83 = load i64, ptr %82, align 4
  %84 = mul i64 %73, %79
  %85 = add i64 %83, %84
  %86 = mul i64 %57, 150
  %87 = add i64 %86, %61
  %88 = getelementptr i64, ptr %48, i64 %87
  store i64 %85, ptr %88, align 4
  %89 = add i64 %65, 1
  br label %64

90:                                               ; preds = %64
  %91 = add i64 %61, 1
  br label %60

92:                                               ; preds = %60
  %93 = add i64 %57, 1
  br label %56

94:                                               ; preds = %56
  %95 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 800) to i64), i64 64))
  %96 = ptrtoint ptr %95 to i64
  %97 = add i64 %96, 63
  %98 = urem i64 %97, 64
  %99 = sub i64 %97, %98
  %100 = inttoptr i64 %99 to ptr
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %95, 0
  %102 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, ptr %100, 1
  %103 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %102, i64 0, 2
  %104 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, i64 100, 3, 0
  %105 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %104, i64 8, 3, 1
  %106 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %105, i64 8, 4, 0
  %107 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %106, i64 1, 4, 1
  br label %108

108:                                              ; preds = %142, %94
  %109 = phi i64 [ %143, %142 ], [ 0, %94 ]
  %110 = icmp slt i64 %109, 100
  br i1 %110, label %111, label %144

111:                                              ; preds = %108
  br label %112

112:                                              ; preds = %140, %111
  %113 = phi i64 [ %141, %140 ], [ 0, %111 ]
  %114 = icmp slt i64 %113, 8
  br i1 %114, label %115, label %142

115:                                              ; preds = %112
  br label %116

116:                                              ; preds = %119, %115
  %117 = phi i64 [ %139, %119 ], [ 0, %115 ]
  %118 = icmp slt i64 %117, 150
  br i1 %118, label %119, label %140

119:                                              ; preds = %116
  %120 = mul i64 %109, 150
  %121 = add i64 %120, %117
  %122 = getelementptr i64, ptr %48, i64 %121
  %123 = load i64, ptr %122, align 4
  %124 = getelementptr i64, ptr %15, i64 %16
  %125 = mul i64 %117, %19
  %126 = mul i64 %113, %20
  %127 = add i64 %125, %126
  %128 = getelementptr i64, ptr %124, i64 %127
  %129 = load i64, ptr %128, align 4
  %130 = mul i64 %109, 8
  %131 = add i64 %130, %113
  %132 = getelementptr i64, ptr %100, i64 %131
  %133 = load i64, ptr %132, align 4
  %134 = mul i64 %123, %129
  %135 = add i64 %133, %134
  %136 = mul i64 %109, 8
  %137 = add i64 %136, %113
  %138 = getelementptr i64, ptr %100, i64 %137
  store i64 %135, ptr %138, align 4
  %139 = add i64 %117, 1
  br label %116

140:                                              ; preds = %116
  %141 = add i64 %113, 1
  br label %112

142:                                              ; preds = %112
  %143 = add i64 %109, 1
  br label %108

144:                                              ; preds = %108
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %107
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
