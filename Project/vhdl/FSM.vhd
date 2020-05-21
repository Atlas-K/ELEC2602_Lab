LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM is
	port (
            clk: IN STD_LOGIC;
            reset: IN STD_LOGIC
			);
END;
ARCHITECTURE behavioural of FSM is
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
            w_addr: in std_logic_vector(13 downto 0);
            r_addr: in std_logic_vector(13 downto 0);
            data_in: in std_logic_vector(15 downto 0);
            clk: in std_logic;
            data_out out std_logic_vector(15 downto 0)
        );
    END COMPONENT;

    COMPONENT reg_file
        PORT (
            clk: in std_logic;
            reg0sel: in std_logic_vector(2 downto 0); -- 2bit address
            reg1sel: in std_logic_vector(2 downto 0); -- 2bit address
            mode: in std_logic;                                   -- 0/1
            rw_mode: in std_logic;                                 -- 0/1
            input: in std_logic_vector(15 downto 0);   -- input data port for external input mode
            output: out std_logic_vector(15 downto 0)  -- output data port for external output mode
        );
    END COMPONENT;

    COMPONENT InstructionRegister
        PORT (
            incr_clk : IN STD_LOGIC; 
    		instruction : OUT STD_LOGIC_VECTOR(34 DOWNTO 0) --- <3 bit op code> <16 bit add1> <16 bit add 2>
        );
    END COMPONENT;

    -------------DECLARE SIGNALS--------------
    signal reg_1 : STD_LOGIC_VECTOR(2 downto 0);
    signal reg_2 : STD_LOGIC_VECTOR(2 downto 0);

    signal current_state: STD_LOGIC_VECTOR(2 downto 0);
    signal next_state: STD_LOGIC_VECTOR(2 downto 0);

    signal instruction: STD_LOGIC_VECTOR(34 downto 0);

    signal op_code: STD_LOGIC_VECTOR(2 downto 0);
    signal arg1: STD_LOGIC_VECTOR(15 downto 0);
    signal arg2: STD_LOGIC_VECTOR(15 downto 0);

    signal mode: STD_LOGIC;
    signal rw_mode: STD_LOGIC; 
    signal alu_reg1_in: STD_LOGIC;
    signal alu_reg2_out: STD_LOGIC;



    -------------REROUTING--------------
    BEGIN

    INST_REG: InstructionRegister PORT MAP(clk, instruction);
    
    DECODER0: Decoder PORT MAP(instruction, op_code, arg1, arg2);

    NEXT_STATE0: next_state PORT MAP(current_state, op_code, reg_1, reg_2, reset, next_state);
    current_state <= next_state; --move to next

    OUTPUT_SIG: outputsig PORT MAP(current_state, reg_1, reg_2, mode, rw_mode, alu_reg1_in, alu_reg2_out);

    REG_FILE0: reg_file PORT MAP(clk, reg_1, reg_2, mode, rw_mode, ); --input, output???

    RAM0: RAM PORT MAP();

    ALU0: ALU PORT MAP();





END behavioural;