LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_project IS 
END testbench_project;

ARCHITECTURE behavior OF testbench_project IS

    -- Components
	COMPONENT my_FSM
		port (	
					<< Fill_in_here>>
		); 
	END COMPONENT;
	
	COMPONENT my_Datapath
		port (	
					<< Fill_in_here>>
		
		); 
	END COMPONENT;
	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	signal clk_in, reset_in  : STD_LOGIC:= '0';
	
	-- Internal Signals
	signal code 				: std_logic_vector(8 downto 0);
	--<< Add your own signals >>
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	a: my_FSM port map ( << Fill_in_here>>
								
	);
	
	b: my_Datapath port map ( << Fill_in_here>>
								);
	
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk_in <= not(clk_in);
	end process;
	
   stim_proc2: process(clk_in) 
	begin
		if rising_edge(clk_in) then
			cnt <= cnt+1;
		end if;
	end process;

	-- This gives a set of simple instructions. It also has a simple flag whenever a new instruction is added
	process (cnt)
	begin  
		case cnt is 
			-- Reset
			when 0 to 4		=> 	reset_in <= '1'; code <= ("000" & "000" & "000"); new_instruction <= '0';
			
			-- load 		r0 1
			when 5 			=> 	reset_in <= '0'; code <= ("000" & "000" & "001"); new_instruction <= '1';
			when 6 to 9		=> 	reset_in <= '0'; code <= ("000" & "000" & "001"); new_instruction <= '0';
			--	load 		r1 1
			when 10 		=> 	reset_in <= '0'; code <= ("000" & "000" & "001"); new_instruction <= '1';
			when 11 to 14	=> 	reset_in <= '0'; code <= ("000" & "000" & "001"); new_instruction <= '0';
			-- add		r0	r1
			when 15 		=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '1';
			when 16 to 19	=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '0';
			-- add		r0	r1
			when 20 		=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '1';
			when 21 to 24	=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '0';
			--	add		r0	r1
			when 25			=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '1';
			when 26 to 29	=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '0';
			-- add		r0	r1
			when 30 		=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '1';
			when 31 to 34	=> 	reset_in <= '0'; code <= ("010" & "000" & "001"); new_instruction <= '0';
			--	load 		r2 2
			when 35			=> 	reset_in <= '0'; code <= ("000" & "010" & "010"); new_instruction <= '1';
			when 36 to 39	=> 	reset_in <= '0'; code <= ("000" & "010" & "010"); new_instruction <= '0';
			--	add		r0	r1
			when 40			=> 	reset_in <= '0'; code <= ("010" & "000" & "010"); new_instruction <= '1';
			when 41 to 44	=> 	reset_in <= '0'; code <= ("010" & "000" & "010"); new_instruction <= '0';
			
			when others		=> 	reset_in <= '1'; code <= ("000" & "000" & "000"); new_instruction <= '0';
		end case;
	end process;
	
	
END;
