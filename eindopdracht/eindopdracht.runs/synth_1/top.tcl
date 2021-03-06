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
set_param chipscope.maxJobs 3
set_param synth.incrementalSynthesisCache C:/Users/Max/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-6868-DESKTOP-5PCB5FN/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Development/PROGH2/eindopdracht/eindopdracht.cache/wt [current_project]
set_property parent.project_path C:/Development/PROGH2/eindopdracht/eindopdracht.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib eindopdracht [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_output_repo c:/Development/PROGH2/eindopdracht/eindopdracht.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Development/PROGH2/eindopdracht/notenbalk.coe
add_files C:/Development/PROGH2/eindopdracht/noot.coe
add_files C:/Development/PROGH2/eindopdracht/sharp.coe
add_files C:/Development/PROGH2/eindopdracht/flat.coe
read_vhdl -library eindopdracht {
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/constants.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/hdl/microblaze_wrapper.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/ps2_keyboard.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/pwm_sound.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/seven_segment_display.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/vga_controller.vhd
  C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/new/top.vhd
}
add_files C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/microblaze.bd
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_0_0/microblaze_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_0_0/microblaze_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_0_0/microblaze_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_clk_wiz_0_0/microblaze_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_clk_wiz_0_0/microblaze_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_clk_wiz_0_0/microblaze_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_uartlite_0_0/microblaze_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_uartlite_0_0/microblaze_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_uartlite_0_0/microblaze_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_microblaze_0_2/microblaze_microblaze_0_2.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_microblaze_0_2/microblaze_microblaze_0_2_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_microblaze_0_2/microblaze_microblaze_0_2_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_dlmb_v10_1/microblaze_dlmb_v10_1.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_dlmb_v10_1/microblaze_dlmb_v10_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_ilmb_v10_1/microblaze_ilmb_v10_1.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_ilmb_v10_1/microblaze_ilmb_v10_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_dlmb_bram_if_cntlr_1/microblaze_dlmb_bram_if_cntlr_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_ilmb_bram_if_cntlr_1/microblaze_ilmb_bram_if_cntlr_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_lmb_bram_1/microblaze_lmb_bram_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_mdm_1_1/microblaze_mdm_1_1.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_mdm_1_1/microblaze_mdm_1_1_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_rst_clk_wiz_0_100M_1/microblaze_rst_clk_wiz_0_100M_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_rst_clk_wiz_0_100M_1/microblaze_rst_clk_wiz_0_100M_1.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_rst_clk_wiz_0_100M_1/microblaze_rst_clk_wiz_0_100M_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_xbar_1/microblaze_xbar_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_1_1/microblaze_axi_gpio_1_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_1_1/microblaze_axi_gpio_1_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_1_1/microblaze_axi_gpio_1_1.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_2_0/microblaze_axi_gpio_2_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_2_0/microblaze_axi_gpio_2_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_axi_gpio_2_0/microblaze_axi_gpio_2_0.xdc]
set_property used_in_implementation false [get_files -all C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/microblaze_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_microblaze_0_2/data/mb_bootloop_le.elf]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_sound/clk_wiz_sound.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_sound/clk_wiz_sound_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_sound/clk_wiz_sound.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_sound/clk_wiz_sound_ooc.xdc]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_vga/clk_wiz_vga.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_vga/clk_wiz_vga_board.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_vga/clk_wiz_vga.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/clk_wiz_vga/clk_wiz_vga_ooc.xdc]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_notenbalk/blk_mem_notenbalk.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_notenbalk/blk_mem_notenbalk_ooc.xdc]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_noot/blk_mem_noot.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_noot/blk_mem_noot_ooc.xdc]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_flat/blk_mem_flat.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_flat/blk_mem_flat_ooc.xdc]

read_ip -quiet C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_sharp/blk_mem_sharp.xci
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/ip/blk_mem_sharp/blk_mem_sharp_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/constrs_1/new/constr_manual.xdc
set_property used_in_implementation false [get_files C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/constrs_1/new/constr_manual.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
