`timescale 1ns / 1ps

module list_selection_stage
    (input  logic [0:7]  i_data_list_0,
     input  logic [0:7]  i_data_list_1,
     input  logic [0:15] i_rank,
     output logic [0:7]  o_data_list_0,
     output logic [0:7]  o_data_list_1);
    
	always_comb
	begin	   
		if(i_rank[0] == '0)
			o_data_list_0[0] <= i_data_list_0[0];
		else
			o_data_list_0[0] <= i_data_list_1[0];
		if(i_rank[1] == '0)
			o_data_list_0[1] <= i_data_list_0[1];
		else
			o_data_list_0[1] <= i_data_list_1[1];
		if(i_rank[2] == '0)
			o_data_list_0[2] <= i_data_list_0[2];
		else
			o_data_list_0[2] <= i_data_list_1[2];
		if(i_rank[3] == '0)
			o_data_list_0[3] <= i_data_list_0[3];
		else
			o_data_list_0[3] <= i_data_list_1[3];
	    if(i_rank[4] == '0)
			o_data_list_0[4] <= i_data_list_0[4];
		else
			o_data_list_0[4] <= i_data_list_1[4];
		if(i_rank[5] == '0)
			o_data_list_0[5] <= i_data_list_0[5];
		else
			o_data_list_0[5] <= i_data_list_1[5];
		if(i_rank[6] == '0)
			o_data_list_0[6] <= i_data_list_0[6];
		else
			o_data_list_0[6] <= i_data_list_1[6];
		if(i_rank[7] == '0)
			o_data_list_0[7] <= i_data_list_0[7];
		else
			o_data_list_0[7] <= i_data_list_1[7];
		
		if(i_rank[8] == '0)
			o_data_list_1[0] <= i_data_list_0[0];
		else
			o_data_list_1[0] <= i_data_list_1[0];
		if(i_rank[9] == '0)
			o_data_list_1[1] <= i_data_list_0[1];
		else
			o_data_list_1[1] <= i_data_list_1[1];
		if(i_rank[10] == '0)
			o_data_list_1[2] <= i_data_list_0[2];
		else
			o_data_list_1[2] <= i_data_list_1[2];
		if(i_rank[11] == '0)
			o_data_list_1[3] <= i_data_list_0[3];
		else
			o_data_list_1[3] <= i_data_list_1[3];
	    if(i_rank[12] == '0)
			o_data_list_1[4] <= i_data_list_0[4];
		else
			o_data_list_1[4] <= i_data_list_1[4];
		if(i_rank[13] == '0)
			o_data_list_1[5] <= i_data_list_0[5];
		else
			o_data_list_1[5] <= i_data_list_1[5];
		if(i_rank[14] == '0)
			o_data_list_1[6] <= i_data_list_0[6];
		else
			o_data_list_1[6] <= i_data_list_1[6];
		if(i_rank[15] == '0)
			o_data_list_1[7] <= i_data_list_0[7];
		else
			o_data_list_1[7] <= i_data_list_1[7];
		
	end

endmodule
	