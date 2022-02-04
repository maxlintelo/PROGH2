----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2022 12:06:08
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
Port(    
    PS2_clock : in STD_LOGIC;
    i_data_key : in STD_LOGIC;
    clk: in STD_LOGIC;
    led_out: out STD_LOGIC);
end top;

architecture Behavioral of top is

component meta_fix is
    Port ( main_clk : in STD_LOGIC;
           unstable_clk : in STD_LOGIC;
           stable_clk : out STD_LOGIC
    );
end component;

component PS2_read is
Port (  clk_key     : in STD_LOGIC; -- clock is already stable and synced with fpga
        data_key    : in STD_LOGIC;
        scancode    : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal stable : STD_LOGIC;
signal o_scancode : STD_LOGIC_VECTOR(7 downto 0);

begin

    meta_fix1: meta_fix port map(main_clk => clk, unstable_clk => PS2_clock, stable_clk => stable);
    PS2_read1: PS2_read port map(clk_key => stable, data_key => i_data_key, scancode => o_scancode);

    led_out <= o_scancode(0);

end Behavioral;
