
y
Command: %s
53*	vivadotcl2H
4synth_design -top riscv_soc -part xc7vx485tffg1157-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
	xc7vx485t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
	xc7vx485t2default:defaultZ17-349h px� 
�
%s*synth2�
sStarting Synthesize : Time (s): cpu = 00:00:01 ; elapsed = 00:00:03 . Memory (MB): peak = 564.738 ; gain = 185.594
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
	riscv_soc2default:default2
 2default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/chip/riscv_soc.v2default:default2
82default:default8@Z8-6157h px� 
]
%s
*synth2E
1	Parameter IRAM_DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
b
%s
*synth2J
6	Parameter IRAM_DEPTH bound to: 2048 - type: integer 
2default:defaulth p
x
� 
]
%s
*synth2E
1	Parameter DRAM_DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
b
%s
*synth2J
6	Parameter DRAM_DEPTH bound to: 2048 - type: integer 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys2

riscv_core2default:default2
 2default:default2�
lF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/riscv_core.v2default:default2
82default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
mux22default:default2
 2default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux2.v2default:default2
82default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mux22default:default2
 2default:default2
12default:default2
12default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux2.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
pc2default:default2
 2default:default2z
dF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/pc.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pc2default:default2
 2default:default2
22default:default2
12default:default2z
dF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/pc.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
alu_add2default:default2
 2default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_add.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alu_add2default:default2
 2default:default2
32default:default2
12default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_add.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
if_id2default:default2
 2default:default2}
gF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/if_id.v2default:default2
92default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
dff2default:default2
 2default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dff2default:default2
 2default:default2
42default:default2
12default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
if_id2default:default2
 2default:default2
52default:default2
12default:default2}
gF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/if_id.v2default:default2
92default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	main_ctrl2default:default2
 2default:default2�
kF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/main_ctrl.v2default:default2
112default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	main_ctrl2default:default2
 2default:default2
62default:default2
12default:default2�
kF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/main_ctrl.v2default:default2
112default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2(
mux2__parameterized02default:default2
 2default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux2.v2default:default2
82default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 12 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2(
mux2__parameterized02default:default2
 2default:default2
62default:default2
12default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux2.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
regs2default:default2
 2default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/regs.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
regs2default:default2
 2default:default2
72default:default2
12default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/regs.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
imm_gen2default:default2
 2default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/imm_gen.v2default:default2
112default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
imm_gen2default:default2
 2default:default2
82default:default2
12default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/imm_gen.v2default:default2
112default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
or_gate2default:default2
 2default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/or_gate.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
or_gate2default:default2
 2default:default2
92default:default2
12default:default2
iF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/or_gate.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
id_ex2default:default2
 2default:default2}
gF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/id_ex.v2default:default2
82default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2'
dff__parameterized02default:default2
 2default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6157h px� 
W
%s
*synth2?
+	Parameter DW bound to: 1 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2'
dff__parameterized02default:default2
 2default:default2
92default:default2
12default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2'
dff__parameterized12default:default2
 2default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6157h px� 
W
%s
*synth2?
+	Parameter DW bound to: 3 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2'
dff__parameterized12default:default2
 2default:default2
92default:default2
12default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2'
dff__parameterized22default:default2
 2default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6157h px� 
W
%s
*synth2?
+	Parameter DW bound to: 5 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2'
dff__parameterized22default:default2
 2default:default2
92default:default2
12default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/dff.v2default:default2
82default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
id_ex2default:default2
 2default:default2
102default:default2
12default:default2}
gF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/id_ex.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
mux32default:default2
 2default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux3.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mux32default:default2
 2default:default2
112default:default2
12default:default2|
fF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mux3.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
alu_ex2default:default2
 2default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
112default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alu_ex2default:default2
 2default:default2
122default:default2
12default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
112default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
alu_ctrl2default:default2
 2default:default2�
jF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ctrl.v2default:default2
112default:default8@Z8-6157h px� 
�
default block is never used226*oasys2�
jF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ctrl.v2default:default2
222default:default8@Z8-226h px� 
�
default block is never used226*oasys2�
jF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ctrl.v2default:default2
792default:default8@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alu_ctrl2default:default2
 2default:default2
132default:default2
12default:default2�
jF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ctrl.v2default:default2
112default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
ex_mem2default:default2
 2default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/ex_mem.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ex_mem2default:default2
 2default:default2
142default:default2
12default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/ex_mem.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
mem_wb2default:default2
 2default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mem_wb.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mem_wb2default:default2
 2default:default2
152default:default2
12default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/mem_wb.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2"
jump_ctrl_unit2default:default2
 2default:default2�
pF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/jump_ctrl_unit.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2"
jump_ctrl_unit2default:default2
 2default:default2
162default:default2
12default:default2�
pF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/jump_ctrl_unit.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys24
 Hazard_Detection_Forwarding_unit2default:default2
 2default:default2�
�F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/Hazard_Detection_Forwarding_unit.v2default:default2
82default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys24
 Hazard_Detection_Forwarding_unit2default:default2
 2default:default2
172default:default2
12default:default2�
�F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/Hazard_Detection_Forwarding_unit.v2default:default2
82default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

riscv_core2default:default2
 2default:default2
182default:default2
12default:default2�
lF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/riscv_core.v2default:default2
82default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
iram2default:default2
 2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
92default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter MEM_DEPTH bound to: 2048 - type: integer 
2default:defaulth p
x
� 
�
ignoring %s2898*oasys2+
malformed $readmem task2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
222default:default8@Z8-2898h px� 
�
%s
*synth2�
�
Warning: Trying to implement RAM in registers. Block RAM or DRAM implementation is not possible for one or more of the following reasons :
2default:defaulth p
x
� 
j
%s
*synth2R
>	1: Unable to determine number of words or word size in RAM. 
2default:defaulth p
x
� 
T
%s
*synth2<
(	2: No valid read/write found for RAM. 
2default:defaulth p
x
� 
I
%s
*synth21
RAM dissolved into registers
2default:defaulth p
x
� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
mem2default:default2
iram2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
182default:default8@Z8-3848h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2 
Synth 8-38482default:default2
1002default:defaultZ17-14h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
iram2default:default2
 2default:default2
192default:default2
12default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/iram.v2default:default2
92default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dram2default:default2
 2default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dram.v2default:default2
112default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter MEM_DEPTH bound to: 2048 - type: integer 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys2
dual_ram2default:default2
 2default:default2z
dF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dual_ram.v2default:default2
82default:default8@Z8-6157h px� 
X
%s
*synth2@
,	Parameter DW bound to: 32 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter MEM_DEPTH bound to: 2048 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dual_ram2default:default2
 2default:default2
202default:default2
12default:default2z
dF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dual_ram.v2default:default2
82default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dram2default:default2
 2default:default2
212default:default2
12default:default2v
`F:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/wrap/dram.v2default:default2
112default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	riscv_soc2default:default2
 2default:default2
222default:default2
12default:default2{
eF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/chip/riscv_soc.v2default:default2
82default:default8@Z8-6155h px� 
�
%s*synth2�
sFinished Synthesize : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 643.910 ; gain = 264.766
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
~Finished Constraint Validation : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 643.910 ; gain = 264.766
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Loading part: xc7vx485tffg1157-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:01 ; elapsed = 00:00:04 . Memory (MB): peak = 643.910 ; gain = 264.766
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Y
Loading part %s157*device2&
xc7vx485tffg1157-12default:defaultZ21-403h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
memtoreg2default:defaultZ8-5587h px� 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
regwrite2default:defaultZ8-5546h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
memread2default:defaultZ8-5546h px� 
x
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
memwrite2default:defaultZ8-5546h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
aluop2default:defaultZ8-5587h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2
alusrc2default:defaultZ8-5587h px� 
z
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2

pc_rs1_sel2default:defaultZ8-5546h px� 
�
cNot enough pipeline registers after wide multiplier. Recommended levels of pipeline registers is %s4267*oasys2
42default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
812default:default8@Z8-5845h px� 
�
cNot enough pipeline registers after wide multiplier. Recommended levels of pipeline registers is %s4267*oasys2
42default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
762default:default8@Z8-5845h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:03 ; elapsed = 00:00:06 . Memory (MB): peak = 794.270 ; gain = 415.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
f
%s
*synth2N
:+------+------------------------+------------+----------+
2default:defaulth p
x
� 
f
%s
*synth2N
:|      |RTL Partition           |Replication |Instances |
2default:defaulth p
x
� 
f
%s
*synth2N
:+------+------------------------+------------+----------+
2default:defaulth p
x
� 
f
%s
*synth2N
:|1     |alu_ex__GB0             |           1|     19909|
2default:defaulth p
x
� 
f
%s
*synth2N
:|2     |datapath__25_alu_ex__GD |           1|      4647|
2default:defaulth p
x
� 
f
%s
*synth2N
:|3     |riscv_core__GC0         |           1|      2356|
2default:defaulth p
x
� 
f
%s
*synth2N
:|4     |muxpart__19_iram        |           1|     65504|
2default:defaulth p
x
� 
f
%s
*synth2N
:|5     |dram                    |           1|       767|
2default:defaulth p
x
� 
f
%s
*synth2N
:+------+------------------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     64 Bit       Adders := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 9     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     32 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      6 Bit       Adders := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
+---XORs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit         XORs := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit         XORs := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 11    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 6     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 13    
2default:defaulth p
x
� 
?
%s
*synth2'
+---Multipliers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                32x32  Multipliers := 2     
2default:defaulth p
x
� 
8
%s
*synth2 
+---RAMs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	             1024 Bit         RAMs := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     64 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 31    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   5 Input     32 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     32 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     16 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   5 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 10    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      5 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	  10 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 5     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      2 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 35    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	  10 Input      1 Bit        Muxes := 6     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Y
%s
*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Hierarchical RTL Component report 
2default:defaulth p
x
� 
;
%s
*synth2#
Module alu_ex 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     64 Bit       Adders := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 7     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     32 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      6 Bit       Adders := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
+---XORs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit         XORs := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit         XORs := 1     
2default:defaulth p
x
� 
?
%s
*synth2'
+---Multipliers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                32x32  Multipliers := 2     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     64 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 9     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 2     
2default:defaulth p
x
� 
<
%s
*synth2$
Module mux2__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
7
%s
*synth2
Module pc 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
?
%s
*synth2'
Module alu_add__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__9 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
Module dff 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
>
%s
*synth2&
Module main_ctrl 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	  10 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	  10 Input      1 Bit        Muxes := 6     
2default:defaulth p
x
� 
I
%s
*synth21
Module mux2__parameterized0 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
Module regs 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
8
%s
*synth2 
+---RAMs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	             1024 Bit         RAMs := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
<
%s
*synth2$
Module imm_gen 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__8 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__9 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
L
%s
*synth24
 Module dff__parameterized0__10 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
L
%s
*synth24
 Module dff__parameterized0__11 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized1__2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
H
%s
*synth20
Module dff__parameterized1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
L
%s
*synth24
 Module dff__parameterized0__12 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
H
%s
*synth20
Module dff__parameterized0 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__5 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__6 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__7 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__8 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized2__3 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized2__4 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized2__5 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
H
%s
*synth20
Module dff__parameterized2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
<
%s
*synth2$
Module mux2__2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
<
%s
*synth2$
Module mux3__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
Module mux3 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
<
%s
*synth2$
Module mux2__3 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
<
%s
*synth2$
Module alu_add 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
Module alu_ctrl 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      5 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__3 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__4 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__5 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__6 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized1__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__7 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__3 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__4 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized2__2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized0__2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
;
%s
*synth2#
Module dff__2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
K
%s
*synth23
Module dff__parameterized2__1 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
Module mux2 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
U
%s
*synth2=
)Module Hazard_Detection_Forwarding_unit 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      2 Bit        Muxes := 2     
2default:defaulth p
x
� 
=
%s
*synth2%
Module dual_ram 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
Module dram 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   5 Input     32 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     32 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input     16 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   5 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
[
%s
*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2o
[Part Resources:
DSPs: 2800 (col length:140)
BRAMs: 2060 (col length: RAMB18 140 RAMB36 70)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
]
%s
*synth2E
1Warning: Parallel synthesis criteria is not met 
2default:defaulth p
x
� 
�
cNot enough pipeline registers after wide multiplier. Recommended levels of pipeline registers is %s4267*oasys2
42default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
722default:default8@Z8-5845h px� 
�
cNot enough pipeline registers after wide multiplier. Recommended levels of pipeline registers is %s4267*oasys2
42default:default2~
hF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.srcs/sources_1/imports/riscv_core/alu_ex.v2default:default2
702default:default8@Z8-5845h px� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result0, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result0, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result0, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result0, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result0 is absorbed into DSP ALU_result0.
2default:defaulth p
x
� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result3, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result3, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result3, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result3, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result3, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result3, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
l
%s
*synth2T
@DSP Report: Generating DSP ALU_result3, operation Mode is: A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
w
%s
*synth2_
KDSP Report: Generating DSP ALU_result3, operation Mode is: (PCIN>>17)+A*B.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
o
%s
*synth2W
CDSP Report: operator ALU_result3 is absorbed into DSP ALU_result3.
2default:defaulth p
x
� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2*
u_main_ctrl/pc_rs1_sel2default:defaultZ8-5546h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2&
u_main_ctrl/alusrc2default:defaultZ8-5587h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2%
u_main_ctrl/aluop2default:defaultZ8-5587h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2(
u_main_ctrl/memwrite2default:defaultZ8-5546h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2'
u_main_ctrl/memread2default:defaultZ8-5546h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2(
u_main_ctrl/regwrite2default:defaultZ8-5546h px� 
�
TROM size for "%s" is below threshold of ROM address width. It will be mapped to LUTs4039*oasys2(
u_main_ctrl/memtoreg2default:defaultZ8-5587h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:05 ; elapsed = 00:00:13 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP and Shift Register Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
_
%s*synth2G
3
DSP: Preliminary Mapping  Report (see note below)
2default:defaulth px� 
�
%s*synth2�
+------------+----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
2default:defaulth px� 
�
%s*synth2�
�|Module Name | DSP Mapping    | A Size | B Size | C Size | D Size | P Size | AREG | BREG | CREG | DREG | ADREG | MREG | PREG | 
2default:defaulth px� 
�
%s*synth2�
+------------+----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
2default:defaulth px� 
�
%s*synth2�
�|riscv_soc   | A*B            | 18     | 16     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|riscv_soc   | (PCIN>>17)+A*B | 16     | 16     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|riscv_soc   | A*B            | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|riscv_soc   | (PCIN>>17)+A*B | 18     | 16     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | A*B            | 18     | 16     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | (PCIN>>17)+A*B | 16     | 16     | -      | -      | 30     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | A*B            | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | (PCIN>>17)+A*B | 18     | 16     | -      | -      | 47     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | A*B            | 18     | 16     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | (PCIN>>17)+A*B | 16     | 16     | -      | -      | 30     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | A*B            | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�|alu_ex      | (PCIN>>17)+A*B | 18     | 16     | -      | -      | 47     | 0    | 0    | -    | -    | -     | 0    | 0    | 
2default:defaulth px� 
�
%s*synth2�
�+------------+----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+

2default:defaulth px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the DSPs inferred at the current stage of the synthesis flow. Some DSP may be reimplemented as non DSP primitives later in the synthesis flow. Multiple instantiated DSPs are reported only once.
2default:defaulth px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP and Shift Register Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Timing Optimization : Time (s): cpu = 00:00:05 ; elapsed = 00:00:13 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
{Finished Technology Mapping : Time (s): cpu = 00:00:05 ; elapsed = 00:00:13 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
uFinished IO Insertion : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
=
%s*synth2%
+-+-----+------+
2default:defaulth px� 
=
%s*synth2%
| |Cell |Count |
2default:defaulth px� 
=
%s*synth2%
+-+-----+------+
2default:defaulth px� 
=
%s*synth2%
+-+-----+------+
2default:defaulth px� 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
N
%s
*synth26
"|      |Instance |Module |Cells |
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
N
%s
*synth26
"|1     |top      |       |     0|
2default:defaulth p
x
� 
N
%s
*synth26
"+------+---------+-------+------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
u
%s
*synth2]
ISynthesis finished with 0 errors, 0 critical warnings and 2049 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
~Synthesis Optimization Runtime : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Complete : Time (s): cpu = 00:00:06 ; elapsed = 00:00:14 . Memory (MB): peak = 983.949 ; gain = 604.805
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1069.2382default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
802default:default2
1012default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:072default:default2
00:00:212default:default2
1069.2382default:default2
713.9772default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1069.2382default:default2
0.0002default:defaultZ17-268h px� 
K
"No constraints selected for write.1103*constraintsZ18-5210h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2l
XF:/vivado_project/RISCV_vivado_20250403/RISCV_vivado_20250403.runs/synth_1/riscv_soc.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2|
hExecuting : report_utilization -file riscv_soc_utilization_synth.rpt -pb riscv_soc_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Tue Apr  8 15:06:08 20252default:defaultZ17-206h px� 


End Record