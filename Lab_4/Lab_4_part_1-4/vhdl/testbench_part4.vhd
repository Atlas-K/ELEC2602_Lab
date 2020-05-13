LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_part4 IS 
END testbench_part4;

ARCHITECTURE behavior OF testbench_part4 IS

   -- Components that are being studied
	COMPONENT my_latch
		PORT ( 
					Clk, D	: IN STD_LOGIC;
					Q, Qnot 	: OUT STD_LOGIC
				);
	END COMPONENT;
	COMPONENT DFF_neg
		PORT ( 
					Clk, D	: IN STD_LOGIC;
					Q, Qnot 	: OUT STD_LOGIC
				);
	END COMPONENT;
	COMPONENT DFF_pos
		PORT ( 
					Clk, D	: IN STD_LOGIC;
					Q, Qnot 	: OUT STD_LOGIC
				);
	END COMPONENT;
	
	signal count : integer := 0;
	
	signal clk_in, D_in,  Q_out1, Q_not1  : STD_LOGIC;
	signal Q_out2, Q_not2,  Q_out3, Q_not3  : STD_LOGIC;
BEGIN
	-- ------------------ Instantiate module under test ------------------
   uut1: my_latch PORT MAP (
			clk 	=> clk_in,
			D 		=> D_in,
			Q 		=> Q_out1,
			Qnot 	=> Q_not1
        );     
   uut2: dff_neg PORT MAP (
			clk 	=> clk_in,
			D 		=> D_in,
			Q 		=> Q_out2,
			Qnot 	=> Q_not2
        );     
   uut3: dff_pos PORT MAP (
			clk 	=> clk_in,
			D 		=> D_in,
			Q 		=> Q_out3,
			Qnot 	=> Q_not3
        );     


   stim_proc: process 
   begin         
			wait for 50 ns;
			count <= count+1;
	end process;
	
   -- Create different test vectors. Please modify if you want to test anything else
	process (count)
   begin  
		case count is 
			when 0 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 1 		=> 	clk_in <= '0'; D_in <= '1'; 	
			when 2 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 3 		=> 	clk_in <= '0'; D_in <= '1'; 	
			when 4 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 5 		=> 	clk_in <= '1'; D_in <= '0'; 	
			when 6 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 7 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 8 		=> 	clk_in <= '0'; D_in <= '1'; 	
			when 9 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 10 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 11 		=> 	clk_in <= '0'; D_in <= '0'; 		
			when 12 		=> 	clk_in <= '1'; D_in <= '0'; 	
			when 13 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 14 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 15 		=> 	clk_in <= '1'; D_in <= '0'; 		
			when 16 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 17 		=> 	clk_in <= '0'; D_in <= '1'; 	
			when 18 		=> 	clk_in <= '0'; D_in <= '1'; 	
			when 19 		=> 	clk_in <= '0'; D_in <= '0'; 	
			when 20 		=> 	clk_in <= '1'; D_in <= '0'; 	
			when 21 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 22 		=> 	clk_in <= '1'; D_in <= '1'; 	
			when 23 		=> 	clk_in <= '1'; D_in <= '0'; 
			when others	=> 	clk_in <= '0'; D_in <= '0'; 
		end case;
	end process;
  
END;
