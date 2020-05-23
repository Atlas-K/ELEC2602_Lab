LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY outputsig is
	port (
				--When assigning signals, remember that if the "signals" at the bottom are IN then, in the FSM: signals <= component_signal. If OUT, then component_signal <= signals
				state: 	IN std_logic_vector (3 downto 0);
				output_op_code_from_decoder : IN std_LOGIC_VECTOR (2 downto 0);		--This is the output op-code from the decoder (connect in FSM with decoder)
				output_arg1_from_decoder : IN std_logic_vector (15 downto 0);		--This is the output arg1 from the decoder (connect in FSM with decoder)
				output_arg2_from_decoder : IN std_logic_vector (15 downto 0);		--This is the output arg2 from the decoder (connect in FSM with decoder)
				output_output_from_reg_file : IN std_LOGIC_VECTOR (15 downto 0);  --This is the output output from the reg_file (connect in FSM with reg_file)
				output_C_from_ALU2		 : IN std_LOGIC_VECTOR (15 downto 0);		--This is the output C from the ALU2 (connect in FSM with ALU2)
				to_reg0sel_in_reg_file 	 :OUT std_LOGIC_VECTOR (2 downto 0); 		--Connect in FSM with reg0sel of reg_file
				to_reg1sel_in_reg_file 	 :OUT std_LOGIC_VECTOR (2 downto 0); 		--Connect in FSM with reg1sel of reg_file
				to_mode_in_reg_file 	 	 :OUT std_logic; 									--Connect in FSM with mode of reg_file
				to_rw_mode_in_reg_file	 :OUT std_LOGIC; 									--Connect in FSM with rw_mode of reg_file
				to_A_in_ALU2				 :OUT std_LOGIC_VECTOR (15 downto 0);		--Connect in FSM with A of ALU2
				to_A_SET_in_ALU2			 :OUT std_LOGIC;									--Connect in FSM with A_SET of ALU2
				to_B_in_ALU2				 :OUT std_LOGIC_VECTOR (15 downto 0);		--Connect in FSM with B of ALU2
				to_TRIGGER_in_ALU2		 :OUT std_LOGIc;									--Connect in FSM with TRIGGER of ALU2
				
				
			);
END;


ARCHITECTURE behavioural of outputsig is

signal	temp_arg1_from_decoder std_LOGIC_VECTOR (15 downto 0);
signal	temp_arg2_from_decoder std_LOGIC_VECTOR (15 downto 0);
signal	temp_output_output_from_reg_file std_LOGIC_VECTOR (15 downto 0);
signal	temp_output_op_code_from_decoder (2 downto 0);
signal	temp_output_C_from_ALU2 (15 downto 0);

	begin
			process(state)
			begin
				case state is
					when "0000" => --During reset
						--
					when "0001" => --During store instructions
						--
					when "0010" => --During PC load instruction 0
						--
					when "0011" => --During PC instruction to instruction register
						--
					when "0100" => --During PC instruction to instruction register & PC increments by 1
						--
					when "0101" => --During Instruction register instruction to Decoder
						--
					when "0110" => --During load.
						to_reg0sel_in_reg_file <= "111"; 										--This is the register where we will load the value (to be MOVED in the next state).
						to_mode_in_reg_file <= '1'; 	
						to_rw_mode_in_reg_file <= '0';								
																											--?? Where will I get the input (for the input of reg_file) from? This is the load value I am speaking of.
					when "0111" => --During move (move only)
						temp_arg1_from_decoder <= output_arg1_from_decoder;				--arg1 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg0sel_in_reg_file <= temp_arg1_from_decoder;					--arg1 has now been assigned to the reg0sel of reg_file
						temp_arg2_from_decoder <= output_arg2_from_decoder;				--arg2 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg1sel_in_reg_file <= temp_arg2_from_decoder;					--arg2 has now been assigned to the reg1sel of reg_file
						to_mode_in_reg_file <= '0'; 	
						to_rw_mode_in_reg_file <= '0';											--As Moses stated, this can be either 0 or 1 for MOVE, it doesn't matter.	
					when "1110" =>	--During load1
						temp_arg1_from_decoder <= output_arg1_from_decoder;				--arg1 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg0sel_in_reg_file <= temp_arg1_from_decoder;					--arg1 has now been assigned to the reg0sel of reg_file as this is the location where we will load.
						to_reg1sel_in_reg_file <= "111";											--This is the register where we had loaded the value. Now, we will use it to Move to R[x].
						to_mode_in_reg_file <= '0'; 	
						to_rw_mode_in_reg_file <= '0';											--As Moses stated, this can be either 0 or 1 for MOVE, it doesn't matter.
					when "1000" => --During add_or_xor_sub
						temp_arg1_from_decoder <= output_arg1_from_decoder;				--arg1 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg0sel_in_reg_file <= temp_arg1_from_decoder;					--arg1 has now been assigned to the reg0sel of reg_file
						to_mode_in_reg_file <= '1'; 	
						to_rw_mode_in_reg_file <= '1';
						temp_output_output_from_reg_file <= output_output_from_reg_file;--This temporarily stores the output from the reg_file.
						to_A_in_ALU2 <= temp_output_output_from_reg_file;					 --This sends the output of reg_file to the A input of ALU2.
						to_A_SET_in_ALU2 <= '1';													--This allows the ALU2 to accept the value of A being sent by the reg_file
					when "1001" => --During add_or_xor_sub1
						temp_arg2_from_decoder <= output_arg2_from_decoder;				--arg2 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg0sel_in_reg_file <= temp_arg2_from_decoder;					--arg2 has now been assigned to the reg0sel of reg_file
						to_mode_in_reg_file <= '1'; 	
						to_rw_mode_in_reg_file <= '1';
						temp_output_output_from_reg_file <= output_output_from_reg_file;--This temporarily stores the output from the reg_file.
						to_B_in_ALU2 <= temp_output_output_from_reg_file;					 --This sends the output of reg_file to the B input of ALU2.
						temp_output_op_code_from_decoder <= output_op_code_from_decoder;--This temporarily stores the op_code from the decoder
						to_OP_in_ALU2 <= temp_output_op_code_from_decoder;					--This sends the op_code to the ALU2 so that it knows what operation to perform on A & B.
						to_TRIGGER_in_ALU2 <= '1';													--This allows the ALU2 to accept the value of B being sent by the reg_file and start the operation.
																										--What about the C output of the ALU2? Won't we like to see what the result is? Ans: We will store it.
					when "1011" => --During add_or_xor_sub2
						temp_output_C_from_ALU2 <= output_C_from_ALU2;						--This  temporarily stores the output C from the ALU2.
						to_input_in_reg_file <= temp_output_C_from_ALU2;					--This sends the output C of ALU2 to the "input" of reg_file (to be loaded on R[x]).
						temp_arg1_from_decoder <= output_arg1_from_decoder;				--arg1 from decoder has been temporarily stored (because we cannot assign input to output directly).
						to_reg0sel_in_reg_file <= temp_arg1_from_decoder;					--arg1 has now been assigned to the reg0sel of reg_file
						to_mode_in_reg_file <= '1'; 	
						to_rw_mode_in_reg_file <= '0'; 											--Now reg_file goes into Load mode and changes R[x] to => R[x] <opcode> R[y]
					when "1100" => --During ldpc, see/change
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '0'; 
						pc_out <= '1'; 		
					when "1101" => --During branch, see/change
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '1'; 
						pc_in <= 1;
					when "1111" => ;--Kill state		
					
					--(TODO): Implement FLOOR as part of ALU?
					--when "" =>  <= ; <= ; <= ; <= ; <= ; 			--These ones have been left blank as many other states are prone to change until the other components have been finalised.
					
					--when "" =>  <= ; <= ; <= ; <= ; <= ;			--Once that is done, finish these states and then head on to the final file, CC, to assign all wires
					
					--when "" =>  <= ; <= ; <= ; <= ; <= ;			--To each component that you have used. There will be a lot of output for this file
					
					--when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					--when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					--when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					--when others =>  <= "";  <= "";
				end case;
			end process;
	END behavioural;
