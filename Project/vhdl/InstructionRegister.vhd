LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;
library STD;
use STD.textio.all;

ENTITY InstructionRegister IS
  PORT(
    		incr_clk : IN STD_LOGIC; -- flip state when you want to incrament (0 -> 1 or 1-> 0 will incrament)
    		instruction : OUT STD_LOGIC_VECTOR(34 DOWNTO 0) --- <3 bit op code> <16 bit add1> <16 bit add 2>
    );
  
	
END;

ARCHITECTURE behavioral OF InstructionRegister IS
  
  -- globals 
   signal NUM_INSTRUCTIONS : integer := 4;
	signal INSTRUCTION_SIZE : integer := 35;
   signal TERMINATED_INSTRUCTION :  STD_LOGIC_VECTOR(INSTRUCTION_SIZE - 1 DOWNTO 0) := "11111111111111111111111111111111111";

	-- internal signals 
	signal current_instruction_internal : STD_LOGIC_VECTOR(INSTRUCTION_SIZE - 1 DOWNTO 0) := "00000000000000000000000000000000000";
  
	-- type defs 
	type InstructionMemory is array(NUM_INSTRUCTIONS DOWNTO 0) of STD_LOGIC_VECTOR(INSTRUCTION_SIZE -1 DOWNTO 0);
	
  -- 4 instructions, 35 bits per instruction
  signal instructions : InstructionMemory;

  -- start at 0 addr
	signal program_counter : integer := 0;
                                   
BEGIN
  -- load instructions 
  instructions(0) <= "00000000000000000000000000000000000";
  instructions(1) <= "00000000000000000000000000000000001";
  instructions(2) <= "00000000000000000000000000000000010";
  instructions(3) <= "00000000000000000000000000000000011";
  instructions(4) <= TERMINATED_INSTRUCTION;

  
  -- when incrament changes state, execute 
	PROCESS(incr_clk)
		BEGIN 
		if current_instruction_internal /= TERMINATED_INSTRUCTION AND rising_edge(incr_clk)
		then
			if program_counter /= NUM_INSTRUCTIONS + 1
			then 
				 program_counter <= program_counter + 1;
			end if; 
		
		end if;
	END PROCESS;	
	
	current_instruction_internal <= instructions(program_counter);

					 
	-- return instruction 
	instruction <= current_instruction_internal;
	
END behavioral;

  
  
  
  
  
