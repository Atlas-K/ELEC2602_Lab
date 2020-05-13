LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY DFF_w_clear IS 
		PORT ( 	
			D, async_clear, clk, EN: IN STD_LOGIC;
			Q: OUT STD_LOGIC := '0';
			nQ: OUT STD_LOGIC := '1'
				);
END DFF_w_clear;

ARCHITECTURE Behavioral OF DFF_w_clear IS

BEGIN
	PROCESS (clk)
	BEGIN
		IF async_clear ='1' THEN
			Q <= '0';
		ELSIF rising_edge(clk) AND EN = '1' THEN
			Q <= D;
			nQ <= not(D);
		END IF;
	END PROCESS;
	
END Behavioral;
