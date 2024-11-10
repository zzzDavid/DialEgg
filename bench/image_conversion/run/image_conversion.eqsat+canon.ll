; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare void @displayTime(i64, i64)

declare void @printI64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64)

define { ptr, ptr, i64, [3 x i64], [3 x i64] } @blackhole4k(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, i64 %8) {
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %0, 0
  %11 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %10, ptr %1, 1
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %11, i64 %2, 2
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, i64 %3, 3, 0
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 %6, 4, 0
  %15 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %14, i64 %4, 3, 1
  %16 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, i64 %7, 4, 1
  %17 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %16, i64 %5, 3, 2
  %18 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %17, i64 %8, 4, 2
  ret { ptr, ptr, i64, [3 x i64], [3 x i64] } %18
}

define i64 @main() {
  %1 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 24883200) to i64), i64 64))
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = urem i64 %3, 64
  %5 = sub i64 %3, %4
  %6 = inttoptr i64 %5 to ptr
  %7 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %1, 0
  %8 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %7, ptr %6, 1
  %9 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %8, i64 0, 2
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %9, i64 3840, 3, 0
  %11 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %10, i64 2160, 3, 1
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %11, i64 3, 3, 2
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, i64 6480, 4, 0
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 3, 4, 1
  %15 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %14, i64 1, 4, 2
  br label %16

16:                                               ; preds = %36, %0
  %17 = phi i64 [ %37, %36 ], [ 0, %0 ]
  %18 = icmp slt i64 %17, 3840
  br i1 %18, label %19, label %38

19:                                               ; preds = %16
  br label %20

20:                                               ; preds = %34, %19
  %21 = phi i64 [ %35, %34 ], [ 0, %19 ]
  %22 = icmp slt i64 %21, 2160
  br i1 %22, label %23, label %36

23:                                               ; preds = %20
  br label %24

24:                                               ; preds = %27, %23
  %25 = phi i64 [ %33, %27 ], [ 0, %23 ]
  %26 = icmp slt i64 %25, 3
  br i1 %26, label %27, label %34

27:                                               ; preds = %24
  %28 = mul i64 %17, 6480
  %29 = mul i64 %21, 3
  %30 = add i64 %28, %29
  %31 = add i64 %30, %25
  %32 = getelementptr i64, ptr %6, i64 %31
  store i64 100, ptr %32, align 4
  %33 = add i64 %25, 1
  br label %24

34:                                               ; preds = %24
  %35 = add i64 %21, 1
  br label %20

36:                                               ; preds = %20
  %37 = add i64 %17, 1
  br label %16

38:                                               ; preds = %16
  %39 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 0
  %40 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 1
  %41 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 2
  %42 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 3, 0
  %43 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 3, 1
  %44 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 3, 2
  %45 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 4, 0
  %46 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 4, 1
  %47 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, 4, 2
  %48 = call { ptr, ptr, i64, [3 x i64], [3 x i64] } @blackhole4k(ptr %39, ptr %40, i64 %41, i64 %42, i64 %43, i64 %44, i64 %45, i64 %46, i64 %47)
  %49 = call i64 @clock()
  %50 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 8294400) to i64), i64 64))
  %51 = ptrtoint ptr %50 to i64
  %52 = add i64 %51, 63
  %53 = urem i64 %52, 64
  %54 = sub i64 %52, %53
  %55 = inttoptr i64 %54 to ptr
  %56 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %50, 0
  %57 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %56, ptr %55, 1
  %58 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %57, i64 0, 2
  %59 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %58, i64 3840, 3, 0
  %60 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %59, i64 2160, 3, 1
  %61 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, i64 2160, 4, 0
  %62 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %61, i64 1, 4, 1
  br label %63

63:                                               ; preds = %118, %38
  %64 = phi i64 [ %119, %118 ], [ 0, %38 ]
  %65 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %70, %118 ], [ %62, %38 ]
  %66 = icmp slt i64 %64, 3840
  br i1 %66, label %67, label %120

67:                                               ; preds = %63
  br label %68

68:                                               ; preds = %72, %67
  %69 = phi i64 [ %117, %72 ], [ 0, %67 ]
  %70 = phi { ptr, ptr, i64, [2 x i64], [2 x i64] } [ %70, %72 ], [ %65, %67 ]
  %71 = icmp slt i64 %69, 2160
  br i1 %71, label %72, label %118

72:                                               ; preds = %68
  %73 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 1
  %74 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 2
  %75 = getelementptr i64, ptr %73, i64 %74
  %76 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 0
  %77 = mul i64 %64, %76
  %78 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 1
  %79 = mul i64 %69, %78
  %80 = add i64 %77, %79
  %81 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 2
  %82 = mul i64 %81, 0
  %83 = add i64 %80, %82
  %84 = getelementptr i64, ptr %75, i64 %83
  %85 = load i64, ptr %84, align 4
  %86 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 1
  %87 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 2
  %88 = getelementptr i64, ptr %86, i64 %87
  %89 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 0
  %90 = mul i64 %64, %89
  %91 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 1
  %92 = mul i64 %69, %91
  %93 = add i64 %90, %92
  %94 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 2
  %95 = mul i64 %94, 1
  %96 = add i64 %93, %95
  %97 = getelementptr i64, ptr %88, i64 %96
  %98 = load i64, ptr %97, align 4
  %99 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 1
  %100 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 2
  %101 = getelementptr i64, ptr %99, i64 %100
  %102 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 0
  %103 = mul i64 %64, %102
  %104 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 1
  %105 = mul i64 %69, %104
  %106 = add i64 %103, %105
  %107 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %48, 4, 2
  %108 = mul i64 %107, 2
  %109 = add i64 %106, %108
  %110 = getelementptr i64, ptr %101, i64 %109
  %111 = load i64, ptr %110, align 4
  %112 = call i64 @rgb_to_grayscale(i64 %85, i64 %98, i64 %111)
  %113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %70, 1
  %114 = mul i64 %64, 2160
  %115 = add i64 %114, %69
  %116 = getelementptr i64, ptr %113, i64 %115
  store i64 %112, ptr %116, align 4
  %117 = add i64 %69, 1
  br label %68

118:                                              ; preds = %68
  %119 = add i64 %64, 1
  br label %63

120:                                              ; preds = %63
  %121 = call i64 @clock()
  %122 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 0
  %123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 1
  %124 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 2
  %125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 3, 0
  %126 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 3, 1
  %127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 4, 0
  %128 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, 4, 1
  call void @printI64Tensor2D(ptr %122, ptr %123, i64 %124, i64 %125, i64 %126, i64 %127, i64 %128)
  call void @printNewline()
  call void @displayTime(i64 %49, i64 %121)
  ret i64 0
}

define i64 @rgb_to_grayscale(i64 %0, i64 %1, i64 %2) {
  %4 = mul i64 %0, 77
  %5 = mul i64 %1, 150
  %6 = mul i64 %2, 29
  %7 = ashr i64 %4, 8
  %8 = ashr i64 %5, 8
  %9 = ashr i64 %6, 8
  %10 = add i64 %7, %8
  %11 = add i64 %10, %9
  ret i64 %11
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
