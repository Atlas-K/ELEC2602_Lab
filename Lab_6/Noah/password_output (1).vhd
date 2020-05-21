library IEEE;
use IEEE.std_logic_1164.all;


ENTITY password_output IS
	PORT (
    	state : IN STD_LOGIC_VECTOR(3 downto 0);
		pass_index : OUT std_logic_vector(1 downto 0);
		w_e : OUT std_logic;
		correct : OUT STD_LOGIC
    );
    
END password_output;

ARCHITECTURE behaviour OF password_output IS

BEGIN

process(state)
begin
    case state is
					-- setting password states:
			  when "0000" =>
					correct <= '0'; --default reset state. Enter pass r0.
					w_e <= '1';  -- write enabled for entering password
					pass_index <= "00";  -- r0

			  when "0001" =>
					pass_index <= "01";  -- r1
			  when "0010" =>
					pass_index <= "10";  -- r2
			  when "0011" =>
					pass_index <= "11";  -- r3
					
					-- checking password states:
			  when "0100" => 
					correct <= '0'; -- if re-entering password after being correct
					w_e <= '0'; -- do not overwrite set password!
					pass_index <= "00";  -- r0
			  when "0101" => 
					pass_index <= "01";  -- r1
			  when "0110" => 
					pass_index <= "10";  -- r2
			  when "0111" => 
					pass_index <= "11";  -- r3
					
			  when "1000" => correct <= '1';	-- correct state
			  
			  when others => correct <= '0';

		 end case;
    	
end process;

END behaviour;