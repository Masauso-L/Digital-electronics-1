library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity LED_bar_control_unit is
  Port (
  enable_i      : in   std_logic;
  distance_i    : in   std_logic_vector(4 - 1 downto 0);
  LED_bar_o     : out  std_logic_vector(10 - 1 downto 0)
  );
end LED_bar_control_unit;

architecture Behavioral of LED_bar_control_unit is

begin

    p_LED_bar :process(distance_i, enable_i)
    begin
        if (enable_i = '1')then
            case distance_i is
                when "0000" =>
                    -- 0,1m-0m all leds ON
                    LED_bar_o <= "1111111111";
                when "0001" =>
                    -- 0,2m-0,1m first red ON
                    LED_bar_o <= "1111111110";
                when "0010" =>
                    -- 0,3m-0,2m thirds yellow ON
                    LED_bar_o <= "1111111100";
                when "0011" =>
                    -- 0,4m-0,3m second yellow ON
                    LED_bar_o <= "1111111000";
                when "0100" =>
                    -- 0,5m-0,4m first yellow ON
                    LED_bar_o <= "1111110000";
                when "0101" =>
                    -- 0,6m-0,5 5th green ON
                    LED_bar_o <= "1111100000";
                when "0110" =>
                    -- 0,8m-0,6m 4th green ON
                    LED_bar_o <= "1111000000";
                when "0111" =>
                    -- 1m-0,8m thirds green ON
                    LED_bar_o <= "1110000000";
                when "1000" =>
                    -- 1,2m-1m second green ON
                    LED_bar_o <= "1100000000";
                when "1001" =>
                    -- 1,5m-1,2m first green ON
                    LED_bar_o <= "1000000000";
                when others =>
                    -- All leds OFF
                    LED_bar_o <= "0000000000";
            end case;
        else
            LED_bar_o <= "0000000000";
        end if;
    end process p_LED_bar;
end Behavioral;