`timescale 1ns / 1ps

module ACS(
    input  logic       rst,
    input  logic       clk,
    input  logic       enable,
    input  logic [3:0] MB0,
    input  logic [3:0] MB1,
    input  logic [6:0] MN0,
    input  logic [6:0] MN1,
    output logic [6:0] MN_out,
    output logic       decision
    );
    
    logic [6:0] MN_0_new, MN_1_new;
    logic [6:0] next_MN;
    
    assign MN_0_new = MN0 + MB0;
    assign MN_1_new = MN1 + MB1;
    
    always_comb
    begin
        if(MN_0_new < MN_1_new) begin 
            decision = '0;
            next_MN = MN_0_new;
        end
        else begin
            decision = '1;
            next_MN = MN_1_new;
        end
    end
    
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
            MN_out <= '0;
        else if (enable)
            MN_out <= next_MN;
    end
    
endmodule
