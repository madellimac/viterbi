`timescale 1ns / 1ps


module pos_edge_detector(
    input sig_in,
    input clk,
    output sig_out
    );
    
    reg sig_dly;
    
    always @(posedge clk) begin
        sig_dly <= sig_in;
    end
    
    assign sig_out = sig_in & ~sig_dly;
    
endmodule
