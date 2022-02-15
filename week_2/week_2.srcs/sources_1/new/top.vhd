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
    
    -- Signals for PS2
    signal ps2_new_code : STD_LOGIC;
    signal ps2_current_code : STD_LOGIC_VECTOR(7 downto 0);
    
    signal ff0 : STD_LOGIC_VECTOR(7 downto 0);
    signal ff1 : STD_LOGIC_VECTOR(7 downto 0);
    
    signal temp : STD_LOGIC_VECTOR(7 downto 0);
    
    signal n0 : integer;
    signal n1 : integer;
    signal n2 : integer;
    signal n3 : integer;
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
    my_display : seven_segment_display port map (
        clk => clk,
        reset => '0',
        segments => segments,
        anode => anodes,
        number0 => n0,
        number1 => n1,
        number2 => n2,
        number3 => n3
    );
    
    process(ps2_new_code) is
    begin
        if rising_edge(ps2_new_code) then
            if ff1 /= "11110000" then
                if ff0 /= "11110000" then
                    n0 <= n1;
                    n1 <= n2;
                    n2 <= n3;
                    case ff1 is
                        when "01000101" =>
                            n3 <= 0;
                        when "00010110" =>
                            n3 <= 1;
                        when "00011110" =>
                            n3 <= 2;
                        when "00100110" =>
                            n3 <= 3;
                        when "00100101" =>
                            n3 <= 4;
                        when "00101110" =>
                            n3 <= 5;
                        when "00110110" =>
                            n3 <= 6;
                        when "00111101" =>
                            n3 <= 7;
                        when "00111110" =>
                            n3 <= 8;
                        when "01000110" =>
                            n3 <= 9;
                        when others =>
                            n3 <= 9;
                    end case;
                end if;
            end if;
            
            ff0 <= ff1;
            ff1 <= ps2_current_code;
        end if;
    end process;

--    process(ps2_new_code) is
--    begin
--        if rising_edge(ps2_new_code) then
            
--        end if;
--    end process;
end Behavioral;
