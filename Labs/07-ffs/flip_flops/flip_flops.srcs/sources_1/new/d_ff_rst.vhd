----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2021 11:01:28 PM
-- Design Name: 
-- Module Name: d_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity d_ff_rst is
    Port ( 
        clk   : in STD_LOGIC;
        d     : in std_logic;
        rst   : in STD_LOGIC;
        q     : out STD_LOGIC;
        q_bar : out STD_LOGIC
        );
end d_ff_rst;

architecture Behavioral of d_ff_rst is
begin
    p_d_ff_rst : process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                q     <= '0';
                q_bar <= '1';
            else
                q     <= d;
                q_bar <= not d;
            end if;
        end if;
    end process p_d_ff_rst;
end Behavioral;