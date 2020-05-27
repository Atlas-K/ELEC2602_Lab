LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
library STD;
use STD.textio.all;

ENTITY Decoder IS 
	PORT (
		instruction : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		op_code : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		arg_1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		arg_2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END;

ARCHITECTURE behavioural OF Decoder IS 
begin
	op_code <= instruction(8 DOWNTO 6);
	arg_1 <= instruction(5 DOWNTO 3);
	arg_2 <= instruction(2 DOWNTO 0);
	
END behavioural;