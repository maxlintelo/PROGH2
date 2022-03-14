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
set_param synth.incrementalSynthesisCache C:/Users/Max/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-5028-DESKTOP-5PCB5FN/incrSyn
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
read_vhdl -library eindopdracht C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/hdl/microblaze_wrapper.vhd
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
set_property used_in_implementation false [get_files -all C:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/microblaze_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Development/PROGH2/eindopdracht/eindopdracht.srcs/sources_1/bd/microblaze/ip/microblaze_microblaze_0_2/data/mb_bootloop_le.elf]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top microblaze_wrapper -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef microblaze_wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file microblaze_wrapper_utilization_synth.rpt -pb microblaze_wrapper_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
