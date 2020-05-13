LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_counter IS 
END testbench_counter;

ARCHITECTURE behavior OF testbench_counter IS

   -- Components that are being compared. You must add your component here for your counter
	-- Your component should have Enable, Clock and Clear signals
	COMPONENT my_counter
		PORT ( 	
			en : in std_logic; 
			clk : in std_logic;
			clear : in std_logic;
			count : out STD_LOGIC_VECTOR(15 DOWNTO 0)
				);
	END COMPONENT;
	
	-- declare inputs and initialize them. You can only initialise 
	-- values in a testbench; this is not synthesizable, just for
	-- testing:
	signal cnt: integer:= 0;
	
    signal clk_in  : STD_LOGIC:= '0';
    signal en_in,  clear_in  : STD_LOGIC;
	signal count_out: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	-- You must insantiate your module here

	   uut: my_counter PORT MAP (
			en 	=> en_in,
			clk	=> clk_in,
			clear 	=> clear_in,
			count 	=> count_out
        );    
	
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk_in <= not(clk_in);
	end process;

	counter_proc: process (clk_in)
   begin         
		if (rising_edge(clk_in)) then
			cnt <= cnt+1;
		end if;
	end process;

	process (cnt)
	begin  
		case cnt is 
			when 0 		=> 	clear_in <= '1'; en_in <= '0';
			when 1 		=> 	clear_in <= '1'; en_in <= '0';	
			when 2 		=> 	clear_in <= '1'; en_in <= '0';
			when 3 		=> 	clear_in <= '0'; en_in <= '0';
			when 4 		=> 	clear_in <= '0'; en_in <= '0';
			when 20 		=> 	clear_in <= '0'; en_in <= '0';
			when 21 		=> 	clear_in <= '0'; en_in <= '0';
			when 40 		=> 	clear_in <= '0'; en_in <= '0';
			when others	=> 	clear_in <= '0'; en_in <= '1'; 
		end case;
	end process;	

  
END;
