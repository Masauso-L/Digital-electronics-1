library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

entity tb_Sensor_control_unit is
--  Port ( );
end tb_Sensor_control_unit;

architecture testbench of tb_Sensor_control_unit is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    -- Local signals    
    signal s_clk        : std_logic;
    signal s_puls       : std_logic;
    signal s_echo       : std_logic := '0';
    signal s_trigger    : std_logic;
    signal s_time_o     : natural;
     
begin
    uut_Sensor_control_unit : entity work.Sensor_control_unit
    port map(
            CLK100MHZ    => s_clk,
            puls_i       => s_puls,
            echo_i       => s_echo,
            trigger_o    => s_trigger,
            time_o       => s_time_o
        );
        
        
    p_clk_gen : process
   
    begin
        while now < 2000000000 ns loop          -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                                   -- Process is suspended forever
    end process p_clk_gen;
    
    p_sensor_puls : process
    begin
        while now < 2000000000 ns loop          -- 75 periods of 100MHz clock
            s_puls <= '0';
            wait for 50ns;
            s_puls <= '1';
            wait for (20ms - 50ns);
        end loop;
        wait;                                   -- Process is suspended forever
    end process p_sensor_puls;
    
    p_sensor_echo : process
    variable seed1, seed2: positive;              -- Values for random generator
    variable rand: real;                          -- Random real-number value in range 0 to 1,5m  
    variable range_of_rand : real := 600000.0;    -- The range of random created values will be by 0 to +1000
   
    begin
        wait until (s_puls = '1');
        wait for 7540 us; -- 130cm
        s_echo <= '1';
        wait for 7540 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 6902 us; -- 119cm
        s_echo <= '1';
        wait for 6902 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 6090 us; -- 105cm
        s_echo <= '1';
        wait for 6090 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 5510 us; -- 95cm
        s_echo <= '1';
        wait for 5510 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 4582 us; -- 79cm
        s_echo <= '1';
        wait for 4582 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 3480 us; -- 60cm
        s_echo <= '1';
        wait for 3480 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 2262 us; -- 39cm
        s_echo <= '1';
        wait for 2262 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 1682 us; -- 29cm
        s_echo <= '1';
        wait for 1682 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 1102 us; -- 19cm
        s_echo <= '1';
        wait for 1102 us;
        s_echo <= '0';
        wait until (s_puls = '1');
        wait for 522 us; -- 9cm
        s_echo <= '1';
        wait for 522 us;
        s_echo <= '0';
        
        wait;
    end process p_sensor_echo;
end testbench;