; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @printF64(double)

declare void @printNewline()

define float @main() {
  call void @printF64(double 3.500000e+00)
  call void @printNewline()
  call void @printF64(double 5.000000e-01)
  call void @printNewline()
  ret float 0.000000e+00
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
