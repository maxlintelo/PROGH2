library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_sound is
    port (
        clk : in std_logic;
        reset : in std_logic;
        note : in integer;
        accidental : in std_logic_vector(1 downto 0);
        pwm : out std_logic;
        enabled : in std_logic
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
        variable wavelength : integer := 1_000_000_000 / frequency * 2;
    begin
        if reset = '1' then
        elsif rising_edge(clk) then
            pwm <= '0';
            if clk_counter >= wavelength then
                clk_counter <= 0;
            else
                if clk_counter < (wavelength / 2) then
                    if enabled = '1' then
                        pwm <= '1';
                    end if;
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
            if accidental(0) = '1' then
                -- Sharps
                case note is
                when 0 => -- C5s
                    frequency <= 5543;
                when 1 => -- D5s
                    frequency <= 6222;
                when 2 => -- E5s
                    frequency <= 6984;
                when 3 => -- F5s
                    frequency <= 7399;
                when 4 => -- G5s
                    frequency <= 8306;
                when 5 => -- A5s
                    frequency <= 9323;
                when 6 => -- B5s
                    frequency <= 10465;
                when 7 => -- C6s
                    frequency <= 11087;
                when 8 => -- D6s
                    frequency <= 12445;
                when 9 => -- E6s
                    frequency <= 13969;
                when 10 => -- F6s
                    frequency <= 14799;
                when others =>
                    frequency <= 5232;
                end case;
            elsif accidental(1) = '1' then
                -- Flats
                case note is
                when 0 => -- C5b
                    frequency <= 4938;
                when 1 => -- D5b
                    frequency <= 5543;
                when 2 => -- E5b
                    frequency <= 6222;
                when 3 => -- F5b
                    frequency <= 6592;
                when 4 => -- G5b
                    frequency <= 7399;
                when 5 => -- A5b
                    frequency <= 8306;
                when 6 => -- B5b
                    frequency <= 9323;
                when 7 => -- C6b
                    frequency <= 9877;
                when 8 => -- D6b
                    frequency <= 11087;
                when 9 => -- E6b
                    frequency <= 12445;
                when 10 => -- F6b
                    frequency <= 13185;
                when others =>
                    frequency <= 5232;
                end case;
            else
                -- Naturals
                case note is
                when 0 => -- C5
                    frequency <= 5232;
                when 1 => -- D5
                    frequency <= 5873;
                when 2 => -- E5
                    frequency <= 6592;
                when 3 => -- F5
                    frequency <= 6984;
                when 4 => -- G5
                    frequency <= 7839;
                when 5 => -- A5
                    frequency <= 8800;
                when 6 => -- B5
                    frequency <= 9877;
                when 7 => -- C6
                    frequency <= 10465;
                when 8 => -- D6
                    frequency <= 11746;
                when 9 => -- E6
                    frequency <= 13185;
                when 10 => -- F6
                    frequency <= 13969;
                when others =>
                    frequency <= 5232;
                end case;
            end if;
        end if;
    end process;
end Behavioral;
