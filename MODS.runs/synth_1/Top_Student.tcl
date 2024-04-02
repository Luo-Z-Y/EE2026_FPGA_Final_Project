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
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.xpr} [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/imports/res/weights.coe}}
add_files {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/imports/res/00.coe}}
read_verilog -library xil_defaultlib {
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/CanvasTransfer.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/imports/Desktop/Oled_Display.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/module_pack.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/neural_net.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/paint.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/ss_display.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/the_flexible_module.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/Top_Student.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/counter.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/reach200ms.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/counter_a.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/vga_test.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/vga_sync.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/ascii_test.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/ascii_rom.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/board_animation.v}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/new/cursor_animation.v}
}
read_vhdl -library xil_defaultlib {
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/imports/Desktop/Mouse_Control.vhd}
  {C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/imports/Desktop/Ps2Interface.vhd}
}
read_ip -quiet {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_inter/blk_mem_gen_inter.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_inter/blk_mem_gen_inter_ooc.xdc}}]

read_ip -quiet {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_0_1/blk_mem_gen_0_ooc.xdc}}]

read_ip -quiet {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_img/blk_mem_gen_img.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_img/blk_mem_gen_img_ooc.xdc}}]

read_ip -quiet {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_const/blk_mem_gen_const.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/sources_1/ip/blk_mem_gen_const/blk_mem_gen_const_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/constrs_1/new/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Luo Zhiyang/OneDrive - National University of Singapore/Y2S2/EE2026/EE2026 Project/MODS_Final_Project.xpr/MODS/EE2026_FPGA_Final_Project/MODS.srcs/constrs_1/new/Basys3_Master.xdc}}]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top Top_Student -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Top_Student.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Top_Student_utilization_synth.rpt -pb Top_Student_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
