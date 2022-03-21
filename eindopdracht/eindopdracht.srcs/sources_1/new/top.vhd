library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    port (
        sys_clock : in std_logic;
        top_reset : in std_logic;
        top_switches : in std_logic_vector(15 downto 0);
        top_leds : out std_logic_vector(15 downto 0);
        top_uart_rx : in std_logic;
        top_uart_tx : out std_logic;
        top_ps2_data : in std_logic;
        top_ps2_clk : in std_logic;
        top_pwm : out std_logic;
        top_vga_r : inout STD_LOGIC_VECTOR (3 downto 0);
        top_vga_g : inout STD_LOGIC_VECTOR (3 downto 0);
        top_vga_b : inout STD_LOGIC_VECTOR (3 downto 0);
        top_vga_h_sync : inout STD_LOGIC;
        top_vga_v_sync : inout STD_LOGIC
    );
end top;

architecture Behavioral of top is
    component microblaze_wrapper is
        port (
            GPIO2_0_tri_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
            GPIO_0_tri_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
            dip_switches_16bits_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
            led_16bits_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
            reset : in STD_LOGIC;
            sys_clock : in STD_LOGIC;
            usb_uart_rxd : in STD_LOGIC;
            usb_uart_txd : out STD_LOGIC
        );
    end component microblaze_wrapper;
    component ps2_keyboard is
        port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            reset_new_data : in std_logic;
            ps2_data : in STD_LOGIC;
            ps2_clk : in STD_LOGIC;
            new_data : out STD_LOGIC;
            data : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component ps2_keyboard;
    component pwm_sound is
        port (
            clk : in std_logic;
            reset : in std_logic;
            note : in integer;
            accidental : in std_logic_vector(1 downto 0);
            pwm : out std_logic;
            enabled : in std_logic
        );
    end component pwm_sound;
    component vga_controller is
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
    end component vga_controller;
    component clk_wiz_vga is
        port ( 
            clk_out1 : out STD_LOGIC;
            reset : in STD_LOGIC;
            locked : out STD_LOGIC;
            clk_in1 : in STD_LOGIC
        );
    end component clk_wiz_vga;
    
    signal microblaze_i : std_logic_vector(31 downto 0);
    signal microblaze_o : std_logic_vector(31 downto 0);
    
    signal vga_clock : std_logic;
    
    signal s_pwm : std_logic;

begin
    my_vga_clk : clk_wiz_vga port map (
        clk_out1 => vga_clock,
        reset => top_reset,
        clk_in1 => sys_clock
    );
    my_vga : vga_controller port map (
        clk => sys_clock,
        pixel_clk => vga_clock,
        hsync => top_vga_h_sync,
        vsync => top_vga_v_sync,
        red => top_vga_r,
        green => top_vga_g,
        blue => top_vga_b,
        note_height => to_integer(unsigned(microblaze_o(15 downto 0))),
        note_color => microblaze_o(25 downto 24),
        note_type => microblaze_o(23 downto 22)
    );
    
    my_microblaze : microblaze_wrapper port map (
        GPIO2_0_tri_o => microblaze_o,
        GPIO_0_tri_i => microblaze_i,
        dip_switches_16bits_tri_i => top_switches,
        led_16bits_tri_o => top_leds,
        reset => top_reset,
        sys_clock => sys_clock,
        usb_uart_rxd => top_uart_rx,
        usb_uart_txd => top_uart_tx
    );
    
    my_keyboard : ps2_keyboard port map (
        clk => sys_clock,
        reset => top_reset,
        reset_new_data => microblaze_o(16),
        ps2_data => top_ps2_data,
        ps2_clk => top_ps2_clk,
        data => microblaze_i(31 downto 24),
        new_data => microblaze_i(0)
    );
    my_sound : pwm_sound port map (
        clk => sys_clock,
        reset => top_reset,
        note => to_integer(unsigned(microblaze_o(31 downto 28))),
        accidental => microblaze_o(27 downto 26),
        pwm => s_pwm,
        enabled => microblaze_o(17)
    );
    top_pwm <= s_pwm when top_switches(0) = '1' else '0';
end Behavioral;
