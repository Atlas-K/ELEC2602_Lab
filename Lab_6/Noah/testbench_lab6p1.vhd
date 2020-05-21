LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_lab6p1 IS 
END testbench_lab6p1;

ARCHITECTURE behavior OF testbench_lab6p1 IS

    -- Components that are being compared. You must add your components here for your counter
	-- Your component should have  clock, reset, w  inputs and z outputs
	-- Use 2 components if comparing two versions. Otherwise delete z_out2
	COMPONENT seq_detector
		PORT ( 		
          clk : IN STD_LOGIC;
          w : IN STD_LOGIC;
          reset : IN STD_LOGIC;
          o : OUT STD_LOGIC;
			 testS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
				);
	END COMPONENT;

	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	
	signal clk_in, w_in, reset_in  : STD_LOGIC:= '0';
	signal z_out1: STD_LOGIC;
	signal z_out2: STD_LOGIC;
	signal sstate: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	-- You must insantiate your modules here
	-- you must map clk_in to your clock input, reset_in to your reset input
	-- w_in to your w input and z_out to your output signal
    
   s0: seq_detector port map (clk => clk_in, w => w_in, reset => reset_in, o => z_out1,testS=>sstate);
	
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk_in <= not(clk_in);
            if cnt > 50 then
            	wait;
            end if;
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
				when 0 		=> 	reset_in <= '1'; w_in <= '0';
				when 1 		=> 	reset_in <= '1'; w_in <= '0';	
				when 7 		=> 	reset_in <= '0'; w_in <= '1';
				when 11 		=> 	reset_in <= '0'; w_in <= '1';
				when 12 		=> 	reset_in <= '0'; w_in <= '1';
				when 13 		=> 	reset_in <= '0'; w_in <= '1';
				when 15 		=> 	reset_in <= '0'; w_in <= '1';
				when 16 		=> 	reset_in <= '0'; w_in <= '1';
				when 17 		=> 	reset_in <= '0'; w_in <= '1';
				when 18 		=> 	reset_in <= '0'; w_in <= '1';
				when 19 		=> 	reset_in <= '0'; w_in <= '1';
				when 20 		=> 	reset_in <= '0'; w_in <= '1';
				when 21 		=> 	reset_in <= '0'; w_in <= '1';
				when others	=> 	reset_in <= '0'; w_in <= '0'; 
			end case;
		end process;	

  
END;
