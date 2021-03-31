----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2021 08:40:24 PM
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

----------------------------------------------------------------------------------
entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is
    
    constant c_CLK_100MHZ_PERIOD : time := 10ns;
    signal s_clk   : std_logic;
    signal s_arst  : std_logic;
    signal s_d     : std_logic;
    signal s_q     : std_logic;
    signal s_q_bar : std_logic;
    
begin
    uut_d_ff_arst : entity work.d_ff_arst
        port map(
            clk   => s_clk,
            arst  => s_arst,
            d     => s_d,
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
        s_arst <= '0'; wait for 13 ns;  
        s_arst <= '1'; wait for 5 ns;   --activate reset
        s_arst <= '0'; wait for 120 ns; --deactivate reset
        s_arst <= '1'; wait for 15 ns;
        s_arst <= '0'; wait for 60 ns;
        s_arst <= '1'; wait for 20 ns;
        s_arst <= '0';
        
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- stimulus process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d <= '0'; wait for 10 ns;
        
        -- d sequence
        s_d <= '1'; wait for 30 ns;
        s_d <= '0'; wait for 20 ns;
        s_d <= '1'; wait for 20 ns;
        s_d <= '0'; wait for 30 ns;
        s_d <= '1'; wait for 30 ns;
        s_d <= '0'; wait for 20 ns;
        s_d <= '1'; wait for 20 ns;
        s_d <= '0'; wait for 30 ns;
        s_d <= '1'; wait for 20 ns;
        s_d <= '0'; wait for 30 ns;
        s_d <= '1'; wait for 30 ns;
        s_d <= '0'; wait for 20 ns;
        
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;
