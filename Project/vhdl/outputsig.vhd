LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY outputsig is
	port (
				state: IN std_logic_vector(4 downto 0);
				 : OUT std_logic_vector(2 downto 0); --(TODO): Add component wire names
				reg0sel, reg1sel: OUT std_logic_vector(3 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(1 downto 0);
				mode, rw_mode : OUT std_logic
			);
END;
ARCHITECTURE behavioural of outputsig is
	begin
			process(state)
			begin
				case state is
					when "10001" => --During load. Also need to change R_y.
						decoder_out <= '1'; 
						reg0sel <= R_y; 
						mode <= '1'; 
						rw_mode <= '0';
					when "10010" => --During load_or_move
						reg0sel <= R_x; 
						reg1sel <= R_y; 
						mode <= '0'; 
						rw_mode <= 0/1;	
					when "10100" => --During add1, see if you have to change names / values or not
						reg0sel <= R_y; 
						mode <= '1'; 
						rw_mode <= '1'; 
						alu_mode <= '1';	
					when "10011" => --During add_or_xor, need to change values if needed
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '1'; 
						alu_reg1_in <= '1';	
					when "10110" => --During xor, see if type of values / names changes.
						reg0sel <= R_y; 
						mode <= '1'; 
						rw_mode <= '1'; 
						alu_mode <= '0'';	
					when "10111" => --During add_or_xor1, see/change
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '0'; 
						alu_reg2_out <= '1'; 
					when "11000" => --During ldpc, see/change
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '0'; 
						pc_out <= '1'; 		
					when "11001" => --During branch, see/change
						reg0sel <= R_x; 
						mode <= '1'; 
						rw_mode <= '1'; 
						pc_in <= 1;		
					--(TODO): Implement FLOOR as part of ALU?
					when "" =>  <= ; <= ; <= ; <= ; <= ; 			--These ones have been left blank as many other states are prone to change until the other components have been finalised.
					
					when "" =>  <= ; <= ; <= ; <= ; <= ;			--Once that is done, finish these states and then head on to the final file, CC, to assign all wires
					
					when "" =>  <= ; <= ; <= ; <= ; <= ;			--To each component that you have used. There will be a lot of output for this file
					
					when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					when "" =>  <= ; <= ; <= ; <= ; <= ;
					
					when others =>  <= "";  <= "";
				end case;
			end process;
	END behavioural;