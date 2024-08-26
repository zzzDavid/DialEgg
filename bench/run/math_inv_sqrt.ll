; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @printF64(double)

declare void @printF32(float)

declare void @printNewline()

define float @fast_inv_sqrt(float %0) {
  %2 = fmul float %0, 5.000000e-01
  %3 = bitcast float %0 to i32
  %4 = ashr i32 %3, 1
  %5 = sub i32 1597463007, %4
  %6 = bitcast i32 %5 to float
  %7 = fmul float %6, %6
  %8 = fmul float %2, %7
  %9 = fsub float 1.500000e+00, %8
  %10 = fmul float %6, %9
  ret float %10
}

define float @inv_sqrt(float %0) {
  %2 = call fast float @llvm.sqrt.f32(float %0)
  %3 = fdiv fast float 1.000000e+00, %2
  ret float %3
}

define i32 @main() {
  %1 = call float @inv_sqrt(float 9.000000e+00)
  call void @printF32(float %1)
  call void @printNewline()
  %2 = call float @fast_inv_sqrt(float 9.000000e+00)
  call void @printF32(float %2)
  call void @printNewline()
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
