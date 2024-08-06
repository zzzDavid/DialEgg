; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @printF64(double)

declare void @printNewline()

define float @main() {
  call void @printF64(double -2.000000e+00)
  call void @printNewline()
  ret float 0.000000e+00
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
