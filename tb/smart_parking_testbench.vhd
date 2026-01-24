LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TEST_Smart_Parking_System IS 
END TEST_Smart_Parking_System;

ARCHITECTURE arch of  TEST_Smart_Parking_System IS
	SIGNAL clk:  std_logic;
	SIGNAL car_detect_in_sensor1: std_logic; -- 0 when detecting an object and 1 when vice versa--
	SIGNAL car_detect_in_sensor2: std_logic; -- 0 when detecting an object and 1 when vice versa--
	SIGNAL auto_manual_switch:  std_logic; -- 1 for auto, 0 for manual--
	SIGNAL reset_btn: std_logic;
	SIGNAL open_close_button:  std_logic;
	SIGNAL seg_display_ofnumbers:  std_logic_vector(6 DOWNTO 0); --abcdefg ACTIVE LOW--
	SIGNAL servo_motor:  std_logic;

	COMPONENT smart_parking_top 
		PORT (	
		clk: IN std_logic;
		car_detect_in_sensor1:IN std_logic; -- 0 when detecting an object and 1 when vice versa--
		car_detect_in_sensor2:IN std_logic; -- 0 when detecting an object and 1 when vice versa--
		auto_manual_switch: IN std_logic; -- 1 for auto, 0 for manual--
		reset_btn:IN std_logic;
		open_close_button: IN std_logic;
		seg_display_ofnumbers: OUT std_logic_vector(6 DOWNTO 0); --abcdefg ACTIVE LOW--
		servo_motor: OUT std_logic
		);
	END COMPONENT;

BEGIN
    Instantiation_Proc: smart_parking_top PORT MAP (clk => clk, 
						car_detect_in_sensor1 => car_detect_in_sensor1, 
						car_detect_in_sensor2 => car_detect_in_sensor2, 
						auto_manual_switch => auto_manual_switch, 
						reset_btn => reset_btn,
 						open_close_button => open_close_button, 
						seg_display_ofnumbers => seg_display_ofnumbers, 
						servo_motor => servo_motor);

	process_clk: PROCESS 
	BEGIN 
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1';
		wait for 10 ns; 
	END PROCESS process_clk;

	process_sensor1: PROCESS 
	BEGIN 
		car_detect_in_sensor1 <= '0'; 
		wait for 20 ms; 
		car_detect_in_sensor1 <= '1'; 
		wait; 
	END PROCESS process_sensor1;

	process_sensor2: PROCESS 
	BEGIN 
		car_detect_in_sensor2 <= '1'; 
		wait for 20 ms; 
		car_detect_in_sensor2 <= '0'; 
		wait for 20  ms; 
		car_detect_in_sensor2 <= '1'; 
		wait; 
	END PROCESS process_sensor2;

	process_mode: PROCESS 
	BEGIN 
		auto_manual_switch <= '1'; 
		wait for 40 ms;
		auto_manual_switch <= '0'; 
		wait for 80 ms; 
		auto_manual_switch <= '1';
		wait; 
	END PROCESS process_mode;

	process_button: PROCESS 
	BEGIN 
		open_close_button <= '1'; 
		wait for 40 ms; 
		open_close_button <= '0'; 
		wait for 10 ms; 
		open_close_button <= '1'; 
		wait for 10 ms; 
		open_close_button <= '0'; 
		wait for 10 ms; 
		open_close_button <= '1'; 
		wait; 
	END PROCESS process_button;

	process_reset: PROCESS
	BEGIN 
		reset_btn <= '1'; 
		wait for 80 ms; 
		reset_btn <= '0';
		wait for  2 ms; 
		reset_btn <= '1'; 
		wait; 
	END PROCESS process_reset;

END arch;