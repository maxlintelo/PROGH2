library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD;

entity PS2_read is
    generic (
        clk_frequency : integer := 100_000_000
    );
    port (
        clk : in STD_LOGIC;
        ps2_clk : in STD_LOGIC;
        ps2_data : in STD_LOGIC;
        ps2_code : out STD_LOGIC_VECTOR(7 downto 0);
        ps2_code_new : out STD_LOGIC
    );
end PS2_read;

architecture Behavioral of PS2_read is
    signal count_idle : integer range 0 to clk_frequency/18_000;
    signal ps2_word : std_logic_vector(10 downto 0);
begin
    process(ps2_clk) is
    begin
        if falling_edge(ps2_clk) then
            ps2_word <= ps2_data & ps2_word(10 DOWNTO 1);
        end if;
    end process;
    
    process(clk) is
    begin
        if rising_edge(clk) then
            if ps2_clk = '0' then
                count_idle <= 0;
            elsif count_idle /= clk_frequency/18_000 then
                count_idle <= count_idle + 1;
            end if;
            if count_idle = clk_frequency/18_000 then
                ps2_code_new <= '1';
                ps2_code <= ps2_word(8 DOWNTO 1);
            else
                ps2_code_new <= '0';
            end if;
        end if;
    end process;
end Behavioral;
