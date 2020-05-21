library IEEE;
use IEEE.std_logic_1164.all;


ENTITY password_nextstate IS
	PORT (
		  state : IN STD_LOGIC_VECTOR(3 downto 0);
        input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  password : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        reset : IN STD_LOGIC;
        nstate : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
    
END password_nextstate;

ARCHITECTURE behaviour OF password_nextstate IS

	
	
	
BEGIN

	process(state,input,reset)
	variable temp : STD_LOGIC_VECTOR(4 downto 0);
	begin
		 
	  if reset = '1' then
		 nstate <= "0000";
	  else

		 case state is

			  when "0000" => nstate <= "0001"; --default reset state. Enter pass r0.
			  
			  when "0001" => nstate <= "0010"; -- enter pass r1
			  when "0010" => nstate <= "0011"; -- enter pass r2
			  when "0011" => nstate <= "0100"; -- enter pass r3
			  when "0100" => 
					if input(0) = password(0) then	-- check pass r0
						nstate <= "0101";
					else
						nstate <= "0100";
					end if;
			  when "0101" => 
					if input = password then	-- check pass r1
						nstate <= "0110";
					else
						nstate <= "0100";
					end if;
			  when "0110" => 
					if input = password then	-- check pass r2
						nstate <= "0111";
					else
						nstate <= "0100";
					end if;
			  when "0111" => 
					if input = password then	-- check pass r3
						nstate <= "1000";
					else
						nstate <= "0100";
					end if;
					
			  when "1000" => nstate <= "0100";	-- correct state
			  
			  when others => nstate <= "0000";

		 end case;

	  end if;
		 

	end process;


END behaviour;