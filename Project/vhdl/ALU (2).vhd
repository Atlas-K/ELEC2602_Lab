library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

ENTITY ALU IS 
	GENERIC ( N : INTEGER := 4 );
PORT ( 
					A, B												: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
					clk, AddXor, o_in, o_out, Ain, reset	            	: IN STD_LOGIC;
					G													: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);

END;

ARCHITECTURE Structural OF ALU IS

COMPONENT fourbitReg IS
		PORT ( 
					input							: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
					clk, reset, enable	        	: IN STD_LOGIC;
					output					    	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
				);

END COMPONENT;

COMPONENT Reg IS
		PORT ( 
			input 							: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			Rin, Rout, reset, clk		    : IN STD_LOGIC;
			output, data 					: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
			);
				
END COMPONENT;

SIGNAL G_t:  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL A_t: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
 
BEGIN 

	A1: fourbitReg PORT MAP (
			clk    => clk,
			reset  => reset,
			enable => Ain,
			input  => A,
			output => A_t
		);
		
--
	PROCESS(A_t, B, AddXor,clk)
	Begin 
		case	(AddXor) is 
		when '1' =>
			G_t <= A_t + B;
		when others =>
			G_t <= A_t xor B;
	end case;
	END PROCESS;

	Reg1 : Reg PORT MAP (
			input 				=>  	G_t,
			Rin					=> 	    O_in,
			Rout				=>		O_out,
			clk 				=> 	    clk,
			output		 		=>  	O,
			reset				=>		reset
        );

END Structural;
