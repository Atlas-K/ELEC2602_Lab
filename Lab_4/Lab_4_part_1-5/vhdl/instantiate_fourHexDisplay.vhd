LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY instantiate_fourHexDisplay IS
PORT ( 	SW : IN std_logic_vector(9 DOWNTO 0);
			hex1, hex2, hex3, hex4 : OUT std_logic_vector(6 DOWNTO 0)
			);
END instantiate_fourHexDisplay;

ARCHITECTURE behaviour OF instantiate_fourHexDisplay IS

   -- Component Declaration that you are instantiating
    COMPONENT fourHexDisplay  
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
    END COMPONENT;
	
BEGIN

   uut: fourHexDisplay PORT MAP (
          input1 => SW(3 DOWNTO 0),
          input2 => SW(7 DOWNTO 4),
          clk => SW(8),
			 reset => SW(9),
			 out1 => hex1,
			 out2 => hex2,
			 out3 => hex3,
			 out4 => hex4
        ); 
	
END behaviour;