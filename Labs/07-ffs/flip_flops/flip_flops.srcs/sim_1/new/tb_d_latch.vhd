----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:31:17 AM
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions:  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------
entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture Behavioral of tb_d_latch is
    signal s_en    : std_logic;
    signal s_arst  : std_logic;
    signal s_d     : std_logic;
    signal s_q     : std_logic;
    signal s_q_bar : std_logic;
    
begin
    uut_d_latch : entity work.d_latch
        port map(
            en    => s_en,
            arst  => s_arst,
            d     => s_d,
            q     => s_q,
            q_bar => s_q_bar
        );
        
    --------------------------------------------------------------------
    -- reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_arst <= '0'; wait for 60 ns;  
        s_arst <= '1'; wait for 5 ns;  --activate reset
        s_arst <= '0'; wait for 120 ns; --deactivate reset
        s_arst <= '1'; wait for 10 ns;
        s_arst <= '0'; wait for 60 ns;
        s_arst <= '1';
        
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- stimulus process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_en <= '0';
        s_d  <= '0';
        wait for 10 ns;
        
        -- d sequence
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        
        s_en <= '1'; wait for 3 ns;
        assert(s_q = '0' and s_q_bar = '1')
        report "Enable fault" severity error;
        wait for 7 ns;
        
        -- d sequence
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        
        s_en <= '0'; wait for 5 ns;
        assert(s_q = '1' and s_q_bar = '0')
        report "Hold failed " severity error;
        wait for 5 ns;
 
        -- d sequence
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        
        s_en <= '1'; wait for 10 ns;
        
        -- d sequence
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        s_d <= '1'; wait for 10 ns;
        s_d <= '0'; wait for 10 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
   
end Behavioral;
