module rr_arbiter #(
    parameter int N = 4  // number of requesters
)(
    input  logic           clk,
    input  logic           rst_n,
    input  logic [N-1:0]   req,    // request lines
    output logic [N-1:0]   grant   // one-hot grant output
);

    logic [N-1:0] mask;
    logic [N-1:0] masked_req;
    logic [N-1:0] grant_int;

    // Next mask
    logic [N-1:0] next_mask;

    // Apply current mask to requests
    assign masked_req = req & mask;

    // Priority encoder: grant masked first, then unmasked
    always_comb begin
        grant_int = '0;
        for (int i = 0; i < N; i++) begin
            if (masked_req[i]) begin
                grant_int[i] = 1;
                break;
            end
        end
        // If nothing masked is requested, fall back to unmasked
        if (grant_int == '0) begin
            for (int i = 0; i < N; i++) begin
                if (req[i]) begin
                    grant_int[i] = 1;
                    break;
                end
            end
        end
    end

    // Update mask on grant
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mask <= 'b1 << 1; // initial mask (e.g., 000...0010)
        end else begin
            // Rotate mask based on granted position
            for (int i = 0; i < N; i++) begin
                if (grant_int[i]) begin
                    mask <= {grant_int[N-2:0], grant_int[N-1]};
                    break;
                end
            end
        end
    end

    assign grant = grant_int;

endmodule
