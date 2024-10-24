; ModuleID = 'bench/run/math_inv_sqrt.canon+eqsat.ll'
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
  %18 = fmul double %17, 0x3F3E847FF7F70DE4
  %19 = fadd double %18, -1.000000e+06
  store double %19, ptr %13, align 8
  %20 = mul i32 %11, -1029531031
  %21 = add i32 %20, 362964203
  %22 = sitofp i32 %21 to double
  %23 = fadd double %22, 0x41DFFFFFFFC00000
  %24 = fmul double %23, 0x3F3E847FF7F70DE4
  %25 = fadd double %24, -1.000000e+06
  %26 = getelementptr double, ptr %13, i64 %6
  store double %25, ptr %26, align 8
  %27 = mul i32 %11, -1029531031
  %28 = add i32 %27, 1466479448
  %29 = sitofp i32 %28 to double
  %30 = fadd double %29, 0x41DFFFFFFFC00000
  %31 = fmul double %30, 0x3F3E847FF7F70DE4
  %32 = fadd double %31, -1.000000e+06
  %33 = getelementptr double, ptr %13, i64 %9
  store double %32, ptr %33, align 8
  %34 = add nuw nsw i64 %10, 1
  %35 = icmp ult i64 %10, 999999
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

; Function Attrs: nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @normalize_distance_vectors(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #4 {
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
  %14 = fmul double %13, 0x3F3E847FF7F70DE4
  %15 = fadd double %14, -1.000000e+06
  store double %15, ptr %9, align 8
  %16 = add i32 %10, 362964203
  %17 = sitofp i32 %16 to double
  %18 = fadd double %17, 0x41DFFFFFFFC00000
  %19 = fmul double %18, 0x3F3E847FF7F70DE4
  %20 = fadd double %19, -1.000000e+06
  %21 = getelementptr double, ptr %9, i64 1
  store double %20, ptr %21, align 8
  %22 = add i32 %10, 1466479448
  %23 = sitofp i32 %22 to double
  %24 = fadd double %23, 0x41DFFFFFFFC00000
  %25 = fmul double %24, 0x3F3E847FF7F70DE4
  %26 = fadd double %25, -1.000000e+06
  %27 = getelementptr double, ptr %9, i64 2
  store double %26, ptr %27, align 8
  %28 = add nuw nsw i64 %6, 1
  %29 = icmp ult i64 %6, 999999
  br i1 %29, label %.preheader.i, label %fillRandomF64Tensor2D.exit

fillRandomF64Tensor2D.exit:                       ; preds = %.preheader.i
  %30 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
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
  %50 = icmp ult i64 %35, 999999
  br i1 %50, label %.preheader, label %51

51:                                               ; preds = %.preheader
  %52 = tail call i64 @clock()
  %53 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %54 = ptrtoint ptr %53 to i64
  %55 = add i64 %54, 63
  %56 = and i64 %55, -64
  %57 = inttoptr i64 %56 to ptr
  br label %58

58:                                               ; preds = %58, %51
  %59 = phi i64 [ 0, %51 ], [ %87, %58 ]
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
  %72 = fmul float %71, 5.000000e-01
  %73 = bitcast float %71 to i32
  %74 = ashr i32 %73, 1
  %75 = sub i32 1597463007, %74
  %76 = bitcast i32 %75 to float
  %77 = fmul float %76, %76
  %78 = fmul float %72, %77
  %79 = fsub float 1.500000e+00, %78
  %80 = fmul float %79, %76
  %81 = fmul float %62, %80
  %82 = fmul float %64, %80
  %83 = fmul float %66, %80
  %84 = getelementptr float, ptr %57, i64 %60
  store float %81, ptr %84, align 4
  %85 = getelementptr float, ptr %84, i64 1
  store float %82, ptr %85, align 4
  %86 = getelementptr float, ptr %84, i64 2
  store float %83, ptr %86, align 4
  %87 = add nuw nsw i64 %59, 1
  %88 = icmp ult i64 %59, 999999
  br i1 %88, label %58, label %normalize_distance_vectors.exit

normalize_distance_vectors.exit:                  ; preds = %58
  %89 = tail call i64 @clock()
  %90 = tail call dereferenceable_or_null(12000064) ptr @malloc(i64 12000064)
  %91 = ptrtoint ptr %90 to i64
  %92 = add i64 %91, 63
  %93 = and i64 %92, -64
  %94 = inttoptr i64 %93 to ptr
  br label %95

95:                                               ; preds = %95, %normalize_distance_vectors.exit
  %96 = phi i64 [ 0, %normalize_distance_vectors.exit ], [ %124, %95 ]
  %97 = mul nuw nsw i64 %96, 3
  %98 = getelementptr float, ptr %34, i64 %97
  %99 = load float, ptr %98, align 4
  %100 = getelementptr float, ptr %98, i64 1
  %101 = load float, ptr %100, align 4
  %102 = getelementptr float, ptr %98, i64 2
  %103 = load float, ptr %102, align 4
  %104 = fmul float %99, %99
  %105 = fmul float %101, %101
  %106 = fmul float %103, %103
  %107 = fadd float %104, %105
  %108 = fadd float %107, %106
  %109 = fmul float %108, 5.000000e-01
  %110 = bitcast float %108 to i32
  %111 = ashr i32 %110, 1
  %112 = sub i32 1597463007, %111
  %113 = bitcast i32 %112 to float
  %114 = fmul float %113, %113
  %115 = fmul float %109, %114
  %116 = fsub float 1.500000e+00, %115
  %117 = fmul float %116, %113
  %118 = fmul float %99, %117
  %119 = fmul float %101, %117
  %120 = fmul float %103, %117
  %121 = getelementptr float, ptr %94, i64 %97
  store float %118, ptr %121, align 4
  %122 = getelementptr float, ptr %121, i64 1
  store float %119, ptr %122, align 4
  %123 = getelementptr float, ptr %121, i64 2
  store float %120, ptr %123, align 4
  %124 = add nuw nsw i64 %96, 1
  %125 = icmp ult i64 %96, 999999
  br i1 %125, label %95, label %normalize_distance_vectors.exit1

normalize_distance_vectors.exit1:                 ; preds = %95
  %126 = sub i64 %89, %52
  %127 = uitofp i64 %126 to double
  %128 = fdiv double %127, 1.000000e+06
  %129 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %126, double %128)
  ret i32 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #4 = { nofree nounwind memory(write, argmem: readwrite, inaccessiblemem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
