library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_display is
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
end seven_segment_display;

architecture Behavioral of seven_segment_display is

signal refresh_counter : STD_LOGIC_VECTOR(19 downto 0);
signal active_leds : STD_LOGIC_VECTOR(1 downto 0);
signal led_integer : INTEGER range 0 to 9;

begin
    active_leds <= refresh_counter(19 downto 18);
    
    clock_process: process(clk, reset) is
    begin
        if reset = '1' then
            -- Reset counter
            refresh_counter <= (others => '0');
        elsif rising_edge(clk) then
            -- Increment counter by 1
            refresh_counter <= std_logic_vector(to_unsigned(to_integer(unsigned(refresh_counter)) + 1, refresh_counter'length));
        end if;
    end process clock_process;
    
    anode_process: process(clk, reset) is
    begin
        case active_leds is
        when "00" =>
            anode <= "0111";
            led_integer <= number0;
        when "01" =>
            anode <= "1011";
            led_integer <= number1;
        when "10" =>
            anode <= "1101";
            led_integer <= number2;
        when "11" =>
            anode <= "1110";
            led_integer <= number3;
        end case;
    end process anode_process;
    conversion_process: process(led_integer) is
    begin
        case led_integer is
        when 0 =>
            segments <= "0000001";
        when 1 =>
            segments <= "1001111";
        when 2 =>
            segments <= "0010010";
        when 3 =>
            segments <= "0000110";
        when 4 =>
            segments <= "1001100";
        when 5 =>
            segments <= "0100100";
        when 6 =>
            segments <= "0100000";
        when 7 =>
            segments <= "0001111";
        when 8 =>
            segments <= "0000000";
        when 9 =>
            segments <= "0000100";
        end case;
    end process conversion_process;
end Behavioral;