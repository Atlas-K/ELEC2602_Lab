library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg_file is
	generic( ADDR_SIZE: integer := 3; --8 regs
				DATA_SIZE: integer := 16;
				);
	
	port( clk: in std_logic;
			reg0sel: in std_logic_vector(ADDR_SIZE - 1 downto 0); --always write for internal, only reg for external
			reg1sel: in std_logic_vector(ADDR_SIZE - 1 downto 0);
			mode: in std_logic;
			rw_mode: i std_logic;
			input: in std_logic_vector(DATA_SIZE - 1 downto 0);
			output: out std_logic_vector(DATA_SIZE - 1 downto 0)
	);
	
end;

architecture Behavior of reg_file is
	type reg is array(0 to 2**ADDR_SIZE - 1) of std_logic_vector(DATA_SIZE - 1 downto 0);
	signal reg_bus: reg;
	
	w: process(clk)
		variable write_reg: unsigned range 0 to 2**ADDR_SIZE - 1;
		variable read_reg: unsigned range 0 to 2**ADDR_SIZE - 1;
	begin
		if clk = '1' and clk'event then
			internal: if mode = '0' then
							write_reg := conv_unsigned(reg0sel);
							read_reg := conv_unsigned(reg1sel);
							reg_bus(write_reg) <= reg_bus(read_reg);
							output <= ('others' => 'Z');
		external_in: elsif mode = '1' then
							if rw_mode = '0' then
								write_reg := conv_unsigned(reg0sel);
								reg_bus(write_reg) <= input;
								output <= ('others' => 'Z');
	    external_out: elsif rw_mode = '1' then
								read_reg := conv_unsigned(reg0sel);
								output <= reg_bus(read_reg);
							end if;
						end if;
		end if;
	end process;
end reg_file;