LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
library STD;
use STD.textio.all;

ENTITY PC IS
PORT(
		enable	: 		IN STD_LOGIC;
		clk, reset	:	IN STD_LOGIC;
		pointer	:		OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	  );
	
END;

ARCHITECTURE behavioral OF PC IS

SIGNAL temp_pc: STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

	PROCESS(clk,reset,enable, pc_var)
		BEGIN
			if (reset = '1') then
				pc_var <= (OTHERS => '0');
			elsif	rising_edge(clk) then
				if enable = '1' then
					if (pc_var= "111") then
						pc_var <= (OTHERS => '0');
					else
						pc_var <= std_logic_vector(unsigned(pc_var) + 1);
					end if;	
				end if;
			else
				pc_var <= pc_var;
			end if;
	END PROCESS;
	pointer <= pc_var;	
	
END behavioral;