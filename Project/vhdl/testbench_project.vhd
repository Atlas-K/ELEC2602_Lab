LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY testbench_project IS 
END testbench_project;

ARCHITECTURE behavior OF testbench_project IS

	COMPONENT FSM
		port (
		clk: IN STD_LOGIC;
        reset: IN STD_LOGIC
		); 
	END COMPONENT;
	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	signal clk_in, reset_in  : STD_LOGIC:= '0';
	
	-- Internal Signals
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	a: FSM port map (
	clk => clk_in,
	reset => reset_in
	);
	
	
   stim_proc: process 
   begin         
			wait for 50ns;
			clk_in <= not(clk_in);
	end process;
	
   stim_proc2: process(clk_in) 
	begin
		if rising_edge(clk_in) then
			cnt <= cnt+1;
		end if;
	end process;

	process (cnt)
	begin  
		case cnt is 
			when 0 => reset_in <= '1';
			when others => reset_in <= '0';
		end case;
	end process;
	--:( 
	
END;
