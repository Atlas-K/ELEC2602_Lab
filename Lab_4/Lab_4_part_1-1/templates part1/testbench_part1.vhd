LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_part1 IS 
END testbench_part1;

ARCHITECTURE behavior OF testbench_part1 IS

   -- Components that are being studied
	COMPONENT part1
		PORT ( 
					Clk, R, S : IN STD_LOGIC;
					Q, Qnot : OUT STD_LOGIC
				);
	END COMPONENT;
	
	signal count : integer:=0;
	
	signal clk_in, R_in, S_in, Q_out, Q_not : STD_LOGIC;
BEGIN
	-- ------------------ Instantiate module under test ------------------
   uut: part1 PORT MAP (
			clk 	=> clk_in,
			R 		=> R_in,
			S 		=> S_in,
			Q 		=> Q_out,
			Qnot 	=> Q_not
        );     

   -- Toggle inputs at different rates to cover all input 
   -- combinations
   stim_proc: process 
   begin         
			wait for 50 ns;
			count <= count+1;
	end process;
	
	process (count)
   begin  
		case count is 
			when 0 		=> 	clk_in <= '0'; S_in <= '0'; R_in <= '0'; 	
			when 1 		=> 	clk_in <= '0'; S_in <= '0'; R_in <= '1'; 
			when 2 		=> 	clk_in <= '0'; S_in <= '1'; R_in <= '0'; 
			when 3 		=> 	clk_in <= '0'; S_in <= '1'; R_in <= '1'; 
			when 4 		=> 	clk_in <= '1'; S_in <= '0'; R_in <= '0'; 
			when 5 		=> 	clk_in <= '1'; S_in <= '0'; R_in <= '1'; 	
			when 6 		=> 	clk_in <= '1'; S_in <= '1'; R_in <= '0'; 
			when 7 		=> 	clk_in <= '1'; S_in <= '1'; R_in <= '1'; 	
			when others	=> 	clk_in <= '0'; S_in <= '0'; R_in <= '0'; 
		end case;
	end process;
  
END;
