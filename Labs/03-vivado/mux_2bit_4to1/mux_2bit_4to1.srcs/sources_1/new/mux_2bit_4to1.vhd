----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------
-- Entity declaration for 4-to-1 mux
----------------------------------------------------------------------------------
entity mux_2bit_4to1 is
    Port (
        a_i   : in  std_logic_vector(2-1 downto 0);
        b_i   : in  std_logic_vector(2-1 downto 0);
        c_i   : in  std_logic_vector(2-1 downto 0);
        d_i   : in  std_logic_vector(2-1 downto 0);
        sel_i : in  std_logic_vector(2-1 downto 0);
        f_o   : out std_logic_vector(2-1 downto 0) 
    
     );
end entity mux_2bit_4to1;

----------------------------------------------------------------------------------
-- Architecture body for 4-to-1 mux
----------------------------------------------------------------------------------
architecture Behavioral of mux_2bit_4to1 is
begin
    f_o <= a_i when (sel_i = "00") else
           b_i when (sel_i = "01") else
           c_i when (sel_i = "10") else
           d_i;
           
end Behavioral;
