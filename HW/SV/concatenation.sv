module concatenation #(parameter DATA_WIDTH = 8)(
	input logic clk,
	input logic rst,
	input logic data_un_bit,
	input logic enable_concat,
	output logic [DATA_WIDTH-1:0] out,
	output logic ready
	);

	int unsigned cnt=0;
	logic [DATA_WIDTH-1:0] mem;
	always_ff @(posedge clk or posedge rst) begin
		if (rst) begin
            cnt=0;
				ready=0;
				out =8'b00000000;
				mem =8'b00000000;
        end else begin
            if (enable_concat) begin
					mem[cnt]=data_un_bit;
					if (cnt==DATA_WIDTH) begin
						cnt=0;
						out=mem;
						ready=1;
						mem=0;
					end else begin
						cnt=cnt+1;
						ready=0;
					end   
				end
        end
	end
endmodule