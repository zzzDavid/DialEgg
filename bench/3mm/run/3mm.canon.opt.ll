; ModuleID = 'bench/3mm/run/3mm.canon.ll'
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
  %1 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 200, i64 175, i64 poison, i64 poison)
  %2 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 175, i64 250, i64 poison, i64 poison)
  %3 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 250, i64 150, i64 poison, i64 poison)
  %4 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomI64Tensor2D(ptr poison, ptr poison, i64 poison, i64 150, i64 10, i64 poison, i64 poison)
  %5 = tail call i64 @clock()
  %6 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 1
  %7 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 2
  %8 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 4, 0
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1, 4, 1
  %10 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 1
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 2
  %12 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 4, 0
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2, 4, 1
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 1
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 2
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 4, 0
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, 4, 1
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 1
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 2
  %20 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 0
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 1
  %22 = tail call { ptr, ptr, i64, [2 x i64], [2 x i64] } @_3mm(ptr poison, ptr %6, i64 %7, i64 poison, i64 poison, i64 %8, i64 %9, ptr poison, ptr %10, i64 %11, i64 poison, i64 poison, i64 %12, i64 %13, ptr poison, ptr %14, i64 %15, i64 poison, i64 poison, i64 %16, i64 %17, ptr poison, ptr %18, i64 %19, i64 poison, i64 poison, i64 %20, i64 %21)
  %23 = tail call i64 @clock()
  %24 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 0
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 1
  %26 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 2
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 3, 0
  %28 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 3, 1
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 4, 0
  %30 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, 4, 1
  tail call void @printI64Tensor2D(ptr %24, ptr %25, i64 %26, i64 %27, i64 %28, i64 %29, i64 %30)
  tail call void @printNewline()
  tail call void @displayTime(i64 %5, i64 %23)
  ret i32 0
}

; Function Attrs: nofree nounwind
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @_3mm(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr nocapture readnone %7, ptr nocapture readonly %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr nocapture readnone %14, ptr nocapture readonly %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20, ptr nocapture readnone %21, ptr nocapture readonly %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27) local_unnamed_addr #1 {
  %29 = tail call dereferenceable_or_null(400064) ptr @malloc(i64 400064)
  %30 = ptrtoint ptr %29 to i64
  %31 = add i64 %30, 63
  %32 = and i64 %31, -64
  %33 = inttoptr i64 %32 to ptr
  %34 = getelementptr i64, ptr %1, i64 %2
  %35 = getelementptr i64, ptr %8, i64 %9
  br label %.preheader7

.preheader7:                                      ; preds = %28, %59
  %36 = phi i64 [ 0, %28 ], [ %60, %59 ]
  %37 = mul i64 %36, %5
  %38 = getelementptr i64, ptr %34, i64 %37
  %39 = mul nuw nsw i64 %36, 250
  %40 = getelementptr i64, ptr %33, i64 %39
  br label %.preheader6

.preheader6:                                      ; preds = %.preheader7, %56
  %41 = phi i64 [ 0, %.preheader7 ], [ %57, %56 ]
  %42 = mul i64 %41, %13
  %invariant.gep = getelementptr i64, ptr %35, i64 %42
  %43 = getelementptr i64, ptr %40, i64 %41
  %.promoted = load i64, ptr %43, align 8
  br label %44

44:                                               ; preds = %.preheader6, %44
  %45 = phi i64 [ 0, %.preheader6 ], [ %54, %44 ]
  %46 = phi i64 [ %.promoted, %.preheader6 ], [ %53, %44 ]
  %47 = mul i64 %45, %6
  %48 = getelementptr i64, ptr %38, i64 %47
  %49 = load i64, ptr %48, align 4
  %50 = mul i64 %45, %12
  %gep = getelementptr i64, ptr %invariant.gep, i64 %50
  %51 = load i64, ptr %gep, align 4
  %52 = mul i64 %51, %49
  %53 = add i64 %46, %52
  store i64 %53, ptr %43, align 8
  %54 = add nuw nsw i64 %45, 1
  %55 = icmp ult i64 %45, 174
  br i1 %55, label %44, label %56

56:                                               ; preds = %44
  %57 = add nuw nsw i64 %41, 1
  %58 = icmp ult i64 %41, 249
  br i1 %58, label %.preheader6, label %59

59:                                               ; preds = %56
  %60 = add nuw nsw i64 %36, 1
  %61 = icmp ult i64 %36, 199
  br i1 %61, label %.preheader7, label %62

62:                                               ; preds = %59
  %63 = tail call dereferenceable_or_null(240064) ptr @malloc(i64 240064)
  %64 = ptrtoint ptr %63 to i64
  %65 = add i64 %64, 63
  %66 = and i64 %65, -64
  %67 = inttoptr i64 %66 to ptr
  %68 = getelementptr i64, ptr %15, i64 %16
  br label %.preheader5

.preheader5:                                      ; preds = %62, %91
  %69 = phi i64 [ 0, %62 ], [ %92, %91 ]
  %70 = mul nuw nsw i64 %69, 250
  %71 = getelementptr i64, ptr %33, i64 %70
  %72 = mul nuw nsw i64 %69, 150
  %73 = getelementptr i64, ptr %67, i64 %72
  br label %.preheader4

.preheader4:                                      ; preds = %.preheader5, %88
  %74 = phi i64 [ 0, %.preheader5 ], [ %89, %88 ]
  %75 = mul i64 %74, %20
  %invariant.gep8 = getelementptr i64, ptr %68, i64 %75
  %76 = getelementptr i64, ptr %73, i64 %74
  %.promoted10 = load i64, ptr %76, align 8
  br label %77

77:                                               ; preds = %.preheader4, %77
  %78 = phi i64 [ 0, %.preheader4 ], [ %86, %77 ]
  %79 = phi i64 [ %.promoted10, %.preheader4 ], [ %85, %77 ]
  %80 = getelementptr i64, ptr %71, i64 %78
  %81 = load i64, ptr %80, align 8
  %82 = mul i64 %78, %19
  %gep9 = getelementptr i64, ptr %invariant.gep8, i64 %82
  %83 = load i64, ptr %gep9, align 4
  %84 = mul i64 %83, %81
  %85 = add i64 %79, %84
  store i64 %85, ptr %76, align 8
  %86 = add nuw nsw i64 %78, 1
  %87 = icmp ult i64 %78, 249
  br i1 %87, label %77, label %88

88:                                               ; preds = %77
  %89 = add nuw nsw i64 %74, 1
  %90 = icmp ult i64 %74, 149
  br i1 %90, label %.preheader4, label %91

91:                                               ; preds = %88
  %92 = add nuw nsw i64 %69, 1
  %93 = icmp ult i64 %69, 199
  br i1 %93, label %.preheader5, label %94

94:                                               ; preds = %91
  %95 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %96 = ptrtoint ptr %95 to i64
  %97 = add i64 %96, 63
  %98 = and i64 %97, -64
  %99 = inttoptr i64 %98 to ptr
  %100 = getelementptr i64, ptr %22, i64 %23
  %invariant.gep11.1 = getelementptr i64, ptr %100, i64 %27
  %101 = shl i64 %27, 1
  %invariant.gep11.2 = getelementptr i64, ptr %100, i64 %101
  %102 = mul i64 %27, 3
  %invariant.gep11.3 = getelementptr i64, ptr %100, i64 %102
  %103 = shl i64 %27, 2
  %invariant.gep11.4 = getelementptr i64, ptr %100, i64 %103
  %104 = mul i64 %27, 5
  %invariant.gep11.5 = getelementptr i64, ptr %100, i64 %104
  %105 = mul i64 %27, 6
  %invariant.gep11.6 = getelementptr i64, ptr %100, i64 %105
  %106 = mul i64 %27, 7
  %invariant.gep11.7 = getelementptr i64, ptr %100, i64 %106
  %107 = shl i64 %27, 3
  %invariant.gep11.8 = getelementptr i64, ptr %100, i64 %107
  %108 = mul i64 %27, 9
  %invariant.gep11.9 = getelementptr i64, ptr %100, i64 %108
  br label %.preheader3

.preheader3:                                      ; preds = %94, %233
  %109 = phi i64 [ 0, %94 ], [ %234, %233 ]
  %110 = mul nuw nsw i64 %109, 150
  %111 = getelementptr i64, ptr %67, i64 %110
  %112 = mul nuw nsw i64 %109, 10
  %113 = getelementptr i64, ptr %99, i64 %112
  %.promoted13 = load i64, ptr %113, align 16
  br label %114

114:                                              ; preds = %.preheader3, %114
  %115 = phi i64 [ 0, %.preheader3 ], [ %123, %114 ]
  %116 = phi i64 [ %.promoted13, %.preheader3 ], [ %122, %114 ]
  %117 = getelementptr i64, ptr %111, i64 %115
  %118 = load i64, ptr %117, align 8
  %119 = mul i64 %115, %26
  %gep12 = getelementptr i64, ptr %100, i64 %119
  %120 = load i64, ptr %gep12, align 4
  %121 = mul i64 %120, %118
  %122 = add i64 %116, %121
  store i64 %122, ptr %113, align 16
  %123 = add nuw nsw i64 %115, 1
  %124 = icmp ult i64 %115, 149
  br i1 %124, label %114, label %.preheader.1

.preheader.1:                                     ; preds = %114
  %125 = getelementptr i64, ptr %113, i64 1
  %.promoted13.1 = load i64, ptr %125, align 8
  br label %126

126:                                              ; preds = %126, %.preheader.1
  %127 = phi i64 [ 0, %.preheader.1 ], [ %135, %126 ]
  %128 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %134, %126 ]
  %129 = getelementptr i64, ptr %111, i64 %127
  %130 = load i64, ptr %129, align 8
  %131 = mul i64 %127, %26
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %131
  %132 = load i64, ptr %gep12.1, align 4
  %133 = mul i64 %132, %130
  %134 = add i64 %128, %133
  store i64 %134, ptr %125, align 8
  %135 = add nuw nsw i64 %127, 1
  %136 = icmp ult i64 %127, 149
  br i1 %136, label %126, label %.preheader.2

.preheader.2:                                     ; preds = %126
  %137 = getelementptr i64, ptr %113, i64 2
  %.promoted13.2 = load i64, ptr %137, align 16
  br label %138

138:                                              ; preds = %138, %.preheader.2
  %139 = phi i64 [ 0, %.preheader.2 ], [ %147, %138 ]
  %140 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %146, %138 ]
  %141 = getelementptr i64, ptr %111, i64 %139
  %142 = load i64, ptr %141, align 8
  %143 = mul i64 %139, %26
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %143
  %144 = load i64, ptr %gep12.2, align 4
  %145 = mul i64 %144, %142
  %146 = add i64 %140, %145
  store i64 %146, ptr %137, align 16
  %147 = add nuw nsw i64 %139, 1
  %148 = icmp ult i64 %139, 149
  br i1 %148, label %138, label %.preheader.3

.preheader.3:                                     ; preds = %138
  %149 = getelementptr i64, ptr %113, i64 3
  %.promoted13.3 = load i64, ptr %149, align 8
  br label %150

150:                                              ; preds = %150, %.preheader.3
  %151 = phi i64 [ 0, %.preheader.3 ], [ %159, %150 ]
  %152 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %158, %150 ]
  %153 = getelementptr i64, ptr %111, i64 %151
  %154 = load i64, ptr %153, align 8
  %155 = mul i64 %151, %26
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %155
  %156 = load i64, ptr %gep12.3, align 4
  %157 = mul i64 %156, %154
  %158 = add i64 %152, %157
  store i64 %158, ptr %149, align 8
  %159 = add nuw nsw i64 %151, 1
  %160 = icmp ult i64 %151, 149
  br i1 %160, label %150, label %.preheader.4

.preheader.4:                                     ; preds = %150
  %161 = getelementptr i64, ptr %113, i64 4
  %.promoted13.4 = load i64, ptr %161, align 16
  br label %162

162:                                              ; preds = %162, %.preheader.4
  %163 = phi i64 [ 0, %.preheader.4 ], [ %171, %162 ]
  %164 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %170, %162 ]
  %165 = getelementptr i64, ptr %111, i64 %163
  %166 = load i64, ptr %165, align 8
  %167 = mul i64 %163, %26
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %167
  %168 = load i64, ptr %gep12.4, align 4
  %169 = mul i64 %168, %166
  %170 = add i64 %164, %169
  store i64 %170, ptr %161, align 16
  %171 = add nuw nsw i64 %163, 1
  %172 = icmp ult i64 %163, 149
  br i1 %172, label %162, label %.preheader.5

.preheader.5:                                     ; preds = %162
  %173 = getelementptr i64, ptr %113, i64 5
  %.promoted13.5 = load i64, ptr %173, align 8
  br label %174

174:                                              ; preds = %174, %.preheader.5
  %175 = phi i64 [ 0, %.preheader.5 ], [ %183, %174 ]
  %176 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %182, %174 ]
  %177 = getelementptr i64, ptr %111, i64 %175
  %178 = load i64, ptr %177, align 8
  %179 = mul i64 %175, %26
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %179
  %180 = load i64, ptr %gep12.5, align 4
  %181 = mul i64 %180, %178
  %182 = add i64 %176, %181
  store i64 %182, ptr %173, align 8
  %183 = add nuw nsw i64 %175, 1
  %184 = icmp ult i64 %175, 149
  br i1 %184, label %174, label %.preheader.6

.preheader.6:                                     ; preds = %174
  %185 = getelementptr i64, ptr %113, i64 6
  %.promoted13.6 = load i64, ptr %185, align 16
  br label %186

186:                                              ; preds = %186, %.preheader.6
  %187 = phi i64 [ 0, %.preheader.6 ], [ %195, %186 ]
  %188 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %194, %186 ]
  %189 = getelementptr i64, ptr %111, i64 %187
  %190 = load i64, ptr %189, align 8
  %191 = mul i64 %187, %26
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %191
  %192 = load i64, ptr %gep12.6, align 4
  %193 = mul i64 %192, %190
  %194 = add i64 %188, %193
  store i64 %194, ptr %185, align 16
  %195 = add nuw nsw i64 %187, 1
  %196 = icmp ult i64 %187, 149
  br i1 %196, label %186, label %.preheader.7

.preheader.7:                                     ; preds = %186
  %197 = getelementptr i64, ptr %113, i64 7
  %.promoted13.7 = load i64, ptr %197, align 8
  br label %198

198:                                              ; preds = %198, %.preheader.7
  %199 = phi i64 [ 0, %.preheader.7 ], [ %207, %198 ]
  %200 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %206, %198 ]
  %201 = getelementptr i64, ptr %111, i64 %199
  %202 = load i64, ptr %201, align 8
  %203 = mul i64 %199, %26
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %203
  %204 = load i64, ptr %gep12.7, align 4
  %205 = mul i64 %204, %202
  %206 = add i64 %200, %205
  store i64 %206, ptr %197, align 8
  %207 = add nuw nsw i64 %199, 1
  %208 = icmp ult i64 %199, 149
  br i1 %208, label %198, label %.preheader.8

.preheader.8:                                     ; preds = %198
  %209 = getelementptr i64, ptr %113, i64 8
  %.promoted13.8 = load i64, ptr %209, align 16
  br label %210

210:                                              ; preds = %210, %.preheader.8
  %211 = phi i64 [ 0, %.preheader.8 ], [ %219, %210 ]
  %212 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %218, %210 ]
  %213 = getelementptr i64, ptr %111, i64 %211
  %214 = load i64, ptr %213, align 8
  %215 = mul i64 %211, %26
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %215
  %216 = load i64, ptr %gep12.8, align 4
  %217 = mul i64 %216, %214
  %218 = add i64 %212, %217
  store i64 %218, ptr %209, align 16
  %219 = add nuw nsw i64 %211, 1
  %220 = icmp ult i64 %211, 149
  br i1 %220, label %210, label %.preheader.9

.preheader.9:                                     ; preds = %210
  %221 = getelementptr i64, ptr %113, i64 9
  %.promoted13.9 = load i64, ptr %221, align 8
  br label %222

222:                                              ; preds = %222, %.preheader.9
  %223 = phi i64 [ 0, %.preheader.9 ], [ %231, %222 ]
  %224 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %230, %222 ]
  %225 = getelementptr i64, ptr %111, i64 %223
  %226 = load i64, ptr %225, align 8
  %227 = mul i64 %223, %26
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %227
  %228 = load i64, ptr %gep12.9, align 4
  %229 = mul i64 %228, %226
  %230 = add i64 %224, %229
  store i64 %230, ptr %221, align 8
  %231 = add nuw nsw i64 %223, 1
  %232 = icmp ult i64 %223, 149
  br i1 %232, label %222, label %233

233:                                              ; preds = %222
  %234 = add nuw nsw i64 %109, 1
  %235 = icmp ult i64 %109, 199
  br i1 %235, label %.preheader3, label %236

236:                                              ; preds = %233
  %237 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %95, 0
  %238 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %237, ptr %99, 1
  %239 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %238, i64 0, 2
  %240 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %239, i64 200, 3, 0
  %241 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %240, i64 10, 3, 1
  %242 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %241, i64 10, 4, 0
  %243 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %242, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %243
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #2

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
