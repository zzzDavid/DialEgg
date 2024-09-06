; ModuleID = 'bench/run/linalg_assoc.canon+eqsat.ll'
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
  %16 = tail call dereferenceable_or_null(6464) ptr @malloc(i64 6464)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = and i64 %18, -64
  %20 = tail call dereferenceable_or_null(704) ptr @malloc(i64 704)
  %21 = ptrtoint ptr %20 to i64
  %22 = add i64 %21, 63
  %23 = and i64 %22, -64
  %24 = inttoptr i64 %23 to ptr
  %invariant.gep.1 = getelementptr i64, ptr %15, i64 1
  %invariant.gep.2 = getelementptr i64, ptr %15, i64 2
  %invariant.gep.3 = getelementptr i64, ptr %15, i64 3
  %invariant.gep.4 = getelementptr i64, ptr %15, i64 4
  %invariant.gep.5 = getelementptr i64, ptr %15, i64 5
  %invariant.gep.6 = getelementptr i64, ptr %15, i64 6
  %invariant.gep.7 = getelementptr i64, ptr %15, i64 7
  br label %.preheader5

.preheader5:                                      ; preds = %0, %125
  %25 = phi i64 [ 0, %0 ], [ %126, %125 ]
  %26 = mul nuw nsw i64 %25, 150
  %27 = getelementptr i64, ptr %10, i64 %26
  %28 = shl nuw nsw i64 %25, 3
  %29 = getelementptr i64, ptr %24, i64 %28
  %.promoted = load i64, ptr %29, align 64
  br label %30

30:                                               ; preds = %.preheader5, %30
  %31 = phi i64 [ 0, %.preheader5 ], [ %39, %30 ]
  %32 = phi i64 [ %.promoted, %.preheader5 ], [ %38, %30 ]
  %33 = getelementptr i64, ptr %27, i64 %31
  %34 = load i64, ptr %33, align 8
  %35 = shl nuw nsw i64 %31, 3
  %gep = getelementptr i64, ptr %15, i64 %35
  %36 = load i64, ptr %gep, align 64
  %37 = mul i64 %36, %34
  %38 = add i64 %32, %37
  store i64 %38, ptr %29, align 64
  %39 = add nuw nsw i64 %31, 1
  %40 = icmp ult i64 %31, 149
  br i1 %40, label %30, label %.preheader4.1

.preheader4.1:                                    ; preds = %30
  %41 = getelementptr i64, ptr %29, i64 1
  %.promoted.1 = load i64, ptr %41, align 8
  br label %42

42:                                               ; preds = %42, %.preheader4.1
  %43 = phi i64 [ 0, %.preheader4.1 ], [ %51, %42 ]
  %44 = phi i64 [ %.promoted.1, %.preheader4.1 ], [ %50, %42 ]
  %45 = getelementptr i64, ptr %27, i64 %43
  %46 = load i64, ptr %45, align 8
  %47 = shl nuw nsw i64 %43, 3
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %47
  %48 = load i64, ptr %gep.1, align 8
  %49 = mul i64 %48, %46
  %50 = add i64 %44, %49
  store i64 %50, ptr %41, align 8
  %51 = add nuw nsw i64 %43, 1
  %52 = icmp ult i64 %43, 149
  br i1 %52, label %42, label %.preheader4.2

.preheader4.2:                                    ; preds = %42
  %53 = getelementptr i64, ptr %29, i64 2
  %.promoted.2 = load i64, ptr %53, align 16
  br label %54

54:                                               ; preds = %54, %.preheader4.2
  %55 = phi i64 [ 0, %.preheader4.2 ], [ %63, %54 ]
  %56 = phi i64 [ %.promoted.2, %.preheader4.2 ], [ %62, %54 ]
  %57 = getelementptr i64, ptr %27, i64 %55
  %58 = load i64, ptr %57, align 8
  %59 = shl nuw nsw i64 %55, 3
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %59
  %60 = load i64, ptr %gep.2, align 16
  %61 = mul i64 %60, %58
  %62 = add i64 %56, %61
  store i64 %62, ptr %53, align 16
  %63 = add nuw nsw i64 %55, 1
  %64 = icmp ult i64 %55, 149
  br i1 %64, label %54, label %.preheader4.3

.preheader4.3:                                    ; preds = %54
  %65 = getelementptr i64, ptr %29, i64 3
  %.promoted.3 = load i64, ptr %65, align 8
  br label %66

66:                                               ; preds = %66, %.preheader4.3
  %67 = phi i64 [ 0, %.preheader4.3 ], [ %75, %66 ]
  %68 = phi i64 [ %.promoted.3, %.preheader4.3 ], [ %74, %66 ]
  %69 = getelementptr i64, ptr %27, i64 %67
  %70 = load i64, ptr %69, align 8
  %71 = shl nuw nsw i64 %67, 3
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %71
  %72 = load i64, ptr %gep.3, align 8
  %73 = mul i64 %72, %70
  %74 = add i64 %68, %73
  store i64 %74, ptr %65, align 8
  %75 = add nuw nsw i64 %67, 1
  %76 = icmp ult i64 %67, 149
  br i1 %76, label %66, label %.preheader4.4

.preheader4.4:                                    ; preds = %66
  %77 = getelementptr i64, ptr %29, i64 4
  %.promoted.4 = load i64, ptr %77, align 32
  br label %78

78:                                               ; preds = %78, %.preheader4.4
  %79 = phi i64 [ 0, %.preheader4.4 ], [ %87, %78 ]
  %80 = phi i64 [ %.promoted.4, %.preheader4.4 ], [ %86, %78 ]
  %81 = getelementptr i64, ptr %27, i64 %79
  %82 = load i64, ptr %81, align 8
  %83 = shl nuw nsw i64 %79, 3
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %83
  %84 = load i64, ptr %gep.4, align 32
  %85 = mul i64 %84, %82
  %86 = add i64 %80, %85
  store i64 %86, ptr %77, align 32
  %87 = add nuw nsw i64 %79, 1
  %88 = icmp ult i64 %79, 149
  br i1 %88, label %78, label %.preheader4.5

.preheader4.5:                                    ; preds = %78
  %89 = getelementptr i64, ptr %29, i64 5
  %.promoted.5 = load i64, ptr %89, align 8
  br label %90

90:                                               ; preds = %90, %.preheader4.5
  %91 = phi i64 [ 0, %.preheader4.5 ], [ %99, %90 ]
  %92 = phi i64 [ %.promoted.5, %.preheader4.5 ], [ %98, %90 ]
  %93 = getelementptr i64, ptr %27, i64 %91
  %94 = load i64, ptr %93, align 8
  %95 = shl nuw nsw i64 %91, 3
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %95
  %96 = load i64, ptr %gep.5, align 8
  %97 = mul i64 %96, %94
  %98 = add i64 %92, %97
  store i64 %98, ptr %89, align 8
  %99 = add nuw nsw i64 %91, 1
  %100 = icmp ult i64 %91, 149
  br i1 %100, label %90, label %.preheader4.6

.preheader4.6:                                    ; preds = %90
  %101 = getelementptr i64, ptr %29, i64 6
  %.promoted.6 = load i64, ptr %101, align 16
  br label %102

102:                                              ; preds = %102, %.preheader4.6
  %103 = phi i64 [ 0, %.preheader4.6 ], [ %111, %102 ]
  %104 = phi i64 [ %.promoted.6, %.preheader4.6 ], [ %110, %102 ]
  %105 = getelementptr i64, ptr %27, i64 %103
  %106 = load i64, ptr %105, align 8
  %107 = shl nuw nsw i64 %103, 3
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %107
  %108 = load i64, ptr %gep.6, align 16
  %109 = mul i64 %108, %106
  %110 = add i64 %104, %109
  store i64 %110, ptr %101, align 16
  %111 = add nuw nsw i64 %103, 1
  %112 = icmp ult i64 %103, 149
  br i1 %112, label %102, label %.preheader4.7

.preheader4.7:                                    ; preds = %102
  %113 = getelementptr i64, ptr %29, i64 7
  %.promoted.7 = load i64, ptr %113, align 8
  br label %114

114:                                              ; preds = %114, %.preheader4.7
  %115 = phi i64 [ 0, %.preheader4.7 ], [ %123, %114 ]
  %116 = phi i64 [ %.promoted.7, %.preheader4.7 ], [ %122, %114 ]
  %117 = getelementptr i64, ptr %27, i64 %115
  %118 = load i64, ptr %117, align 8
  %119 = shl nuw nsw i64 %115, 3
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %119
  %120 = load i64, ptr %gep.7, align 8
  %121 = mul i64 %120, %118
  %122 = add i64 %116, %121
  store i64 %122, ptr %113, align 8
  %123 = add nuw nsw i64 %115, 1
  %124 = icmp ult i64 %115, 149
  br i1 %124, label %114, label %125

125:                                              ; preds = %114
  %126 = add nuw nsw i64 %25, 1
  %127 = icmp ult i64 %25, 9
  br i1 %127, label %.preheader5, label %.preheader2.preheader

.preheader2.preheader:                            ; preds = %125
  %128 = inttoptr i64 %5 to ptr
  %129 = inttoptr i64 %19 to ptr
  br label %.preheader2

.preheader2:                                      ; preds = %.preheader2.preheader, %188
  %130 = phi i64 [ %189, %188 ], [ 0, %.preheader2.preheader ]
  %131 = mul nuw nsw i64 %130, 10
  %132 = getelementptr i64, ptr %128, i64 %131
  %133 = shl nuw nsw i64 %130, 3
  %134 = getelementptr i64, ptr %129, i64 %133
  %135 = getelementptr i64, ptr %132, i64 1
  %136 = getelementptr i64, ptr %132, i64 2
  %137 = getelementptr i64, ptr %132, i64 3
  %138 = getelementptr i64, ptr %132, i64 4
  %139 = getelementptr i64, ptr %132, i64 5
  %140 = getelementptr i64, ptr %132, i64 6
  %141 = getelementptr i64, ptr %132, i64 7
  %142 = getelementptr i64, ptr %132, i64 8
  %143 = getelementptr i64, ptr %132, i64 9
  br label %.preheader

.preheader:                                       ; preds = %.preheader2, %.preheader
  %144 = phi i64 [ 0, %.preheader2 ], [ %186, %.preheader ]
  %invariant.gep6 = getelementptr i64, ptr %24, i64 %144
  %145 = getelementptr i64, ptr %134, i64 %144
  %.promoted8 = load i64, ptr %145, align 8
  %146 = load i64, ptr %132, align 16
  %147 = load i64, ptr %invariant.gep6, align 8
  %148 = mul i64 %147, %146
  %149 = add i64 %.promoted8, %148
  store i64 %149, ptr %145, align 8
  %150 = load i64, ptr %135, align 8
  %gep7.1 = getelementptr i64, ptr %invariant.gep6, i64 8
  %151 = load i64, ptr %gep7.1, align 8
  %152 = mul i64 %151, %150
  %153 = add i64 %149, %152
  store i64 %153, ptr %145, align 8
  %154 = load i64, ptr %136, align 16
  %gep7.2 = getelementptr i64, ptr %invariant.gep6, i64 16
  %155 = load i64, ptr %gep7.2, align 8
  %156 = mul i64 %155, %154
  %157 = add i64 %153, %156
  store i64 %157, ptr %145, align 8
  %158 = load i64, ptr %137, align 8
  %gep7.3 = getelementptr i64, ptr %invariant.gep6, i64 24
  %159 = load i64, ptr %gep7.3, align 8
  %160 = mul i64 %159, %158
  %161 = add i64 %157, %160
  store i64 %161, ptr %145, align 8
  %162 = load i64, ptr %138, align 16
  %gep7.4 = getelementptr i64, ptr %invariant.gep6, i64 32
  %163 = load i64, ptr %gep7.4, align 8
  %164 = mul i64 %163, %162
  %165 = add i64 %161, %164
  store i64 %165, ptr %145, align 8
  %166 = load i64, ptr %139, align 8
  %gep7.5 = getelementptr i64, ptr %invariant.gep6, i64 40
  %167 = load i64, ptr %gep7.5, align 8
  %168 = mul i64 %167, %166
  %169 = add i64 %165, %168
  store i64 %169, ptr %145, align 8
  %170 = load i64, ptr %140, align 16
  %gep7.6 = getelementptr i64, ptr %invariant.gep6, i64 48
  %171 = load i64, ptr %gep7.6, align 8
  %172 = mul i64 %171, %170
  %173 = add i64 %169, %172
  store i64 %173, ptr %145, align 8
  %174 = load i64, ptr %141, align 8
  %gep7.7 = getelementptr i64, ptr %invariant.gep6, i64 56
  %175 = load i64, ptr %gep7.7, align 8
  %176 = mul i64 %175, %174
  %177 = add i64 %173, %176
  store i64 %177, ptr %145, align 8
  %178 = load i64, ptr %142, align 16
  %gep7.8 = getelementptr i64, ptr %invariant.gep6, i64 64
  %179 = load i64, ptr %gep7.8, align 8
  %180 = mul i64 %179, %178
  %181 = add i64 %177, %180
  store i64 %181, ptr %145, align 8
  %182 = load i64, ptr %143, align 8
  %gep7.9 = getelementptr i64, ptr %invariant.gep6, i64 72
  %183 = load i64, ptr %gep7.9, align 8
  %184 = mul i64 %183, %182
  %185 = add i64 %181, %184
  store i64 %185, ptr %145, align 8
  %186 = add nuw nsw i64 %144, 1
  %187 = icmp ult i64 %144, 7
  br i1 %187, label %.preheader, label %188

188:                                              ; preds = %.preheader
  %189 = add nuw nsw i64 %130, 1
  %190 = icmp ult i64 %130, 99
  br i1 %190, label %.preheader2, label %191

191:                                              ; preds = %188
  %192 = tail call i64 @clock()
  %193 = sub i64 %192, %1
  %194 = uitofp i64 %193 to double
  %195 = fdiv double %194, 1.000000e+04
  %196 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %193, double %195)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
