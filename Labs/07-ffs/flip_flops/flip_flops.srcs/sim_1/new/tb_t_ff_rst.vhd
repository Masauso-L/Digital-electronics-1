----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2021 11:09:36 PM
-- Design Name: 
-- Module Name: tb_t_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10ns;
    signal s_clk   : std_logic;
    signal s_rst   : std_logic;
    signal s_t     : std_logic;
    signal s_q     : std_logic;
    signal s_q_bar : std_logic;

begin
    uut_t_ff_rst : entity work.t_ff_rst
        port map(
            clk   => s_clk,
            rst   => s_rst,
            t     => s_t,
            q     => s_q,
            q_bar => s_q_bar
        );
        
    --------------------------------------------------------------------
    -- clock generation process
    --------------------------------------------------------------------    
    p_clk_gen : process
    begin
        while now < 400 ns loop
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
   
    --------------------------------------------------------------------
    -- reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst <= '0'; wait for 13 ns;  
        s_rst <= '1'; wait for 5 ns;   --activate reset
        s_rst <= '0'; wait for 120 ns; --deactivate reset
        s_rst <= '1'; wait for 15 ns;
        s_rst <= '0'; wait for 60 ns;
        s_rst <= '1'; wait for 20 ns;
        s_rst <= '0';
        
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- stimulus process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        -- t sequence
        s_t <= '0'; wait for 30 ns;
        s_t <= '1'; wait for 30 ns;
        s_t <= '0'; wait for 30 ns;
        s_t <= '1'; wait for 30 ns;
        s_t <= '0'; wait for 30 ns;
        s_t <= '1'; wait for 30 ns;
        s_t <= '0'; wait for 30 ns;
        s_t <= '1'; wait for 30 ns;
        s_t <= '0'; wait for 30 ns;
        s_t <= '1'; wait for 30 ns;
     
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
