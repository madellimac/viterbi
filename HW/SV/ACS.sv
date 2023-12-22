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
    output logic       decision_2,
    output logic       rank,
    output logic       rank_2
    );
    
    logic [6:0] MN_0_new, MN_1_new, MN_2_new, MN_3_new;
    logic [6:0] m_01, m_23, M_01, M_23, mM_0123, Mm_0123;
    logic dec_m_01, dec_m_23, dec_M_01, dec_mM_0123, dec_Mm_0123;
    logic rnk_m_01, rnk_m_23, rnk_M_01, rnk_mM_0123, rnk_Mm_0123;
    logic [6:0] next_M_min, next_M_min_2, next_M_min_3;
    

    assign MN_0_new = MN0 + MB0;
    assign MN_1_new = MN1 + MB1;
    assign MN_2_new = MN2 + MB2;
    assign MN_3_new = MN3 + MB3;

    assign rnk_0 = '0;
    assign rnk_1 = '0;
    assign rnk_2 = '1;
    assign rnk_3 = '1;

    assign dec_0 = '0;
    assign dec_1 = '1;

    // sorting network
    CS cs_0(.A(MN_0_new), .idx_A({rnk_0, dec_0}), .B(MN_1_new), .idx_B({rnk_0, dec_1}), .min(m_01), .idx_min({rnk_m_01, dec_m_01}), .max(M_01), .idx_max({rnk_M_01, dec_M_01}));
    CS cs_1(.A(MN_2_new), .idx_A({rnk_2, dec_0}), .B(MN_3_new), .idx_B({rnk_3, dec_1}), .min(m_23), .idx_min({rnk_m_23, dec_m_23}), .max(M_23), .idx_max({rnk_M_23, dec_M_23}));
    CS cs_2(.A(m_01), .idx_A({rnk_m_01, dec_m_01}), .B(m_23), .idx_B({rnk_m_23, dec_m_23}), .min(next_M_min), .idx_min({rank, decision}), .max(mM_0123), .idx_max({rnk_mM_0123, dec_mM_0123}));
    CS cs_3(.A(M_01), .idx_A({rnk_M_01, dec_M_01}), .B(M_23), .idx_B({rnk_M_23, dec_M_23}), .min(Mm_0123), .idx_min({rnk_Mm_0123, dec_Mm_0123}), .max(MM_0123), .idx_max({rnk_MM_0123, dec_MM_0123}));
    CS cs_4(.A(mM_0123), .idx_A({rnk_mM_0123, dec_mM_0123}), .B(Mm_0123), .idx_B({rnk_Mm_0123, dec_Mm_0123}), .min(next_M_min_2), .idx_min({rank_2, decision_2}), .max(next_M_min_3), .idx_max({rank_3, decicion_3}));
    
       
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
