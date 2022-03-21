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
        note_height : in integer;
        note_color : in std_logic_vector(1 downto 0);
        note_type : in std_logic_vector(1 downto 0)
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
    component blk_mem_flat is
        port ( 
            clka : in STD_LOGIC;
            ena : in STD_LOGIC;
            addra : in STD_LOGIC_VECTOR ( 13 downto 0 );
            douta : out STD_LOGIC_VECTOR ( 0 to 0 )
        );
    end component blk_mem_flat;
    component blk_mem_sharp is
        port ( 
            clka : in STD_LOGIC;
            ena : in STD_LOGIC;
            addra : in STD_LOGIC_VECTOR ( 14 downto 0 );
            douta : out STD_LOGIC_VECTOR ( 0 to 0 )
        );
    end component blk_mem_sharp;
    
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
    signal flat_addr : std_logic_vector(13 downto 0);
    signal flat_data : std_logic;
    signal sharp_addr : std_logic_vector(14 downto 0);
    signal sharp_data : std_logic;
begin
    my_notenbalk : blk_mem_notenbalk port map (
        clka => pixel_clk,
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
    my_flat : blk_mem_flat port map (
        clka => pixel_clk,
        ena => '1',
        addra => flat_addr,
        douta(0) => flat_data
    );
    my_sharp : blk_mem_sharp port map (
        clka => pixel_clk,
        ena => '1',
        addra => sharp_addr,
        douta(0) => sharp_data
    );
    
--    process (Pixel_clk) is
--        VARIABLE hcount	:	INTEGER RANGE 0 TO H_total_pixels - 1 := 0;  --horizontal counter (counts the columns)
--        VARIABLE vcount	:	INTEGER RANGE 0 TO V_total_pixels - 1 := 0;  --vertical counter (counts the rows)
--        variable hcount_temp : integer;
--    begin
--        if rising_edge(Pixel_clk) then
--            notenbalk_addr <= std_logic_vector(to_unsigned((((vcount-((c_screen_height - c_balk_height)/2)) * c_balk_width) + hcount_temp), notenbalk_addr'length));
--            noot_addr <= std_logic_vector(to_unsigned(  ((vcount - note_height) * c_noot_width ) + (hcount - c_note_offset_x), noot_addr'length  ));
            
--            sharp_addr <= std_logic_vector(to_unsigned(
--                (vcount - note_height - c_sharp_offset_y) * c_sharp_width + (hcount - c_sharp_offset_x)
--            ,sharp_addr'length));
            
--            flat_addr <= std_logic_vector(to_unsigned(
--                (vcount - note_height - c_flat_offset_y) * c_flat_width + (hcount - c_flat_offset_x)
--            ,flat_addr'length));

--            if (hcount >= 0) and (hcount < H_pixels) and (vcount >= 0) and (vcount < V_pixels) then
--                -- START DISPLAY TIME
--                red <= "1111";
--                green <= "1111";
--                blue <= "1111";
                
--                if hcount >= (c_balk_width - 10) then
--                    hcount_temp := c_balk_width - 30;
--                else
--                    hcount_temp := hcount;
--                end if;
--                -- 0000 == zwart
                
--                if vcount > ((c_screen_height - c_balk_height)/2) then
--                    if notenbalk_data = '0' then
--                    --if balk((balk_width * balk_height)-(((vcount-((screen_height - balk_height)/2)) * balk_width) + hcount_temp)) = '1' then
--                        red <= "0000";
--                        green <= "0000";
--                        blue <= "0000";
--                    end if;
--                end if;
                
--                if note_type(0) = '1' then
--                    -- This note is a sharp
--                    if vcount >= note_height + c_sharp_offset_y and vcount < note_height + c_sharp_height + c_sharp_offset_y
--                    and hcount >= c_sharp_offset_x + 2 and hcount < c_sharp_offset_x + c_sharp_width + 2 then
--                        if sharp_data = '0' then
--                            red <= "0000";
--                            green <= "0000";
--                            blue <= "0000";
--                        end if;
--                    end if;
--                elsif note_type(1) = '1' then
--                    -- This note is a flat
--                    if vcount >= note_height + c_flat_offset_y and vcount < note_height + c_flat_height + c_flat_offset_y
--                    and hcount >= c_flat_offset_x + 2 and hcount < c_flat_offset_x + c_flat_width + 2 then
--                        if flat_data = '0' then
--                            red <= "0000";
--                            green <= "0000";
--                            blue <= "0000";
--                        end if;
--                    end if;
--                end if;
                
--                if vcount >= note_height and vcount < note_height + c_noot_height and hcount >= c_note_offset_x + 2 and hcount < c_note_offset_x + c_noot_width + 2 then
--                    if noot_data = '0' then
--                        if note_color(0) = '1' then
--                            red <= "1111";
--                        else
--                            red <= "0000";
--                        end if;
--                        if note_color(1) = '1' then
--                            green <= "1111";
--                        else
--                            green <= "0000";
--                        end if;
--                        blue <= "0000";
--                    end if;
--                end if;
--                -- END DISPLAY TIME
--            end if;
--            -- Horizontal sync pulse signal
--            if ((hcount >= (H_pixels + H_frontporch)) and (hcount < (H_pixels + H_frontporch + H_syncwidth))) then
--                hsync <= H_sync_polarity;
--            else
--                hsync <= (not H_sync_polarity);
--            end if;
--            -- vertical sync pulse signal
--            if ((vcount >= (V_pixels + V_frontporch)) and (vcount < (V_pixels + V_frontporch + V_syncwidth))) then
--                vsync <= V_sync_polarity;
--            else
--                vsync <= (not V_sync_polarity);
--            end if;
--            -- horizontal pixel counter
--            hcount := hcount + 1;
            
--            if hcount = (H_total_pixels - 1) then
--                -- vertical line counter
--                vcount := vcount + 1;
--                hcount := 0;
--            end if;
            
--            if vcount = (V_total_pixels -1) then		    
--                vcount := 0;
--            end if;
--        else
--            red <= "0000";
--            green <= "0000";
--            blue <= "0000";
--        end if;
--    end process;
    process (Pixel_clk) is
        VARIABLE hcount	:	INTEGER RANGE 0 TO H_total_pixels - 1 := 0;  --horizontal counter (counts the columns)
        VARIABLE vcount	:	INTEGER RANGE 0 TO V_total_pixels - 1 := 0;  --vertical counter (counts the rows)
        variable hcount_temp : integer;
    begin
        if rising_edge(Pixel_clk) then
            if (hcount >= 0) and (hcount < H_pixels) and (vcount >= 0) and (vcount < V_pixels) then
                if hcount >= (c_balk_width - 10) then
                    hcount_temp := c_balk_width - 30;
                else
                    hcount_temp := hcount;
                end if;
                
                notenbalk_addr <= std_logic_vector(to_unsigned(
                    ((vcount-((c_screen_height - c_balk_height)/2)) * c_balk_width) + hcount_temp
                ,notenbalk_addr'length));
                
                noot_addr <= std_logic_vector(to_unsigned(
                    ((vcount - note_height) * c_noot_width ) + (hcount - c_note_offset_x)
                ,noot_addr'length  ));
            
                sharp_addr <= std_logic_vector(to_unsigned(
                    (vcount - note_height - c_sharp_offset_y) * c_sharp_width + (hcount - c_sharp_offset_x)
                ,sharp_addr'length));
                
                flat_addr <= std_logic_vector(to_unsigned(
                    (vcount - note_height - c_flat_offset_y) * c_flat_width + (hcount - c_flat_offset_x)
                ,flat_addr'length));
                
                red <= "1111";
                green <= "1111";
                blue <= "1111";
                
                -- START DRAW NOTENBALK
                if vcount >= ((c_screen_height - c_balk_height)/2) and vcount < c_screen_height - ((c_screen_height - c_balk_height)/2) then
                    if notenbalk_data = '0' then
                        red <= "0000";
                        green <= "0000";
                        blue <= "0000";
                    end if;
                end if;
                -- END DRAW NOTENBALK
                
                -- START DRAW SHARPS AND FLATS
                if note_type(0) = '1' then
                    -- This note is a sharp
                    if vcount >= note_height + c_sharp_offset_y and vcount < note_height + c_sharp_height + c_sharp_offset_y
                    and hcount >= c_sharp_offset_x + 2 and hcount < c_sharp_offset_x + c_sharp_width + 2 then
                        if sharp_data = '0' then
                            red <= "0000";
                            green <= "0000";
                            blue <= "0000";
                        end if;
                    end if;
                elsif note_type(1) = '1' then
                    -- This note is a flat
                    if vcount >= note_height + c_flat_offset_y and vcount < note_height + c_flat_height + c_flat_offset_y
                    and hcount >= c_flat_offset_x + 2 and hcount < c_flat_offset_x + c_flat_width + 2 then
                        if flat_data = '0' then
                            red <= "0000";
                            green <= "0000";
                            blue <= "0000";
                        end if;
                    end if;
                end if;
                -- END DRAW SHARPS AND FLATS
                
                -- START DRAW NOTE
                if vcount >= note_height and vcount < note_height + c_noot_height and hcount >= c_note_offset_x + 2 and hcount < c_note_offset_x + c_noot_width + 2 then
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
                -- END DRAW NOTE
            else
                red <= "0000";
                green <= "0000";
                blue <= "0000";
            end if;
            
            -- START VGA
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
            -- END VGA
        end if;
    end process;
end Behavioral;
