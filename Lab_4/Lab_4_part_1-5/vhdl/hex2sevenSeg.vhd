LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hex2sevenSeg IS
PORT ( 
					hex_in   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					sevenSeg	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
END hex2sevenSeg;

ARCHITECTURE Structural OF hex2sevenSeg IS


BEGIN

	PROCESS (hex_in)
	BEGIN
		CASE hex_in IS               --6543210
			WHEN "0000" => sevenSeg <= "1000000"; --00
			WHEN "0001" => sevenSeg <= "1111001"; --01
			WHEN "0010" => sevenSeg <= "0100100"; --02
			WHEN "0011" => sevenSeg <= "0110000"; --03
			WHEN "0100" => sevenSeg <= "0011001"; --04
			WHEN "0101" => sevenSeg <= "0010010"; --05
			WHEN "0110" => sevenSeg <= "0000010"; --06
			WHEN "0111" => sevenSeg <= "1111000"; --07
			WHEN "1000" => sevenSeg <= "0000000"; --08
			WHEN "1001" => sevenSeg <= "0011000"; --09
			WHEN "1010" => sevenSeg <= "0001000"; --10
			WHEN "1011" => sevenSeg <= "0000011"; --11
			WHEN "1100" => sevenSeg <= "1000110"; --12
			WHEN "1101" => sevenSeg <= "0100001"; --13
			WHEN "1110" => sevenSeg <= "0000110"; --14
			WHEN "1111" => sevenSeg <= "0001110"; --15
			WHEN OTHERS => sevenSeg <= "1001001"; --Error
		END CASE;
	END PROCESS;
	
END Structural;