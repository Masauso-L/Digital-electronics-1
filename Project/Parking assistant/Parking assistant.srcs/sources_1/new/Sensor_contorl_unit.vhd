library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Sensor_control_unit is
    Port ( 
    CLK100MHZ    : in STD_LOGIC;
    puls_i       : in STD_LOGIC;
    echo_i       : in STD_LOGIC;
    trigger_o    : out STD_LOGIC;
    time_o       : out natural
    );
end Sensor_control_unit;

architecture Behavioral of Sensor_control_unit is
    signal s_count_local    : natural;
    signal s_time           : natural;
    signal local_reset      : std_logic;
    signal s_time_o         : natural;
    
begin
    sensor_puls: process (CLK100MHZ, puls_i)            -- Creating puls for sensor with 10us periode
    begin
        if rising_edge(CLK100MHZ) then                  -- Synchronous process
            if (puls_i = '1') then
                local_reset <= '1';
            end if;  
            if (local_reset = '1') then                 -- High active reset
                s_count_local <= 0;                     -- Clearing local counter
                trigger_o     <= '1';                   -- Genetating puls
                local_reset   <= '0';                   -- Finishing event
            elsif (s_count_local >= (1000 - 1)) then    -- 1000 clk = 10us
                -- s_count_local <= 0;                  -- Clearing local counter
                trigger_o      <= '0';                  -- End of pulse
            else
                s_count_local <= s_count_local + 1;
                -- trigger_o        <= '1';
            end if;
        end if;
    end process sensor_puls;
    
    
    echo_count: process (CLK100MHZ, echo_i)
    begin    
        if (echo_i = '1') then                          -- High active reset
            s_time   <= 0;                              -- Clearing local counter
            s_time_o <= 0;
            time_o   <= 0;
        else
            time_o <= s_time_o;
        end if;
        
        if rising_edge(CLK100MHZ) then                  -- Synchronous process
            if (s_time >= 5800-1) then
                s_time_o <= s_time_o + 1;
                -- time_o <= s_time_o;
                s_time <= 0; 
            else 
                s_time <= s_time + 1;
            end if;
        end if;
    end process echo_count;
end Behavioral;