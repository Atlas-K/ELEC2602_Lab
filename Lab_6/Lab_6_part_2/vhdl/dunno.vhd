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
          --0000: null
			 --0001: store pw1
			 --0010: store pw2
			 --0011: store pw3
			 --0100: store pw4
			 --0101: correct pw1
			 --0110: correct pw2
			 --0111: correct pw3
			 --1000: correct pw4
			 --1001: incorrect pw1
			 --1010: incorrect pw2
			 --1011: incorrect pw3
			 --1100  incorrect pw4
			 --1101: valid passcode
			 --1110: invalid passcode
			 --if state 0000 => state 0001 => state 0010 => state 0011 => state 0100
			 --if state 0100 and pw1 correct => state 0101
									-- pw1 incorrect => state 1001
			 --if state 0101 and pw2 correct => state 0110
									-- pw2 incorrect => state 1010
			 --if state 0110 and pw3 correct => state 0111
									-- pw3 incorrect => state 1011
			 --if state 0111 and pw4 correct => state 1000
									-- pw4 incorrect => state 1100
			 --if state 1000 => state 1101
			 --if state 1001 => state 1010 => state 1011 => state 1100 => state 1110
			 --if state 1101 => output(z) = 1
			 --if state 1110 => output(z) = 0
			 --correct pw: w=1, incorrect pw: w=0
			 --from state 0000 to state 0100, w, z = 0
			 --from state 0101 to state 1100, w = 0
			 --DONE
			 
          --  XXX    X --
          --{state} {W}--
					when "0000" => next_state <= "0001"; --A/0 -> B/0
					when "0001" => next_state <= "0101"; --A/0 -> F/0
					when "0010" => next_state <= "0010"; --B/0 -> C/0
					when "0011" => next_state <= "0101"; --B/0 -> F/0
					when "0100" => next_state <= "0011"; --C/0 -> D/0
					when "0101" => next_state <= "0101"; --C/0 -> F/0
					when "00110" => next_state <= "0100"; --D/0 -> E/0
					when "00111" => next_state <= "0101"; --D/0 -> F/0
					when "01000" => next_state <= "0100"; --E/0 -> E/0
					when "01001" => next_state <= "0101"; --E/0 -> F/0
					when "01010" => next_state <= "0001"; --F/0 -> B/0
					when "01011" => next_state <= "0110"; --F/0 -> G/0
					when "01100" => next_state <= "0001"; --G/0 -> B/0
					when "01101" => next_state <= "0111";--G/0 -> H/0
					when "01110" => next_state <= "0001"; --H/0 -> B/0
					when "01111" => next_state <= "1000"; --H/0 -> I/0
					when "10000" => next_state <= "0001"; --I/0 -> B/0
					when "10001" => next_state <= "1000"; --I/0 -> I/0
					when others => next_state <= "0000"; --reset
				end case; --peepeepoopoo
			end if;
end process;
END behavioural;