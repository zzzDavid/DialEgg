module NV_GR_SM_MIOP_partial (
    // Input data signals (32 x 32-bit)
    input  logic [31:0] i3_ra_data0,
    input  logic [31:0] i3_ra_data1,
    input  logic [31:0] i3_ra_data2,
    input  logic [31:0] i3_ra_data3,
    input  logic [31:0] i3_ra_data4,
    input  logic [31:0] i3_ra_data5,
    input  logic [31:0] i3_ra_data6,
    input  logic [31:0] i3_ra_data7,
    input  logic [31:0] i3_ra_data8,
    input  logic [31:0] i3_ra_data9,
    input  logic [31:0] i3_ra_data10,
    input  logic [31:0] i3_ra_data11,
    input  logic [31:0] i3_ra_data12,
    input  logic [31:0] i3_ra_data13,
    input  logic [31:0] i3_ra_data14,
    input  logic [31:0] i3_ra_data15,
    input  logic [31:0] i3_ra_data16,
    input  logic [31:0] i3_ra_data17,
    input  logic [31:0] i3_ra_data18,
    input  logic [31:0] i3_ra_data19,
    input  logic [31:0] i3_ra_data20,
    input  logic [31:0] i3_ra_data21,
    input  logic [31:0] i3_ra_data22,
    input  logic [31:0] i3_ra_data23,
    input  logic [31:0] i3_ra_data24,
    input  logic [31:0] i3_ra_data25,
    input  logic [31:0] i3_ra_data26,
    input  logic [31:0] i3_ra_data27,
    input  logic [31:0] i3_ra_data28,
    input  logic [31:0] i3_ra_data29,
    input  logic [31:0] i3_ra_data30,
    input  logic [31:0] i3_ra_data31,
    
    // Active mask input (32-bit)
    input  logic [31:0] i3_agu_active_mask,
    
    // Output XOR comparison results
    output logic i3_q0_is_xor_1,
    output logic i3_q0_is_xor_2,
    output logic i3_q1_is_xor_1,
    output logic i3_q1_is_xor_2,
    output logic i3_q2_is_xor_1,
    output logic i3_q2_is_xor_2,
    output logic i3_q3_is_xor_1,
    output logic i3_q3_is_xor_2,
    output logic i3_q4_is_xor_1,
    output logic i3_q4_is_xor_2,
    output logic i3_q5_is_xor_1,
    output logic i3_q5_is_xor_2,
    output logic i3_q6_is_xor_1,
    output logic i3_q6_is_xor_2,
    output logic i3_q7_is_xor_1,
    output logic i3_q7_is_xor_2
);

always_comb begin
    i3_q0_is_xor_1 = ( (i3_ra_data0[31:0] == i3_ra_data1[31:0])      ||
                            ~(i3_agu_active_mask[0] && i3_agu_active_mask[1]) ) &&
                           ( (i3_ra_data2[31:0] == i3_ra_data3[31:0])      || 
                            ~(i3_agu_active_mask[2] && i3_agu_active_mask[3]) );
                                
    i3_q0_is_xor_2 = ( (i3_ra_data0[31:0] == i3_ra_data2[31:0])      ||
                            ~(i3_agu_active_mask[0] && i3_agu_active_mask[2]) ) &&
                           ( (i3_ra_data1[31:0] == i3_ra_data3[31:0])      || 
                            ~(i3_agu_active_mask[1] && i3_agu_active_mask[3]) );
                                

    i3_q1_is_xor_1 = ( (i3_ra_data4[31:0] == i3_ra_data5[31:0])      ||
                            ~(i3_agu_active_mask[4] && i3_agu_active_mask[5]) ) &&
                           ( (i3_ra_data6[31:0] == i3_ra_data7[31:0])      || 
                            ~(i3_agu_active_mask[6] && i3_agu_active_mask[7]) );
                                
    i3_q1_is_xor_2 = ( (i3_ra_data4[31:0] == i3_ra_data6[31:0])      ||
                            ~(i3_agu_active_mask[4] && i3_agu_active_mask[6]) ) &&
                           ( (i3_ra_data5[31:0] == i3_ra_data7[31:0])      || 
                            ~(i3_agu_active_mask[5] && i3_agu_active_mask[7]) );
                                

    i3_q2_is_xor_1 = ( (i3_ra_data8[31:0] == i3_ra_data9[31:0])      ||
                            ~(i3_agu_active_mask[8] && i3_agu_active_mask[9]) ) &&
                           ( (i3_ra_data10[31:0] == i3_ra_data11[31:0])      || 
                            ~(i3_agu_active_mask[10] && i3_agu_active_mask[11]) );
                                
    i3_q2_is_xor_2 = ( (i3_ra_data8[31:0] == i3_ra_data10[31:0])      ||
                            ~(i3_agu_active_mask[8] && i3_agu_active_mask[10]) ) &&
                           ( (i3_ra_data9[31:0] == i3_ra_data11[31:0])      || 
                            ~(i3_agu_active_mask[9] && i3_agu_active_mask[11]) );
                                

    i3_q3_is_xor_1 = ( (i3_ra_data12[31:0] == i3_ra_data13[31:0])      ||
                            ~(i3_agu_active_mask[12] && i3_agu_active_mask[13]) ) &&
                           ( (i3_ra_data14[31:0] == i3_ra_data15[31:0])      || 
                            ~(i3_agu_active_mask[14] && i3_agu_active_mask[15]) );
                                
    i3_q3_is_xor_2 = ( (i3_ra_data12[31:0] == i3_ra_data14[31:0])      ||
                            ~(i3_agu_active_mask[12] && i3_agu_active_mask[14]) ) &&
                           ( (i3_ra_data13[31:0] == i3_ra_data15[31:0])      || 
                            ~(i3_agu_active_mask[13] && i3_agu_active_mask[15]) );
                                

    i3_q4_is_xor_1 = ( (i3_ra_data16[31:0] == i3_ra_data17[31:0])      ||
                            ~(i3_agu_active_mask[16] && i3_agu_active_mask[17]) ) &&
                           ( (i3_ra_data18[31:0] == i3_ra_data19[31:0])      || 
                            ~(i3_agu_active_mask[18] && i3_agu_active_mask[19]) );
                                
    i3_q4_is_xor_2 = ( (i3_ra_data16[31:0] == i3_ra_data18[31:0])      ||
                            ~(i3_agu_active_mask[16] && i3_agu_active_mask[18]) ) &&
                           ( (i3_ra_data17[31:0] == i3_ra_data19[31:0])      || 
                            ~(i3_agu_active_mask[17] && i3_agu_active_mask[19]) );
                                

    i3_q5_is_xor_1 = ( (i3_ra_data20[31:0] == i3_ra_data21[31:0])      ||
                            ~(i3_agu_active_mask[20] && i3_agu_active_mask[21]) ) &&
                           ( (i3_ra_data22[31:0] == i3_ra_data23[31:0])      || 
                            ~(i3_agu_active_mask[22] && i3_agu_active_mask[23]) );
                                
    i3_q5_is_xor_2 = ( (i3_ra_data20[31:0] == i3_ra_data22[31:0])      ||
                            ~(i3_agu_active_mask[20] && i3_agu_active_mask[22]) ) &&
                           ( (i3_ra_data21[31:0] == i3_ra_data23[31:0])      || 
                            ~(i3_agu_active_mask[21] && i3_agu_active_mask[23]) );
                                

    i3_q6_is_xor_1 = ( (i3_ra_data24[31:0] == i3_ra_data25[31:0])      ||
                            ~(i3_agu_active_mask[24] && i3_agu_active_mask[25]) ) &&
                           ( (i3_ra_data26[31:0] == i3_ra_data27[31:0])      || 
                            ~(i3_agu_active_mask[26] && i3_agu_active_mask[27]) );
                                
    i3_q6_is_xor_2 = ( (i3_ra_data24[31:0] == i3_ra_data26[31:0])      ||
                            ~(i3_agu_active_mask[24] && i3_agu_active_mask[26]) ) &&
                           ( (i3_ra_data25[31:0] == i3_ra_data27[31:0])      || 
                            ~(i3_agu_active_mask[25] && i3_agu_active_mask[27]) );
                                

    i3_q7_is_xor_1 = ( (i3_ra_data28[31:0] == i3_ra_data29[31:0])      ||
                            ~(i3_agu_active_mask[28] && i3_agu_active_mask[29]) ) &&
                           ( (i3_ra_data30[31:0] == i3_ra_data31[31:0])      || 
                            ~(i3_agu_active_mask[30] && i3_agu_active_mask[31]) );
                                
    i3_q7_is_xor_2 = ( (i3_ra_data28[31:0] == i3_ra_data30[31:0])      ||
                            ~(i3_agu_active_mask[28] && i3_agu_active_mask[30]) ) &&
                           ( (i3_ra_data29[31:0] == i3_ra_data31[31:0])      || 
                            ~(i3_agu_active_mask[29] && i3_agu_active_mask[31]) );
                                

//| &End;
end

endmodule