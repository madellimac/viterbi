module delay #(parameter DELAY = 100)(
	input logic clk,
	input logic to_delay,
	input logic enable,
	input logic rst,
	output logic out);

	int      unsigned		cnt=0;
	logic 					cnt_enable=0;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst) begin
            cnt=0;
				cnt_enable=0;
				out=0;
        end else begin
            if (enable) begin
					if (to_delay && !cnt_enable) begin
						cnt=0;
						cnt_enable=1;
						out=0;
					end else if (cnt==DELAY) begin
						out <= 1;
						cnt =0;
						cnt_enable=0;
					end else if (cnt_enable) begin
						cnt=cnt+1;
						out=0;
					end else begin
						out=0;
					end
            end           
        end
	end
endmodule