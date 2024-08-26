module {
  llvm.func @printF64(f64) attributes {sym_visibility = "private"}
  llvm.func @printF32(f32) attributes {sym_visibility = "private"}
  llvm.func @printNewline() attributes {sym_visibility = "private"}
  llvm.func @fast_inv_sqrt(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.mlir.constant(1.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1597463007 : i32) : i32
    %4 = llvm.fmul %arg0, %1  : f32
    %5 = llvm.bitcast %arg0 : f32 to i32
    %6 = llvm.ashr %5, %0  : i32
    %7 = llvm.sub %3, %6  : i32
    %8 = llvm.bitcast %7 : i32 to f32
    %9 = llvm.fmul %8, %8  : f32
    %10 = llvm.fmul %4, %9  : f32
    %11 = llvm.fsub %2, %10  : f32
    %12 = llvm.fmul %8, %11  : f32
    llvm.return %12 : f32
  }
  llvm.func @inv_sqrt(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %2 = llvm.call @inv_sqrt(%1) : (f32) -> f32
    llvm.call @printF32(%2) : (f32) -> ()
    llvm.call @printNewline() : () -> ()
    %3 = llvm.call @fast_inv_sqrt(%1) : (f32) -> f32
    llvm.call @printF32(%3) : (f32) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.return %0 : i32
  }
}

