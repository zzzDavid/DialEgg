func.func @nestedFunc(%arg0: i32) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %a0_i1 = arith.cmpi slt, %0, %arg0 : i32
    %1 = scf.if %a0_i1 -> (i32) {
        ^bb0:
        %2 = arith.subi %0, %arg0 : i32
        scf.yield %2 : i32
    } else {
        ^bb1:
        %3 = arith.muli %0, %arg0 : i32
        scf.yield %3 : i32
    }
    func.return %1 : i32
}
