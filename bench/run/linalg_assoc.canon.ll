; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

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

define void @displayTime(i64 %0, i64 %1) {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+04
  %6 = call i32 (ptr, ...) @printf(ptr @time, i64 %3, double %5)
  ret void
}

define i32 @main() {
  %1 = call i64 @clock()
  %2 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1000) to i64), i64 64))
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = urem i64 %4, 64
  %6 = sub i64 %4, %5
  %7 = inttoptr i64 %6 to ptr
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %2, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %7, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 0, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 100, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 10, 3, 1
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 10, 4, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 1, 4, 1
  %15 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1500) to i64), i64 64))
  %16 = ptrtoint ptr %15 to i64
  %17 = add i64 %16, 63
  %18 = urem i64 %17, 64
  %19 = sub i64 %17, %18
  %20 = inttoptr i64 %19 to ptr
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %15, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, ptr %20, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 0, 2
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 10, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 150, 3, 1
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 150, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 1, 4, 1
  %28 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1200) to i64), i64 64))
  %29 = ptrtoint ptr %28 to i64
  %30 = add i64 %29, 63
  %31 = urem i64 %30, 64
  %32 = sub i64 %30, %31
  %33 = inttoptr i64 %32 to ptr
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %28, 0
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, ptr %33, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 0, 2
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 150, 3, 0
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 8, 3, 1
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 8, 4, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 1, 4, 1
  %41 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 15000) to i64), i64 64))
  %42 = ptrtoint ptr %41 to i64
  %43 = add i64 %42, 63
  %44 = urem i64 %43, 64
  %45 = sub i64 %43, %44
  %46 = inttoptr i64 %45 to ptr
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %41, 0
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, ptr %46, 1
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 0, 2
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 100, 3, 0
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 150, 3, 1
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 150, 4, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 1, 4, 1
  br label %54

54:                                               ; preds = %86, %0
  %55 = phi i64 [ %87, %86 ], [ 0, %0 ]
  %56 = icmp slt i64 %55, 100
  br i1 %56, label %57, label %88

57:                                               ; preds = %54
  br label %58

58:                                               ; preds = %84, %57
  %59 = phi i64 [ %85, %84 ], [ 0, %57 ]
  %60 = icmp slt i64 %59, 150
  br i1 %60, label %61, label %86

61:                                               ; preds = %58
  br label %62

62:                                               ; preds = %65, %61
  %63 = phi i64 [ %83, %65 ], [ 0, %61 ]
  %64 = icmp slt i64 %63, 10
  br i1 %64, label %65, label %84

65:                                               ; preds = %62
  %66 = mul i64 %55, 10
  %67 = add i64 %66, %63
  %68 = getelementptr i64, ptr %7, i64 %67
  %69 = load i64, ptr %68, align 4
  %70 = mul i64 %63, 150
  %71 = add i64 %70, %59
  %72 = getelementptr i64, ptr %20, i64 %71
  %73 = load i64, ptr %72, align 4
  %74 = mul i64 %55, 150
  %75 = add i64 %74, %59
  %76 = getelementptr i64, ptr %46, i64 %75
  %77 = load i64, ptr %76, align 4
  %78 = mul i64 %69, %73
  %79 = add i64 %77, %78
  %80 = mul i64 %55, 150
  %81 = add i64 %80, %59
  %82 = getelementptr i64, ptr %46, i64 %81
  store i64 %79, ptr %82, align 4
  %83 = add i64 %63, 1
  br label %62

84:                                               ; preds = %62
  %85 = add i64 %59, 1
  br label %58

86:                                               ; preds = %58
  %87 = add i64 %55, 1
  br label %54

88:                                               ; preds = %54
  %89 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 800) to i64), i64 64))
  %90 = ptrtoint ptr %89 to i64
  %91 = add i64 %90, 63
  %92 = urem i64 %91, 64
  %93 = sub i64 %91, %92
  %94 = inttoptr i64 %93 to ptr
  %95 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %89, 0
  %96 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %95, ptr %94, 1
  %97 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %96, i64 0, 2
  %98 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %97, i64 100, 3, 0
  %99 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %98, i64 8, 3, 1
  %100 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %99, i64 8, 4, 0
  %101 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %100, i64 1, 4, 1
  br label %102

102:                                              ; preds = %134, %88
  %103 = phi i64 [ %135, %134 ], [ 0, %88 ]
  %104 = icmp slt i64 %103, 100
  br i1 %104, label %105, label %136

105:                                              ; preds = %102
  br label %106

106:                                              ; preds = %132, %105
  %107 = phi i64 [ %133, %132 ], [ 0, %105 ]
  %108 = icmp slt i64 %107, 8
  br i1 %108, label %109, label %134

109:                                              ; preds = %106
  br label %110

110:                                              ; preds = %113, %109
  %111 = phi i64 [ %131, %113 ], [ 0, %109 ]
  %112 = icmp slt i64 %111, 150
  br i1 %112, label %113, label %132

113:                                              ; preds = %110
  %114 = mul i64 %103, 150
  %115 = add i64 %114, %111
  %116 = getelementptr i64, ptr %46, i64 %115
  %117 = load i64, ptr %116, align 4
  %118 = mul i64 %111, 8
  %119 = add i64 %118, %107
  %120 = getelementptr i64, ptr %33, i64 %119
  %121 = load i64, ptr %120, align 4
  %122 = mul i64 %103, 8
  %123 = add i64 %122, %107
  %124 = getelementptr i64, ptr %94, i64 %123
  %125 = load i64, ptr %124, align 4
  %126 = mul i64 %117, %121
  %127 = add i64 %125, %126
  %128 = mul i64 %103, 8
  %129 = add i64 %128, %107
  %130 = getelementptr i64, ptr %94, i64 %129
  store i64 %127, ptr %130, align 4
  %131 = add i64 %111, 1
  br label %110

132:                                              ; preds = %110
  %133 = add i64 %107, 1
  br label %106

134:                                              ; preds = %106
  %135 = add i64 %103, 1
  br label %102

136:                                              ; preds = %102
  %137 = call i64 @clock()
  call void @displayTime(i64 %1, i64 %137)
  %138 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 0
  %139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 1
  %140 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 2
  %141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 3, 0
  %142 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 3, 1
  %143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 4, 0
  %144 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %101, 4, 1
  %145 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %138, ptr %139, i64 %140, i64 %141, i64 %142, i64 %143, i64 %144)
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
