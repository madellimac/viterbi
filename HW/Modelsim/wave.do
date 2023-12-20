onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top_level/uut/error_count/enable
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/BE_Nb
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/Bit_Nb
add wave -noupdate /tb_top_level/uut/error_count/comp_1
add wave -noupdate /tb_top_level/uut/error_count/comp_2
add wave -noupdate -divider BMU
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/y1
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/y2
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/MB00
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/MB01
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/MB10
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/BMU/MB11
add wave -noupdate -divider SMU
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[7]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[6]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[5]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[4]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[3]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[2]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[1]}
add wave -noupdate -radix unsigned {/tb_top_level/uut/dec/SMU/state_metric_tmp[0]}
add wave -noupdate -divider ACS0
add wave -noupdate /tb_top_level/uut/dec/SMU/acs0/rst
add wave -noupdate /tb_top_level/uut/dec/SMU/acs0/clk
add wave -noupdate /tb_top_level/uut/dec/SMU/acs0/enable
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MB0
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MN0
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MB1
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MN1
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/decision
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MN_0_new
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/acs0/MN_1_new
add wave -noupdate -divider survivor
add wave -noupdate /tb_top_level/uut/dec/survivor_path_unit_0/rst
add wave -noupdate /tb_top_level/uut/dec/survivor_path_unit_0/clk
add wave -noupdate /tb_top_level/uut/dec/survivor_path_unit_0/enable
add wave -noupdate /tb_top_level/uut/dec/survivor_path_unit_0/data_in
add wave -noupdate /tb_top_level/uut/dec/survivor_path_unit_0/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {336559 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {824416 ps}
