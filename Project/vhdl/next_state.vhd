LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY next_state is
	port (	--I don't think that any of this useful except for state, f1f0, reset, next_state. I will update this in the end.
	
				state: IN std_logic_vector(3 downto 0); 		--Current State.
				f1f0:	 IN std_LOGIC_VECTOR(2 downto 0);		--The operation to be performed (Add, Move, XOR, etc) given by OPCODE. (Connect this to op_code of decoder in FSM)
				reset: IN std_logic;									--Everyone is familiar with this devil.
				next_state : OUT std_logic_vector(3 downto 0)--The next state that will be output
				);
END;

ARCHITECTURE behavioural of next_state is

begin

		process(state, f1f0, w, reset) is
				
		begin
		--If statements are used here instead of "case" as the events are not mutually exclusive. Check this website for mutually exclusive: https://electronics.stackexchange.com/questions/73387/difference-between-if-else-and-case-statement-in-vhdl
				if (reset = '1') then							
					next_state <= "0000";
				elsif (state = "0000") then							--Path: Start -> Store Instruction
					next_state <= "0001";
				elsif (state = "0001") then							--Path: Store Instruction -> PC Load Instruction 0
					next_state <= "0010";
				elsif (state = "0010") then							--Path: PC Load Instruction 0 -> PC Instruction to Instruction Register
					next_state <= "0011";
				elsif (state = "0011") then							--Path: PC Instruction to Instruction Register -> Instruction Register Instruction to Decoder
					next_state <= "0101";
				elsif (state = "0101" and f1f0 = "000") then		--Path: Instruction Register Instruction to Decoder -> Kill Clock?? (Termination OPCODE)
					next_state <= "1111";
				elsif (state = "0101" and f1f0 = "010") then		--Path: Instruction Register Instruction to Decoder -> move (move only)
					next_state <= "0111";
				elsif (state = "0101" and f1f0 = "001") then		--Path: Instruction Register Instruction to Decoder -> load
					next_state <= "0110";
				elsif (state = "0110") then							--Path: load -> load1
					next_state <= "1110";								--Excuse the break in pattern. I had to make these changes after creating this file.
				elsif (state = "1110") then							--Path: load1 -> PC Instruction to instruction register & PC increments by 1
					next_state <= "0100";
				elsif (state = "0111") then							--Path: move (move only) -> PC Instruction to instruction register & PC increments by 1
					next_state <= "0100";									
				elsif (state = "0101" and f1f0 = "011") then		--Path: Instruction Register Instruction to Decoder -> add_or_xor_sub (add only)
					next_state <= "1000";
				elsif (state = "0101" and f1f0 = "101") then		--Path: Instruction Register Instruction to Decoder -> add_or_xor_sub (xor only)
					next_state <= "1000";
				elsif (state = "0101" and f1f0 = "100") then		--Path: Instruction Register Instruction to Decoder -> add_or_xor_sub (sub only)
					next_state <= "1000"'
				elsif (state = "1000") then							--Path: add_or_xor_sub (any) -> add_or_xor_sub1 (any)
					next_state <= "1001";
				elsif (state = "1001") then							--Path: add_or_xor_sub1 (any) -> add_or_xor_sub2 (any)
					next_state <= "1011";
				elsif (state = "1011") then							--Path: add_or_xor2 (any) -> PC Instruction to instruction register & PC increments by 1
					next_state <= "0100";
				elsif (state = "0101" and f1f0 = "010") then		--Path: Instruction Register Instruction to Decoder -> ldpc
					next_state <= "1100";
				elsif (state = "1100") then							--Path: ldpc -> PC Instruction to instruction register & PC increments by 1
					next_state <= "0100";
				elsif (state = "0101" and f1f0 = "011") then		--Path: Instruction Register Instruction to Decoder -> branch
					next_state <= "1101";
				elsif (state = "1101") then							--Path: branch -> PC Instruction to instruction register
					next_state <= "0011";
				elsif (state = "0100") then							--Path: PC Instruction to instruction register & PC increments by 1 -> Instruction Register Instruction to Decoder
					next_state <= "0101";
				else
					next_state <= "1111";								--?? Terminate the code. This shouldn't be the case if we want to do multiple operations, no? Go back to start, then?
				end if;
		end process;
END behavioural;
