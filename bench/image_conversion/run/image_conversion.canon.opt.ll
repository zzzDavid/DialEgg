; ModuleID = 'bench/image_conversion/run/image_conversion.canon.ll'
source_filename = "LLVMDialectModule"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

declare void @displayTime(i64, i64) local_unnamed_addr

declare void @printI64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64) local_unnamed_addr

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define { ptr, ptr, i64, [3 x i64], [3 x i64] } @blackhole4k(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, i64 %8) local_unnamed_addr #1 {
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
  %38 = sdiv i64 %37, 256
  %39 = load <2 x i64>, ptr %36, align 8
  %40 = mul <2 x i64> %39, <i64 150, i64 29>
  %41 = sdiv <2 x i64> %40, <i64 256, i64 256>
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
  tail call void @printI64Tensor2D(ptr %21, ptr nonnull %25, i64 0, i64 3840, i64 2160, i64 2160, i64 1)
  tail call void @printNewline()
  tail call void @displayTime(i64 %20, i64 %53)
  ret i64 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i64 @rgb_to_grayscale(i64 %0, i64 %1, i64 %2) local_unnamed_addr #1 {
  %4 = mul i64 %0, 77
  %5 = insertelement <2 x i64> poison, i64 %1, i64 0
  %6 = insertelement <2 x i64> %5, i64 %2, i64 1
  %7 = mul <2 x i64> %6, <i64 150, i64 29>
  %8 = sdiv i64 %4, 256
  %9 = sdiv <2 x i64> %7, <i64 256, i64 256>
  %10 = extractelement <2 x i64> %9, i64 0
  %11 = add nsw i64 %10, %8
  %12 = extractelement <2 x i64> %9, i64 1
  %13 = add nsw i64 %11, %12
  ret i64 %13
}

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
