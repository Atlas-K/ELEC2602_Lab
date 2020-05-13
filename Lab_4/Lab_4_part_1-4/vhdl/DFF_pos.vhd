LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF_pos IS
PORT ( 	
			D, Clk : IN STD_LOGIC ;
			Q, Qnot : OUT STD_LOGIC
		) ;
END DFF_pos ;

ARCHITECTURE Behavior OF DFF_pos IS

BEGIN

	PROCESS (clk)
	BEGIN
		if (rising_edge(clk)) then
			Q <= D ;
			Qnot <= NOT D;
		end if;
	END PROCESS ;

END Behavior ;
