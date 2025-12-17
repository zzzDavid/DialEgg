module comparator_4bit(
    input clk,                  // Clock signal for pipelining datapath
    input [3:0] A,              // First 4-bit input operand
    input [3:0] B,              // Second 4-bit input operand
    output reg A_greater,       // Registered outputs
    output reg A_equal,
    output reg A_less
);

    // Input registers for pipelining
    reg [3:0] A_reg;
    reg [3:0] B_reg;

    // Internal wires for combinational datapath
    wire [3:0] diff;
    wire cout;
    wire greater_comb;
    wire equal_comb;
    wire less_comb;

    assign {cout, diff} = A_reg - B_reg;
    assign greater_comb = (~cout) && (diff != 4'b0000);
    assign equal_comb   = (A_reg == B_reg);
    assign less_comb    = cout;

    always @(posedge clk) begin
        // Register the inputs
        A_reg <= A;
        B_reg <= B;
        // Register the outputs
        A_greater <= greater_comb;
        A_equal   <= equal_comb;
        A_less    <= less_comb;
    end

endmodule