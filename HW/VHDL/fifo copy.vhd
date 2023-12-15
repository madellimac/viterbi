`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 11:51:42 AM
// Design Name: 
// Module Name: socket
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo #(parameter DATA_WIDTH = 8, DEPTH = 4)(
    input logic i_clk,
    input logic i_rst,
    input logic [DATA_WIDTH-1:0] i_data,
    input logic i_rd_en,
    input logic i_wr_en,
    
    output logic [DATA_WIDTH-1:0] o_data,
    output logic o_dv,
    output logic o_full,
    output logic o_empty);

    // Déclaration du tableau de stockage des données
    logic [DATA_WIDTH-1:0] fifo [DEPTH-1:0];

    // Déclaration des pointeurs de lecture et écriture
    logic [$clog2(DEPTH):0] wr_ptr, rd_ptr;
    logic [$clog2(DEPTH):0] data_count;

    // Logique de contrôle
    always_ff @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            wr_ptr <= 0;
            fifo[DEPTH-1:0] <= '{DEPTH{0}};
        end else begin
            if (i_wr_en && !o_full) begin
                if(wr_ptr == DEPTH-1) begin
                    fifo[wr_ptr] <= i_data;
                    wr_ptr <= 0;
                end else begin
                    fifo[wr_ptr] <= i_data;
                    wr_ptr <= wr_ptr + 1;
                end             
            end           
        end
    end

    // Logique de contrôle
    always_ff @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            rd_ptr <= 0;
            o_dv <= 0;
            o_data <= 0;
        end else begin
            if (i_rd_en && !o_empty) begin
                if(rd_ptr == DEPTH-1) begin
                    o_data <= fifo[rd_ptr];
                    o_dv <= 1;
                    rd_ptr <= 0;
                end else begin
                    o_data <= fifo[rd_ptr];
                    o_dv <= 1;
                    rd_ptr <= rd_ptr + 1;
                end
            end else begin
                o_data <= fifo[rd_ptr];
                o_dv <= 0;
                rd_ptr <= rd_ptr;            
            end
        end
    end
    
    always_ff @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            data_count <= 0;
        end else begin
            if (i_rd_en && !i_wr_en) begin
                data_count <= data_count -1;
            end else if(!i_rd_en && i_wr_en) begin
                data_count <= data_count +1;             
            end else begin
                data_count <= data_count;
            end
        end
    end
    
    assign o_full = (data_count == DEPTH);
    assign o_empty = (data_count == 0);
    

endmodule