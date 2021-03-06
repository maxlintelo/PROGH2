//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Thu Feb 24 15:25:47 2022
//Host        : LAPTOP-T2099UT1 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (dip_switches_16bits_tri_i,
    led_16bits_tri_o,
    push_buttons_4bits_tri_i,
    reset,
    sys_clock,
    usb_uart_0_rxd,
    usb_uart_0_txd);
  input [15:0]dip_switches_16bits_tri_i;
  output [15:0]led_16bits_tri_o;
  input [3:0]push_buttons_4bits_tri_i;
  input reset;
  input sys_clock;
  input usb_uart_0_rxd;
  output usb_uart_0_txd;

  wire [15:0]dip_switches_16bits_tri_i;
  wire [15:0]led_16bits_tri_o;
  wire [3:0]push_buttons_4bits_tri_i;
  wire reset;
  wire sys_clock;
  wire usb_uart_0_rxd;
  wire usb_uart_0_txd;

  design_1 design_1_i
       (.dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .led_16bits_tri_o(led_16bits_tri_o),
        .push_buttons_4bits_tri_i(push_buttons_4bits_tri_i),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_0_rxd(usb_uart_0_rxd),
        .usb_uart_0_txd(usb_uart_0_txd));
endmodule
