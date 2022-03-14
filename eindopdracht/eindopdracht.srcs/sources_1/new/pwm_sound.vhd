library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_sound is
    port (
        clk : in std_logic;
        reset : in std_logic;
        frequency : in integer;
        pwm : out std_logic
    );
end pwm_sound;

architecture Behavioral of pwm_sound is
--    component pwm_clk is
--        Port ( 
--            clk_out1 : out STD_LOGIC;
--            reset : in STD_LOGIC;
--            locked : out STD_LOGIC;
--            clk_in1 : in STD_LOGIC
--        );
--    end component pwm_clk;
    
    --signal clk_16 : std_logic;
    signal clk_counter : integer range 0 to 100000000;
    signal pwm_value : std_logic;
    signal pwm_length : integer;
begin
--    my_pwm_clock : pwm_clk port map (
--        clk_out1 => clk_16,
--        reset => reset,
--        clk_in1 => clk
--    );
    
    frequency_p : process(clk) is
    begin
        pwm_length <= 100000000/frequency;
        
        if clk_counter < pwm_length / 2 then
            pwm_value <= '1';
        else
            pwm_value <= '0';
        end if;
        
        if clk_counter >= pwm_length then
            clk_counter <= 0;
        else
            clk_counter <= clk_counter + 1;
        end if;
    end process frequency_p;
    
    pwm_process: process(clk) is
    begin
        if rising_edge(clk) then
            pwm <= pwm_value;
        end if;
    end process pwm_process;
end Behavioral;
