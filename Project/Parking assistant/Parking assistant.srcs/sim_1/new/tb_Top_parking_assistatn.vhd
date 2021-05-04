----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

 

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

 

entity tb_top is
--  Port ( );
end tb_top;

 

architecture Behavioral of tb_top is
    constant c_CLK100MHZ : time :=10 ns;  -- period of the fpga
    
    signal s_clk     : std_logic;
    signal s_sw      : std_logic;
    --signal s_btn     : std_logic_vector(1-1 downto 0);
    signal s_echo    : std_logic;
    signal s_ck_io   : std_logic_vector(10-1 downto 0);
    signal s_trigger : std_logic;
    signal s_buzzer  : std_logic;
    

 

begin
    uut_top : entity work.Top_parking_assistant
        port map(
            CLK100MHZ => s_clk,
            SW        => s_sw,
            --BTN(0)    => s_btn(0),
            echo      => s_echo,
            ck_io     => s_ck_io,
            trigger   => s_trigger,
            Buzzer    => s_buzzer
            );
    
    p_clk_gen : process
    begin 
        while now < 10000 ms loop
            s_clk <= '0';
            wait for c_CLK100MHZ / 2;
            s_clk <= '1';
            wait for c_CLK100MHZ / 2;
            
        end loop;
        wait;
    end process p_clk_gen;
    
     p_stimulus : process
    begin
        s_sw <= '1';
        wait;       
    end process p_stimulus;
            
end Behavioral;