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
  %54 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 2000) to i64), i64 64))
  %55 = ptrtoint ptr %54 to i64
  %56 = add i64 %55, 63
  %57 = urem i64 %56, 64
  %58 = sub i64 %56, %57
  %59 = inttoptr i64 %58 to ptr
  %60 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %54, 0
  %61 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %60, ptr %59, 1
  %62 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %61, i64 0, 2
  %63 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %62, i64 200, 3, 0
  %64 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %63, i64 10, 3, 1
  %65 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %64, i64 10, 4, 0
  %66 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %65, i64 1, 4, 1
  %67 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 2500) to i64), i64 64))
  %68 = ptrtoint ptr %67 to i64
  %69 = add i64 %68, 63
  %70 = urem i64 %69, 64
  %71 = sub i64 %69, %70
  %72 = inttoptr i64 %71 to ptr
  %73 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %67, 0
  %74 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %73, ptr %72, 1
  %75 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %74, i64 0, 2
  %76 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %75, i64 250, 3, 0
  %77 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, i64 10, 3, 1
  %78 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, i64 10, 4, 0
  %79 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %78, i64 1, 4, 1
  br label %80

80:                                               ; preds = %112, %0
  %81 = phi i64 [ %113, %112 ], [ 0, %0 ]
  %82 = icmp slt i64 %81, 250
  br i1 %82, label %83, label %114

83:                                               ; preds = %80
  br label %84

84:                                               ; preds = %110, %83
  %85 = phi i64 [ %111, %110 ], [ 0, %83 ]
  %86 = icmp slt i64 %85, 10
  br i1 %86, label %87, label %112

87:                                               ; preds = %84
  br label %88

88:                                               ; preds = %91, %87
  %89 = phi i64 [ %109, %91 ], [ 0, %87 ]
  %90 = icmp slt i64 %89, 150
  br i1 %90, label %91, label %110

91:                                               ; preds = %88
  %92 = mul i64 %81, 150
  %93 = add i64 %92, %89
  %94 = getelementptr i64, ptr %33, i64 %93
  %95 = load i64, ptr %94, align 4
  %96 = mul i64 %89, 10
  %97 = add i64 %96, %85
  %98 = getelementptr i64, ptr %46, i64 %97
  %99 = load i64, ptr %98, align 4
  %100 = mul i64 %81, 10
  %101 = add i64 %100, %85
  %102 = getelementptr i64, ptr %72, i64 %101
  %103 = load i64, ptr %102, align 4
  %104 = mul i64 %95, %99
  %105 = add i64 %103, %104
  %106 = mul i64 %81, 10
  %107 = add i64 %106, %85
  %108 = getelementptr i64, ptr %72, i64 %107
  store i64 %105, ptr %108, align 4
  %109 = add i64 %89, 1
  br label %88

110:                                              ; preds = %88
  %111 = add i64 %85, 1
  br label %84

112:                                              ; preds = %84
  %113 = add i64 %81, 1
  br label %80

114:                                              ; preds = %80
  %115 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1750) to i64), i64 64))
  %116 = ptrtoint ptr %115 to i64
  %117 = add i64 %116, 63
  %118 = urem i64 %117, 64
  %119 = sub i64 %117, %118
  %120 = inttoptr i64 %119 to ptr
  %121 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %115, 0
  %122 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %121, ptr %120, 1
  %123 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %122, i64 0, 2
  %124 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %123, i64 175, 3, 0
  %125 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %124, i64 10, 3, 1
  %126 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %125, i64 10, 4, 0
  %127 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %126, i64 1, 4, 1
  br label %128

128:                                              ; preds = %160, %114
  %129 = phi i64 [ %161, %160 ], [ 0, %114 ]
  %130 = icmp slt i64 %129, 175
  br i1 %130, label %131, label %162

131:                                              ; preds = %128
  br label %132

132:                                              ; preds = %158, %131
  %133 = phi i64 [ %159, %158 ], [ 0, %131 ]
  %134 = icmp slt i64 %133, 10
  br i1 %134, label %135, label %160

135:                                              ; preds = %132
  br label %136

136:                                              ; preds = %139, %135
  %137 = phi i64 [ %157, %139 ], [ 0, %135 ]
  %138 = icmp slt i64 %137, 250
  br i1 %138, label %139, label %158

139:                                              ; preds = %136
  %140 = mul i64 %129, 250
  %141 = add i64 %140, %137
  %142 = getelementptr i64, ptr %20, i64 %141
  %143 = load i64, ptr %142, align 4
  %144 = mul i64 %137, 10
  %145 = add i64 %144, %133
  %146 = getelementptr i64, ptr %72, i64 %145
  %147 = load i64, ptr %146, align 4
  %148 = mul i64 %129, 10
  %149 = add i64 %148, %133
  %150 = getelementptr i64, ptr %120, i64 %149
  %151 = load i64, ptr %150, align 4
  %152 = mul i64 %143, %147
  %153 = add i64 %151, %152
  %154 = mul i64 %129, 10
  %155 = add i64 %154, %133
  %156 = getelementptr i64, ptr %120, i64 %155
  store i64 %153, ptr %156, align 4
  %157 = add i64 %137, 1
  br label %136

158:                                              ; preds = %136
  %159 = add i64 %133, 1
  br label %132

160:                                              ; preds = %132
  %161 = add i64 %129, 1
  br label %128

162:                                              ; preds = %128
  br label %163

163:                                              ; preds = %195, %162
  %164 = phi i64 [ %196, %195 ], [ 0, %162 ]
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
  %181 = getelementptr i64, ptr %120, i64 %180
  %182 = load i64, ptr %181, align 4
  %183 = mul i64 %164, 10
  %184 = add i64 %183, %168
  %185 = getelementptr i64, ptr %59, i64 %184
  %186 = load i64, ptr %185, align 4
  %187 = mul i64 %178, %182
  %188 = add i64 %186, %187
  %189 = mul i64 %164, 10
  %190 = add i64 %189, %168
  %191 = getelementptr i64, ptr %59, i64 %190
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
  %199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 0
  %200 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 1
  %201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 2
  %202 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 3, 0
  %203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 3, 1
  %204 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 4, 0
  %205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %66, 4, 1
  %206 = call { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %199, ptr %200, i64 %201, i64 %202, i64 %203, i64 %204, i64 %205)
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
