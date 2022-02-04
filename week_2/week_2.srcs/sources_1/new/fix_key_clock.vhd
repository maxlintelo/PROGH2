library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity meta_fix is
    Port ( main_clk : in STD_LOGIC;
           unstable_clk : in STD_LOGIC;
           stable_clk : out STD_LOGIC
    );
end meta_fix;

architecture Behavioral of meta_fix is

signal ff0 : STD_LOGIC;
signal ff1 : STD_LOGIC;
signal ff2 : STD_LOGIC;

begin
    main_process: process(main_clk) is
    begin
        if rising_edge(main_clk) then
            ff0 <= unstable_clk;
            ff1 <= ff0;
            ff2 <= ff1;
            stable_clk <= ff2;
        end if;
    end process main_process;
end Behavioral;