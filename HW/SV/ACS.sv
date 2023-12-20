`timescale 1ns / 1ps

module ACS(
    input  logic       rst,
    input  logic       clk,
    input  logic       enable,
    input  logic [3:0] MB0,
    input  logic [3:0] MB1,
    input  logic [3:0] MB2,
    input  logic [3:0] MB3,
    input  logic [6:0] MN0,
    input  logic [6:0] MN1,
    input  logic [6:0] MN2,
    input  logic [6:0] MN3,
    output logic [6:0] M_min,
    output logic [6:0] M_min_2,
    output logic       decision,
    output logic       decision_2
    );
    
    logic [6:0] MN_0_new, MN_1_new, MN_2_new, MN_3_new;
    logic [6:0] m_01, m_23, M_01, M_23, mm_0123, Mm_23, mM_0123, MM_0123;
    logic dec_m_01, dec_m_23, dec_M_01, dec_M_23, dec_mm_0123, dec_Mm_23, dec_mM_0123, dec_MM_0123;
    logic [6:0] next_M_min, next_M_min_2;

    assign MN_0_new = MN0 + MB0;
    assign MN_1_new = MN1 + MB1;
    assign MN_2_new = MN2 + MB2;
    assign MN_3_new = MN3 + MB3;

    // sorting network
    CS cs_0(.A(MN_0_new), .dec_A('0),          .B(MN_1_new), .dec_B('1),          .min(m_01),       .dec_min(dec_m_01),    .max(M_01),         .dec_max(dec_M_01));
    CS cs_1(.A(MN_2_new), .dec_A('0),          .B(MN_3_new), .dec_B('1),          .min(m_23),       .dec_min(dec_m_23),    .max(M_23),         .dec_max(dec_M_23));
    CS cs_2(.A(m_01),     .dec_A(dec_m_01),    .B(m_23),     .dec_B(dec_m_23),    .min(mm_0123),    .dec_min(dec_mm_0123), .max(Mm_23),        .dec_max(dec_Mm_23));
    CS cs_3(.A(M_01),     .dec_A(dec_M_01),    .B(M_23),     .dec_B(dec_M_23),    .min(mM_0123),    .dec_min(dec_mM_0123), .max(MM_0123),      .dec_max(dec_MM_0123));
    CS cs_4(.A(mm_0123),  .dec_A(dec_mm_0123), .B(mM_0123),  .dec_B(dec_mM_0123), .min(next_M_min), .dec_min(decision),    .max(next_M_min_2), .dec_max(decicions_2));
       
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst) begin
            M_min <= 0;
            M_min_2 <= 0;
        end else if (enable) begin
            M_min <= next_M_min;
            M_min_2 <= next_M_min_2;
	end
    end
    
endmodule
