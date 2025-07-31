module {
  func.func @fir_simple(%delay0: i16, %delay1: i16, %delay2: i16) -> i16 {
    // Constants
    %c0_i16 = arith.constant 0 : i16
    %c1_i16 = arith.constant 1 : i16
    
    // delay1 * 2 implemented as left shift
    %delay1_doubled = arith.shli %delay1, %c1_i16 : i16
    
    // Redundant OR with 0 - should be optimized away: x | 0 = x
    %delay1_final = arith.ori %delay1_doubled, %c0_i16 : i16
    
    // Add delay0 + (delay1 << 1) 
    %temp_sum = arith.addi %delay0, %delay1_final : i16
    
    // Add delay2: result = delay0 + (delay1 << 1) + delay2
    %result = arith.addi %temp_sum, %delay2 : i16
    
    // Redundant add with 0 - should be optimized away: x + 0 = x
    %final_result = arith.addi %result, %c0_i16 : i16
    
    func.return %final_result : i16
  }
} 