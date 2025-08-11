module {
  hw.module @simple_test(in %a : i4, in %b : i4, out result : i4) {
    %c0_i4 = hw.constant 0 : i4
    
    // This should be optimized: a | 0 = a
    %or_result = comb.or %a, %c0_i4 : i4
    
    // This should be optimized: result + 0 = result  
    %final_result = comb.add %or_result, %c0_i4 : i4
    
    hw.output %final_result : i4
  }
} 