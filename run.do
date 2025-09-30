vlog list.svh
#vopt work.top +cover=fcbest -o N_writes_N_reads
#vsim -suppress 12110 -assertdebug -coverage N_writes_N_reads +testcase=CONSECUTIVE_WRITES_READS +N=3 -sv_seed 657483920 -l transcript.log
vsim top -assertdebug -novopt -suppress 12110 +testcase=N_writes_N_reads +N=4 +num_agents=5 -sv_seed 657483920 -l transcript.log

coverage save -onexit N_writes_N_reads.ucdb
#add wave -r sim:/dut/*
do exclude.do
do wave.do
add wave sim:/top/mem_assert/HARDSHAKE_PR WDATA_PR RDATA_PR ADDR_PR
run -all

