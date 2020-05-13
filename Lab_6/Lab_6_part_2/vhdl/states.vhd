LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  


ENTITY states is
	port ( 	reset, w, clk: IN std_logic; 
				states: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				outs : OUT std_logic
			);
END;
		
ARCHITECTURE behavioural of states is

	component next_state
		port ( 	state: IN std_logic_vector(3 downto 0); 
					w, reset: IN std_logic;
					next_state : OUT std_logic_vector(3 downto 0)
				);
	END component;


		
	signal state, ns : std_logic_vector(3 downto 0);
		
begin
	
		a: next_state port map ( state => state, w => w, reset => reset, next_state => ns);
		b: outputsig port map ( state => state , my_out => outs);
		
	PROCESS (clk)
	begin
		if rising_edge(clk) then
				state <= ns;
				
		end if;
	END PROCESS;
	
	
	states <= state;
END behavioural;
