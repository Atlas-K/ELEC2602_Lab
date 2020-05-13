LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY my_TFF IS 
		PORT ( 	
			T, EN : in std_logic; 
			clk : in std_logic;
			clear_in : in std_logic;
			Q : out std_logic;
			nQ : out std_logic
				);
END my_TFF;

ARCHITECTURE behavior OF my_TFF IS

	COMPONENT DFF_w_clear IS
		PORT ( 
			D, async_clear, clk, EN : IN STD_LOGIC;
			Q, nQ : OUT STD_LOGIC
		);
	END COMPONENT;

	signal D_temp, Q_temp, nQ_temp: STD_LOGIC;
	
BEGIN
	D_temp <= (T AND nQ_temp) OR (not(T) AND Q_temp);
	Q <= Q_temp;
	nQ <= not(Q_temp);
	
	DFF1: DFF_w_clear PORT MAP (
	clk => clk,
	async_clear => clear_in,
	D => D_temp,
	Q => Q_temp,
	nQ => nQ_temp,
	EN => EN
	);
	
END behavior;
