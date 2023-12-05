`timescale 1ns / 1ps

module enable_manager(
    input clk,
    input rst,
    input received,
    output en_decoder,
    output en_tx
    );
    
    logic en_decoder, en_tx;
    shortint delay;

    always_ff @(posedge clk) begin
        if(rst) begin
            delay = 4; // A vérifier
        end else begin
            if(received) begin
                en_decoder <= 'b1;
                en_tx <= 'b0;
                delay = 4;
            end else begin
                en_decoder <= 'b0;
                if(delay == 1) begin
                    en_tx <= 'b1;
                end else if(delay != 0) begin
                    en_tx <= 'b0;
                    delay -= 1;
                end
            end
        end
    end
endmodule