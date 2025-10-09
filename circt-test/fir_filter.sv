// FIR Filter with optimization opportunities
// 4-tap FIR filter with some redundant and suboptimal operations
module fir_filter #(
    parameter DATA_WIDTH = 8,
    parameter COEFF_WIDTH = 8
)(
    input logic clk,
    input logic rst_n,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH+COEFF_WIDTH+1:0] data_out
);

    // Filter coefficients (can be optimized)
    localparam [COEFF_WIDTH-1:0] COEFF0 = 8'd1;   // 1
    localparam [COEFF_WIDTH-1:0] COEFF1 = 8'd2;   // 2  
    localparam [COEFF_WIDTH-1:0] COEFF2 = 8'd1;   // 1
    localparam [COEFF_WIDTH-1:0] COEFF3 = 8'd0;   // 0 (redundant!)

    // Delay line registers
    logic [DATA_WIDTH-1:0] delay0, delay1, delay2, delay3;
    
    // Intermediate products with optimization opportunities
    logic [DATA_WIDTH+COEFF_WIDTH-1:0] prod0, prod1, prod2, prod3;
    logic [DATA_WIDTH+COEFF_WIDTH-1:0] temp_sum1, temp_sum2;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            delay0 <= '0;
            delay1 <= '0;
            delay2 <= '0;
            delay3 <= '0;
        end else begin
            delay0 <= data_in;
            delay1 <= delay0;
            delay2 <= delay1;  
            delay3 <= delay2;
        end
    end
    
    // Multiplication stage with redundancy
    always_comb begin
        // Optimizable: multiply by 1 
        prod0 = delay0 * COEFF0;  // delay0 * 1 = delay0
        
        // Optimizable: multiply by power of 2
        prod1 = delay1 * COEFF1;  // delay1 * 2 = delay1 << 1
        
        // Optimizable: multiply by 1
        prod2 = delay2 * COEFF2;  // delay2 * 1 = delay2
        
        // Optimizable: multiply by 0
        prod3 = delay3 * COEFF3;  // delay3 * 0 = 0
        
        // Suboptimal addition tree
        temp_sum1 = prod0 + prod1;
        temp_sum2 = prod2 + prod3;  // prod3 is always 0!
        
        // Final sum with redundant operation
        data_out = temp_sum1 + temp_sum2 + 18'd0;  // Adding 0 is redundant
    end

endmodule 