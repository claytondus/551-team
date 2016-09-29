# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a100tcsg324-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/jdavi194/Documents/551/Lab1/Lab1.cache/wt [current_project]
set_property parent.project_path C:/Users/jdavi194/Documents/551/Lab1/Lab1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib C:/Users/jdavi194/Documents/551/Lab1/Lab1.srcs/sources_1/new/ALU.vhd
read_xdc C:/Users/jdavi194/Downloads/Nexys4_Master.xdc
set_property used_in_implementation false [get_files C:/Users/jdavi194/Downloads/Nexys4_Master.xdc]

catch { write_hwdef -file ALU.hwdef }
synth_design -top ALU -part xc7a100tcsg324-1
write_checkpoint -noxdef ALU.dcp
catch { report_utilization -file ALU_utilization_synth.rpt -pb ALU_utilization_synth.pb }