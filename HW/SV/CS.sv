`timescale 1ns / 1ps

module CS(
    input  logic [6:0] A,
    input  logic [1:0] idx_A,
    input  logic [6:0] B,
    input  logic [1:0] idx_B,
    output logic [6:0] min,
    output logic [1:0] idx_min,
    output logic [6:0] max,
    output logic [1:0] idx_max
    );
    
    always_comb
    begin
        if(A < B) begin 
            min = A;
            idx_min = idx_A;
            max = B;
            idx_max = idx_B;
        end
        else begin
            min = B;
            idx_min = idx_B;
            max = A;
            idx_max = idx_A;
        end
    end    
    
endmodule
