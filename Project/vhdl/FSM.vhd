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
            A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            A_SET : IN STD_LOGIC; -- when rising edge, A is loaded into Reg
            TRIGGER : IN STD_LOGIC; -- when rising edge, A <some op> B is placed in C
            OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- op code 
            C : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT next_state
        PORT (
            state: IN std_logic_vector(3 downto 0); 		--Current State.
            f1f0:  IN std_LOGIC_VECTOR(2 downto 0);		    --The operation to be performed (Add, Move, XOR, etc).
            clk: IN std_logic;			--Everyone is familiar with this devil.
			reset: IN std_logic;
            next_state : OUT std_logic_vector(3 downto 0)   --The next state that will be output
        );
    END COMPONENT;

    COMPONENT outputsig
        PORT (
            state: 	IN std_logic_vector (3 downto 0);
				output_op_code_from_decoder : IN std_LOGIC_VECTOR (2 downto 0);	--This is the output op-code from the decoder (connect in FSM with decoder)
				output_arg1_from_decoder : IN std_logic_vector (2 downto 0);		--This is the output arg1 from the decoder (connect in FSM with decoder)
				output_arg2_from_decoder : IN std_logic_vector (2 downto 0);		--This is the output arg2 from the decoder (connect in FSM with decoder)
				output_output_from_reg_file : IN std_LOGIC_VECTOR (2 downto 0);  --This is the output output from the reg_file (connect in FSM with reg_file)
				output_C_from_ALU2		 : IN std_LOGIC_VECTOR (2 downto 0);		--This is the output C from the ALU2 (connect in FSM with ALU2)
				output_pc_counter_from_instruction_register: IN std_LOGIC_VECTOR (2 downto 0);	--This is the output pc_counter from the instruction register (to be made) (connect in FSM with instruction register)
				output_instruction_from_instruction_from_register: IN std_LOGIC_VECTOR (8 downto 0);--This is the output Instruction from the Instruction Register (connect in FSM with decoder)
				to_reg0sel_in_reg_file 	 :OUT std_LOGIC_VECTOR (2 downto 0); 		--Connect in FSM with reg0sel of reg_file (!!!need to change vector in original file)
				to_reg1sel_in_reg_file 	 :OUT std_LOGIC_VECTOR (2 downto 0); 		--Connect in FSM with reg1sel of reg_file (!!!need to change vector in original file)
				to_input_in_reg_file		 :OUT std_LOGIC_VECTOR (2 downto 0);		--Connect in FSM with input of reg_file
				to_mode_in_reg_file 	 	 :OUT std_logic; 									--Connect in FSM with mode of reg_file
				to_rw_mode_in_reg_file	 :OUT std_LOGIC; 									--Connect in FSM with rw_mode of reg_file
				to_OP_in_ALU2			: OUT STD_LOGIC_VECTOR(2 downto 0);
				to_A_in_ALU2				 :OUT std_LOGIC_VECTOR (2 downto 0);		--Connect in FSM with A of ALU2
				to_A_SET_in_ALU2			 :OUT std_LOGIC;									--Connect in FSM with A_SET of ALU2
				to_B_in_ALU2				 :OUT std_LOGIC_VECTOR (2 downto 0);		--Connect in FSM with B of ALU2
				to_TRIGGER_in_ALU2		 :OUT std_LOGIc;									--Connect in FSM with TRIGGER of ALU2
				to_incr_clk_in_instruction_register : OUT std_LOGIC;					--Connect in FSM with incr_clk of Instruction Register
				to_pc_in_in_instruction_register: OUT std_LOGIC_VECTOR (2 downto 0);--Connect in FSM with pc_in of Instruction Register (to be made)
				to_instruction_in_decoder : OUT std_LOGIC_VECTOR (8 downto 0); --Connect in FSM with instruction of decoder.
				to_branch_in_instruction_register : OUT std_logic
            );
    END COMPONENT;

    COMPONENT decoder
        PORT (
            instruction : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            op_code : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            arg_1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            arg_2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) 
        );
    END COMPONENT;

    -- COMPONENT RAM
    --     PORT (
    --         w_en: in std_logic;
    --         w_addr: in std_logic_vector(13 downto 0);
    --         r_addr: in std_logic_vector(13 downto 0);
    --         data_in: in std_logic_vector(15 downto 0);
    --         clk: in std_logic;
    --         data_out out std_logic_vector(15 downto 0)
    --     );
    -- END COMPONENT;

    COMPONENT reg_file
        PORT (
            clk: in std_logic;
            reg0sel: in std_logic_vector(2 downto 0); -- TODO: change length in reg_file
            reg1sel: in std_logic_vector(2 downto 0); -- TODO: change length in reg_file
            mode: in std_logic;                                   -- 0/1
            rw_mode: in std_logic;                                 -- 0/1
            input: in std_logic_vector(2 downto 0);   -- input data port for external input mode
            output: out std_logic_vector(2 downto 0)  -- output data port for external output mode
        );
    END COMPONENT;

    COMPONENT InstructionRegister
        PORT (
            incr_clk, branch : IN STD_LOGIC; 
    		instruction : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --- <3 bit op code> <16 bit add1> <16 bit add 2>
            pc_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- TODO: implement in InstructionRegister
            pc_counter : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- TODO: implement in InstructionRegister
        );
    END COMPONENT;

    -------------DECLARE SIGNALS--------------
    -- InstructionRegister signals
    signal inst_reg_incr_clk: STD_LOGIC;
	signal to_branch_in_instruction_register: STD_LOGIC;
    signal instruction_from_instruction_reg: STD_LOGIC_VECTOR(8 downto 0);
    signal pc_in: STD_LOGIC_VECTOR(2 downto 0);
    signal pc_counter: STD_LOGIC_VECTOR(2 downto 0);

    -- Decoder signals
    signal instruction_in_decoder: STD_LOGIC_VECTOR(8 downto 0);
    signal op_code: STD_LOGIC_VECTOR(2 downto 0);
    signal arg1: STD_LOGIC_VECTOR(2 downto 0);
    signal arg2: STD_LOGIC_VECTOR(2 downto 0);

    -- next_state signals (+ op_code, reset)
    signal current_state: STD_LOGIC_VECTOR(3 downto 0);
    signal next_state_sig: STD_LOGIC_VECTOR(3 downto 0);

    -- ALU signals (+ op_code)
    signal alu_a: STD_LOGIC_VECTOR(2 downto 0);
    signal alu_b: STD_LOGIC_VECTOR(2 downto 0);
	signal to_OP_in_ALU2: STD_LOGIC_VECTOR(2 downto 0);
    signal alu_a_set: STD_LOGIC;
    signal alu_trigger: STD_LOGIC;
    signal alu_c: STD_LOGIC_VECTOR(2 downto 0);

    -- reg_file signals
    signal reg_1 : STD_LOGIC_VECTOR(2 downto 0);
    signal reg_2 : STD_LOGIC_VECTOR(2 downto 0);
    signal reg_mode: STD_LOGIC;
    signal rw_mode: STD_LOGIC;
    signal reg_input_dataport: STD_LOGIC_VECTOR(2 downto 0);
    signal reg_output_dataport: STD_LOGIC_VECTOR(2 downto 0);



    -------------REROUTING--------------
    BEGIN

    INST_REG: InstructionRegister PORT MAP(inst_reg_incr_clk, to_branch_in_instruction_register, instruction_from_instruction_reg, pc_in, pc_counter); --Registers the instruction
    
    DECODER0: Decoder PORT MAP(instruction_in_decoder, op_code, arg1, arg2); --Decodes the instruction (splits it up to op_code, arg1, arg2)

    NEXT_STATE0: next_state PORT MAP(current_state, op_code,clk,reset, next_state_sig); --Based on the current state, get the next state
    current_state <= next_state_sig; --move to next
   
   ALU0: ALU PORT MAP(alu_a, alu_b, alu_a_set, alu_trigger, op_code, alu_c);

    REG_FILE0: reg_file PORT MAP(clk, reg_1, reg_2, reg_mode, rw_mode, reg_input_dataport, reg_output_dataport); 

    OUTPUT_SIG: outputsig PORT MAP(
        current_state, 
        op_code, 
        arg1, 
        arg2, 
        reg_output_dataport, 
        alu_c, 
        pc_counter,
        instruction_from_instruction_reg,
        reg_1, 
        reg_2, 
        reg_input_dataport,
        reg_mode, 
        rw_mode, 
		to_OP_in_ALU2,
        alu_a, 
        alu_a_set, 
        alu_b, 
        alu_trigger, 
        inst_reg_incr_clk,
        pc_in,
        instruction_in_decoder,
		to_branch_in_instruction_register); --Process the state and wire up output signals to ALU and reg_file


    --RAM0: RAM PORT MAP();




END behavioural;