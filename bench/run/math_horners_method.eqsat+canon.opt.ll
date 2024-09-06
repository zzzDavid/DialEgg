; ModuleID = 'bench/run/math_horners_method.eqsat+canon.ll'
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
  %10 = mul i64 %6, 3
  br label %.preheader

.preheader:                                       ; preds = %7, %.preheader
  %11 = phi i64 [ 0, %7 ], [ %42, %.preheader ]
  %12 = trunc i64 %11 to i32
  %13 = mul i64 %11, %5
  %14 = getelementptr double, ptr %8, i64 %13
  %15 = mul i32 %12, -1029531031
  %16 = add i32 %15, -740551042
  %17 = sitofp i32 %16 to double
  %18 = fadd double %17, 0x41DFFFFFFFC00000
  %19 = fmul double %18, 0x3E33FFFFFABBF5C5
  %20 = fadd double %19, -1.000000e+01
  store double %20, ptr %14, align 8
  %21 = mul i32 %12, -1029531031
  %22 = add i32 %21, 362964203
  %23 = sitofp i32 %22 to double
  %24 = fadd double %23, 0x41DFFFFFFFC00000
  %25 = fmul double %24, 0x3E33FFFFFABBF5C5
  %26 = fadd double %25, -1.000000e+01
  %27 = getelementptr double, ptr %14, i64 %6
  store double %26, ptr %27, align 8
  %28 = mul i32 %12, -1029531031
  %29 = add i32 %28, 1466479448
  %30 = sitofp i32 %29 to double
  %31 = fadd double %30, 0x41DFFFFFFFC00000
  %32 = fmul double %31, 0x3E33FFFFFABBF5C5
  %33 = fadd double %32, -1.000000e+01
  %34 = getelementptr double, ptr %14, i64 %9
  store double %33, ptr %34, align 8
  %35 = mul i32 %12, -1029531031
  %36 = add i32 %35, -1724972603
  %37 = sitofp i32 %36 to double
  %38 = fadd double %37, 0x41DFFFFFFFC00000
  %39 = fmul double %38, 0x3E33FFFFFABBF5C5
  %40 = fadd double %39, -1.000000e+01
  %41 = getelementptr double, ptr %14, i64 %10
  store double %40, ptr %41, align 8
  %42 = add nuw nsw i64 %11, 1
  %43 = icmp ult i64 %11, 99999
  br i1 %43, label %.preheader, label %44

44:                                               ; preds = %.preheader
  %45 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %46 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %45, ptr %1, 1
  %47 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %46, i64 %2, 2
  %48 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %47, i64 %3, 3, 0
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %48, i64 %5, 4, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, i64 %4, 3, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %51
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [1 x i64], [1 x i64] } @blackhole(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr #3 {
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, ptr %1, 1
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, i64 %2, 2
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, i64 %3, 3, 0
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 %4, 4, 0
  ret { ptr, ptr, i64, [1 x i64], [1 x i64] } %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @poly_eval_3(double %0, double %1, double %2, double %3, double %4) local_unnamed_addr #3 {
  %6 = fmul fast double %4, %0
  %7 = fadd fast double %6, %1
  %8 = fmul fast double %7, %4
  %9 = fadd fast double %8, %2
  %10 = fmul fast double %9, %4
  %11 = fadd fast double %10, %3
  ret double %11
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @poly_eval_2(double %0, double %1, double %2, double %3) local_unnamed_addr #3 {
  %5 = fmul fast double %3, %0
  %6 = fadd fast double %5, %1
  %7 = fmul fast double %6, %3
  %8 = fadd fast double %7, %2
  ret double %8
}

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call dereferenceable_or_null(3200064) ptr @malloc(i64 3200064)
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = and i64 %3, -64
  %5 = inttoptr i64 %4 to ptr
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i, %0
  %6 = phi i64 [ 0, %0 ], [ %34, %.preheader.i ]
  %7 = trunc i64 %6 to i32
  %8 = shl nuw nsw i64 %6, 2
  %9 = getelementptr double, ptr %5, i64 %8
  %10 = mul i32 %7, -1029531031
  %11 = add i32 %10, -740551042
  %12 = sitofp i32 %11 to double
  %13 = fadd double %12, 0x41DFFFFFFFC00000
  %14 = fmul double %13, 0x3E33FFFFFABBF5C5
  %15 = fadd double %14, -1.000000e+01
  store double %15, ptr %9, align 32
  %16 = add i32 %10, 362964203
  %17 = sitofp i32 %16 to double
  %18 = fadd double %17, 0x41DFFFFFFFC00000
  %19 = fmul double %18, 0x3E33FFFFFABBF5C5
  %20 = fadd double %19, -1.000000e+01
  %21 = getelementptr double, ptr %9, i64 1
  store double %20, ptr %21, align 8
  %22 = add i32 %10, 1466479448
  %23 = sitofp i32 %22 to double
  %24 = fadd double %23, 0x41DFFFFFFFC00000
  %25 = fmul double %24, 0x3E33FFFFFABBF5C5
  %26 = fadd double %25, -1.000000e+01
  %27 = getelementptr double, ptr %9, i64 2
  store double %26, ptr %27, align 16
  %28 = add i32 %10, -1724972603
  %29 = sitofp i32 %28 to double
  %30 = fadd double %29, 0x41DFFFFFFFC00000
  %31 = fmul double %30, 0x3E33FFFFFABBF5C5
  %32 = fadd double %31, -1.000000e+01
  %33 = getelementptr double, ptr %9, i64 3
  store double %32, ptr %33, align 8
  %34 = add nuw nsw i64 %6, 1
  %35 = icmp ult i64 %6, 99999
  br i1 %35, label %.preheader.i, label %fillRandomF64Tensor2D.exit

fillRandomF64Tensor2D.exit:                       ; preds = %.preheader.i
  %36 = tail call i64 @clock()
  %37 = tail call dereferenceable_or_null(800064) ptr @malloc(i64 800064)
  %38 = ptrtoint ptr %37 to i64
  %39 = add i64 %38, 63
  %40 = and i64 %39, -64
  %41 = inttoptr i64 %40 to ptr
  br label %42

42:                                               ; preds = %fillRandomF64Tensor2D.exit, %42
  %43 = phi i64 [ 0, %fillRandomF64Tensor2D.exit ], [ %49, %42 ]
  %44 = shl nuw nsw i64 %43, 2
  %45 = getelementptr double, ptr %5, i64 %44
  %46 = load <4 x double>, ptr %45, align 32
  %47 = tail call fast double @llvm.vector.reduce.fadd.v4f64(double -0.000000e+00, <4 x double> %46)
  %48 = getelementptr double, ptr %41, i64 %43
  store double %47, ptr %48, align 8
  %49 = add nuw nsw i64 %43, 1
  %50 = icmp ult i64 %43, 99999
  br i1 %50, label %42, label %51

51:                                               ; preds = %42
  %52 = tail call i64 @clock()
  tail call void @printNewline()
  %53 = sub i64 %52, %36
  %54 = uitofp i64 %53 to double
  %55 = fdiv double %54, 1.000000e+08
  %56 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %53, double %55)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v4f64(double, <4 x double>) #4

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
