----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2026 03:41:41 PM
-- Design Name: 
-- Module Name: kitt_car - Behavioral
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


---------- DEFAULT LIBRARY ---------
library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.NUMERIC_STD.ALL;
------------------------------------

entity kitt_car is
	Generic (

		CLK_PERIOD_NS			:	POSITIVE	RANGE	1   TO	100     := 10;	-- clk period in nanoseconds
		MIN_KITT_CAR_STEP_MS	:	POSITIVE	RANGE	1	TO	2000    := 1;	-- Minimum step period in milliseconds (i.e., value in milliseconds of Delta_t)

		SWITCH_NUMBER		    :	INTEGER	    RANGE	1   TO  16      := 16;	-- Number of input switches
		LED_NUMBER		        :	INTEGER	    RANGE	1   TO  16      := 16;	-- Number of output LEDs
        TAIL_LENGTH				:	INTEGER	    RANGE	1   TO  16      := 4	-- Tail length

	);
    Port (

        ------- Reset/Clock --------
        clk     :   IN  STD_LOGIC;
        rst     :   IN  STD_LOGIC;
        ----------------------------

        -------- LEDs/SWs ----------
        sw		:	IN	STD_LOGIC_VECTOR(SWITCH_NUMBER-1 downto 0);
        leds	:	OUT	STD_LOGIC_VECTOR(LED_NUMBER-1 downto 0)
        ----------------------------
    );
end kitt_car;

architecture Behavioral of kitt_car is

    -- Calculate how many clock cycles are in the minimum step (Delta_t)
    -- Formula: (ms * 1,000,000) / clk_period_ns
    constant CLK_CYCLES_PER_STEP : integer := (MIN_KITT_CAR_STEP_MS * 1000000) / CLK_PERIOD_NS;

    

begin


end Behavioral;
