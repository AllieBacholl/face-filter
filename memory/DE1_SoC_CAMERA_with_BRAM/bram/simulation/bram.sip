set_global_assignment -entity "bram" -library "lib_bram" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "bram" -library "lib_bram" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "bram" -library "lib_bram" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_bram" -name SPD_FILE [file join $::quartus(sip_path) "../bram.spd"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "../../bram.qsys"]

set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "bram.v"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/bram_onchip_memory2_1.v"]
set_global_assignment -library "lib_bram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/bram_onchip_memory2_0.v"]
