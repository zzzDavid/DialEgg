// MLIR function to sum the numbers in a 1D vector with scf dialect
func.func @sum_scf(%vec: tensor<?xf64>) -> f64 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %size = tensor.dim %vec, %c0 : tensor<?xf64>

    %c0_f64 = arith.constant 0.0 : f64

    %sum = scf.for %i = %c0 to %size step %c1 iter_args(%acc = %c0_f64) -> f64 {
        %val = tensor.extract %vec[%i] : tensor<?xf64>
        %new_acc = arith.addf %acc, %val : f64
        scf.yield %new_acc : f64
    }

    func.return %sum : f64
}

func.func @multi_block_func() {
    %0 = arith.constant 42 : i32
    %1 = arith.constant 0 : i32

    %cond = arith.cmpi ne, %0, %1 : i32
    llvm.cond_br %cond, ^then_block, ^else_block

    ^then_block:
      %2 = arith.addi %0, %0 : i32
      llvm.br ^merge_block(%2 : i32)

    ^else_block:
      %3 = arith.subi %0, %1 : i32
      llvm.br ^merge_block(%3 : i32)

    ^merge_block(%phi : i32):
      %4 = arith.muli %phi, %0 : i32
      func.return
  }

llvm.mlir.global constant @str("Sum is: %f")
llvm.func @printf(!llvm.ptr, ...) -> i32

func.func @main() {
    func.return
}