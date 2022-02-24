# 
# Report generation script generated by Vivado
# 

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
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param chipscope.maxJobs 3
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.cache/wt [current_project]
  set_property parent.project_path C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.xpr [current_project]
  set_property ip_output_repo C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.runs/synth_1/adder16bit2bitfa.dcp
  read_xdc C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.srcs/constrs_1/imports/constraints/adder16bit2bitfa.xdc
  read_xdc C:/Users/lenna/Documents/Github/PROGH2/Week_3_Deel_2/Week_3_Deel_2.srcs/constrs_1/imports/constraints/io.xdc
  link_design -top adder16bit2bitfa -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force adder16bit2bitfa_opt.dcp
  create_report "impl_1_opt_report_drc_0" "report_drc -file adder16bit2bitfa_drc_opted.rpt -pb adder16bit2bitfa_drc_opted.pb -rpx adder16bit2bitfa_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  if { [llength [get_debug_cores -quiet] ] > 0 }  { 
    implement_debug_core 
  } 
  place_design 
  write_checkpoint -force adder16bit2bitfa_placed.dcp
  create_report "impl_1_place_report_io_0" "report_io -file adder16bit2bitfa_io_placed.rpt"
  create_report "impl_1_place_report_utilization_0" "report_utilization -file adder16bit2bitfa_utilization_placed.rpt -pb adder16bit2bitfa_utilization_placed.pb"
  create_report "impl_1_place_report_control_sets_0" "report_control_sets -verbose -file adder16bit2bitfa_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

  set_msg_config -source 4 -id {Route 35-39} -severity "critical warning" -new_severity warning
start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force adder16bit2bitfa_routed.dcp
  create_report "impl_1_route_report_drc_0" "report_drc -file adder16bit2bitfa_drc_routed.rpt -pb adder16bit2bitfa_drc_routed.pb -rpx adder16bit2bitfa_drc_routed.rpx"
  create_report "impl_1_route_report_methodology_0" "report_methodology -file adder16bit2bitfa_methodology_drc_routed.rpt -pb adder16bit2bitfa_methodology_drc_routed.pb -rpx adder16bit2bitfa_methodology_drc_routed.rpx"
  create_report "impl_1_route_report_power_0" "report_power -file adder16bit2bitfa_power_routed.rpt -pb adder16bit2bitfa_power_summary_routed.pb -rpx adder16bit2bitfa_power_routed.rpx"
  create_report "impl_1_route_report_route_status_0" "report_route_status -file adder16bit2bitfa_route_status.rpt -pb adder16bit2bitfa_route_status.pb"
  create_report "impl_1_route_report_timing_summary_0" "report_timing_summary -max_paths 10 -file adder16bit2bitfa_timing_summary_routed.rpt -pb adder16bit2bitfa_timing_summary_routed.pb -rpx adder16bit2bitfa_timing_summary_routed.rpx"
  create_report "impl_1_route_report_incremental_reuse_0" "report_incremental_reuse -file adder16bit2bitfa_incremental_reuse_routed.rpt"
  create_report "impl_1_route_report_clock_utilization_0" "report_clock_utilization -file adder16bit2bitfa_clock_utilization_routed.rpt"
  create_report "impl_1_route_report_bus_skew_0" "report_bus_skew -warn_on_violation -file adder16bit2bitfa_bus_skew_routed.rpt -pb adder16bit2bitfa_bus_skew_routed.pb -rpx adder16bit2bitfa_bus_skew_routed.rpx"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force adder16bit2bitfa_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step post_route_phys_opt_design
set ACTIVE_STEP post_route_phys_opt_design
set rc [catch {
  set tool_flow [get_property -quiet TOOL_FLOW [current_project -quiet]]
  if {$tool_flow eq {SDx}} {send_msg_id {101-1} {status} {Starting optional post-route physical design optimization.} }
  create_msg_db post_route_phys_opt_design.pb
  phys_opt_design 
  write_checkpoint -force adder16bit2bitfa_postroute_physopt.dcp
  create_report "impl_1_post_route_phys_opt_report_timing_summary_0" "report_timing_summary -max_paths 10 -warn_on_violation -file adder16bit2bitfa_timing_summary_postroute_physopted.rpt -pb adder16bit2bitfa_timing_summary_postroute_physopted.pb -rpx adder16bit2bitfa_timing_summary_postroute_physopted.rpx"
  create_report "impl_1_post_route_phys_opt_report_bus_skew_0" "report_bus_skew -warn_on_violation -file adder16bit2bitfa_bus_skew_postroute_physopted.rpt -pb adder16bit2bitfa_bus_skew_postroute_physopted.pb -rpx adder16bit2bitfa_bus_skew_postroute_physopted.rpx"
  close_msg_db -file post_route_phys_opt_design.pb
  set tool_flow [get_property TOOL_FLOW [current_project]]
  if {$tool_flow eq {SDx}} {send_msg_id {101-1} {status} {Finished optional post-route physical design optimization.} }
} RESULT]
if {$rc} {
  step_failed post_route_phys_opt_design
  return -code error $RESULT
} else {
  end_step post_route_phys_opt_design
  unset ACTIVE_STEP 
}

