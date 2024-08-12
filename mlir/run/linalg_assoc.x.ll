; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

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
  %57 = fmul double %56, 0x3E23FFFFFABBF5C5
  %58 = fadd double %57, 0.000000e+00
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
  br label %86

86:                                               ; preds = %105, %85
  %87 = phi i64 [ %106, %105 ], [ 0, %85 ]
  %88 = icmp slt i64 %87, %22
  br i1 %88, label %89, label %107

89:                                               ; preds = %86
  br label %90

90:                                               ; preds = %93, %89
  %91 = phi i64 [ %104, %93 ], [ 0, %89 ]
  %92 = icmp slt i64 %91, %18
  br i1 %92, label %93, label %105

93:                                               ; preds = %90
  %94 = mul i64 %87, %18
  %95 = add i64 %94, %91
  %96 = getelementptr double, ptr %32, i64 %95
  %97 = load double, ptr %96, align 8
  %98 = fptosi double %97 to i64
  %99 = getelementptr i64, ptr %1, i64 %2
  %100 = mul i64 %87, %5
  %101 = mul i64 %91, %6
  %102 = add i64 %100, %101
  %103 = getelementptr i64, ptr %99, i64 %102
  store i64 %98, ptr %103, align 4
  %104 = add i64 %91, 1
  br label %90

105:                                              ; preds = %90
  %106 = add i64 %87, 1
  br label %86

107:                                              ; preds = %86
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
}

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @xy_z(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
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
  %43 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 150000000) to i64), i64 64))
  %44 = ptrtoint ptr %43 to i64
  %45 = add i64 %44, 63
  %46 = urem i64 %45, 64
  %47 = sub i64 %45, %46
  %48 = inttoptr i64 %47 to ptr
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %43, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, ptr %48, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 0, 2
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 10000, 3, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 15000, 3, 1
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 15000, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 1, 4, 1
  br label %56

56:                                               ; preds = %92, %21
  %57 = phi i64 [ %93, %92 ], [ 0, %21 ]
  %58 = icmp slt i64 %57, 10000
  br i1 %58, label %59, label %94

59:                                               ; preds = %56
  br label %60

60:                                               ; preds = %90, %59
  %61 = phi i64 [ %91, %90 ], [ 0, %59 ]
  %62 = icmp slt i64 %61, 15000
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
  %80 = mul i64 %57, 15000
  %81 = add i64 %80, %61
  %82 = getelementptr i64, ptr %48, i64 %81
  %83 = load i64, ptr %82, align 4
  %84 = mul i64 %73, %79
  %85 = add i64 %83, %84
  %86 = mul i64 %57, 15000
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
  %95 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 80000) to i64), i64 64))
  %96 = ptrtoint ptr %95 to i64
  %97 = add i64 %96, 63
  %98 = urem i64 %97, 64
  %99 = sub i64 %97, %98
  %100 = inttoptr i64 %99 to ptr
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %95, 0
  %102 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, ptr %100, 1
  %103 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %102, i64 0, 2
  %104 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, i64 10000, 3, 0
  %105 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %104, i64 8, 3, 1
  %106 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %105, i64 8, 4, 0
  %107 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %106, i64 1, 4, 1
  br label %108

108:                                              ; preds = %142, %94
  %109 = phi i64 [ %143, %142 ], [ 0, %94 ]
  %110 = icmp slt i64 %109, 10000
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
  %118 = icmp slt i64 %117, 15000
  br i1 %118, label %119, label %140

119:                                              ; preds = %116
  %120 = mul i64 %109, 15000
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

define { ptr, ptr, i64, [2 x i64], [2 x i64] } @x_yz(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
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
  %43 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 80) to i64), i64 64))
  %44 = ptrtoint ptr %43 to i64
  %45 = add i64 %44, 63
  %46 = urem i64 %45, 64
  %47 = sub i64 %45, %46
  %48 = inttoptr i64 %47 to ptr
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %43, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, ptr %48, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 0, 2
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 10, 3, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 8, 3, 1
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 8, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 1, 4, 1
  br label %56

56:                                               ; preds = %92, %21
  %57 = phi i64 [ %93, %92 ], [ 0, %21 ]
  %58 = icmp slt i64 %57, 10
  br i1 %58, label %59, label %94

59:                                               ; preds = %56
  br label %60

60:                                               ; preds = %90, %59
  %61 = phi i64 [ %91, %90 ], [ 0, %59 ]
  %62 = icmp slt i64 %61, 8
  br i1 %62, label %63, label %92

63:                                               ; preds = %60
  br label %64

64:                                               ; preds = %67, %63
  %65 = phi i64 [ %89, %67 ], [ 0, %63 ]
  %66 = icmp slt i64 %65, 15000
  br i1 %66, label %67, label %90

67:                                               ; preds = %64
  %68 = getelementptr i64, ptr %8, i64 %9
  %69 = mul i64 %57, %12
  %70 = mul i64 %65, %13
  %71 = add i64 %69, %70
  %72 = getelementptr i64, ptr %68, i64 %71
  %73 = load i64, ptr %72, align 4
  %74 = getelementptr i64, ptr %15, i64 %16
  %75 = mul i64 %65, %19
  %76 = mul i64 %61, %20
  %77 = add i64 %75, %76
  %78 = getelementptr i64, ptr %74, i64 %77
  %79 = load i64, ptr %78, align 4
  %80 = mul i64 %57, 8
  %81 = add i64 %80, %61
  %82 = getelementptr i64, ptr %48, i64 %81
  %83 = load i64, ptr %82, align 4
  %84 = mul i64 %73, %79
  %85 = add i64 %83, %84
  %86 = mul i64 %57, 8
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
  %95 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 80000) to i64), i64 64))
  %96 = ptrtoint ptr %95 to i64
  %97 = add i64 %96, 63
  %98 = urem i64 %97, 64
  %99 = sub i64 %97, %98
  %100 = inttoptr i64 %99 to ptr
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %95, 0
  %102 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, ptr %100, 1
  %103 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %102, i64 0, 2
  %104 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, i64 10000, 3, 0
  %105 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %104, i64 8, 3, 1
  %106 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %105, i64 8, 4, 0
  %107 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %106, i64 1, 4, 1
  br label %108

108:                                              ; preds = %142, %94
  %109 = phi i64 [ %143, %142 ], [ 0, %94 ]
  %110 = icmp slt i64 %109, 10000
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
  %118 = icmp slt i64 %117, 10
  br i1 %118, label %119, label %140

119:                                              ; preds = %116
  %120 = getelementptr i64, ptr %1, i64 %2
  %121 = mul i64 %109, %5
  %122 = mul i64 %117, %6
  %123 = add i64 %121, %122
  %124 = getelementptr i64, ptr %120, i64 %123
  %125 = load i64, ptr %124, align 4
  %126 = mul i64 %117, 8
  %127 = add i64 %126, %113
  %128 = getelementptr i64, ptr %48, i64 %127
  %129 = load i64, ptr %128, align 4
  %130 = mul i64 %109, 8
  %131 = add i64 %130, %113
  %132 = getelementptr i64, ptr %100, i64 %131
  %133 = load i64, ptr %132, align 4
  %134 = mul i64 %125, %129
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

define float @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 100000) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 10000, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 10, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 10, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1, 4, 1
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 0
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 1
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 2
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 0
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 3, 1
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 0
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, 4, 1
  %21 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20)
  %22 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 150000) to i64), i64 64))
  %23 = ptrtoint ptr %22 to i64
  %24 = add i64 %23, 63
  %25 = urem i64 %24, 64
  %26 = sub i64 %24, %25
  %27 = inttoptr i64 %26 to ptr
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %22, 0
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, ptr %27, 1
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, i64 0, 2
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 10, 3, 0
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 15000, 3, 1
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 15000, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 1, 4, 1
  %35 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 0
  %36 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 1
  %37 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 2
  %38 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 3, 0
  %39 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 3, 1
  %40 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 4, 0
  %41 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, 4, 1
  %42 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %35, ptr %36, i64 %37, i64 %38, i64 %39, i64 %40, i64 %41)
  %43 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 120000) to i64), i64 64))
  %44 = ptrtoint ptr %43 to i64
  %45 = add i64 %44, 63
  %46 = urem i64 %45, 64
  %47 = sub i64 %45, %46
  %48 = inttoptr i64 %47 to ptr
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %43, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, ptr %48, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 0, 2
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 15000, 3, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 8, 3, 1
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 8, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 1, 4, 1
  %56 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 0
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 1
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 2
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 0
  %60 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 3, 1
  %61 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 0
  %62 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %55, 4, 1
  %63 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr %56, ptr %57, i64 %58, i64 %59, i64 %60, i64 %61, i64 %62)
  %64 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 0
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 1
  %66 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 2
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3, 0
  %68 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 3, 1
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 0
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, 4, 1
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 0
  %72 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 1
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 2
  %74 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3, 0
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3, 1
  %76 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 0
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 1
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 0
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 1
  %80 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 2
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 3, 0
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 3, 1
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 0
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, 4, 1
  %85 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @xy_z(ptr %64, ptr %65, i64 %66, i64 %67, i64 %68, i64 %69, i64 %70, ptr %71, ptr %72, i64 %73, i64 %74, i64 %75, i64 %76, i64 %77, ptr %78, ptr %79, i64 %80, i64 %81, i64 %82, i64 %83, i64 %84)
  ret float 0.000000e+00
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
