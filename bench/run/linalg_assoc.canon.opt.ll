; ModuleID = 'bench/run/linalg_assoc.canon.ll'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare i64 @clock() local_unnamed_addr

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

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

; Function Attrs: nofree nounwind
define void @displayTime(i64 %0, i64 %1) local_unnamed_addr #1 {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+04
  %6 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %3, double %5)
  ret void
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call i64 @clock()
  %2 = tail call dereferenceable_or_null(8064) ptr @malloc(i64 8064)
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = and i64 %4, -64
  %6 = inttoptr i64 %5 to ptr
  %7 = tail call dereferenceable_or_null(12064) ptr @malloc(i64 12064)
  %8 = ptrtoint ptr %7 to i64
  %9 = add i64 %8, 63
  %10 = and i64 %9, -64
  %11 = inttoptr i64 %10 to ptr
  %12 = tail call dereferenceable_or_null(9664) ptr @malloc(i64 9664)
  %13 = ptrtoint ptr %12 to i64
  %14 = add i64 %13, 63
  %15 = and i64 %14, -64
  %16 = tail call dereferenceable_or_null(120064) ptr @malloc(i64 120064)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = and i64 %18, -64
  %20 = inttoptr i64 %19 to ptr
  br label %.preheader4

.preheader4:                                      ; preds = %0, %79
  %21 = phi i64 [ 0, %0 ], [ %80, %79 ]
  %22 = mul nuw nsw i64 %21, 10
  %23 = getelementptr i64, ptr %6, i64 %22
  %24 = mul nuw nsw i64 %21, 150
  %25 = getelementptr i64, ptr %20, i64 %24
  %26 = getelementptr i64, ptr %23, i64 1
  %27 = getelementptr i64, ptr %23, i64 2
  %28 = getelementptr i64, ptr %23, i64 3
  %29 = getelementptr i64, ptr %23, i64 4
  %30 = getelementptr i64, ptr %23, i64 5
  %31 = getelementptr i64, ptr %23, i64 6
  %32 = getelementptr i64, ptr %23, i64 7
  %33 = getelementptr i64, ptr %23, i64 8
  %34 = getelementptr i64, ptr %23, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %.preheader4, %.preheader3
  %35 = phi i64 [ 0, %.preheader4 ], [ %77, %.preheader3 ]
  %invariant.gep = getelementptr i64, ptr %11, i64 %35
  %36 = getelementptr i64, ptr %25, i64 %35
  %.promoted = load i64, ptr %36, align 8
  %37 = load i64, ptr %23, align 16
  %38 = load i64, ptr %invariant.gep, align 8
  %39 = mul i64 %38, %37
  %40 = add i64 %.promoted, %39
  store i64 %40, ptr %36, align 8
  %41 = load i64, ptr %26, align 8
  %gep.1 = getelementptr i64, ptr %invariant.gep, i64 150
  %42 = load i64, ptr %gep.1, align 8
  %43 = mul i64 %42, %41
  %44 = add i64 %40, %43
  store i64 %44, ptr %36, align 8
  %45 = load i64, ptr %27, align 16
  %gep.2 = getelementptr i64, ptr %invariant.gep, i64 300
  %46 = load i64, ptr %gep.2, align 8
  %47 = mul i64 %46, %45
  %48 = add i64 %44, %47
  store i64 %48, ptr %36, align 8
  %49 = load i64, ptr %28, align 8
  %gep.3 = getelementptr i64, ptr %invariant.gep, i64 450
  %50 = load i64, ptr %gep.3, align 8
  %51 = mul i64 %50, %49
  %52 = add i64 %48, %51
  store i64 %52, ptr %36, align 8
  %53 = load i64, ptr %29, align 16
  %gep.4 = getelementptr i64, ptr %invariant.gep, i64 600
  %54 = load i64, ptr %gep.4, align 8
  %55 = mul i64 %54, %53
  %56 = add i64 %52, %55
  store i64 %56, ptr %36, align 8
  %57 = load i64, ptr %30, align 8
  %gep.5 = getelementptr i64, ptr %invariant.gep, i64 750
  %58 = load i64, ptr %gep.5, align 8
  %59 = mul i64 %58, %57
  %60 = add i64 %56, %59
  store i64 %60, ptr %36, align 8
  %61 = load i64, ptr %31, align 16
  %gep.6 = getelementptr i64, ptr %invariant.gep, i64 900
  %62 = load i64, ptr %gep.6, align 8
  %63 = mul i64 %62, %61
  %64 = add i64 %60, %63
  store i64 %64, ptr %36, align 8
  %65 = load i64, ptr %32, align 8
  %gep.7 = getelementptr i64, ptr %invariant.gep, i64 1050
  %66 = load i64, ptr %gep.7, align 8
  %67 = mul i64 %66, %65
  %68 = add i64 %64, %67
  store i64 %68, ptr %36, align 8
  %69 = load i64, ptr %33, align 16
  %gep.8 = getelementptr i64, ptr %invariant.gep, i64 1200
  %70 = load i64, ptr %gep.8, align 8
  %71 = mul i64 %70, %69
  %72 = add i64 %68, %71
  store i64 %72, ptr %36, align 8
  %73 = load i64, ptr %34, align 8
  %gep.9 = getelementptr i64, ptr %invariant.gep, i64 1350
  %74 = load i64, ptr %gep.9, align 8
  %75 = mul i64 %74, %73
  %76 = add i64 %72, %75
  store i64 %76, ptr %36, align 8
  %77 = add nuw nsw i64 %35, 1
  %78 = icmp ult i64 %35, 149
  br i1 %78, label %.preheader3, label %79

79:                                               ; preds = %.preheader3
  %80 = add nuw nsw i64 %21, 1
  %81 = icmp ult i64 %21, 99
  br i1 %81, label %.preheader4, label %82

82:                                               ; preds = %79
  %83 = inttoptr i64 %15 to ptr
  %84 = tail call dereferenceable_or_null(6464) ptr @malloc(i64 6464)
  %85 = ptrtoint ptr %84 to i64
  %86 = add i64 %85, 63
  %87 = and i64 %86, -64
  %88 = inttoptr i64 %87 to ptr
  %invariant.gep5.1 = getelementptr i64, ptr %83, i64 1
  %invariant.gep5.2 = getelementptr i64, ptr %83, i64 2
  %invariant.gep5.3 = getelementptr i64, ptr %83, i64 3
  %invariant.gep5.4 = getelementptr i64, ptr %83, i64 4
  %invariant.gep5.5 = getelementptr i64, ptr %83, i64 5
  %invariant.gep5.6 = getelementptr i64, ptr %83, i64 6
  %invariant.gep5.7 = getelementptr i64, ptr %83, i64 7
  br label %.preheader2

.preheader2:                                      ; preds = %82, %189
  %89 = phi i64 [ 0, %82 ], [ %190, %189 ]
  %90 = mul nuw nsw i64 %89, 150
  %91 = getelementptr i64, ptr %20, i64 %90
  %92 = shl nuw nsw i64 %89, 3
  %93 = getelementptr i64, ptr %88, i64 %92
  %.promoted7 = load i64, ptr %93, align 64
  br label %94

94:                                               ; preds = %.preheader2, %94
  %95 = phi i64 [ 0, %.preheader2 ], [ %103, %94 ]
  %96 = phi i64 [ %.promoted7, %.preheader2 ], [ %102, %94 ]
  %97 = getelementptr i64, ptr %91, i64 %95
  %98 = load i64, ptr %97, align 8
  %99 = shl nuw nsw i64 %95, 3
  %gep6 = getelementptr i64, ptr %83, i64 %99
  %100 = load i64, ptr %gep6, align 64
  %101 = mul i64 %100, %98
  %102 = add i64 %96, %101
  store i64 %102, ptr %93, align 64
  %103 = add nuw nsw i64 %95, 1
  %104 = icmp ult i64 %95, 149
  br i1 %104, label %94, label %.preheader.1

.preheader.1:                                     ; preds = %94
  %105 = getelementptr i64, ptr %93, i64 1
  %.promoted7.1 = load i64, ptr %105, align 8
  br label %106

106:                                              ; preds = %106, %.preheader.1
  %107 = phi i64 [ 0, %.preheader.1 ], [ %115, %106 ]
  %108 = phi i64 [ %.promoted7.1, %.preheader.1 ], [ %114, %106 ]
  %109 = getelementptr i64, ptr %91, i64 %107
  %110 = load i64, ptr %109, align 8
  %111 = shl nuw nsw i64 %107, 3
  %gep6.1 = getelementptr i64, ptr %invariant.gep5.1, i64 %111
  %112 = load i64, ptr %gep6.1, align 8
  %113 = mul i64 %112, %110
  %114 = add i64 %108, %113
  store i64 %114, ptr %105, align 8
  %115 = add nuw nsw i64 %107, 1
  %116 = icmp ult i64 %107, 149
  br i1 %116, label %106, label %.preheader.2

.preheader.2:                                     ; preds = %106
  %117 = getelementptr i64, ptr %93, i64 2
  %.promoted7.2 = load i64, ptr %117, align 16
  br label %118

118:                                              ; preds = %118, %.preheader.2
  %119 = phi i64 [ 0, %.preheader.2 ], [ %127, %118 ]
  %120 = phi i64 [ %.promoted7.2, %.preheader.2 ], [ %126, %118 ]
  %121 = getelementptr i64, ptr %91, i64 %119
  %122 = load i64, ptr %121, align 8
  %123 = shl nuw nsw i64 %119, 3
  %gep6.2 = getelementptr i64, ptr %invariant.gep5.2, i64 %123
  %124 = load i64, ptr %gep6.2, align 16
  %125 = mul i64 %124, %122
  %126 = add i64 %120, %125
  store i64 %126, ptr %117, align 16
  %127 = add nuw nsw i64 %119, 1
  %128 = icmp ult i64 %119, 149
  br i1 %128, label %118, label %.preheader.3

.preheader.3:                                     ; preds = %118
  %129 = getelementptr i64, ptr %93, i64 3
  %.promoted7.3 = load i64, ptr %129, align 8
  br label %130

130:                                              ; preds = %130, %.preheader.3
  %131 = phi i64 [ 0, %.preheader.3 ], [ %139, %130 ]
  %132 = phi i64 [ %.promoted7.3, %.preheader.3 ], [ %138, %130 ]
  %133 = getelementptr i64, ptr %91, i64 %131
  %134 = load i64, ptr %133, align 8
  %135 = shl nuw nsw i64 %131, 3
  %gep6.3 = getelementptr i64, ptr %invariant.gep5.3, i64 %135
  %136 = load i64, ptr %gep6.3, align 8
  %137 = mul i64 %136, %134
  %138 = add i64 %132, %137
  store i64 %138, ptr %129, align 8
  %139 = add nuw nsw i64 %131, 1
  %140 = icmp ult i64 %131, 149
  br i1 %140, label %130, label %.preheader.4

.preheader.4:                                     ; preds = %130
  %141 = getelementptr i64, ptr %93, i64 4
  %.promoted7.4 = load i64, ptr %141, align 32
  br label %142

142:                                              ; preds = %142, %.preheader.4
  %143 = phi i64 [ 0, %.preheader.4 ], [ %151, %142 ]
  %144 = phi i64 [ %.promoted7.4, %.preheader.4 ], [ %150, %142 ]
  %145 = getelementptr i64, ptr %91, i64 %143
  %146 = load i64, ptr %145, align 8
  %147 = shl nuw nsw i64 %143, 3
  %gep6.4 = getelementptr i64, ptr %invariant.gep5.4, i64 %147
  %148 = load i64, ptr %gep6.4, align 32
  %149 = mul i64 %148, %146
  %150 = add i64 %144, %149
  store i64 %150, ptr %141, align 32
  %151 = add nuw nsw i64 %143, 1
  %152 = icmp ult i64 %143, 149
  br i1 %152, label %142, label %.preheader.5

.preheader.5:                                     ; preds = %142
  %153 = getelementptr i64, ptr %93, i64 5
  %.promoted7.5 = load i64, ptr %153, align 8
  br label %154

154:                                              ; preds = %154, %.preheader.5
  %155 = phi i64 [ 0, %.preheader.5 ], [ %163, %154 ]
  %156 = phi i64 [ %.promoted7.5, %.preheader.5 ], [ %162, %154 ]
  %157 = getelementptr i64, ptr %91, i64 %155
  %158 = load i64, ptr %157, align 8
  %159 = shl nuw nsw i64 %155, 3
  %gep6.5 = getelementptr i64, ptr %invariant.gep5.5, i64 %159
  %160 = load i64, ptr %gep6.5, align 8
  %161 = mul i64 %160, %158
  %162 = add i64 %156, %161
  store i64 %162, ptr %153, align 8
  %163 = add nuw nsw i64 %155, 1
  %164 = icmp ult i64 %155, 149
  br i1 %164, label %154, label %.preheader.6

.preheader.6:                                     ; preds = %154
  %165 = getelementptr i64, ptr %93, i64 6
  %.promoted7.6 = load i64, ptr %165, align 16
  br label %166

166:                                              ; preds = %166, %.preheader.6
  %167 = phi i64 [ 0, %.preheader.6 ], [ %175, %166 ]
  %168 = phi i64 [ %.promoted7.6, %.preheader.6 ], [ %174, %166 ]
  %169 = getelementptr i64, ptr %91, i64 %167
  %170 = load i64, ptr %169, align 8
  %171 = shl nuw nsw i64 %167, 3
  %gep6.6 = getelementptr i64, ptr %invariant.gep5.6, i64 %171
  %172 = load i64, ptr %gep6.6, align 16
  %173 = mul i64 %172, %170
  %174 = add i64 %168, %173
  store i64 %174, ptr %165, align 16
  %175 = add nuw nsw i64 %167, 1
  %176 = icmp ult i64 %167, 149
  br i1 %176, label %166, label %.preheader.7

.preheader.7:                                     ; preds = %166
  %177 = getelementptr i64, ptr %93, i64 7
  %.promoted7.7 = load i64, ptr %177, align 8
  br label %178

178:                                              ; preds = %178, %.preheader.7
  %179 = phi i64 [ 0, %.preheader.7 ], [ %187, %178 ]
  %180 = phi i64 [ %.promoted7.7, %.preheader.7 ], [ %186, %178 ]
  %181 = getelementptr i64, ptr %91, i64 %179
  %182 = load i64, ptr %181, align 8
  %183 = shl nuw nsw i64 %179, 3
  %gep6.7 = getelementptr i64, ptr %invariant.gep5.7, i64 %183
  %184 = load i64, ptr %gep6.7, align 8
  %185 = mul i64 %184, %182
  %186 = add i64 %180, %185
  store i64 %186, ptr %177, align 8
  %187 = add nuw nsw i64 %179, 1
  %188 = icmp ult i64 %179, 149
  br i1 %188, label %178, label %189

189:                                              ; preds = %178
  %190 = add nuw nsw i64 %89, 1
  %191 = icmp ult i64 %89, 99
  br i1 %191, label %.preheader2, label %192

192:                                              ; preds = %189
  %193 = tail call i64 @clock()
  %194 = sub i64 %193, %1
  %195 = uitofp i64 %194 to double
  %196 = fdiv double %195, 1.000000e+04
  %197 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %194, double %196)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
