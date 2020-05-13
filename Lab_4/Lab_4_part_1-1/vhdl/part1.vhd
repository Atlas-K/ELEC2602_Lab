LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part1 IS
PORT ( 
			Clk, R, S : IN STD_LOGIC;
			Q, Qnot : OUT STD_LOGIC
		);
END part1;

ARCHITECTURE Structural OF part1 IS

	SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of R_g, S_g, Qa, Qb : SIGNAL IS true;
	
BEGIN

	R_g <= NOT(R AND Clk);
	S_g <= NOT(S AND Clk);
	Qa <= NOT (S_g AND Qb);
	Qb <= NOT (R_g AND Qa);
	Q <= Qa;
	Qnot <= Qb;
	
END Structural;