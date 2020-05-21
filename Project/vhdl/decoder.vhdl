LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
library STD;
use STD.textio.all;

ENTITY Decoder IS 
	PORT (
		instruction : IN STD_LOGIC_VECTOR(34 DOWNTO 0);
		op_code : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		arg_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		arg_2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END;

ARCHITECTURE behavioural OF Decoder IS 

	op_code <= instruction(34 DOWNTO 32);
	arg_1 <= instruction(31 DOWNTO 16);
	arg_2 <= instruction(15 DOWNTO 0);
	
END behavioral;
