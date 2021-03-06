------- ALU IMPLEMENTATION 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY ALU IS 
  PORT (
    	A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    	B : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    	A_SET : IN STD_LOGIC; -- when rising edge, A is loaded into Reg
    	TRIGGER : IN STD_LOGIC; -- when rising edge, A <some op> B is placed in C
    	OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- op code 
    	C : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
  
  END;
  
  ARCHITECTURE behavioural OF ALU IS
    
    -- 16 bit reg, set to A when A_Set has rising edge 
    signal A_REG : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	BEGIN
    -- set A Register on rising clock edge 
    ---PROCESS(A_SET) 
	 --BEGIN
      ---IF (rising_edge(A_SET))
      --THEN
        A_REG <= A;
--      END IF;
--    END PROCESS;
        
    -- ALU OPS
    PROCESS(TRIGGER)
	 BEGIN
        IF (rising_edge(TRIGGER))
        THEN
          CASE OP IS
            WHEN "011" => -- ADD 
            	C <= A_REG + B;
            WHEN "100" => -- SUB
          		C <= A_REG - B;
            WHEN "101" => -- xor
        			C <= A_REG XOR B;
				WHEN OTHERS => -- undefined
					C <= "XXX";
          END CASE;
        END IF;
    END PROCESS;
          
  END behavioural;