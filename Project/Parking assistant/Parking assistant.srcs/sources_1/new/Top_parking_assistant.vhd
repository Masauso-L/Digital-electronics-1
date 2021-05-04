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

 

entity Top_parking_assistant is
    Port ( 
          CLK100MHZ  : in  std_logic;                       -- for fgpa 100MHz clock
          --BTN        : in  std_logic_vector(1-1 downto 0);  -- for reset
          SW         : in  std_logic;                       --for enable
          echo       : in  std_logic;
          ck_io      : out std_logic_vector(10-1 downto 0); --output led
          trigger    : out std_logic;
          Buzzer     : out std_logic                        --audio output pin
    );
end Top_parking_assistant;

 

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of Top_parking_assistant is
-- inernal signals 
    signal s_pulse    : std_logic;    -- for puls_i and sensi_o
    signal s_distance : std_logic_vector(4-1 downto 0);
    signal s_time     : natural;
    
begin

 

    --------------------------------------------------------------------
    -- Instance (copy) of sensor_contrl_unit entity
    --------------------------------------------------------------------
    Sensor_control_unit : entity work.Sensor_control_unit
        port map(
             CLK100MHZ => CLK100MHZ,
             echo_i    => echo,
             puls_i    => s_pulse,
             time_o    => s_time,
             trigger_o => trigger
             
             );
    --------------------------------------------------------------------
    -- Instance (copy) of sensor_logic_unit entity
    --------------------------------------------------------------------
    Sensor_logic_unit : entity work.Sensor_logic_unit
        port map(
             CLK100MHZ  => CLK100MHZ,
             enable_i   => SW,
             sensi_i    => s_time,
             sensi_o    => s_pulse,
             distance_o => s_distance
             
             );
             
    --------------------------------------------------------------------
    -- Instance (copy) of sensor_logic_unit entity
    --------------------------------------------------------------------
    LEDs : entity work.LED_bar_control_unit
        port map(
             enable_i     => SW,
             distance_i   => s_distance,
             LED_bar_o(0) => ck_io(0),  --red
             LED_bar_o(1) => ck_io(1),
             LED_bar_o(2) => ck_io(2),  --yellow
             LED_bar_o(3) => ck_io(3),
             LED_bar_o(4) => ck_io(4),  
             LED_bar_o(5) => ck_io(5),  --green
             LED_bar_o(6) => ck_io(6),
             LED_bar_o(7) => ck_io(7),
             LED_bar_o(8) => ck_io(8),  
             LED_bar_o(9) => ck_io(9)
             
             );
     
     --------------------------------------------------------------------
    -- Instance (copy) of Buzzer_unit entity
    --------------------------------------------------------------------
    Buzzer_unit : entity work.Buzzer_control_unit
        port map(
             enable_i   => SW,
             CLK100MHZ  => CLK100MHZ,
             distance_i => s_distance,
             buzzer_o   => Buzzer
             
             );        

 

end Behavioral;