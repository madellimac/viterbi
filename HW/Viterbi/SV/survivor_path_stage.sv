
`timescale 1ns / 1ps

module survivor_path_stage
    (input  logic         rst,
     input  logic         clk,
     input  logic         enable,
     input  logic [7 : 0] data_in,
     input  logic [7 : 0] decision,
     output logic [7 : 0] data_out);
    

	logic [7:0] reg_data;

	always_ff @(posedge clk, posedge rst)
	begin
		if(rst)
			reg_data <= '0;
		else if(enable)
			reg_data <= data_in;
	end

	always_comb
	begin
		if(decision[0] == '0)
			data_out[0] <= reg_data[0];
		else
			data_out[0] <= reg_data[1];
		
		if(decision[1] == '0)
			data_out[1] <= reg_data[2];
		else
			data_out[1] <= reg_data[3];
		
		if(decision[2] == '0)
			data_out[2] <= reg_data[4];
		else
			data_out[2] <= reg_data[5];
		
		if(decision[3] == '0)
			data_out[3] <= reg_data[6];
		else
			data_out[3] <= reg_data[7];
		
		if(decision[4] == '0)
			data_out[4] <= reg_data[0];
		else
			data_out[4] <= reg_data[1];
		
		if(decision[5] == '0)
			data_out[5] <= reg_data[2];
		else
			data_out[5] <= reg_data[3];
		
		if(decision[6] == '0)
			data_out[6] <= reg_data[4];
		else
			data_out[6] <= reg_data[5];
		
		if(decision[7] == '0)
			data_out[7] <= reg_data[6];
		else
			data_out[7] <= reg_data[7];
		
	end

endmodule
	
