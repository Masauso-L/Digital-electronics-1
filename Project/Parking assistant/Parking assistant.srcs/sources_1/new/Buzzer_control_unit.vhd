library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Buzzer_control_unit is
    Port ( 
    enable_i            : in   std_logic;
    CLK100MHZ           : in   std_logic;
    distance_i          : in   std_logic_vector(4 - 1 downto 0);
    buzzer_o            : out  std_logic
    );
end Buzzer_control_unit;

architecture Behavioral of Buzzer_control_unit is
---------------------------------------------------
-- internal signals 
signal clk              : std_logic;
signal s_buzzer         : std_logic;
signal s_counter_clk    : natural;
signal s_counter        : natural :=0;


begin

    p_clk: process (CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            if (s_counter_clk >= 10) then
                s_counter_clk <=  0;
                clk           <= '1';
            else
                s_counter_clk <= s_counter_clk + 1;
                clk           <= '0';
            end if;
        end if;
    end process p_clk;
    
    p_buzzer : process(clk)
    begin
            if (enable_i = '1')then
                case distance_i is
                    -- 0m-0,1m
                    when "0000" =>
                        buzzer_o <= '1';
                    -- 0,1m-0,2m
                    when "0001" =>
                    if rising_edge(clk)then
                        if (s_counter >= 1) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,2m-0,3m
                    when "0010" =>
                    if rising_edge(clk)then
                        if (s_counter >= 2) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,3m-0,4m
                    when "0011" =>
                    if rising_edge(clk)then
                        if (s_counter >= 3) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,4m-0,5m
                    when "0100" =>
                    if rising_edge(clk)then
                        if (s_counter >= 4) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,5m-0,6m
                    when "0101" =>
                    if rising_edge(clk)then
                        if (s_counter >= 5) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,6m-0,8m
                    when "0110" =>
                    if rising_edge(clk)then
                        if (s_counter >= 6) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 0,8m-1m
                    when "0111" =>
                    if rising_edge(clk)then
                        if (s_counter >= 7) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 1m-1,2m
                    when "1000" =>
                    if rising_edge(clk)then
                        if (s_counter >= 8) then
                            s_counter <= 0;       
                            buzzer_o  <= '1'; 
                        else
                            s_counter <= s_counter + 1;
                            buzzer_o  <= '0';
                        end if;
                    end if;
                    -- 1,2m-1,5m
                    when others =>
                        buzzer_o <= '0';
                end case;
            else
                buzzer_o <= '0';
            end if;
    end process p_buzzer;    
end Behavioral;