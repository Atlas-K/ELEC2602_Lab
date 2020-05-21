library IEEE;
use IEEE.std_logic_1164.all;


ENTITY password IS
	PORT (
    	clk : IN STD_LOGIC;
    	input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      reset : IN STD_LOGIC;
    	o : OUT STD_LOGIC;
		testS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    
END password;


ARCHITECTURE behaviour OF password IS

  COMPONENT password_nextstate IS
      PORT (
          state : IN STD_LOGIC_VECTOR(3 downto 0);
          input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 password : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          reset : IN STD_LOGIC;
          nstate : OUT STD_LOGIC_VECTOR(3 downto 0)
      );

  END COMPONENT;

  COMPONENT password_output IS
      PORT (
          state : IN STD_LOGIC_VECTOR(3 downto 0);
			 pass_index : OUT std_logic_vector(1 downto 0);
			 w_e : OUT std_logic;
			 correct : OUT STD_LOGIC
      );  
		
  END COMPONENT;

  
	component password_memory IS
		PORT (
			char_index : IN STD_LOGIC_VECTOR(1 downto 0); -- 2 bit to index 4 bytes 0 1 2 3
			write_enable : IN std_logic;
			reset : IN std_logic;
			input : IN STD_LOGIC_VECTOR(3 downto 0);
			output : OUT STD_LOGIC_VECTOR(3 downto 0) -- 4 bit chars
		 );
	END component;
  
signal state, ns : STD_LOGIC_VECTOR(3 downto 0);

signal pass_index : std_logic_vector(1 downto 0);
signal w_e : std_logic;
signal check_pass : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	
	pwmem: password_memory port map(char_index=>pass_index,write_enable=>w_e, reset=>reset,input=>input,output=>check_pass);

	
	nst: password_nextstate port map(state => state, input => input, password => check_pass,reset => reset, nstate => ns);
    ou: password_output port map(state => state, pass_index=>pass_index, w_e=>w_e,correct => o);
    
    process(clk)
    begin
    	if rising_edge(clk) then
        	state <= ns;
        end if;
    end process;
	 
	 testS <= state;
    

END behaviour;