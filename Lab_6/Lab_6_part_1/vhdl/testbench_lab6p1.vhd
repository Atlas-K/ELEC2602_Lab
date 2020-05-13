LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_lab6p1 IS 
END testbench_lab6p1;

ARCHITECTURE behavior OF testbench_lab6p1 IS

    -- Components that are being compared. You must add your components here for your counter
	-- Your component should have  clock, reset, w  inputs and z outputs
	-- Use 2 components if comparing two versions. Otherwise delete z_out2
	COMPONENT seq_detect
		PORT (reset, w, clk: IN std_logic; 
				states: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				outs : OUT std_logic 			
				);
	END COMPONENT;
	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	
	signal clk, w, reset: STD_LOGIC:= '0';
	signal outs: STD_LOGIC;
	signal states: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	-- You must insantiate your modules here
	-- you must map clk_in to your clock input, reset_in to your reset input
	-- w_in to your w input and z_out to your output signal
	
	uut: seq_detect PORT MAP (
	reset => reset,
	w => w,
	clk => clk,
	states => states,
	outs => outs
	);
	
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk <= not(clk);
	end process;
	
   stim_proc2: process(clk) 
	begin
		if rising_edge(clk) then
			cnt <= cnt+1;
		end if;
	end process;

	process (cnt)
		 begin  
			case cnt is 
				when 0 		=> 	reset <= '1'; w <= '0';
				when 1 		=> 	reset <= '1'; w <= '0';	
				when 7 		=> 	reset <= '0'; w <= '1';
				when 11 		=> 	reset <= '0'; w <= '1';
				when 12 		=> 	reset <= '0'; w <= '1';
				when 13 		=> 	reset <= '0'; w <= '1';
				when 15 		=> 	reset <= '0'; w <= '1';
				when 16 		=> 	reset <= '0'; w <= '1';
				when 17 		=> 	reset <= '0'; w <= '1';
				when 18 		=> 	reset <= '0'; w <= '1';
				when 19 		=> 	reset <= '0'; w <= '1';
				when 20 		=> 	reset <= '0'; w <= '1';
				when 21 		=> 	reset <= '0'; w <= '1';
				when others	=> 	reset <= '0'; w <= '0'; 
			end case;
		end process;	

  
END;
