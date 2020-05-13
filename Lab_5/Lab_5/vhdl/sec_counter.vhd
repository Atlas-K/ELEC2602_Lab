LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY sec_counter IS 
		PORT ( 	
			EN : in std_logic; 
			clk1Khz: in std_logic;
			clear_in : in std_logic;
			Q : out STD_LOGIC_VECTOR(15 DOWNTO 0)
				);
END sec_counter;

ARCHITECTURE behavior OF sec_counter IS
		
	COMPONENT my_counter IS
		PORT ( 
			EN : in std_logic; 
			clk : in std_logic;
			clear : in std_logic;
			count : out STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT counter_w_process IS
		PORT ( 
			EN: IN STD_LOGIC;
			clk : in std_logic;
			clear : in std_logic;
			Q : out std_logic_VECTOR(15 downto 0)
		);
	END COMPONENT;

	signal sec_counter_EN, timer_IN, clear_sig: STD_LOGIC;
	signal counter_temp: STD_LOGIC_VECTOR(15 downto 0);
	
BEGIN
	PROCESS (clk1KHz)
	BEGIN
		IF counter_temp = 999 THEN
			clear_sig <= '1';
			timer_IN <= '1';
		ELSE
			timer_IN <= '0';
			clear_sig <= '0';
		END IF;
	END PROCESS;

	COUNTER: my_counter PORT MAP (
		EN => EN,
		clk => clk1KHz,
		clear => clear_sig,
		count => counter_temp
	);
	
	TIMER: counter_w_process PORT MAP (
		EN => timer_IN,
		clk => clk1KHz,
		clear => clear_in,
		Q => Q
	);

	
END behavior;
