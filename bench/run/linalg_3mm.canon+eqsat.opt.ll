; ModuleID = 'bench/run/linalg_3mm.canon+eqsat.ll'
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
  %10 = tail call dereferenceable_or_null(300064) ptr @malloc(i64 300064)
  %11 = ptrtoint ptr %10 to i64
  %12 = add i64 %11, 63
  %13 = and i64 %12, -64
  %14 = inttoptr i64 %13 to ptr
  %15 = tail call dereferenceable_or_null(12064) ptr @malloc(i64 12064)
  %16 = ptrtoint ptr %15 to i64
  %17 = add i64 %16, 63
  %18 = and i64 %17, -64
  %19 = inttoptr i64 %18 to ptr
  %20 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %21 = ptrtoint ptr %20 to i64
  %22 = add i64 %21, 63
  %23 = and i64 %22, -64
  %24 = tail call dereferenceable_or_null(20064) ptr @malloc(i64 20064)
  %25 = ptrtoint ptr %24 to i64
  %26 = add i64 %25, 63
  %27 = and i64 %26, -64
  %28 = inttoptr i64 %27 to ptr
  %invariant.gep.1 = getelementptr i64, ptr %19, i64 1
  %invariant.gep.2 = getelementptr i64, ptr %19, i64 2
  %invariant.gep.3 = getelementptr i64, ptr %19, i64 3
  %invariant.gep.4 = getelementptr i64, ptr %19, i64 4
  %invariant.gep.5 = getelementptr i64, ptr %19, i64 5
  %invariant.gep.6 = getelementptr i64, ptr %19, i64 6
  %invariant.gep.7 = getelementptr i64, ptr %19, i64 7
  %invariant.gep.8 = getelementptr i64, ptr %19, i64 8
  %invariant.gep.9 = getelementptr i64, ptr %19, i64 9
  br label %.preheader8

.preheader8:                                      ; preds = %0, %153
  %29 = phi i64 [ 0, %0 ], [ %154, %153 ]
  %30 = mul nuw nsw i64 %29, 150
  %31 = getelementptr i64, ptr %14, i64 %30
  %32 = mul nuw nsw i64 %29, 10
  %33 = getelementptr i64, ptr %28, i64 %32
  %.promoted = load i64, ptr %33, align 16
  br label %34

34:                                               ; preds = %.preheader8, %34
  %35 = phi i64 [ 0, %.preheader8 ], [ %43, %34 ]
  %36 = phi i64 [ %.promoted, %.preheader8 ], [ %42, %34 ]
  %37 = getelementptr i64, ptr %31, i64 %35
  %38 = load i64, ptr %37, align 8
  %39 = mul nuw nsw i64 %35, 10
  %gep = getelementptr i64, ptr %19, i64 %39
  %40 = load i64, ptr %gep, align 16
  %41 = mul i64 %40, %38
  %42 = add i64 %36, %41
  store i64 %42, ptr %33, align 16
  %43 = add nuw nsw i64 %35, 1
  %44 = icmp ult i64 %35, 149
  br i1 %44, label %34, label %.preheader7.1

.preheader7.1:                                    ; preds = %34
  %45 = getelementptr i64, ptr %33, i64 1
  %.promoted.1 = load i64, ptr %45, align 8
  br label %46

46:                                               ; preds = %46, %.preheader7.1
  %47 = phi i64 [ 0, %.preheader7.1 ], [ %55, %46 ]
  %48 = phi i64 [ %.promoted.1, %.preheader7.1 ], [ %54, %46 ]
  %49 = getelementptr i64, ptr %31, i64 %47
  %50 = load i64, ptr %49, align 8
  %51 = mul nuw nsw i64 %47, 10
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %51
  %52 = load i64, ptr %gep.1, align 8
  %53 = mul i64 %52, %50
  %54 = add i64 %48, %53
  store i64 %54, ptr %45, align 8
  %55 = add nuw nsw i64 %47, 1
  %56 = icmp ult i64 %47, 149
  br i1 %56, label %46, label %.preheader7.2

.preheader7.2:                                    ; preds = %46
  %57 = getelementptr i64, ptr %33, i64 2
  %.promoted.2 = load i64, ptr %57, align 16
  br label %58

58:                                               ; preds = %58, %.preheader7.2
  %59 = phi i64 [ 0, %.preheader7.2 ], [ %67, %58 ]
  %60 = phi i64 [ %.promoted.2, %.preheader7.2 ], [ %66, %58 ]
  %61 = getelementptr i64, ptr %31, i64 %59
  %62 = load i64, ptr %61, align 8
  %63 = mul nuw nsw i64 %59, 10
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %63
  %64 = load i64, ptr %gep.2, align 16
  %65 = mul i64 %64, %62
  %66 = add i64 %60, %65
  store i64 %66, ptr %57, align 16
  %67 = add nuw nsw i64 %59, 1
  %68 = icmp ult i64 %59, 149
  br i1 %68, label %58, label %.preheader7.3

.preheader7.3:                                    ; preds = %58
  %69 = getelementptr i64, ptr %33, i64 3
  %.promoted.3 = load i64, ptr %69, align 8
  br label %70

70:                                               ; preds = %70, %.preheader7.3
  %71 = phi i64 [ 0, %.preheader7.3 ], [ %79, %70 ]
  %72 = phi i64 [ %.promoted.3, %.preheader7.3 ], [ %78, %70 ]
  %73 = getelementptr i64, ptr %31, i64 %71
  %74 = load i64, ptr %73, align 8
  %75 = mul nuw nsw i64 %71, 10
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %75
  %76 = load i64, ptr %gep.3, align 8
  %77 = mul i64 %76, %74
  %78 = add i64 %72, %77
  store i64 %78, ptr %69, align 8
  %79 = add nuw nsw i64 %71, 1
  %80 = icmp ult i64 %71, 149
  br i1 %80, label %70, label %.preheader7.4

.preheader7.4:                                    ; preds = %70
  %81 = getelementptr i64, ptr %33, i64 4
  %.promoted.4 = load i64, ptr %81, align 16
  br label %82

82:                                               ; preds = %82, %.preheader7.4
  %83 = phi i64 [ 0, %.preheader7.4 ], [ %91, %82 ]
  %84 = phi i64 [ %.promoted.4, %.preheader7.4 ], [ %90, %82 ]
  %85 = getelementptr i64, ptr %31, i64 %83
  %86 = load i64, ptr %85, align 8
  %87 = mul nuw nsw i64 %83, 10
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %87
  %88 = load i64, ptr %gep.4, align 16
  %89 = mul i64 %88, %86
  %90 = add i64 %84, %89
  store i64 %90, ptr %81, align 16
  %91 = add nuw nsw i64 %83, 1
  %92 = icmp ult i64 %83, 149
  br i1 %92, label %82, label %.preheader7.5

.preheader7.5:                                    ; preds = %82
  %93 = getelementptr i64, ptr %33, i64 5
  %.promoted.5 = load i64, ptr %93, align 8
  br label %94

94:                                               ; preds = %94, %.preheader7.5
  %95 = phi i64 [ 0, %.preheader7.5 ], [ %103, %94 ]
  %96 = phi i64 [ %.promoted.5, %.preheader7.5 ], [ %102, %94 ]
  %97 = getelementptr i64, ptr %31, i64 %95
  %98 = load i64, ptr %97, align 8
  %99 = mul nuw nsw i64 %95, 10
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %99
  %100 = load i64, ptr %gep.5, align 8
  %101 = mul i64 %100, %98
  %102 = add i64 %96, %101
  store i64 %102, ptr %93, align 8
  %103 = add nuw nsw i64 %95, 1
  %104 = icmp ult i64 %95, 149
  br i1 %104, label %94, label %.preheader7.6

.preheader7.6:                                    ; preds = %94
  %105 = getelementptr i64, ptr %33, i64 6
  %.promoted.6 = load i64, ptr %105, align 16
  br label %106

106:                                              ; preds = %106, %.preheader7.6
  %107 = phi i64 [ 0, %.preheader7.6 ], [ %115, %106 ]
  %108 = phi i64 [ %.promoted.6, %.preheader7.6 ], [ %114, %106 ]
  %109 = getelementptr i64, ptr %31, i64 %107
  %110 = load i64, ptr %109, align 8
  %111 = mul nuw nsw i64 %107, 10
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %111
  %112 = load i64, ptr %gep.6, align 16
  %113 = mul i64 %112, %110
  %114 = add i64 %108, %113
  store i64 %114, ptr %105, align 16
  %115 = add nuw nsw i64 %107, 1
  %116 = icmp ult i64 %107, 149
  br i1 %116, label %106, label %.preheader7.7

.preheader7.7:                                    ; preds = %106
  %117 = getelementptr i64, ptr %33, i64 7
  %.promoted.7 = load i64, ptr %117, align 8
  br label %118

118:                                              ; preds = %118, %.preheader7.7
  %119 = phi i64 [ 0, %.preheader7.7 ], [ %127, %118 ]
  %120 = phi i64 [ %.promoted.7, %.preheader7.7 ], [ %126, %118 ]
  %121 = getelementptr i64, ptr %31, i64 %119
  %122 = load i64, ptr %121, align 8
  %123 = mul nuw nsw i64 %119, 10
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %123
  %124 = load i64, ptr %gep.7, align 8
  %125 = mul i64 %124, %122
  %126 = add i64 %120, %125
  store i64 %126, ptr %117, align 8
  %127 = add nuw nsw i64 %119, 1
  %128 = icmp ult i64 %119, 149
  br i1 %128, label %118, label %.preheader7.8

.preheader7.8:                                    ; preds = %118
  %129 = getelementptr i64, ptr %33, i64 8
  %.promoted.8 = load i64, ptr %129, align 16
  br label %130

130:                                              ; preds = %130, %.preheader7.8
  %131 = phi i64 [ 0, %.preheader7.8 ], [ %139, %130 ]
  %132 = phi i64 [ %.promoted.8, %.preheader7.8 ], [ %138, %130 ]
  %133 = getelementptr i64, ptr %31, i64 %131
  %134 = load i64, ptr %133, align 8
  %135 = mul nuw nsw i64 %131, 10
  %gep.8 = getelementptr i64, ptr %invariant.gep.8, i64 %135
  %136 = load i64, ptr %gep.8, align 16
  %137 = mul i64 %136, %134
  %138 = add i64 %132, %137
  store i64 %138, ptr %129, align 16
  %139 = add nuw nsw i64 %131, 1
  %140 = icmp ult i64 %131, 149
  br i1 %140, label %130, label %.preheader7.9

.preheader7.9:                                    ; preds = %130
  %141 = getelementptr i64, ptr %33, i64 9
  %.promoted.9 = load i64, ptr %141, align 8
  br label %142

142:                                              ; preds = %142, %.preheader7.9
  %143 = phi i64 [ 0, %.preheader7.9 ], [ %151, %142 ]
  %144 = phi i64 [ %.promoted.9, %.preheader7.9 ], [ %150, %142 ]
  %145 = getelementptr i64, ptr %31, i64 %143
  %146 = load i64, ptr %145, align 8
  %147 = mul nuw nsw i64 %143, 10
  %gep.9 = getelementptr i64, ptr %invariant.gep.9, i64 %147
  %148 = load i64, ptr %gep.9, align 8
  %149 = mul i64 %148, %146
  %150 = add i64 %144, %149
  store i64 %150, ptr %141, align 8
  %151 = add nuw nsw i64 %143, 1
  %152 = icmp ult i64 %143, 149
  br i1 %152, label %142, label %153

153:                                              ; preds = %142
  %154 = add nuw nsw i64 %29, 1
  %155 = icmp ult i64 %29, 249
  br i1 %155, label %.preheader8, label %156

156:                                              ; preds = %153
  %157 = inttoptr i64 %9 to ptr
  %158 = tail call dereferenceable_or_null(14064) ptr @malloc(i64 14064)
  %159 = ptrtoint ptr %158 to i64
  %160 = add i64 %159, 63
  %161 = and i64 %160, -64
  %162 = inttoptr i64 %161 to ptr
  %invariant.gep9.1 = getelementptr i64, ptr %28, i64 1
  %invariant.gep9.2 = getelementptr i64, ptr %28, i64 2
  %invariant.gep9.3 = getelementptr i64, ptr %28, i64 3
  %invariant.gep9.4 = getelementptr i64, ptr %28, i64 4
  %invariant.gep9.5 = getelementptr i64, ptr %28, i64 5
  %invariant.gep9.6 = getelementptr i64, ptr %28, i64 6
  %invariant.gep9.7 = getelementptr i64, ptr %28, i64 7
  %invariant.gep9.8 = getelementptr i64, ptr %28, i64 8
  %invariant.gep9.9 = getelementptr i64, ptr %28, i64 9
  br label %.preheader6

.preheader6:                                      ; preds = %156, %287
  %163 = phi i64 [ 0, %156 ], [ %288, %287 ]
  %164 = mul nuw nsw i64 %163, 250
  %165 = getelementptr i64, ptr %157, i64 %164
  %166 = mul nuw nsw i64 %163, 10
  %167 = getelementptr i64, ptr %162, i64 %166
  %.promoted11 = load i64, ptr %167, align 16
  br label %168

168:                                              ; preds = %.preheader6, %168
  %169 = phi i64 [ 0, %.preheader6 ], [ %177, %168 ]
  %170 = phi i64 [ %.promoted11, %.preheader6 ], [ %176, %168 ]
  %171 = getelementptr i64, ptr %165, i64 %169
  %172 = load i64, ptr %171, align 8
  %173 = mul nuw nsw i64 %169, 10
  %gep10 = getelementptr i64, ptr %28, i64 %173
  %174 = load i64, ptr %gep10, align 16
  %175 = mul i64 %174, %172
  %176 = add i64 %170, %175
  store i64 %176, ptr %167, align 16
  %177 = add nuw nsw i64 %169, 1
  %178 = icmp ult i64 %169, 249
  br i1 %178, label %168, label %.preheader5.1

.preheader5.1:                                    ; preds = %168
  %179 = getelementptr i64, ptr %167, i64 1
  %.promoted11.1 = load i64, ptr %179, align 8
  br label %180

180:                                              ; preds = %180, %.preheader5.1
  %181 = phi i64 [ 0, %.preheader5.1 ], [ %189, %180 ]
  %182 = phi i64 [ %.promoted11.1, %.preheader5.1 ], [ %188, %180 ]
  %183 = getelementptr i64, ptr %165, i64 %181
  %184 = load i64, ptr %183, align 8
  %185 = mul nuw nsw i64 %181, 10
  %gep10.1 = getelementptr i64, ptr %invariant.gep9.1, i64 %185
  %186 = load i64, ptr %gep10.1, align 8
  %187 = mul i64 %186, %184
  %188 = add i64 %182, %187
  store i64 %188, ptr %179, align 8
  %189 = add nuw nsw i64 %181, 1
  %190 = icmp ult i64 %181, 249
  br i1 %190, label %180, label %.preheader5.2

.preheader5.2:                                    ; preds = %180
  %191 = getelementptr i64, ptr %167, i64 2
  %.promoted11.2 = load i64, ptr %191, align 16
  br label %192

192:                                              ; preds = %192, %.preheader5.2
  %193 = phi i64 [ 0, %.preheader5.2 ], [ %201, %192 ]
  %194 = phi i64 [ %.promoted11.2, %.preheader5.2 ], [ %200, %192 ]
  %195 = getelementptr i64, ptr %165, i64 %193
  %196 = load i64, ptr %195, align 8
  %197 = mul nuw nsw i64 %193, 10
  %gep10.2 = getelementptr i64, ptr %invariant.gep9.2, i64 %197
  %198 = load i64, ptr %gep10.2, align 16
  %199 = mul i64 %198, %196
  %200 = add i64 %194, %199
  store i64 %200, ptr %191, align 16
  %201 = add nuw nsw i64 %193, 1
  %202 = icmp ult i64 %193, 249
  br i1 %202, label %192, label %.preheader5.3

.preheader5.3:                                    ; preds = %192
  %203 = getelementptr i64, ptr %167, i64 3
  %.promoted11.3 = load i64, ptr %203, align 8
  br label %204

204:                                              ; preds = %204, %.preheader5.3
  %205 = phi i64 [ 0, %.preheader5.3 ], [ %213, %204 ]
  %206 = phi i64 [ %.promoted11.3, %.preheader5.3 ], [ %212, %204 ]
  %207 = getelementptr i64, ptr %165, i64 %205
  %208 = load i64, ptr %207, align 8
  %209 = mul nuw nsw i64 %205, 10
  %gep10.3 = getelementptr i64, ptr %invariant.gep9.3, i64 %209
  %210 = load i64, ptr %gep10.3, align 8
  %211 = mul i64 %210, %208
  %212 = add i64 %206, %211
  store i64 %212, ptr %203, align 8
  %213 = add nuw nsw i64 %205, 1
  %214 = icmp ult i64 %205, 249
  br i1 %214, label %204, label %.preheader5.4

.preheader5.4:                                    ; preds = %204
  %215 = getelementptr i64, ptr %167, i64 4
  %.promoted11.4 = load i64, ptr %215, align 16
  br label %216

216:                                              ; preds = %216, %.preheader5.4
  %217 = phi i64 [ 0, %.preheader5.4 ], [ %225, %216 ]
  %218 = phi i64 [ %.promoted11.4, %.preheader5.4 ], [ %224, %216 ]
  %219 = getelementptr i64, ptr %165, i64 %217
  %220 = load i64, ptr %219, align 8
  %221 = mul nuw nsw i64 %217, 10
  %gep10.4 = getelementptr i64, ptr %invariant.gep9.4, i64 %221
  %222 = load i64, ptr %gep10.4, align 16
  %223 = mul i64 %222, %220
  %224 = add i64 %218, %223
  store i64 %224, ptr %215, align 16
  %225 = add nuw nsw i64 %217, 1
  %226 = icmp ult i64 %217, 249
  br i1 %226, label %216, label %.preheader5.5

.preheader5.5:                                    ; preds = %216
  %227 = getelementptr i64, ptr %167, i64 5
  %.promoted11.5 = load i64, ptr %227, align 8
  br label %228

228:                                              ; preds = %228, %.preheader5.5
  %229 = phi i64 [ 0, %.preheader5.5 ], [ %237, %228 ]
  %230 = phi i64 [ %.promoted11.5, %.preheader5.5 ], [ %236, %228 ]
  %231 = getelementptr i64, ptr %165, i64 %229
  %232 = load i64, ptr %231, align 8
  %233 = mul nuw nsw i64 %229, 10
  %gep10.5 = getelementptr i64, ptr %invariant.gep9.5, i64 %233
  %234 = load i64, ptr %gep10.5, align 8
  %235 = mul i64 %234, %232
  %236 = add i64 %230, %235
  store i64 %236, ptr %227, align 8
  %237 = add nuw nsw i64 %229, 1
  %238 = icmp ult i64 %229, 249
  br i1 %238, label %228, label %.preheader5.6

.preheader5.6:                                    ; preds = %228
  %239 = getelementptr i64, ptr %167, i64 6
  %.promoted11.6 = load i64, ptr %239, align 16
  br label %240

240:                                              ; preds = %240, %.preheader5.6
  %241 = phi i64 [ 0, %.preheader5.6 ], [ %249, %240 ]
  %242 = phi i64 [ %.promoted11.6, %.preheader5.6 ], [ %248, %240 ]
  %243 = getelementptr i64, ptr %165, i64 %241
  %244 = load i64, ptr %243, align 8
  %245 = mul nuw nsw i64 %241, 10
  %gep10.6 = getelementptr i64, ptr %invariant.gep9.6, i64 %245
  %246 = load i64, ptr %gep10.6, align 16
  %247 = mul i64 %246, %244
  %248 = add i64 %242, %247
  store i64 %248, ptr %239, align 16
  %249 = add nuw nsw i64 %241, 1
  %250 = icmp ult i64 %241, 249
  br i1 %250, label %240, label %.preheader5.7

.preheader5.7:                                    ; preds = %240
  %251 = getelementptr i64, ptr %167, i64 7
  %.promoted11.7 = load i64, ptr %251, align 8
  br label %252

252:                                              ; preds = %252, %.preheader5.7
  %253 = phi i64 [ 0, %.preheader5.7 ], [ %261, %252 ]
  %254 = phi i64 [ %.promoted11.7, %.preheader5.7 ], [ %260, %252 ]
  %255 = getelementptr i64, ptr %165, i64 %253
  %256 = load i64, ptr %255, align 8
  %257 = mul nuw nsw i64 %253, 10
  %gep10.7 = getelementptr i64, ptr %invariant.gep9.7, i64 %257
  %258 = load i64, ptr %gep10.7, align 8
  %259 = mul i64 %258, %256
  %260 = add i64 %254, %259
  store i64 %260, ptr %251, align 8
  %261 = add nuw nsw i64 %253, 1
  %262 = icmp ult i64 %253, 249
  br i1 %262, label %252, label %.preheader5.8

.preheader5.8:                                    ; preds = %252
  %263 = getelementptr i64, ptr %167, i64 8
  %.promoted11.8 = load i64, ptr %263, align 16
  br label %264

264:                                              ; preds = %264, %.preheader5.8
  %265 = phi i64 [ 0, %.preheader5.8 ], [ %273, %264 ]
  %266 = phi i64 [ %.promoted11.8, %.preheader5.8 ], [ %272, %264 ]
  %267 = getelementptr i64, ptr %165, i64 %265
  %268 = load i64, ptr %267, align 8
  %269 = mul nuw nsw i64 %265, 10
  %gep10.8 = getelementptr i64, ptr %invariant.gep9.8, i64 %269
  %270 = load i64, ptr %gep10.8, align 16
  %271 = mul i64 %270, %268
  %272 = add i64 %266, %271
  store i64 %272, ptr %263, align 16
  %273 = add nuw nsw i64 %265, 1
  %274 = icmp ult i64 %265, 249
  br i1 %274, label %264, label %.preheader5.9

.preheader5.9:                                    ; preds = %264
  %275 = getelementptr i64, ptr %167, i64 9
  %.promoted11.9 = load i64, ptr %275, align 8
  br label %276

276:                                              ; preds = %276, %.preheader5.9
  %277 = phi i64 [ 0, %.preheader5.9 ], [ %285, %276 ]
  %278 = phi i64 [ %.promoted11.9, %.preheader5.9 ], [ %284, %276 ]
  %279 = getelementptr i64, ptr %165, i64 %277
  %280 = load i64, ptr %279, align 8
  %281 = mul nuw nsw i64 %277, 10
  %gep10.9 = getelementptr i64, ptr %invariant.gep9.9, i64 %281
  %282 = load i64, ptr %gep10.9, align 8
  %283 = mul i64 %282, %280
  %284 = add i64 %278, %283
  store i64 %284, ptr %275, align 8
  %285 = add nuw nsw i64 %277, 1
  %286 = icmp ult i64 %277, 249
  br i1 %286, label %276, label %287

287:                                              ; preds = %276
  %288 = add nuw nsw i64 %163, 1
  %289 = icmp ult i64 %163, 174
  br i1 %289, label %.preheader6, label %.preheader3.preheader

.preheader3.preheader:                            ; preds = %287
  %290 = inttoptr i64 %5 to ptr
  %291 = inttoptr i64 %23 to ptr
  %invariant.gep12.1 = getelementptr i64, ptr %162, i64 1
  %invariant.gep12.2 = getelementptr i64, ptr %162, i64 2
  %invariant.gep12.3 = getelementptr i64, ptr %162, i64 3
  %invariant.gep12.4 = getelementptr i64, ptr %162, i64 4
  %invariant.gep12.5 = getelementptr i64, ptr %162, i64 5
  %invariant.gep12.6 = getelementptr i64, ptr %162, i64 6
  %invariant.gep12.7 = getelementptr i64, ptr %162, i64 7
  %invariant.gep12.8 = getelementptr i64, ptr %162, i64 8
  %invariant.gep12.9 = getelementptr i64, ptr %162, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %.preheader3.preheader, %416
  %292 = phi i64 [ %417, %416 ], [ 0, %.preheader3.preheader ]
  %293 = mul nuw nsw i64 %292, 175
  %294 = getelementptr i64, ptr %290, i64 %293
  %295 = mul nuw nsw i64 %292, 10
  %296 = getelementptr i64, ptr %291, i64 %295
  %.promoted14 = load i64, ptr %296, align 16
  br label %297

297:                                              ; preds = %.preheader3, %297
  %298 = phi i64 [ 0, %.preheader3 ], [ %306, %297 ]
  %299 = phi i64 [ %.promoted14, %.preheader3 ], [ %305, %297 ]
  %300 = getelementptr i64, ptr %294, i64 %298
  %301 = load i64, ptr %300, align 8
  %302 = mul nuw nsw i64 %298, 10
  %gep13 = getelementptr i64, ptr %162, i64 %302
  %303 = load i64, ptr %gep13, align 16
  %304 = mul i64 %303, %301
  %305 = add i64 %299, %304
  store i64 %305, ptr %296, align 16
  %306 = add nuw nsw i64 %298, 1
  %307 = icmp ult i64 %298, 174
  br i1 %307, label %297, label %.preheader.1

.preheader.1:                                     ; preds = %297
  %308 = getelementptr i64, ptr %296, i64 1
  %.promoted14.1 = load i64, ptr %308, align 8
  br label %309

309:                                              ; preds = %309, %.preheader.1
  %310 = phi i64 [ 0, %.preheader.1 ], [ %318, %309 ]
  %311 = phi i64 [ %.promoted14.1, %.preheader.1 ], [ %317, %309 ]
  %312 = getelementptr i64, ptr %294, i64 %310
  %313 = load i64, ptr %312, align 8
  %314 = mul nuw nsw i64 %310, 10
  %gep13.1 = getelementptr i64, ptr %invariant.gep12.1, i64 %314
  %315 = load i64, ptr %gep13.1, align 8
  %316 = mul i64 %315, %313
  %317 = add i64 %311, %316
  store i64 %317, ptr %308, align 8
  %318 = add nuw nsw i64 %310, 1
  %319 = icmp ult i64 %310, 174
  br i1 %319, label %309, label %.preheader.2

.preheader.2:                                     ; preds = %309
  %320 = getelementptr i64, ptr %296, i64 2
  %.promoted14.2 = load i64, ptr %320, align 16
  br label %321

321:                                              ; preds = %321, %.preheader.2
  %322 = phi i64 [ 0, %.preheader.2 ], [ %330, %321 ]
  %323 = phi i64 [ %.promoted14.2, %.preheader.2 ], [ %329, %321 ]
  %324 = getelementptr i64, ptr %294, i64 %322
  %325 = load i64, ptr %324, align 8
  %326 = mul nuw nsw i64 %322, 10
  %gep13.2 = getelementptr i64, ptr %invariant.gep12.2, i64 %326
  %327 = load i64, ptr %gep13.2, align 16
  %328 = mul i64 %327, %325
  %329 = add i64 %323, %328
  store i64 %329, ptr %320, align 16
  %330 = add nuw nsw i64 %322, 1
  %331 = icmp ult i64 %322, 174
  br i1 %331, label %321, label %.preheader.3

.preheader.3:                                     ; preds = %321
  %332 = getelementptr i64, ptr %296, i64 3
  %.promoted14.3 = load i64, ptr %332, align 8
  br label %333

333:                                              ; preds = %333, %.preheader.3
  %334 = phi i64 [ 0, %.preheader.3 ], [ %342, %333 ]
  %335 = phi i64 [ %.promoted14.3, %.preheader.3 ], [ %341, %333 ]
  %336 = getelementptr i64, ptr %294, i64 %334
  %337 = load i64, ptr %336, align 8
  %338 = mul nuw nsw i64 %334, 10
  %gep13.3 = getelementptr i64, ptr %invariant.gep12.3, i64 %338
  %339 = load i64, ptr %gep13.3, align 8
  %340 = mul i64 %339, %337
  %341 = add i64 %335, %340
  store i64 %341, ptr %332, align 8
  %342 = add nuw nsw i64 %334, 1
  %343 = icmp ult i64 %334, 174
  br i1 %343, label %333, label %.preheader.4

.preheader.4:                                     ; preds = %333
  %344 = getelementptr i64, ptr %296, i64 4
  %.promoted14.4 = load i64, ptr %344, align 16
  br label %345

345:                                              ; preds = %345, %.preheader.4
  %346 = phi i64 [ 0, %.preheader.4 ], [ %354, %345 ]
  %347 = phi i64 [ %.promoted14.4, %.preheader.4 ], [ %353, %345 ]
  %348 = getelementptr i64, ptr %294, i64 %346
  %349 = load i64, ptr %348, align 8
  %350 = mul nuw nsw i64 %346, 10
  %gep13.4 = getelementptr i64, ptr %invariant.gep12.4, i64 %350
  %351 = load i64, ptr %gep13.4, align 16
  %352 = mul i64 %351, %349
  %353 = add i64 %347, %352
  store i64 %353, ptr %344, align 16
  %354 = add nuw nsw i64 %346, 1
  %355 = icmp ult i64 %346, 174
  br i1 %355, label %345, label %.preheader.5

.preheader.5:                                     ; preds = %345
  %356 = getelementptr i64, ptr %296, i64 5
  %.promoted14.5 = load i64, ptr %356, align 8
  br label %357

357:                                              ; preds = %357, %.preheader.5
  %358 = phi i64 [ 0, %.preheader.5 ], [ %366, %357 ]
  %359 = phi i64 [ %.promoted14.5, %.preheader.5 ], [ %365, %357 ]
  %360 = getelementptr i64, ptr %294, i64 %358
  %361 = load i64, ptr %360, align 8
  %362 = mul nuw nsw i64 %358, 10
  %gep13.5 = getelementptr i64, ptr %invariant.gep12.5, i64 %362
  %363 = load i64, ptr %gep13.5, align 8
  %364 = mul i64 %363, %361
  %365 = add i64 %359, %364
  store i64 %365, ptr %356, align 8
  %366 = add nuw nsw i64 %358, 1
  %367 = icmp ult i64 %358, 174
  br i1 %367, label %357, label %.preheader.6

.preheader.6:                                     ; preds = %357
  %368 = getelementptr i64, ptr %296, i64 6
  %.promoted14.6 = load i64, ptr %368, align 16
  br label %369

369:                                              ; preds = %369, %.preheader.6
  %370 = phi i64 [ 0, %.preheader.6 ], [ %378, %369 ]
  %371 = phi i64 [ %.promoted14.6, %.preheader.6 ], [ %377, %369 ]
  %372 = getelementptr i64, ptr %294, i64 %370
  %373 = load i64, ptr %372, align 8
  %374 = mul nuw nsw i64 %370, 10
  %gep13.6 = getelementptr i64, ptr %invariant.gep12.6, i64 %374
  %375 = load i64, ptr %gep13.6, align 16
  %376 = mul i64 %375, %373
  %377 = add i64 %371, %376
  store i64 %377, ptr %368, align 16
  %378 = add nuw nsw i64 %370, 1
  %379 = icmp ult i64 %370, 174
  br i1 %379, label %369, label %.preheader.7

.preheader.7:                                     ; preds = %369
  %380 = getelementptr i64, ptr %296, i64 7
  %.promoted14.7 = load i64, ptr %380, align 8
  br label %381

381:                                              ; preds = %381, %.preheader.7
  %382 = phi i64 [ 0, %.preheader.7 ], [ %390, %381 ]
  %383 = phi i64 [ %.promoted14.7, %.preheader.7 ], [ %389, %381 ]
  %384 = getelementptr i64, ptr %294, i64 %382
  %385 = load i64, ptr %384, align 8
  %386 = mul nuw nsw i64 %382, 10
  %gep13.7 = getelementptr i64, ptr %invariant.gep12.7, i64 %386
  %387 = load i64, ptr %gep13.7, align 8
  %388 = mul i64 %387, %385
  %389 = add i64 %383, %388
  store i64 %389, ptr %380, align 8
  %390 = add nuw nsw i64 %382, 1
  %391 = icmp ult i64 %382, 174
  br i1 %391, label %381, label %.preheader.8

.preheader.8:                                     ; preds = %381
  %392 = getelementptr i64, ptr %296, i64 8
  %.promoted14.8 = load i64, ptr %392, align 16
  br label %393

393:                                              ; preds = %393, %.preheader.8
  %394 = phi i64 [ 0, %.preheader.8 ], [ %402, %393 ]
  %395 = phi i64 [ %.promoted14.8, %.preheader.8 ], [ %401, %393 ]
  %396 = getelementptr i64, ptr %294, i64 %394
  %397 = load i64, ptr %396, align 8
  %398 = mul nuw nsw i64 %394, 10
  %gep13.8 = getelementptr i64, ptr %invariant.gep12.8, i64 %398
  %399 = load i64, ptr %gep13.8, align 16
  %400 = mul i64 %399, %397
  %401 = add i64 %395, %400
  store i64 %401, ptr %392, align 16
  %402 = add nuw nsw i64 %394, 1
  %403 = icmp ult i64 %394, 174
  br i1 %403, label %393, label %.preheader.9

.preheader.9:                                     ; preds = %393
  %404 = getelementptr i64, ptr %296, i64 9
  %.promoted14.9 = load i64, ptr %404, align 8
  br label %405

405:                                              ; preds = %405, %.preheader.9
  %406 = phi i64 [ 0, %.preheader.9 ], [ %414, %405 ]
  %407 = phi i64 [ %.promoted14.9, %.preheader.9 ], [ %413, %405 ]
  %408 = getelementptr i64, ptr %294, i64 %406
  %409 = load i64, ptr %408, align 8
  %410 = mul nuw nsw i64 %406, 10
  %gep13.9 = getelementptr i64, ptr %invariant.gep12.9, i64 %410
  %411 = load i64, ptr %gep13.9, align 8
  %412 = mul i64 %411, %409
  %413 = add i64 %407, %412
  store i64 %413, ptr %404, align 8
  %414 = add nuw nsw i64 %406, 1
  %415 = icmp ult i64 %406, 174
  br i1 %415, label %405, label %416

416:                                              ; preds = %405
  %417 = add nuw nsw i64 %292, 1
  %418 = icmp ult i64 %292, 199
  br i1 %418, label %.preheader3, label %419

419:                                              ; preds = %416
  %420 = tail call i64 @clock()
  %421 = sub i64 %420, %1
  %422 = uitofp i64 %421 to double
  %423 = fdiv double %422, 9.000000e+03
  %424 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %421, double %423)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
