; ModuleID = 'bench/vector_norm/run/vector_norm.eqsat.ll'
source_filename = "LLVMDialectModule"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

declare void @displayTime(i64, i64) local_unnamed_addr

declare void @printF32Tensor2D(ptr, ptr, i64, i64, i64, i64, i64) local_unnamed_addr

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: write)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #1 {
  %8 = icmp sgt i64 %3, 0
  br i1 %8, label %.preheader.lr.ph, label %._crit_edge4

.preheader.lr.ph:                                 ; preds = %7
  %9 = icmp sgt i64 %4, 0
  %10 = getelementptr double, ptr %1, i64 %2
  br i1 %9, label %.preheader.us, label %._crit_edge4

.preheader.us:                                    ; preds = %.preheader.lr.ph, %._crit_edge.us
  %11 = phi i64 [ %31, %._crit_edge.us ], [ 0, %.preheader.lr.ph ]
  %12 = trunc i64 %11 to i32
  %13 = mul i32 %12, 1103515245
  %14 = add i32 %13, 12345
  %15 = mul i64 %11, %5
  %16 = getelementptr double, ptr %10, i64 %15
  br label %17

17:                                               ; preds = %.preheader.us, %17
  %18 = phi i64 [ 0, %.preheader.us ], [ %29, %17 ]
  %19 = trunc i64 %18 to i32
  %20 = add i32 %14, %19
  %21 = mul i32 %20, 1103515245
  %22 = add i32 %21, 12345
  %23 = sitofp i32 %22 to double
  %24 = fadd double %23, 0x41DFFFFFFFC00000
  %25 = fmul double %24, 0x3E33FFFFFABBF5C5
  %26 = fadd double %25, -1.000000e+01
  %27 = mul i64 %18, %6
  %28 = getelementptr double, ptr %16, i64 %27
  store double %26, ptr %28, align 8
  %29 = add nuw nsw i64 %18, 1
  %30 = icmp slt i64 %29, %4
  br i1 %30, label %17, label %._crit_edge.us

._crit_edge.us:                                   ; preds = %17
  %31 = add nuw nsw i64 %11, 1
  %32 = icmp slt i64 %31, %3
  br i1 %32, label %.preheader.us, label %._crit_edge4

._crit_edge4:                                     ; preds = %._crit_edge.us, %.preheader.lr.ph, %7
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, ptr %1, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %2, 2
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, i64 %3, 3, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, i64 %5, 4, 0
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %4, 3, 1
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %39
}

; Function Attrs: nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #2 {
  %8 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %9 = ptrtoint ptr %8 to i64
  %10 = add i64 %9, 63
  %11 = and i64 %10, -64
  %12 = inttoptr i64 %11 to ptr
  %13 = getelementptr float, ptr %1, i64 %2
  %14 = shl i64 %6, 1
  br label %15

15:                                               ; preds = %7, %15
  %16 = phi i64 [ 0, %7 ], [ %45, %15 ]
  %17 = mul i64 %16, %5
  %18 = getelementptr float, ptr %13, i64 %17
  %19 = load float, ptr %18, align 4
  %20 = getelementptr float, ptr %18, i64 %6
  %21 = load float, ptr %20, align 4
  %22 = getelementptr float, ptr %18, i64 %14
  %23 = load float, ptr %22, align 4
  %24 = fmul float %19, %19
  %25 = fmul float %21, %21
  %26 = fmul float %23, %23
  %27 = fadd float %24, %25
  %28 = fadd float %27, %26
  %29 = fmul float %28, 5.000000e-01
  %30 = bitcast float %28 to i32
  %31 = ashr i32 %30, 1
  %32 = sub i32 1597463007, %31
  %33 = bitcast i32 %32 to float
  %34 = fmul float %33, %33
  %35 = fmul float %29, %34
  %36 = fsub float 1.500000e+00, %35
  %37 = fmul float %36, %33
  %38 = fmul float %19, %37
  %39 = fmul float %21, %37
  %40 = fmul float %23, %37
  %41 = mul nuw nsw i64 %16, 3
  %42 = getelementptr float, ptr %12, i64 %41
  store float %38, ptr %42, align 4
  %43 = getelementptr float, ptr %42, i64 1
  store float %39, ptr %43, align 4
  %44 = getelementptr float, ptr %42, i64 2
  store float %40, ptr %44, align 4
  %45 = add nuw nsw i64 %16, 1
  %46 = icmp ult i64 %16, 999999
  br i1 %46, label %15, label %47

47:                                               ; preds = %15
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %8, 0
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, ptr %12, 1
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 0, 2
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 1000000, 3, 0
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 3, 3, 1
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 3, 4, 0
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %54
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call dereferenceable_or_null(24000064) ptr @malloc(i64 24000064)
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = and i64 %3, -64
  %5 = inttoptr i64 %4 to ptr
  br label %.preheader.us.i

.preheader.us.i:                                  ; preds = %.preheader.us.i, %0
  %6 = phi i64 [ %30, %.preheader.us.i ], [ 0, %0 ]
  %7 = trunc i64 %6 to i32
  %8 = mul nuw nsw i64 %6, 3
  %9 = getelementptr double, ptr %5, i64 %8
  %10 = mul i32 %7, -1029531031
  %11 = add i32 %10, -740551042
  %12 = sitofp i32 %11 to double
  %13 = fadd double %12, 0x41DFFFFFFFC00000
  %14 = fmul double %13, 0x3E33FFFFFABBF5C5
  %15 = fadd double %14, -1.000000e+01
  store double %15, ptr %9, align 8
  %16 = mul i32 %7, -1029531031
  %17 = add i32 %16, 362964203
  %18 = sitofp i32 %17 to double
  %19 = fadd double %18, 0x41DFFFFFFFC00000
  %20 = fmul double %19, 0x3E33FFFFFABBF5C5
  %21 = fadd double %20, -1.000000e+01
  %22 = getelementptr double, ptr %9, i64 1
  store double %21, ptr %22, align 8
  %23 = mul i32 %7, -1029531031
  %24 = add i32 %23, 1466479448
  %25 = sitofp i32 %24 to double
  %26 = fadd double %25, 0x41DFFFFFFFC00000
  %27 = fmul double %26, 0x3E33FFFFFABBF5C5
  %28 = fadd double %27, -1.000000e+01
  %29 = getelementptr double, ptr %9, i64 2
  store double %28, ptr %29, align 8
  %30 = add nuw nsw i64 %6, 1
  %31 = icmp ult i64 %6, 999999
  br i1 %31, label %.preheader.us.i, label %fillRandomF64Tensor2D.exit

fillRandomF64Tensor2D.exit:                       ; preds = %.preheader.us.i
  %32 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %33 = ptrtoint ptr %32 to i64
  %34 = add i64 %33, 63
  %35 = and i64 %34, -64
  %36 = inttoptr i64 %35 to ptr
  br label %.preheader

.preheader:                                       ; preds = %fillRandomF64Tensor2D.exit, %.preheader
  %37 = phi i64 [ 0, %fillRandomF64Tensor2D.exit ], [ %51, %.preheader ]
  %38 = mul nuw nsw i64 %37, 3
  %39 = getelementptr double, ptr %5, i64 %38
  %40 = getelementptr float, ptr %36, i64 %38
  %41 = load double, ptr %39, align 8
  %42 = fptrunc double %41 to float
  store float %42, ptr %40, align 4
  %43 = getelementptr double, ptr %39, i64 1
  %44 = load double, ptr %43, align 8
  %45 = fptrunc double %44 to float
  %46 = getelementptr float, ptr %40, i64 1
  store float %45, ptr %46, align 4
  %47 = getelementptr double, ptr %39, i64 2
  %48 = load double, ptr %47, align 8
  %49 = fptrunc double %48 to float
  %50 = getelementptr float, ptr %40, i64 2
  store float %49, ptr %50, align 4
  %51 = add nuw nsw i64 %37, 1
  %52 = icmp ult i64 %37, 999999
  br i1 %52, label %.preheader, label %53

53:                                               ; preds = %.preheader
  %54 = tail call i64 @clock()
  %55 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %56 = ptrtoint ptr %55 to i64
  %57 = add i64 %56, 63
  %58 = and i64 %57, -64
  %59 = inttoptr i64 %58 to ptr
  br label %60

60:                                               ; preds = %60, %53
  %61 = phi i64 [ 0, %53 ], [ %89, %60 ]
  %62 = mul nuw nsw i64 %61, 3
  %63 = getelementptr float, ptr %36, i64 %62
  %64 = load float, ptr %63, align 4
  %65 = getelementptr float, ptr %63, i64 1
  %66 = load float, ptr %65, align 4
  %67 = getelementptr float, ptr %63, i64 2
  %68 = load float, ptr %67, align 4
  %69 = fmul float %64, %64
  %70 = fmul float %66, %66
  %71 = fmul float %68, %68
  %72 = fadd float %69, %70
  %73 = fadd float %72, %71
  %74 = fmul float %73, 5.000000e-01
  %75 = bitcast float %73 to i32
  %76 = ashr i32 %75, 1
  %77 = sub i32 1597463007, %76
  %78 = bitcast i32 %77 to float
  %79 = fmul float %78, %78
  %80 = fmul float %74, %79
  %81 = fsub float 1.500000e+00, %80
  %82 = fmul float %81, %78
  %83 = fmul float %64, %82
  %84 = fmul float %66, %82
  %85 = fmul float %68, %82
  %86 = getelementptr float, ptr %59, i64 %62
  store float %83, ptr %86, align 4
  %87 = getelementptr float, ptr %86, i64 1
  store float %84, ptr %87, align 4
  %88 = getelementptr float, ptr %86, i64 2
  store float %85, ptr %88, align 4
  %89 = add nuw nsw i64 %61, 1
  %90 = icmp ult i64 %61, 999999
  br i1 %90, label %60, label %normalize_distance_vectors.exit

normalize_distance_vectors.exit:                  ; preds = %60
  %91 = tail call i64 @clock()
  tail call void @printF32Tensor2D(ptr %55, ptr nonnull %59, i64 0, i64 1000000, i64 3, i64 3, i64 1)
  tail call void @printNewline()
  tail call void @displayTime(i64 %54, i64 %91)
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define float @fast_inv_sqrt(float %0) local_unnamed_addr #3 {
  %2 = fmul float %0, 5.000000e-01
  %3 = bitcast float %0 to i32
  %4 = ashr i32 %3, 1
  %5 = sub i32 1597463007, %4
  %6 = bitcast i32 %5 to float
  %7 = fmul float %6, %6
  %8 = fmul float %2, %7
  %9 = fsub float 1.500000e+00, %8
  %10 = fmul float %9, %6
  ret float %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { float, float, float } @normalize_vector(float %0, float %1, float %2) local_unnamed_addr #3 {
  %4 = fmul float %0, %0
  %5 = fmul float %1, %1
  %6 = fmul float %2, %2
  %7 = fadd float %4, %5
  %8 = fadd float %7, %6
  %9 = fmul float %8, 5.000000e-01
  %10 = bitcast float %8 to i32
  %11 = ashr i32 %10, 1
  %12 = sub i32 1597463007, %11
  %13 = bitcast i32 %12 to float
  %14 = fmul float %13, %13
  %15 = fmul float %9, %14
  %16 = fsub float 1.500000e+00, %15
  %17 = fmul float %16, %13
  %18 = fmul float %17, %0
  %19 = fmul float %17, %1
  %20 = fmul float %17, %2
  %21 = insertvalue { float, float, float } undef, float %18, 0
  %22 = insertvalue { float, float, float } %21, float %19, 1
  %23 = insertvalue { float, float, float } %22, float %20, 2
  ret { float, float, float } %23
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #2 = { nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
