library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity servo_pwm is
    port (
        clk         : in std_logic;
        gate_status : in std_logic; -- 1=open, 0=closed
        servo_pwm  : out std_logic
    );
end servo_pwm;

architecture behavioral of servo_pwm is
    signal cycles : integer range 0 to 1000000 := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Counter logic
            if cycles = 999999 then
                cycles <= 0;
            else
                cycles <= cycles + 1;
            end if;

            if (gate_status = '1' and cycles < 75000) or
               (gate_status = '0' and cycles < 50000) then
                servo_pwm <= '1';
            else
                servo_pwm <= '0';
            end if;
        end if;
    end process;
end behavioral;