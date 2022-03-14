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
        top_pwm : out std_logic
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
            frequency : in integer;
            pwm : out std_logic
        );
    end component pwm_sound;
    
    signal microblaze_i : std_logic_vector(31 downto 0);
    signal microblaze_o : std_logic_vector(31 downto 0);
begin
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
        ps2_data => top_ps2_data,
        ps2_clk => top_ps2_clk,
        data => microblaze_i(31 downto 24),
        new_data => microblaze_i(0)
    );
    my_sound : pwm_sound port map (
        clk => sys_clock,
        reset => top_reset,
        frequency => 523,
        pwm => top_pwm
    );
end Behavioral;
