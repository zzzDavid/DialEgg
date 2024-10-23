; ModuleID = 'bench/run/math_inv_sqrt_.eqsat+canon.ll'
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
  %5 = fdiv double %4, 1.000000e+06
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define float @fast_inv_sqrt(float %0) local_unnamed_addr #2 {
  %2 = bitcast float %0 to i32
  %3 = ashr i32 %2, 1
  %4 = sub i32 1597463007, %3
  %5 = bitcast i32 %4 to float
  %6 = fmul fast float %0, 5.000000e-01
  %7 = fmul fast float %5, %5
  %8 = fmul fast float %7, %6
  %9 = fsub fast float 1.500000e+00, %8
  %10 = fmul fast float %9, %5
  ret float %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { float, float, float } @normalize_vector(float %0, float %1, float %2) local_unnamed_addr #2 {
  %4 = fmul float %0, %0
  %5 = fmul float %1, %1
  %6 = fmul float %2, %2
  %7 = fadd float %4, %5
  %8 = fadd float %7, %6
  %9 = bitcast float %8 to i32
  %10 = ashr i32 %9, 1
  %11 = sub i32 1597463007, %10
  %12 = bitcast i32 %11 to float
  %13 = fmul fast float %8, 5.000000e-01
  %14 = fmul fast float %12, %12
  %15 = fmul fast float %14, %13
  %16 = fsub fast float 1.500000e+00, %15
  %17 = fmul fast float %16, %12
  %18 = fmul float %17, %0
  %19 = fmul float %17, %1
  %20 = fmul float %17, %2
  %21 = insertvalue { float, float, float } undef, float %18, 0
  %22 = insertvalue { float, float, float } %21, float %19, 1
  %23 = insertvalue { float, float, float } %22, float %20, 2
  ret { float, float, float } %23
}

; Function Attrs: nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #3 {
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
  %29 = bitcast float %28 to i32
  %30 = ashr i32 %29, 1
  %31 = sub i32 1597463007, %30
  %32 = bitcast i32 %31 to float
  %33 = fmul fast float %28, 5.000000e-01
  %34 = fmul fast float %32, %32
  %35 = fmul fast float %34, %33
  %36 = fsub fast float 1.500000e+00, %35
  %37 = fmul fast float %36, %32
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
  %6 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %7 = ptrtoint ptr %6 to i64
  %8 = add i64 %7, 63
  %9 = and i64 %8, -64
  %10 = inttoptr i64 %9 to ptr
  br label %.preheader

.preheader:                                       ; preds = %0, %.preheader
  %11 = phi i64 [ 0, %0 ], [ %27, %.preheader ]
  %12 = mul nuw nsw i64 %11, 3
  %13 = getelementptr double, ptr %5, i64 %12
  %14 = load double, ptr %13, align 8
  %15 = fptrunc double %14 to float
  %16 = getelementptr float, ptr %10, i64 %12
  store float %15, ptr %16, align 4
  %17 = add nuw nsw i64 %12, 1
  %18 = getelementptr double, ptr %5, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = fptrunc double %19 to float
  %21 = getelementptr float, ptr %10, i64 %17
  store float %20, ptr %21, align 4
  %22 = add nuw nsw i64 %12, 2
  %23 = getelementptr double, ptr %5, i64 %22
  %24 = load double, ptr %23, align 8
  %25 = fptrunc double %24 to float
  %26 = getelementptr float, ptr %10, i64 %22
  store float %25, ptr %26, align 4
  %27 = add nuw nsw i64 %11, 1
  %28 = icmp ult i64 %11, 999999
  br i1 %28, label %.preheader, label %29

29:                                               ; preds = %.preheader
  %30 = tail call i64 @clock()
  %31 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %32 = ptrtoint ptr %31 to i64
  %33 = add i64 %32, 63
  %34 = and i64 %33, -64
  %35 = inttoptr i64 %34 to ptr
  br label %36

36:                                               ; preds = %36, %29
  %37 = phi i64 [ 0, %29 ], [ %65, %36 ]
  %38 = mul nuw nsw i64 %37, 3
  %39 = getelementptr float, ptr %10, i64 %38
  %40 = load float, ptr %39, align 4
  %41 = getelementptr float, ptr %39, i64 1
  %42 = load float, ptr %41, align 4
  %43 = getelementptr float, ptr %39, i64 2
  %44 = load float, ptr %43, align 4
  %45 = fmul float %40, %40
  %46 = fmul float %42, %42
  %47 = fmul float %44, %44
  %48 = fadd float %45, %46
  %49 = fadd float %48, %47
  %50 = bitcast float %49 to i32
  %51 = ashr i32 %50, 1
  %52 = sub i32 1597463007, %51
  %53 = bitcast i32 %52 to float
  %54 = fmul fast float %49, 5.000000e-01
  %55 = fmul fast float %53, %53
  %56 = fmul fast float %55, %54
  %57 = fsub fast float 1.500000e+00, %56
  %58 = fmul fast float %57, %53
  %59 = fmul float %40, %58
  %60 = fmul float %42, %58
  %61 = fmul float %44, %58
  %62 = getelementptr float, ptr %35, i64 %38
  store float %59, ptr %62, align 4
  %63 = getelementptr float, ptr %62, i64 1
  store float %60, ptr %63, align 4
  %64 = getelementptr float, ptr %62, i64 2
  store float %61, ptr %64, align 4
  %65 = add nuw nsw i64 %37, 1
  %66 = icmp ult i64 %37, 999999
  br i1 %66, label %36, label %normalize_distance_vectors.exit

normalize_distance_vectors.exit:                  ; preds = %36
  %67 = tail call i64 @clock()
  %68 = sub i64 %67, %30
  %69 = uitofp i64 %68 to double
  %70 = fdiv double %69, 1.000000e+06
  %71 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %68, double %70)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #3 = { nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
