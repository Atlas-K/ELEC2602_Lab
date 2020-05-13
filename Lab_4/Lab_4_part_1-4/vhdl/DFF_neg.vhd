LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF_neg IS
PORT ( 	
			D, Clk : IN STD_LOGIC ;
			Q, Qnot : OUT STD_LOGIC
		) ;
END DFF_neg ;

ARCHITECTURE Behavior OF DFF_neg IS

BEGIN

	PROCESS (clk)
	BEGIN
		if (falling_edge(clk)) then
			Q <= D ;
			Qnot <= NOT D;
		end if;
	END PROCESS ;

END Behavior ;
