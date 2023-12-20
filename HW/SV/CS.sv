`timescale 1ns / 1ps

module CS(
    input  logic [6:0] A,
    input  logic       dec_A,
    input  logic [6:0] B,
    input  logic       dec_B,
    output logic [6:0] min,
    output logic       dec_min,
    output logic [6:0] max,
    output logic       dec_max
    );
    
    always_comb
    begin
        if(A < B) begin 
            min = A;
            dec_min = dec_A;
            max = B;
            dec_max = dec_B;
        end
        else begin
            min = B;
            dec_min = dec_B;
            max = A;
            dec_max = dec_A;
        end
    end    
    
endmodule
