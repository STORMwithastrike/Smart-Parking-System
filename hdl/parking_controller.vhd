library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_controller is
    port (
        clk             : in std_logic;
        reset_n         : in std_logic;
        sensor1         : in std_logic;
        sensor2         : in std_logic;
        mode_switch     : in std_logic; -- 1=auto, 0=manual
        manual_btn      : in std_logic;
        
        gate_is_open_cmd : out std_logic;
        current_spots    : out integer range 0 to 8
    );
end parking_controller;

architecture behavioral of parking_controller is
    signal gate_status : std_logic := '0';
    signal count       : integer range 0 to 8 := 8;
    
    signal countdelayinsensor2 : integer range 0 to 100000000 := 0;
    signal prev_button  : std_logic := '1';
    signal prev_sensor1 : std_logic := '1';
    signal prev_sensor2 : std_logic := '1';

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset_n = '0' then
                count <= 8;
                gate_status <= '0';
            else
                -- manual mode
                if mode_switch = '0' then
                    if manual_btn = '0' and prev_button = '1' then
                        if gate_status = '0' then
                            gate_status <= '1'; 
                        else
                            gate_status <= '0';
                            if count > 0 then
                                count <= count - 1;
                            end if;
                        end if;
                    end if;
                
                -- autonomous mode
                else
                    -- entry logic
                    if prev_sensor1 = '1' and sensor1 = '0' and gate_status = '0' then
                        gate_status <= '1';
                    end if;
                    
                    -- exit & delay logic
                    if prev_sensor2 = '1' and sensor2 = '0' then
                        if countdelayinsensor2 = 0 then
                            gate_status <= '0';
                            if count > 0 then
                                count <= count - 1;
                            end if;
                            countdelayinsensor2 <= 100000000;
                        end if;
                    end if;
                end if;
                
                if countdelayinsensor2 > 0 then
                    countdelayinsensor2 <= countdelayinsensor2 - 1;
                end if;

                prev_button  <= manual_btn;
                prev_sensor1 <= sensor1;
                prev_sensor2 <= sensor2;
            end if;
        end if;
    end process;

    gate_is_open_cmd <= gate_status;
    current_spots    <= count;

end behavioral;