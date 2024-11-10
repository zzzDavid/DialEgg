; ModuleID = 'bench/3mm/run/3mm.eqsat.ll'
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
  %29 = tail call dereferenceable_or_null(20064) ptr @malloc(i64 20064)
  %30 = ptrtoint ptr %29 to i64
  %31 = add i64 %30, 63
  %32 = and i64 %31, -64
  %33 = inttoptr i64 %32 to ptr
  %34 = getelementptr i64, ptr %15, i64 %16
  %35 = getelementptr i64, ptr %22, i64 %23
  %invariant.gep.1 = getelementptr i64, ptr %35, i64 %27
  %36 = shl i64 %27, 1
  %invariant.gep.2 = getelementptr i64, ptr %35, i64 %36
  %37 = mul i64 %27, 3
  %invariant.gep.3 = getelementptr i64, ptr %35, i64 %37
  %38 = shl i64 %27, 2
  %invariant.gep.4 = getelementptr i64, ptr %35, i64 %38
  %39 = mul i64 %27, 5
  %invariant.gep.5 = getelementptr i64, ptr %35, i64 %39
  %40 = mul i64 %27, 6
  %invariant.gep.6 = getelementptr i64, ptr %35, i64 %40
  %41 = mul i64 %27, 7
  %invariant.gep.7 = getelementptr i64, ptr %35, i64 %41
  %42 = shl i64 %27, 3
  %invariant.gep.8 = getelementptr i64, ptr %35, i64 %42
  %43 = mul i64 %27, 9
  %invariant.gep.9 = getelementptr i64, ptr %35, i64 %43
  br label %.preheader7

.preheader7:                                      ; preds = %28, %178
  %44 = phi i64 [ 0, %28 ], [ %179, %178 ]
  %45 = mul i64 %44, %19
  %46 = getelementptr i64, ptr %34, i64 %45
  %47 = mul nuw nsw i64 %44, 10
  %48 = getelementptr i64, ptr %33, i64 %47
  %.promoted = load i64, ptr %48, align 16
  br label %49

49:                                               ; preds = %.preheader7, %49
  %50 = phi i64 [ 0, %.preheader7 ], [ %59, %49 ]
  %51 = phi i64 [ %.promoted, %.preheader7 ], [ %58, %49 ]
  %52 = mul i64 %50, %20
  %53 = getelementptr i64, ptr %46, i64 %52
  %54 = load i64, ptr %53, align 4
  %55 = mul i64 %50, %26
  %gep = getelementptr i64, ptr %35, i64 %55
  %56 = load i64, ptr %gep, align 4
  %57 = mul i64 %56, %54
  %58 = add i64 %51, %57
  store i64 %58, ptr %48, align 16
  %59 = add nuw nsw i64 %50, 1
  %60 = icmp ult i64 %50, 149
  br i1 %60, label %49, label %.preheader6.1

.preheader6.1:                                    ; preds = %49
  %61 = getelementptr i64, ptr %48, i64 1
  %.promoted.1 = load i64, ptr %61, align 8
  br label %62

62:                                               ; preds = %62, %.preheader6.1
  %63 = phi i64 [ 0, %.preheader6.1 ], [ %72, %62 ]
  %64 = phi i64 [ %.promoted.1, %.preheader6.1 ], [ %71, %62 ]
  %65 = mul i64 %63, %20
  %66 = getelementptr i64, ptr %46, i64 %65
  %67 = load i64, ptr %66, align 4
  %68 = mul i64 %63, %26
  %gep.1 = getelementptr i64, ptr %invariant.gep.1, i64 %68
  %69 = load i64, ptr %gep.1, align 4
  %70 = mul i64 %69, %67
  %71 = add i64 %64, %70
  store i64 %71, ptr %61, align 8
  %72 = add nuw nsw i64 %63, 1
  %73 = icmp ult i64 %63, 149
  br i1 %73, label %62, label %.preheader6.2

.preheader6.2:                                    ; preds = %62
  %74 = getelementptr i64, ptr %48, i64 2
  %.promoted.2 = load i64, ptr %74, align 16
  br label %75

75:                                               ; preds = %75, %.preheader6.2
  %76 = phi i64 [ 0, %.preheader6.2 ], [ %85, %75 ]
  %77 = phi i64 [ %.promoted.2, %.preheader6.2 ], [ %84, %75 ]
  %78 = mul i64 %76, %20
  %79 = getelementptr i64, ptr %46, i64 %78
  %80 = load i64, ptr %79, align 4
  %81 = mul i64 %76, %26
  %gep.2 = getelementptr i64, ptr %invariant.gep.2, i64 %81
  %82 = load i64, ptr %gep.2, align 4
  %83 = mul i64 %82, %80
  %84 = add i64 %77, %83
  store i64 %84, ptr %74, align 16
  %85 = add nuw nsw i64 %76, 1
  %86 = icmp ult i64 %76, 149
  br i1 %86, label %75, label %.preheader6.3

.preheader6.3:                                    ; preds = %75
  %87 = getelementptr i64, ptr %48, i64 3
  %.promoted.3 = load i64, ptr %87, align 8
  br label %88

88:                                               ; preds = %88, %.preheader6.3
  %89 = phi i64 [ 0, %.preheader6.3 ], [ %98, %88 ]
  %90 = phi i64 [ %.promoted.3, %.preheader6.3 ], [ %97, %88 ]
  %91 = mul i64 %89, %20
  %92 = getelementptr i64, ptr %46, i64 %91
  %93 = load i64, ptr %92, align 4
  %94 = mul i64 %89, %26
  %gep.3 = getelementptr i64, ptr %invariant.gep.3, i64 %94
  %95 = load i64, ptr %gep.3, align 4
  %96 = mul i64 %95, %93
  %97 = add i64 %90, %96
  store i64 %97, ptr %87, align 8
  %98 = add nuw nsw i64 %89, 1
  %99 = icmp ult i64 %89, 149
  br i1 %99, label %88, label %.preheader6.4

.preheader6.4:                                    ; preds = %88
  %100 = getelementptr i64, ptr %48, i64 4
  %.promoted.4 = load i64, ptr %100, align 16
  br label %101

101:                                              ; preds = %101, %.preheader6.4
  %102 = phi i64 [ 0, %.preheader6.4 ], [ %111, %101 ]
  %103 = phi i64 [ %.promoted.4, %.preheader6.4 ], [ %110, %101 ]
  %104 = mul i64 %102, %20
  %105 = getelementptr i64, ptr %46, i64 %104
  %106 = load i64, ptr %105, align 4
  %107 = mul i64 %102, %26
  %gep.4 = getelementptr i64, ptr %invariant.gep.4, i64 %107
  %108 = load i64, ptr %gep.4, align 4
  %109 = mul i64 %108, %106
  %110 = add i64 %103, %109
  store i64 %110, ptr %100, align 16
  %111 = add nuw nsw i64 %102, 1
  %112 = icmp ult i64 %102, 149
  br i1 %112, label %101, label %.preheader6.5

.preheader6.5:                                    ; preds = %101
  %113 = getelementptr i64, ptr %48, i64 5
  %.promoted.5 = load i64, ptr %113, align 8
  br label %114

114:                                              ; preds = %114, %.preheader6.5
  %115 = phi i64 [ 0, %.preheader6.5 ], [ %124, %114 ]
  %116 = phi i64 [ %.promoted.5, %.preheader6.5 ], [ %123, %114 ]
  %117 = mul i64 %115, %20
  %118 = getelementptr i64, ptr %46, i64 %117
  %119 = load i64, ptr %118, align 4
  %120 = mul i64 %115, %26
  %gep.5 = getelementptr i64, ptr %invariant.gep.5, i64 %120
  %121 = load i64, ptr %gep.5, align 4
  %122 = mul i64 %121, %119
  %123 = add i64 %116, %122
  store i64 %123, ptr %113, align 8
  %124 = add nuw nsw i64 %115, 1
  %125 = icmp ult i64 %115, 149
  br i1 %125, label %114, label %.preheader6.6

.preheader6.6:                                    ; preds = %114
  %126 = getelementptr i64, ptr %48, i64 6
  %.promoted.6 = load i64, ptr %126, align 16
  br label %127

127:                                              ; preds = %127, %.preheader6.6
  %128 = phi i64 [ 0, %.preheader6.6 ], [ %137, %127 ]
  %129 = phi i64 [ %.promoted.6, %.preheader6.6 ], [ %136, %127 ]
  %130 = mul i64 %128, %20
  %131 = getelementptr i64, ptr %46, i64 %130
  %132 = load i64, ptr %131, align 4
  %133 = mul i64 %128, %26
  %gep.6 = getelementptr i64, ptr %invariant.gep.6, i64 %133
  %134 = load i64, ptr %gep.6, align 4
  %135 = mul i64 %134, %132
  %136 = add i64 %129, %135
  store i64 %136, ptr %126, align 16
  %137 = add nuw nsw i64 %128, 1
  %138 = icmp ult i64 %128, 149
  br i1 %138, label %127, label %.preheader6.7

.preheader6.7:                                    ; preds = %127
  %139 = getelementptr i64, ptr %48, i64 7
  %.promoted.7 = load i64, ptr %139, align 8
  br label %140

140:                                              ; preds = %140, %.preheader6.7
  %141 = phi i64 [ 0, %.preheader6.7 ], [ %150, %140 ]
  %142 = phi i64 [ %.promoted.7, %.preheader6.7 ], [ %149, %140 ]
  %143 = mul i64 %141, %20
  %144 = getelementptr i64, ptr %46, i64 %143
  %145 = load i64, ptr %144, align 4
  %146 = mul i64 %141, %26
  %gep.7 = getelementptr i64, ptr %invariant.gep.7, i64 %146
  %147 = load i64, ptr %gep.7, align 4
  %148 = mul i64 %147, %145
  %149 = add i64 %142, %148
  store i64 %149, ptr %139, align 8
  %150 = add nuw nsw i64 %141, 1
  %151 = icmp ult i64 %141, 149
  br i1 %151, label %140, label %.preheader6.8

.preheader6.8:                                    ; preds = %140
  %152 = getelementptr i64, ptr %48, i64 8
  %.promoted.8 = load i64, ptr %152, align 16
  br label %153

153:                                              ; preds = %153, %.preheader6.8
  %154 = phi i64 [ 0, %.preheader6.8 ], [ %163, %153 ]
  %155 = phi i64 [ %.promoted.8, %.preheader6.8 ], [ %162, %153 ]
  %156 = mul i64 %154, %20
  %157 = getelementptr i64, ptr %46, i64 %156
  %158 = load i64, ptr %157, align 4
  %159 = mul i64 %154, %26
  %gep.8 = getelementptr i64, ptr %invariant.gep.8, i64 %159
  %160 = load i64, ptr %gep.8, align 4
  %161 = mul i64 %160, %158
  %162 = add i64 %155, %161
  store i64 %162, ptr %152, align 16
  %163 = add nuw nsw i64 %154, 1
  %164 = icmp ult i64 %154, 149
  br i1 %164, label %153, label %.preheader6.9

.preheader6.9:                                    ; preds = %153
  %165 = getelementptr i64, ptr %48, i64 9
  %.promoted.9 = load i64, ptr %165, align 8
  br label %166

166:                                              ; preds = %166, %.preheader6.9
  %167 = phi i64 [ 0, %.preheader6.9 ], [ %176, %166 ]
  %168 = phi i64 [ %.promoted.9, %.preheader6.9 ], [ %175, %166 ]
  %169 = mul i64 %167, %20
  %170 = getelementptr i64, ptr %46, i64 %169
  %171 = load i64, ptr %170, align 4
  %172 = mul i64 %167, %26
  %gep.9 = getelementptr i64, ptr %invariant.gep.9, i64 %172
  %173 = load i64, ptr %gep.9, align 4
  %174 = mul i64 %173, %171
  %175 = add i64 %168, %174
  store i64 %175, ptr %165, align 8
  %176 = add nuw nsw i64 %167, 1
  %177 = icmp ult i64 %167, 149
  br i1 %177, label %166, label %178

178:                                              ; preds = %166
  %179 = add nuw nsw i64 %44, 1
  %180 = icmp ult i64 %44, 249
  br i1 %180, label %.preheader7, label %181

181:                                              ; preds = %178
  %182 = tail call dereferenceable_or_null(14064) ptr @malloc(i64 14064)
  %183 = ptrtoint ptr %182 to i64
  %184 = add i64 %183, 63
  %185 = and i64 %184, -64
  %186 = inttoptr i64 %185 to ptr
  %187 = getelementptr i64, ptr %8, i64 %9
  %invariant.gep8.1 = getelementptr i64, ptr %33, i64 1
  %invariant.gep8.2 = getelementptr i64, ptr %33, i64 2
  %invariant.gep8.3 = getelementptr i64, ptr %33, i64 3
  %invariant.gep8.4 = getelementptr i64, ptr %33, i64 4
  %invariant.gep8.5 = getelementptr i64, ptr %33, i64 5
  %invariant.gep8.6 = getelementptr i64, ptr %33, i64 6
  %invariant.gep8.7 = getelementptr i64, ptr %33, i64 7
  %invariant.gep8.8 = getelementptr i64, ptr %33, i64 8
  %invariant.gep8.9 = getelementptr i64, ptr %33, i64 9
  br label %.preheader5

.preheader5:                                      ; preds = %181, %322
  %188 = phi i64 [ 0, %181 ], [ %323, %322 ]
  %189 = mul i64 %188, %12
  %190 = getelementptr i64, ptr %187, i64 %189
  %191 = mul nuw nsw i64 %188, 10
  %192 = getelementptr i64, ptr %186, i64 %191
  %.promoted10 = load i64, ptr %192, align 16
  br label %193

193:                                              ; preds = %.preheader5, %193
  %194 = phi i64 [ 0, %.preheader5 ], [ %203, %193 ]
  %195 = phi i64 [ %.promoted10, %.preheader5 ], [ %202, %193 ]
  %196 = mul i64 %194, %13
  %197 = getelementptr i64, ptr %190, i64 %196
  %198 = load i64, ptr %197, align 4
  %199 = mul nuw nsw i64 %194, 10
  %gep9 = getelementptr i64, ptr %33, i64 %199
  %200 = load i64, ptr %gep9, align 16
  %201 = mul i64 %200, %198
  %202 = add i64 %195, %201
  store i64 %202, ptr %192, align 16
  %203 = add nuw nsw i64 %194, 1
  %204 = icmp ult i64 %194, 249
  br i1 %204, label %193, label %.preheader4.1

.preheader4.1:                                    ; preds = %193
  %205 = getelementptr i64, ptr %192, i64 1
  %.promoted10.1 = load i64, ptr %205, align 8
  br label %206

206:                                              ; preds = %206, %.preheader4.1
  %207 = phi i64 [ 0, %.preheader4.1 ], [ %216, %206 ]
  %208 = phi i64 [ %.promoted10.1, %.preheader4.1 ], [ %215, %206 ]
  %209 = mul i64 %207, %13
  %210 = getelementptr i64, ptr %190, i64 %209
  %211 = load i64, ptr %210, align 4
  %212 = mul nuw nsw i64 %207, 10
  %gep9.1 = getelementptr i64, ptr %invariant.gep8.1, i64 %212
  %213 = load i64, ptr %gep9.1, align 8
  %214 = mul i64 %213, %211
  %215 = add i64 %208, %214
  store i64 %215, ptr %205, align 8
  %216 = add nuw nsw i64 %207, 1
  %217 = icmp ult i64 %207, 249
  br i1 %217, label %206, label %.preheader4.2

.preheader4.2:                                    ; preds = %206
  %218 = getelementptr i64, ptr %192, i64 2
  %.promoted10.2 = load i64, ptr %218, align 16
  br label %219

219:                                              ; preds = %219, %.preheader4.2
  %220 = phi i64 [ 0, %.preheader4.2 ], [ %229, %219 ]
  %221 = phi i64 [ %.promoted10.2, %.preheader4.2 ], [ %228, %219 ]
  %222 = mul i64 %220, %13
  %223 = getelementptr i64, ptr %190, i64 %222
  %224 = load i64, ptr %223, align 4
  %225 = mul nuw nsw i64 %220, 10
  %gep9.2 = getelementptr i64, ptr %invariant.gep8.2, i64 %225
  %226 = load i64, ptr %gep9.2, align 16
  %227 = mul i64 %226, %224
  %228 = add i64 %221, %227
  store i64 %228, ptr %218, align 16
  %229 = add nuw nsw i64 %220, 1
  %230 = icmp ult i64 %220, 249
  br i1 %230, label %219, label %.preheader4.3

.preheader4.3:                                    ; preds = %219
  %231 = getelementptr i64, ptr %192, i64 3
  %.promoted10.3 = load i64, ptr %231, align 8
  br label %232

232:                                              ; preds = %232, %.preheader4.3
  %233 = phi i64 [ 0, %.preheader4.3 ], [ %242, %232 ]
  %234 = phi i64 [ %.promoted10.3, %.preheader4.3 ], [ %241, %232 ]
  %235 = mul i64 %233, %13
  %236 = getelementptr i64, ptr %190, i64 %235
  %237 = load i64, ptr %236, align 4
  %238 = mul nuw nsw i64 %233, 10
  %gep9.3 = getelementptr i64, ptr %invariant.gep8.3, i64 %238
  %239 = load i64, ptr %gep9.3, align 8
  %240 = mul i64 %239, %237
  %241 = add i64 %234, %240
  store i64 %241, ptr %231, align 8
  %242 = add nuw nsw i64 %233, 1
  %243 = icmp ult i64 %233, 249
  br i1 %243, label %232, label %.preheader4.4

.preheader4.4:                                    ; preds = %232
  %244 = getelementptr i64, ptr %192, i64 4
  %.promoted10.4 = load i64, ptr %244, align 16
  br label %245

245:                                              ; preds = %245, %.preheader4.4
  %246 = phi i64 [ 0, %.preheader4.4 ], [ %255, %245 ]
  %247 = phi i64 [ %.promoted10.4, %.preheader4.4 ], [ %254, %245 ]
  %248 = mul i64 %246, %13
  %249 = getelementptr i64, ptr %190, i64 %248
  %250 = load i64, ptr %249, align 4
  %251 = mul nuw nsw i64 %246, 10
  %gep9.4 = getelementptr i64, ptr %invariant.gep8.4, i64 %251
  %252 = load i64, ptr %gep9.4, align 16
  %253 = mul i64 %252, %250
  %254 = add i64 %247, %253
  store i64 %254, ptr %244, align 16
  %255 = add nuw nsw i64 %246, 1
  %256 = icmp ult i64 %246, 249
  br i1 %256, label %245, label %.preheader4.5

.preheader4.5:                                    ; preds = %245
  %257 = getelementptr i64, ptr %192, i64 5
  %.promoted10.5 = load i64, ptr %257, align 8
  br label %258

258:                                              ; preds = %258, %.preheader4.5
  %259 = phi i64 [ 0, %.preheader4.5 ], [ %268, %258 ]
  %260 = phi i64 [ %.promoted10.5, %.preheader4.5 ], [ %267, %258 ]
  %261 = mul i64 %259, %13
  %262 = getelementptr i64, ptr %190, i64 %261
  %263 = load i64, ptr %262, align 4
  %264 = mul nuw nsw i64 %259, 10
  %gep9.5 = getelementptr i64, ptr %invariant.gep8.5, i64 %264
  %265 = load i64, ptr %gep9.5, align 8
  %266 = mul i64 %265, %263
  %267 = add i64 %260, %266
  store i64 %267, ptr %257, align 8
  %268 = add nuw nsw i64 %259, 1
  %269 = icmp ult i64 %259, 249
  br i1 %269, label %258, label %.preheader4.6

.preheader4.6:                                    ; preds = %258
  %270 = getelementptr i64, ptr %192, i64 6
  %.promoted10.6 = load i64, ptr %270, align 16
  br label %271

271:                                              ; preds = %271, %.preheader4.6
  %272 = phi i64 [ 0, %.preheader4.6 ], [ %281, %271 ]
  %273 = phi i64 [ %.promoted10.6, %.preheader4.6 ], [ %280, %271 ]
  %274 = mul i64 %272, %13
  %275 = getelementptr i64, ptr %190, i64 %274
  %276 = load i64, ptr %275, align 4
  %277 = mul nuw nsw i64 %272, 10
  %gep9.6 = getelementptr i64, ptr %invariant.gep8.6, i64 %277
  %278 = load i64, ptr %gep9.6, align 16
  %279 = mul i64 %278, %276
  %280 = add i64 %273, %279
  store i64 %280, ptr %270, align 16
  %281 = add nuw nsw i64 %272, 1
  %282 = icmp ult i64 %272, 249
  br i1 %282, label %271, label %.preheader4.7

.preheader4.7:                                    ; preds = %271
  %283 = getelementptr i64, ptr %192, i64 7
  %.promoted10.7 = load i64, ptr %283, align 8
  br label %284

284:                                              ; preds = %284, %.preheader4.7
  %285 = phi i64 [ 0, %.preheader4.7 ], [ %294, %284 ]
  %286 = phi i64 [ %.promoted10.7, %.preheader4.7 ], [ %293, %284 ]
  %287 = mul i64 %285, %13
  %288 = getelementptr i64, ptr %190, i64 %287
  %289 = load i64, ptr %288, align 4
  %290 = mul nuw nsw i64 %285, 10
  %gep9.7 = getelementptr i64, ptr %invariant.gep8.7, i64 %290
  %291 = load i64, ptr %gep9.7, align 8
  %292 = mul i64 %291, %289
  %293 = add i64 %286, %292
  store i64 %293, ptr %283, align 8
  %294 = add nuw nsw i64 %285, 1
  %295 = icmp ult i64 %285, 249
  br i1 %295, label %284, label %.preheader4.8

.preheader4.8:                                    ; preds = %284
  %296 = getelementptr i64, ptr %192, i64 8
  %.promoted10.8 = load i64, ptr %296, align 16
  br label %297

297:                                              ; preds = %297, %.preheader4.8
  %298 = phi i64 [ 0, %.preheader4.8 ], [ %307, %297 ]
  %299 = phi i64 [ %.promoted10.8, %.preheader4.8 ], [ %306, %297 ]
  %300 = mul i64 %298, %13
  %301 = getelementptr i64, ptr %190, i64 %300
  %302 = load i64, ptr %301, align 4
  %303 = mul nuw nsw i64 %298, 10
  %gep9.8 = getelementptr i64, ptr %invariant.gep8.8, i64 %303
  %304 = load i64, ptr %gep9.8, align 16
  %305 = mul i64 %304, %302
  %306 = add i64 %299, %305
  store i64 %306, ptr %296, align 16
  %307 = add nuw nsw i64 %298, 1
  %308 = icmp ult i64 %298, 249
  br i1 %308, label %297, label %.preheader4.9

.preheader4.9:                                    ; preds = %297
  %309 = getelementptr i64, ptr %192, i64 9
  %.promoted10.9 = load i64, ptr %309, align 8
  br label %310

310:                                              ; preds = %310, %.preheader4.9
  %311 = phi i64 [ 0, %.preheader4.9 ], [ %320, %310 ]
  %312 = phi i64 [ %.promoted10.9, %.preheader4.9 ], [ %319, %310 ]
  %313 = mul i64 %311, %13
  %314 = getelementptr i64, ptr %190, i64 %313
  %315 = load i64, ptr %314, align 4
  %316 = mul nuw nsw i64 %311, 10
  %gep9.9 = getelementptr i64, ptr %invariant.gep8.9, i64 %316
  %317 = load i64, ptr %gep9.9, align 8
  %318 = mul i64 %317, %315
  %319 = add i64 %312, %318
  store i64 %319, ptr %309, align 8
  %320 = add nuw nsw i64 %311, 1
  %321 = icmp ult i64 %311, 249
  br i1 %321, label %310, label %322

322:                                              ; preds = %310
  %323 = add nuw nsw i64 %188, 1
  %324 = icmp ult i64 %188, 174
  br i1 %324, label %.preheader5, label %325

325:                                              ; preds = %322
  %326 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %327 = ptrtoint ptr %326 to i64
  %328 = add i64 %327, 63
  %329 = and i64 %328, -64
  %330 = inttoptr i64 %329 to ptr
  %331 = getelementptr i64, ptr %1, i64 %2
  %invariant.gep11.1 = getelementptr i64, ptr %186, i64 1
  %invariant.gep11.2 = getelementptr i64, ptr %186, i64 2
  %invariant.gep11.3 = getelementptr i64, ptr %186, i64 3
  %invariant.gep11.4 = getelementptr i64, ptr %186, i64 4
  %invariant.gep11.5 = getelementptr i64, ptr %186, i64 5
  %invariant.gep11.6 = getelementptr i64, ptr %186, i64 6
  %invariant.gep11.7 = getelementptr i64, ptr %186, i64 7
  %invariant.gep11.8 = getelementptr i64, ptr %186, i64 8
  %invariant.gep11.9 = getelementptr i64, ptr %186, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %325, %466
  %332 = phi i64 [ 0, %325 ], [ %467, %466 ]
  %333 = mul i64 %332, %5
  %334 = getelementptr i64, ptr %331, i64 %333
  %335 = mul nuw nsw i64 %332, 10
  %336 = getelementptr i64, ptr %330, i64 %335
  %.promoted13 = load i64, ptr %336, align 16
  br label %337

337:                                              ; preds = %.preheader3, %337
  %338 = phi i64 [ 0, %.preheader3 ], [ %347, %337 ]
  %339 = phi i64 [ %.promoted13, %.preheader3 ], [ %346, %337 ]
  %340 = mul i64 %338, %6
  %341 = getelementptr i64, ptr %334, i64 %340
  %342 = load i64, ptr %341, align 4
  %343 = mul nuw nsw i64 %338, 10
  %gep12 = getelementptr i64, ptr %186, i64 %343
  %344 = load i64, ptr %gep12, align 16
  %345 = mul i64 %344, %342
  %346 = add i64 %339, %345
  store i64 %346, ptr %336, align 16
  %347 = add nuw nsw i64 %338, 1
  %348 = icmp ult i64 %338, 174
  br i1 %348, label %337, label %.preheader.1

.preheader.1:                                     ; preds = %337
  %349 = getelementptr i64, ptr %336, i64 1
  %.promoted13.1 = load i64, ptr %349, align 8
  br label %350

350:                                              ; preds = %350, %.preheader.1
  %351 = phi i64 [ 0, %.preheader.1 ], [ %360, %350 ]
  %352 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %359, %350 ]
  %353 = mul i64 %351, %6
  %354 = getelementptr i64, ptr %334, i64 %353
  %355 = load i64, ptr %354, align 4
  %356 = mul nuw nsw i64 %351, 10
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %356
  %357 = load i64, ptr %gep12.1, align 8
  %358 = mul i64 %357, %355
  %359 = add i64 %352, %358
  store i64 %359, ptr %349, align 8
  %360 = add nuw nsw i64 %351, 1
  %361 = icmp ult i64 %351, 174
  br i1 %361, label %350, label %.preheader.2

.preheader.2:                                     ; preds = %350
  %362 = getelementptr i64, ptr %336, i64 2
  %.promoted13.2 = load i64, ptr %362, align 16
  br label %363

363:                                              ; preds = %363, %.preheader.2
  %364 = phi i64 [ 0, %.preheader.2 ], [ %373, %363 ]
  %365 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %372, %363 ]
  %366 = mul i64 %364, %6
  %367 = getelementptr i64, ptr %334, i64 %366
  %368 = load i64, ptr %367, align 4
  %369 = mul nuw nsw i64 %364, 10
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %369
  %370 = load i64, ptr %gep12.2, align 16
  %371 = mul i64 %370, %368
  %372 = add i64 %365, %371
  store i64 %372, ptr %362, align 16
  %373 = add nuw nsw i64 %364, 1
  %374 = icmp ult i64 %364, 174
  br i1 %374, label %363, label %.preheader.3

.preheader.3:                                     ; preds = %363
  %375 = getelementptr i64, ptr %336, i64 3
  %.promoted13.3 = load i64, ptr %375, align 8
  br label %376

376:                                              ; preds = %376, %.preheader.3
  %377 = phi i64 [ 0, %.preheader.3 ], [ %386, %376 ]
  %378 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %385, %376 ]
  %379 = mul i64 %377, %6
  %380 = getelementptr i64, ptr %334, i64 %379
  %381 = load i64, ptr %380, align 4
  %382 = mul nuw nsw i64 %377, 10
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %382
  %383 = load i64, ptr %gep12.3, align 8
  %384 = mul i64 %383, %381
  %385 = add i64 %378, %384
  store i64 %385, ptr %375, align 8
  %386 = add nuw nsw i64 %377, 1
  %387 = icmp ult i64 %377, 174
  br i1 %387, label %376, label %.preheader.4

.preheader.4:                                     ; preds = %376
  %388 = getelementptr i64, ptr %336, i64 4
  %.promoted13.4 = load i64, ptr %388, align 16
  br label %389

389:                                              ; preds = %389, %.preheader.4
  %390 = phi i64 [ 0, %.preheader.4 ], [ %399, %389 ]
  %391 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %398, %389 ]
  %392 = mul i64 %390, %6
  %393 = getelementptr i64, ptr %334, i64 %392
  %394 = load i64, ptr %393, align 4
  %395 = mul nuw nsw i64 %390, 10
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %395
  %396 = load i64, ptr %gep12.4, align 16
  %397 = mul i64 %396, %394
  %398 = add i64 %391, %397
  store i64 %398, ptr %388, align 16
  %399 = add nuw nsw i64 %390, 1
  %400 = icmp ult i64 %390, 174
  br i1 %400, label %389, label %.preheader.5

.preheader.5:                                     ; preds = %389
  %401 = getelementptr i64, ptr %336, i64 5
  %.promoted13.5 = load i64, ptr %401, align 8
  br label %402

402:                                              ; preds = %402, %.preheader.5
  %403 = phi i64 [ 0, %.preheader.5 ], [ %412, %402 ]
  %404 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %411, %402 ]
  %405 = mul i64 %403, %6
  %406 = getelementptr i64, ptr %334, i64 %405
  %407 = load i64, ptr %406, align 4
  %408 = mul nuw nsw i64 %403, 10
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %408
  %409 = load i64, ptr %gep12.5, align 8
  %410 = mul i64 %409, %407
  %411 = add i64 %404, %410
  store i64 %411, ptr %401, align 8
  %412 = add nuw nsw i64 %403, 1
  %413 = icmp ult i64 %403, 174
  br i1 %413, label %402, label %.preheader.6

.preheader.6:                                     ; preds = %402
  %414 = getelementptr i64, ptr %336, i64 6
  %.promoted13.6 = load i64, ptr %414, align 16
  br label %415

415:                                              ; preds = %415, %.preheader.6
  %416 = phi i64 [ 0, %.preheader.6 ], [ %425, %415 ]
  %417 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %424, %415 ]
  %418 = mul i64 %416, %6
  %419 = getelementptr i64, ptr %334, i64 %418
  %420 = load i64, ptr %419, align 4
  %421 = mul nuw nsw i64 %416, 10
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %421
  %422 = load i64, ptr %gep12.6, align 16
  %423 = mul i64 %422, %420
  %424 = add i64 %417, %423
  store i64 %424, ptr %414, align 16
  %425 = add nuw nsw i64 %416, 1
  %426 = icmp ult i64 %416, 174
  br i1 %426, label %415, label %.preheader.7

.preheader.7:                                     ; preds = %415
  %427 = getelementptr i64, ptr %336, i64 7
  %.promoted13.7 = load i64, ptr %427, align 8
  br label %428

428:                                              ; preds = %428, %.preheader.7
  %429 = phi i64 [ 0, %.preheader.7 ], [ %438, %428 ]
  %430 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %437, %428 ]
  %431 = mul i64 %429, %6
  %432 = getelementptr i64, ptr %334, i64 %431
  %433 = load i64, ptr %432, align 4
  %434 = mul nuw nsw i64 %429, 10
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %434
  %435 = load i64, ptr %gep12.7, align 8
  %436 = mul i64 %435, %433
  %437 = add i64 %430, %436
  store i64 %437, ptr %427, align 8
  %438 = add nuw nsw i64 %429, 1
  %439 = icmp ult i64 %429, 174
  br i1 %439, label %428, label %.preheader.8

.preheader.8:                                     ; preds = %428
  %440 = getelementptr i64, ptr %336, i64 8
  %.promoted13.8 = load i64, ptr %440, align 16
  br label %441

441:                                              ; preds = %441, %.preheader.8
  %442 = phi i64 [ 0, %.preheader.8 ], [ %451, %441 ]
  %443 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %450, %441 ]
  %444 = mul i64 %442, %6
  %445 = getelementptr i64, ptr %334, i64 %444
  %446 = load i64, ptr %445, align 4
  %447 = mul nuw nsw i64 %442, 10
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %447
  %448 = load i64, ptr %gep12.8, align 16
  %449 = mul i64 %448, %446
  %450 = add i64 %443, %449
  store i64 %450, ptr %440, align 16
  %451 = add nuw nsw i64 %442, 1
  %452 = icmp ult i64 %442, 174
  br i1 %452, label %441, label %.preheader.9

.preheader.9:                                     ; preds = %441
  %453 = getelementptr i64, ptr %336, i64 9
  %.promoted13.9 = load i64, ptr %453, align 8
  br label %454

454:                                              ; preds = %454, %.preheader.9
  %455 = phi i64 [ 0, %.preheader.9 ], [ %464, %454 ]
  %456 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %463, %454 ]
  %457 = mul i64 %455, %6
  %458 = getelementptr i64, ptr %334, i64 %457
  %459 = load i64, ptr %458, align 4
  %460 = mul nuw nsw i64 %455, 10
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %460
  %461 = load i64, ptr %gep12.9, align 8
  %462 = mul i64 %461, %459
  %463 = add i64 %456, %462
  store i64 %463, ptr %453, align 8
  %464 = add nuw nsw i64 %455, 1
  %465 = icmp ult i64 %455, 174
  br i1 %465, label %454, label %466

466:                                              ; preds = %454
  %467 = add nuw nsw i64 %332, 1
  %468 = icmp ult i64 %332, 199
  br i1 %468, label %.preheader3, label %469

469:                                              ; preds = %466
  %470 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %326, 0
  %471 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %470, ptr %330, 1
  %472 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %471, i64 0, 2
  %473 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %472, i64 200, 3, 0
  %474 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %473, i64 10, 3, 1
  %475 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %474, i64 10, 4, 0
  %476 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %475, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %476
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #2

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
