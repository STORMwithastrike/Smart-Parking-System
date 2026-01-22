library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity smart_parking_top is
    port (
        clk                   : in std_logic;
        reset_btn             : in std_logic;
        car_detect_in_sensor1 : in std_logic;
        car_detect_in_sensor2 : in std_logic;
        auto_manual_switch    : in std_logic;
        open_close_button     : in std_logic;
        
        seg_display_ofnumbers : out std_logic_vector(6 downto 0);
        servo_motor           : out std_logic
    );
end smart_parking_top;

architecture structural of smart_parking_top is
    signal wire_gate_cmd : std_logic;
    signal wire_count    : integer range 0 to 8;

    -- Component Mappings
    component parking_controller
        port (
            clk, reset_n, sensor1, sensor2, mode_switch, manual_btn : in std_logic;
            gate_is_open_cmd : out std_logic;
            current_spots    : out integer range 0 to 8
        );
    end component;

    component servo_pwm
        port (
            clk, gate_status : in std_logic;
            servo_pwm       : out std_logic
        );
    end component;

    component seven_seg_decoder
        port (
            count_in : in integer range 0 to 8;
            seg_out  : out std_logic_vector(6 downto 0)
        );
    end component;

begin

    -- controller mapping
    CONTROLLER: parking_controller port map (
        clk              => clk,
        reset_n          => reset_btn,
        sensor1          => car_detect_in_sensor1,
        sensor2          => car_detect_in_sensor2,
        mode_switch      => auto_manual_switch,
        manual_btn       => open_close_button,
        gate_is_open_cmd => wire_gate_cmd, 
        current_spots    => wire_count     
    );

    -- servo motor mapping
    SERVO: servo_pwm port map (
        clk         => clk,
        gate_status => wire_gate_cmd, 
        servo_pwm  => servo_motor
    );

    -- seven segment mapping
    DISPLAY: seven_seg_decoder port map (
        count_in => wire_count,    
        seg_out  => seg_display_ofnumbers
    );

end structural;