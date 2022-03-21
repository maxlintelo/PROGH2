library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

package constants is
    constant c_screen_width : integer := 1920;
    constant c_screen_height : integer := 1080;
    
    constant c_balk_width : integer := 980;
    constant c_balk_height : integer := 720;
    
    constant c_noot_height : integer := 113;
    constant c_noot_width : integer := 209;
    
    constant c_flat_height : integer := 233;
    constant c_flat_width : integer := 69;
    
    constant c_sharp_height : integer := 233;
    constant c_sharp_width : integer := 124;
    
    constant c_note_offset_x : integer := 550;
    constant c_flat_offset_x : integer := 450;
    constant c_sharp_offset_x : integer := 400;
    
    constant c_flat_offset_y : integer := -53;
    constant c_sharp_offset_y : integer := -53;
end package constants;
