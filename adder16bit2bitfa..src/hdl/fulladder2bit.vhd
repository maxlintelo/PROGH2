library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladder2bit is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           CI : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (1 downto 0);
           CO : out STD_LOGIC);
end fulladder2bit;

architecture Behavioral of fulladder2bit is

--attribute keep_hierarchy : string;
--attribute keep_hierarchy of Behavioral: architecture is "yes";

component fulladder1bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           CI : in STD_LOGIC;
           CO : out STD_LOGIC);
end component;

signal COBIT0 : std_logic;

begin

fulladder1bit0: fulladder1bit port map (A => A(0), B => B(0), S => S(0), CI => CI, CO => COBIT0);
fulladder1bit1: fulladder1bit port map (A => A(1), B => B(1), S => S(1), CI => COBIT0, CO => CO);

end Behavioral;
