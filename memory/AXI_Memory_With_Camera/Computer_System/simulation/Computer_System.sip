set_global_assignment -entity "Computer_System" -library "lib_Computer_System" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "Computer_System" -library "lib_Computer_System" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "Computer_System" -library "lib_Computer_System" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_Computer_System" -name SPD_FILE [file join $::quartus(sip_path) "../Computer_System.spd"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "../../Computer_System.qsys"]

set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "Computer_System.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_irq_mapper.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_avalon_st_adapter.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_rsp_mux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_arbitrator.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_rsp_demux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_cmd_mux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_cmd_demux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_uncmpr.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_13_1.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_new.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_incr_burst_converter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_wrap_burst_converter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_default_burst_converter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_address_alignment.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_pipeline_stage.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_pipeline_base.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_traffic_limiter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_reorder_memory.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_sc_fifo.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_router_002.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_1_router.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_agent.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_uncompressor.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_axi_master_ni.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_translator.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_width_adapter.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_rsp_mux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_rsp_demux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_cmd_mux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_cmd_demux.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_router_002.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_mm_interconnect_0_router.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_fifo_FPGA_to_HPS.sdc"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_fifo_FPGA_to_HPS.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_System_PLL.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_avalon_reset_from_locked_signal.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_System_PLL_sys_pll.vo"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_Onchip_SRAM.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS_hps_io.v"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/verbosity_pkg.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_utilities_pkg.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_mm_pkg.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_mm_slave_bfm.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_interrupt_sink.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_clock_source.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_reset_source.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS_hps_io_border_memory.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS_hps_io_border_hps_io.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS_hps_io_border.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/questa_mvc_svapi.svh"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_common_axi.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_axi_master.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_axi_slave.sv"]
set_global_assignment -library "lib_Computer_System" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Computer_System_ARM_A9_HPS_fpga_interfaces.sv"]
