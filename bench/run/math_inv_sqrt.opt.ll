; ModuleID = 'bench/run/math_inv_sqrt.ll'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printF64(double) local_unnamed_addr

declare void @printComma() local_unnamed_addr

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
define void @displayTime(i64 %0, i64 %1) local_unnamed_addr #1 {
  %3 = sub i64 %1, %0
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+08
  %6 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %3, double %5)
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: write)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @fillRandomF64Tensor2D(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #2 {
  %8 = getelementptr double, ptr %1, i64 %2
  %9 = shl i64 %6, 1
  br label %.preheader

.preheader:                                       ; preds = %7, %.preheader
  %10 = phi i64 [ 0, %7 ], [ %34, %.preheader ]
  %11 = trunc i64 %10 to i32
  %12 = mul i64 %10, %5
  %13 = getelementptr double, ptr %8, i64 %12
  %14 = mul i32 %11, -1029531031
  %15 = add i32 %14, -740551042
  %16 = sitofp i32 %15 to double
  %17 = fadd double %16, 0x41DFFFFFFFC00000
  %18 = fmul double %17, 0x3F0869FFF9927183
  %19 = fadd double %18, -1.000000e+05
  store double %19, ptr %13, align 8
  %20 = mul i32 %11, -1029531031
  %21 = add i32 %20, 362964203
  %22 = sitofp i32 %21 to double
  %23 = fadd double %22, 0x41DFFFFFFFC00000
  %24 = fmul double %23, 0x3F0869FFF9927183
  %25 = fadd double %24, -1.000000e+05
  %26 = getelementptr double, ptr %13, i64 %6
  store double %25, ptr %26, align 8
  %27 = mul i32 %11, -1029531031
  %28 = add i32 %27, 1466479448
  %29 = sitofp i32 %28 to double
  %30 = fadd double %29, 0x41DFFFFFFFC00000
  %31 = fmul double %30, 0x3F0869FFF9927183
  %32 = fadd double %31, -1.000000e+05
  %33 = getelementptr double, ptr %13, i64 %9
  store double %32, ptr %33, align 8
  %34 = add nuw nsw i64 %10, 1
  %35 = icmp ult i64 %10, 99999
  br i1 %35, label %.preheader, label %36

36:                                               ; preds = %.preheader
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, ptr %1, 1
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %2, 2
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %3, 3, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %5, 4, 0
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %4, 3, 1
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %43
}

define void @printF64Tensor1D(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr {
  %6 = tail call i32 @putchar(i32 91)
  %7 = icmp sgt i64 %3, 0
  br i1 %7, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %5
  %8 = getelementptr double, ptr %1, i64 %2
  %9 = add nsw i64 %3, -1
  br label %10

10:                                               ; preds = %.lr.ph, %17
  %11 = phi i64 [ 0, %.lr.ph ], [ %18, %17 ]
  %12 = mul i64 %11, %4
  %13 = getelementptr double, ptr %8, i64 %12
  %14 = load double, ptr %13, align 8
  tail call void @printF64(double %14)
  %15 = icmp ult i64 %11, %9
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @printComma()
  br label %17

17:                                               ; preds = %16, %10
  %18 = add nuw nsw i64 %11, 1
  %19 = icmp slt i64 %18, %3
  br i1 %19, label %10, label %._crit_edge

._crit_edge:                                      ; preds = %17, %5
  %20 = tail call i32 @putchar(i32 93)
  ret void
}

define void @printF64Tensor2D(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr {
  %.fr4 = freeze i64 %4
  %8 = tail call i32 @putchar(i32 91)
  %invariant.gep = getelementptr double, ptr %1, i64 %2
  %9 = icmp sgt i64 %3, 0
  br i1 %9, label %.lr.ph, label %._crit_edge.thread

.lr.ph:                                           ; preds = %7
  %10 = icmp sgt i64 %.fr4, 0
  %11 = add nsw i64 %.fr4, -1
  %12 = add nsw i64 %3, -1
  br i1 %10, label %.lr.ph.i.us, label %printF64Tensor1D.exit

.lr.ph.i.us:                                      ; preds = %.lr.ph, %28
  %13 = phi i64 [ %29, %28 ], [ 0, %.lr.ph ]
  tail call void @printNewline()
  %14 = tail call i32 @putchar(i32 9)
  %15 = tail call i32 @putchar(i32 91)
  %16 = mul i64 %13, %5
  %gep.us = getelementptr double, ptr %invariant.gep, i64 %16
  br label %17

17:                                               ; preds = %24, %.lr.ph.i.us
  %18 = phi i64 [ 0, %.lr.ph.i.us ], [ %25, %24 ]
  %19 = mul i64 %18, %6
  %20 = getelementptr double, ptr %gep.us, i64 %19
  %21 = load double, ptr %20, align 8
  tail call void @printF64(double %21)
  %22 = icmp ult i64 %18, %11
  br i1 %22, label %23, label %24

23:                                               ; preds = %17
  tail call void @printComma()
  br label %24

24:                                               ; preds = %23, %17
  %25 = add nuw nsw i64 %18, 1
  %26 = icmp slt i64 %25, %.fr4
  br i1 %26, label %17, label %printF64Tensor1D.exit.loopexit.us

27:                                               ; preds = %printF64Tensor1D.exit.loopexit.us
  tail call void @printComma()
  br label %28

28:                                               ; preds = %27, %printF64Tensor1D.exit.loopexit.us
  %29 = add nuw nsw i64 %13, 1
  %30 = icmp slt i64 %29, %3
  br i1 %30, label %.lr.ph.i.us, label %._crit_edge

printF64Tensor1D.exit.loopexit.us:                ; preds = %24
  %31 = tail call i32 @putchar(i32 93)
  %32 = icmp ult i64 %13, %12
  br i1 %32, label %27, label %28

printF64Tensor1D.exit:                            ; preds = %.lr.ph, %39
  %33 = phi i64 [ %40, %39 ], [ 0, %.lr.ph ]
  tail call void @printNewline()
  %34 = tail call i32 @putchar(i32 9)
  %35 = tail call i32 @putchar(i32 91)
  %36 = tail call i32 @putchar(i32 93)
  %37 = icmp ult i64 %33, %12
  br i1 %37, label %38, label %39

38:                                               ; preds = %printF64Tensor1D.exit
  tail call void @printComma()
  br label %39

39:                                               ; preds = %38, %printF64Tensor1D.exit
  %40 = add nuw nsw i64 %33, 1
  %41 = icmp slt i64 %40, %3
  br i1 %41, label %printF64Tensor1D.exit, label %._crit_edge

._crit_edge:                                      ; preds = %39, %28
  br i1 %9, label %42, label %._crit_edge.thread

42:                                               ; preds = %._crit_edge
  tail call void @printNewline()
  br label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %7, %42, %._crit_edge
  %43 = tail call i32 @putchar(i32 93)
  ret void
}

define void @printF32Tensor2D(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr {
  %8 = shl i64 %3, 3
  %.idx = mul i64 %8, %4
  %9 = add i64 %.idx, 64
  %10 = tail call ptr @malloc(i64 %9)
  %11 = ptrtoint ptr %10 to i64
  %12 = add i64 %11, 63
  %13 = and i64 %12, -64
  %14 = inttoptr i64 %13 to ptr
  %15 = icmp sgt i64 %3, 0
  br i1 %15, label %.preheader.lr.ph, label %._crit_edge12

.preheader.lr.ph:                                 ; preds = %7
  %16 = icmp sgt i64 %4, 0
  %17 = getelementptr float, ptr %1, i64 %2
  br i1 %16, label %.preheader.us, label %._crit_edge12

.preheader.us:                                    ; preds = %.preheader.lr.ph, %._crit_edge.us
  %18 = phi i64 [ %32, %._crit_edge.us ], [ 0, %.preheader.lr.ph ]
  %19 = mul i64 %18, %5
  %20 = getelementptr float, ptr %17, i64 %19
  %21 = mul i64 %18, %4
  %22 = getelementptr double, ptr %14, i64 %21
  br label %23

23:                                               ; preds = %.preheader.us, %23
  %24 = phi i64 [ 0, %.preheader.us ], [ %30, %23 ]
  %25 = mul i64 %24, %6
  %26 = getelementptr float, ptr %20, i64 %25
  %27 = load float, ptr %26, align 4
  %28 = fpext float %27 to double
  %29 = getelementptr double, ptr %22, i64 %24
  store double %28, ptr %29, align 8
  %30 = add nuw nsw i64 %24, 1
  %31 = icmp slt i64 %30, %4
  br i1 %31, label %23, label %._crit_edge.us

._crit_edge.us:                                   ; preds = %23
  %32 = add nuw nsw i64 %18, 1
  %33 = icmp slt i64 %32, %3
  br i1 %33, label %.preheader.us, label %._crit_edge12

._crit_edge12:                                    ; preds = %._crit_edge.us, %.preheader.lr.ph, %7
  tail call void @printF64Tensor2D(ptr poison, ptr %14, i64 0, i64 %3, i64 %4, i64 %4, i64 1)
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #3 {
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
  %9 = tail call fast float @llvm.sqrt.f32(float %8)
  %10 = fdiv fast float 1.000000e+00, %9
  %11 = fmul float %10, %0
  %12 = fmul float %10, %1
  %13 = fmul float %10, %2
  %14 = insertvalue { float, float, float } undef, float %11, 0
  %15 = insertvalue { float, float, float } %14, float %12, 1
  %16 = insertvalue { float, float, float } %15, float %13, 2
  ret { float, float, float } %16
}

; Function Attrs: nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #4 {
  %8 = tail call dereferenceable_or_null(1200064) ptr @malloc(i64 1200064)
  %9 = ptrtoint ptr %8 to i64
  %10 = add i64 %9, 63
  %11 = and i64 %10, -64
  %12 = inttoptr i64 %11 to ptr
  %13 = getelementptr float, ptr %1, i64 %2
  %14 = shl i64 %6, 1
  br label %15

15:                                               ; preds = %7, %15
  %16 = phi i64 [ 0, %7 ], [ %38, %15 ]
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
  %29 = tail call fast float @llvm.sqrt.f32(float %28)
  %30 = fdiv fast float 1.000000e+00, %29
  %31 = fmul float %19, %30
  %32 = fmul float %21, %30
  %33 = fmul float %23, %30
  %34 = mul nuw nsw i64 %16, 3
  %35 = getelementptr float, ptr %12, i64 %34
  store float %31, ptr %35, align 4
  %36 = getelementptr float, ptr %35, i64 1
  store float %32, ptr %36, align 4
  %37 = getelementptr float, ptr %35, i64 2
  store float %33, ptr %37, align 4
  %38 = add nuw nsw i64 %16, 1
  %39 = icmp ult i64 %16, 99999
  br i1 %39, label %15, label %40

40:                                               ; preds = %15
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %8, 0
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, ptr %12, 1
  %43 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, i64 0, 2
  %44 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %43, i64 100000, 3, 0
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %44, i64 3, 3, 1
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, i64 3, 4, 0
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, i64 1, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %47
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call dereferenceable_or_null(2400064) ptr @malloc(i64 2400064)
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = and i64 %3, -64
  %5 = inttoptr i64 %4 to ptr
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i, %0
  %6 = phi i64 [ 0, %0 ], [ %28, %.preheader.i ]
  %7 = trunc i64 %6 to i32
  %8 = mul nuw nsw i64 %6, 3
  %9 = getelementptr double, ptr %5, i64 %8
  %10 = mul i32 %7, -1029531031
  %11 = add i32 %10, -740551042
  %12 = sitofp i32 %11 to double
  %13 = fadd double %12, 0x41DFFFFFFFC00000
  %14 = fmul double %13, 0x3F0869FFF9927183
  %15 = fadd double %14, -1.000000e+05
  store double %15, ptr %9, align 8
  %16 = add i32 %10, 362964203
  %17 = sitofp i32 %16 to double
  %18 = fadd double %17, 0x41DFFFFFFFC00000
  %19 = fmul double %18, 0x3F0869FFF9927183
  %20 = fadd double %19, -1.000000e+05
  %21 = getelementptr double, ptr %9, i64 1
  store double %20, ptr %21, align 8
  %22 = add i32 %10, 1466479448
  %23 = sitofp i32 %22 to double
  %24 = fadd double %23, 0x41DFFFFFFFC00000
  %25 = fmul double %24, 0x3F0869FFF9927183
  %26 = fadd double %25, -1.000000e+05
  %27 = getelementptr double, ptr %9, i64 2
  store double %26, ptr %27, align 8
  %28 = add nuw nsw i64 %6, 1
  %29 = icmp ult i64 %6, 99999
  br i1 %29, label %.preheader.i, label %fillRandomF64Tensor2D.exit

fillRandomF64Tensor2D.exit:                       ; preds = %.preheader.i
  %30 = tail call dereferenceable_or_null(1200064) ptr @malloc(i64 1200064)
  %31 = ptrtoint ptr %30 to i64
  %32 = add i64 %31, 63
  %33 = and i64 %32, -64
  %34 = inttoptr i64 %33 to ptr
  br label %.preheader

.preheader:                                       ; preds = %fillRandomF64Tensor2D.exit, %.preheader
  %35 = phi i64 [ 0, %fillRandomF64Tensor2D.exit ], [ %49, %.preheader ]
  %36 = mul nuw nsw i64 %35, 3
  %37 = getelementptr double, ptr %5, i64 %36
  %38 = getelementptr float, ptr %34, i64 %36
  %39 = load double, ptr %37, align 8
  %40 = fptrunc double %39 to float
  store float %40, ptr %38, align 4
  %41 = getelementptr double, ptr %37, i64 1
  %42 = load double, ptr %41, align 8
  %43 = fptrunc double %42 to float
  %44 = getelementptr float, ptr %38, i64 1
  store float %43, ptr %44, align 4
  %45 = getelementptr double, ptr %37, i64 2
  %46 = load double, ptr %45, align 8
  %47 = fptrunc double %46 to float
  %48 = getelementptr float, ptr %38, i64 2
  store float %47, ptr %48, align 4
  %49 = add nuw nsw i64 %35, 1
  %50 = icmp ult i64 %35, 99999
  br i1 %50, label %.preheader, label %51

51:                                               ; preds = %.preheader
  %52 = tail call i64 @clock()
  %53 = tail call dereferenceable_or_null(1200064) ptr @malloc(i64 1200064)
  %54 = ptrtoint ptr %53 to i64
  %55 = add i64 %54, 63
  %56 = and i64 %55, -64
  %57 = inttoptr i64 %56 to ptr
  br label %58

58:                                               ; preds = %58, %51
  %59 = phi i64 [ 0, %51 ], [ %80, %58 ]
  %60 = mul nuw nsw i64 %59, 3
  %61 = getelementptr float, ptr %34, i64 %60
  %62 = load float, ptr %61, align 4
  %63 = getelementptr float, ptr %61, i64 1
  %64 = load float, ptr %63, align 4
  %65 = getelementptr float, ptr %61, i64 2
  %66 = load float, ptr %65, align 4
  %67 = fmul float %62, %62
  %68 = fmul float %64, %64
  %69 = fmul float %66, %66
  %70 = fadd float %67, %68
  %71 = fadd float %70, %69
  %72 = tail call fast float @llvm.sqrt.f32(float %71)
  %73 = fdiv fast float 1.000000e+00, %72
  %74 = fmul float %62, %73
  %75 = fmul float %64, %73
  %76 = fmul float %66, %73
  %77 = getelementptr float, ptr %57, i64 %60
  store float %74, ptr %77, align 4
  %78 = getelementptr float, ptr %77, i64 1
  store float %75, ptr %78, align 4
  %79 = getelementptr float, ptr %77, i64 2
  store float %76, ptr %79, align 4
  %80 = add nuw nsw i64 %59, 1
  %81 = icmp ult i64 %59, 99999
  br i1 %81, label %58, label %normalize_distance_vectors.exit

normalize_distance_vectors.exit:                  ; preds = %58
  %82 = tail call i64 @clock()
  %83 = sub i64 %82, %52
  %84 = uitofp i64 %83 to double
  %85 = fdiv double %84, 1.000000e+08
  %86 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %83, double %85)
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #5

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #4 = { nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
