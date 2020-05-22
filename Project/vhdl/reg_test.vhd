LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

-- entity declaration for your testbench.Dont declare any ports here
ENTITY reg_test IS 
END reg_test;

ARCHITECTURE behavior OF reg_test IS
    -- Components
	COMPONENT reg_file
		port(	
			clk: in std_logic;
			reg0sel: in std_logic_vector(2 downto 0); -- 2bit address
			reg1sel: in std_logic_vector(2 downto 0); -- 2bit address
			mode: in std_logic;                                   -- 0/1
			rw_mode: in std_logic;                                 -- 0/1
			input: in std_logic_vector(15 downto 0);   -- input data port for external input mode
			output: out std_logic_vector(15 downto 0) 
			); 
	END COMPONENT;

	
   -- declare inputs and initialize them. You can only initialise 
   -- values in a testbench; this is not synthesizable, just for
   -- testing:
	signal cnt: integer:= 0;
	signal clk_in  : STD_LOGIC:= '0';
	signal mode, rw_mode  : STD_LOGIC;
	signal reg0sel, reg1sel : STD_LOGIC_VECTOR(2 downto 0);
	signal input : STD_LOGIC_VECTOR(15 downto 0);
	signal output : STD_LOGIC_VECTOR(15 downto 0);
	
BEGIN
	
	-- ------------------ Instantiate modules ------------------
	a: reg_file port map (
						clk => clk_in,
						reg0sel => reg0sel,
						reg1sel => reg1sel,
						mode => mode,
						rw_mode => rw_mode,
						input => input,
						output => output
								
	);
	
   stim_proc: process 
   begin         
			wait for 50 ns;
			clk_in <= not(clk_in);
	end process;
	
   stim_proc2: process(clk_in) 
	begin
		if rising_edge(clk_in) then
			cnt <= cnt+1;
		end if;
	end process;

	-- This gives a set of simple instructions. It also has a simple flag whenever a new instruction is added
	process (cnt)
	begin  
		case cnt is 
			when 0		=> 	reg0sel <= "000"; reg1sel <= "000"; mode <= '1'; rw_mode <= '0'; input <= "0000000000000001";
			when 1		=> 	reg0sel <= "001"; reg1sel <= "001"; mode <= '1'; rw_mode <= '0'; input <= "0000000000000010";
			when 2		=> 	reg0sel <= "000"; reg1sel <= "001"; mode <= '0'; rw_mode <= '0';
			when 3		=> 	reg0sel <= "000"; reg1sel <= "000"; mode <= '1'; rw_mode <= '1';
			when others => 	reg0sel <= "100"; reg1sel <= "101"; mode <= '1'; rw_mode <= '0'; input <= "1100000001100000";

		end case;
	end process;
	
	
END;
