library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;

entity PS2_read is
Port (  clk : in STD_LOGIC;
        ps2_clk : in STD_LOGIC; -- clock is already stable and synced with fpga
        ps2_data : in STD_LOGIC;
        ps2_code_new : out STD_LOGIC;
        ps2_code : out STD_LOGIC_VECTOR(7 downto 0);
        ps2_code_previous : out STD_LOGIC_VECTOR(7 downto 0));
end PS2_read;

architecture Behavioral of PS2_read is

signal reading: STD_LOGIC := '0';
signal ps2_word : STD_LOGIC_VECTOR(10 downto 0) := (others => '1');
signal error : STD_LOGIC;
signal ps2_current_code : STD_LOGIC_VECTOR(7 downto 0);

begin
    ps2_retrieve: process(ps2_clk) is
    begin
        if rising_edge(ps2_clk) then
            
            ps2_word <= ps2_data & ps2_word(10 downto 1);
        end if;
    end process ps2_retrieve;
    
    error <= NOT (NOT ps2_word(0) AND ps2_word(10) AND (ps2_word(9) XOR ps2_word(8) XOR
        ps2_word(7) XOR ps2_word(6) XOR ps2_word(5) XOR ps2_word(4) XOR ps2_word(3) XOR 
        ps2_word(2) XOR ps2_word(1)));
    ps2_code <= ps2_current_code;
    
    output_result: process(clk) is
    begin
        if rising_edge(clk) then
            if error = '0' then
                ps2_code_new <= '1';
                if ps2_current_code /= ps2_word(8 downto 1) then
                    ps2_code_previous <= ps2_current_code;
                end if;
                ps2_current_code <= ps2_word(8 downto 1);
            else
                ps2_code_new <= '0';
            end if;
        end if;
    end process output_result;
end Behavioral;
