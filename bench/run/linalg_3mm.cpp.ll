; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

declare ptr @malloc(i64)

declare void @printNewline()

declare i64 @clock()

declare i32 @putchar(i32)

declare i32 @printf(ptr, ...)

define void @displayTime(i64 %0, i64 %1) {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 9.000000e+03
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

define i32 @main() {
  %1 = call i64 @clock()
  %2 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 35000) to i64), i64 64))
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = urem i64 %4, 64
  %6 = sub i64 %4, %5
  %7 = inttoptr i64 %6 to ptr
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %2, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %7, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 0, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 200, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 175, 3, 1
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 175, 4, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 1, 4, 1
  %15 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 43750) to i64), i64 64))
  %16 = ptrtoint ptr %15 to i64
  %17 = add i64 %16, 63
  %18 = urem i64 %17, 64
  %19 = sub i64 %17, %18
  %20 = inttoptr i64 %19 to ptr
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %15, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, ptr %20, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 0, 2
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 175, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 250, 3, 1
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 250, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 1, 4, 1
  %28 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 37500) to i64), i64 64))
  %29 = ptrtoint ptr %28 to i64
  %30 = add i64 %29, 63
  %31 = urem i64 %30, 64
  %32 = sub i64 %30, %31
  %33 = inttoptr i64 %32 to ptr
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %28, 0
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, ptr %33, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 0, 2
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 250, 3, 0
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 150, 3, 1
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 150, 4, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 1, 4, 1
  %41 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1500) to i64), i64 64))
  %42 = ptrtoint ptr %41 to i64
  %43 = add i64 %42, 63
  %44 = urem i64 %43, 64
  %45 = sub i64 %43, %44
  %46 = inttoptr i64 %45 to ptr
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %41, 0
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, ptr %46, 1
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 0, 2
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 150, 3, 0
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 10, 3, 1
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 10, 4, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 1, 4, 1
  %54 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 26250) to i64), i64 64))
  %55 = ptrtoint ptr %54 to i64
  %56 = add i64 %55, 63
  %57 = urem i64 %56, 64
  %58 = sub i64 %56, %57
  %59 = inttoptr i64 %58 to ptr
  %60 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %54, 0
  %61 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, ptr %59, 1
  %62 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %61, i64 0, 2
  %63 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %62, i64 175, 3, 0
  %64 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, i64 150, 3, 1
  %65 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %64, i64 150, 4, 0
  %66 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, i64 1, 4, 1
  br label %67

67:                                               ; preds = %99, %0
  %68 = phi i64 [ %100, %99 ], [ 0, %0 ]
  %69 = icmp slt i64 %68, 175
  br i1 %69, label %70, label %101

70:                                               ; preds = %67
  br label %71

71:                                               ; preds = %97, %70
  %72 = phi i64 [ %98, %97 ], [ 0, %70 ]
  %73 = icmp slt i64 %72, 150
  br i1 %73, label %74, label %99

74:                                               ; preds = %71
  br label %75

75:                                               ; preds = %78, %74
  %76 = phi i64 [ %96, %78 ], [ 0, %74 ]
  %77 = icmp slt i64 %76, 250
  br i1 %77, label %78, label %97

78:                                               ; preds = %75
  %79 = mul i64 %68, 250
  %80 = add i64 %79, %76
  %81 = getelementptr i64, ptr %20, i64 %80
  %82 = load i64, ptr %81, align 4
  %83 = mul i64 %76, 150
  %84 = add i64 %83, %72
  %85 = getelementptr i64, ptr %33, i64 %84
  %86 = load i64, ptr %85, align 4
  %87 = mul i64 %68, 150
  %88 = add i64 %87, %72
  %89 = getelementptr i64, ptr %59, i64 %88
  %90 = load i64, ptr %89, align 4
  %91 = mul i64 %82, %86
  %92 = add i64 %90, %91
  %93 = mul i64 %68, 150
  %94 = add i64 %93, %72
  %95 = getelementptr i64, ptr %59, i64 %94
  store i64 %92, ptr %95, align 4
  %96 = add i64 %76, 1
  br label %75

97:                                               ; preds = %75
  %98 = add i64 %72, 1
  br label %71

99:                                               ; preds = %71
  %100 = add i64 %68, 1
  br label %67

101:                                              ; preds = %67
  %102 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1750) to i64), i64 64))
  %103 = ptrtoint ptr %102 to i64
  %104 = add i64 %103, 63
  %105 = urem i64 %104, 64
  %106 = sub i64 %104, %105
  %107 = inttoptr i64 %106 to ptr
  %108 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %102, 0
  %109 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %108, ptr %107, 1
  %110 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %109, i64 0, 2
  %111 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %110, i64 175, 3, 0
  %112 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %111, i64 10, 3, 1
  %113 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %112, i64 10, 4, 0
  %114 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %113, i64 1, 4, 1
  br label %115

115:                                              ; preds = %147, %101
  %116 = phi i64 [ %148, %147 ], [ 0, %101 ]
  %117 = icmp slt i64 %116, 175
  br i1 %117, label %118, label %149

118:                                              ; preds = %115
  br label %119

119:                                              ; preds = %145, %118
  %120 = phi i64 [ %146, %145 ], [ 0, %118 ]
  %121 = icmp slt i64 %120, 10
  br i1 %121, label %122, label %147

122:                                              ; preds = %119
  br label %123

123:                                              ; preds = %126, %122
  %124 = phi i64 [ %144, %126 ], [ 0, %122 ]
  %125 = icmp slt i64 %124, 150
  br i1 %125, label %126, label %145

126:                                              ; preds = %123
  %127 = mul i64 %116, 150
  %128 = add i64 %127, %124
  %129 = getelementptr i64, ptr %59, i64 %128
  %130 = load i64, ptr %129, align 4
  %131 = mul i64 %124, 10
  %132 = add i64 %131, %120
  %133 = getelementptr i64, ptr %46, i64 %132
  %134 = load i64, ptr %133, align 4
  %135 = mul i64 %116, 10
  %136 = add i64 %135, %120
  %137 = getelementptr i64, ptr %107, i64 %136
  %138 = load i64, ptr %137, align 4
  %139 = mul i64 %130, %134
  %140 = add i64 %138, %139
  %141 = mul i64 %116, 10
  %142 = add i64 %141, %120
  %143 = getelementptr i64, ptr %107, i64 %142
  store i64 %140, ptr %143, align 4
  %144 = add i64 %124, 1
  br label %123

145:                                              ; preds = %123
  %146 = add i64 %120, 1
  br label %119

147:                                              ; preds = %119
  %148 = add i64 %116, 1
  br label %115

149:                                              ; preds = %115
  %150 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 2000) to i64), i64 64))
  %151 = ptrtoint ptr %150 to i64
  %152 = add i64 %151, 63
  %153 = urem i64 %152, 64
  %154 = sub i64 %152, %153
  %155 = inttoptr i64 %154 to ptr
  %156 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %150, 0
  %157 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %156, ptr %155, 1
  %158 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %157, i64 0, 2
  %159 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %158, i64 200, 3, 0
  %160 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %159, i64 10, 3, 1
  %161 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %160, i64 10, 4, 0
  %162 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %161, i64 1, 4, 1
  br label %163

163:                                              ; preds = %195, %149
  %164 = phi i64 [ %196, %195 ], [ 0, %149 ]
  %165 = icmp slt i64 %164, 200
  br i1 %165, label %166, label %197

166:                                              ; preds = %163
  br label %167

167:                                              ; preds = %193, %166
  %168 = phi i64 [ %194, %193 ], [ 0, %166 ]
  %169 = icmp slt i64 %168, 10
  br i1 %169, label %170, label %195

170:                                              ; preds = %167
  br label %171

171:                                              ; preds = %174, %170
  %172 = phi i64 [ %192, %174 ], [ 0, %170 ]
  %173 = icmp slt i64 %172, 175
  br i1 %173, label %174, label %193

174:                                              ; preds = %171
  %175 = mul i64 %164, 175
  %176 = add i64 %175, %172
  %177 = getelementptr i64, ptr %7, i64 %176
  %178 = load i64, ptr %177, align 4
  %179 = mul i64 %172, 10
  %180 = add i64 %179, %168
  %181 = getelementptr i64, ptr %107, i64 %180
  %182 = load i64, ptr %181, align 4
  %183 = mul i64 %164, 10
  %184 = add i64 %183, %168
  %185 = getelementptr i64, ptr %155, i64 %184
  %186 = load i64, ptr %185, align 4
  %187 = mul i64 %178, %182
  %188 = add i64 %186, %187
  %189 = mul i64 %164, 10
  %190 = add i64 %189, %168
  %191 = getelementptr i64, ptr %155, i64 %190
  store i64 %188, ptr %191, align 4
  %192 = add i64 %172, 1
  br label %171

193:                                              ; preds = %171
  %194 = add i64 %168, 1
  br label %167

195:                                              ; preds = %167
  %196 = add i64 %164, 1
  br label %163

197:                                              ; preds = %163
  %198 = call i64 @clock()
  call void @displayTime(i64 %1, i64 %198)
  %199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 0
  %200 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 1
  %201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 2
  %202 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 3, 0
  %203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 3, 1
  %204 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 4, 0
  %205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %162, 4, 1
  %206 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %199, ptr %200, i64 %201, i64 %202, i64 %203, i64 %204, i64 %205)
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
