LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY passcode IS
PORT (
					input		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					clk 		: IN STD_LOGIC;
					reset		: IN STD_LOGIC;
					output	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
					EN			: IN STD_LOGIC
		);
END passcode;

ARCHITECTURE Structural OF passcode IS

	COMPONENT fourBitReg PORT (
	input		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	clk 		: IN STD_LOGIC;
	reset		: IN STD_LOGIC;
	output	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	EN			: IN STD_LOGIC
	);
	END COMPONENT;
	
	--from clk tick 0 to 3, store pw1 in reg1, EN for reg 2 to 4 is 0
	--from clk tick 4 to 7, store pw2 in reg2, EN for reg 1,3,4 is 0
	--from clk tick 8 to 11, store pw3 in reg3, EN for reg 1,2,4 is 0
	--from clk tick 12 to 15, store pw4 in reg4, EN for reg 1,2,3 is 0
	--from tick 16, all EN is 0
			 --0000: null
			 --0001: store pw1
			 --0010: store pw2
			 --0011: store pw3
			 --0100: store pw4
			 --0101: correct pw1
			 --0110: correct pw2
			 --0111: correct pw3
			 --1000: correct pw4
			 --1001: incorrect pw1
			 --1010: incorrect pw2
			 --1011: incorrect pw3
			 --1100  incorrect pw4
			 --1101: valid passcode
			 --1110: invalid passcode
			 --if state 0000 => state 0001 => state 0010 => state 0011 => state 0100
			 --if state 0100 and pw1 correct => state 0101
									-- pw1 incorrect => state 1001
			 --if state 0101 and pw2 correct => state 0110
									-- pw2 incorrect => state 1010
			 --if state 0110 and pw3 correct => state 0111
									-- pw3 incorrect => state 1011
			 --if state 0111 and pw4 correct => state 1000
									-- pw4 incorrect => state 1100
			 --if state 1000 => state 1101
			 --if state 1001 => state 1010 => state 1011 => state 1100 => state 1110
			 --if state 1101 => output(z) = 1
			 --if state 1110 => output(z) = 0
			 --correct pw: w=1, incorrect pw: w=0
			 --from state 0000 to state 0100, w, z = 0
			 --from state 0101 to state 1100, w = 0	
	

	SIGNAL reg1_signal, reg2_signal, reg3_signal, reg4_signal: STD_LOGIC_VECTOR(3 downto 0);
BEGIN

	output <= reg4_signal & reg3_signal & reg2_signal & reg1_signal;

	REG1: fourBitReg PORT MAP (
	input => input,
	clk => clk,
	reset => reset,
	output => reg1_signal,
	EN => EN
	);
	
	REG2: fourBitReg PORT MAP (
	input => reg1_signal,
	clk => clk,
	reset => reset,
	output => reg2_signal,
	EN => EN
	);
	
	REG3: fourBitReg PORT MAP (
	input => reg2_signal,
	clk => clk,
	reset => reset,
	output => reg3_signal,
	EN => EN
	);
	
	REG4: fourBitReg PORT MAP (
	input => reg3_signal,
	clk => clk,
	reset => reset,
	output => reg4_signal,
	EN => EN
	);

END Structural;
