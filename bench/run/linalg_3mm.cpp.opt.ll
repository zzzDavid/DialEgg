; ModuleID = 'bench/run/linalg_3mm.cpp.ll'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare i64 @clock() local_unnamed_addr

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
define void @displayTime(i64 %0, i64 %1) local_unnamed_addr #1 {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 9.000000e+03
  %6 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %3, double %5)
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #2 {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call i64 @clock()
  %2 = tail call dereferenceable_or_null(280064) ptr @malloc(i64 280064)
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = and i64 %4, -64
  %6 = tail call dereferenceable_or_null(350064) ptr @malloc(i64 350064)
  %7 = ptrtoint ptr %6 to i64
  %8 = add i64 %7, 63
  %9 = and i64 %8, -64
  %10 = inttoptr i64 %9 to ptr
  %11 = tail call dereferenceable_or_null(300064) ptr @malloc(i64 300064)
  %12 = ptrtoint ptr %11 to i64
  %13 = add i64 %12, 63
  %14 = and i64 %13, -64
  %15 = inttoptr i64 %14 to ptr
  %16 = tail call dereferenceable_or_null(12064) ptr @malloc(i64 12064)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = and i64 %18, -64
  %20 = tail call dereferenceable_or_null(210064) ptr @malloc(i64 210064)
  %21 = ptrtoint ptr %20 to i64
  %22 = add i64 %21, 63
  %23 = and i64 %22, -64
  %24 = inttoptr i64 %23 to ptr
  br label %.preheader7

.preheader7:                                      ; preds = %0, %46
  %25 = phi i64 [ 0, %0 ], [ %47, %46 ]
  %26 = mul nuw nsw i64 %25, 250
  %27 = getelementptr i64, ptr %10, i64 %26
  %28 = mul nuw nsw i64 %25, 150
  %29 = getelementptr i64, ptr %24, i64 %28
  br label %.preheader6

.preheader6:                                      ; preds = %.preheader7, %43
  %30 = phi i64 [ 0, %.preheader7 ], [ %44, %43 ]
  %invariant.gep = getelementptr i64, ptr %15, i64 %30
  %31 = getelementptr i64, ptr %29, i64 %30
  %.promoted = load i64, ptr %31, align 8
  br label %32

32:                                               ; preds = %.preheader6, %32
  %33 = phi i64 [ 0, %.preheader6 ], [ %41, %32 ]
  %34 = phi i64 [ %.promoted, %.preheader6 ], [ %40, %32 ]
  %35 = getelementptr i64, ptr %27, i64 %33
  %36 = load i64, ptr %35, align 8
  %37 = mul nuw nsw i64 %33, 150
  %gep = getelementptr i64, ptr %invariant.gep, i64 %37
  %38 = load i64, ptr %gep, align 8
  %39 = mul i64 %38, %36
  %40 = add i64 %34, %39
  store i64 %40, ptr %31, align 8
  %41 = add nuw nsw i64 %33, 1
  %42 = icmp ult i64 %33, 249
  br i1 %42, label %32, label %43

43:                                               ; preds = %32
  %44 = add nuw nsw i64 %30, 1
  %45 = icmp ult i64 %30, 149
  br i1 %45, label %.preheader6, label %46

46:                                               ; preds = %43
  %47 = add nuw nsw i64 %25, 1
  %48 = icmp ult i64 %25, 174
  br i1 %48, label %.preheader7, label %49

49:                                               ; preds = %46
  %50 = inttoptr i64 %19 to ptr
  %51 = tail call dereferenceable_or_null(14064) ptr @malloc(i64 14064)
  %52 = ptrtoint ptr %51 to i64
  %53 = add i64 %52, 63
  %54 = and i64 %53, -64
  %55 = inttoptr i64 %54 to ptr
  %invariant.gep8.1 = getelementptr i64, ptr %50, i64 1
  %invariant.gep8.2 = getelementptr i64, ptr %50, i64 2
  %invariant.gep8.3 = getelementptr i64, ptr %50, i64 3
  %invariant.gep8.4 = getelementptr i64, ptr %50, i64 4
  %invariant.gep8.5 = getelementptr i64, ptr %50, i64 5
  %invariant.gep8.6 = getelementptr i64, ptr %50, i64 6
  %invariant.gep8.7 = getelementptr i64, ptr %50, i64 7
  %invariant.gep8.8 = getelementptr i64, ptr %50, i64 8
  %invariant.gep8.9 = getelementptr i64, ptr %50, i64 9
  br label %.preheader5

.preheader5:                                      ; preds = %49, %180
  %56 = phi i64 [ 0, %49 ], [ %181, %180 ]
  %57 = mul nuw nsw i64 %56, 150
  %58 = getelementptr i64, ptr %24, i64 %57
  %59 = mul nuw nsw i64 %56, 10
  %60 = getelementptr i64, ptr %55, i64 %59
  %.promoted10 = load i64, ptr %60, align 16
  br label %61

61:                                               ; preds = %.preheader5, %61
  %62 = phi i64 [ 0, %.preheader5 ], [ %70, %61 ]
  %63 = phi i64 [ %.promoted10, %.preheader5 ], [ %69, %61 ]
  %64 = getelementptr i64, ptr %58, i64 %62
  %65 = load i64, ptr %64, align 8
  %66 = mul nuw nsw i64 %62, 10
  %gep9 = getelementptr i64, ptr %50, i64 %66
  %67 = load i64, ptr %gep9, align 16
  %68 = mul i64 %67, %65
  %69 = add i64 %63, %68
  store i64 %69, ptr %60, align 16
  %70 = add nuw nsw i64 %62, 1
  %71 = icmp ult i64 %62, 149
  br i1 %71, label %61, label %.preheader4.1

.preheader4.1:                                    ; preds = %61
  %72 = getelementptr i64, ptr %60, i64 1
  %.promoted10.1 = load i64, ptr %72, align 8
  br label %73

73:                                               ; preds = %73, %.preheader4.1
  %74 = phi i64 [ 0, %.preheader4.1 ], [ %82, %73 ]
  %75 = phi i64 [ %.promoted10.1, %.preheader4.1 ], [ %81, %73 ]
  %76 = getelementptr i64, ptr %58, i64 %74
  %77 = load i64, ptr %76, align 8
  %78 = mul nuw nsw i64 %74, 10
  %gep9.1 = getelementptr i64, ptr %invariant.gep8.1, i64 %78
  %79 = load i64, ptr %gep9.1, align 8
  %80 = mul i64 %79, %77
  %81 = add i64 %75, %80
  store i64 %81, ptr %72, align 8
  %82 = add nuw nsw i64 %74, 1
  %83 = icmp ult i64 %74, 149
  br i1 %83, label %73, label %.preheader4.2

.preheader4.2:                                    ; preds = %73
  %84 = getelementptr i64, ptr %60, i64 2
  %.promoted10.2 = load i64, ptr %84, align 16
  br label %85

85:                                               ; preds = %85, %.preheader4.2
  %86 = phi i64 [ 0, %.preheader4.2 ], [ %94, %85 ]
  %87 = phi i64 [ %.promoted10.2, %.preheader4.2 ], [ %93, %85 ]
  %88 = getelementptr i64, ptr %58, i64 %86
  %89 = load i64, ptr %88, align 8
  %90 = mul nuw nsw i64 %86, 10
  %gep9.2 = getelementptr i64, ptr %invariant.gep8.2, i64 %90
  %91 = load i64, ptr %gep9.2, align 16
  %92 = mul i64 %91, %89
  %93 = add i64 %87, %92
  store i64 %93, ptr %84, align 16
  %94 = add nuw nsw i64 %86, 1
  %95 = icmp ult i64 %86, 149
  br i1 %95, label %85, label %.preheader4.3

.preheader4.3:                                    ; preds = %85
  %96 = getelementptr i64, ptr %60, i64 3
  %.promoted10.3 = load i64, ptr %96, align 8
  br label %97

97:                                               ; preds = %97, %.preheader4.3
  %98 = phi i64 [ 0, %.preheader4.3 ], [ %106, %97 ]
  %99 = phi i64 [ %.promoted10.3, %.preheader4.3 ], [ %105, %97 ]
  %100 = getelementptr i64, ptr %58, i64 %98
  %101 = load i64, ptr %100, align 8
  %102 = mul nuw nsw i64 %98, 10
  %gep9.3 = getelementptr i64, ptr %invariant.gep8.3, i64 %102
  %103 = load i64, ptr %gep9.3, align 8
  %104 = mul i64 %103, %101
  %105 = add i64 %99, %104
  store i64 %105, ptr %96, align 8
  %106 = add nuw nsw i64 %98, 1
  %107 = icmp ult i64 %98, 149
  br i1 %107, label %97, label %.preheader4.4

.preheader4.4:                                    ; preds = %97
  %108 = getelementptr i64, ptr %60, i64 4
  %.promoted10.4 = load i64, ptr %108, align 16
  br label %109

109:                                              ; preds = %109, %.preheader4.4
  %110 = phi i64 [ 0, %.preheader4.4 ], [ %118, %109 ]
  %111 = phi i64 [ %.promoted10.4, %.preheader4.4 ], [ %117, %109 ]
  %112 = getelementptr i64, ptr %58, i64 %110
  %113 = load i64, ptr %112, align 8
  %114 = mul nuw nsw i64 %110, 10
  %gep9.4 = getelementptr i64, ptr %invariant.gep8.4, i64 %114
  %115 = load i64, ptr %gep9.4, align 16
  %116 = mul i64 %115, %113
  %117 = add i64 %111, %116
  store i64 %117, ptr %108, align 16
  %118 = add nuw nsw i64 %110, 1
  %119 = icmp ult i64 %110, 149
  br i1 %119, label %109, label %.preheader4.5

.preheader4.5:                                    ; preds = %109
  %120 = getelementptr i64, ptr %60, i64 5
  %.promoted10.5 = load i64, ptr %120, align 8
  br label %121

121:                                              ; preds = %121, %.preheader4.5
  %122 = phi i64 [ 0, %.preheader4.5 ], [ %130, %121 ]
  %123 = phi i64 [ %.promoted10.5, %.preheader4.5 ], [ %129, %121 ]
  %124 = getelementptr i64, ptr %58, i64 %122
  %125 = load i64, ptr %124, align 8
  %126 = mul nuw nsw i64 %122, 10
  %gep9.5 = getelementptr i64, ptr %invariant.gep8.5, i64 %126
  %127 = load i64, ptr %gep9.5, align 8
  %128 = mul i64 %127, %125
  %129 = add i64 %123, %128
  store i64 %129, ptr %120, align 8
  %130 = add nuw nsw i64 %122, 1
  %131 = icmp ult i64 %122, 149
  br i1 %131, label %121, label %.preheader4.6

.preheader4.6:                                    ; preds = %121
  %132 = getelementptr i64, ptr %60, i64 6
  %.promoted10.6 = load i64, ptr %132, align 16
  br label %133

133:                                              ; preds = %133, %.preheader4.6
  %134 = phi i64 [ 0, %.preheader4.6 ], [ %142, %133 ]
  %135 = phi i64 [ %.promoted10.6, %.preheader4.6 ], [ %141, %133 ]
  %136 = getelementptr i64, ptr %58, i64 %134
  %137 = load i64, ptr %136, align 8
  %138 = mul nuw nsw i64 %134, 10
  %gep9.6 = getelementptr i64, ptr %invariant.gep8.6, i64 %138
  %139 = load i64, ptr %gep9.6, align 16
  %140 = mul i64 %139, %137
  %141 = add i64 %135, %140
  store i64 %141, ptr %132, align 16
  %142 = add nuw nsw i64 %134, 1
  %143 = icmp ult i64 %134, 149
  br i1 %143, label %133, label %.preheader4.7

.preheader4.7:                                    ; preds = %133
  %144 = getelementptr i64, ptr %60, i64 7
  %.promoted10.7 = load i64, ptr %144, align 8
  br label %145

145:                                              ; preds = %145, %.preheader4.7
  %146 = phi i64 [ 0, %.preheader4.7 ], [ %154, %145 ]
  %147 = phi i64 [ %.promoted10.7, %.preheader4.7 ], [ %153, %145 ]
  %148 = getelementptr i64, ptr %58, i64 %146
  %149 = load i64, ptr %148, align 8
  %150 = mul nuw nsw i64 %146, 10
  %gep9.7 = getelementptr i64, ptr %invariant.gep8.7, i64 %150
  %151 = load i64, ptr %gep9.7, align 8
  %152 = mul i64 %151, %149
  %153 = add i64 %147, %152
  store i64 %153, ptr %144, align 8
  %154 = add nuw nsw i64 %146, 1
  %155 = icmp ult i64 %146, 149
  br i1 %155, label %145, label %.preheader4.8

.preheader4.8:                                    ; preds = %145
  %156 = getelementptr i64, ptr %60, i64 8
  %.promoted10.8 = load i64, ptr %156, align 16
  br label %157

157:                                              ; preds = %157, %.preheader4.8
  %158 = phi i64 [ 0, %.preheader4.8 ], [ %166, %157 ]
  %159 = phi i64 [ %.promoted10.8, %.preheader4.8 ], [ %165, %157 ]
  %160 = getelementptr i64, ptr %58, i64 %158
  %161 = load i64, ptr %160, align 8
  %162 = mul nuw nsw i64 %158, 10
  %gep9.8 = getelementptr i64, ptr %invariant.gep8.8, i64 %162
  %163 = load i64, ptr %gep9.8, align 16
  %164 = mul i64 %163, %161
  %165 = add i64 %159, %164
  store i64 %165, ptr %156, align 16
  %166 = add nuw nsw i64 %158, 1
  %167 = icmp ult i64 %158, 149
  br i1 %167, label %157, label %.preheader4.9

.preheader4.9:                                    ; preds = %157
  %168 = getelementptr i64, ptr %60, i64 9
  %.promoted10.9 = load i64, ptr %168, align 8
  br label %169

169:                                              ; preds = %169, %.preheader4.9
  %170 = phi i64 [ 0, %.preheader4.9 ], [ %178, %169 ]
  %171 = phi i64 [ %.promoted10.9, %.preheader4.9 ], [ %177, %169 ]
  %172 = getelementptr i64, ptr %58, i64 %170
  %173 = load i64, ptr %172, align 8
  %174 = mul nuw nsw i64 %170, 10
  %gep9.9 = getelementptr i64, ptr %invariant.gep8.9, i64 %174
  %175 = load i64, ptr %gep9.9, align 8
  %176 = mul i64 %175, %173
  %177 = add i64 %171, %176
  store i64 %177, ptr %168, align 8
  %178 = add nuw nsw i64 %170, 1
  %179 = icmp ult i64 %170, 149
  br i1 %179, label %169, label %180

180:                                              ; preds = %169
  %181 = add nuw nsw i64 %56, 1
  %182 = icmp ult i64 %56, 174
  br i1 %182, label %.preheader5, label %183

183:                                              ; preds = %180
  %184 = inttoptr i64 %5 to ptr
  %185 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %186 = ptrtoint ptr %185 to i64
  %187 = add i64 %186, 63
  %188 = and i64 %187, -64
  %189 = inttoptr i64 %188 to ptr
  %invariant.gep11.1 = getelementptr i64, ptr %55, i64 1
  %invariant.gep11.2 = getelementptr i64, ptr %55, i64 2
  %invariant.gep11.3 = getelementptr i64, ptr %55, i64 3
  %invariant.gep11.4 = getelementptr i64, ptr %55, i64 4
  %invariant.gep11.5 = getelementptr i64, ptr %55, i64 5
  %invariant.gep11.6 = getelementptr i64, ptr %55, i64 6
  %invariant.gep11.7 = getelementptr i64, ptr %55, i64 7
  %invariant.gep11.8 = getelementptr i64, ptr %55, i64 8
  %invariant.gep11.9 = getelementptr i64, ptr %55, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %183, %314
  %190 = phi i64 [ 0, %183 ], [ %315, %314 ]
  %191 = mul nuw nsw i64 %190, 175
  %192 = getelementptr i64, ptr %184, i64 %191
  %193 = mul nuw nsw i64 %190, 10
  %194 = getelementptr i64, ptr %189, i64 %193
  %.promoted13 = load i64, ptr %194, align 16
  br label %195

195:                                              ; preds = %.preheader3, %195
  %196 = phi i64 [ 0, %.preheader3 ], [ %204, %195 ]
  %197 = phi i64 [ %.promoted13, %.preheader3 ], [ %203, %195 ]
  %198 = getelementptr i64, ptr %192, i64 %196
  %199 = load i64, ptr %198, align 8
  %200 = mul nuw nsw i64 %196, 10
  %gep12 = getelementptr i64, ptr %55, i64 %200
  %201 = load i64, ptr %gep12, align 16
  %202 = mul i64 %201, %199
  %203 = add i64 %197, %202
  store i64 %203, ptr %194, align 16
  %204 = add nuw nsw i64 %196, 1
  %205 = icmp ult i64 %196, 174
  br i1 %205, label %195, label %.preheader.1

.preheader.1:                                     ; preds = %195
  %206 = getelementptr i64, ptr %194, i64 1
  %.promoted13.1 = load i64, ptr %206, align 8
  br label %207

207:                                              ; preds = %207, %.preheader.1
  %208 = phi i64 [ 0, %.preheader.1 ], [ %216, %207 ]
  %209 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %215, %207 ]
  %210 = getelementptr i64, ptr %192, i64 %208
  %211 = load i64, ptr %210, align 8
  %212 = mul nuw nsw i64 %208, 10
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %212
  %213 = load i64, ptr %gep12.1, align 8
  %214 = mul i64 %213, %211
  %215 = add i64 %209, %214
  store i64 %215, ptr %206, align 8
  %216 = add nuw nsw i64 %208, 1
  %217 = icmp ult i64 %208, 174
  br i1 %217, label %207, label %.preheader.2

.preheader.2:                                     ; preds = %207
  %218 = getelementptr i64, ptr %194, i64 2
  %.promoted13.2 = load i64, ptr %218, align 16
  br label %219

219:                                              ; preds = %219, %.preheader.2
  %220 = phi i64 [ 0, %.preheader.2 ], [ %228, %219 ]
  %221 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %227, %219 ]
  %222 = getelementptr i64, ptr %192, i64 %220
  %223 = load i64, ptr %222, align 8
  %224 = mul nuw nsw i64 %220, 10
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %224
  %225 = load i64, ptr %gep12.2, align 16
  %226 = mul i64 %225, %223
  %227 = add i64 %221, %226
  store i64 %227, ptr %218, align 16
  %228 = add nuw nsw i64 %220, 1
  %229 = icmp ult i64 %220, 174
  br i1 %229, label %219, label %.preheader.3

.preheader.3:                                     ; preds = %219
  %230 = getelementptr i64, ptr %194, i64 3
  %.promoted13.3 = load i64, ptr %230, align 8
  br label %231

231:                                              ; preds = %231, %.preheader.3
  %232 = phi i64 [ 0, %.preheader.3 ], [ %240, %231 ]
  %233 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %239, %231 ]
  %234 = getelementptr i64, ptr %192, i64 %232
  %235 = load i64, ptr %234, align 8
  %236 = mul nuw nsw i64 %232, 10
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %236
  %237 = load i64, ptr %gep12.3, align 8
  %238 = mul i64 %237, %235
  %239 = add i64 %233, %238
  store i64 %239, ptr %230, align 8
  %240 = add nuw nsw i64 %232, 1
  %241 = icmp ult i64 %232, 174
  br i1 %241, label %231, label %.preheader.4

.preheader.4:                                     ; preds = %231
  %242 = getelementptr i64, ptr %194, i64 4
  %.promoted13.4 = load i64, ptr %242, align 16
  br label %243

243:                                              ; preds = %243, %.preheader.4
  %244 = phi i64 [ 0, %.preheader.4 ], [ %252, %243 ]
  %245 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %251, %243 ]
  %246 = getelementptr i64, ptr %192, i64 %244
  %247 = load i64, ptr %246, align 8
  %248 = mul nuw nsw i64 %244, 10
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %248
  %249 = load i64, ptr %gep12.4, align 16
  %250 = mul i64 %249, %247
  %251 = add i64 %245, %250
  store i64 %251, ptr %242, align 16
  %252 = add nuw nsw i64 %244, 1
  %253 = icmp ult i64 %244, 174
  br i1 %253, label %243, label %.preheader.5

.preheader.5:                                     ; preds = %243
  %254 = getelementptr i64, ptr %194, i64 5
  %.promoted13.5 = load i64, ptr %254, align 8
  br label %255

255:                                              ; preds = %255, %.preheader.5
  %256 = phi i64 [ 0, %.preheader.5 ], [ %264, %255 ]
  %257 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %263, %255 ]
  %258 = getelementptr i64, ptr %192, i64 %256
  %259 = load i64, ptr %258, align 8
  %260 = mul nuw nsw i64 %256, 10
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %260
  %261 = load i64, ptr %gep12.5, align 8
  %262 = mul i64 %261, %259
  %263 = add i64 %257, %262
  store i64 %263, ptr %254, align 8
  %264 = add nuw nsw i64 %256, 1
  %265 = icmp ult i64 %256, 174
  br i1 %265, label %255, label %.preheader.6

.preheader.6:                                     ; preds = %255
  %266 = getelementptr i64, ptr %194, i64 6
  %.promoted13.6 = load i64, ptr %266, align 16
  br label %267

267:                                              ; preds = %267, %.preheader.6
  %268 = phi i64 [ 0, %.preheader.6 ], [ %276, %267 ]
  %269 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %275, %267 ]
  %270 = getelementptr i64, ptr %192, i64 %268
  %271 = load i64, ptr %270, align 8
  %272 = mul nuw nsw i64 %268, 10
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %272
  %273 = load i64, ptr %gep12.6, align 16
  %274 = mul i64 %273, %271
  %275 = add i64 %269, %274
  store i64 %275, ptr %266, align 16
  %276 = add nuw nsw i64 %268, 1
  %277 = icmp ult i64 %268, 174
  br i1 %277, label %267, label %.preheader.7

.preheader.7:                                     ; preds = %267
  %278 = getelementptr i64, ptr %194, i64 7
  %.promoted13.7 = load i64, ptr %278, align 8
  br label %279

279:                                              ; preds = %279, %.preheader.7
  %280 = phi i64 [ 0, %.preheader.7 ], [ %288, %279 ]
  %281 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %287, %279 ]
  %282 = getelementptr i64, ptr %192, i64 %280
  %283 = load i64, ptr %282, align 8
  %284 = mul nuw nsw i64 %280, 10
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %284
  %285 = load i64, ptr %gep12.7, align 8
  %286 = mul i64 %285, %283
  %287 = add i64 %281, %286
  store i64 %287, ptr %278, align 8
  %288 = add nuw nsw i64 %280, 1
  %289 = icmp ult i64 %280, 174
  br i1 %289, label %279, label %.preheader.8

.preheader.8:                                     ; preds = %279
  %290 = getelementptr i64, ptr %194, i64 8
  %.promoted13.8 = load i64, ptr %290, align 16
  br label %291

291:                                              ; preds = %291, %.preheader.8
  %292 = phi i64 [ 0, %.preheader.8 ], [ %300, %291 ]
  %293 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %299, %291 ]
  %294 = getelementptr i64, ptr %192, i64 %292
  %295 = load i64, ptr %294, align 8
  %296 = mul nuw nsw i64 %292, 10
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %296
  %297 = load i64, ptr %gep12.8, align 16
  %298 = mul i64 %297, %295
  %299 = add i64 %293, %298
  store i64 %299, ptr %290, align 16
  %300 = add nuw nsw i64 %292, 1
  %301 = icmp ult i64 %292, 174
  br i1 %301, label %291, label %.preheader.9

.preheader.9:                                     ; preds = %291
  %302 = getelementptr i64, ptr %194, i64 9
  %.promoted13.9 = load i64, ptr %302, align 8
  br label %303

303:                                              ; preds = %303, %.preheader.9
  %304 = phi i64 [ 0, %.preheader.9 ], [ %312, %303 ]
  %305 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %311, %303 ]
  %306 = getelementptr i64, ptr %192, i64 %304
  %307 = load i64, ptr %306, align 8
  %308 = mul nuw nsw i64 %304, 10
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %308
  %309 = load i64, ptr %gep12.9, align 8
  %310 = mul i64 %309, %307
  %311 = add i64 %305, %310
  store i64 %311, ptr %302, align 8
  %312 = add nuw nsw i64 %304, 1
  %313 = icmp ult i64 %304, 174
  br i1 %313, label %303, label %314

314:                                              ; preds = %303
  %315 = add nuw nsw i64 %190, 1
  %316 = icmp ult i64 %190, 199
  br i1 %316, label %.preheader3, label %317

317:                                              ; preds = %314
  %318 = tail call i64 @clock()
  %319 = sub i64 %318, %1
  %320 = uitofp i64 %319 to double
  %321 = fdiv double %320, 9.000000e+03
  %322 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %319, double %321)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
