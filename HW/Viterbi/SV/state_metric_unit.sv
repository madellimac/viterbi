`timescale 1ns / 1ps

module state_metric_unit(
    input logic rst,
    input logic clk,
    input logic enable,
    input logic [3:0] branch_metric [0:3],
    output logic [7:0] decision
    );

logic [6:0] state_metric_loopback [0:7];
logic [6:0] state_metric_tmp [0:7];
    
ACS acs0 (.MB0(branch_metric[0]), .MB1(branch_metric[3]), .MN0(state_metric_loopback[0]), .MN1(state_metric_loopback[1]), .decision(decision[0]), .MN_out(state_metric_tmp[0]), .*);
ACS acs1 (.MB0(branch_metric[1]), .MB1(branch_metric[2]), .MN0(state_metric_loopback[2]), .MN1(state_metric_loopback[3]), .decision(decision[1]), .MN_out(state_metric_tmp[1]), .*);
ACS acs2 (.MB0(branch_metric[2]), .MB1(branch_metric[1]), .MN0(state_metric_loopback[4]), .MN1(state_metric_loopback[5]), .decision(decision[2]), .MN_out(state_metric_tmp[2]), .*);
ACS acs3 (.MB0(branch_metric[3]), .MB1(branch_metric[0]), .MN0(state_metric_loopback[6]), .MN1(state_metric_loopback[7]), .decision(decision[3]), .MN_out(state_metric_tmp[3]), .*);
ACS acs4 (.MB0(branch_metric[3]), .MB1(branch_metric[0]), .MN0(state_metric_loopback[0]), .MN1(state_metric_loopback[1]), .decision(decision[4]), .MN_out(state_metric_tmp[4]), .*);
ACS acs5 (.MB0(branch_metric[2]), .MB1(branch_metric[1]), .MN0(state_metric_loopback[2]), .MN1(state_metric_loopback[3]), .decision(decision[5]), .MN_out(state_metric_tmp[5]), .*);
ACS acs6 (.MB0(branch_metric[1]), .MB1(branch_metric[2]), .MN0(state_metric_loopback[4]), .MN1(state_metric_loopback[5]), .decision(decision[6]), .MN_out(state_metric_tmp[6]), .*);
ACS acs7 (.MB0(branch_metric[0]), .MB1(branch_metric[3]), .MN0(state_metric_loopback[6]), .MN1(state_metric_loopback[7]), .decision(decision[7]), .MN_out(state_metric_tmp[7]), .*);

assign state_metric_loopback[0][5:0] = state_metric_tmp[0][5:0];
assign state_metric_loopback[1][5:0] = state_metric_tmp[1][5:0];
assign state_metric_loopback[2][5:0] = state_metric_tmp[2][5:0];
assign state_metric_loopback[3][5:0] = state_metric_tmp[3][5:0];
assign state_metric_loopback[4][5:0] = state_metric_tmp[4][5:0];
assign state_metric_loopback[5][5:0] = state_metric_tmp[5][5:0];
assign state_metric_loopback[6][5:0] = state_metric_tmp[6][5:0];
assign state_metric_loopback[7][5:0] = state_metric_tmp[7][5:0];

always_comb
begin
    if(state_metric_tmp[0][6]&state_metric_tmp[1][6]&state_metric_tmp[2][6]&state_metric_tmp[3][6]&state_metric_tmp[4][6]&state_metric_tmp[5][6]&state_metric_tmp[6][6]&state_metric_tmp[7][6])
    begin
        state_metric_loopback[0][6] <= '0;
        state_metric_loopback[1][6] <= '0;
        state_metric_loopback[2][6] <= '0;
        state_metric_loopback[3][6] <= '0;
        state_metric_loopback[4][6] <= '0;
        state_metric_loopback[5][6] <= '0;
        state_metric_loopback[6][6] <= '0;
        state_metric_loopback[7][6] <= '0;
    end
    else
    begin
        state_metric_loopback[0][6] <= state_metric_tmp[0][6];
        state_metric_loopback[1][6] <= state_metric_tmp[1][6];
        state_metric_loopback[2][6] <= state_metric_tmp[2][6];
        state_metric_loopback[3][6] <= state_metric_tmp[3][6];
        state_metric_loopback[4][6] <= state_metric_tmp[4][6];
        state_metric_loopback[5][6] <= state_metric_tmp[5][6];
        state_metric_loopback[6][6] <= state_metric_tmp[6][6];
        state_metric_loopback[7][6] <= state_metric_tmp[7][6];
    end
end

endmodule
