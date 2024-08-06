module {
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @main() -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.500000e+00 : f64) : f64
    llvm.call @printF64(%2) : (f64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @printF64(%0) : (f64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.return %1 : f32
  }
}

