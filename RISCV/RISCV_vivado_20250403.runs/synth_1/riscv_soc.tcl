# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 4
set_param synth.incrementalSynthesisCache C:/Users/Lenovo/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-12232-DESKTOP-H4FIGOR/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7vx485tffg1157-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.cache/wt [current_project]
set_property parent.project_path F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo f:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/Hazard_Detection_Forwarding_unit.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_add.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/defines.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ctrl.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dram.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dual_ram.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/ex_mem.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/id_ex.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/if_id.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/imm_gen.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/jump_ctrl_unit.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/main_ctrl.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mem_wb.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux2.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux3.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/or_gate.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/pc.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/regs.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/riscv_core.v
  F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/chip/riscv_soc.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top riscv_soc -part xc7vx485tffg1157-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef riscv_soc.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file riscv_soc_utilization_synth.rpt -pb riscv_soc_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
