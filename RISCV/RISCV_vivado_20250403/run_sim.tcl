close_sim -quiet

set instr_file "rv32ui-p-add.txt"
set_property verilog_define "INSTR_FILE=\"$instr_file\"" [get_filesets sim_1]
launch_simulation
run 10000ns

