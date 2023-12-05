`timescale 1ns / 1ps

module tb_top_level_decoder();

    logic clk;
    logic rstn;
    logic rxsig;
    
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
        rxsig = 1'b1;
        repeat(20)   @(posedge clk); // 1449 cycles -> 9600 bauds
        rstn = 1'b1;
        repeat(10)   @(posedge clk); // 1449 cycles -> 9600 bauds
        
        
        repeat(10) @(posedge clk) begin
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b0; // start
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1; // 1
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1;
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1;
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1;
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1; // 6
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b0; // stop
            repeat(1449) @(posedge clk); // 1449 cycles -> 9600 bauds
            rxsig = 1'b1; // idle
            repeat(10000) @(posedge clk); // 1449 cycles -> 9600 bauds
        end
    end
endmodule
