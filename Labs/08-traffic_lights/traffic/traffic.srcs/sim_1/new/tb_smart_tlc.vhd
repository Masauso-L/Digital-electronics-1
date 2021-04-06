----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2021 10:52:39 PM
-- Design Name: 
-- Module Name: tb_smart_tlc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity tb_smart_tlc is
--  Port ( );
end tb_smart_tlc;

architecture testbench of tb_smart_tlc is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_sensor1    : std_logic;
    signal s_sensor2    : std_logic;
    signal s_south      : std_logic_vector(3 - 1 downto 0);
    signal s_west       : std_logic_vector(3 - 1 downto 0);

begin
    -- Connecting testbench signals with tlc entity (Unit Under Test)
    uut_tlc : entity work.smat_tlc
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            sensor1 => s_sensor1,
            sensor2 => s_sensor2,
            south_o => s_south,
            west_o  => s_west
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop   -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- No input data needed.
        wait;
    end process p_stimulus;
    --------------------------------------------------------------------
    -- configuring sensors
    --------------------------------------------------------------------
    p_sensors : process
    begin
        wait for 500 ns;
        s_sensor1 <= '1'; 
        s_sensor2 <= '0';
        wait for 1000 ns; 
        s_sensor2 <= '1';
        wait for 1000 ns;
        s_sensor1 <= '0'; 
        wait for 1000 ns;
        s_sensor2 <= '0'; 
        wait for 1000 ns;
        
        --wait;
    end process p_sensors;
    

end testbench;
