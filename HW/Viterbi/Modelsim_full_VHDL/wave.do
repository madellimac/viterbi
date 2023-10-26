onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/rst
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/clk
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/enable
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/comp_1
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/comp_2
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/BE_Nb
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/FE_Nb
add wave -noupdate -radix unsigned /tb_top_level/uut/error_count/Bit_Nb
add wave -noupdate -divider BMU
add wave -noupdate /tb_top_level/uut/dec/BMU/rst
add wave -noupdate /tb_top_level/uut/dec/BMU/clk
add wave -noupdate /tb_top_level/uut/dec/BMU/enable
add wave -noupdate /tb_top_level/uut/dec/BMU/y1
add wave -noupdate /tb_top_level/uut/dec/BMU/y2
add wave -noupdate /tb_top_level/uut/dec/BMU/MB00
add wave -noupdate /tb_top_level/uut/dec/BMU/MB01
add wave -noupdate /tb_top_level/uut/dec/BMU/MB10
add wave -noupdate /tb_top_level/uut/dec/BMU/MB11
add wave -noupdate /tb_top_level/uut/dec/BMU/ROM_MB00
add wave -noupdate /tb_top_level/uut/dec/BMU/ROM_MB01
add wave -noupdate /tb_top_level/uut/dec/BMU/ROM_MB10
add wave -noupdate /tb_top_level/uut/dec/BMU/ROM_MB11
add wave -noupdate /tb_top_level/uut/dec/BMU/address
add wave -noupdate /tb_top_level/uut/dec/BMU/rMB00
add wave -noupdate /tb_top_level/uut/dec/BMU/rMB01
add wave -noupdate /tb_top_level/uut/dec/BMU/rMB10
add wave -noupdate /tb_top_level/uut/dec/BMU/rMB11
add wave -noupdate -divider ACS0
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/rst
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/clk
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/enable
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MB_0
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MB_1
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MN_0
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MN_1
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MN_out
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/decision
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MN_0_new
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/MN_1_new
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/ACS0/next_MN
add wave -noupdate -divider SMU
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/rst
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/clk
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/enable
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/branch_metric
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/decision
add wave -noupdate -radix unsigned -childformat {{/tb_top_level/uut/dec/SMU/state_metric_tmp(0) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(1) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(2) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(3) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(4) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(5) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(6) -radix unsigned} {/tb_top_level/uut/dec/SMU/state_metric_tmp(7) -radix unsigned}} -expand -subitemconfig {/tb_top_level/uut/dec/SMU/state_metric_tmp(0) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(1) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(2) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(3) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(4) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(5) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(6) {-height 16 -radix unsigned} /tb_top_level/uut/dec/SMU/state_metric_tmp(7) {-height 16 -radix unsigned}} /tb_top_level/uut/dec/SMU/state_metric_tmp
add wave -noupdate -radix unsigned /tb_top_level/uut/dec/SMU/state_metric_loopback
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {210000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
WaveRestoreZoom {1050988 ps} {1208580 ps}
