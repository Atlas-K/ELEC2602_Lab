library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_1164.ALL;


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----Reg_file has 3 modes: internal transfer, external input, external output                            ----
----Internal transfer (mode: 0, rw_mode: 0/1, output: Z):                                               ----
----    This mode transfers data from one register to another. reg0 is always the register              ----
----    that is being written and reg1 is always being read. Thus, reg1's data is written on reg0.      ----
----    Used ports: clk, reg0sel, reg1sel, mode                                                         ----
----                                                                                                    ----
----External input (mode: 1, rw_mode: 0, output: Z):                                                    ---- 
----    This mode writes data input to the destination register. The register used in this process      ----
----    is described by reg0sel.                                                                        ----
----    Used ports: clk, reg0sel, mode, rw_mode, input                                                  ----
----                                                                                                    ----
----External output (mode: 1, rw_mode: 1, output: data):                                                ----
----    This mode outputs data from a specific register. The register used in this process              ----
----    is described by reg0sel.                                                                        ----
----    Used ports: clk, reg0sel, mode, rw_mode, output                                                 ----
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


entity reg_file is
   generic(ADDR_SIZE: integer := 3;  -- 8 regs
           DATA_SIZE: integer := 3 -- 16 bit data
           );
   
    port(
		clk: in std_logic;
        reg0sel: in std_logic_vector(ADDR_SIZE - 1 downto 0); -- 2bit address
        reg1sel: in std_logic_vector(ADDR_SIZE - 1 downto 0); -- 2bit address
        mode: in std_logic;                                   -- 0/1
        rw_mode: in std_logic;                                 -- 0/1
        input: in std_logic_vector(DATA_SIZE - 1 downto 0);   -- input data port for external input mode
        output: out std_logic_vector(DATA_SIZE - 1 downto 0)  -- output data port for external output mode
    );

end;

architecture Behavior of reg_file is
    type reg is array(0 to 2**ADDR_SIZE - 1) of std_logic_vector(DATA_SIZE - 1 downto 0);
    signal reg_bus: reg;
begin
   w: process(clk)
      variable write_reg: integer range 0 to 2**ADDR_SIZE - 1;
      variable read_reg: integer range 0 to 2**ADDR_SIZE - 1;
   begin
        if clk = '1' and clk'event then
			if mode = '0' then
				write_reg := conv_integer(reg0sel);
				read_reg := conv_integer(reg1sel);
				reg_bus(write_reg) <= reg_bus(read_reg);
				output <= (others => 'Z');

			elsif mode = '1' then
				if rw_mode = '0' then
					write_reg := conv_integer(reg0sel);
					reg_bus(write_reg) <= input;
					output <= (others => 'Z');

				elsif rw_mode = '1' then
					read_reg := conv_integer(reg0sel);
					output <= reg_bus(read_reg);
				end if;
			end if;
		end if;
	end process;
end Behavior;
