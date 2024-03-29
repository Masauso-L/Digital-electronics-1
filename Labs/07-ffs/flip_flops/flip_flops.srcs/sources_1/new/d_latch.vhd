----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:18:13 AM
-- Design Name: 
-- Module Name: d_latch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

----------------------------------------------------------------------------------
-- Entity declaration of d_latch
----------------------------------------------------------------------------------
entity d_latch is
    Port (
         en    : in STD_LOGIC;
         d     : in STD_LOGIC;
         arst  : in STD_LOGIC;
         q     : out STD_LOGIC;
         q_bar : out STD_LOGIC);
end d_latch;

-----------------------------------------------------------------------------------
-- Architecture behaviour of d_latch
-----------------------------------------------------------------------------------
architecture Behavioral of d_latch is

begin
    p_d_latch :process(en, d, arst)
    begin
        if (arst = '1') then 
            q     <= '0';
            q_bar <= '1';
        elsif (en = '1') then
            q     <= d;
            q_bar <= not d;
        end if;
        
    end process p_d_latch;      
    
end Behavioral;
