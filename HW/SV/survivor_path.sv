`timescale 1ns / 1ps

module survivor_path
    (input  logic         rst,
     input  logic         clk,
     input  logic         enable,
     input  logic [0:15] data_in,
     input  logic [0:15] rank,
     output logic [0:15] data_out);

logic [0:7] st0_l0_out, st0_l1_out,
            st1_l0_out, st1_l1_out,
            st2_l0_out, st2_l1_out,
            st3_l0_out, st3_l1_out,
            st4_l0_out, st4_l1_out,
            st5_l0_out, st5_l1_out,
            st6_l0_out, st6_l1_out,
            st7_l0_out, st7_l1_out,
            st8_l0_out, st8_l1_out,
            st9_l0_out, st9_l1_out,
            st10_l0_out, st10_l1_out,
            st11_l0_out, st11_l1_out,
            st12_l0_out, st12_l1_out,
            st13_l0_out, st13_l1_out,
            st14_l0_out, st14_l1_out,
            st15_l0_out, st15_l1_out,
            st16_l0_out, st16_l1_out,
            st17_l0_out, st17_l1_out,
            st18_l0_out, st18_l1_out,
            st19_l0_out, st19_l1_out;
            
logic [0:7] lss_0_l0_out, lss_0_l1_out,
            lss_1_l0_out, lss_1_l1_out,        
            lss_2_l0_out, lss_2_l1_out,        
            lss_3_l0_out, lss_3_l1_out,        
            lss_4_l0_out, lss_4_l1_out,        
            lss_5_l0_out, lss_5_l1_out,        
            lss_6_l0_out, lss_6_l1_out,        
            lss_7_l0_out, lss_7_l1_out,        
            lss_8_l0_out, lss_8_l1_out,        
            lss_9_l0_out, lss_9_l1_out,        
            lss_10_l0_out, lss_10_l1_out,        
            lss_11_l0_out, lss_11_l1_out,        
            lss_12_l0_out, lss_12_l1_out,        
            lss_13_l0_out, lss_13_l1_out,        
            lss_14_l0_out, lss_14_l1_out,        
            lss_15_l0_out, lss_15_l1_out,        
            lss_16_l0_out, lss_16_l1_out,        
            lss_17_l0_out, lss_17_l1_out,        
            lss_18_l0_out, lss_18_l1_out,
            lss_19_l0_out, lss_19_l1_out;        
            

survivor_path_stage stage_0_l0(.data_in(data_in[0:7 ]),   .decision(data_in[0:7 ]), .data_out(st0_l0_out), .*);
survivor_path_stage stage_0_l1(.data_in(data_in[8:15]),   .decision(data_in[8:15]), .data_out(st0_l1_out), .*);
list_selection_stage lss_0 (.i_data_list_0(st0_l0_out), .i_data_list_1(st0_l1_out), .i_rank(rank), .o_data_list_0(lss_0_l0_out), .o_data_list_1(lss_0_l1_out) );

survivor_path_stage stage_1_l0(.data_in(lss_0_l0_out),   .decision(data_in[0:7 ]), .data_out(st1_l0_out), .*);
survivor_path_stage stage_1_l1(.data_in(lss_0_l1_out),   .decision(data_in[8:15]), .data_out(st1_l1_out), .*);
list_selection_stage lss_1 (.i_data_list_0(st1_l0_out), .i_data_list_1(st1_l1_out), .i_rank(rank), .o_data_list_0(lss_1_l0_out), .o_data_list_1(lss_1_l1_out) );

survivor_path_stage stage_2_l0(.data_in(lss_1_l0_out),   .decision(data_in[0:7 ]), .data_out(st2_l0_out), .*);
survivor_path_stage stage_2_l1(.data_in(lss_1_l1_out),   .decision(data_in[8:15]), .data_out(st2_l1_out), .*);
list_selection_stage lss_2 (.i_data_list_0(st2_l0_out), .i_data_list_1(st2_l1_out), .i_rank(rank), .o_data_list_0(lss_2_l0_out), .o_data_list_1(lss_2_l1_out) );

survivor_path_stage stage_3_l0(.data_in(lss_2_l0_out),   .decision(data_in[0:7 ]), .data_out(st3_l0_out), .*);
survivor_path_stage stage_3_l1(.data_in(lss_2_l1_out),   .decision(data_in[8:15]), .data_out(st3_l1_out), .*);
list_selection_stage lss_3 (.i_data_list_0(st3_l0_out), .i_data_list_1(st3_l1_out), .i_rank(rank), .o_data_list_0(lss_3_l0_out), .o_data_list_1(lss_3_l1_out) );

survivor_path_stage stage_4_l0(.data_in(lss_3_l0_out),   .decision(data_in[0:7 ]), .data_out(st4_l0_out), .*);
survivor_path_stage stage_4_l1(.data_in(lss_3_l1_out),   .decision(data_in[8:15]), .data_out(st4_l1_out), .*);
list_selection_stage lss_4 (.i_data_list_0(st4_l0_out), .i_data_list_1(st4_l1_out), .i_rank(rank), .o_data_list_0(lss_4_l0_out), .o_data_list_1(lss_4_l1_out) );

survivor_path_stage stage_5_l0(.data_in(lss_4_l0_out),   .decision(data_in[0:7 ]), .data_out(st5_l0_out), .*);
survivor_path_stage stage_5_l1(.data_in(lss_4_l1_out),   .decision(data_in[8:15]), .data_out(st5_l1_out), .*);
list_selection_stage lss_5 (.i_data_list_0(st5_l0_out), .i_data_list_1(st5_l1_out), .i_rank(rank), .o_data_list_0(lss_5_l0_out), .o_data_list_1(lss_5_l1_out) );

survivor_path_stage stage_6_l0(.data_in(lss_5_l0_out),   .decision(data_in[0:7 ]), .data_out(st6_l0_out), .*);
survivor_path_stage stage_6_l1(.data_in(lss_5_l1_out),   .decision(data_in[8:15]), .data_out(st6_l1_out), .*);
list_selection_stage lss_6 (.i_data_list_0(st6_l0_out), .i_data_list_1(st6_l1_out), .i_rank(rank), .o_data_list_0(lss_6_l0_out), .o_data_list_1(lss_6_l1_out) );

survivor_path_stage stage_7_l0(.data_in(lss_6_l0_out),   .decision(data_in[0:7 ]), .data_out(st7_l0_out), .*);
survivor_path_stage stage_7_l1(.data_in(lss_6_l1_out),   .decision(data_in[8:15]), .data_out(st7_l1_out), .*);
list_selection_stage lss_7 (.i_data_list_0(st7_l0_out), .i_data_list_1(st7_l1_out), .i_rank(rank), .o_data_list_0(lss_7_l0_out), .o_data_list_1(lss_7_l1_out) );

survivor_path_stage stage_8_l0(.data_in(lss_7_l0_out),   .decision(data_in[0:7 ]), .data_out(st8_l0_out), .*);
survivor_path_stage stage_8_l1(.data_in(lss_7_l1_out),   .decision(data_in[8:15]), .data_out(st8_l1_out), .*);
list_selection_stage lss_8 (.i_data_list_0(st8_l0_out), .i_data_list_1(st8_l1_out), .i_rank(rank), .o_data_list_0(lss_8_l0_out), .o_data_list_1(lss_8_l1_out) );

survivor_path_stage stage_9_l0(.data_in(lss_8_l0_out),   .decision(data_in[0:7 ]), .data_out(st9_l0_out), .*);
survivor_path_stage stage_9_l1(.data_in(lss_8_l1_out),   .decision(data_in[8:15]), .data_out(st9_l1_out), .*);
list_selection_stage lss_9 (.i_data_list_0(st9_l0_out), .i_data_list_1(st9_l1_out), .i_rank(rank), .o_data_list_0(lss_9_l0_out), .o_data_list_1(lss_9_l1_out) );

survivor_path_stage stage_10_l0(.data_in(lss_9_l0_out),   .decision(data_in[0:7 ]), .data_out(st10_l0_out), .*);
survivor_path_stage stage_10_l1(.data_in(lss_9_l1_out),   .decision(data_in[8:15]), .data_out(st10_l1_out), .*);
list_selection_stage lss_10 (.i_data_list_0(st10_l0_out), .i_data_list_1(st10_l1_out), .i_rank(rank), .o_data_list_0(lss_10_l0_out), .o_data_list_1(lss_10_l1_out) );
    
survivor_path_stage stage_11_l0(.data_in(lss_10_l0_out),   .decision(data_in[0:7 ]), .data_out(st11_l0_out), .*);
survivor_path_stage stage_11_l1(.data_in(lss_10_l1_out),   .decision(data_in[8:15]), .data_out(st11_l1_out), .*);
list_selection_stage lss_11 (.i_data_list_0(st11_l0_out), .i_data_list_1(st11_l1_out), .i_rank(rank), .o_data_list_0(lss_11_l0_out), .o_data_list_1(lss_11_l1_out) );

survivor_path_stage stage_12_l0(.data_in(lss_11_l0_out),   .decision(data_in[0:7 ]), .data_out(st12_l0_out), .*);
survivor_path_stage stage_12_l1(.data_in(lss_11_l1_out),   .decision(data_in[8:15]), .data_out(st12_l1_out), .*);
list_selection_stage lss_12 (.i_data_list_0(st12_l0_out), .i_data_list_1(st12_l1_out), .i_rank(rank), .o_data_list_0(lss_12_l0_out), .o_data_list_1(lss_12_l1_out) );

survivor_path_stage stage_13_l0(.data_in(lss_12_l0_out),   .decision(data_in[0:7 ]), .data_out(st13_l0_out), .*);
survivor_path_stage stage_13_l1(.data_in(lss_12_l1_out),   .decision(data_in[8:15]), .data_out(st13_l1_out), .*);
list_selection_stage lss_13 (.i_data_list_0(st13_l0_out), .i_data_list_1(st13_l1_out), .i_rank(rank), .o_data_list_0(lss_13_l0_out), .o_data_list_1(lss_13_l1_out) );

survivor_path_stage stage_14_l0(.data_in(lss_13_l0_out),   .decision(data_in[0:7 ]), .data_out(st14_l0_out), .*);
survivor_path_stage stage_14_l1(.data_in(lss_13_l1_out),   .decision(data_in[8:15]), .data_out(st14_l1_out), .*);
list_selection_stage lss_14 (.i_data_list_0(st14_l0_out), .i_data_list_1(st14_l1_out), .i_rank(rank), .o_data_list_0(lss_14_l0_out), .o_data_list_1(lss_14_l1_out) );

survivor_path_stage stage_15_l0(.data_in(lss_14_l0_out),   .decision(data_in[0:7 ]), .data_out(st15_l0_out), .*);
survivor_path_stage stage_15_l1(.data_in(lss_14_l1_out),   .decision(data_in[8:15]), .data_out(st15_l1_out), .*);
list_selection_stage lss_15 (.i_data_list_0(st15_l0_out), .i_data_list_1(st15_l1_out), .i_rank(rank), .o_data_list_0(lss_15_l0_out), .o_data_list_1(lss_15_l1_out) );

survivor_path_stage stage_16_l0(.data_in(lss_15_l0_out),   .decision(data_in[0:7 ]), .data_out(st16_l0_out), .*);
survivor_path_stage stage_16_l1(.data_in(lss_15_l1_out),   .decision(data_in[8:15]), .data_out(st16_l1_out), .*);
list_selection_stage lss_16 (.i_data_list_0(st16_l0_out), .i_data_list_1(st16_l1_out), .i_rank(rank), .o_data_list_0(lss_16_l0_out), .o_data_list_1(lss_16_l1_out) );

survivor_path_stage stage_17_l0(.data_in(lss_16_l0_out),   .decision(data_in[0:7 ]), .data_out(st17_l0_out), .*);
survivor_path_stage stage_17_l1(.data_in(lss_16_l1_out),   .decision(data_in[8:15]), .data_out(st17_l1_out), .*);
list_selection_stage lss_17 (.i_data_list_0(st17_l0_out), .i_data_list_1(st17_l1_out), .i_rank(rank), .o_data_list_0(lss_17_l0_out), .o_data_list_1(lss_17_l1_out) );

survivor_path_stage stage_18_l0(.data_in(lss_17_l0_out),   .decision(data_in[0:7 ]), .data_out(st18_l0_out), .*);
survivor_path_stage stage_18_l1(.data_in(lss_17_l1_out),   .decision(data_in[8:15]), .data_out(st18_l1_out), .*);
list_selection_stage lss_18 (.i_data_list_0(st18_l0_out), .i_data_list_1(st18_l1_out), .i_rank(rank), .o_data_list_0(lss_18_l0_out), .o_data_list_1(lss_18_l1_out) );

survivor_path_stage stage_19_l0(.data_in(lss_18_l0_out),   .decision(data_in[0:7 ]), .data_out(st19_l0_out), .*);
survivor_path_stage stage_19_l1(.data_in(lss_18_l1_out),   .decision(data_in[8:15]), .data_out(st19_l1_out), .*);
list_selection_stage lss_19 (.i_data_list_0(st19_l0_out), .i_data_list_1(st19_l1_out), .i_rank(rank), .o_data_list_0(lss_19_l0_out), .o_data_list_1(lss_19_l1_out) );

assign data_out[0:7 ] = lss_19_l0_out;
assign data_out[8:15] = lss_19_l1_out;

endmodule

