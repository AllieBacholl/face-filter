set_global_assignment -entity "clk_gen" -library "lib_clk_gen" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_gen" -library "lib_clk_gen" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "clk_gen" -library "lib_clk_gen" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_gen" -name SPD_FILE [file join $::quartus(sip_path) "clk_gen.spd"]

set_global_assignment -library "lib_clk_gen" -name MISC_FILE [file join $::quartus(sip_path) "clk_gen_sim/clk_gen.vo"]
