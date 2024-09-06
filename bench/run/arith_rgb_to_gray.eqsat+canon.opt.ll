; ModuleID = 'bench/run/arith_rgb_to_gray.eqsat+canon.ll'
source_filename = "LLVMDialectModule"

@time = constant [13 x i8] c"%d us -> %f s"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printI64(i64) local_unnamed_addr

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
  %5 = fdiv double %4, 1.000000e+06
  %6 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %3, double %5)
  ret void
}

define void @printI64Tensor1D(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4) local_unnamed_addr {
  %6 = tail call i32 @putchar(i32 91)
  %7 = icmp sgt i64 %3, 0
  br i1 %7, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %5
  %8 = getelementptr i64, ptr %1, i64 %2
  %9 = add nsw i64 %3, -1
  br label %10

10:                                               ; preds = %.lr.ph, %17
  %11 = phi i64 [ 0, %.lr.ph ], [ %18, %17 ]
  %12 = mul i64 %11, %4
  %13 = getelementptr i64, ptr %8, i64 %12
  %14 = load i64, ptr %13, align 4
  tail call void @printI64(i64 %14)
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

define void @printI64Tensor2D(ptr nocapture readnone %0, ptr nocapture readonly %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr {
  %.fr4 = freeze i64 %4
  %8 = tail call i32 @putchar(i32 91)
  %invariant.gep = getelementptr i64, ptr %1, i64 %2
  %9 = icmp sgt i64 %3, 0
  br i1 %9, label %.lr.ph, label %._crit_edge.thread

.lr.ph:                                           ; preds = %7
  %10 = icmp sgt i64 %.fr4, 0
  %11 = add nsw i64 %.fr4, -1
  %12 = add nsw i64 %3, -1
  br i1 %10, label %.lr.ph.i.us, label %printI64Tensor1D.exit

.lr.ph.i.us:                                      ; preds = %.lr.ph, %28
  %13 = phi i64 [ %29, %28 ], [ 0, %.lr.ph ]
  tail call void @printNewline()
  %14 = tail call i32 @putchar(i32 9)
  %15 = tail call i32 @putchar(i32 91)
  %16 = mul i64 %13, %5
  %gep.us = getelementptr i64, ptr %invariant.gep, i64 %16
  br label %17

17:                                               ; preds = %24, %.lr.ph.i.us
  %18 = phi i64 [ 0, %.lr.ph.i.us ], [ %25, %24 ]
  %19 = mul i64 %18, %6
  %20 = getelementptr i64, ptr %gep.us, i64 %19
  %21 = load i64, ptr %20, align 4
  tail call void @printI64(i64 %21)
  %22 = icmp ult i64 %18, %11
  br i1 %22, label %23, label %24

23:                                               ; preds = %17
  tail call void @printComma()
  br label %24

24:                                               ; preds = %23, %17
  %25 = add nuw nsw i64 %18, 1
  %26 = icmp slt i64 %25, %.fr4
  br i1 %26, label %17, label %printI64Tensor1D.exit.loopexit.us

27:                                               ; preds = %printI64Tensor1D.exit.loopexit.us
  tail call void @printComma()
  br label %28

28:                                               ; preds = %27, %printI64Tensor1D.exit.loopexit.us
  %29 = add nuw nsw i64 %13, 1
  %30 = icmp slt i64 %29, %3
  br i1 %30, label %.lr.ph.i.us, label %._crit_edge

printI64Tensor1D.exit.loopexit.us:                ; preds = %24
  %31 = tail call i32 @putchar(i32 93)
  %32 = icmp ult i64 %13, %12
  br i1 %32, label %27, label %28

printI64Tensor1D.exit:                            ; preds = %.lr.ph, %39
  %33 = phi i64 [ %40, %39 ], [ 0, %.lr.ph ]
  tail call void @printNewline()
  %34 = tail call i32 @putchar(i32 9)
  %35 = tail call i32 @putchar(i32 91)
  %36 = tail call i32 @putchar(i32 93)
  %37 = icmp ult i64 %33, %12
  br i1 %37, label %38, label %39

38:                                               ; preds = %printI64Tensor1D.exit
  tail call void @printComma()
  br label %39

39:                                               ; preds = %38, %printI64Tensor1D.exit
  %40 = add nuw nsw i64 %33, 1
  %41 = icmp slt i64 %40, %3
  br i1 %41, label %printI64Tensor1D.exit, label %._crit_edge

._crit_edge:                                      ; preds = %39, %28
  br i1 %9, label %42, label %._crit_edge.thread

42:                                               ; preds = %._crit_edge
  tail call void @printNewline()
  br label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %7, %42, %._crit_edge
  %43 = tail call i32 @putchar(i32 93)
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i64 @rgb_to_grayscale(i64 %0, i64 %1, i64 %2) local_unnamed_addr #2 {
  %4 = mul i64 %0, 77
  %5 = mul i64 %1, 150
  %6 = mul i64 %2, 29
  %7 = ashr i64 %4, 8
  %8 = ashr i64 %5, 8
  %9 = ashr i64 %6, 8
  %10 = add nsw i64 %8, %7
  %11 = add nsw i64 %10, %9
  ret i64 %11
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [3 x i64], [3 x i64] } @blackhole1(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, i64 %8) local_unnamed_addr #2 {
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %0, 0
  %11 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %10, ptr %1, 1
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %11, i64 %2, 2
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, i64 %3, 3, 0
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 %6, 4, 0
  %15 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %14, i64 %4, 3, 1
  %16 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, i64 %7, 4, 1
  %17 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %16, i64 %5, 3, 2
  %18 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %17, i64 %8, 4, 2
  ret { ptr, ptr, i64, [3 x i64], [3 x i64] } %18
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [2 x i64], [2 x i64] } @blackhole2(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6) local_unnamed_addr #2 {
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, ptr %1, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 %2, 2
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 %3, 3, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 %5, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 %4, 3, 1
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 %6, 4, 1
  ret { ptr, ptr, i64, [2 x i64], [2 x i64] } %14
}

define noundef i64 @main() local_unnamed_addr {
  %1 = tail call dereferenceable_or_null(199065664) ptr @malloc(i64 199065664)
  %2 = ptrtoint ptr %1 to i64
  %3 = add i64 %2, 63
  %4 = and i64 %3, -64
  %5 = inttoptr i64 %4 to ptr
  br label %.preheader3

.preheader3:                                      ; preds = %0, %16
  %6 = phi i64 [ 0, %0 ], [ %17, %16 ]
  %7 = mul nuw nsw i64 %6, 6480
  %8 = getelementptr i64, ptr %5, i64 %7
  br label %.preheader2

.preheader2:                                      ; preds = %.preheader3, %.preheader2
  %9 = phi i64 [ 0, %.preheader3 ], [ %14, %.preheader2 ]
  %10 = mul nuw nsw i64 %9, 3
  %11 = getelementptr i64, ptr %8, i64 %10
  store i64 100, ptr %11, align 8
  %12 = getelementptr i64, ptr %11, i64 1
  store i64 100, ptr %12, align 8
  %13 = getelementptr i64, ptr %11, i64 2
  store i64 100, ptr %13, align 8
  %14 = add nuw nsw i64 %9, 1
  %15 = icmp ult i64 %9, 2159
  br i1 %15, label %.preheader2, label %16

16:                                               ; preds = %.preheader2
  %17 = add nuw nsw i64 %6, 1
  %18 = icmp ult i64 %6, 3839
  br i1 %18, label %.preheader3, label %19

19:                                               ; preds = %16
  %20 = tail call i64 @clock()
  %21 = tail call dereferenceable_or_null(66355264) ptr @malloc(i64 66355264)
  %22 = ptrtoint ptr %21 to i64
  %23 = add i64 %22, 63
  %24 = and i64 %23, -64
  %25 = inttoptr i64 %24 to ptr
  br label %.preheader

.preheader:                                       ; preds = %19, %49
  %26 = phi i64 [ 0, %19 ], [ %50, %49 ]
  %27 = mul nuw nsw i64 %26, 6480
  %28 = getelementptr i64, ptr %5, i64 %27
  %29 = mul nuw nsw i64 %26, 2160
  %30 = getelementptr i64, ptr %25, i64 %29
  br label %31

31:                                               ; preds = %.preheader, %31
  %32 = phi i64 [ 0, %.preheader ], [ %47, %31 ]
  %33 = mul nuw nsw i64 %32, 3
  %34 = getelementptr i64, ptr %28, i64 %33
  %35 = load i64, ptr %34, align 8
  %36 = getelementptr i64, ptr %34, i64 1
  %37 = mul i64 %35, 77
  %38 = ashr i64 %37, 8
  %39 = load <2 x i64>, ptr %36, align 8
  %40 = mul <2 x i64> %39, <i64 150, i64 29>
  %41 = ashr <2 x i64> %40, <i64 8, i64 8>
  %42 = extractelement <2 x i64> %41, i64 0
  %43 = add nsw i64 %42, %38
  %44 = extractelement <2 x i64> %41, i64 1
  %45 = add nsw i64 %43, %44
  %46 = getelementptr i64, ptr %30, i64 %32
  store i64 %45, ptr %46, align 8
  %47 = add nuw nsw i64 %32, 1
  %48 = icmp ult i64 %32, 2159
  br i1 %48, label %31, label %49

49:                                               ; preds = %31
  %50 = add nuw nsw i64 %26, 1
  %51 = icmp ult i64 %26, 3839
  br i1 %51, label %.preheader, label %52

52:                                               ; preds = %49
  %53 = tail call i64 @clock()
  %54 = sub i64 %53, %20
  %55 = uitofp i64 %54 to double
  %56 = fdiv double %55, 1.000000e+06
  %57 = tail call i32 (ptr, ...) @printf(ptr nonnull dereferenceable(1) @time, i64 %54, double %56)
  ret i64 0
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { nofree nounwind }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
