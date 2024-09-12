; ModuleID = 'bench/run/linalg_3mm.ll'
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
  %6 = inttoptr i64 %5 to ptr
  %7 = tail call dereferenceable_or_null(350064) ptr @malloc(i64 350064)
  %8 = ptrtoint ptr %7 to i64
  %9 = add i64 %8, 63
  %10 = and i64 %9, -64
  %11 = inttoptr i64 %10 to ptr
  %12 = tail call dereferenceable_or_null(300064) ptr @malloc(i64 300064)
  %13 = ptrtoint ptr %12 to i64
  %14 = add i64 %13, 63
  %15 = and i64 %14, -64
  %16 = tail call dereferenceable_or_null(12064) ptr @malloc(i64 12064)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = and i64 %18, -64
  %20 = tail call dereferenceable_or_null(400064) ptr @malloc(i64 400064)
  %21 = ptrtoint ptr %20 to i64
  %22 = add i64 %21, 63
  %23 = and i64 %22, -64
  %24 = inttoptr i64 %23 to ptr
  br label %.preheader7

.preheader7:                                      ; preds = %0, %46
  %25 = phi i64 [ 0, %0 ], [ %47, %46 ]
  %26 = mul nuw nsw i64 %25, 175
  %27 = getelementptr i64, ptr %6, i64 %26
  %28 = mul nuw nsw i64 %25, 250
  %29 = getelementptr i64, ptr %24, i64 %28
  br label %.preheader6

.preheader6:                                      ; preds = %.preheader7, %43
  %30 = phi i64 [ 0, %.preheader7 ], [ %44, %43 ]
  %invariant.gep = getelementptr i64, ptr %11, i64 %30
  %31 = getelementptr i64, ptr %29, i64 %30
  %.promoted = load i64, ptr %31, align 8
  br label %32

32:                                               ; preds = %.preheader6, %32
  %33 = phi i64 [ 0, %.preheader6 ], [ %41, %32 ]
  %34 = phi i64 [ %.promoted, %.preheader6 ], [ %40, %32 ]
  %35 = getelementptr i64, ptr %27, i64 %33
  %36 = load i64, ptr %35, align 8
  %37 = mul nuw nsw i64 %33, 250
  %gep = getelementptr i64, ptr %invariant.gep, i64 %37
  %38 = load i64, ptr %gep, align 8
  %39 = mul i64 %38, %36
  %40 = add i64 %34, %39
  store i64 %40, ptr %31, align 8
  %41 = add nuw nsw i64 %33, 1
  %42 = icmp ult i64 %33, 174
  br i1 %42, label %32, label %43

43:                                               ; preds = %32
  %44 = add nuw nsw i64 %30, 1
  %45 = icmp ult i64 %30, 249
  br i1 %45, label %.preheader6, label %46

46:                                               ; preds = %43
  %47 = add nuw nsw i64 %25, 1
  %48 = icmp ult i64 %25, 199
  br i1 %48, label %.preheader7, label %49

49:                                               ; preds = %46
  %50 = inttoptr i64 %15 to ptr
  %51 = tail call dereferenceable_or_null(240064) ptr @malloc(i64 240064)
  %52 = ptrtoint ptr %51 to i64
  %53 = add i64 %52, 63
  %54 = and i64 %53, -64
  %55 = inttoptr i64 %54 to ptr
  br label %.preheader5

.preheader5:                                      ; preds = %49, %77
  %56 = phi i64 [ 0, %49 ], [ %78, %77 ]
  %57 = mul nuw nsw i64 %56, 250
  %58 = getelementptr i64, ptr %24, i64 %57
  %59 = mul nuw nsw i64 %56, 150
  %60 = getelementptr i64, ptr %55, i64 %59
  br label %.preheader4

.preheader4:                                      ; preds = %.preheader5, %74
  %61 = phi i64 [ 0, %.preheader5 ], [ %75, %74 ]
  %invariant.gep8 = getelementptr i64, ptr %50, i64 %61
  %62 = getelementptr i64, ptr %60, i64 %61
  %.promoted10 = load i64, ptr %62, align 8
  br label %63

63:                                               ; preds = %.preheader4, %63
  %64 = phi i64 [ 0, %.preheader4 ], [ %72, %63 ]
  %65 = phi i64 [ %.promoted10, %.preheader4 ], [ %71, %63 ]
  %66 = getelementptr i64, ptr %58, i64 %64
  %67 = load i64, ptr %66, align 8
  %68 = mul nuw nsw i64 %64, 150
  %gep9 = getelementptr i64, ptr %invariant.gep8, i64 %68
  %69 = load i64, ptr %gep9, align 8
  %70 = mul i64 %69, %67
  %71 = add i64 %65, %70
  store i64 %71, ptr %62, align 8
  %72 = add nuw nsw i64 %64, 1
  %73 = icmp ult i64 %64, 249
  br i1 %73, label %63, label %74

74:                                               ; preds = %63
  %75 = add nuw nsw i64 %61, 1
  %76 = icmp ult i64 %61, 149
  br i1 %76, label %.preheader4, label %77

77:                                               ; preds = %74
  %78 = add nuw nsw i64 %56, 1
  %79 = icmp ult i64 %56, 199
  br i1 %79, label %.preheader5, label %80

80:                                               ; preds = %77
  %81 = inttoptr i64 %19 to ptr
  %82 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %83 = ptrtoint ptr %82 to i64
  %84 = add i64 %83, 63
  %85 = and i64 %84, -64
  %86 = inttoptr i64 %85 to ptr
  %invariant.gep11.1 = getelementptr i64, ptr %81, i64 1
  %invariant.gep11.2 = getelementptr i64, ptr %81, i64 2
  %invariant.gep11.3 = getelementptr i64, ptr %81, i64 3
  %invariant.gep11.4 = getelementptr i64, ptr %81, i64 4
  %invariant.gep11.5 = getelementptr i64, ptr %81, i64 5
  %invariant.gep11.6 = getelementptr i64, ptr %81, i64 6
  %invariant.gep11.7 = getelementptr i64, ptr %81, i64 7
  %invariant.gep11.8 = getelementptr i64, ptr %81, i64 8
  %invariant.gep11.9 = getelementptr i64, ptr %81, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %80, %211
  %87 = phi i64 [ 0, %80 ], [ %212, %211 ]
  %88 = mul nuw nsw i64 %87, 150
  %89 = getelementptr i64, ptr %55, i64 %88
  %90 = mul nuw nsw i64 %87, 10
  %91 = getelementptr i64, ptr %86, i64 %90
  %.promoted13 = load i64, ptr %91, align 16
  br label %92

92:                                               ; preds = %.preheader3, %92
  %93 = phi i64 [ 0, %.preheader3 ], [ %101, %92 ]
  %94 = phi i64 [ %.promoted13, %.preheader3 ], [ %100, %92 ]
  %95 = getelementptr i64, ptr %89, i64 %93
  %96 = load i64, ptr %95, align 8
  %97 = mul nuw nsw i64 %93, 10
  %gep12 = getelementptr i64, ptr %81, i64 %97
  %98 = load i64, ptr %gep12, align 16
  %99 = mul i64 %98, %96
  %100 = add i64 %94, %99
  store i64 %100, ptr %91, align 16
  %101 = add nuw nsw i64 %93, 1
  %102 = icmp ult i64 %93, 149
  br i1 %102, label %92, label %.preheader.1

.preheader.1:                                     ; preds = %92
  %103 = getelementptr i64, ptr %91, i64 1
  %.promoted13.1 = load i64, ptr %103, align 8
  br label %104

104:                                              ; preds = %104, %.preheader.1
  %105 = phi i64 [ 0, %.preheader.1 ], [ %113, %104 ]
  %106 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %112, %104 ]
  %107 = getelementptr i64, ptr %89, i64 %105
  %108 = load i64, ptr %107, align 8
  %109 = mul nuw nsw i64 %105, 10
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %109
  %110 = load i64, ptr %gep12.1, align 8
  %111 = mul i64 %110, %108
  %112 = add i64 %106, %111
  store i64 %112, ptr %103, align 8
  %113 = add nuw nsw i64 %105, 1
  %114 = icmp ult i64 %105, 149
  br i1 %114, label %104, label %.preheader.2

.preheader.2:                                     ; preds = %104
  %115 = getelementptr i64, ptr %91, i64 2
  %.promoted13.2 = load i64, ptr %115, align 16
  br label %116

116:                                              ; preds = %116, %.preheader.2
  %117 = phi i64 [ 0, %.preheader.2 ], [ %125, %116 ]
  %118 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %124, %116 ]
  %119 = getelementptr i64, ptr %89, i64 %117
  %120 = load i64, ptr %119, align 8
  %121 = mul nuw nsw i64 %117, 10
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %121
  %122 = load i64, ptr %gep12.2, align 16
  %123 = mul i64 %122, %120
  %124 = add i64 %118, %123
  store i64 %124, ptr %115, align 16
  %125 = add nuw nsw i64 %117, 1
  %126 = icmp ult i64 %117, 149
  br i1 %126, label %116, label %.preheader.3

.preheader.3:                                     ; preds = %116
  %127 = getelementptr i64, ptr %91, i64 3
  %.promoted13.3 = load i64, ptr %127, align 8
  br label %128

128:                                              ; preds = %128, %.preheader.3
  %129 = phi i64 [ 0, %.preheader.3 ], [ %137, %128 ]
  %130 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %136, %128 ]
  %131 = getelementptr i64, ptr %89, i64 %129
  %132 = load i64, ptr %131, align 8
  %133 = mul nuw nsw i64 %129, 10
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %133
  %134 = load i64, ptr %gep12.3, align 8
  %135 = mul i64 %134, %132
  %136 = add i64 %130, %135
  store i64 %136, ptr %127, align 8
  %137 = add nuw nsw i64 %129, 1
  %138 = icmp ult i64 %129, 149
  br i1 %138, label %128, label %.preheader.4

.preheader.4:                                     ; preds = %128
  %139 = getelementptr i64, ptr %91, i64 4
  %.promoted13.4 = load i64, ptr %139, align 16
  br label %140

140:                                              ; preds = %140, %.preheader.4
  %141 = phi i64 [ 0, %.preheader.4 ], [ %149, %140 ]
  %142 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %148, %140 ]
  %143 = getelementptr i64, ptr %89, i64 %141
  %144 = load i64, ptr %143, align 8
  %145 = mul nuw nsw i64 %141, 10
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %145
  %146 = load i64, ptr %gep12.4, align 16
  %147 = mul i64 %146, %144
  %148 = add i64 %142, %147
  store i64 %148, ptr %139, align 16
  %149 = add nuw nsw i64 %141, 1
  %150 = icmp ult i64 %141, 149
  br i1 %150, label %140, label %.preheader.5

.preheader.5:                                     ; preds = %140
  %151 = getelementptr i64, ptr %91, i64 5
  %.promoted13.5 = load i64, ptr %151, align 8
  br label %152

152:                                              ; preds = %152, %.preheader.5
  %153 = phi i64 [ 0, %.preheader.5 ], [ %161, %152 ]
  %154 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %160, %152 ]
  %155 = getelementptr i64, ptr %89, i64 %153
  %156 = load i64, ptr %155, align 8
  %157 = mul nuw nsw i64 %153, 10
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %157
  %158 = load i64, ptr %gep12.5, align 8
  %159 = mul i64 %158, %156
  %160 = add i64 %154, %159
  store i64 %160, ptr %151, align 8
  %161 = add nuw nsw i64 %153, 1
  %162 = icmp ult i64 %153, 149
  br i1 %162, label %152, label %.preheader.6

.preheader.6:                                     ; preds = %152
  %163 = getelementptr i64, ptr %91, i64 6
  %.promoted13.6 = load i64, ptr %163, align 16
  br label %164

164:                                              ; preds = %164, %.preheader.6
  %165 = phi i64 [ 0, %.preheader.6 ], [ %173, %164 ]
  %166 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %172, %164 ]
  %167 = getelementptr i64, ptr %89, i64 %165
  %168 = load i64, ptr %167, align 8
  %169 = mul nuw nsw i64 %165, 10
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %169
  %170 = load i64, ptr %gep12.6, align 16
  %171 = mul i64 %170, %168
  %172 = add i64 %166, %171
  store i64 %172, ptr %163, align 16
  %173 = add nuw nsw i64 %165, 1
  %174 = icmp ult i64 %165, 149
  br i1 %174, label %164, label %.preheader.7

.preheader.7:                                     ; preds = %164
  %175 = getelementptr i64, ptr %91, i64 7
  %.promoted13.7 = load i64, ptr %175, align 8
  br label %176

176:                                              ; preds = %176, %.preheader.7
  %177 = phi i64 [ 0, %.preheader.7 ], [ %185, %176 ]
  %178 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %184, %176 ]
  %179 = getelementptr i64, ptr %89, i64 %177
  %180 = load i64, ptr %179, align 8
  %181 = mul nuw nsw i64 %177, 10
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %181
  %182 = load i64, ptr %gep12.7, align 8
  %183 = mul i64 %182, %180
  %184 = add i64 %178, %183
  store i64 %184, ptr %175, align 8
  %185 = add nuw nsw i64 %177, 1
  %186 = icmp ult i64 %177, 149
  br i1 %186, label %176, label %.preheader.8

.preheader.8:                                     ; preds = %176
  %187 = getelementptr i64, ptr %91, i64 8
  %.promoted13.8 = load i64, ptr %187, align 16
  br label %188

188:                                              ; preds = %188, %.preheader.8
  %189 = phi i64 [ 0, %.preheader.8 ], [ %197, %188 ]
  %190 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %196, %188 ]
  %191 = getelementptr i64, ptr %89, i64 %189
  %192 = load i64, ptr %191, align 8
  %193 = mul nuw nsw i64 %189, 10
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %193
  %194 = load i64, ptr %gep12.8, align 16
  %195 = mul i64 %194, %192
  %196 = add i64 %190, %195
  store i64 %196, ptr %187, align 16
  %197 = add nuw nsw i64 %189, 1
  %198 = icmp ult i64 %189, 149
  br i1 %198, label %188, label %.preheader.9

.preheader.9:                                     ; preds = %188
  %199 = getelementptr i64, ptr %91, i64 9
  %.promoted13.9 = load i64, ptr %199, align 8
  br label %200

200:                                              ; preds = %200, %.preheader.9
  %201 = phi i64 [ 0, %.preheader.9 ], [ %209, %200 ]
  %202 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %208, %200 ]
  %203 = getelementptr i64, ptr %89, i64 %201
  %204 = load i64, ptr %203, align 8
  %205 = mul nuw nsw i64 %201, 10
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %205
  %206 = load i64, ptr %gep12.9, align 8
  %207 = mul i64 %206, %204
  %208 = add i64 %202, %207
  store i64 %208, ptr %199, align 8
  %209 = add nuw nsw i64 %201, 1
  %210 = icmp ult i64 %201, 149
  br i1 %210, label %200, label %211

211:                                              ; preds = %200
  %212 = add nuw nsw i64 %87, 1
  %213 = icmp ult i64 %87, 199
  br i1 %213, label %.preheader3, label %214

214:                                              ; preds = %211
  %215 = tail call i64 @clock()
  %216 = sub i64 %215, %1
  %217 = uitofp i64 %216 to double
  %218 = fdiv double %217, 9.000000e+03
  %219 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %216, double %218)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
