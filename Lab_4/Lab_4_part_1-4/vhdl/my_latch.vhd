LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY my_latch IS
PORT ( 	
			D, Clk : IN STD_LOGIC ;
			Q, Qnot : OUT STD_LOGIC
		) ;
END my_latch ;

ARCHITECTURE Behavior OF my_latch IS

BEGIN

	PROCESS ( D, Clk )
	BEGIN
		IF Clk = '1' THEN
			Q <= D ;
			Qnot <= NOT D;
		END IF ;
	END PROCESS ;

END Behavior ;
