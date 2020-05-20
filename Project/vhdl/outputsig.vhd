LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY outputsig is
	port (
				state: IN std_logic_vector(4 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(2 downto 0);
				 : OUT std_logic_vector(1 downto 0)
			);
END;

ARCHITECTURE behavioural of outputsig is
	begin
			process(state)
			begin
						case state is
							when "10001" => decoder_out <= '1'; reg0sel <= R_y; mode <= '1'; rw_mode = '0';	--During load. Also need to change R_y.
							when "10010" => reg0sel <= R_x; reg1sel <= R_y; mode <= '0'; rw_mode = 0/1;	--During load_or_move
							when "10011" => reg0sel <= R_x; mode <= '1'; rw_mode = '1'; alu_reg1_in = 1;	--During add_or_xor, need to change values if needed
							when "10100" => reg0sel <= R_y; mode <= '1'; rw_mode = '1'; alu_mode = "ADD";	--During add1, see if you have to change names / values or not
							when "10110" => reg0sel <= R_y; mode <= '1'; rw_mode = '1'; alu_mode = "XOR";	--During xor, see if type of values / names changes.
							when "10111" => reg0sel <= R_x; mode <= '1'; rw_mode = '0'; alu_reg2_out = '1'; --During add_or_xor1, see/change
							when "11000" => reg0sel <= R_x; mode <= '1'; rw_mode = '0'; pc_out = '1'; 		--During ldpc, see/change
							when "11001" => reg0sel <= R_x; mode <= '1'; rw_mode = '1'; pc_in = 1;		--During branch, see/change
							
							when "" =>  <= ; <= ; <= ; <= ; <= ; 			--These ones have been left blank as many other states are prone to change until the other components have been finalised.
							
							when "" =>  <= ; <= ; <= ; <= ; <= ;			--Once that is done, finish these states and then head on to the final file, CC, to assign all wires
							
							when "" =>  <= ; <= ; <= ; <= ; <= ;			--To each component that you have used. There will be a lot of output for this file
							
							when "" =>  <= ; <= ; <= ; <= ; <= ;
							
							when "" =>  <= ; <= ; <= ; <= ; <= ;
							
							when "" =>  <= ; <= ; <= ; <= ; <= ;
							
							when others =>  <= "";  <= "";
						end case;
					end if;
			end process;
	END behavioural;