module {
  func.func @test_native_hw_comb(%a : i4) -> i4 {
    // Using native HW/Comb operations directly in a function
    %c0_i4 = hw.constant 0 : i4
    
    // This should be optimized: a | 0 = a
    %or_result = comb.or %a, %c0_i4 : i4
    
    // This should be optimized: result + 0 = result  
    %final_result = comb.add %or_result, %c0_i4 : i4
    
    func.return %final_result : i4
  }
} 