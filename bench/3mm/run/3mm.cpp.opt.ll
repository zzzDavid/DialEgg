; ModuleID = 'bench/3mm/run/3mm.cpp.ll'
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
  %29 = tail call dereferenceable_or_null(210064) ptr @malloc(i64 210064)
  %30 = ptrtoint ptr %29 to i64
  %31 = add i64 %30, 63
  %32 = and i64 %31, -64
  %33 = inttoptr i64 %32 to ptr
  %34 = getelementptr i64, ptr %8, i64 %9
  %35 = getelementptr i64, ptr %15, i64 %16
  br label %.preheader7

.preheader7:                                      ; preds = %28, %59
  %36 = phi i64 [ 0, %28 ], [ %60, %59 ]
  %37 = mul i64 %36, %12
  %38 = getelementptr i64, ptr %34, i64 %37
  %39 = mul nuw nsw i64 %36, 150
  %40 = getelementptr i64, ptr %33, i64 %39
  br label %.preheader6

.preheader6:                                      ; preds = %.preheader7, %56
  %41 = phi i64 [ 0, %.preheader7 ], [ %57, %56 ]
  %42 = mul i64 %41, %20
  %invariant.gep = getelementptr i64, ptr %35, i64 %42
  %43 = getelementptr i64, ptr %40, i64 %41
  %.promoted = load i64, ptr %43, align 8
  br label %44

44:                                               ; preds = %.preheader6, %44
  %45 = phi i64 [ 0, %.preheader6 ], [ %54, %44 ]
  %46 = phi i64 [ %.promoted, %.preheader6 ], [ %53, %44 ]
  %47 = mul i64 %45, %13
  %48 = getelementptr i64, ptr %38, i64 %47
  %49 = load i64, ptr %48, align 4
  %50 = mul i64 %45, %19
  %gep = getelementptr i64, ptr %invariant.gep, i64 %50
  %51 = load i64, ptr %gep, align 4
  %52 = mul i64 %51, %49
  %53 = add i64 %46, %52
  store i64 %53, ptr %43, align 8
  %54 = add nuw nsw i64 %45, 1
  %55 = icmp ult i64 %45, 249
  br i1 %55, label %44, label %56

56:                                               ; preds = %44
  %57 = add nuw nsw i64 %41, 1
  %58 = icmp ult i64 %41, 149
  br i1 %58, label %.preheader6, label %59

59:                                               ; preds = %56
  %60 = add nuw nsw i64 %36, 1
  %61 = icmp ult i64 %36, 174
  br i1 %61, label %.preheader7, label %62

62:                                               ; preds = %59
  %63 = tail call dereferenceable_or_null(14064) ptr @malloc(i64 14064)
  %64 = ptrtoint ptr %63 to i64
  %65 = add i64 %64, 63
  %66 = and i64 %65, -64
  %67 = inttoptr i64 %66 to ptr
  %68 = getelementptr i64, ptr %22, i64 %23
  %invariant.gep8.1 = getelementptr i64, ptr %68, i64 %27
  %69 = shl i64 %27, 1
  %invariant.gep8.2 = getelementptr i64, ptr %68, i64 %69
  %70 = mul i64 %27, 3
  %invariant.gep8.3 = getelementptr i64, ptr %68, i64 %70
  %71 = shl i64 %27, 2
  %invariant.gep8.4 = getelementptr i64, ptr %68, i64 %71
  %72 = mul i64 %27, 5
  %invariant.gep8.5 = getelementptr i64, ptr %68, i64 %72
  %73 = mul i64 %27, 6
  %invariant.gep8.6 = getelementptr i64, ptr %68, i64 %73
  %74 = mul i64 %27, 7
  %invariant.gep8.7 = getelementptr i64, ptr %68, i64 %74
  %75 = shl i64 %27, 3
  %invariant.gep8.8 = getelementptr i64, ptr %68, i64 %75
  %76 = mul i64 %27, 9
  %invariant.gep8.9 = getelementptr i64, ptr %68, i64 %76
  br label %.preheader5

.preheader5:                                      ; preds = %62, %201
  %77 = phi i64 [ 0, %62 ], [ %202, %201 ]
  %78 = mul nuw nsw i64 %77, 150
  %79 = getelementptr i64, ptr %33, i64 %78
  %80 = mul nuw nsw i64 %77, 10
  %81 = getelementptr i64, ptr %67, i64 %80
  %.promoted10 = load i64, ptr %81, align 16
  br label %82

82:                                               ; preds = %.preheader5, %82
  %83 = phi i64 [ 0, %.preheader5 ], [ %91, %82 ]
  %84 = phi i64 [ %.promoted10, %.preheader5 ], [ %90, %82 ]
  %85 = getelementptr i64, ptr %79, i64 %83
  %86 = load i64, ptr %85, align 8
  %87 = mul i64 %83, %26
  %gep9 = getelementptr i64, ptr %68, i64 %87
  %88 = load i64, ptr %gep9, align 4
  %89 = mul i64 %88, %86
  %90 = add i64 %84, %89
  store i64 %90, ptr %81, align 16
  %91 = add nuw nsw i64 %83, 1
  %92 = icmp ult i64 %83, 149
  br i1 %92, label %82, label %.preheader4.1

.preheader4.1:                                    ; preds = %82
  %93 = getelementptr i64, ptr %81, i64 1
  %.promoted10.1 = load i64, ptr %93, align 8
  br label %94

94:                                               ; preds = %94, %.preheader4.1
  %95 = phi i64 [ 0, %.preheader4.1 ], [ %103, %94 ]
  %96 = phi i64 [ %.promoted10.1, %.preheader4.1 ], [ %102, %94 ]
  %97 = getelementptr i64, ptr %79, i64 %95
  %98 = load i64, ptr %97, align 8
  %99 = mul i64 %95, %26
  %gep9.1 = getelementptr i64, ptr %invariant.gep8.1, i64 %99
  %100 = load i64, ptr %gep9.1, align 4
  %101 = mul i64 %100, %98
  %102 = add i64 %96, %101
  store i64 %102, ptr %93, align 8
  %103 = add nuw nsw i64 %95, 1
  %104 = icmp ult i64 %95, 149
  br i1 %104, label %94, label %.preheader4.2

.preheader4.2:                                    ; preds = %94
  %105 = getelementptr i64, ptr %81, i64 2
  %.promoted10.2 = load i64, ptr %105, align 16
  br label %106

106:                                              ; preds = %106, %.preheader4.2
  %107 = phi i64 [ 0, %.preheader4.2 ], [ %115, %106 ]
  %108 = phi i64 [ %.promoted10.2, %.preheader4.2 ], [ %114, %106 ]
  %109 = getelementptr i64, ptr %79, i64 %107
  %110 = load i64, ptr %109, align 8
  %111 = mul i64 %107, %26
  %gep9.2 = getelementptr i64, ptr %invariant.gep8.2, i64 %111
  %112 = load i64, ptr %gep9.2, align 4
  %113 = mul i64 %112, %110
  %114 = add i64 %108, %113
  store i64 %114, ptr %105, align 16
  %115 = add nuw nsw i64 %107, 1
  %116 = icmp ult i64 %107, 149
  br i1 %116, label %106, label %.preheader4.3

.preheader4.3:                                    ; preds = %106
  %117 = getelementptr i64, ptr %81, i64 3
  %.promoted10.3 = load i64, ptr %117, align 8
  br label %118

118:                                              ; preds = %118, %.preheader4.3
  %119 = phi i64 [ 0, %.preheader4.3 ], [ %127, %118 ]
  %120 = phi i64 [ %.promoted10.3, %.preheader4.3 ], [ %126, %118 ]
  %121 = getelementptr i64, ptr %79, i64 %119
  %122 = load i64, ptr %121, align 8
  %123 = mul i64 %119, %26
  %gep9.3 = getelementptr i64, ptr %invariant.gep8.3, i64 %123
  %124 = load i64, ptr %gep9.3, align 4
  %125 = mul i64 %124, %122
  %126 = add i64 %120, %125
  store i64 %126, ptr %117, align 8
  %127 = add nuw nsw i64 %119, 1
  %128 = icmp ult i64 %119, 149
  br i1 %128, label %118, label %.preheader4.4

.preheader4.4:                                    ; preds = %118
  %129 = getelementptr i64, ptr %81, i64 4
  %.promoted10.4 = load i64, ptr %129, align 16
  br label %130

130:                                              ; preds = %130, %.preheader4.4
  %131 = phi i64 [ 0, %.preheader4.4 ], [ %139, %130 ]
  %132 = phi i64 [ %.promoted10.4, %.preheader4.4 ], [ %138, %130 ]
  %133 = getelementptr i64, ptr %79, i64 %131
  %134 = load i64, ptr %133, align 8
  %135 = mul i64 %131, %26
  %gep9.4 = getelementptr i64, ptr %invariant.gep8.4, i64 %135
  %136 = load i64, ptr %gep9.4, align 4
  %137 = mul i64 %136, %134
  %138 = add i64 %132, %137
  store i64 %138, ptr %129, align 16
  %139 = add nuw nsw i64 %131, 1
  %140 = icmp ult i64 %131, 149
  br i1 %140, label %130, label %.preheader4.5

.preheader4.5:                                    ; preds = %130
  %141 = getelementptr i64, ptr %81, i64 5
  %.promoted10.5 = load i64, ptr %141, align 8
  br label %142

142:                                              ; preds = %142, %.preheader4.5
  %143 = phi i64 [ 0, %.preheader4.5 ], [ %151, %142 ]
  %144 = phi i64 [ %.promoted10.5, %.preheader4.5 ], [ %150, %142 ]
  %145 = getelementptr i64, ptr %79, i64 %143
  %146 = load i64, ptr %145, align 8
  %147 = mul i64 %143, %26
  %gep9.5 = getelementptr i64, ptr %invariant.gep8.5, i64 %147
  %148 = load i64, ptr %gep9.5, align 4
  %149 = mul i64 %148, %146
  %150 = add i64 %144, %149
  store i64 %150, ptr %141, align 8
  %151 = add nuw nsw i64 %143, 1
  %152 = icmp ult i64 %143, 149
  br i1 %152, label %142, label %.preheader4.6

.preheader4.6:                                    ; preds = %142
  %153 = getelementptr i64, ptr %81, i64 6
  %.promoted10.6 = load i64, ptr %153, align 16
  br label %154

154:                                              ; preds = %154, %.preheader4.6
  %155 = phi i64 [ 0, %.preheader4.6 ], [ %163, %154 ]
  %156 = phi i64 [ %.promoted10.6, %.preheader4.6 ], [ %162, %154 ]
  %157 = getelementptr i64, ptr %79, i64 %155
  %158 = load i64, ptr %157, align 8
  %159 = mul i64 %155, %26
  %gep9.6 = getelementptr i64, ptr %invariant.gep8.6, i64 %159
  %160 = load i64, ptr %gep9.6, align 4
  %161 = mul i64 %160, %158
  %162 = add i64 %156, %161
  store i64 %162, ptr %153, align 16
  %163 = add nuw nsw i64 %155, 1
  %164 = icmp ult i64 %155, 149
  br i1 %164, label %154, label %.preheader4.7

.preheader4.7:                                    ; preds = %154
  %165 = getelementptr i64, ptr %81, i64 7
  %.promoted10.7 = load i64, ptr %165, align 8
  br label %166

166:                                              ; preds = %166, %.preheader4.7
  %167 = phi i64 [ 0, %.preheader4.7 ], [ %175, %166 ]
  %168 = phi i64 [ %.promoted10.7, %.preheader4.7 ], [ %174, %166 ]
  %169 = getelementptr i64, ptr %79, i64 %167
  %170 = load i64, ptr %169, align 8
  %171 = mul i64 %167, %26
  %gep9.7 = getelementptr i64, ptr %invariant.gep8.7, i64 %171
  %172 = load i64, ptr %gep9.7, align 4
  %173 = mul i64 %172, %170
  %174 = add i64 %168, %173
  store i64 %174, ptr %165, align 8
  %175 = add nuw nsw i64 %167, 1
  %176 = icmp ult i64 %167, 149
  br i1 %176, label %166, label %.preheader4.8

.preheader4.8:                                    ; preds = %166
  %177 = getelementptr i64, ptr %81, i64 8
  %.promoted10.8 = load i64, ptr %177, align 16
  br label %178

178:                                              ; preds = %178, %.preheader4.8
  %179 = phi i64 [ 0, %.preheader4.8 ], [ %187, %178 ]
  %180 = phi i64 [ %.promoted10.8, %.preheader4.8 ], [ %186, %178 ]
  %181 = getelementptr i64, ptr %79, i64 %179
  %182 = load i64, ptr %181, align 8
  %183 = mul i64 %179, %26
  %gep9.8 = getelementptr i64, ptr %invariant.gep8.8, i64 %183
  %184 = load i64, ptr %gep9.8, align 4
  %185 = mul i64 %184, %182
  %186 = add i64 %180, %185
  store i64 %186, ptr %177, align 16
  %187 = add nuw nsw i64 %179, 1
  %188 = icmp ult i64 %179, 149
  br i1 %188, label %178, label %.preheader4.9

.preheader4.9:                                    ; preds = %178
  %189 = getelementptr i64, ptr %81, i64 9
  %.promoted10.9 = load i64, ptr %189, align 8
  br label %190

190:                                              ; preds = %190, %.preheader4.9
  %191 = phi i64 [ 0, %.preheader4.9 ], [ %199, %190 ]
  %192 = phi i64 [ %.promoted10.9, %.preheader4.9 ], [ %198, %190 ]
  %193 = getelementptr i64, ptr %79, i64 %191
  %194 = load i64, ptr %193, align 8
  %195 = mul i64 %191, %26
  %gep9.9 = getelementptr i64, ptr %invariant.gep8.9, i64 %195
  %196 = load i64, ptr %gep9.9, align 4
  %197 = mul i64 %196, %194
  %198 = add i64 %192, %197
  store i64 %198, ptr %189, align 8
  %199 = add nuw nsw i64 %191, 1
  %200 = icmp ult i64 %191, 149
  br i1 %200, label %190, label %201

201:                                              ; preds = %190
  %202 = add nuw nsw i64 %77, 1
  %203 = icmp ult i64 %77, 174
  br i1 %203, label %.preheader5, label %204

204:                                              ; preds = %201
  %205 = tail call dereferenceable_or_null(16064) ptr @malloc(i64 16064)
  %206 = ptrtoint ptr %205 to i64
  %207 = add i64 %206, 63
  %208 = and i64 %207, -64
  %209 = inttoptr i64 %208 to ptr
  %210 = getelementptr i64, ptr %1, i64 %2
  %invariant.gep11.1 = getelementptr i64, ptr %67, i64 1
  %invariant.gep11.2 = getelementptr i64, ptr %67, i64 2
  %invariant.gep11.3 = getelementptr i64, ptr %67, i64 3
  %invariant.gep11.4 = getelementptr i64, ptr %67, i64 4
  %invariant.gep11.5 = getelementptr i64, ptr %67, i64 5
  %invariant.gep11.6 = getelementptr i64, ptr %67, i64 6
  %invariant.gep11.7 = getelementptr i64, ptr %67, i64 7
  %invariant.gep11.8 = getelementptr i64, ptr %67, i64 8
  %invariant.gep11.9 = getelementptr i64, ptr %67, i64 9
  br label %.preheader3

.preheader3:                                      ; preds = %204, %345
  %211 = phi i64 [ 0, %204 ], [ %346, %345 ]
  %212 = mul i64 %211, %5
  %213 = getelementptr i64, ptr %210, i64 %212
  %214 = mul nuw nsw i64 %211, 10
  %215 = getelementptr i64, ptr %209, i64 %214
  %.promoted13 = load i64, ptr %215, align 16
  br label %216

216:                                              ; preds = %.preheader3, %216
  %217 = phi i64 [ 0, %.preheader3 ], [ %226, %216 ]
  %218 = phi i64 [ %.promoted13, %.preheader3 ], [ %225, %216 ]
  %219 = mul i64 %217, %6
  %220 = getelementptr i64, ptr %213, i64 %219
  %221 = load i64, ptr %220, align 4
  %222 = mul nuw nsw i64 %217, 10
  %gep12 = getelementptr i64, ptr %67, i64 %222
  %223 = load i64, ptr %gep12, align 16
  %224 = mul i64 %223, %221
  %225 = add i64 %218, %224
  store i64 %225, ptr %215, align 16
  %226 = add nuw nsw i64 %217, 1
  %227 = icmp ult i64 %217, 174
  br i1 %227, label %216, label %.preheader.1

.preheader.1:                                     ; preds = %216
  %228 = getelementptr i64, ptr %215, i64 1
  %.promoted13.1 = load i64, ptr %228, align 8
  br label %229

229:                                              ; preds = %229, %.preheader.1
  %230 = phi i64 [ 0, %.preheader.1 ], [ %239, %229 ]
  %231 = phi i64 [ %.promoted13.1, %.preheader.1 ], [ %238, %229 ]
  %232 = mul i64 %230, %6
  %233 = getelementptr i64, ptr %213, i64 %232
  %234 = load i64, ptr %233, align 4
  %235 = mul nuw nsw i64 %230, 10
  %gep12.1 = getelementptr i64, ptr %invariant.gep11.1, i64 %235
  %236 = load i64, ptr %gep12.1, align 8
  %237 = mul i64 %236, %234
  %238 = add i64 %231, %237
  store i64 %238, ptr %228, align 8
  %239 = add nuw nsw i64 %230, 1
  %240 = icmp ult i64 %230, 174
  br i1 %240, label %229, label %.preheader.2

.preheader.2:                                     ; preds = %229
  %241 = getelementptr i64, ptr %215, i64 2
  %.promoted13.2 = load i64, ptr %241, align 16
  br label %242

242:                                              ; preds = %242, %.preheader.2
  %243 = phi i64 [ 0, %.preheader.2 ], [ %252, %242 ]
  %244 = phi i64 [ %.promoted13.2, %.preheader.2 ], [ %251, %242 ]
  %245 = mul i64 %243, %6
  %246 = getelementptr i64, ptr %213, i64 %245
  %247 = load i64, ptr %246, align 4
  %248 = mul nuw nsw i64 %243, 10
  %gep12.2 = getelementptr i64, ptr %invariant.gep11.2, i64 %248
  %249 = load i64, ptr %gep12.2, align 16
  %250 = mul i64 %249, %247
  %251 = add i64 %244, %250
  store i64 %251, ptr %241, align 16
  %252 = add nuw nsw i64 %243, 1
  %253 = icmp ult i64 %243, 174
  br i1 %253, label %242, label %.preheader.3

.preheader.3:                                     ; preds = %242
  %254 = getelementptr i64, ptr %215, i64 3
  %.promoted13.3 = load i64, ptr %254, align 8
  br label %255

255:                                              ; preds = %255, %.preheader.3
  %256 = phi i64 [ 0, %.preheader.3 ], [ %265, %255 ]
  %257 = phi i64 [ %.promoted13.3, %.preheader.3 ], [ %264, %255 ]
  %258 = mul i64 %256, %6
  %259 = getelementptr i64, ptr %213, i64 %258
  %260 = load i64, ptr %259, align 4
  %261 = mul nuw nsw i64 %256, 10
  %gep12.3 = getelementptr i64, ptr %invariant.gep11.3, i64 %261
  %262 = load i64, ptr %gep12.3, align 8
  %263 = mul i64 %262, %260
  %264 = add i64 %257, %263
  store i64 %264, ptr %254, align 8
  %265 = add nuw nsw i64 %256, 1
  %266 = icmp ult i64 %256, 174
  br i1 %266, label %255, label %.preheader.4

.preheader.4:                                     ; preds = %255
  %267 = getelementptr i64, ptr %215, i64 4
  %.promoted13.4 = load i64, ptr %267, align 16
  br label %268

268:                                              ; preds = %268, %.preheader.4
  %269 = phi i64 [ 0, %.preheader.4 ], [ %278, %268 ]
  %270 = phi i64 [ %.promoted13.4, %.preheader.4 ], [ %277, %268 ]
  %271 = mul i64 %269, %6
  %272 = getelementptr i64, ptr %213, i64 %271
  %273 = load i64, ptr %272, align 4
  %274 = mul nuw nsw i64 %269, 10
  %gep12.4 = getelementptr i64, ptr %invariant.gep11.4, i64 %274
  %275 = load i64, ptr %gep12.4, align 16
  %276 = mul i64 %275, %273
  %277 = add i64 %270, %276
  store i64 %277, ptr %267, align 16
  %278 = add nuw nsw i64 %269, 1
  %279 = icmp ult i64 %269, 174
  br i1 %279, label %268, label %.preheader.5

.preheader.5:                                     ; preds = %268
  %280 = getelementptr i64, ptr %215, i64 5
  %.promoted13.5 = load i64, ptr %280, align 8
  br label %281

281:                                              ; preds = %281, %.preheader.5
  %282 = phi i64 [ 0, %.preheader.5 ], [ %291, %281 ]
  %283 = phi i64 [ %.promoted13.5, %.preheader.5 ], [ %290, %281 ]
  %284 = mul i64 %282, %6
  %285 = getelementptr i64, ptr %213, i64 %284
  %286 = load i64, ptr %285, align 4
  %287 = mul nuw nsw i64 %282, 10
  %gep12.5 = getelementptr i64, ptr %invariant.gep11.5, i64 %287
  %288 = load i64, ptr %gep12.5, align 8
  %289 = mul i64 %288, %286
  %290 = add i64 %283, %289
  store i64 %290, ptr %280, align 8
  %291 = add nuw nsw i64 %282, 1
  %292 = icmp ult i64 %282, 174
  br i1 %292, label %281, label %.preheader.6

.preheader.6:                                     ; preds = %281
  %293 = getelementptr i64, ptr %215, i64 6
  %.promoted13.6 = load i64, ptr %293, align 16
  br label %294

294:                                              ; preds = %294, %.preheader.6
  %295 = phi i64 [ 0, %.preheader.6 ], [ %304, %294 ]
  %296 = phi i64 [ %.promoted13.6, %.preheader.6 ], [ %303, %294 ]
  %297 = mul i64 %295, %6
  %298 = getelementptr i64, ptr %213, i64 %297
  %299 = load i64, ptr %298, align 4
  %300 = mul nuw nsw i64 %295, 10
  %gep12.6 = getelementptr i64, ptr %invariant.gep11.6, i64 %300
  %301 = load i64, ptr %gep12.6, align 16
  %302 = mul i64 %301, %299
  %303 = add i64 %296, %302
  store i64 %303, ptr %293, align 16
  %304 = add nuw nsw i64 %295, 1
  %305 = icmp ult i64 %295, 174
  br i1 %305, label %294, label %.preheader.7

.preheader.7:                                     ; preds = %294
  %306 = getelementptr i64, ptr %215, i64 7
  %.promoted13.7 = load i64, ptr %306, align 8
  br label %307

307:                                              ; preds = %307, %.preheader.7
  %308 = phi i64 [ 0, %.preheader.7 ], [ %317, %307 ]
  %309 = phi i64 [ %.promoted13.7, %.preheader.7 ], [ %316, %307 ]
  %310 = mul i64 %308, %6
  %311 = getelementptr i64, ptr %213, i64 %310
  %312 = load i64, ptr %311, align 4
  %313 = mul nuw nsw i64 %308, 10
  %gep12.7 = getelementptr i64, ptr %invariant.gep11.7, i64 %313
  %314 = load i64, ptr %gep12.7, align 8
  %315 = mul i64 %314, %312
  %316 = add i64 %309, %315
  store i64 %316, ptr %306, align 8
  %317 = add nuw nsw i64 %308, 1
  %318 = icmp ult i64 %308, 174
  br i1 %318, label %307, label %.preheader.8

.preheader.8:                                     ; preds = %307
  %319 = getelementptr i64, ptr %215, i64 8
  %.promoted13.8 = load i64, ptr %319, align 16
  br label %320

320:                                              ; preds = %320, %.preheader.8
  %321 = phi i64 [ 0, %.preheader.8 ], [ %330, %320 ]
  %322 = phi i64 [ %.promoted13.8, %.preheader.8 ], [ %329, %320 ]
  %323 = mul i64 %321, %6
  %324 = getelementptr i64, ptr %213, i64 %323
  %325 = load i64, ptr %324, align 4
  %326 = mul nuw nsw i64 %321, 10
  %gep12.8 = getelementptr i64, ptr %invariant.gep11.8, i64 %326
  %327 = load i64, ptr %gep12.8, align 16
  %328 = mul i64 %327, %325
  %329 = add i64 %322, %328
  store i64 %329, ptr %319, align 16
  %330 = add nuw nsw i64 %321, 1
  %331 = icmp ult i64 %321, 174
  br i1 %331, label %320, label %.preheader.9

.preheader.9:                                     ; preds = %320
  %332 = getelementptr i64, ptr %215, i64 9
  %.promoted13.9 = load i64, ptr %332, align 8
  br label %333

333:                                              ; preds = %333, %.preheader.9
  %334 = phi i64 [ 0, %.preheader.9 ], [ %343, %333 ]
  %335 = phi i64 [ %.promoted13.9, %.preheader.9 ], [ %342, %333 ]
  %336 = mul i64 %334, %6
  %337 = getelementptr i64, ptr %213, i64 %336
  %338 = load i64, ptr %337, align 4
  %339 = mul nuw nsw i64 %334, 10
  %gep12.9 = getelementptr i64, ptr %invariant.gep11.9, i64 %339
  %340 = load i64, ptr %gep12.9, align 8
  %341 = mul i64 %340, %338
  %342 = add i64 %335, %341
  store i64 %342, ptr %332, align 8
  %343 = add nuw nsw i64 %334, 1
  %344 = icmp ult i64 %334, 174
  br i1 %344, label %333, label %345

345:                                              ; preds = %333
  %346 = add nuw nsw i64 %211, 1
  %347 = icmp ult i64 %211, 199
  br i1 %347, label %.preheader3, label %348

348:                                              ; preds = %345
  %349 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %205, 0
  %350 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %349, ptr %209, 1
  %351 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %350, i64 0, 2
  %352 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %351, i64 200, 3, 0
  %353 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %352, i64 10, 3, 1
  %354 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %353, i64 10, 4, 0
  %355 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %354, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %355
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #2

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
