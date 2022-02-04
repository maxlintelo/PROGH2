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
    l1: out STD_LOGIC_VECTOR(7 downto 0);
    segments: out STD_LOGIC_VECTOR(6 downto 0);
    anodes: out STD_LOGIC_VECTOR(3 downto 0);
    new_code: out STD_LOGIC
    );
end top;

architecture Behavioral of top is

component meta_fix is
    Port ( main_clk : in STD_LOGIC;
           unstable_clk : in STD_LOGIC;
           stable_clk : out STD_LOGIC
    );
end component;

component PS2_read is
Port (  clk : in STD_LOGIC;
        ps2_clk     : in STD_LOGIC; -- clock is already stable and synced with fpga
        ps2_data    : in STD_LOGIC;
        ps2_code_new : out STD_LOGIC;
        ps2_code    : out STD_LOGIC_VECTOR(7 downto 0);
        ps2_code_previous : out STD_LOGIC_VECTOR(7 downto 0));
end component PS2_read;

component seven_segment_display is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        number0 : in INTEGER range 0 to 9;
        number1 : in INTEGER range 0 to 9;
        number2 : in INTEGER range 0 to 9;
        number3 : in INTEGER range 0 to 9;
        segments : out STD_LOGIC_VECTOR (6 downto 0);
        anode : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component seven_segment_display;

signal stable : STD_LOGIC;

signal num0 : INTEGER range 0 to 9;
signal num1 : INTEGER range 0 to 9;
signal num2 : INTEGER range 0 to 9;
signal num3 : INTEGER range 0 to 9;

signal new_code_flag : STD_LOGIC;
signal s_toggled : STD_LOGIC;

signal previous_code : STD_LOGIC_VECTOR(7 downto 0);
signal current_code : STD_LOGIC_VECTOR(7 downto 0);

begin
    meta_fix1: meta_fix port map(main_clk => clk, unstable_clk => PS2_clock, stable_clk => stable);
    PS2_read1: PS2_read port map(clk => clk, ps2_clk => stable, ps2_data => i_data_key, ps2_code => current_code, ps2_code_new => new_code_flag, ps2_code_previous => previous_code);
    display: seven_segment_display port map(
        clk => clk, reset => '0',
        number0 => num0, number1 => num1, number2 => num2, number3 => num3,
        segments => segments, anode => anodes
    );
    
    l1 <= current_code;
    
    my_pro: process(new_code_flag) is
    begin
        if rising_edge(new_code_flag) then
            if previous_code = "11110000" then
                new_code <= '1';
            else
                num0 <= num1;
                num1 <= num2;
                num2 <= num3;
            end if;
        end if;
    end process my_pro;
    
    p: process(clk) is
    variable temp : std_logic_vector(7 downto 0);
    begin
        if rising_edge(clk) then
            --for i in 0 to o_scancode'left loop
            --    temp(i) := o_scancode(o_scancode'left - i);
            --end loop;
            case current_code is
            when "01000101" =>
                num3 <= 0;
            when "00010110" =>
                num3 <= 1;
            when "00011110" =>
                num3 <= 2;
            when "00100110" =>
                num3 <= 3;
            when "00100101" =>
                num3 <= 4;
            when "00101110" =>
                num3 <= 5;
            when "00110110" =>
                num3 <= 6;
            when "00111101" =>
                num3 <= 7;
            when "00111110" =>
                num3 <= 8;
            when "01000110" =>
                num3 <= 9;
            when others =>
                num3 <= 9;
            end case;
        end if;
    end process p;
end Behavioral;
