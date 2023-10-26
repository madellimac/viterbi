`timescale 1ns / 1ps

module branch_metric_unit
    #(
        parameter QB = 3
    )
    (
    input  logic           rst,
    input  logic           clk,
    input  logic           enable,
    input  logic [QB-1 : 0] y1,
    input  logic [QB-1 : 0] y2,
    output logic [QB   : 0] MB00,
    output logic [QB   : 0] MB01,
    output logic [QB   : 0] MB10,
    output logic [QB   : 0] MB11
    );
    
    localparam max = 4'd7;
    
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
            MB00 <= '0;
        else if (enable)
            MB00 <= {'0, y1} + {'0, y2};
    end
    
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
            MB01 <= '0;
        else if (enable)
            MB01 <= {'0, y1} + (max - {'0, y2});
    end
 
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
            MB10 <= '0;
        else if (enable)
            MB10 <= {'0, (max - y1)} + {'0, y2};
       end
    
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst)
            MB11 <= '0;
        else if (enable)
            MB11 <= {'0, (max - y1)} + {'0, (max - y2)};
    end       
    
endmodule
