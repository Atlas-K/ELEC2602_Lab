LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY my_counter IS 
		PORT ( 	
			EN : in std_logic; 
			clk : in std_logic;
			clear : in std_logic;
			count : out STD_LOGIC_VECTOR(15 DOWNTO 0)
				);
END my_counter;

ARCHITECTURE behavior OF my_counter IS

	COMPONENT my_TFF
		PORT ( 	
			T, EN : in std_logic; 
			clk : in std_logic;
			clear_in : in std_logic;
			Q, nQ: out std_logic
				);
	END COMPONENT;

	
	signal temp_q : STD_LOGIC_VECTOR(13 DOWNTO 0);
	signal temp_T : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	temp_q(0)  <= temp_T(0)  AND temp_T(1);
	temp_q(1)  <= temp_q(0)  AND temp_T(2);
	temp_q(2)  <= temp_q(1)  AND temp_T(3);
	temp_q(3)  <= temp_q(2)  AND temp_T(4);
	temp_q(4)  <= temp_q(3)  AND temp_T(5);
	temp_q(5)  <= temp_q(4)  AND temp_T(6);
	temp_q(6)  <= temp_q(5)  AND temp_T(7);
	temp_q(7)  <= temp_q(6)  AND temp_T(8);
	temp_q(8)  <= temp_q(7)  AND temp_T(9);
	temp_q(9)  <= temp_q(8)  AND temp_T(10);
	temp_q(10) <= temp_q(9)  AND temp_T(11);
	temp_q(11) <= temp_q(10) AND temp_T(12);
	temp_q(12) <= temp_q(11) AND temp_T(13);
	temp_q(13) <= temp_q(12) AND temp_T(14);
	count <= temp_T(15) & temp_T(14) & temp_T(13) & temp_T(12) & temp_T(11) & temp_T(10) & temp_T(9) & temp_T(8) &
	temp_T(7) & temp_T(6) & temp_T(5) & temp_T(4) & temp_T(3) & temp_T(2) & temp_T(1) & temp_T(0);
	
	TFF_Q00: my_TFF PORT MAP (
		T => EN,
		clk => clk,
		clear_in => clear,
		Q => temp_T(0),
		EN => EN
	);
	
	TFF_Q01: my_TFF PORT MAP (
		T => temp_T(0),
		clk => clk,
		clear_in => clear,
		Q => temp_T(1),
		EN => EN
	);
	
	TFF_Q02: my_TFF PORT MAP (
		T => temp_q(0),
		clk => clk,
		clear_in => clear,
		Q => temp_t(2),
		EN => EN
	);
	
	TFF_Q03: my_TFF PORT MAP (
		T => temp_q(1),
		clk => clk,
		clear_in => clear,
		Q => temp_t(3),
		EN => EN
	);

	TFF_Q04: my_TFF PORT MAP (
		T => temp_q(2),
		clk => clk,
		clear_in => clear,
		Q => temp_T(4),
		EN => EN
	);
	
	TFF_Q05: my_TFF PORT MAP (
		T => temp_q(3),
		clk => clk,
		clear_in => clear,
		Q => temp_T(5),
		EN => EN
	);
	
	TFF_Q06: my_TFF PORT MAP (
		T => temp_q(4),
		clk => clk,
		clear_in => clear,
		Q => temp_t(6),
		EN => EN
	);
	
	TFF_Q07: my_TFF PORT MAP (
		T => temp_q(5),
		clk => clk,
		clear_in => clear,
		Q => temp_t(7),
		EN => EN
	);
	
	TFF_Q08: my_TFF PORT MAP (
		T => temp_q(6),
		clk => clk,
		clear_in => clear,
		Q => temp_T(8),
		EN => EN
	);
	
	TFF_Q09: my_TFF PORT MAP (
		T => temp_q(7),
		clk => clk,
		clear_in => clear,
		Q => temp_T(9),
		EN => EN
	);
	
	TFF_Q10: my_TFF PORT MAP (
		T => temp_q(8),
		clk => clk,
		clear_in => clear,
		Q => temp_t(10),
		EN => EN
	);
	
	TFF_Q11: my_TFF PORT MAP (
		T => temp_q(9),
		clk => clk,
		clear_in => clear,
		Q => temp_t(11),
		EN => EN
	);
	
	TFF_Q12: my_TFF PORT MAP (
		T => temp_q(10),
		clk => clk,
		clear_in => clear,
		Q => temp_T(12),
		EN => EN
	);
	
	TFF_Q13: my_TFF PORT MAP (
		T => temp_q(11),
		clk => clk,
		clear_in => clear,
		Q => temp_T(13),
		EN => EN
	);
	
	TFF_Q14: my_TFF PORT MAP (
		T => temp_q(12),
		clk => clk,
		clear_in => clear,
		Q => temp_t(14),
		EN => EN
	);
	
	TFF_Q15: my_TFF PORT MAP (
		T => temp_q(13),
		clk => clk,
		clear_in => clear,
		Q => temp_t(15),
		EN => EN
	);

END;
