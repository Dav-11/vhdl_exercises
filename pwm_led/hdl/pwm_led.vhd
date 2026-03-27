
---------- DEFAULT LIBRARY ---------
library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.NUMERIC_STD.ALL;
    use IEEE.MATH_REAL.all;
------------------------------------

entity pwm_led is
	Generic (
        SYS_CLK_FREQ        : integer   := 100_000_000; -- 100MHz for Basys 3
        PWM_FREQ            : integer   := 1_000;       -- 1kHz
        BRIGHTNESS_LEVELS   : integer   := 16           -- Number of brightness steps (0 = off)
	);
    Port (

        ------- Reset/Clock --------
        clk     :   IN  STD_LOGIC;
        rst     :   IN  STD_LOGIC;
        ----------------------------

        -- needs to contain values from 0 to BRIGHTNESS_LEVELS (simulate duty_cycle)
        brightness  :   IN  STD_LOGIC_VECTOR(integer(ceil(log2(real(BRIGHTNESS_LEVELS+1)))) - 1 downto 0);
        pwm_out	    :	OUT	STD_LOGIC
    );
end pwm_led;

architecture Behavioral of pwm_led is

    -- Calculate total clocks per PWM period
    constant MAX_COUNT : integer := SYS_CLK_FREQ / PWM_FREQ;

    -- internal registers
    signal cnt_r : integer range 0 to MAX_COUNT - 1 := 0;
    signal high_count : integer range 0 to MAX_COUNT - 1 := 0;

    signal pwm_out_n : STD_LOGIC;
    signal pwm_out_r : STD_LOGIC;

begin

    -----------------------
    -- compute high count
    -----------------------
    high_count <= (to_integer(unsigned(brightness)) * (MAX_COUNT-1)) / BRIGHTNESS_LEVELS;

    -----------------------
    -- out logic
    -----------------------

    if cnt_r < high_count then
        
        pwm_out_n <= '1';
    else

        pwm_out_n <= '0';
    end if;

    process(clk, rst)
    begin

        if (rising_edge(clk)) then
            
            if rst = '1' then
                
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
                pwm_out <= pwm_out_n;

            end if;
        end if;
    end process;

end Behavioral;