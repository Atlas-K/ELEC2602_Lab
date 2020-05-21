LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY main is
	port (
            clk: IN STD_LOGIC;
            reset: IN STD_LOGIC
			);
END;
ARCHITECTURE behavioural of main is
    --------------DECLARE COMPONENTS--------------
    COMPONENT ALU
        PORT (
            A, B												: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            clk, AddXor, o_in, o_out, Ain, reset	            : IN STD_LOGIC;
            G													: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT next_state
        PORT (
            state: IN std_logic_vector(3 downto 0); 		--Current State.
            f1f0:  IN std_LOGIC_VECTOR(2 downto 0);		    --The operation to be performed (Add, Move, XOR, etc).
            reg0:  IN std_LOGIC_VECTOR( downto );			--The first register
            reg1:  IN std_LOGIC_VECTOR( downto );			--The second register
            reset: IN std_logic;							--Everyone is familiar with this devil.
            next_state : OUT std_logic_vector(3 downto 0)   --The next state that will be output
        );
    END COMPONENT;

    COMPONENT outputsig
        PORT (
            state: IN std_logic_vector(3 downto 0);
            reg0sel, reg1sel: OUT std_logic_vector(2 downto 0);
            mode, rw_mode, alu_reg1_in, alu_reg2_out: OUT std_logic
        );
    END COMPONENT;

    COMPONENT decoder
        PORT (
            instruction : IN STD_LOGIC_VECTOR(34 DOWNTO 0);
            op_code : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            arg_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            arg_2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
        );
    END COMPONENT;

    COMPONENT RAM
        PORT (
            w_en: in std_logic;
            w_addr: in std_logic_vector(ADDR_SIZE - 1 downto 0);
            r_addr: in std_logic_vector(ADDR_SIZE - 1 downto 0);
            data_in: in std_logic_vector(DATA_SIZE - 1 downto 0);
            clk: in std_logic;
            data_out out std_logic_vector(DATA_SIZE - 1 downto 0)
        );
    END COMPONENT;

    COMPONENT reg_file
        PORT (
            clk: in std_logic;
            reg0sel: in std_logic_vector(ADDR_SIZE - 1 downto 0); -- 2bit address
            reg1sel: in std_logic_vector(ADDR_SIZE - 1 downto 0); -- 2bit address
            mode: in std_logic;                                   -- 0/1
            rw_mode: i std_logic;                                 -- 0/1
            input: in std_logic_vector(DATA_SIZE - 1 downto 0);   -- input data port for external input mode
            output: out std_logic_vector(DATA_SIZE - 1 downto 0)  -- output data port for external output mode
        );
    END COMPONENT;

    COMPONENT InstructionRegister
        PORT (
            incr_clk : IN STD_LOGIC; 
    		instruction : OUT STD_LOGIC_VECTOR(34 DOWNTO 0) --- <3 bit op code> <16 bit add1> <16 bit add 2>
        );
    END COMPONENT;
END behavioural;