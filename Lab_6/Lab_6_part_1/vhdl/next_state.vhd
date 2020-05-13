LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  

ENTITY next_state is
	port ( 	state: IN std_logic_vector(3 downto 0); 
				w, reset: IN std_logic;
				next_state : OUT std_logic_vector(3 downto 0));
END;

ARCHITECTURE behavioural of next_state is
	begin
		process(w, state,reset)
				variable temp : std_logic_vector(4 downto 0);
		
		begin
			temp:= state & w;
			if reset = '1' then
				next_state <= "0000";
			else
				case temp is
          --0000: A
          --0001: B
          --0010: C
          --0011: D
          --0100: E
          --0101: F
          --0110: G
          --0111: H
          --1000: I
          --  XXXX   X--
          --{state} {W}--
					when "00000" => next_state <= "0001"; --A/0 -> B/0
					when "00001" => next_state <= "0101"; --A/0 -> F/0
					when "00010" => next_state <= "0010"; --B/0 -> C/0
					when "00011" => next_state <= "0101"; --B/0 -> F/0
					when "00100" => next_state <= "0011"; --C/0 -> D/0
					when "00101" => next_state <= "0101"; --C/0 -> F/0
					when "00110" => next_state <= "0100"; --D/0 -> E/0
					when "00111" => next_state <= "0101"; --D/0 -> F/0
					when "01000" => next_state <= "0100"; --E/0 -> E/0
					when "01001" => next_state <= "0101"; --E/0 -> F/0
					when "01010" => next_state <= "0001"; --F/0 -> B/0
					when "01011" => next_state <= "0110"; --F/0 -> G/0
					when "01100" => next_state <= "0001"; --G/0 -> B/0
					when "01101" => next_state <= "0111"; --G/0 -> H/0
					when "01110" => next_state <= "0001"; --H/0 -> B/0
					when "01111" => next_state <= "1000"; --H/0 -> I/0
					when "10000" => next_state <= "0001"; --I/0 -> B/0
					when "10001" => next_state <= "1000"; --I/0 -> I/0
					when others => next_state <= "0000"; --reset
				end case; --pp
			end if;
end process;
END behavioural;
        
-----------outputsig-----------
        
        LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
library STD;
use STD.textio.all;  


ENTITY outputsig is
	port ( 	state: IN std_logic_vector(3 downto 0);
				my_out : OUT std_logic);
END;


ARCHITECTURE behavioural of outputsig is

		begin
			process(state)
				begin
					if (state = "0100" OR state = "1000") then
							my_out <= '1';
					else 
							my_out <= '0';
					end if;
			end process;
END behavioural;
