----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2021 02:15:32 AM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
entity top is
    Port ( BTNU : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           SW   : in STD_LOGIC_VECTOR (1-1 downto 0);
           LED  : OUT STD_LOGIC_VECTOR (4-1 downto 0)
           );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

    -- Internal signals between flip-flops
    signal s_LED : std_logic_vector( 4-1 downto 0);
begin
     LED <= s_LED;
    --------------------------------------------------------------------
    -- Four instances (copies) of D type FF entity
    d_ff_0 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d => SW(0),
            q => s_LED(0)
            );

    d_ff_1 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d => s_LED(0),
            q => s_LED(1)
            );

    -- WRITE YOUR CODE HERE
    d_ff_2 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d => s_LED(1),
            q => s_LED(2)
            );

    d_ff_3 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d => s_LED(2),
            q => s_LED(3)
            );
     LED(0) <= s_LED(0);
     LED(1) <= s_LED(1);
     LED(2) <= s_LED(2);
     LED(3) <= s_LED(3);
 
end Behavioral;
