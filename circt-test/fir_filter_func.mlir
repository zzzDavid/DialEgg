module {
  func.func @fir_filter_comb(%delay0: i8, %delay1: i8, %delay2: i8) -> i18 {
    // Constants from the arith conversion
    %c0_i16 = arith.constant 0 : i16
    %c1_i16 = arith.constant 1 : i16
    
    // Extend delay0 to i16 (delay0 * 1 = delay0)
    %delay0_ext = arith.extui %delay0 : i8 to i16
    
    // Extend delay1 to i16 and shift left by 1 (delay1 * 2 = delay1 << 1)
    %delay1_ext = arith.extui %delay1 : i8 to i16
    %delay1_shifted = arith.shli %delay1_ext, %c1_i16 : i16
    
    // Redundant OR with 0 - this should be optimized away
    %delay1_final = arith.ori %delay1_shifted, %c0_i16 : i16
    
    // Add delay0 and (delay1 << 1)
    %temp_sum = arith.addi %delay0_ext, %delay1_final : i16
    
    // Extend to i18
    %temp_sum_ext = arith.extui %temp_sum : i16 to i18
    
    // Extend delay2 to i18 (delay2 * 1 = delay2)
    %delay2_ext = arith.extui %delay2 : i8 to i18
    
    // Final addition
    %result = arith.addi %temp_sum_ext, %delay2_ext : i18
    
    func.return %result : i18
  }
} 