LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part3 IS
PORT ( 
			Clk, D : IN STD_LOGIC;
			Q, Qnot : OUT STD_LOGIC
		);
END part3;

ARCHITECTURE Structural OF part3 IS

	-- You will need a component part 2, and some intermediate signals
	COMPONENT part2 IS
		PORT ( 
			Clk, D : IN STD_LOGIC;
			Q, Qnot : OUT STD_LOGIC
		);
	END COMPONENT;
	
		SIGNAL master_slave_connector, not_clock: STD_LOGIC;
		
BEGIN

	-- You will need to instantiate a few instances of part 2, and perhaps assign some intermediate signals
	not_clock <= not(clk);
	
	SR_master: part2 PORT MAP (
	clk => not_clock,
	D => D,
	Q => master_slave_connector
	);
	
	SR_slave: part2 PORT MAP (
	clk => clk,
	D => master_slave_connector,
	Q => Q,
	Qnot => Qnot
	);
END Structural;