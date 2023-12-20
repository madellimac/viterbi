`timescale 1ns / 1ps

module viterbi_decoder(
	input logic rst,
	input logic clk,
    input logic enable,
	input logic [2:0] y1,
    input logic [2:0] y2,
    output logic decoded_bit,
	output logic data_valid
	);

logic enable_dly1, enable_dly2, enable_dly3, enable_dly4;
logic [3:0] branch_metric [3:0];
logic [7:0] final_decision;
logic [15:0] decision;
logic [3:0] MB00, MB01, MB10, MB11;

always_ff @(posedge clk, posedge rst)
    begin
        if(rst) begin
            enable_dly1 <= 0;
            enable_dly2 <= 0;
            enable_dly3 <= 0;
            enable_dly4 <= 0;
        end else if (enable) begin
            enable_dly1 <= enable;            
            enable_dly2 <= enable_dly1;
            enable_dly3 <= enable_dly2;
            enable_dly4 <= enable_dly3;
	end
    end

    assign data_valid = enable_dly4;
	 
branch_metric_unit #(.QB(3)) BMU (.rst(rst),
			            .clk(clk),
			            .enable(enable_dly2),
			            .y1(y1),
			            .y2(y2),
			            .MB00(MB00),
			            .MB01(MB01),
			            .MB10(MB10),
			            .MB11(MB11));
						
assign branch_metric[0] = MB00;
assign branch_metric[1] = MB01;
assign branch_metric[2] = MB10;
assign branch_metric[3] = MB11;

state_metric_unit SMU ( .rst(rst),
	                    .clk(clk),
	                    .enable(enable_dly3),
	                    .branch_metric(branch_metric),
	                    .decision(decision));
	
survivor_path survivor_path_unit_0 (.rst(rst),
                                    .clk(clk),
                                    .enable(enable_dly3),
                                    .data_in(decision[7:0]),
                                    .data_out(final_decision));
	
assign decoded_bit = final_decision[0];

endmodule