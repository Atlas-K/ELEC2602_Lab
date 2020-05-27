LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
library STD;
use STD.textio.all;

ENTITY InstructionRegister IS
  PORT(
    		incr_clk, branch : IN STD_LOGIC; 
    		instruction : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --- <3 bit op code> <16 bit add1> <16 bit add 2>
			pc_in: IN STD_LOGIC_Vector(2 downto 0)
    );
  
	
END;

ARCHITECTURE behavioral OF InstructionRegister IS
  
  -- globals 
   signal NUM_INSTRUCTIONS : integer := 4;
	signal INSTRUCTION_SIZE : integer := 9;
   signal TERMINATED_INSTRUCTION :  STD_LOGIC_VECTOR(INSTRUCTION_SIZE - 1 DOWNTO 0) := "111111111";

	-- internal signals 
	signal current_instruction_internal : STD_LOGIC_VECTOR(INSTRUCTION_SIZE - 1 DOWNTO 0) := "000000000";
  
	-- type defs 
	type InstructionMemory is array(NUM_INSTRUCTIONS DOWNTO 0) of STD_LOGIC_VECTOR(INSTRUCTION_SIZE -1 DOWNTO 0);
	
  -- 4 instructions, 35 bits per instruction
  signal instructions : InstructionMemory;

  -- start at 0 addr
	signal program_counter : integer := 0;
                                   
BEGIN
  -- load instructions 
  --876543210--
  instructions(0) <= "001000100"; -- LOAD R0 4 (100)
  instructions(1) <= "010001000"; -- MOV R1 R0 -> R0 = R1 = 4
  instructions(2) <= "011000001"; -- ADD R0 R1 -> R0 = 8, R1 = 4
  instructions(3) <= "100000001"; -- SUB R0 R1 -> R0 = 4, R1 = 4
--3 bit op, 3bit addr1, 3bit addr2
  
  -- when incrament changes state, execute 
	PROCESS(incr_clk,branch)
		BEGIN 
			if branch /= '1' then
				if program_counter /= NUM_INSTRUCTIONS + 1 then 
					program_counter <= program_counter + 1;
				end if; 
			else
				program_counter <= conv_integer(pc_in);

			end if;
		

	
	END PROCESS;	
	
	current_instruction_internal <= instructions(program_counter);

					 
	-- return instruction 
	instruction <= current_instruction_internal;
END behavioral;

  
  
  
  
  
