library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Sensor_logic_unit is
end tb_Sensor_logic_unit;

architecture testbench of tb_Sensor_logic_unit is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    signal s_clk        : std_logic;
    signal s_enable     : std_logic;
    signal s_sensi_i    : natural;
    signal s_sensi_o    : std_logic;
    signal s_distance   : std_logic_vector(4 - 1 downto 0) := "1111";
    
begin
    uut_sensor : entity work.Sensor_logic_unit
    port map(
            CLK100MHZ   => s_clk,
            enable_i    => s_enable,
            sensi_i     => s_sensi_i,
            sensi_o     => s_sensi_o,
            distance_o  => s_distance
        );

    p_clok_gen : process
    begin
        while now < 2000000000 ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                                  -- Process is suspended forever
    end process p_clok_gen;
    
    p_enable : process
    begin
        s_enable <= '1'; 
        wait for 2000 ms;
        s_enable <= '0'; 
        wait;
    end process p_enable;
    
    p_tb_sensor_logic : process
    begin
        wait until (s_sensi_o = '1');
        s_sensi_i <= 130;
        wait until (s_sensi_o = '1');
        s_sensi_i <= 110;
        wait until (s_sensi_o = '1');
        s_sensi_i <= 90;
        wait until (s_sensi_o = '1');
        s_sensi_i <= 79;
        wait until (s_sensi_o = '1');
        s_sensi_i <= 50;
        wait until (s_sensi_o = '1');
        s_sensi_i <= 20;
    end process p_tb_sensor_logic;
end testbench;