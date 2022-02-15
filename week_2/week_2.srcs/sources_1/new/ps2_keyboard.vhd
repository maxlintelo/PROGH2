library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ps2_keyboard is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        ps2_data : in STD_LOGIC;
        ps2_clk : in STD_LOGIC;
        new_data : out STD_LOGIC;
        data : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ps2_keyboard;

architecture behavioral of ps2_keyboard is
    -- State machine
    type state_t is (waiting, busy, done);
    signal current_state : state_t;
    signal next_state: state_t;
    
    -- Counters
    signal current_counter : UNSIGNED(3 downto 0);
    signal next_counter : UNSIGNED(3 downto 0);
    
    -- Data
    signal current_buffer : STD_LOGIC_VECTOR(10 downto 0);
    signal next_buffer : STD_LOGIC_VECTOR(10 downto 0);
    
    -- Meta fix
    signal ps2_meta_fix : STD_LOGIC_VECTOR(1 downto 0);
begin
    -- Meta fix 2 ffs
    edge_detector: process(clk, reset)
    begin
        if reset = '1' then
            ps2_meta_fix <= (others => '0');
        elsif rising_edge(clk) then
            ps2_meta_fix <= ps2_meta_fix(0) & ps2_clk;
        end if;
    end process;

    -- Update variables on clock or reset
    clk_process: process(clk, reset)
    begin
        if reset = '1' then
            current_state <= waiting;
            current_buffer <= (others => '0');
            current_counter <= (others => '0');
        elsif rising_edge(clk) then
            current_state <= next_state;
            current_buffer <= next_buffer;
            current_counter <= next_counter;
        end if;
    end process;
    
    -- State machine process
    state_machine: process(current_state, ps2_meta_fix, ps2_data, current_buffer, current_counter)
    begin
        -- setting default values
        next_state <= current_state;
        next_buffer <= current_buffer;
        next_counter <= current_counter;
        new_data <= '0';
        
        case (current_state) is
            -- waiting for falling edge and start bit
            when waiting =>
                if ps2_meta_fix(1) = '1' and ps2_meta_fix(0) = '0' and ps2_data = '0' then
                    next_state <= busy;
                    next_counter <= "1001"; -- 9 bits to go
                    
                    -- loading bits into buffer
                    next_buffer <= ps2_data & current_buffer(10 downto 1);
                end if;
            -- receiving bits
            when busy =>
                if ps2_meta_fix(1) = '1' and ps2_meta_fix(0) = '0' then
                    -- loading bits into buffer
                    next_buffer <= ps2_data & current_buffer(10 downto 1);
                    
                    -- simple counter
                    if current_counter = 0 then
                        next_state <= done;
                    else
                        next_counter <= current_counter - 1;
                    end if;
                end if;
            -- end of transmission
            when done =>
                next_state <= waiting;
                new_data <= '1';
        end case;
    end process;
    
    data <= current_buffer(8 downto 1); -- output from shift register
end behavioral;
