// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Fri Nov 17 09:37:01 2023"

module uart_test(
	CLK,
	RSTN,
	RXSIG,
	TXSIG,
	TXREADY
);


input wire	CLK;
input wire	RSTN;
input wire	RXSIG;
output wire	TXSIG;
output wire	TXREADY;

wire	SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;





uart_rx	b2v_inst(
	.rxsig(RXSIG),
	.rxready(1'b1),
	.clk(CLK),
	.rstn(RSTN),
	.rxvalid(SYNTHESIZED_WIRE_0),
	.rxdata(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst.BAUD_RATE = 115200;
	defparam	b2v_inst.CLK_FREQ = 100000000;
	defparam	b2v_inst.DATA_WIDTH = 8;


uart_tx	b2v_inst2(
	.txvalid(SYNTHESIZED_WIRE_0),
	.clk(CLK),
	.rstn(RSTN),
	.txdata(SYNTHESIZED_WIRE_1),
	.txsig(TXSIG),
	.txready(TXREADY));
	defparam	b2v_inst2.BAUD_RATE = 115200;
	defparam	b2v_inst2.CLK_FREQ = 100000000;
	defparam	b2v_inst2.DATA_WIDTH = 8;


endmodule
