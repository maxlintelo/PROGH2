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
        hsync, vsync : out STD_LOGIC
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
    
    constant H_pixels: integer := 1920;			--horizontal display width in pixels
    constant H_frontporch: integer := 88;			--horizontal front porch width in pixels
    constant H_syncwidth: integer := 44; 			--horizontal sync pulse width in pixels
    constant H_backporch: integer := 148;			--horizontal back porch width in pixels
    constant H_total_pixels: integer := (H_pixels + H_frontporch + H_syncwidth + H_backporch);
    constant H_sync_polarity: STD_LOGIC := '1';	--horizontal sync pulse polarity (1 = positive, 0 = negative)
    constant V_pixels: integer := 1080;			--vertical display width in rows
    constant V_frontporch: integer := 4;			--vertical front porch width in rows
    constant V_syncwidth: integer := 5;			--vertical sync pulse width in rows
    constant V_backporch: integer := 36;			--vertical back porch width in rows
    constant V_total_pixels: integer := (V_pixels + V_frontporch + V_syncwidth + V_backporch);
    constant V_sync_polarity: STD_LOGIC := '1';	--vertical sync pulse polarity (1 = positive, 0 = negative)
    
    signal notenbalk_addr : std_logic_vector(19 downto 0);
    signal notenbalk_data : std_logic;
begin
    my_notenbalk : blk_mem_notenbalk port map (
        clka => Pixel_clk,
        ena => '1',
        addra => notenbalk_addr,
        douta(0) => notenbalk_data
    );
    process (Pixel_clk) is
        VARIABLE hcount	:	INTEGER RANGE 0 TO H_total_pixels - 1 := 0;  --horizontal counter (counts the columns)
        VARIABLE vcount	:	INTEGER RANGE 0 TO V_total_pixels - 1 := 0;  --vertical counter (counts the rows)
        variable hcount_temp : integer;
    begin
        if rising_edge(Pixel_clk) then
            notenbalk_addr <= std_logic_vector(to_unsigned((((vcount-((screen_height - balk_height)/2)) * balk_width) + hcount_temp), notenbalk_addr'length));
            -- Standard blanking
            red <= "0000";
            green <= "0000";
            blue <= "0000";
            
            -- Display time
            if (hcount >= 0) and (hcount < H_pixels) and (vcount >= 0) and (vcount < V_pixels) then	
                if hcount >= balk_width then
                    hcount_temp := balk_width - 30;
                else
                    hcount_temp := hcount;
                end if;
                if vcount > ((screen_height - balk_height)/2) then
                    if notenbalk_data = '1' then
                    --if balk((balk_width * balk_height)-(((vcount-((screen_height - balk_height)/2)) * balk_width) + hcount_temp)) = '1' then
                        red <= "1111";
                        green <= "1111";
                        blue <= "1111";
                    end if;
                end if;
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

