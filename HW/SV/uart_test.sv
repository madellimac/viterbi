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
// CREATED		"Fri Dec 15 11:51:41 2023"

module uart_test(
	CLK,
	RSTN,
	RXSIG,
	from_1st_to_2nd,
	from_2nd_to_PC,
	TXSIG,
	full_first_fifo,
	empty_first_fifo,
	full_second_fifo,
	empty_second_fifo,
	rx_valid
);


input wire	CLK;
input wire	RSTN;
input wire	RXSIG;
input wire	from_1st_to_2nd;
input wire	from_2nd_to_PC;
output wire	TXSIG;
output wire	full_first_fifo;
output wire	empty_first_fifo;
output wire	full_second_fifo;
output wire	empty_second_fifo;
output wire	rx_valid;

wire	rst;
wire	rxvalid;
wire	tx_ready;
wire	un;
wire	zero;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	[7:0] SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;





uart_rx	b2v_inst(
	.rxsig(RXSIG),
	.rxready(un),
	.clk(CLK),
	.rstn(RSTN),
	.rxvalid(rxvalid),
	.rxdata(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst.BAUD_RATE = 9600;
	defparam	b2v_inst.CLK_FREQ = 100000000;
	defparam	b2v_inst.DATA_WIDTH = 8;

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_0 & from_1st_to_2nd;


uart_tx	b2v_inst2(
	.txvalid(SYNTHESIZED_WIRE_1),
	.clk(CLK),
	.rstn(RSTN),
	.txdata(SYNTHESIZED_WIRE_2),
	.txsig(TXSIG),
	.txready(tx_ready));
	defparam	b2v_inst2.BAUD_RATE = 9600;
	defparam	b2v_inst2.CLK_FREQ = 100000000;
	defparam	b2v_inst2.DATA_WIDTH = 8;


fifo	b2v_inst3(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(from_1st_to_2nd),
	.i_wr_en(rxvalid),
	.i_data(SYNTHESIZED_WIRE_3),
	.o_dv(SYNTHESIZED_WIRE_0),
	.o_full(full_first_fifo),
	.o_empty(empty_first_fifo),
	.o_data(SYNTHESIZED_WIRE_6));
	defparam	b2v_inst3.DATA_WIDTH = 8;
	defparam	b2v_inst3.DEPTH = 64;

assign	SYNTHESIZED_WIRE_4 = from_2nd_to_PC & tx_ready;

assign	rst =  ~RSTN;



fifo	b2v_inst7(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(SYNTHESIZED_WIRE_4),
	.i_wr_en(SYNTHESIZED_WIRE_5),
	.i_data(SYNTHESIZED_WIRE_6),
	.o_dv(SYNTHESIZED_WIRE_7),
	.o_full(full_second_fifo),
	.o_empty(empty_second_fifo),
	.o_data(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst7.DATA_WIDTH = 8;
	defparam	b2v_inst7.DEPTH = 64;


assign	SYNTHESIZED_WIRE_1 = from_2nd_to_PC & SYNTHESIZED_WIRE_7;

assign	rx_valid = rxvalid;
assign	un = 1;
assign	zero = 0;

endmodule
