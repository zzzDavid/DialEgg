; ModuleID = 'test/arith/run/arith_tensor.ll'
source_filename = "LLVMDialectModule"

@__constant_2x3xf64 = private unnamed_addr constant [2 x [3 x double]] [[3 x double] [double 3.000000e+00, double 5.000000e+00, double 7.000000e+00], [3 x double] [double 9.000000e+00, double 1.100000e+01, double 1.300000e+01]], align 64

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

declare void @printNewline() local_unnamed_addr

declare i64 @clock() local_unnamed_addr

declare void @printF64Tensor2D(ptr, ptr, i64, i64, i64, i64, i64) local_unnamed_addr

declare void @displayTime(i64, i64) local_unnamed_addr

define noundef i64 @main() local_unnamed_addr {
  %1 = tail call i64 @clock()
  %2 = tail call dereferenceable_or_null(112) ptr @malloc(i64 112)
  %3 = ptrtoint ptr %2 to i64
  %4 = add i64 %3, 63
  %5 = and i64 %4, -64
  %6 = inttoptr i64 %5 to ptr
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 64 dereferenceable(48) %6, ptr noundef nonnull align 64 dereferenceable(48) @__constant_2x3xf64, i64 48, i1 false)
  tail call void @printF64Tensor2D(ptr %2, ptr %6, i64 0, i64 2, i64 3, i64 3, i64 1)
  tail call void @printNewline()
  %7 = tail call i64 @clock()
  tail call void @displayTime(i64 %1, i64 %7)
  ret i64 0
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
