library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RAM is
	generic( ADDR_SIZE: integer := 14; --0x0000 to 0x3FFF
				DATA_SIZE: integer := 16;
				);
	
	port(w_en: in std_logic;
	w_addr: in std_logic_vector(ADDR_SIZE - 1 downto 0);
	r_addr: in std_logic_vector(ADDR_SIZE - 1 downto 0);
	data_in: in std_logic_vector(DATA_SIZE - 1 downto 0);
	clk: in std_logic;
	data_out out std_logic_vector(DATA_SIZE - 1 downto 0);
	);
	
end;

architecture Behavior of RAM is
	type memory is array(0 to 2**ADDR_SIZE - 1) of std_logic_vector(DATA_SIZE - 1 downto 0);
	signal mem_bus: memory;
	
	w: process(clk)
		variable write_addr: unsigned range 0 to 2**ADDR_SIZE - 1;
	begin
		if clk = '1' and clk'event then
			if w_en = '1' then
				write_addr := conv_unsigned(w_addr);
				mem_bus(write_addr) <= data_in;
			end if;
		end if;
	end process;
	
	r: process(r_addr)
		variable read_addr: unsigned range 0 to 2**ADDR_SIZE - 1;
	begin
		read_addr := conv_unsigned(r_addr);
		data_out <= mem_bus(read_addr);
	end process;
end RAM;
