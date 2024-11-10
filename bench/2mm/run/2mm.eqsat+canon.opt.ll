; ModuleID = 'bench/2mm/run/2mm.eqsat+canon.ll'
source_filename = "LLVMDialectModule"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

declare void @displayTime(i64, i64) local_unnamed_addr

declare void @printI64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64) local_unnamed_addr

; Function Attrs: nofree nounwind
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr nocapture readnone %0, ptr nocapture readnone %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #1 {
  %8 = shl i64 %3, 3
  %.idx = mul i64 %8, %4
  %9 = add i64 %.idx, 64
  %10 = tail call ptr @malloc(i64 %9)
  %11 = ptrtoint ptr %10 to i64
  %12 = add i64 %11, 63
  %13 = and i64 %12, -64
  %14 = inttoptr i64 %13 to ptr
  %15 = icmp sgt i64 %3, 0
  %16 = icmp sgt i64 %4, 0
  %or.cond = and i1 %15, %16
  br i1 %or.cond, label %.preheader9.us, label %._crit_edge10

.preheader9.us:                                   ; preds = %7, %._crit_edge.us
  %17 = phi i64 [ %36, %._crit_edge.us ], [ 0, %7 ]
  %18 = trunc i64 %17 to i32
  %19 = mul i32 %18, 1103515245
  %20 = add i32 %19, 12345
  %21 = mul i64 %17, %4
  %22 = getelementptr double, ptr %14, i64 %21
  br label %23

23:                                               ; preds = %.preheader9.us, %23
  %24 = phi i64 [ 0, %.preheader9.us ], [ %34, %23 ]
  %25 = trunc i64 %24 to i32
  %26 = add i32 %20, %25
  %27 = mul i32 %26, 1103515245
  %28 = add i32 %27, 12345
  %29 = sitofp i32 %28 to double
  %30 = fadd double %29, 0x41DFFFFFFFC00000
  %31 = fmul double %30, 0x3E33FFFFFABBF5C5
  %32 = fadd double %31, -1.000000e+01
  %33 = getelementptr double, ptr %22, i64 %24
  store double %32, ptr %33, align 8
  %34 = add nuw nsw i64 %24, 1
  %35 = icmp slt i64 %34, %4
  br i1 %35, label %23, label %._crit_edge.us

._crit_edge.us:                                   ; preds = %23
  %36 = add nuw nsw i64 %17, 1
  %37 = icmp slt i64 %36, %3
  br i1 %37, label %.preheader9.us, label %.preheader8

.preheader8:                                      ; preds = %._crit_edge.us
  %38 = icmp sgt i64 %4, 0
  %or.cond18 = and i1 %15, %38
  br i1 %or.cond18, label %.preheader7.us, label %._crit_edge10

.preheader7.us:                                   ; preds = %.preheader8, %._crit_edge.us11
  %39 = phi i64 [ %49, %._crit_edge.us11 ], [ 0, %.preheader8 ]
  %40 = mul i64 %39, %4
  %41 = getelementptr double, ptr %14, i64 %40
  br label %42

42:                                               ; preds = %.preheader7.us, %42
  %43 = phi i64 [ 0, %.preheader7.us ], [ %47, %42 ]
  %44 = getelementptr double, ptr %41, i64 %43
  %45 = load double, ptr %44, align 8
  %46 = tail call double @llvm.floor.f64(double %45)
  store double %46, ptr %44, align 8
  %47 = add nuw nsw i64 %43, 1
  %48 = icmp slt i64 %47, %4
  br i1 %48, label %42, label %._crit_edge.us11

._crit_edge.us11:                                 ; preds = %42
  %49 = add nuw nsw i64 %39, 1
  %50 = icmp slt i64 %49, %3
  br i1 %50, label %.preheader7.us, label %._crit_edge10

._crit_edge10:                                    ; preds = %._crit_edge.us11, %7, %.preheader8
  %51 = tail call ptr @malloc(i64 %9)
  %52 = ptrtoint ptr %51 to i64
  %53 = add i64 %52, 63
  %54 = and i64 %53, -64
  %55 = inttoptr i64 %54 to ptr
  %56 = icmp sgt i64 %4, 0
  %or.cond19 = and i1 %15, %56
  br i1 %or.cond19, label %.preheader.us, label %._crit_edge12

.preheader.us:                                    ; preds = %._crit_edge10, %._crit_edge.us13
  %57 = phi i64 [ %68, %._crit_edge.us13 ], [ 0, %._crit_edge10 ]
  %58 = mul i64 %57, %4
  br label %59

59:                                               ; preds = %.preheader.us, %59
  %60 = phi i64 [ 0, %.preheader.us ], [ %66, %59 ]
  %61 = add i64 %60, %58
  %62 = getelementptr double, ptr %14, i64 %61
  %63 = load double, ptr %62, align 8
  %64 = fptosi double %63 to i64
  %65 = getelementptr i64, ptr %55, i64 %61
  store i64 %64, ptr %65, align 8
  %66 = add nuw nsw i64 %60, 1
  %67 = icmp slt i64 %66, %4
  br i1 %67, label %59, label %._crit_edge.us13

._crit_edge.us13:                                 ; preds = %59
  %68 = add nuw nsw i64 %57, 1
  %69 = icmp slt i64 %68, %3
  br i1 %69, label %.preheader.us, label %._crit_edge12

._crit_edge12:                                    ; preds = %._crit_edge.us13, %._crit_edge10
  %70 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %51, 0
  %71 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %70, ptr %55, 1
  %72 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %71, i64 0, 2
  %73 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %72, i64 %3, 3, 0
  %74 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %73, i64 %4, 3, 1
  %75 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %74, i64 %4, 4, 0
  %76 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %75, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %76
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 100, i64 10, i64 poison, i64 poison)
  %2 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 10, i64 150, i64 poison, i64 poison)
  %3 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 150, i64 8, i64 poison, i64 poison)
  %4 = tail call i64 @clock()
  %5 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 1
  %6 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 2
  %7 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 4, 0
  %8 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 4, 1
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 1
  %10 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 2
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 4, 0
  %12 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 4, 1
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 1
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 2
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 4, 0
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 4, 1
  %17 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @_2mm(ptr poison, ptr %5, i64 %6, i64 poison, i64 poison, i64 %7, i64 %8, ptr poison, ptr %9, i64 %10, i64 poison, i64 poison, i64 %11, i64 %12, ptr poison, ptr %13, i64 %14, i64 poison, i64 poison, i64 %15, i64 %16)
  %18 = tail call i64 @clock()
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 0
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 2
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 3, 0
  %23 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 3, 1
  %24 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 4, 0
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 4, 1
  tail call void @printI64Tensor2D(ptr %19, ptr %20, i64 %21, i64 %22, i64 %23, i64 %24, i64 %25)
  tail call void @printNewline()
  tail call void @displayTime(i64 %4, i64 %18)
  ret i32 0
}

; Function Attrs: nofree nounwind
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @_2mm(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr nocapture readnone %7, ptr nocapture readonly %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr nocapture readnone %14, ptr nocapture readonly %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) local_unnamed_addr #1 {
  %22 = tail call dereferenceable_or_null(704) ptr @malloc(i64 704)
  %23 = ptrtoint ptr %22 to i64
  %24 = add i64 %23, 63
  %25 = and i64 %24, -64
  %26 = inttoptr i64 %25 to ptr
  %27 = getelementptr i64, ptr %8, i64 %9
  %28 = getelementptr i64, ptr %15, i64 %16
  %invariant.gep.1 = getelementptr i64, ptr %28, i64 %20
  %29 = shl i64 %20, 1
  %invariant.gep.2 = getelementptr i64, ptr %28, i64 %29
  %30 = mul i64 %20, 3
  %invariant.gep.3 = getelementptr i64, ptr %28, i64 %30
  %31 = shl i64 %20, 2
  %invariant.gep.4 = getelementptr i64, ptr %28, i64 %31
  %32 = mul i64 %20, 5
  %invariant.gep.5 = getelementptr i64, ptr %28, i64 %32
  %33 = mul i64 %20, 6
  %invariant.gep.6 = getelementptr i64, ptr %28, i64 %33
  %34 = mul i64 %20, 7
  %invariant.gep.7 = getelementptr i64, ptr %28, i64 %34
  br label %.preheader4

.preheader4:                                      ; preds = %21, %143
  %35 = phi i64 [ 0, %21 ], [ %144, %143 ]
  %36 = mul i64 %35, %12
  %37 = getelementptr i64, ptr %27, i64 %36
  %38 = shl nuw nsw i64 %35, 3
  %39 = getelementptr i64, ptr %26, i64 %38
  %.promoted = load i64, ptr %39, align 64
  br label %40

40:                                               ; preds = %.preheader4, %40
  %41 = phi i64 [ 0, %.preheader4 ], [ %50, %40 ]
  %42 = phi i64 [ %.promoted, %.preheader4 ], [ %49, %40 ]
  %43 = mul i64 %41, %13
  %44 = getelementptr i64, ptr %37, i64 %43
  %45 = load i64, ptr %44, align 4
  %46 = mul i64 %41, %19
  %gep = getelementptr i64, ptr %28, i64 %46
  %47 = load i64, ptr %gep, align 4
  %48 = mul i64 %47, %45
  %49 = add i64 %42, %48
  store i64 %49, ptr %39, align 64
  %50 = add nuw nsw i64 %41, 1
  %51 = icmp ult i64 %41, 149
  br i1 %51, label %40, label %.preheader3.1

.preheader3.1:                                    ; preds = %40
  %52 = getelementptr i64, ptr %39, i64 1
  %.promoted.1 = load i64, ptr %52, align 8
  br label %53

53:                                               ; preds = %53, %.preheader3.1
  %54 = phi i64 [ 0, %.preheader3.1 ], [ %63, %53 ]
  %55 = phi i64 [ %.promoted.1, %.preheader3.1 ], [ %62, %53 ]
  %56 = mul i64 %54, %13
  %57 = getelementptr i64, ptr %37, i64 %56
  %58 = load i64, ptr %57, align 4
  %59 = mul i64 %54, %19
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %59
  %60 = load i64, ptr %gep.1, align 4
  %61 = mul i64 %60, %58
  %62 = add i64 %55, %61
  store i64 %62, ptr %52, align 8
  %63 = add nuw nsw i64 %54, 1
  %64 = icmp ult i64 %54, 149
  br i1 %64, label %53, label %.preheader3.2

.preheader3.2:                                    ; preds = %53
  %65 = getelementptr i64, ptr %39, i64 2
  %.promoted.2 = load i64, ptr %65, align 16
  br label %66

66:                                               ; preds = %66, %.preheader3.2
  %67 = phi i64 [ 0, %.preheader3.2 ], [ %76, %66 ]
  %68 = phi i64 [ %.promoted.2, %.preheader3.2 ], [ %75, %66 ]
  %69 = mul i64 %67, %13
  %70 = getelementptr i64, ptr %37, i64 %69
  %71 = load i64, ptr %70, align 4
  %72 = mul i64 %67, %19
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %72
  %73 = load i64, ptr %gep.2, align 4
  %74 = mul i64 %73, %71
  %75 = add i64 %68, %74
  store i64 %75, ptr %65, align 16
  %76 = add nuw nsw i64 %67, 1
  %77 = icmp ult i64 %67, 149
  br i1 %77, label %66, label %.preheader3.3

.preheader3.3:                                    ; preds = %66
  %78 = getelementptr i64, ptr %39, i64 3
  %.promoted.3 = load i64, ptr %78, align 8
  br label %79

79:                                               ; preds = %79, %.preheader3.3
  %80 = phi i64 [ 0, %.preheader3.3 ], [ %89, %79 ]
  %81 = phi i64 [ %.promoted.3, %.preheader3.3 ], [ %88, %79 ]
  %82 = mul i64 %80, %13
  %83 = getelementptr i64, ptr %37, i64 %82
  %84 = load i64, ptr %83, align 4
  %85 = mul i64 %80, %19
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %85
  %86 = load i64, ptr %gep.3, align 4
  %87 = mul i64 %86, %84
  %88 = add i64 %81, %87
  store i64 %88, ptr %78, align 8
  %89 = add nuw nsw i64 %80, 1
  %90 = icmp ult i64 %80, 149
  br i1 %90, label %79, label %.preheader3.4

.preheader3.4:                                    ; preds = %79
  %91 = getelementptr i64, ptr %39, i64 4
  %.promoted.4 = load i64, ptr %91, align 32
  br label %92

92:                                               ; preds = %92, %.preheader3.4
  %93 = phi i64 [ 0, %.preheader3.4 ], [ %102, %92 ]
  %94 = phi i64 [ %.promoted.4, %.preheader3.4 ], [ %101, %92 ]
  %95 = mul i64 %93, %13
  %96 = getelementptr i64, ptr %37, i64 %95
  %97 = load i64, ptr %96, align 4
  %98 = mul i64 %93, %19
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %98
  %99 = load i64, ptr %gep.4, align 4
  %100 = mul i64 %99, %97
  %101 = add i64 %94, %100
  store i64 %101, ptr %91, align 32
  %102 = add nuw nsw i64 %93, 1
  %103 = icmp ult i64 %93, 149
  br i1 %103, label %92, label %.preheader3.5

.preheader3.5:                                    ; preds = %92
  %104 = getelementptr i64, ptr %39, i64 5
  %.promoted.5 = load i64, ptr %104, align 8
  br label %105

105:                                              ; preds = %105, %.preheader3.5
  %106 = phi i64 [ 0, %.preheader3.5 ], [ %115, %105 ]
  %107 = phi i64 [ %.promoted.5, %.preheader3.5 ], [ %114, %105 ]
  %108 = mul i64 %106, %13
  %109 = getelementptr i64, ptr %37, i64 %108
  %110 = load i64, ptr %109, align 4
  %111 = mul i64 %106, %19
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %111
  %112 = load i64, ptr %gep.5, align 4
  %113 = mul i64 %112, %110
  %114 = add i64 %107, %113
  store i64 %114, ptr %104, align 8
  %115 = add nuw nsw i64 %106, 1
  %116 = icmp ult i64 %106, 149
  br i1 %116, label %105, label %.preheader3.6

.preheader3.6:                                    ; preds = %105
  %117 = getelementptr i64, ptr %39, i64 6
  %.promoted.6 = load i64, ptr %117, align 16
  br label %118

118:                                              ; preds = %118, %.preheader3.6
  %119 = phi i64 [ 0, %.preheader3.6 ], [ %128, %118 ]
  %120 = phi i64 [ %.promoted.6, %.preheader3.6 ], [ %127, %118 ]
  %121 = mul i64 %119, %13
  %122 = getelementptr i64, ptr %37, i64 %121
  %123 = load i64, ptr %122, align 4
  %124 = mul i64 %119, %19
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %124
  %125 = load i64, ptr %gep.6, align 4
  %126 = mul i64 %125, %123
  %127 = add i64 %120, %126
  store i64 %127, ptr %117, align 16
  %128 = add nuw nsw i64 %119, 1
  %129 = icmp ult i64 %119, 149
  br i1 %129, label %118, label %.preheader3.7

.preheader3.7:                                    ; preds = %118
  %130 = getelementptr i64, ptr %39, i64 7
  %.promoted.7 = load i64, ptr %130, align 8
  br label %131

131:                                              ; preds = %131, %.preheader3.7
  %132 = phi i64 [ 0, %.preheader3.7 ], [ %141, %131 ]
  %133 = phi i64 [ %.promoted.7, %.preheader3.7 ], [ %140, %131 ]
  %134 = mul i64 %132, %13
  %135 = getelementptr i64, ptr %37, i64 %134
  %136 = load i64, ptr %135, align 4
  %137 = mul i64 %132, %19
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %137
  %138 = load i64, ptr %gep.7, align 4
  %139 = mul i64 %138, %136
  %140 = add i64 %133, %139
  store i64 %140, ptr %130, align 8
  %141 = add nuw nsw i64 %132, 1
  %142 = icmp ult i64 %132, 149
  br i1 %142, label %131, label %143

143:                                              ; preds = %131
  %144 = add nuw nsw i64 %35, 1
  %145 = icmp ult i64 %35, 9
  br i1 %145, label %.preheader4, label %146

146:                                              ; preds = %143
  %147 = tail call dereferenceable_or_null(6464) ptr @malloc(i64 6464)
  %148 = ptrtoint ptr %147 to i64
  %149 = add i64 %148, 63
  %150 = and i64 %149, -64
  %151 = inttoptr i64 %150 to ptr
  %152 = getelementptr i64, ptr %1, i64 %2
  %153 = shl i64 %6, 1
  %154 = mul i64 %6, 3
  %155 = shl i64 %6, 2
  %156 = mul i64 %6, 5
  %157 = mul i64 %6, 6
  %158 = mul i64 %6, 7
  %159 = shl i64 %6, 3
  %160 = mul i64 %6, 9
  br label %.preheader2

.preheader2:                                      ; preds = %146, %219
  %161 = phi i64 [ 0, %146 ], [ %220, %219 ]
  %162 = mul i64 %161, %5
  %163 = getelementptr i64, ptr %152, i64 %162
  %164 = shl nuw nsw i64 %161, 3
  %165 = getelementptr i64, ptr %151, i64 %164
  %166 = getelementptr i64, ptr %163, i64 %6
  %167 = getelementptr i64, ptr %163, i64 %153
  %168 = getelementptr i64, ptr %163, i64 %154
  %169 = getelementptr i64, ptr %163, i64 %155
  %170 = getelementptr i64, ptr %163, i64 %156
  %171 = getelementptr i64, ptr %163, i64 %157
  %172 = getelementptr i64, ptr %163, i64 %158
  %173 = getelementptr i64, ptr %163, i64 %159
  %174 = getelementptr i64, ptr %163, i64 %160
  br label %.preheader

.preheader:                                       ; preds = %.preheader2, %.preheader
  %175 = phi i64 [ 0, %.preheader2 ], [ %217, %.preheader ]
  %invariant.gep5 = getelementptr i64, ptr %26, i64 %175
  %176 = getelementptr i64, ptr %165, i64 %175
  %.promoted7 = load i64, ptr %176, align 8
  %177 = load i64, ptr %163, align 4
  %178 = load i64, ptr %invariant.gep5, align 8
  %179 = mul i64 %178, %177
  %180 = add i64 %.promoted7, %179
  store i64 %180, ptr %176, align 8
  %181 = load i64, ptr %166, align 4
  %gep6.1 = getelementptr i64, ptr %invariant.gep5, i64 8
  %182 = load i64, ptr %gep6.1, align 8
  %183 = mul i64 %182, %181
  %184 = add i64 %180, %183
  store i64 %184, ptr %176, align 8
  %185 = load i64, ptr %167, align 4
  %gep6.2 = getelementptr i64, ptr %invariant.gep5, i64 16
  %186 = load i64, ptr %gep6.2, align 8
  %187 = mul i64 %186, %185
  %188 = add i64 %184, %187
  store i64 %188, ptr %176, align 8
  %189 = load i64, ptr %168, align 4
  %gep6.3 = getelementptr i64, ptr %invariant.gep5, i64 24
  %190 = load i64, ptr %gep6.3, align 8
  %191 = mul i64 %190, %189
  %192 = add i64 %188, %191
  store i64 %192, ptr %176, align 8
  %193 = load i64, ptr %169, align 4
  %gep6.4 = getelementptr i64, ptr %invariant.gep5, i64 32
  %194 = load i64, ptr %gep6.4, align 8
  %195 = mul i64 %194, %193
  %196 = add i64 %192, %195
  store i64 %196, ptr %176, align 8
  %197 = load i64, ptr %170, align 4
  %gep6.5 = getelementptr i64, ptr %invariant.gep5, i64 40
  %198 = load i64, ptr %gep6.5, align 8
  %199 = mul i64 %198, %197
  %200 = add i64 %196, %199
  store i64 %200, ptr %176, align 8
  %201 = load i64, ptr %171, align 4
  %gep6.6 = getelementptr i64, ptr %invariant.gep5, i64 48
  %202 = load i64, ptr %gep6.6, align 8
  %203 = mul i64 %202, %201
  %204 = add i64 %200, %203
  store i64 %204, ptr %176, align 8
  %205 = load i64, ptr %172, align 4
  %gep6.7 = getelementptr i64, ptr %invariant.gep5, i64 56
  %206 = load i64, ptr %gep6.7, align 8
  %207 = mul i64 %206, %205
  %208 = add i64 %204, %207
  store i64 %208, ptr %176, align 8
  %209 = load i64, ptr %173, align 4
  %gep6.8 = getelementptr i64, ptr %invariant.gep5, i64 64
  %210 = load i64, ptr %gep6.8, align 8
  %211 = mul i64 %210, %209
  %212 = add i64 %208, %211
  store i64 %212, ptr %176, align 8
  %213 = load i64, ptr %174, align 4
  %gep6.9 = getelementptr i64, ptr %invariant.gep5, i64 72
  %214 = load i64, ptr %gep6.9, align 8
  %215 = mul i64 %214, %213
  %216 = add i64 %212, %215
  store i64 %216, ptr %176, align 8
  %217 = add nuw nsw i64 %175, 1
  %218 = icmp ult i64 %175, 7
  br i1 %218, label %.preheader, label %219

219:                                              ; preds = %.preheader
  %220 = add nuw nsw i64 %161, 1
  %221 = icmp ult i64 %161, 99
  br i1 %221, label %.preheader2, label %222

222:                                              ; preds = %219
  %223 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %147, 0
  %224 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %223, ptr %151, 1
  %225 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %224, i64 0, 2
  %226 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %225, i64 100, 3, 0
  %227 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %226, i64 8, 3, 1
  %228 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %227, i64 8, 4, 0
  %229 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %228, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %229
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #2

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
