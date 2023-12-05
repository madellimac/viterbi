`timescale 1ns / 1ps

module decoder_top_level
(
    input  logic clk,
    input  logic rstn,
    input  logic rxsig,
    output logic tx    
);

logic rst;
logic received;
logic [5:0] in_data;
// logic en_decoder;
logic en_tx;
logic decoded_bit;
logic [2:0] compteur;


viterbi_decoder decoder(
    .rst(rst),
    .clk(clk),
    .enable(received),
    .y1(in_data[2:0]),
    .y2(in_data[5:3]),
    .decoded_bit(decoded_bit),
    .data_valid(en_tx)
);

uart_rx	
    #(
        .BAUD_RATE(9600),
        .CLK_FREQ(100_000_000),
        .DATA_WIDTH(6)
    ) uart_rx_inst
    (
        .rxsig(rxsig),
        .rxready(1'b1),
        .clk(clk),
        .rstn(rstn),
        .rxvalid(received),
        .rxdata(in_data)
    );


uart_tx
    #(
        .BAUD_RATE(9600),
        .CLK_FREQ(100_000_000),
        .DATA_WIDTH(1)
    ) uart_tx_inst
    (
        .txvalid(en_tx),
        .clk(clk),
        .rstn(rstn),
        .txdata(decoded_bit),
        .txsig(tx),
        .txready()
    );

    assign rst = ~rstn;

endmodule
