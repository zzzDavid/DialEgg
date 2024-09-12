; ModuleID = 'bench/run/linalg_3mm.eqsat+canon.ll'
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
  %20 = tail call dereferenceable_or_null(20064) ptr @malloc(i64 20064)
  %21 = ptrtoint ptr %20 to i64
  %22 = add i64 %21, 63
  %23 = and i64 %22, -64
  %24 = inttoptr i64 %23 to ptr
  %invariant.gep.1 = getelementptr i64, ptr %19, i64 1
  %invariant.gep.2 = getelementptr i64, ptr %19, i64 2
  %invariant.gep.3 = getelementptr i64, ptr %19, i64 3
  %invariant.gep.4 = getelementptr i64, ptr %19, i64 4
  %invariant.gep.5 = getelementptr i64, ptr %19, i64 5
  %invariant.gep.6 = getelementptr i64, ptr %19, i64 6
  %invariant.gep.7 = getelementptr i64, ptr %19, i64 7
  %invariant.gep.8 = getelementptr i64, ptr %19, i64 8
  %invariant.gep.9 = getelementptr i64, ptr %19, i64 9
  br label %.preheader7

.preheader7:                                      ; preds = %0, %149
  %25 = phi i64 [ 0, %0 ], [ %150, %149 ]
  %26 = mul nuw nsw i64 %25, 150
  %27 = getelementptr i64, ptr %14, i64 %26
  %28 = mul nuw nsw i64 %25, 10
  %29 = getelementptr i64, ptr %24, i64 %28
  %.promoted = load i64, ptr %29, align 16
  br label %30

30:                                               ; preds = %.preheader7, %30
  %31 = phi i64 [ 0, %.preheader7 ], [ %39, %30 ]
  %32 = phi i64 [ %.promoted, %.preheader7 ], [ %38, %30 ]
  %33 = getelementptr i64, ptr %27, i64 %31
  %34 = load i64, ptr %33, align 8
  %35 = mul nuw nsw i64 %31, 10
  %gep = getelementptr i64, ptr %19, i64 %35
  %36 = load i64, ptr %gep, align 16
  %37 = mul i64 %36, %34
  %38 = add i64 %32, %37
  store i64 %38, ptr %29, align 16
  %39 = add nuw nsw i64 %31, 1
  %40 = icmp ult i64 %31, 149
  br i1 %40, label %30, label %.preheader6.1

.preheader6.1:                                    ; preds = %30
  %41 = getelementptr i64, ptr %29, i64 1
  %.promoted.1 = load i64, ptr %41, align 8
  br label %42

42:                                               ; preds = %42, %.preheader6.1
  %43 = phi i64 [ 0, %.preheader6.1 ], [ %51, %42 ]
  %44 = phi i64 [ %.promoted.1, %.preheader6.1 ], [ %50, %42 ]
  %45 = getelementptr i64, ptr %27, i64 %43
  %46 = load i64, ptr %45, align 8
  %47 = mul nuw nsw i64 %43, 10
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %47
  %48 = load i64, ptr %gep.1, align 8
  %49 = mul i64 %48, %46
  %50 = add i64 %44, %49
  store i64 %50, ptr %41, align 8
  %51 = add nuw nsw i64 %43, 1
  %52 = icmp ult i64 %43, 149
  br i1 %52, label %42, label %.preheader6.2

.preheader6.2:                                    ; preds = %42
  %53 = getelementptr i64, ptr %29, i64 2
  %.promoted.2 = load i64, ptr %53, align 16
  br label %54

54:                                               ; preds = %54, %.preheader6.2
  %55 = phi i64 [ 0, %.preheader6.2 ], [ %63, %54 ]
  %56 = phi i64 [ %.promoted.2, %.preheader6.2 ], [ %62, %54 ]
  %57 = getelementptr i64, ptr %27, i64 %55
  %58 = load i64, ptr %57, align 8
  %59 = mul nuw nsw i64 %55, 10
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %59
  %60 = load i64, ptr %gep.2, align 16
  %61 = mul i64 %60, %58
  %62 = add i64 %56, %61
  store i64 %62, ptr %53, align 16
  %63 = add nuw nsw i64 %55, 1
  %64 = icmp ult i64 %55, 149
  br i1 %64, label %54, label %.preheader6.3

.preheader6.3:                                    ; preds = %54
  %65 = getelementptr i64, ptr %29, i64 3
  %.promoted.3 = load i64, ptr %65, align 8
  br label %66

66:                                               ; preds = %66, %.preheader6.3
  %67 = phi i64 [ 0, %.preheader6.3 ], [ %75, %66 ]
  %68 = phi i64 [ %.promoted.3, %.preheader6.3 ], [ %74, %66 ]
  %69 = getelementptr i64, ptr %27, i64 %67
  %70 = load i64, ptr %69, align 8
  %71 = mul nuw nsw i64 %67, 10
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %71
  %72 = load i64, ptr %gep.3, align 8
  %73 = mul i64 %72, %70
  %74 = add i64 %68, %73
  store i64 %74, ptr %65, align 8
  %75 = add nuw nsw i64 %67, 1
  %76 = icmp ult i64 %67, 149
  br i1 %76, label %66, label %.preheader6.4

.preheader6.4:                                    ; preds = %66
  %77 = getelementptr i64, ptr %29, i64 4
  %.promoted.4 = load i64, ptr %77, align 16
  br label %78

78:                                               ; preds = %78, %.preheader6.4
  %79 = phi i64 [ 0, %.preheader6.4 ], [ %87, %78 ]
  %80 = phi i64 [ %.promoted.4, %.preheader6.4 ], [ %86, %78 ]
  %81 = getelementptr i64, ptr %27, i64 %79
  %82 = load i64, ptr %81, align 8
  %83 = mul nuw nsw i64 %79, 10
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %83
  %84 = load i64, ptr %gep.4, align 16
  %85 = mul i64 %84, %82
  %86 = add i64 %80, %85
  store i64 %86, ptr %77, align 16
  %87 = add nuw nsw i64 %79, 1
  %88 = icmp ult i64 %79, 149
  br i1 %88, label %78, label %.preheader6.5

.preheader6.5:                                    ; preds = %78
  %89 = getelementptr i64, ptr %29, i64 5
  %.promoted.5 = load i64, ptr %89, align 8
  br label %90

90:                                               ; preds = %90, %.preheader6.5
  %91 = phi i64 [ 0, %.preheader6.5 ], [ %99, %90 ]
  %92 = phi i64 [ %.promoted.5, %.preheader6.5 ], [ %98, %90 ]
  %93 = getelementptr i64, ptr %27, i64 %91
  %94 = load i64, ptr %93, align 8
  %95 = mul nuw nsw i64 %91, 10
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %95
  %96 = load i64, ptr %gep.5, align 8
  %97 = mul i64 %96, %94
  %98 = add i64 %92, %97
  store i64 %98, ptr %89, align 8
  %99 = add nuw nsw i64 %91, 1
  %100 = icmp ult i64 %91, 149
  br i1 %100, label %90, label %.preheader6.6

.preheader6.6:                                    ; preds = %90
  %101 = getelementptr i64, ptr %29, i64 6
  %.promoted.6 = load i64, ptr %101, align 16
  br label %102

102:                                              ; preds = %102, %.preheader6.6
  %103 = phi i64 [ 0, %.preheader6.6 ], [ %111, %102 ]
  %104 = phi i64 [ %.promoted.6, %.preheader6.6 ], [ %110, %102 ]
  %105 = getelementptr i64, ptr %27, i64 %103
  %106 = load i64, ptr %105, align 8
  %107 = mul nuw nsw i64 %103, 10
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %107
  %108 = load i64, ptr %gep.6, align 16
  %109 = mul i64 %108, %106
  %110 = add i64 %104, %109
  store i64 %110, ptr %101, align 16
  %111 = add nuw nsw i64 %103, 1
  %112 = icmp ult i64 %103, 149
  br i1 %112, label %102, label %.preheader6.7

.preheader6.7:                                    ; preds = %102
  %113 = getelementptr i64, ptr %29, i64 7
  %.promoted.7 = load i64, ptr %113, align 8
  br label %114

114:                                              ; preds = %114, %.preheader6.7
  %115 = phi i64 [ 0, %.preheader6.7 ], [ %123, %114 ]
  %116 = phi i64 [ %.promoted.7, %.preheader6.7 ], [ %122, %114 ]
  %117 = getelementptr i64, ptr %27, i64 %115
  %118 = load i64, ptr %117, align 8
  %119 = mul nuw nsw i64 %115, 10
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %119
  %120 = load i64, ptr %gep.7, align 8
  %121 = mul i64 %120, %118
  %122 = add i64 %116, %121
  store i64 %122, ptr %113, align 8
  %123 = add nuw nsw i64 %115, 1
  %124 = icmp ult i64 %115, 149
  br i1 %124, label %114, label %.preheader6.8

.preheader6.8:                                    ; preds = %114
  %125 = getelementptr i64, ptr %29, i64 8
  %.promoted.8 = load i64, ptr %125, align 16
  br label %126

126:                                              ; preds = %126, %.preheader6.8
  %127 = phi i64 [ 0, %.preheader6.8 ], [ %135, %126 ]
  %128 = phi i64 [ %.promoted.8, %.preheader6.8 ], [ %134, %126 ]
  %129 = getelementptr i64, ptr %27, i64 %127
  %130 = load i64, ptr %129, align 8
  %131 = mul nuw nsw i64 %127, 10
  %gep.8 = getelementptr i64, ptr %invariant.gep.8, i64 %131
  %132 = load i64, ptr %gep.8, align 16
  %133 = mul i64 %132, %130
  %134 = add i64 %128, %133
  store i64 %134, ptr %125, align 16
  %135 = add nuw nsw i64 %127, 1
  %136 = icmp ult i64 %127, 149
  br i1 %136, label %126, label %.preheader6.9

.preheader6.9:                                    ; preds = %126
  %137 = getelementptr i64, ptr %29, i64 9
  %.promoted.9 = load i64, ptr %137, align 8
  br label %138

138:                                              ; preds = %138, %.preheader6.9
  %139 = phi i64 [ 0, %.preheader6.9 ], [ %147, %138 ]
  %140 = phi i64 [ %.promoted.9, %.preheader6.9 ], [ %146, %138 ]
  %141 = getelementptr i64, ptr %27, i64 %139
  %142 = load i64, ptr %141, align 8
  %143 = mul nuw nsw i64 %139, 10
  %gep.9 = getelementptr i64, ptr %invariant.gep.9, i64 %143
  %144 = load i64, ptr %gep.9, align 8
  %145 = mul i64 %144, %142
  %146 = add i64 %140, %145
  store i64 %146, ptr %137, align 8
  %147 = add nuw nsw i64 %139, 1
  %148 = icmp ult i64 %139, 149
  br i1 %148, label %138, label %149

149:                                              ; preds = %138
  %150 = add nuw nsw i64 %25, 1
  %151 = icmp ult i64 %25, 249
  br i1 %151, label %.preheader7, label %152

152:                                              ; preds = %149
  %153 = inttoptr i64 %9 to ptr
  %154 = tail call dereferenceable_or_null(14064) ptr @malloc(i64 14064)
  %155 = ptrtoint ptr %154 to i64
  %156 = add i64 %155, 63
  %157 = and i64 %156, -64
  %158 = inttoptr i64 %157 to ptr
  %invariant.gep8.1 = getelementptr i64, ptr %24, i64 1
  %invariant.gep8.2 = getelementptr i64, ptr %24, i64 2
  %invariant.gep8.3 = getelementptr i64, ptr %24, i64 3
  %invariant.gep8.4 = getelementptr i64, ptr %24, i64 4
  %invariant.gep8.5 = getelementptr i64, ptr %24, i64 5
  %invariant.gep8.6 = getelementptr i64, ptr %24, i64 6
  %invariant.gep8.7 = getelementptr i64, ptr %24, i64 7
  %invariant.gep8.8 = getelementptr i64, ptr %24, i64 8
  %invariant.gep8.9 = getelementptr i64, ptr %24, i64 9
  br label %.preheader5

.preheader5:                                      ; preds = %152, %283
  %159 = phi i64 [ 0, %152 ], [ %284, %283 ]
  %160 = mul nuw nsw i64 %159, 250
  %161 = getelementptr i64, ptr %153, i64 %160
  %162 = mul nuw nsw i64 %159, 10
  %163 = getelementptr i64, ptr %158, i64 %162
  %.promoted10 = load i64, ptr %163, align 16
  br label %164

164:                                              ; preds = %.preheader5, %164
  %165 = phi i64 [ 0, %.preheader5 ], [ %173, %164 ]
  %166 = phi i64 [ %.promoted10, %.preheader5 ], [ %172, %164 ]
  %167 = getelementptr i64, ptr %161, i64 %165
  %168 = load i64, ptr %167, align 8
  %169 = mul nuw nsw i64 %165, 10
  %gep9 = getelementptr i64, ptr %24, i64 %169
  %170 = load i64, ptr %gep9, align 16
  %171 = mul i64 %170, %168
  %172 = add i64 %166, %171
  store i64 %172, ptr %163, align 16
  %173 = add nuw nsw i64 %165, 1
  %174 = icmp ult i64 %165, 249
  br i1 %174, label %164, label %.preheader4.1

.preheader4.1:                                    ; preds = %164
  %175 = getelementptr i64, ptr %163, i64 1
  %.promoted10.1 = load i64, ptr %175, align 8
  br label %176

176:                                              ; preds = %176, %.preheader4.1
  %177 = phi i64 [ 0, %.preheader4.1 ], [ %185, %176 ]
  %178 = phi i64 [ %.promoted10.1, %.preheader4.1 ], [ %184, %176 ]
  %179 = getelementptr i64, ptr %161, i64 %177
  %180 = load i64, ptr %179, align 8
  %181 = mul nuw nsw i64 %177, 10
  %gep9.1 = getelementptr i64, ptr %invariant.gep8.1, i64 %181
  %182 = load i64, ptr %gep9.1, align 8
  %183 = mul i64 %182, %180
  %184 = add i64 %178, %183
  store i64 %184, ptr %175, align 8
  %185 = add nuw nsw i64 %177, 1
  %186 = icmp ult i64 %177, 249
  br i1 %186, label %176, label %.preheader4.2

.preheader4.2:                                    ; preds = %176
  %187 = getelementptr i64, ptr %163, i64 2
  %.promoted10.2 = load i64, ptr %187, align 16
  br label %188

188:                                              ; preds = %188, %.preheader4.2
  %189 = phi i64 [ 0, %.preheader4.2 ], [ %197, %188 ]
  %190 = phi i64 [ %.promoted10.2, %.preheader4.2 ], [ %196, %188 ]
  %191 = getelementptr i64, ptr %161, i64 %189
  %192 = load i64, ptr %191, align 8
  %193 = mul nuw nsw i64 %189, 10
  %gep9.2 = getelementptr i64, ptr %invariant.gep8.2, i64 %193
  %194 = load i64, ptr %gep9.2, align 16
  %195 = mul i64 %194, %192
  %196 = add i64 %190, %195
  store i64 %196, ptr %187, align 16
  %197 = add nuw nsw i64 %189, 1
  %198 = icmp ult i64 %189, 249
  br i1 %198, label %188, label %.preheader4.3

.preheader4.3:                                    ; preds = %188
  %199 = getelementptr i64, ptr %163, i64 3
  %.promoted10.3 = load i64, ptr %199, align 8
  br label %200

200:                                              ; preds = %200, %.preheader4.3
  %201 = phi i64 [ 0, %.preheader4.3 ], [ %209, %200 ]
  %202 = phi i64 [ %.promoted10.3, %.preheader4.3 ], [ %208, %200 ]
  %203 = getelementptr i64, ptr %161, i64 %201
  %204 = load i64, ptr %203, align 8
  %205 = mul nuw nsw i64 %201, 10
  %gep9.3 = getelementptr i64, ptr %invariant.gep8.3, i64 %205
  %206 = load i64, ptr %gep9.3, align 8
  %207 = mul i64 %206, %204
  %208 = add i64 %202, %207
  store i64 %208, ptr %199, align 8
  %209 = add nuw nsw i64 %201, 1
  %210 = icmp ult i64 %201, 249
  br i1 %210, label %200, label %.preheader4.4

.preheader4.4:                                    ; preds = %200
  %211 = getelementptr i64, ptr %163, i64 4
  %.promoted10.4 = load i64, ptr %211, align 16
  br label %212

212:                                              ; preds = %212, %.preheader4.4
  %213 = phi i64 [ 0, %.preheader4.4 ], [ %221, %212 ]
  %214 = phi i64 [ %.promoted10.4, %.preheader4.4 ], [ %220, %212 ]
  %215 = getelementptr i64, ptr %161, i64 %213
  %216 = load i64, ptr %215, align 8
  %217 = mul nuw nsw i64 %213, 10
  %gep9.4 = getelementptr i64, ptr %invariant.gep8.4, i64 %217
  %218 = load i64, ptr %gep9.4, align 16
  %219 = mul i64 %218, %216
  %220 = add i64 %214, %219
  store i64 %220, ptr %211, align 16
  %221 = add nuw nsw i64 %213, 1
  %222 = icmp ult i64 %213, 249
  br i1 %222, label %212, label %.preheader4.5

.preheader4.5:                                    ; preds = %212
  %223 = getelementptr i64, ptr %163, i64 5
  %.promoted10.5 = load i64, ptr %223, align 8
  br label %224

224:                                              ; preds = %224, %.preheader4.5
  %225 = phi i64 [ 0, %.preheader4.5 ], [ %233, %224 ]
  %226 = phi i64 [ %.promoted10.5, %.preheader4.5 ], [ %232, %224 ]
  %227 = getelementptr i64, ptr %161, i64 %225
  %228 = load i64, ptr %227, align 8
  %229 = mul nuw nsw i64 %225, 10
  %gep9.5 = getelementptr i64, ptr %invariant.gep8.5, i64 %229
  %230 = load i64, ptr %gep9.5, align 8
  %231 = mul i64 %230, %228
  %232 = add i64 %226, %231
  store i64 %232, ptr %223, align 8
  %233 = add nuw nsw i64 %225, 1
  %234 = icmp ult i64 %225, 249
  br i1 %234, label %224, label %.preheader4.6

.preheader4.6:                                    ; preds = %224
  %235 = getelementptr i64, ptr %163, i64 6
  %.promoted10.6 = load i64, ptr %235, align 16
  br label %236

236:                                              ; preds = %236, %.preheader4.6
  %237 = phi i64 [ 0, %.preheader4.6 ], [ %245, %236 ]
  %238 = phi i64 [ %.promoted10.6, %.preheader4.6 ], [ %244, %236 ]
  %239 = getelementptr i64, ptr %161, i64 %237
  %240 = load i64, ptr %239, align 8
  %241 = mul nuw nsw i64 %237, 10
  %gep9.6 = getelementptr i64, ptr %invariant.gep8.6, i64 %241
  %242 = load i64, ptr %gep9.6, align 16
  %243 = mul i64 %242, %240
  %244 = add i64 %238, %243
  store i64 %244, ptr %235, align 16
  %245 = add nuw nsw i64 %237, 1
  %246 = icmp ult i64 %237, 249
  br i1 %246, label %236, label %.preheader4.7

.preheader4.7:                                    ; preds = %236
  %247 = getelementptr i64, ptr %163, i64 7
  %.promoted10.7 = load i64, ptr %247, align 8
  br label %248

248:                                              ; preds = %248, %.preheader4.7
  %249 = phi i64 [ 0, %.preheader4.7 ], [ %257, %248 ]
  %250 = phi i64 [ %.promoted10.7, %.preheader4.7 ], [ %256, %248 ]
  %251 = getelementptr i64, ptr %161, i64 %249
  %252 = load i64, ptr %251, align 8
  %253 = mul nuw nsw i64 %249, 10
  %gep9.7 = getelementptr i64, ptr %invariant.gep8.7, i64 %253
  %254 = load i64, ptr %gep9.7, align 8
  %255 = mul i64 %254, %252
  %256 = add i64 %250, %255
  store i64 %256, ptr %247, align 8
  %257 = add nuw nsw i64 %249, 1
  %258 = icmp ult i64 %249, 249
  br i1 %258, label %248, label %.preheader4.8

.preheader4.8:                                    ; preds = %248
  %259 = getelementptr i64, ptr %163, i64 8
  %.promoted10.8 = load i64, ptr %259, align 16
  br label %260

260:                                              ; preds = %260, %.preheader4.8
  %261 = phi i64 [ 0, %.preheader4.8 ], [ %269, %260 ]
  %262 = phi i64 [ %.promoted10.8, %.preheader4.8 ], [ %268, %260 ]
  %263 = getelementptr i64, ptr %161, i64 %261
  %264 = load i64, ptr %263, align 8
  %265 = mul nuw nsw i64 %261, 10
  %gep9.8 = getelementptr i64, ptr %invariant.gep8.8, i64 %265
  %266 = load i64, ptr %gep9.8, align 16
  %267 = mul i64 %266, %264
  %268 = add i64 %262, %267
  store i64 %268, ptr %259, align 16
  %269 = add nuw nsw i64 %261, 1
  %270 = icmp ult i64 %261, 249
  br i1 %270, label %260, label %.preheader4.9

.preheader4.9:                                    ; preds = %260
  %271 = getelementptr i64, ptr %163, i64 9
  %.promoted10.9 = load i64, ptr %271, align 8
  br label %272

272:                                              ; preds = %272, %.preheader4.9
  %273 = phi i64 [ 0, %.preheader4.9 ], [ %281, %272 ]
  %274 = phi i64 [ %.promoted10.9, %.preheader4.9 ], [ %280, %272 ]
  %275 = getelementptr i64, ptr %161, i64 %273
  %276 = load i64, ptr %275, align 8
  %277 = mul nuw nsw i64 %273, 10
  %gep9.9 = getelementptr i64, ptr %invariant.gep8.9, i64 %277
  %278 = load i64, ptr %gep9.9, align 8
  %279 = mul i64 %278, %276
  %280 = add i64 %274, %279
  store i64 %280, ptr %271, align 8
  %281 = add nuw nsw i64 %273, 1
  %282 = icmp ult i64 %273, 249
  br i1 %282, label %272, label %283

283:                                              ; preds = %272
  %284 = add nuw nsw i64 %159, 1
  %285 = icmp ult i64 %159, 174
  br i1 %285, label %.preheader5, label %286

286:                                              ; preds = %283
  %287 = inttoptr i64 %5 to ptr
  %288 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %289 = ptrtoint ptr %288 to i64
  %290 = add i64 %289, 63
  %291 = and i64 %290, -64
  %292 = inttoptr i64 %291 to ptr
  %invariant.gep11.1 = getelementptr i64, ptr %158, i64 1
  %invariant.gep11.2 = getelementptr i64, ptr %158, i64 2
  %invariant.gep11.3 = getelementptr i64, ptr %158, i64 3
  %invariant.gep11.4 = getelementptr i64, ptr %158, i64 4
  %invariant.gep11.5 = getelementptr i64, ptr %158, i64 5
  %invariant.gep11.6 = getelementptr i64, ptr %158, i64 6
  %invariant.gep11.7 = getelementptr i64, ptr %158, i64 7
  %invariant.gep11.8 = getelementptr i64, ptr %158, i64 8
  %invariant.gep11.9 = getelementptr i64, ptr %158, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %286, %417
  %293 = phi i64 [ 0, %286 ], [ %418, %417 ]
  %294 = mul nuw nsw i64 %293, 175
  %295 = getelementptr i64, ptr %287, i64 %294
  %296 = mul nuw nsw i64 %293, 10
  %297 = getelementptr i64, ptr %292, i64 %296
  %.promoted13 = load i64, ptr %297, align 16
  br label %298

298:                                              ; preds = %.preheader3, %298
  %299 = phi i64 [ 0, %.preheader3 ], [ %307, %298 ]
  %300 = phi i64 [ %.promoted13, %.preheader3 ], [ %306, %298 ]
  %301 = getelementptr i64, ptr %295, i64 %299
  %302 = load i64, ptr %301, align 8
  %303 = mul nuw nsw i64 %299, 10
  %gep12 = getelementptr i64, ptr %158, i64 %303
  %304 = load i64, ptr %gep12, align 16
  %305 = mul i64 %304, %302
  %306 = add i64 %300, %305
  store i64 %306, ptr %297, align 16
  %307 = add nuw nsw i64 %299, 1
  %308 = icmp ult i64 %299, 174
  br i1 %308, label %298, label %.preheader.1

.preheader.1:                                     ; preds = %298
  %309 = getelementptr i64, ptr %297, i64 1
  %.promoted13.1 = load i64, ptr %309, align 8
  br label %310

310:                                              ; preds = %310, %.preheader.1
  %311 = phi i64 [ 0, %.preheader.1 ], [ %319, %310 ]
  %312 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %318, %310 ]
  %313 = getelementptr i64, ptr %295, i64 %311
  %314 = load i64, ptr %313, align 8
  %315 = mul nuw nsw i64 %311, 10
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %315
  %316 = load i64, ptr %gep12.1, align 8
  %317 = mul i64 %316, %314
  %318 = add i64 %312, %317
  store i64 %318, ptr %309, align 8
  %319 = add nuw nsw i64 %311, 1
  %320 = icmp ult i64 %311, 174
  br i1 %320, label %310, label %.preheader.2

.preheader.2:                                     ; preds = %310
  %321 = getelementptr i64, ptr %297, i64 2
  %.promoted13.2 = load i64, ptr %321, align 16
  br label %322

322:                                              ; preds = %322, %.preheader.2
  %323 = phi i64 [ 0, %.preheader.2 ], [ %331, %322 ]
  %324 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %330, %322 ]
  %325 = getelementptr i64, ptr %295, i64 %323
  %326 = load i64, ptr %325, align 8
  %327 = mul nuw nsw i64 %323, 10
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %327
  %328 = load i64, ptr %gep12.2, align 16
  %329 = mul i64 %328, %326
  %330 = add i64 %324, %329
  store i64 %330, ptr %321, align 16
  %331 = add nuw nsw i64 %323, 1
  %332 = icmp ult i64 %323, 174
  br i1 %332, label %322, label %.preheader.3

.preheader.3:                                     ; preds = %322
  %333 = getelementptr i64, ptr %297, i64 3
  %.promoted13.3 = load i64, ptr %333, align 8
  br label %334

334:                                              ; preds = %334, %.preheader.3
  %335 = phi i64 [ 0, %.preheader.3 ], [ %343, %334 ]
  %336 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %342, %334 ]
  %337 = getelementptr i64, ptr %295, i64 %335
  %338 = load i64, ptr %337, align 8
  %339 = mul nuw nsw i64 %335, 10
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %339
  %340 = load i64, ptr %gep12.3, align 8
  %341 = mul i64 %340, %338
  %342 = add i64 %336, %341
  store i64 %342, ptr %333, align 8
  %343 = add nuw nsw i64 %335, 1
  %344 = icmp ult i64 %335, 174
  br i1 %344, label %334, label %.preheader.4

.preheader.4:                                     ; preds = %334
  %345 = getelementptr i64, ptr %297, i64 4
  %.promoted13.4 = load i64, ptr %345, align 16
  br label %346

346:                                              ; preds = %346, %.preheader.4
  %347 = phi i64 [ 0, %.preheader.4 ], [ %355, %346 ]
  %348 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %354, %346 ]
  %349 = getelementptr i64, ptr %295, i64 %347
  %350 = load i64, ptr %349, align 8
  %351 = mul nuw nsw i64 %347, 10
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %351
  %352 = load i64, ptr %gep12.4, align 16
  %353 = mul i64 %352, %350
  %354 = add i64 %348, %353
  store i64 %354, ptr %345, align 16
  %355 = add nuw nsw i64 %347, 1
  %356 = icmp ult i64 %347, 174
  br i1 %356, label %346, label %.preheader.5

.preheader.5:                                     ; preds = %346
  %357 = getelementptr i64, ptr %297, i64 5
  %.promoted13.5 = load i64, ptr %357, align 8
  br label %358

358:                                              ; preds = %358, %.preheader.5
  %359 = phi i64 [ 0, %.preheader.5 ], [ %367, %358 ]
  %360 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %366, %358 ]
  %361 = getelementptr i64, ptr %295, i64 %359
  %362 = load i64, ptr %361, align 8
  %363 = mul nuw nsw i64 %359, 10
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %363
  %364 = load i64, ptr %gep12.5, align 8
  %365 = mul i64 %364, %362
  %366 = add i64 %360, %365
  store i64 %366, ptr %357, align 8
  %367 = add nuw nsw i64 %359, 1
  %368 = icmp ult i64 %359, 174
  br i1 %368, label %358, label %.preheader.6

.preheader.6:                                     ; preds = %358
  %369 = getelementptr i64, ptr %297, i64 6
  %.promoted13.6 = load i64, ptr %369, align 16
  br label %370

370:                                              ; preds = %370, %.preheader.6
  %371 = phi i64 [ 0, %.preheader.6 ], [ %379, %370 ]
  %372 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %378, %370 ]
  %373 = getelementptr i64, ptr %295, i64 %371
  %374 = load i64, ptr %373, align 8
  %375 = mul nuw nsw i64 %371, 10
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %375
  %376 = load i64, ptr %gep12.6, align 16
  %377 = mul i64 %376, %374
  %378 = add i64 %372, %377
  store i64 %378, ptr %369, align 16
  %379 = add nuw nsw i64 %371, 1
  %380 = icmp ult i64 %371, 174
  br i1 %380, label %370, label %.preheader.7

.preheader.7:                                     ; preds = %370
  %381 = getelementptr i64, ptr %297, i64 7
  %.promoted13.7 = load i64, ptr %381, align 8
  br label %382

382:                                              ; preds = %382, %.preheader.7
  %383 = phi i64 [ 0, %.preheader.7 ], [ %391, %382 ]
  %384 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %390, %382 ]
  %385 = getelementptr i64, ptr %295, i64 %383
  %386 = load i64, ptr %385, align 8
  %387 = mul nuw nsw i64 %383, 10
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %387
  %388 = load i64, ptr %gep12.7, align 8
  %389 = mul i64 %388, %386
  %390 = add i64 %384, %389
  store i64 %390, ptr %381, align 8
  %391 = add nuw nsw i64 %383, 1
  %392 = icmp ult i64 %383, 174
  br i1 %392, label %382, label %.preheader.8

.preheader.8:                                     ; preds = %382
  %393 = getelementptr i64, ptr %297, i64 8
  %.promoted13.8 = load i64, ptr %393, align 16
  br label %394

394:                                              ; preds = %394, %.preheader.8
  %395 = phi i64 [ 0, %.preheader.8 ], [ %403, %394 ]
  %396 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %402, %394 ]
  %397 = getelementptr i64, ptr %295, i64 %395
  %398 = load i64, ptr %397, align 8
  %399 = mul nuw nsw i64 %395, 10
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %399
  %400 = load i64, ptr %gep12.8, align 16
  %401 = mul i64 %400, %398
  %402 = add i64 %396, %401
  store i64 %402, ptr %393, align 16
  %403 = add nuw nsw i64 %395, 1
  %404 = icmp ult i64 %395, 174
  br i1 %404, label %394, label %.preheader.9

.preheader.9:                                     ; preds = %394
  %405 = getelementptr i64, ptr %297, i64 9
  %.promoted13.9 = load i64, ptr %405, align 8
  br label %406

406:                                              ; preds = %406, %.preheader.9
  %407 = phi i64 [ 0, %.preheader.9 ], [ %415, %406 ]
  %408 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %414, %406 ]
  %409 = getelementptr i64, ptr %295, i64 %407
  %410 = load i64, ptr %409, align 8
  %411 = mul nuw nsw i64 %407, 10
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %411
  %412 = load i64, ptr %gep12.9, align 8
  %413 = mul i64 %412, %410
  %414 = add i64 %408, %413
  store i64 %414, ptr %405, align 8
  %415 = add nuw nsw i64 %407, 1
  %416 = icmp ult i64 %407, 174
  br i1 %416, label %406, label %417

417:                                              ; preds = %406
  %418 = add nuw nsw i64 %293, 1
  %419 = icmp ult i64 %293, 199
  br i1 %419, label %.preheader3, label %420

420:                                              ; preds = %417
  %421 = tail call i64 @clock()
  %422 = sub i64 %421, %1
  %423 = uitofp i64 %422 to double
  %424 = fdiv double %423, 9.000000e+03
  %425 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %422, double %424)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
