library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- TODO Remove
use IEEE.NUMERIC_STD.ALL;

library eindopdracht;
use eindopdracht.constants.ALL;

entity vga_controller is
    port (
        clk : in std_logic;
        Pixel_clk : in STD_LOGIC; -- 148.5MHz
        red : out STD_LOGIC_VECTOR (3 downto 0);
        green : out STD_LOGIC_VECTOR (3 downto 0);
        blue : out STD_LOGIC_VECTOR (3 downto 0);
        hsync, vsync : out STD_LOGIC;
        note : in integer;
        note_color : in std_logic_vector(1 downto 0)
    );
end vga_controller;

architecture Behavioral of vga_controller is
    -- h720 w980
    component blk_mem_notenbalk is
        port ( 
            clka : in STD_LOGIC;
            ena : in STD_LOGIC;
            addra : in STD_LOGIC_VECTOR ( 19 downto 0 );
            douta : out STD_LOGIC_VECTOR ( 0 to 0 )
        );
    end component blk_mem_notenbalk;
    component blk_mem_noot is
        port ( 
            clka : in STD_LOGIC;
            ena : in STD_LOGIC;
            addra : in STD_LOGIC_VECTOR ( 14 downto 0 );
            douta : out STD_LOGIC_VECTOR ( 0 to 0 )
        );
    end component blk_mem_noot;
    
    constant H_pixels: integer := 1920; --horizontal display width in pixels
    constant H_frontporch: integer := 88; --horizontal front porch width in pixels
    constant H_syncwidth: integer := 44; --horizontal sync pulse width in pixels
    constant H_backporch: integer := 148; --horizontal back porch width in pixels
    constant H_total_pixels: integer := (H_pixels + H_frontporch + H_syncwidth + H_backporch);
    constant H_sync_polarity: STD_LOGIC := '1';	--horizontal sync pulse polarity (1 = positive, 0 = negative)
    constant V_pixels: integer := 1080; --vertical display width in rows
    constant V_frontporch: integer := 4; --vertical front porch width in rows
    constant V_syncwidth: integer := 5; --vertical sync pulse width in rows
    constant V_backporch: integer := 36; --vertical back porch width in rows
    constant V_total_pixels: integer := (V_pixels + V_frontporch + V_syncwidth + V_backporch);
    constant V_sync_polarity: STD_LOGIC := '1';	--vertical sync pulse polarity (1 = positive, 0 = negative)
    
    signal notenbalk_addr : std_logic_vector(19 downto 0);
    signal notenbalk_data : std_logic;
    signal noot_addr : std_logic_vector(14 downto 0);
    signal noot_data : std_logic;
    
    signal test : integer := 628;
    constant noot_start_x : integer := 400;
    
    
begin
    my_notenbalk : blk_mem_notenbalk port map (
        clka => Pixel_clk,
        ena => '1',
        addra => notenbalk_addr,
        douta(0) => notenbalk_data
    );
    my_noot : blk_mem_noot port map (
        clka => pixel_clk,
        ena => '1',
        addra => noot_addr,
        douta(0) => noot_data
    );
    
    process (clk) is
    begin
        if rising_edge(clk) then
            case note is
            when 1 | 2 | 3 =>
                test <= 628;
            when 4 | 5 | 6 =>
                test <= 628 - 53;
            when 7 | 8 | 9 =>
                test <= 628 - 106;
            when 10 | 11 | 12 =>
                test <= 628 - 159;
            when 13 | 14 | 15 =>
                test <= 628 - 212;
            when 16 | 17 | 18 =>
                test <= 628 - 265;
            when 19 | 20 | 21 =>
                test <= 628 - 318;
            when 22 | 23 | 24 =>
                test <= 628 - 371;
            when others =>
                test <= 628;
            end case;
        end if;
    end process;
    
    
    process (Pixel_clk) is
        VARIABLE hcount	:	INTEGER RANGE 0 TO H_total_pixels - 1 := 0;  --horizontal counter (counts the columns)
        VARIABLE vcount	:	INTEGER RANGE 0 TO V_total_pixels - 1 := 0;  --vertical counter (counts the rows)
        variable hcount_temp : integer;
    begin
        if rising_edge(Pixel_clk) then
            notenbalk_addr <= std_logic_vector(to_unsigned((((vcount-((screen_height - balk_height)/2)) * balk_width) + hcount_temp), notenbalk_addr'length));
            noot_addr <= std_logic_vector(to_unsigned(  ( (vcount - test) * c_noot_width ) + (hcount - noot_start_x), noot_addr'length  ));
            -- Standard blanking
            red <= "0000";
            green <= "0000";
            blue <= "0000";
            
            if (hcount >= 0) and (hcount < H_pixels) and (vcount >= 0) and (vcount < V_pixels) then
                -- START DISPLAY TIME
                red <= "1111";
                green <= "1111";
                blue <= "1111";
                
                if hcount >= (balk_width - 10) then
                    hcount_temp := balk_width - 30;
                else
                    hcount_temp := hcount;
                end if;
                -- 0000 == zwart
                
                if vcount > ((screen_height - balk_height)/2) then
                    if notenbalk_data = '0' then
                    --if balk((balk_width * balk_height)-(((vcount-((screen_height - balk_height)/2)) * balk_width) + hcount_temp)) = '1' then
                        red <= "0000";
                        green <= "0000";
                        blue <= "0000";
                    end if;
                end if;
                
                if vcount >= test and vcount < test + c_noot_height and hcount >= noot_start_x + 2 and hcount < noot_start_x + c_noot_width + 2 then
                    if noot_data = '0' then
                        if note_color(0) = '1' then
                            red <= "1111";
                        else
                            red <= "0000";
                        end if;
                        if note_color(1) = '1' then
                            green <= "1111";
                        else
                            green <= "0000";
                        end if;
                        blue <= "0000";
                    end if;
                end if;
                -- END DISPLAY TIME
            end if;
            -- Horizontal sync pulse signal
            if ((hcount >= (H_pixels + H_frontporch)) and (hcount < (H_pixels + H_frontporch + H_syncwidth))) then
                hsync <= H_sync_polarity;
            else
                hsync <= (not H_sync_polarity);
            end if;
            -- vertical sync pulse signal
            if ((vcount >= (V_pixels + V_frontporch)) and (vcount < (V_pixels + V_frontporch + V_syncwidth))) then
                vsync <= V_sync_polarity;
            else
                vsync <= (not V_sync_polarity);
            end if;
            -- horizontal pixel counter
            hcount := hcount + 1;
            
            if hcount = (H_total_pixels - 1) then
                -- vertical line counter
                vcount := vcount + 1;
                hcount := 0;
            end if;
            
            if vcount = (V_total_pixels -1) then		    
                vcount := 0;
            end if;
        end if;
    end process;
end Behavioral;
