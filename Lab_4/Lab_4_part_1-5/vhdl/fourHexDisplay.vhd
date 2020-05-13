LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity	fourHexDisplay IS
PORT ( 
					input1		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					input2		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					clk 			: IN STD_LOGIC;
					reset 		: IN STD_LOGIC;
					out1	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out2	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out3	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out4	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END fourHexDisplay;

ARCHITECTURE Structural OF fourHexDisplay IS

	component fourBitReg IS
		PORT ( 
					input		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					clk 		: IN STD_LOGIC;
					reset		: IN STD_LOGIC;
					output	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	end component;
	
	component hex2sevenSeg IS
	PORT ( 
					hex_in		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					sevenSeg	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	end component;

	signal stored_input1, stored_input2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

	reg1 : fourBitReg PORT MAP (
			input 				=>  input1,
			clk					=>  clk,
			reset					=>  reset,
			output 				=>  stored_input1 
        );
		  
	reg2 : fourBitReg PORT MAP (
			input 				=>  input2,
			clk					=>  clk,
			reset					=>  reset,
			output 				=>  stored_input2 
        );

   hex1 : hex2sevenSeg PORT MAP (
			hex_in 				=> stored_input1,
			sevenSeg 			=> out1
        );
		  
	hex2 : hex2sevenSeg PORT MAP (
			hex_in 				=> stored_input2,
			sevenSeg 			=> out2
        );   
	
	hex3 : hex2sevenSeg PORT MAP (
			hex_in 				=> input1,
			sevenSeg 			=> out3
        );   

		  
	hex4 : hex2sevenSeg PORT MAP (
			hex_in 				=> input2,
			sevenSeg 			=> out4
        );   

	
END Structural;