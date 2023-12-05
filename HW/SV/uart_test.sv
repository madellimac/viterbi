// Copyright (C) 2023  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 22.1std.2 Build 922 07/20/2023 SC Lite Edition"
// CREATED		"Tue Dec  5 15:38:53 2023"

module uart_test(
	CLK,
	RSTN,
	RXSIG,
	TXSIG,
	full_first_fifo,
	empty_first_fifo,
	full_second_fifo,
	empty_second_fifo
);


input wire	CLK;
input wire	RSTN;
input wire	RXSIG;
output wire	TXSIG;
output wire	full_first_fifo;
output wire	empty_first_fifo;
output wire	full_second_fifo;
output wire	empty_second_fifo;

wire	0;
wire	1;
wire	[5:0] in_first_fifo;
wire	o_empty_fifo2;
wire	[5:0] out_first_fifo;
wire	rst;
wire	rxvalid;
wire	tx_ready;
wire	SYNTHESIZED_WIRE_0;
wire	[5:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





uart_rx	b2v_inst(
	.rxsig(RXSIG),
	.rxready(1),
	.clk(CLK),
	.rstn(RSTN),
	.rxvalid(rxvalid),
	.rxdata(in_first_fifo));
	defparam	b2v_inst.BAUD_RATE = 115200;
	defparam	b2v_inst.CLK_FREQ = 100000000;
	defparam	b2v_inst.DATA_WIDTH = 6;


uart_tx	b2v_inst2(
	.txvalid(SYNTHESIZED_WIRE_0),
	.clk(CLK),
	.rstn(RSTN),
	.txdata(SYNTHESIZED_WIRE_1),
	.txsig(TXSIG),
	.txready(tx_ready));
	defparam	b2v_inst2.BAUD_RATE = 115200;
	defparam	b2v_inst2.CLK_FREQ = 100000000;
	defparam	b2v_inst2.DATA_WIDTH = 6;


fifo	b2v_inst3(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(o_empty_fifo2),
	.i_wr_en(rxvalid),
	.i_data(in_first_fifo),
	.o_dv(SYNTHESIZED_WIRE_2),
	.o_full(full_first_fifo),
	.o_empty(empty_first_fifo),
	.o_data(out_first_fifo));
	defparam	b2v_inst3.DATA_WIDTH = 6;
	defparam	b2v_inst3.DEPTH = 64;

assign	rst =  ~RSTN;



fifo	b2v_inst7(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(tx_ready),
	.i_wr_en(SYNTHESIZED_WIRE_2),
	.i_data(out_first_fifo),
	.o_dv(SYNTHESIZED_WIRE_0),
	.o_full(full_second_fifo),
	.o_empty(o_empty_fifo2),
	.o_data(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst7.DATA_WIDTH = 6;
	defparam	b2v_inst7.DEPTH = 64;


assign	empty_second_fifo = o_empty_fifo2;
assign	0 = 0;
assign	1 = 1;

endmodule
