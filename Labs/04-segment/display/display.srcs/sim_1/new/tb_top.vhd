----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Masauso Lungu
-- 
-- Create Date: 03/06/2021 10:29:20 PM
-- Design Name: 7 segment display
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---------------------------------------------------------------------------------
entity tb_top is
--  Port ( );
end tb_top;
---------------------------------------------------------------------------------

architecture Behavioral of tb_top is
    -- Local signals
    signal s_SW  : STD_LOGIC_VECTOR (3 downto 0);
    signal s_LED : STD_LOGIC_VECTOR (7 downto 0);
    signal s_CA  : STD_LOGIC;
    signal s_CB  : STD_LOGIC;
    signal s_CC  : STD_LOGIC;
    signal s_CD  : STD_LOGIC;
    signal s_CE  : STD_LOGIC;
    signal s_CF  : STD_LOGIC;
    signal s_CG  : STD_LOGIC;
    signal s_AN  : STD_LOGIC_VECTOR (7 downto 0);
  
 
begin
    -- Connecting testbench signals with mux_2bit_4to1 entity (Unit Under Test)
    uut_top : entity work.top
        port map(
            SW  => s_SW,
            LED => s_LED,
            CA  => s_CA,
            CB  => s_CB,
            CC  => s_CC,
            CD  => s_CD,
            CE  => s_CE,
            CF  => s_CF,
            CG  => s_CG,
            AN  => s_AN
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        s_SW <= "0000"; wait for 100 ns;
        s_SW <= "0001"; wait for 100 ns;
        s_SW <= "0010"; wait for 100 ns;
        s_SW <= "0011"; wait for 100 ns;
        s_SW <= "0100"; wait for 100 ns;
        s_SW <= "0101"; wait for 100 ns;
        s_SW <= "0110"; wait for 100 ns;
        s_SW <= "0111"; wait for 100 ns;
        s_SW <= "1000"; wait for 100 ns;
        s_SW <= "1001"; wait for 100 ns;
        s_SW <= "1010"; wait for 100 ns;
        s_SW <= "1011"; wait for 100 ns;
        s_SW <= "1100"; wait for 100 ns;
        s_SW <= "1101"; wait for 100 ns;
        s_SW <= "1110"; wait for 100 ns;
        s_SW <= "1111"; wait for 100 ns;
        
        s_AN <= b"1111_0111"; wait for 100 ns;
        
        s_LED(3 downto 0) <= s_SW; wait for 100 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;


end Behavioral;


