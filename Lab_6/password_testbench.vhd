LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY password_testbench IS 
END password_testbench;

ARCHITECTURE behavior OF password_testbench IS

    -- Components that are being compared. You must add your components here for your counter
	-- Your component should have  clock, reset, w  inputs and z outputs
	-- Use 2 components if comparing two versions. Otherwise delete z_out2
	COMPONENT password
		PORT ( 		
          clk : IN STD_LOGIC;
          input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          reset : IN STD_LOGIC;
          o : OUT STD_LOGIC;
			 testS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			 index: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			 check: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
				);
	END COMPONENT;

	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	
	signal clk_in, reset_in  : STD_LOGIC:= '0';
	signal input_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal output: STD_LOGIC;
	
	signal sstate: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal index: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal check: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	
	-- ------------------ Instantiate modules ------------------
	-- You must insantiate your modules here
	-- you must map clk_in to your clock input, reset_in to your reset input
	-- w_in to your w input and z_out to your output signal
    
   s0: password port map (clk => clk_in, input => input_in, reset => reset_in, o => output, testS=>sstate, index => index, check => check);
	
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
				when 1 		=> 	input_in <= "0000"; reset_in <= '0';
				when 2 		=> 	input_in <= "1000"; reset_in <= '0';
				when 3 		=> 	input_in <= "1100"; reset_in <= '0';
				when 4 		=> 	input_in <= "1110"; reset_in <= '0';
				when 5 		=> 	input_in <= "1000"; reset_in <= '0';
				when 6 		=> 	input_in <= "0100"; reset_in <= '0';
				when 7 		=> 	input_in <= "0000"; reset_in <= '0';
				when 8 		=> 	input_in <= "0110"; reset_in <= '0';
				when 9 		=> 	input_in <= "0000"; reset_in <= '0';
				when 10 		=> 	input_in <= "1000"; reset_in <= '0';
				when 11 		=> 	input_in <= "1100"; reset_in <= '0';
				when 12 		=> 	input_in <= "1110"; reset_in <= '0';
				when others	=> 	input_in <= "UUUU"; reset_in <= '0'; 
			end case;
		end process;	

  
END;