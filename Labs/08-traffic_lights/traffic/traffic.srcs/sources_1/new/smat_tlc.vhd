----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2021 10:35:29 PM
-- Design Name: 
-- Module Name: smat_tlc - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity smat_tlc is
    Port ( clk     : in STD_LOGIC;
           reset   : in STD_LOGIC;
           sensor1 : in STD_LOGIC; -- sensor monitoring cars on south route
           sensor2 : in STD_LOGIC; -- sensor monitoring on west route
           south_o : out STD_LOGIC_VECTOR (2 downto 0);
           west_o  : out STD_LOGIC_VECTOR (2 downto 0));
end smat_tlc;

architecture Behavioral of smat_tlc is
    
    -- Define the states
    type   t_state is (STOP1, WEST_GO,  WEST_WAIT,
                       STOP2, SOUTH_GO, SOUTH_WAIT);
    -- Define the signal that uses different states
    signal s_state  : t_state;

    -- Internal clock enable
    signal s_en   : std_logic;
    -- Local delay counter
    signal s_cnt  : unsigned(5 - 1 downto 0);

    -- Specific values for local counter
    constant c_DELAY_4SEC : unsigned(5 - 1 downto 0) := b"1_0000";
    constant c_DELAY_2SEC : unsigned(5 - 1 downto 0) := b"0_1000";
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100";
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). Remember that the frequency of the clock 
    -- signal is 100 MHz.
    
    -- JUST FOR SHORTER/FASTER SIMULATION
    s_en <= '1';
    --    clk_en0 : entity work.clock_enable
    --        generic map(
    --            g_MAX =>        -- g_MAX = 250 ms / (1/100 MHz)
    --        )
    --        port map(
    --            clk   => clk,
    --            reset => reset,
    --            ce_o  => s_en
    --        );

    --------------------------------------------------------------------
    -- p_smart_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_smart_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                           s_cnt <= s_cnt +1;
                        else
                            if((sensor1='0' and sensor2='0') or(sensor1='0' and sensor2='1')) then
                                s_state <= WEST_GO;
                                s_cnt <= c_ZERO;
                            else
                                s_state <= WEST_WAIT;
                            end if;
                        end if;
                    when WEST_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                           s_cnt <= s_cnt +1;
                        else
                           s_state <= STOP2;
                           s_cnt <= c_ZERO;
                        end if;
                    when STOP2 =>
                        if(s_cnt < c_DELAY_1SEC) then
                           s_cnt <= s_cnt +1;
                        else
                           s_state <= SOUTH_GO;
                           s_cnt <= c_ZERO;
                        end if;
                    when SOUTH_GO =>
                        if(s_cnt < c_DELAY_4SEC) then
                           s_cnt <= s_cnt +1;
                        else
                            if((sensor1='0' and sensor2='0') or(sensor1='1' and sensor2='0')) then
                                s_state <= SOUTH_GO;
                                s_cnt   <= c_ZERO;
                            else
                                s_state <= SOUTH_WAIT;
                            end if; 
                        end if;
                    when SOUTH_WAIT =>
                        if(s_cnt < c_DELAY_2SEC) then
                           s_cnt <= s_cnt +1;
                        else
                           s_state <= STOP1;
                           s_cnt <= c_ZERO;
                        end if;

                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;

    --------------------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state changes, and sets
    -- the output signals accordingly. This is an example of a Moore 
    -- state machine because the output is set based on the active state.
    --------------------------------------------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red (RGB = 100)
            when WEST_GO =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "010";   -- green (RGB = 010)
            when WEST_WAIT =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "110";   -- yellow (RGB = 110)
            when STOP2 =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red (RGB = 100)
            when SOUTH_GO =>
                south_o <= "010";   -- green (RGB = 010)
                west_o  <= "100";   -- Red (RGB = 100)
            when SOUTH_WAIT =>
                south_o <= "110";   -- yellow (RGB = 110)
                west_o  <= "100";   -- Red (RGB = 100)
            when others =>
                south_o <= "100";   -- Red (RGB = 100)
                west_o  <= "100";   -- Red (RGB = 100)
        end case;
    end process p_output_fsm;


end Behavioral;
