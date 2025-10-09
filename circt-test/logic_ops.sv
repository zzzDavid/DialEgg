// Logic operations with optimization opportunities
module logic_ops(
    input logic [3:0] a, b,
    output logic [3:0] out1, out2, out3
);
    // Double negation: !(!a) = a
    assign out1 = !(!a);
    
    // Idempotent operations: a & a = a, a | a = a
    assign out2 = a & a;
    
    // Absorption: a & (a | b) = a
    assign out3 = a & (a | b);
    
endmodule 