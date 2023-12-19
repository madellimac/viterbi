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
// CREATED		"Tue Dec 19 11:06:51 2023"

module uart_test(
	CLK,
	RSTN,
	RXSIG,
	from_first_to_second,
	from_second_to_PC,
	TXSIG,
	full_first_fifo,
	empty_first_fifo,
	full_second_fifo,
	empty_second_fifo,
	rx_valid,
	first_i_rd_en
);


input wire	CLK;
input wire	RSTN;
input wire	RXSIG;
input wire	from_first_to_second;
input wire	from_second_to_PC;
output wire	TXSIG;
output wire	full_first_fifo;
output wire	empty_first_fifo;
output wire	full_second_fifo;
output wire	empty_second_fifo;
output wire	rx_valid;
output wire	first_i_rd_en;

wire	first_i_rd_en_ALTERA_SYNTHESIZED;
wire	first_not_empty;
wire	first_not_full;
wire	rst;
wire	rxvalid;
wire	second_not_empty;
wire	second_not_full;
wire	tx_ready;
wire	un;
wire	zero;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[7:0] SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;

assign	full_first_fifo = SYNTHESIZED_WIRE_3;
assign	empty_first_fifo = SYNTHESIZED_WIRE_1;
assign	full_second_fifo = SYNTHESIZED_WIRE_0;
assign	empty_second_fifo = SYNTHESIZED_WIRE_2;




uart_rx	b2v_inst(
	.rxsig(RXSIG),
	.rxready(un),
	.clk(CLK),
	.rstn(RSTN),
	.rxvalid(rxvalid),
	.rxdata(SYNTHESIZED_WIRE_7));
	defparam	b2v_inst.BAUD_RATE = 9600;
	defparam	b2v_inst.CLK_FREQ = 100000000;
	defparam	b2v_inst.DATA_WIDTH = 8;

assign	second_not_full =  ~SYNTHESIZED_WIRE_0;

assign	first_not_empty =  ~SYNTHESIZED_WIRE_1;

assign	second_not_empty =  ~SYNTHESIZED_WIRE_2;

assign	first_not_full =  ~SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_6 = rxvalid & first_not_full;

assign	first_i_rd_en_ALTERA_SYNTHESIZED = first_not_empty & second_not_full & from_first_to_second;

assign	SYNTHESIZED_WIRE_8 = from_second_to_PC & second_not_empty & tx_ready;


uart_tx	b2v_inst2(
	.txvalid(SYNTHESIZED_WIRE_4),
	.clk(CLK),
	.rstn(RSTN),
	.txdata(SYNTHESIZED_WIRE_5),
	.txsig(TXSIG),
	.txready(tx_ready));
	defparam	b2v_inst2.BAUD_RATE = 9600;
	defparam	b2v_inst2.CLK_FREQ = 100000000;
	defparam	b2v_inst2.DATA_WIDTH = 8;


fifo	b2v_inst3(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(first_i_rd_en_ALTERA_SYNTHESIZED),
	.i_wr_en(SYNTHESIZED_WIRE_6),
	.i_data(SYNTHESIZED_WIRE_7),
	.o_dv(SYNTHESIZED_WIRE_9),
	.o_full(SYNTHESIZED_WIRE_3),
	.o_empty(SYNTHESIZED_WIRE_1),
	.o_data(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst3.DATA_WIDTH = 8;
	defparam	b2v_inst3.DEPTH = 64;

assign	rst =  ~RSTN;



fifo	b2v_inst7(
	.i_clk(CLK),
	.i_rst(rst),
	.i_rd_en(SYNTHESIZED_WIRE_8),
	.i_wr_en(SYNTHESIZED_WIRE_9),
	.i_data(SYNTHESIZED_WIRE_10),
	.o_dv(SYNTHESIZED_WIRE_4),
	.o_full(SYNTHESIZED_WIRE_0),
	.o_empty(SYNTHESIZED_WIRE_2),
	.o_data(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst7.DATA_WIDTH = 8;
	defparam	b2v_inst7.DEPTH = 64;


assign	rx_valid = rxvalid;
assign	first_i_rd_en = first_i_rd_en_ALTERA_SYNTHESIZED;
assign	un = 1;
assign	zero = 0;

endmodule
