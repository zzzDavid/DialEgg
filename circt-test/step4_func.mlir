module {
    func.func @fir_input(%delay0: i16, %delay1: i16, %delay2: i16) -> i16 {
    %false = arith.constant false
    %c0_i16 = arith.constant 0 : i16
    %0 = arith.shrui %delay1, %c0_i16 : i16
    %1 = arith.trunci %0 : i16 to i15
    %c0_i16_0 = arith.constant 0 : i16
    %c1_i16 = arith.constant 1 : i16
    %2 = arith.extui %1 : i15 to i16
    %3 = arith.shli %2, %c1_i16 : i16
    %4 = arith.ori %3, %c0_i16_0 : i16
    %5 = arith.addi %delay0, %4 : i16
    %6 = arith.addi %5, %delay2 : i16
        func.return %6 : i16}
}

