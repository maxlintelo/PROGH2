----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2022 13:12:13
-- Design Name: 
-- Module Name: PS2_read - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PS2_read is
Port (  clk_key     : in STD_LOGIC; -- clock is already stable and synced with fpga
        data_key    : in STD_LOGIC;
        scancode    : out STD_LOGIC_VECTOR(7 downto 0));
end PS2_read;

architecture Behavioral of PS2_read is

signal reading: STD_LOGIC := '0';
signal data: STD_LOGIC_VECTOR(10 downto 0) := (others => '1');

begin
    
    process(clk_key) is
    
    begin
        
    if falling_edge(clk_key) then  
        data <= data(9 downto 0) & data_key; -- shift data 
        if data(10) = '0' then -- when last bit is 0, all data is send
            scancode <= data(9 downto 2);
            data <= (others => '1');
        end if;
    end if;
    
    end process;

end Behavioral;
