library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Sensor_logic_unit is
    Port ( 
    enable_i     : in STD_LOGIC;
    CLK100MHZ    : in STD_LOGIC;
    sensi_i      : in natural;
    sensi_o      : out STD_LOGIC := '0';
    distance_o   : out std_logic_vector(4 - 1 downto 0) := "1111"
    );
end Sensor_logic_unit;

architecture Behavioral of Sensor_logic_unit is
    signal clk            : std_logic;
    signal s_count_local  : natural;
    
begin
    
    p_sensor_clok: process (CLK100MHZ)                 -- Creating freqency for distanc measuring
   
    begin
        if rising_edge(CLK100MHZ) then                 -- Synchronous process
            if (s_count_local >= (50000000 - 1)) then
                s_count_local <= 0;                    -- Clear local counter
                clk           <= '1';                  -- Generate clock enable pulse

            else
                s_count_local <= s_count_local + 1;
                clk           <= '0';
            end if;
        end if;
    end process p_sensor_clok;
    
    
    p_sensor_enable: process (clk, enable_i)           -- Clutch implementation 
                                                       -- Sensor works only if clutch activated - enable_i = 1
    begin
        if (enable_i = '1') then
            if (clk = '1') then
                sensi_o <= '1';                        -- Puls
            else
                sensi_o <= '0';
            end if;
        end if;    
    end process p_sensor_enable;
    
    
    p_sensor_logic: process (sensi_i)                   -- Clasifying to levels for other units to 10 levels
    
    begin
        if (sensi_i < 5) then
            report "Car is too close!";
        elsif ((sensi_i) <= 10) then
            distance_o <= "0000";
        elsif ((sensi_i) <= 20) then
            distance_o <= "0001";
        elsif ((sensi_i) <= 30) then
            distance_o <= "0010";
        elsif ((sensi_i) <= 40) then
            distance_o <= "0011";
        elsif ((sensi_i) <= 50) then
            distance_o <= "0100";
        elsif ((sensi_i) <= 60) then
            distance_o <= "0101";
        elsif ((sensi_i) <= 80) then
            distance_o <= "0110";
        elsif ((sensi_i) <= 100) then
            distance_o <= "0111";
        elsif ((sensi_i) <= 120) then
            distance_o <= "1000";
        elsif ((sensi_i) <= 150) then
            distance_o <= "1001";
        else
            report "Car is too far";    
        end if;
    end process p_sensor_logic;

end Behavioral;