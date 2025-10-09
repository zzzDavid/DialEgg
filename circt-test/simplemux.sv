// Simple 2:1 multiplexer with some redundant logic
module simplemux(
    input logic a, b, sel,
    output logic out
);
    // This has redundant operations that could be optimized
    logic temp1, temp2;
    
    assign temp1 = sel ? a : b;
    assign temp2 = sel ? a : b;  // Same as temp1 - redundant!
    assign out = temp1 & temp2;  // temp1 & temp1 = temp1
    
endmodule 