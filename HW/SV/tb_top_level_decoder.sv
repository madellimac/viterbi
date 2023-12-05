`timescale 1ns / 1ps

module tb_top_level_decoder();

    logic clk;
    logic rstn;
    logic [5:0] rxsig;
    
    logic tx;

    decoder_top_level top_level(
        .clk(clk),
        .rstn(rstn),
        .rxsig(rxsig),
        .tx(tx)
    );
    
    localparam BAUD_RATE  = 9_600;
    localparam CLK_FREQ   = 100_000_000;

    logic clk, rstn;
    
    localparam CLK_PERIOD = 1_000_000_000 / CLK_FREQ;

    // Clock generation
    initial begin
        clk = 1'b0;
    end

    always #(CLK_PERIOD / 2) begin
        clk = ~clk;
    end
    
    // Other
    initial begin
        rstn = 1'b0;
        
        repeat(1449) @(posedge clk); // 1449 cycles -> 9600 Hz
    end

endmodule
