----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2021 03:01:02 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW      : in std_logic_vector(1 downto 0);
           BTNC    : in STD_LOGIC;
           LED16_R : out STD_LOGIC;
           LED16_G : out STD_LOGIC;
           LED16_B : out STD_LOGIC;
           LED17_R : out STD_LOGIC;
           LED17_G : out STD_LOGIC;
           LED17_B : out STD_LOGIC);
end top;

architecture Behavioral of top is

begin

    smart_tlc : entity work.smat_tlc
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            
            sensor1     =>  SW(0),
            sensor2     =>  SW(1),
            
            south_o(0)  => LED16_B,
            south_o(1)  => LED16_G,
            south_o(2)  => LED16_R,
            
            west_o(0)   => LED17_B,
            west_o(1)   => LED17_G,
            west_o(2)   => LED17_R
        );

end Behavioral;
