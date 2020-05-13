LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fourBitReg IS
PORT (
					input		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					clk 		: IN STD_LOGIC;
					reset		: IN STD_LOGIC;
					output	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
					EN			: IN STD_LOGIC
		);
END fourBitReg;

ARCHITECTURE Structural OF fourBitReg IS


BEGIN
	PROCESS (input, reset, clk)
	BEGIN
		IF (rising_edge(clk) AND EN = '1') THEN
			IF reset = '1' THEN
				output <= "0000";
			ELSE
				output <= input;
			END IF;
		END IF;
	END PROCESS;

END Structural;
