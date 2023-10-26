project compileall
vsim -gui -novopt work.tb_top_level -t ps
restart
do wave.do
run 500 ns
