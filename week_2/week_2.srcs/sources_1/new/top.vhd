library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

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
    component ps2_keyboard is
        port (
            clk, reset: in std_logic;              -- System clock and reset
            ps2d, ps2c: in std_logic;              -- PS/2 data and clock signals
            rx_en: in std_logic;                   -- Receiver enabled/disabled signal
            rx_done: out std_logic;                -- End of transmission signal
            dout: out std_logic_vector(7 downto 0) -- Output buffer
        );
    end component ps2_keyboard;
    
    -- Signals for PS2
    signal ps2_new_code : STD_LOGIC;
    signal ps2_current_code : STD_LOGIC_VECTOR(7 downto 0);
    
    signal ff0 : STD_LOGIC_VECTOR(7 downto 0);
    signal ff1 : STD_LOGIC_VECTOR(7 downto 0);
begin
    my_keyboard : ps2_keyboard port map (
        clk => clk,
        reset => '0',
        ps2d => i_data_key,
        ps2c => ps2_clock,
        rx_en => '1',
        rx_done => ps2_new_code,
        dout => ps2_current_code
    );
    
    process(ps2_new_code) is
    begin
        if rising_edge(ps2_new_code) then
            ff0 <= ff1;
            ff1 <= ps2_current_code;
        end if;
    end process;
    
    process(ps2_new_code) is
    begin
        if rising_edge(ps2_new_code) then
            if ff1 /= "11110000" then
                if ps2_current_code /= "11110000" and ps2_current_code /= "00001111" then
                    l1 <= ps2_current_code;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
