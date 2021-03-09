----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2021 05:43:32 PM
-- Design Name: 
-- Module Name: tb_hex_7seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------
entity tb_hex_7seg is
--  Port ( );
end tb_hex_7seg;
---------------------------------------------------------------------------------

architecture Behavioral of tb_hex_7seg is
    -- Local signals
    signal s_hex     : std_logic_vector(4 - 1 downto 0);
    signal s_seg     : std_logic_vector(7 - 1 downto 0);
  
begin
    -- Connecting testbench signals with hex_7seg entity (Unit Under Test)
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i     => s_hex,
            seg_o     => s_seg
          
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        s_hex <= "0000"; wait for 100 ns;
        -- Expected output 0
        assert (s_seg = b"0000001")
        -- If false, then report an error
        report "Test failed for input combination: 0000" severity error;
        
        s_hex <= "0001"; wait for 100 ns;
        -- Expected output 1
        assert (s_seg = b"1001111")
        -- If false, then report an error
        report "Test failed for input combination: 0001" severity error;
        
        s_hex <= "0010"; wait for 100 ns;
        -- Expected output 2
        assert (s_seg = b"0010010")
        -- If false, then report an error
        report "Test failed for input combination: 0010" severity error;
        
        s_hex <= "0011"; wait for 100 ns;
        -- Expected output 3
        assert (s_seg = b"0000110")
        -- If false, then report an error
        report "Test failed for input combination: 0011" severity error;
        
        s_hex <= "0100"; wait for 100 ns;
        -- Expected output
        assert (s_seg = b"1001100")
        -- If false, then report an error
        report "Test failed for input combination: 0100" severity error;
        
        s_hex <= "0101"; wait for 100 ns;
        -- Expected output 5
        assert (s_seg = b"0100100")
        -- If false, then report an error
        report "Test failed for input combination: 0101" severity error;
        
        s_hex <= "0110"; wait for 100 ns;
        -- Expected output 6
        assert (s_seg = b"0100000")
        -- If false, then report an error
        report "Test failed for input combination: 0110" severity error;
        
        s_hex <= "0111"; wait for 100 ns;
        -- Expected output 7
        assert (s_seg = b"0001111")
        -- If false, then report an error
        report "Test failed for input combination: 0111" severity error;
        
        s_hex <= "1000"; wait for 100 ns;
        -- Expected output 8
        assert (s_seg = b"0000000")
        -- If false, then report an error
        report "Test failed for input combination: 1000" severity error;
        
        s_hex <= "1001"; wait for 100 ns;
        -- Expected output 9
        assert (s_seg = b"0000100")
        -- If false, then report an error
        report "Test failed for input combination: 1001" severity error;
        
        s_hex <= "1010"; wait for 100 ns;
        -- Expected output A
        assert (s_seg = b"0001000")
        -- If false, then report an error
        report "Test failed for input combination: 1010" severity error;
        
        s_hex <= "1011"; wait for 100 ns;
        -- Expected output b
        assert (s_seg = b"1100000")
        -- If false, then report an error
        report "Test failed for input combination: 1011" severity error;
        
        s_hex <= "1100"; wait for 100 ns;
        -- Expected output C
        assert (s_seg = b"0110001")
        -- If false, then report an error
        report "Test failed for input combination: 1100" severity error;
        
        s_hex <= "1101"; wait for 100 ns;
        -- Expected output d
        assert (s_seg = b"1000010")
        -- If false, then report an error
        report "Test failed for input combination: 1101" severity error;
        
        s_hex <= "1110"; wait for 100 ns;
        -- Expected output E
        assert (s_seg = b"0110000")
        -- If false, then report an error
        report "Test failed for input combination: 1110" severity error;
        
        s_hex <= "1111"; wait for 100 ns;
        -- Expected output F
        assert (s_seg = b"0111000")
        -- If false, then report an error
        report "Test failed for input combination: 1111" severity error;
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;


end Behavioral;
