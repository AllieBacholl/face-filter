# 文件名：batch_run.tcl
# 功能：批量仿真 RISC-V 指令，分别处理 rv32ui 与 rv32um 测试集

# rv32ui 指令测试列表
# 说明：Load型指令测试文件中ram有初始值无法用原测试文件验证，但实际Store型指令测试文件中已经包含了对Load型指令的验证
set ui_test_list {
					"add" "sub" "sll" "slt" "sltu" "xor" "srl" "sra" "or" "and" "lui" "auipc" "jal" 
					"jalr" "beq" "bne" "blt" "bge" "bltu" "bgeu" "sb"
					"sh" "sw" "addi" "slti" "sltiu" "xori" "ori" "andi" "slli" "srli" "srai"
				}

# rv32um 指令测试列表
set um_test_list {"div" "divu" "mul" "mulh" "mulhsu" "mulhu" "rem" "remu"}

# 日志目录
set log_dir "F:\\vivado_project\\riscv\\sim_logs"
file mkdir $log_dir

# 仿真函数
proc run_test {test_name prefix log_dir} {
    puts "\n========== Running test: $test_name =========="

    # 关闭上一次仿真
    catch { close_sim -quiet }

    # 构造文件名并设置 Verilog 宏
    set instr_file "${prefix}-$test_name.txt"
    set_property verilog_define "INSTR_FILE=\"$instr_file\"" [get_filesets sim_1]

    # 启动仿真
    launch_simulation
    # 执行仿真直到结束 （vivado启动仿真默认仿真1000ns，所有测试中最长测试时间为10150ns）
    run 10000ns

    # 可选波形输出
    # log_wave -recursive *
    # write_waveform "$log_dir/sim_${test_name}.wdb"
}

# 执行 rv32ui 测试集
foreach test_name $ui_test_list {
    run_test $test_name "rv32ui-p" $log_dir
}


# 执行 rv32um 测试集
foreach test_name $um_test_list {
    run_test $test_name "rv32um-p" $log_dir
}

puts "\nAll simulations completed!"

