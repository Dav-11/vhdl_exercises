---------- DEFAULT LIBRARY ---------
library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.NUMERIC_STD.ALL;
------------------------------------

entity keys_encoder is
	Generic (
		SWITCH_NUMBER		    :	INTEGER	    RANGE	1   TO  16      := 16;	-- Number of input switches
	);
    Port (
        ------- Reset/Clock --------
        clk     :   IN  STD_LOGIC;
        rst     :   IN  STD_LOGIC;
        ----------------------------

        sw		:	IN	STD_LOGIC_VECTOR(SWITCH_NUMBER-1 downto 0);
        out     :   OUT
    );
end keys_encoder;

architecture Behavioral of keys_encoder is


begin


end Behavioral;