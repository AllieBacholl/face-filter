vlib work                      ;# Create a working library
vlog ../sources_1/imports/chip/*.v                ;# Compile DUT files
vlog ../sources_1/imports/riscv_core/*.v                ;# Compile DUT files
vlog ../sources_1/imports/wrap/*.v                ;# Compile DUT files
vlog ../sim_1/imports/tb/*.sv          ;# Compile Testbench files
vsim -voptargs=+acc riscv_soc_tb     ;# Simulate starting from Testbench top module
add wave -position insertpoint sim:/riscv_soc_tb/u_riscv_soc/*
run -all
