--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Thu Feb 24 15:27:14 2022
--Host        : LAPTOP-T2099UT1 running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    dip_switches_16bits_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    led_16bits_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_0_rxd : in STD_LOGIC;
    usb_uart_0_txd : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_16bits_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    usb_uart_0_rxd : in STD_LOGIC;
    usb_uart_0_txd : out STD_LOGIC;
    dip_switches_16bits_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      dip_switches_16bits_tri_i(15 downto 0) => dip_switches_16bits_tri_i(15 downto 0),
      led_16bits_tri_o(15 downto 0) => led_16bits_tri_o(15 downto 0),
      push_buttons_4bits_tri_i(3 downto 0) => push_buttons_4bits_tri_i(3 downto 0),
      reset => reset,
      sys_clock => sys_clock,
      usb_uart_0_rxd => usb_uart_0_rxd,
      usb_uart_0_txd => usb_uart_0_txd
    );
end STRUCTURE;
