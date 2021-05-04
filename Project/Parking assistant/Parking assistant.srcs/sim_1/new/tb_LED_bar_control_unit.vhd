library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_LED_bar_control_unit is
--  Port ( );
end tb_LED_bar_control_unit;

architecture Behavioral of tb_LED_bar_control_unit is

    signal s_distance       : std_logic_vector(4 - 1 downto 0);
    signal s_enable         : std_logic;
    signal s_LED_bar        : std_logic_vector(10 - 1 downto 0);
    
begin

    uut_LED_bar : entity work.LED_bar_control_unit
        port map(
            distance_i      => s_distance,
            enable_i        => s_enable,
            LED_bar_o       => s_LED_bar
            );
            
    p_stimulus : process
    begin
        report "Stimulus process started correctly" severity note;
        s_enable <= '1';
        -- 1,5m-1,2m
        s_distance <= "1001";
        wait for 100ns;
        -- 1,2m-1m
        s_distance <= "1000";
        wait for 100ns;
        -- 1m-0,8m
        s_distance <= "0111";
        wait for 100ns;
        -- 0,8m-0,6m
        s_distance <= "0110";
        wait for 100ns;
        -- 0,6m-0,5m
        s_distance <= "0101";
        wait for 100ns;
        -- 0,5m-0,4m
        s_distance <= "0100";
        wait for 100ns;
        -- 0,4m-0,3m
        s_distance <= "0011";
        wait for 100ns;
        -- 0,3m-0,2m
        s_distance <= "0010";
        wait for 100ns;
        -- 0,2m-0,1m
        s_distance <= "0001";
        wait for 100ns;
        -- 0,1m-0m
        s_distance <= "0000";
        wait for 100ns;
        
        -- Sensor disabled
        s_enable <= '0';
        -- 0,3m-0,2m
        s_distance <= "0010";
        wait for 100ns;
        -- 0,2m-0,1m
        s_distance <= "0001";
        wait for 100ns;
        -- 0,1m-0m
        s_distance <= "0000";
        wait for 100ns;
        
        report "Stimulus process finished correctly" severity note;
        wait;
        
    end process p_stimulus;
end Behavioral;