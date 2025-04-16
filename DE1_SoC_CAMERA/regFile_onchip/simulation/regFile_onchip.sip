set_global_assignment -entity "regFile_onchip" -library "lib_regFile_onchip" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "regFile_onchip" -library "lib_regFile_onchip" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "regFile_onchip" -library "lib_regFile_onchip" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_regFile_onchip" -name SPD_FILE [file join $::quartus(sip_path) "../regFile_onchip.spd"]
set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "../../regFile_onchip.qsys"]

set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "regFile_onchip.v"]
set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_regFile_onchip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/regFile_onchip_onchip_regFile.v"]
