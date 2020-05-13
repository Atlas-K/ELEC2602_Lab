LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY testbench_fourHexDisplay IS 
END testbench_fourHexDisplay;

ARCHITECTURE behavior OF testbench_fourHexDisplay IS

   -- Components that are being studied
	COMPONENT fourHexDisplay
		PORT ( 
					input1		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					input2		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
					clk 			: IN STD_LOGIC;
					reset 			: IN STD_LOGIC;
					out1	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out2	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out3	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
					out4	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
				);
	END COMPONENT;
	
	signal count : integer := 0;
	
	signal clk_in, reset_in : STD_LOGIC:= '0';
	
	signal in1, in2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal hex1, hex2, hex3, hex4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	-- ------------------ Instantiate module under test ------------------
   uut: fourHexDisplay PORT MAP (
			input1 	=> in1,
			input2	=> in2,
			out1 		=> hex1,
			out2 	=> hex2,
			out3 	=> hex3,
			out4 	=> hex4,
			clk => clk_in,
			reset => reset_in
        );     

   -- Toggle inputs at different rates to cover all input 
   -- combinations
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk_in <= not(clk_in);
	end process;

	counter_proc: process (clk_in)
   begin         
		if (rising_edge(clk_in)) then
			count <= count+1;
		end if;
	end process;
	
	process (count)
   begin  
		case count is 
			when 0 		=> 	in1 <= "0000"; in2 <= "0001"; reset_in <='1';	
			when 1 		=> 	in1 <= "0001"; in2 <= "0011"; reset_in <='0';	
			when 2 		=> 	in1 <= "0010"; in2 <= "0111"; reset_in <='0'; 
		   --- Add other cases	
			when others	=> 	in1 <= "0011"; in2 <= "1111"; reset_in <= '0';	 	
		end case;
	end process;
  
END;
