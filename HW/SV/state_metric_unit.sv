`timescale 1ns / 1ps

module state_metric_unit(
    input logic rst,
    input logic clk,
    input logic enable,
    input logic [3:0] branch_metric [0:3],
    output logic [15:0] decision
    );

logic [6:0] state_metric_loopback [0:15];
logic [6:0] state_metric_tmp [0:15];
    
ACS acs0 (  .MB0(branch_metric[0]),
            .MB1(branch_metric[3]),
            .MB2(branch_metric[0]),
            .MB3(branch_metric[3]),
            .MN0(state_metric_loopback[0]),
            .MN1(state_metric_loopback[1]),
            .MN2(state_metric_loopback[8]),
            .MN3(state_metric_loopback[9]),
            .decision(decision[0]),
            .decision_2(decision[8]),
            .M_min(state_metric_tmp[0]),
            .M_min_2(state_metric_tmp[8]),
            .*);

ACS acs1 (  .MB0(branch_metric[1]),
            .MB1(branch_metric[2]),
            .MB2(branch_metric[1]),
            .MB3(branch_metric[2]),
            .MN0(state_metric_loopback[2]),
            .MN1(state_metric_loopback[3]),
            .MN2(state_metric_loopback[10]),
            .MN3(state_metric_loopback[11]),
            .decision(decision[1]),
            .decision_2(decision[9]),
            .M_min(state_metric_tmp[1]),
            .M_min_2(state_metric_tmp[9]),
            .*);

ACS acs2 (  .MB0(branch_metric[2]),
            .MB1(branch_metric[1]),
            .MB2(branch_metric[2]),
            .MB3(branch_metric[1]),
            .MN0(state_metric_loopback[4]),
            .MN1(state_metric_loopback[5]),
            .MN2(state_metric_loopback[12]),
            .MN3(state_metric_loopback[13]),
            .decision(decision[2]),
            .decision_2(decision[10]),
            .M_min(state_metric_tmp[2]),
            .M_min_2(state_metric_tmp[10]),
            .*);

ACS acs3 (  .MB0(branch_metric[3]),
            .MB1(branch_metric[0]),
            .MB2(branch_metric[3]),
            .MB3(branch_metric[0]),
            .MN0(state_metric_loopback[6]),
            .MN1(state_metric_loopback[7]),
            .MN2(state_metric_loopback[14]),
            .MN3(state_metric_loopback[15]),
            .decision(decision[3]),
            .decision_2(decision[11]),
            .M_min(state_metric_tmp[3]),
            .M_min_2(state_metric_tmp[11]),
            .*);

ACS acs4 (  .MB0(branch_metric[3]),
            .MB1(branch_metric[0]),
            .MB2(branch_metric[3]),
            .MB3(branch_metric[0]),
            .MN0(state_metric_loopback[0]),
            .MN1(state_metric_loopback[1]),
            .MN2(state_metric_loopback[8]),
            .MN3(state_metric_loopback[9]),
            .decision(decision[4]),
            .decision_2(decision[12]),
            .M_min(state_metric_tmp[4]),
            .M_min_2(state_metric_tmp[12]),
            .*);

ACS acs5 (  .MB0(branch_metric[2]),
            .MB1(branch_metric[1]),
            .MB2(branch_metric[2]),
            .MB3(branch_metric[1]),
            .MN0(state_metric_loopback[2]),
            .MN1(state_metric_loopback[3]),
            .MN2(state_metric_loopback[10]),
            .MN3(state_metric_loopback[11]),
            .decision(decision[5]),
            .decision_2(decision[13]),
            .M_min(state_metric_tmp[5]),
            .M_min_2(state_metric_tmp[13]),
            .*);

ACS acs6 (  .MB0(branch_metric[1]),
            .MB1(branch_metric[2]),
            .MB2(branch_metric[2]),
            .MB3(branch_metric[1]),
            .MN0(state_metric_loopback[4]),
            .MN1(state_metric_loopback[5]),
            .MN2(state_metric_loopback[12]),
            .MN3(state_metric_loopback[13]),
            .decision(decision[6]),
            .decision_2(decision[14]),
            .M_min(state_metric_tmp[6]),
            .M_min_2(state_metric_tmp[14]),
            .*);

ACS acs7 (  .MB0(branch_metric[0]),
            .MB1(branch_metric[3]),
            .MB2(branch_metric[0]),
            .MB3(branch_metric[3]),
            .MN0(state_metric_loopback[6]),
            .MN1(state_metric_loopback[7]),
            .MN2(state_metric_loopback[14]),
            .MN3(state_metric_loopback[15]),
            .decision(decision[7]),
            .decision_2(decision[15]),
            .M_min(state_metric_tmp[7]),
            .M_min_2(state_metric_tmp[15]),
            .*);

assign state_metric_loopback[0][5:0] = state_metric_tmp[0][5:0];
assign state_metric_loopback[1][5:0] = state_metric_tmp[1][5:0];
assign state_metric_loopback[2][5:0] = state_metric_tmp[2][5:0];
assign state_metric_loopback[3][5:0] = state_metric_tmp[3][5:0];
assign state_metric_loopback[4][5:0] = state_metric_tmp[4][5:0];
assign state_metric_loopback[5][5:0] = state_metric_tmp[5][5:0];
assign state_metric_loopback[6][5:0] = state_metric_tmp[6][5:0];
assign state_metric_loopback[7][5:0] = state_metric_tmp[7][5:0];
assign state_metric_loopback[8][5:0] = state_metric_tmp[8][5:0];
assign state_metric_loopback[9][5:0] = state_metric_tmp[9][5:0];
assign state_metric_loopback[10][5:0] = state_metric_tmp[10][5:0];
assign state_metric_loopback[11][5:0] = state_metric_tmp[11][5:0];
assign state_metric_loopback[12][5:0] = state_metric_tmp[12][5:0];
assign state_metric_loopback[13][5:0] = state_metric_tmp[13][5:0];
assign state_metric_loopback[14][5:0] = state_metric_tmp[14][5:0];
assign state_metric_loopback[15][5:0] = state_metric_tmp[15][5:0];

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

always_comb
begin
    if(state_metric_tmp[8][6]&state_metric_tmp[9][6]&state_metric_tmp[10][6]&state_metric_tmp[11][6]&state_metric_tmp[12][6]&state_metric_tmp[13][6]&state_metric_tmp[14][6]&state_metric_tmp[15][6])
    begin
        state_metric_loopback[8][6] <= '0;
        state_metric_loopback[9][6] <= '0;
        state_metric_loopback[10][6] <= '0;
        state_metric_loopback[11][6] <= '0;
        state_metric_loopback[12][6] <= '0;
        state_metric_loopback[13][6] <= '0;
        state_metric_loopback[14][6] <= '0;
        state_metric_loopback[15][6] <= '0;
    end
    else
    begin
        state_metric_loopback[8][6] <= state_metric_tmp[8][6];
        state_metric_loopback[9][6] <= state_metric_tmp[9][6];
        state_metric_loopback[10][6] <= state_metric_tmp[10][6];
        state_metric_loopback[11][6] <= state_metric_tmp[11][6];
        state_metric_loopback[12][6] <= state_metric_tmp[12][6];
        state_metric_loopback[13][6] <= state_metric_tmp[13][6];
        state_metric_loopback[14][6] <= state_metric_tmp[14][6];
        state_metric_loopback[15][6] <= state_metric_tmp[15][6];
    end
end

endmodule
