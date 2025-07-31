// Input SystemVerilog FIR filter with optimization opportunities
// This will be optimized through the complete DialEgg pipeline
module fir_input(
    input  logic [15:0] delay0, delay1, delay2,
    output logic [15:0] result
);
    
    // Intermediate signals with redundant operations
    logic [15:0] delay1_doubled, delay1_with_zero, temp_sum, final_result;
    
    // delay1 * 2 implemented as left shift
    assign delay1_doubled = delay1 << 1;
    
    // Redundant OR with 0 - should be optimized away: x | 0 = x
    assign delay1_with_zero = delay1_doubled | 16'h0000;
    
    // Add delay0 + processed_delay1
    assign temp_sum = delay0 + delay1_with_zero;
    
    // Add delay2
    assign final_result = temp_sum + delay2;
    
    // Redundant addition with 0 - should be optimized away: x + 0 = x  
    assign result = final_result + 16'h0000;
    
endmodule 