module {
  llvm.func @printI64(i64) attributes {sym_visibility = "private"}
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
  llvm.func @printComma() attributes {sym_visibility = "private"}
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @main() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.99999999999999988 : f64) : f64
    llvm.call @printF64(%1) : (f64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.return %0 : f32
  }
}

