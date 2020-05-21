library IEEE;
use IEEE.std_logic_1164.all;


ENTITY seq_detector IS
	PORT (
    	clk : IN STD_LOGIC;
    	w : IN STD_LOGIC;
      reset : IN STD_LOGIC;
    	o : OUT STD_LOGIC;
		testS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    
END seq_detector;


ARCHITECTURE behaviour OF seq_detector IS

  COMPONENT nextstate IS
      PORT (
          state : IN STD_LOGIC_VECTOR(3 downto 0);
          w : IN STD_LOGIC;
          reset : IN STD_LOGIC;
          nstate : OUT STD_LOGIC_VECTOR(3 downto 0)
      );

  END COMPONENT;

  COMPONENT outputcomb IS
      PORT (
          state : IN STD_LOGIC_VECTOR(3 downto 0);
          output : OUT STD_LOGIC
      );

  END COMPONENT;

signal state, ns : STD_LOGIC_VECTOR(3 downto 0);

BEGIN

	nst: nextstate port map(state => state, w => w, reset => reset, nstate => ns);
    ou: outputcomb port map(state => state, output => o);
    
    process(clk)
    begin
    	if rising_edge(clk) then
        	state <= ns;
        end if;
    end process;
	 
	 testS <= state;
    

END behaviour;