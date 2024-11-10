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
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 35000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 200, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 175, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 175, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 4, 1
  %14 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 43750) to i64), i64 64))
  %15 = ptrtoint ptr %14 to i64
  %16 = add i64 %15, 63
  %17 = urem i64 %16, 64
  %18 = sub i64 %16, %17
  %19 = inttoptr i64 %18 to ptr
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, ptr %19, 1
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 0, 2
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 175, 3, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 250, 3, 1
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 250, 4, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 1, 4, 1
  %27 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 37500) to i64), i64 64))
  %28 = ptrtoint ptr %27 to i64
  %29 = add i64 %28, 63
  %30 = urem i64 %29, 64
  %31 = sub i64 %29, %30
  %32 = inttoptr i64 %31 to ptr
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %27, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, ptr %32, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 0, 2
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 250, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 150, 3, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 150, 4, 0
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 1, 4, 1
  %40 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1500) to i64), i64 64))
  %41 = ptrtoint ptr %40 to i64
  %42 = add i64 %41, 63
  %43 = urem i64 %42, 64
  %44 = sub i64 %42, %43
  %45 = inttoptr i64 %44 to ptr
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %40, 0
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, ptr %45, 1
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 0, 2
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 150, 3, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 10, 3, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 10, 4, 0
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 1, 4, 1
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 0
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 1
  %55 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 2
  %56 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 0
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 1
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 0
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 1
  %60 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %53, ptr %54, i64 %55, i64 %56, i64 %57, i64 %58, i64 %59)
  %61 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 0
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 1
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 2
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 0
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 3, 1
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 0
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, 4, 1
  %68 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %61, ptr %62, i64 %63, i64 %64, i64 %65, i64 %66, i64 %67)
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 0
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 1
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 2
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 0
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 3, 1
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 0
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, 4, 1
  %76 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %69, ptr %70, i64 %71, i64 %72, i64 %73, i64 %74, i64 %75)
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 0
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 1
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 2
  %80 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 3, 0
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 3, 1
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 4, 0
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, 4, 1
  %84 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %77, ptr %78, i64 %79, i64 %80, i64 %81, i64 %82, i64 %83)
  %85 = call i64 @clock()
  %86 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 0
  %87 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 1
  %88 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 2
  %89 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 3, 0
  %90 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 3, 1
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 4, 0
  %92 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, 4, 1
  %93 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 0
  %94 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 1
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 2
  %96 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 3, 0
  %97 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 3, 1
  %98 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 4, 0
  %99 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, 4, 1
  %100 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 0
  %101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 1
  %102 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 2
  %103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 3, 0
  %104 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 3, 1
  %105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 4, 0
  %106 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, 4, 1
  %107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 0
  %108 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 1
  %109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 2
  %110 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 3, 0
  %111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 3, 1
  %112 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 4, 0
  %113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %84, 4, 1
  %114 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @_3mm(ptr %86, ptr %87, i64 %88, i64 %89, i64 %90, i64 %91, i64 %92, ptr %93, ptr %94, i64 %95, i64 %96, i64 %97, i64 %98, i64 %99, ptr %100, ptr %101, i64 %102, i64 %103, i64 %104, i64 %105, i64 %106, ptr %107, ptr %108, i64 %109, i64 %110, i64 %111, i64 %112, i64 %113)
  %115 = call i64 @clock()
  %116 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 0
  %117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 1
  %118 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 2
  %119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 3, 0
  %120 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 3, 1
  %121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 4, 0
  %122 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %114, 4, 1
  call void @printI64Tensor2D(ptr %116, ptr %117, i64 %118, i64 %119, i64 %120, i64 %121, i64 %122)
  call void @printNewline()
  call void @displayTime(i64 %85, i64 %115)
  ret i32 0
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @_3mm(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, ptr %21, ptr %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27) {
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %1, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %2, 2
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 %3, 3, 0
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 %5, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %4, 3, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %6, 4, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %7, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %8, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %9, 2
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %10, 3, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %12, 4, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %11, 3, 1
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %13, 4, 1
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, ptr %15, 1
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 %16, 2
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, i64 %17, 3, 0
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, i64 %19, 4, 0
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 %18, 3, 1
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 %20, 4, 1
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %21, 0
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, ptr %22, 1
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 %23, 2
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 %24, 3, 0
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 %26, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 %25, 3, 1
  %56 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, i64 %27, 4, 1
  %57 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 2500) to i64), i64 64))
  %58 = ptrtoint ptr %57 to i64
  %59 = add i64 %58, 63
  %60 = urem i64 %59, 64
  %61 = sub i64 %59, %60
  %62 = inttoptr i64 %61 to ptr
  %63 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %57, 0
  %64 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, ptr %62, 1
  %65 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %64, i64 0, 2
  %66 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, i64 250, 3, 0
  %67 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, i64 10, 3, 1
  %68 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %67, i64 10, 4, 0
  %69 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %68, i64 1, 4, 1
  br label %70

70:                                               ; preds = %106, %28
  %71 = phi i64 [ %107, %106 ], [ 0, %28 ]
  %72 = icmp slt i64 %71, 250
  br i1 %72, label %73, label %108

73:                                               ; preds = %70
  br label %74

74:                                               ; preds = %104, %73
  %75 = phi i64 [ %105, %104 ], [ 0, %73 ]
  %76 = icmp slt i64 %75, 10
  br i1 %76, label %77, label %106

77:                                               ; preds = %74
  br label %78

78:                                               ; preds = %81, %77
  %79 = phi i64 [ %103, %81 ], [ 0, %77 ]
  %80 = icmp slt i64 %79, 150
  br i1 %80, label %81, label %104

81:                                               ; preds = %78
  %82 = getelementptr i64, ptr %15, i64 %16
  %83 = mul i64 %71, %19
  %84 = mul i64 %79, %20
  %85 = add i64 %83, %84
  %86 = getelementptr i64, ptr %82, i64 %85
  %87 = load i64, ptr %86, align 4
  %88 = getelementptr i64, ptr %22, i64 %23
  %89 = mul i64 %79, %26
  %90 = mul i64 %75, %27
  %91 = add i64 %89, %90
  %92 = getelementptr i64, ptr %88, i64 %91
  %93 = load i64, ptr %92, align 4
  %94 = mul i64 %71, 10
  %95 = add i64 %94, %75
  %96 = getelementptr i64, ptr %62, i64 %95
  %97 = load i64, ptr %96, align 4
  %98 = mul i64 %87, %93
  %99 = add i64 %97, %98
  %100 = mul i64 %71, 10
  %101 = add i64 %100, %75
  %102 = getelementptr i64, ptr %62, i64 %101
  store i64 %99, ptr %102, align 4
  %103 = add i64 %79, 1
  br label %78

104:                                              ; preds = %78
  %105 = add i64 %75, 1
  br label %74

106:                                              ; preds = %74
  %107 = add i64 %71, 1
  br label %70

108:                                              ; preds = %70
  %109 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1750) to i64), i64 64))
  %110 = ptrtoint ptr %109 to i64
  %111 = add i64 %110, 63
  %112 = urem i64 %111, 64
  %113 = sub i64 %111, %112
  %114 = inttoptr i64 %113 to ptr
  %115 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %109, 0
  %116 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %115, ptr %114, 1
  %117 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %116, i64 0, 2
  %118 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, i64 175, 3, 0
  %119 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %118, i64 10, 3, 1
  %120 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %119, i64 10, 4, 0
  %121 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %120, i64 1, 4, 1
  br label %122

122:                                              ; preds = %156, %108
  %123 = phi i64 [ %157, %156 ], [ 0, %108 ]
  %124 = icmp slt i64 %123, 175
  br i1 %124, label %125, label %158

125:                                              ; preds = %122
  br label %126

126:                                              ; preds = %154, %125
  %127 = phi i64 [ %155, %154 ], [ 0, %125 ]
  %128 = icmp slt i64 %127, 10
  br i1 %128, label %129, label %156

129:                                              ; preds = %126
  br label %130

130:                                              ; preds = %133, %129
  %131 = phi i64 [ %153, %133 ], [ 0, %129 ]
  %132 = icmp slt i64 %131, 250
  br i1 %132, label %133, label %154

133:                                              ; preds = %130
  %134 = getelementptr i64, ptr %8, i64 %9
  %135 = mul i64 %123, %12
  %136 = mul i64 %131, %13
  %137 = add i64 %135, %136
  %138 = getelementptr i64, ptr %134, i64 %137
  %139 = load i64, ptr %138, align 4
  %140 = mul i64 %131, 10
  %141 = add i64 %140, %127
  %142 = getelementptr i64, ptr %62, i64 %141
  %143 = load i64, ptr %142, align 4
  %144 = mul i64 %123, 10
  %145 = add i64 %144, %127
  %146 = getelementptr i64, ptr %114, i64 %145
  %147 = load i64, ptr %146, align 4
  %148 = mul i64 %139, %143
  %149 = add i64 %147, %148
  %150 = mul i64 %123, 10
  %151 = add i64 %150, %127
  %152 = getelementptr i64, ptr %114, i64 %151
  store i64 %149, ptr %152, align 4
  %153 = add i64 %131, 1
  br label %130

154:                                              ; preds = %130
  %155 = add i64 %127, 1
  br label %126

156:                                              ; preds = %126
  %157 = add i64 %123, 1
  br label %122

158:                                              ; preds = %122
  %159 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 2000) to i64), i64 64))
  %160 = ptrtoint ptr %159 to i64
  %161 = add i64 %160, 63
  %162 = urem i64 %161, 64
  %163 = sub i64 %161, %162
  %164 = inttoptr i64 %163 to ptr
  %165 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %159, 0
  %166 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %165, ptr %164, 1
  %167 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %166, i64 0, 2
  %168 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %167, i64 200, 3, 0
  %169 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %168, i64 10, 3, 1
  %170 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, i64 10, 4, 0
  %171 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %170, i64 1, 4, 1
  br label %172

172:                                              ; preds = %206, %158
  %173 = phi i64 [ %207, %206 ], [ 0, %158 ]
  %174 = icmp slt i64 %173, 200
  br i1 %174, label %175, label %208

175:                                              ; preds = %172
  br label %176

176:                                              ; preds = %204, %175
  %177 = phi i64 [ %205, %204 ], [ 0, %175 ]
  %178 = icmp slt i64 %177, 10
  br i1 %178, label %179, label %206

179:                                              ; preds = %176
  br label %180

180:                                              ; preds = %183, %179
  %181 = phi i64 [ %203, %183 ], [ 0, %179 ]
  %182 = icmp slt i64 %181, 175
  br i1 %182, label %183, label %204

183:                                              ; preds = %180
  %184 = getelementptr i64, ptr %1, i64 %2
  %185 = mul i64 %173, %5
  %186 = mul i64 %181, %6
  %187 = add i64 %185, %186
  %188 = getelementptr i64, ptr %184, i64 %187
  %189 = load i64, ptr %188, align 4
  %190 = mul i64 %181, 10
  %191 = add i64 %190, %177
  %192 = getelementptr i64, ptr %114, i64 %191
  %193 = load i64, ptr %192, align 4
  %194 = mul i64 %173, 10
  %195 = add i64 %194, %177
  %196 = getelementptr i64, ptr %164, i64 %195
  %197 = load i64, ptr %196, align 4
  %198 = mul i64 %189, %193
  %199 = add i64 %197, %198
  %200 = mul i64 %173, 10
  %201 = add i64 %200, %177
  %202 = getelementptr i64, ptr %164, i64 %201
  store i64 %199, ptr %202, align 4
  %203 = add i64 %181, 1
  br label %180

204:                                              ; preds = %180
  %205 = add i64 %177, 1
  br label %176

206:                                              ; preds = %176
  %207 = add i64 %173, 1
  br label %172

208:                                              ; preds = %172
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %171
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
