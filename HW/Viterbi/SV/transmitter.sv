`timescale 1ns / 1ps

module transmitter(
    input rst,
    input clk,
    input enable,
    input [7:0] stream_in,
    output [7:0] stream_out,
    output data_valid
    );
    
    assign stream_out = stream_in;
    assign data_valid = enable;
    
endmodule