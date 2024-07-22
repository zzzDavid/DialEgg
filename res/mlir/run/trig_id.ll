; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare void @printI64(i64)

declare void @printF64(double)

declare void @printComma()

declare void @printNewline()

define float @main() {
  call void @printF64(double 0x3FEFFFFFFFFFFFFF)
  call void @printNewline()
  ret float 0.000000e+00
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
