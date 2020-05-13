LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part2 IS
PORT ( 
			Clk, D : IN STD_LOGIC;
			Q, Qnot : OUT STD_LOGIC
		);
END part2;

ARCHITECTURE Structural OF part2 IS
	-- You will need a component part 1, and some intermediate signals
	COMPONENT part1 IS
		PORT(
		Clk, S, R : IN STD_LOGIC;
		Q, Qnot : OUT STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL not_D: STD_LOGIC;
	
BEGIN

	not_D <= not(D);
	
	SR1: part1 PORT MAP (
		clk => clk,
		S => D,
		R => not_D,
		Q => Q,
		Qnot => Qnot
		);

END Structural;