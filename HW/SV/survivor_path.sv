`timescale 1ns / 1ps

module survivor_path
    (input  logic         rst,
     input  logic         clk,
     input  logic         enable,
     input  logic [7 : 0] data_in,
     output logic [7 : 0] data_out);

logic [7:0] st0_out, st1_out, st2_out, st3_out, st4_out, st5_out, st6_out, st7_out, st8_out, st9_out, st10_out, st11_out, st12_out, st13_out, st14_out, st15_out, st16_out, st17_out, st18_out, st19_out;

survivor_path_stage stage_0(.data_in(data_in),   .decision(data_in), .data_out(st0_out), .*);
survivor_path_stage stage_1(.data_in(st0_out),   .decision(data_in), .data_out(st1_out), .*);
survivor_path_stage stage_2(.data_in(st1_out),   .decision(data_in), .data_out(st2_out), .*);
survivor_path_stage stage_3(.data_in(st2_out),   .decision(data_in), .data_out(st3_out), .*);
survivor_path_stage stage_4(.data_in(st3_out),   .decision(data_in), .data_out(st4_out), .*);
survivor_path_stage stage_5(.data_in(st4_out),   .decision(data_in), .data_out(st5_out), .*);
survivor_path_stage stage_6(.data_in(st5_out),   .decision(data_in), .data_out(st6_out), .*);
survivor_path_stage stage_7(.data_in(st6_out),   .decision(data_in), .data_out(st7_out), .*);
survivor_path_stage stage_8(.data_in(st7_out),   .decision(data_in), .data_out(st8_out), .*);
survivor_path_stage stage_9(.data_in(st8_out),   .decision(data_in), .data_out(st9_out), .*);
survivor_path_stage stage_10(.data_in(st9_out),  .decision(data_in), .data_out(st10_out), .*);
survivor_path_stage stage_11(.data_in(st10_out), .decision(data_in), .data_out(st11_out), .*);
survivor_path_stage stage_12(.data_in(st11_out), .decision(data_in), .data_out(st12_out), .*);
survivor_path_stage stage_13(.data_in(st12_out), .decision(data_in), .data_out(st13_out), .*);
survivor_path_stage stage_14(.data_in(st13_out), .decision(data_in), .data_out(st14_out), .*);
survivor_path_stage stage_15(.data_in(st14_out), .decision(data_in), .data_out(st15_out), .*);
survivor_path_stage stage_16(.data_in(st15_out), .decision(data_in), .data_out(st16_out), .*);
survivor_path_stage stage_17(.data_in(st16_out), .decision(data_in), .data_out(st17_out), .*);
survivor_path_stage stage_18(.data_in(st17_out), .decision(data_in), .data_out(st18_out), .*);
survivor_path_stage stage_19(.data_in(st18_out), .decision(data_in), .data_out(data_out), .*);

endmodule


