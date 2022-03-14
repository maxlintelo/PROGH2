--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Mon Mar 14 11:00:24 2022
--Host        : DESKTOP-5PCB5FN running 64-bit major release  (build 9200)
--Command     : generate_target microblaze_wrapper.bd
--Design      : microblaze_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity microblaze_wrapper is
  port (
    GPIO2_0_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GPIO_0_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dip_switches_16bits_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    led_16bits_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end microblaze_wrapper;

architecture STRUCTURE of microblaze_wrapper is
  component microblaze is
  port (
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    dip_switches_16bits_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    led_16bits_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    GPIO_0_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    GPIO2_0_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component microblaze;
begin
microblaze_i: component microblaze
     port map (
      GPIO2_0_tri_o(31 downto 0) => GPIO2_0_tri_o(31 downto 0),
      GPIO_0_tri_i(31 downto 0) => GPIO_0_tri_i(31 downto 0),
      dip_switches_16bits_tri_i(15 downto 0) => dip_switches_16bits_tri_i(15 downto 0),
      led_16bits_tri_o(15 downto 0) => led_16bits_tri_o(15 downto 0),
      reset => reset,
      sys_clock => sys_clock,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
