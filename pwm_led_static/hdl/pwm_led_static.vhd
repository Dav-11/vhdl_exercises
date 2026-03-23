
---------- DEFAULT LIBRARY ---------
library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.NUMERIC_STD.ALL;
------------------------------------

entity pwm_led_static is
	Generic (
        SYS_CLK_FREQ       : integer                := 100_000_000; -- 100MHz for Basys 3
        PWM_FREQ           : integer                := 1_000;       -- 1kHz
        DUTY_CYCLE_PERCENT : integer range 0 to 100 := 50           -- Set intensity here (0-100)
	);
    Port (

        ------- Reset/Clock --------
        clk     :   IN  STD_LOGIC;
        rst     :   IN  STD_LOGIC;
        ----------------------------

        -------- LEDs/SWs ----------
        pwm_out	:	OUT	STD_LOGIC
        ----------------------------
    );
end pwm_led_static;

architecture Behavioral of pwm_led_static is

    -- Calculate total clocks per PWM period
    constant MAX_COUNT : integer := SYS_CLK_FREQ / PWM_FREQ;

    -- Calculate how many clocks the signal should be HIGH
    constant HIGH_COUNT : integer := (MAX_COUNT * DUTY_CYCLE_PERCENT) / 100;

    -- Counter signal
    signal cnt_r : integer range 0 to MAX_COUNT - 1 := 0;

begin

    process(clk, reset)
    begin

        if (rising_edge(clk)) then
            
            if rst = 1 then
                
                cnt_r       <= 0;
                pwm_out     <= '0';
            else 

                -----------------------
                -- counter logic
                -----------------------

                if cnt_r < MAX_COUNT -1 then
        
                    cnt_r <= cnt_r + 1;
                else

                    cnt_r <= 0;
                end if;

                -----------------------
                -- out logic
                -----------------------

                if cnt_r < HIGH_COUNT then
                    
                    pwm_out <= '1';
                else

                    pwm_out <= '0';
                end if;

            end if

        end if
    end

end Behavioral;