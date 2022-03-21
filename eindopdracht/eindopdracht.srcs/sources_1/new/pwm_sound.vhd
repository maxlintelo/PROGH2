library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_sound is
    port (
        clk : in std_logic;
        reset : in std_logic;
        note : in integer;
        pwm : out std_logic
    );
end pwm_sound;

architecture Behavioral of pwm_sound is
    component clk_wiz_sound is
        port ( 
            clk_out1 : out STD_LOGIC;
            reset : in STD_LOGIC;
            locked : out STD_LOGIC;
            clk_in1 : in STD_LOGIC
        );
    end component clk_wiz_sound;
    
    signal frequency : integer;
    signal clk_counter : integer;
begin
    pwm_clk : clk_wiz_sound port map (
        reset => reset,
        clk_in1 => clk
    );
    
    process(clk, reset) is
        variable wavelength : integer := 100_000_000 / frequency * 2;
    begin
        if reset = '1' then
        elsif rising_edge(clk) then
            pwm <= '0';
            if clk_counter >= wavelength then
                clk_counter <= 0;
            else
                if clk_counter < (wavelength / 2) then
                    pwm <= '1';
                end if;
                clk_counter <= clk_counter + 1;
            end if;
        end if;
    end process;
    
    process(clk, reset) is
    begin
        if reset = '1' then
            frequency <= 523;
        elsif rising_edge(clk) then
            case note is
                when 1 => -- F4b
                    frequency <= 329;
                when 2 => -- F4
                    frequency <= 349;
                when 3 | 4 => -- F4s | G4b
                    frequency <= 369;
                when 5 => -- G4
                    frequency <= 392;
                when 6 | 7 => -- G4s | A4b
                    frequency <= 415;
                when 8 => -- A4
                    frequency <= 440;
                when 9 | 10 => -- A4s | B4b
                    frequency <= 466;
                when 11 | 13 => -- B4 | C5b => B4
                    frequency <= 493;
                when 12 | 14 => -- B4s => C5 | C5
                    frequency <= 523;
                when 15 | 16 => -- C5s | D5b
                    frequency <= 554;
                when 17 => -- D5
                    frequency <= 587;
                when 18 | 19 => -- D5s | E5b
                    frequency <= 622;
                when 20 | 22 => -- E5 | F5b => E5
                    frequency <= 659;
                when 21 | 23 => -- E5s => F5 | F5
                    frequency <= 698;
                when 24 => -- F5s
                    frequency <= 739;
                when others => -- C5
                    frequency <= 523;
            end case;
        end if;
    end process;
end Behavioral;
