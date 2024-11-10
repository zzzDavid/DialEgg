; ModuleID = 'bench/polynomial/run/polynomial.eqsat.ll'
source_filename = "LLVMDialectModule"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

declare void @displayTime(i64, i64) local_unnamed_addr

declare void @printF64Tensor1D(ptr, ptr, i64, i64, i64) local_unnamed_addr

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

define noundef i32 @main() local_unnamed_addr {
  %1 = tail call dereferenceable_or_null(40000064) ptr @malloc(i64 40000064)
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = and i64 %3, -64
  %5 = inttoptr i64 %4 to ptr
  br label %.preheader.us.i

.preheader.us.i:                                  ; preds = %.preheader.us.i, %0
  %6 = phi i64 [ %44, %.preheader.us.i ], [ 0, %0 ]
  %7 = trunc i64 %6 to i32
  %8 = mul nuw nsw i64 %6, 5
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
  %30 = mul i32 %7, -1029531031
  %31 = add i32 %30, -1724972603
  %32 = sitofp i32 %31 to double
  %33 = fadd double %32, 0x41DFFFFFFFC00000
  %34 = fmul double %33, 0x3E33FFFFFABBF5C5
  %35 = fadd double %34, -1.000000e+01
  %36 = getelementptr double, ptr %9, i64 3
  store double %35, ptr %36, align 8
  %37 = mul i32 %7, -1029531031
  %38 = add i32 %37, -621457358
  %39 = sitofp i32 %38 to double
  %40 = fadd double %39, 0x41DFFFFFFFC00000
  %41 = fmul double %40, 0x3E33FFFFFABBF5C5
  %42 = fadd double %41, -1.000000e+01
  %43 = getelementptr double, ptr %9, i64 4
  store double %42, ptr %43, align 8
  %44 = add nuw nsw i64 %6, 1
  %45 = icmp ult i64 %6, 999999
  br i1 %45, label %.preheader.us.i, label %fillRandomF64Tensor2D.exit

fillRandomF64Tensor2D.exit:                       ; preds = %.preheader.us.i
  %46 = tail call i64 @clock()
  %47 = tail call dereferenceable_or_null(8000064) ptr @malloc(i64 8000064)
  %48 = ptrtoint ptr %47 to i64
  %49 = add i64 %48, 63
  %50 = and i64 %49, -64
  %51 = inttoptr i64 %50 to ptr
  br label %52

52:                                               ; preds = %fillRandomF64Tensor2D.exit, %52
  %53 = phi i64 [ 0, %fillRandomF64Tensor2D.exit ], [ %74, %52 ]
  %54 = mul nuw nsw i64 %53, 5
  %55 = getelementptr double, ptr %5, i64 %54
  %56 = load double, ptr %55, align 8
  %57 = getelementptr double, ptr %55, i64 1
  %58 = load double, ptr %57, align 8
  %59 = getelementptr double, ptr %55, i64 2
  %60 = load double, ptr %59, align 8
  %61 = getelementptr double, ptr %55, i64 3
  %62 = load double, ptr %61, align 8
  %63 = getelementptr double, ptr %55, i64 4
  %64 = load double, ptr %63, align 8
  %65 = fmul double %56, 5.000000e+00
  %66 = fadd double %65, %58
  %67 = fmul double %66, 5.000000e+00
  %68 = fadd double %60, %67
  %69 = fmul double %68, 5.000000e+00
  %70 = fadd double %62, %69
  %71 = fmul double %70, 5.000000e+00
  %72 = fadd double %64, %71
  %73 = getelementptr double, ptr %51, i64 %53
  store double %72, ptr %73, align 8
  %74 = add nuw nsw i64 %53, 1
  %75 = icmp ult i64 %53, 999999
  br i1 %75, label %52, label %76

76:                                               ; preds = %52
  %77 = tail call i64 @clock()
  tail call void @printF64Tensor1D(ptr %47, ptr nonnull %51, i64 0, i64 1000000, i64 1)
  tail call void @printNewline()
  tail call void @displayTime(i64 %46, i64 %77)
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @poly_eval_4(double %0, double %1, double %2, double %3, double %4, double %5) local_unnamed_addr #2 {
  %7 = fmul double %0, %5
  %8 = fadd double %7, %1
  %9 = fmul double %8, %5
  %10 = fadd double %9, %2
  %11 = fmul double %10, %5
  %12 = fadd double %11, %3
  %13 = fmul double %12, %5
  %14 = fadd double %13, %4
  ret double %14
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
