library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder16bit2bitfa is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0);
           CO : out STD_LOGIC;
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC);
end adder16bit2bitfa;

architecture Behavioral of adder16bit2bitfa is

attribute keep_hierarchy : string;
attribute keep_hierarchy of Behavioral: architecture is "yes";

component fulladder2bit is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           CI : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (1 downto 0);
           CO : out STD_LOGIC);
end component;

component gen_sync_ff is
    Generic (N, DEPTH : integer := 1);
    Port ( D : in STD_LOGIC_VECTOR(N-1 downto 0);
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;

component gen_ff is
    Generic (N : integer);
    Port ( D : in STD_LOGIC_VECTOR(N-1 downto 0);
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;

component ff is
    Port ( D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

signal CARRY : std_logic_vector(16 downto 0);
signal AI : std_logic_vector(A'range);
signal BI : std_logic_vector(B'range);
signal SO : std_logic_vector(S'range);
signal COO : std_logic;

begin

  A_FF: gen_sync_ff
    generic map ( DEPTH => 3, N => A'length )
    port map (D => A, CLK => CLK, Q => AI);
 
   B_FF: gen_sync_ff
    generic map ( DEPTH => 3, N => B'length )
    port map (D => B, CLK => CLK, Q => BI);

  CARRY(0) <= '0';

  Gen_1 : for I in 0 to 15 generate
    Gen_2: if (I mod 2) = 0 generate
      fulladder2bitgen : fulladder2bit port map (
      A => AI(I+1 downto I),
      B => BI(I+1 downto I),
      CI => CARRY(I),
      S => SO(I+1 downto I),
      CO => CARRY(I+2)
      );
     end generate;
  end generate;

  COO <= CARRY(16);

  S_FF: gen_ff
    generic map ( N => SO'length)
    port map (D => SO, CLK => CLK, Q => S);
  
  CO_FF: ff
    port map (D => COO, CLK => CLK, Q => CO);

end Behavioral;
