library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Buzzer_control_unit is

end tb_Buzzer_control_unit;

architecture Behavioral of tb_Buzzer_control_unit is

    constant clk_period     : time :=10ms;
    
    signal s_clk            : std_logic;
    signal s_enable         : std_logic;
    signal s_distance       : std_logic_vector(4 - 1 downto 0);
    signal s_pwm            : std_logic;
    
begin
    
    uut_Buzzer_control_unit : entity work.Buzzer_control_unit
        port map(
            CLK100MHZ     => s_clk,
            enable_i      => s_enable,
            distance_i    => s_distance,
            buzzer_o      => s_pwm
        );
        
    p_clk : process
    begin
        while now < 46000 ms loop         
            s_clk <= '0';
            wait for clk_period / 2;
            s_clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process p_clk;
    
    p_test : process
    begin
        s_enable   <= '1';
        -- 1,5m-1,2m
        s_distance <= "1001";
        wait for 2000ms;
        -- 1,2m-1m
        s_distance <= "1000";
        wait for 2000ms;
        -- 1m-0,8m
        s_distance <= "0111";
        wait for 2000ms;
        -- 0,8m-0,6m
        s_distance <= "0110";
        wait for 2000ms;
        -- 0,6m-0,5m
        s_distance <= "0101";
        wait for 2000ms;
        -- 0,5m-0,4m
        s_distance <= "0100";
        wait for 2000ms;
        -- 0,4m-0,3m
        s_distance <= "0011";
        wait for 2000ms;
        -- 0,3m-0,2m
        s_distance <= "0010";
        wait for 2000ms;
        -- 0,2m-0,1m
        s_distance <= "0001";
        wait for 2000ms;
        -- 0,1m-0m
        s_distance <= "0000";
        wait for 2000ms;
        -- 1m-0,8m
        s_distance <= "0001";
        wait for 2000ms;
        -- 1,2m-1m
        s_distance <= "0010";
        wait for 2000ms;
        -- 1,4m-1,2m
        s_distance <= "0011";
        wait for 2000ms;
        -- 1,6m-1,4m
        s_distance <= "0100";
        wait for 2000ms;
        -- 1,4m-1,6m
        s_distance <= "0101";
        wait for 2000ms;
        -- 1,6m-1,8m
        s_distance <= "0110";
        wait for 2000ms;
        -- 2m-1,8m
        s_distance <= "0111";
        wait for 2000ms;
        -- 2,2m-2m
        s_distance <= "1000";
        wait for 2000ms;
        -- 3m-2,4m
        s_distance <= "1001";
        wait for 2000ms;
        s_enable       <= '0';
        -- 2,4-2,2m
        s_distance <= "1000";
        wait for 2000ms;
        -- 2,2m-2m
        s_distance <= "0111";
        wait for 2000ms;
        -- m-m
        s_distance <= "0110";
        wait;
    end process p_test;
end Behavioral;