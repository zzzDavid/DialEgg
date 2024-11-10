; ModuleID = 'bench/2mm/run/2mm.ll'
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
  %22 = tail call dereferenceable_or_null(120064) ptr @malloc(i64 120064)
  %23 = ptrtoint ptr %22 to i64
  %24 = add i64 %23, 63
  %25 = and i64 %24, -64
  %26 = inttoptr i64 %25 to ptr
  %27 = getelementptr i64, ptr %1, i64 %2
  %28 = getelementptr i64, ptr %8, i64 %9
  %29 = shl i64 %6, 1
  %30 = shl i64 %12, 1
  %31 = mul i64 %6, 3
  %32 = mul i64 %12, 3
  %33 = shl i64 %6, 2
  %34 = shl i64 %12, 2
  %35 = mul i64 %6, 5
  %36 = mul i64 %12, 5
  %37 = mul i64 %6, 6
  %38 = mul i64 %12, 6
  %39 = mul i64 %6, 7
  %40 = mul i64 %12, 7
  %41 = shl i64 %6, 3
  %42 = shl i64 %12, 3
  %43 = mul i64 %6, 9
  %44 = mul i64 %12, 9
  br label %.preheader4

.preheader4:                                      ; preds = %21, %104
  %45 = phi i64 [ 0, %21 ], [ %105, %104 ]
  %46 = mul i64 %45, %5
  %47 = getelementptr i64, ptr %27, i64 %46
  %48 = mul nuw nsw i64 %45, 150
  %49 = getelementptr i64, ptr %26, i64 %48
  %50 = getelementptr i64, ptr %47, i64 %6
  %51 = getelementptr i64, ptr %47, i64 %29
  %52 = getelementptr i64, ptr %47, i64 %31
  %53 = getelementptr i64, ptr %47, i64 %33
  %54 = getelementptr i64, ptr %47, i64 %35
  %55 = getelementptr i64, ptr %47, i64 %37
  %56 = getelementptr i64, ptr %47, i64 %39
  %57 = getelementptr i64, ptr %47, i64 %41
  %58 = getelementptr i64, ptr %47, i64 %43
  br label %.preheader3

.preheader3:                                      ; preds = %.preheader4, %.preheader3
  %59 = phi i64 [ 0, %.preheader4 ], [ %102, %.preheader3 ]
  %60 = mul i64 %59, %13
  %invariant.gep = getelementptr i64, ptr %28, i64 %60
  %61 = getelementptr i64, ptr %49, i64 %59
  %.promoted = load i64, ptr %61, align 8
  %62 = load i64, ptr %47, align 4
  %63 = load i64, ptr %invariant.gep, align 4
  %64 = mul i64 %63, %62
  %65 = add i64 %.promoted, %64
  store i64 %65, ptr %61, align 8
  %66 = load i64, ptr %50, align 4
  %gep.1 = getelementptr i64, ptr %invariant.gep, i64 %12
  %67 = load i64, ptr %gep.1, align 4
  %68 = mul i64 %67, %66
  %69 = add i64 %65, %68
  store i64 %69, ptr %61, align 8
  %70 = load i64, ptr %51, align 4
  %gep.2 = getelementptr i64, ptr %invariant.gep, i64 %30
  %71 = load i64, ptr %gep.2, align 4
  %72 = mul i64 %71, %70
  %73 = add i64 %69, %72
  store i64 %73, ptr %61, align 8
  %74 = load i64, ptr %52, align 4
  %gep.3 = getelementptr i64, ptr %invariant.gep, i64 %32
  %75 = load i64, ptr %gep.3, align 4
  %76 = mul i64 %75, %74
  %77 = add i64 %73, %76
  store i64 %77, ptr %61, align 8
  %78 = load i64, ptr %53, align 4
  %gep.4 = getelementptr i64, ptr %invariant.gep, i64 %34
  %79 = load i64, ptr %gep.4, align 4
  %80 = mul i64 %79, %78
  %81 = add i64 %77, %80
  store i64 %81, ptr %61, align 8
  %82 = load i64, ptr %54, align 4
  %gep.5 = getelementptr i64, ptr %invariant.gep, i64 %36
  %83 = load i64, ptr %gep.5, align 4
  %84 = mul i64 %83, %82
  %85 = add i64 %81, %84
  store i64 %85, ptr %61, align 8
  %86 = load i64, ptr %55, align 4
  %gep.6 = getelementptr i64, ptr %invariant.gep, i64 %38
  %87 = load i64, ptr %gep.6, align 4
  %88 = mul i64 %87, %86
  %89 = add i64 %85, %88
  store i64 %89, ptr %61, align 8
  %90 = load i64, ptr %56, align 4
  %gep.7 = getelementptr i64, ptr %invariant.gep, i64 %40
  %91 = load i64, ptr %gep.7, align 4
  %92 = mul i64 %91, %90
  %93 = add i64 %89, %92
  store i64 %93, ptr %61, align 8
  %94 = load i64, ptr %57, align 4
  %gep.8 = getelementptr i64, ptr %invariant.gep, i64 %42
  %95 = load i64, ptr %gep.8, align 4
  %96 = mul i64 %95, %94
  %97 = add i64 %93, %96
  store i64 %97, ptr %61, align 8
  %98 = load i64, ptr %58, align 4
  %gep.9 = getelementptr i64, ptr %invariant.gep, i64 %44
  %99 = load i64, ptr %gep.9, align 4
  %100 = mul i64 %99, %98
  %101 = add i64 %97, %100
  store i64 %101, ptr %61, align 8
  %102 = add nuw nsw i64 %59, 1
  %103 = icmp ult i64 %59, 149
  br i1 %103, label %.preheader3, label %104

104:                                              ; preds = %.preheader3
  %105 = add nuw nsw i64 %45, 1
  %106 = icmp ult i64 %45, 99
  br i1 %106, label %.preheader4, label %107

107:                                              ; preds = %104
  %108 = tail call dereferenceable_or_null(6464) ptr @malloc(i64 6464)
  %109 = ptrtoint ptr %108 to i64
  %110 = add i64 %109, 63
  %111 = and i64 %110, -64
  %112 = inttoptr i64 %111 to ptr
  %113 = getelementptr i64, ptr %15, i64 %16
  %invariant.gep5.1 = getelementptr i64, ptr %113, i64 %20
  %114 = shl i64 %20, 1
  %invariant.gep5.2 = getelementptr i64, ptr %113, i64 %114
  %115 = mul i64 %20, 3
  %invariant.gep5.3 = getelementptr i64, ptr %113, i64 %115
  %116 = shl i64 %20, 2
  %invariant.gep5.4 = getelementptr i64, ptr %113, i64 %116
  %117 = mul i64 %20, 5
  %invariant.gep5.5 = getelementptr i64, ptr %113, i64 %117
  %118 = mul i64 %20, 6
  %invariant.gep5.6 = getelementptr i64, ptr %113, i64 %118
  %119 = mul i64 %20, 7
  %invariant.gep5.7 = getelementptr i64, ptr %113, i64 %119
  br label %.preheader2

.preheader2:                                      ; preds = %107, %220
  %120 = phi i64 [ 0, %107 ], [ %221, %220 ]
  %121 = mul nuw nsw i64 %120, 150
  %122 = getelementptr i64, ptr %26, i64 %121
  %123 = shl nuw nsw i64 %120, 3
  %124 = getelementptr i64, ptr %112, i64 %123
  %.promoted7 = load i64, ptr %124, align 64
  br label %125

125:                                              ; preds = %.preheader2, %125
  %126 = phi i64 [ 0, %.preheader2 ], [ %134, %125 ]
  %127 = phi i64 [ %.promoted7, %.preheader2 ], [ %133, %125 ]
  %128 = getelementptr i64, ptr %122, i64 %126
  %129 = load i64, ptr %128, align 8
  %130 = mul i64 %126, %19
  %gep6 = getelementptr i64, ptr %113, i64 %130
  %131 = load i64, ptr %gep6, align 4
  %132 = mul i64 %131, %129
  %133 = add i64 %127, %132
  store i64 %133, ptr %124, align 64
  %134 = add nuw nsw i64 %126, 1
  %135 = icmp ult i64 %126, 149
  br i1 %135, label %125, label %.preheader.1

.preheader.1:                                     ; preds = %125
  %136 = getelementptr i64, ptr %124, i64 1
  %.promoted7.1 = load i64, ptr %136, align 8
  br label %137

137:                                              ; preds = %137, %.preheader.1
  %138 = phi i64 [ 0, %.preheader.1 ], [ %146, %137 ]
  %139 = phi i64 [ %.promoted7.1, %.preheader.1 ], [ %145, %137 ]
  %140 = getelementptr i64, ptr %122, i64 %138
  %141 = load i64, ptr %140, align 8
  %142 = mul i64 %138, %19
  %gep6.1 = getelementptr i64, ptr %invariant.gep5.1, i64 %142
  %143 = load i64, ptr %gep6.1, align 4
  %144 = mul i64 %143, %141
  %145 = add i64 %139, %144
  store i64 %145, ptr %136, align 8
  %146 = add nuw nsw i64 %138, 1
  %147 = icmp ult i64 %138, 149
  br i1 %147, label %137, label %.preheader.2

.preheader.2:                                     ; preds = %137
  %148 = getelementptr i64, ptr %124, i64 2
  %.promoted7.2 = load i64, ptr %148, align 16
  br label %149

149:                                              ; preds = %149, %.preheader.2
  %150 = phi i64 [ 0, %.preheader.2 ], [ %158, %149 ]
  %151 = phi i64 [ %.promoted7.2, %.preheader.2 ], [ %157, %149 ]
  %152 = getelementptr i64, ptr %122, i64 %150
  %153 = load i64, ptr %152, align 8
  %154 = mul i64 %150, %19
  %gep6.2 = getelementptr i64, ptr %invariant.gep5.2, i64 %154
  %155 = load i64, ptr %gep6.2, align 4
  %156 = mul i64 %155, %153
  %157 = add i64 %151, %156
  store i64 %157, ptr %148, align 16
  %158 = add nuw nsw i64 %150, 1
  %159 = icmp ult i64 %150, 149
  br i1 %159, label %149, label %.preheader.3

.preheader.3:                                     ; preds = %149
  %160 = getelementptr i64, ptr %124, i64 3
  %.promoted7.3 = load i64, ptr %160, align 8
  br label %161

161:                                              ; preds = %161, %.preheader.3
  %162 = phi i64 [ 0, %.preheader.3 ], [ %170, %161 ]
  %163 = phi i64 [ %.promoted7.3, %.preheader.3 ], [ %169, %161 ]
  %164 = getelementptr i64, ptr %122, i64 %162
  %165 = load i64, ptr %164, align 8
  %166 = mul i64 %162, %19
  %gep6.3 = getelementptr i64, ptr %invariant.gep5.3, i64 %166
  %167 = load i64, ptr %gep6.3, align 4
  %168 = mul i64 %167, %165
  %169 = add i64 %163, %168
  store i64 %169, ptr %160, align 8
  %170 = add nuw nsw i64 %162, 1
  %171 = icmp ult i64 %162, 149
  br i1 %171, label %161, label %.preheader.4

.preheader.4:                                     ; preds = %161
  %172 = getelementptr i64, ptr %124, i64 4
  %.promoted7.4 = load i64, ptr %172, align 32
  br label %173

173:                                              ; preds = %173, %.preheader.4
  %174 = phi i64 [ 0, %.preheader.4 ], [ %182, %173 ]
  %175 = phi i64 [ %.promoted7.4, %.preheader.4 ], [ %181, %173 ]
  %176 = getelementptr i64, ptr %122, i64 %174
  %177 = load i64, ptr %176, align 8
  %178 = mul i64 %174, %19
  %gep6.4 = getelementptr i64, ptr %invariant.gep5.4, i64 %178
  %179 = load i64, ptr %gep6.4, align 4
  %180 = mul i64 %179, %177
  %181 = add i64 %175, %180
  store i64 %181, ptr %172, align 32
  %182 = add nuw nsw i64 %174, 1
  %183 = icmp ult i64 %174, 149
  br i1 %183, label %173, label %.preheader.5

.preheader.5:                                     ; preds = %173
  %184 = getelementptr i64, ptr %124, i64 5
  %.promoted7.5 = load i64, ptr %184, align 8
  br label %185

185:                                              ; preds = %185, %.preheader.5
  %186 = phi i64 [ 0, %.preheader.5 ], [ %194, %185 ]
  %187 = phi i64 [ %.promoted7.5, %.preheader.5 ], [ %193, %185 ]
  %188 = getelementptr i64, ptr %122, i64 %186
  %189 = load i64, ptr %188, align 8
  %190 = mul i64 %186, %19
  %gep6.5 = getelementptr i64, ptr %invariant.gep5.5, i64 %190
  %191 = load i64, ptr %gep6.5, align 4
  %192 = mul i64 %191, %189
  %193 = add i64 %187, %192
  store i64 %193, ptr %184, align 8
  %194 = add nuw nsw i64 %186, 1
  %195 = icmp ult i64 %186, 149
  br i1 %195, label %185, label %.preheader.6

.preheader.6:                                     ; preds = %185
  %196 = getelementptr i64, ptr %124, i64 6
  %.promoted7.6 = load i64, ptr %196, align 16
  br label %197

197:                                              ; preds = %197, %.preheader.6
  %198 = phi i64 [ 0, %.preheader.6 ], [ %206, %197 ]
  %199 = phi i64 [ %.promoted7.6, %.preheader.6 ], [ %205, %197 ]
  %200 = getelementptr i64, ptr %122, i64 %198
  %201 = load i64, ptr %200, align 8
  %202 = mul i64 %198, %19
  %gep6.6 = getelementptr i64, ptr %invariant.gep5.6, i64 %202
  %203 = load i64, ptr %gep6.6, align 4
  %204 = mul i64 %203, %201
  %205 = add i64 %199, %204
  store i64 %205, ptr %196, align 16
  %206 = add nuw nsw i64 %198, 1
  %207 = icmp ult i64 %198, 149
  br i1 %207, label %197, label %.preheader.7

.preheader.7:                                     ; preds = %197
  %208 = getelementptr i64, ptr %124, i64 7
  %.promoted7.7 = load i64, ptr %208, align 8
  br label %209

209:                                              ; preds = %209, %.preheader.7
  %210 = phi i64 [ 0, %.preheader.7 ], [ %218, %209 ]
  %211 = phi i64 [ %.promoted7.7, %.preheader.7 ], [ %217, %209 ]
  %212 = getelementptr i64, ptr %122, i64 %210
  %213 = load i64, ptr %212, align 8
  %214 = mul i64 %210, %19
  %gep6.7 = getelementptr i64, ptr %invariant.gep5.7, i64 %214
  %215 = load i64, ptr %gep6.7, align 4
  %216 = mul i64 %215, %213
  %217 = add i64 %211, %216
  store i64 %217, ptr %208, align 8
  %218 = add nuw nsw i64 %210, 1
  %219 = icmp ult i64 %210, 149
  br i1 %219, label %209, label %220

220:                                              ; preds = %209
  %221 = add nuw nsw i64 %120, 1
  %222 = icmp ult i64 %120, 99
  br i1 %222, label %.preheader2, label %223

223:                                              ; preds = %220
  %224 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %108, 0
  %225 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %224, ptr %112, 1
  %226 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %225, i64 0, 2
  %227 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %226, i64 100, 3, 0
  %228 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %227, i64 8, 3, 1
  %229 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %228, i64 8, 4, 0
  %230 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %229, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %230
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.floor.f64(double) #2

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
