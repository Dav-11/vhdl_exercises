----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2026 05:54:02 PM
-- Design Name: 
-- Module Name: top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

    Generic (
        WIDTH: integer := 8
    );

    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;

        data_in : in STD_LOGIC;
        data_out: out STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
    );
end top;

architecture Behavioral of top is

    signal shift_reg : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) := (others => '0');

begin

    process(clk, rst)
    begin

        if rising_edge(clk) then

            shift_reg <= data_in & shift_reg(WIDTH-1 downto 1);

            if rst = '1' then
                shift_reg <= (others => '0');
            end if;

        end if;

    end process;

    data_out <= shift_reg;

end Behavioral;
