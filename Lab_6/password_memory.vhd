library IEEE;
use IEEE.std_logic_1164.all;

--Asynchronous
ENTITY password_memory IS
	PORT (
    	char_index : IN STD_LOGIC_VECTOR(1 downto 0); -- 2 bit to index 4 bytes 0 1 2 3
		write_enable : IN std_logic;
		reset : IN std_logic;
		input : IN STD_LOGIC_VECTOR(3 downto 0);
      output : OUT STD_LOGIC_VECTOR(3 downto 0) -- 4 bit chars
    );
    
END password_memory;

ARCHITECTURE behaviour OF password_memory IS

signal r0, r1, r2, r3 : std_logic_vector(3 downto 0);


BEGIN

process(char_index, reset)
begin
	if reset='1' then
		r0 <= "0000"; r1 <= "0000"; r2 <= "0000"; r3 <= "0000";
	else
		if write_enable='1' then
		 case char_index is
		 
			when "00" => r0 <= input;
			when "01" => r1 <= input;
			when "10" => r2 <= input;
			when "11" => r3 <= input;
			when others => r0 <= input;
		 end case;
		else
		 case char_index is
		 
			when "00" => output <= r0;
			when "01" => output <= r1;
			when "10" => output <= r2;
			when "11" => output <= r3;
			when others => output <= r0;
		 end case;
		end if;
	end if;
    	
end process;

END behaviour;