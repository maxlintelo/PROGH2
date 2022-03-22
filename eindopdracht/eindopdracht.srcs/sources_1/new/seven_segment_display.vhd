library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_display is
    port (
        sys_clock : in std_logic;
        sys_reset : in std_logic;
        left_int : in integer;
        right_int : in integer;
        display : out std_logic_vector(3 downto 0);
        segment : out std_logic_vector(6 downto 0)
    );
end seven_segment_display;

architecture Behavioral of seven_segment_display is
    signal signal_delay: STD_LOGIC_VECTOR (19 downto 0); -- 10.5
    signal led_count: std_logic_vector(1 downto 0);
    
    function get_segments (
        number_in : in integer)
        return std_logic_vector is
        variable temp : integer;
    begin
        temp := number_in mod 10;
        case temp is
            when 0 => return "0000001"; --0
            when 1 => return "1001111"; --1
            when 2 => return "0010010"; --2
            when 3 => return "0000110"; --3
            when 4 => return "1001100"; --4
            when 5 => return "0100100"; --5
            when 6 => return "0100000"; --6
            when 7 => return "0001111"; --7
            when 8 => return "0000000"; --8
            when 9 => return "0000100"; --9
            when others => return "1111110";
        end case;
    end;
begin
    process(sys_clock, sys_reset)
    begin 
        if(sys_reset='1') then
            signal_delay <= (others => '0');
        elsif(rising_edge(sys_clock)) then
            signal_delay <= signal_delay + 1;
        end if;
    end process;

    led_count <= signal_delay(19 downto 18);

    process(led_count)
    begin
        segment <= "1111110";
        if(led_count = "00") then
            segment <= get_segments(right_int);
            display <= "1110";
        elsif(led_count = "01") then
            segment <= get_segments(right_int / 10);
            display <= "1101";
        elsif(led_count = "10") then
            display <= "1011";
            segment <= get_segments(left_int);
        else
            segment <= get_segments(left_int / 10);
            display <= "0111";
        end if;
    end process;
end Behavioral;
