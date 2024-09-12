; ModuleID = 'bench/run/linalg_assoc.cpp.ll'
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
  %6 = tail call dereferenceable_or_null(12064) ptr @malloc(i64 12064)
  %7 = ptrtoint ptr %6 to i64
  %8 = add i64 %7, 63
  %9 = and i64 %8, -64
  %10 = inttoptr i64 %9 to ptr
  %11 = tail call dereferenceable_or_null(9664) ptr @malloc(i64 9664)
  %12 = ptrtoint ptr %11 to i64
  %13 = add i64 %12, 63
  %14 = and i64 %13, -64
  %15 = inttoptr i64 %14 to ptr
  %16 = tail call dereferenceable_or_null(704) ptr @malloc(i64 704)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = and i64 %18, -64
  %20 = inttoptr i64 %19 to ptr
  %invariant.gep.1 = getelementptr i64, ptr %15, i64 1
  %invariant.gep.2 = getelementptr i64, ptr %15, i64 2
  %invariant.gep.3 = getelementptr i64, ptr %15, i64 3
  %invariant.gep.4 = getelementptr i64, ptr %15, i64 4
  %invariant.gep.5 = getelementptr i64, ptr %15, i64 5
  %invariant.gep.6 = getelementptr i64, ptr %15, i64 6
  %invariant.gep.7 = getelementptr i64, ptr %15, i64 7
  br label %.preheader4

.preheader4:                                      ; preds = %0, %121
  %21 = phi i64 [ 0, %0 ], [ %122, %121 ]
  %22 = mul nuw nsw i64 %21, 150
  %23 = getelementptr i64, ptr %10, i64 %22
  %24 = shl nuw nsw i64 %21, 3
  %25 = getelementptr i64, ptr %20, i64 %24
  %.promoted = load i64, ptr %25, align 64
  br label %26

26:                                               ; preds = %.preheader4, %26
  %27 = phi i64 [ 0, %.preheader4 ], [ %35, %26 ]
  %28 = phi i64 [ %.promoted, %.preheader4 ], [ %34, %26 ]
  %29 = getelementptr i64, ptr %23, i64 %27
  %30 = load i64, ptr %29, align 8
  %31 = shl nuw nsw i64 %27, 3
  %gep = getelementptr i64, ptr %15, i64 %31
  %32 = load i64, ptr %gep, align 64
  %33 = mul i64 %32, %30
  %34 = add i64 %28, %33
  store i64 %34, ptr %25, align 64
  %35 = add nuw nsw i64 %27, 1
  %36 = icmp ult i64 %27, 149
  br i1 %36, label %26, label %.preheader3.1

.preheader3.1:                                    ; preds = %26
  %37 = getelementptr i64, ptr %25, i64 1
  %.promoted.1 = load i64, ptr %37, align 8
  br label %38

38:                                               ; preds = %38, %.preheader3.1
  %39 = phi i64 [ 0, %.preheader3.1 ], [ %47, %38 ]
  %40 = phi i64 [ %.promoted.1, %.preheader3.1 ], [ %46, %38 ]
  %41 = getelementptr i64, ptr %23, i64 %39
  %42 = load i64, ptr %41, align 8
  %43 = shl nuw nsw i64 %39, 3
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %43
  %44 = load i64, ptr %gep.1, align 8
  %45 = mul i64 %44, %42
  %46 = add i64 %40, %45
  store i64 %46, ptr %37, align 8
  %47 = add nuw nsw i64 %39, 1
  %48 = icmp ult i64 %39, 149
  br i1 %48, label %38, label %.preheader3.2

.preheader3.2:                                    ; preds = %38
  %49 = getelementptr i64, ptr %25, i64 2
  %.promoted.2 = load i64, ptr %49, align 16
  br label %50

50:                                               ; preds = %50, %.preheader3.2
  %51 = phi i64 [ 0, %.preheader3.2 ], [ %59, %50 ]
  %52 = phi i64 [ %.promoted.2, %.preheader3.2 ], [ %58, %50 ]
  %53 = getelementptr i64, ptr %23, i64 %51
  %54 = load i64, ptr %53, align 8
  %55 = shl nuw nsw i64 %51, 3
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %55
  %56 = load i64, ptr %gep.2, align 16
  %57 = mul i64 %56, %54
  %58 = add i64 %52, %57
  store i64 %58, ptr %49, align 16
  %59 = add nuw nsw i64 %51, 1
  %60 = icmp ult i64 %51, 149
  br i1 %60, label %50, label %.preheader3.3

.preheader3.3:                                    ; preds = %50
  %61 = getelementptr i64, ptr %25, i64 3
  %.promoted.3 = load i64, ptr %61, align 8
  br label %62

62:                                               ; preds = %62, %.preheader3.3
  %63 = phi i64 [ 0, %.preheader3.3 ], [ %71, %62 ]
  %64 = phi i64 [ %.promoted.3, %.preheader3.3 ], [ %70, %62 ]
  %65 = getelementptr i64, ptr %23, i64 %63
  %66 = load i64, ptr %65, align 8
  %67 = shl nuw nsw i64 %63, 3
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %67
  %68 = load i64, ptr %gep.3, align 8
  %69 = mul i64 %68, %66
  %70 = add i64 %64, %69
  store i64 %70, ptr %61, align 8
  %71 = add nuw nsw i64 %63, 1
  %72 = icmp ult i64 %63, 149
  br i1 %72, label %62, label %.preheader3.4

.preheader3.4:                                    ; preds = %62
  %73 = getelementptr i64, ptr %25, i64 4
  %.promoted.4 = load i64, ptr %73, align 32
  br label %74

74:                                               ; preds = %74, %.preheader3.4
  %75 = phi i64 [ 0, %.preheader3.4 ], [ %83, %74 ]
  %76 = phi i64 [ %.promoted.4, %.preheader3.4 ], [ %82, %74 ]
  %77 = getelementptr i64, ptr %23, i64 %75
  %78 = load i64, ptr %77, align 8
  %79 = shl nuw nsw i64 %75, 3
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %79
  %80 = load i64, ptr %gep.4, align 32
  %81 = mul i64 %80, %78
  %82 = add i64 %76, %81
  store i64 %82, ptr %73, align 32
  %83 = add nuw nsw i64 %75, 1
  %84 = icmp ult i64 %75, 149
  br i1 %84, label %74, label %.preheader3.5

.preheader3.5:                                    ; preds = %74
  %85 = getelementptr i64, ptr %25, i64 5
  %.promoted.5 = load i64, ptr %85, align 8
  br label %86

86:                                               ; preds = %86, %.preheader3.5
  %87 = phi i64 [ 0, %.preheader3.5 ], [ %95, %86 ]
  %88 = phi i64 [ %.promoted.5, %.preheader3.5 ], [ %94, %86 ]
  %89 = getelementptr i64, ptr %23, i64 %87
  %90 = load i64, ptr %89, align 8
  %91 = shl nuw nsw i64 %87, 3
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %91
  %92 = load i64, ptr %gep.5, align 8
  %93 = mul i64 %92, %90
  %94 = add i64 %88, %93
  store i64 %94, ptr %85, align 8
  %95 = add nuw nsw i64 %87, 1
  %96 = icmp ult i64 %87, 149
  br i1 %96, label %86, label %.preheader3.6

.preheader3.6:                                    ; preds = %86
  %97 = getelementptr i64, ptr %25, i64 6
  %.promoted.6 = load i64, ptr %97, align 16
  br label %98

98:                                               ; preds = %98, %.preheader3.6
  %99 = phi i64 [ 0, %.preheader3.6 ], [ %107, %98 ]
  %100 = phi i64 [ %.promoted.6, %.preheader3.6 ], [ %106, %98 ]
  %101 = getelementptr i64, ptr %23, i64 %99
  %102 = load i64, ptr %101, align 8
  %103 = shl nuw nsw i64 %99, 3
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %103
  %104 = load i64, ptr %gep.6, align 16
  %105 = mul i64 %104, %102
  %106 = add i64 %100, %105
  store i64 %106, ptr %97, align 16
  %107 = add nuw nsw i64 %99, 1
  %108 = icmp ult i64 %99, 149
  br i1 %108, label %98, label %.preheader3.7

.preheader3.7:                                    ; preds = %98
  %109 = getelementptr i64, ptr %25, i64 7
  %.promoted.7 = load i64, ptr %109, align 8
  br label %110

110:                                              ; preds = %110, %.preheader3.7
  %111 = phi i64 [ 0, %.preheader3.7 ], [ %119, %110 ]
  %112 = phi i64 [ %.promoted.7, %.preheader3.7 ], [ %118, %110 ]
  %113 = getelementptr i64, ptr %23, i64 %111
  %114 = load i64, ptr %113, align 8
  %115 = shl nuw nsw i64 %111, 3
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %115
  %116 = load i64, ptr %gep.7, align 8
  %117 = mul i64 %116, %114
  %118 = add i64 %112, %117
  store i64 %118, ptr %109, align 8
  %119 = add nuw nsw i64 %111, 1
  %120 = icmp ult i64 %111, 149
  br i1 %120, label %110, label %121

121:                                              ; preds = %110
  %122 = add nuw nsw i64 %21, 1
  %123 = icmp ult i64 %21, 9
  br i1 %123, label %.preheader4, label %124

124:                                              ; preds = %121
  %125 = inttoptr i64 %5 to ptr
  %126 = tail call dereferenceable_or_null(6464) ptr @malloc(i64 6464)
  %127 = ptrtoint ptr %126 to i64
  %128 = add i64 %127, 63
  %129 = and i64 %128, -64
  %130 = inttoptr i64 %129 to ptr
  br label %.preheader2

.preheader2:                                      ; preds = %124, %189
  %131 = phi i64 [ 0, %124 ], [ %190, %189 ]
  %132 = mul nuw nsw i64 %131, 10
  %133 = getelementptr i64, ptr %125, i64 %132
  %134 = shl nuw nsw i64 %131, 3
  %135 = getelementptr i64, ptr %130, i64 %134
  %136 = getelementptr i64, ptr %133, i64 1
  %137 = getelementptr i64, ptr %133, i64 2
  %138 = getelementptr i64, ptr %133, i64 3
  %139 = getelementptr i64, ptr %133, i64 4
  %140 = getelementptr i64, ptr %133, i64 5
  %141 = getelementptr i64, ptr %133, i64 6
  %142 = getelementptr i64, ptr %133, i64 7
  %143 = getelementptr i64, ptr %133, i64 8
  %144 = getelementptr i64, ptr %133, i64 9
  br label %.preheader

.preheader:                                       ; preds = %.preheader2, %.preheader
  %145 = phi i64 [ 0, %.preheader2 ], [ %187, %.preheader ]
  %invariant.gep5 = getelementptr i64, ptr %20, i64 %145
  %146 = getelementptr i64, ptr %135, i64 %145
  %.promoted7 = load i64, ptr %146, align 8
  %147 = load i64, ptr %133, align 16
  %148 = load i64, ptr %invariant.gep5, align 8
  %149 = mul i64 %148, %147
  %150 = add i64 %.promoted7, %149
  store i64 %150, ptr %146, align 8
  %151 = load i64, ptr %136, align 8
  %gep6.1 = getelementptr i64, ptr %invariant.gep5, i64 8
  %152 = load i64, ptr %gep6.1, align 8
  %153 = mul i64 %152, %151
  %154 = add i64 %150, %153
  store i64 %154, ptr %146, align 8
  %155 = load i64, ptr %137, align 16
  %gep6.2 = getelementptr i64, ptr %invariant.gep5, i64 16
  %156 = load i64, ptr %gep6.2, align 8
  %157 = mul i64 %156, %155
  %158 = add i64 %154, %157
  store i64 %158, ptr %146, align 8
  %159 = load i64, ptr %138, align 8
  %gep6.3 = getelementptr i64, ptr %invariant.gep5, i64 24
  %160 = load i64, ptr %gep6.3, align 8
  %161 = mul i64 %160, %159
  %162 = add i64 %158, %161
  store i64 %162, ptr %146, align 8
  %163 = load i64, ptr %139, align 16
  %gep6.4 = getelementptr i64, ptr %invariant.gep5, i64 32
  %164 = load i64, ptr %gep6.4, align 8
  %165 = mul i64 %164, %163
  %166 = add i64 %162, %165
  store i64 %166, ptr %146, align 8
  %167 = load i64, ptr %140, align 8
  %gep6.5 = getelementptr i64, ptr %invariant.gep5, i64 40
  %168 = load i64, ptr %gep6.5, align 8
  %169 = mul i64 %168, %167
  %170 = add i64 %166, %169
  store i64 %170, ptr %146, align 8
  %171 = load i64, ptr %141, align 16
  %gep6.6 = getelementptr i64, ptr %invariant.gep5, i64 48
  %172 = load i64, ptr %gep6.6, align 8
  %173 = mul i64 %172, %171
  %174 = add i64 %170, %173
  store i64 %174, ptr %146, align 8
  %175 = load i64, ptr %142, align 8
  %gep6.7 = getelementptr i64, ptr %invariant.gep5, i64 56
  %176 = load i64, ptr %gep6.7, align 8
  %177 = mul i64 %176, %175
  %178 = add i64 %174, %177
  store i64 %178, ptr %146, align 8
  %179 = load i64, ptr %143, align 16
  %gep6.8 = getelementptr i64, ptr %invariant.gep5, i64 64
  %180 = load i64, ptr %gep6.8, align 8
  %181 = mul i64 %180, %179
  %182 = add i64 %178, %181
  store i64 %182, ptr %146, align 8
  %183 = load i64, ptr %144, align 8
  %gep6.9 = getelementptr i64, ptr %invariant.gep5, i64 72
  %184 = load i64, ptr %gep6.9, align 8
  %185 = mul i64 %184, %183
  %186 = add i64 %182, %185
  store i64 %186, ptr %146, align 8
  %187 = add nuw nsw i64 %145, 1
  %188 = icmp ult i64 %145, 7
  br i1 %188, label %.preheader, label %189

189:                                              ; preds = %.preheader
  %190 = add nuw nsw i64 %131, 1
  %191 = icmp ult i64 %131, 99
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
