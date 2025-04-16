set_global_assignment -entity "regFile" -library "lib_regFile" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "regFile" -library "lib_regFile" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "regFile" -library "lib_regFile" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_regFile" -name SPD_FILE [file join $::quartus(sip_path) "../regFile.spd"]
set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "../../regFile.qsys"]

set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "regFile.v"]
set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_regFile" -name MISC_FILE [file join $::quartus(sip_path) "submodules/regFile_onchip_regFile.v"]
