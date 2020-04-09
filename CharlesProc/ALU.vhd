use work.Constants.all; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
			--IN :
			  reset,clk : in  STD_LOGIC;
           OpCode : in  STD_LOGIC_VECTOR (OPCodeLength downto 0);
           Din : in  STD_LOGIC_VECTOR (ALURegWidth downto 0);
           ResSel : in  STD_LOGIC_VECTOR (1 downto 0);
           OutSel : in  STD_LOGIC;
			 --OUT :
           D0ZeroFlag,D1ZeroFlag : out  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (ALURegWidth downto 0));
end ALU;

architecture Behavioral of ALU is
	signal OPMux,D0Mux,D1Mux,D0,D1 : STD_LOGIC_VECTOR (ALURegWidth downto 0);
begin
	--OP:
	OPMux <= Din when OpCode = OPCodeSET or OpCode = OPCodeSETL else
				STD_LOGIC_VECTOR(unsigned(D0)+1) when OpCode = OPCodeINC0 else
				STD_LOGIC_VECTOR(unsigned(D1)+1) when OpCode = OPCodeINC1 else
				STD_LOGIC_VECTOR(unsigned(D0)-1) when OpCode = OPCodeDEC0 else
				STD_LOGIC_VECTOR(unsigned(D1)-1) when OpCode = OPCodeDEC1 else
				STD_LOGIC_VECTOR(unsigned(D0)+unsigned(D1)) when OpCode = OPCodeADD else
				STD_LOGIC_VECTOR(unsigned(D0)-unsigned(D1)) when OpCode = OPCodeSUB else
				D0 and D1 when OpCode = OPCodeAND else
				D0 or  D1 when OpCode = OPCodeOR else
				(others=>'0');
	D0Mux <= OPMux when ResSel(0) = '1' else D0;
	D1Mux <= OPMux when ResSel(1) = '1' else D1;
	
	--Registers (CPU cache)
	D0 <= (others=>'0') when reset = '1' else D0Mux when rising_edge(clk);
	D1 <= (others=>'0') when reset = '1' else D1Mux when rising_edge(clk);
	
	--Output
	Dout <= D0 when OutSel = '0' else D1;
	D0ZeroFlag <= '1' when unsigned(D0) = 0 else '0';
	D1ZeroFlag <= '1' when unsigned(D1) = 0 else '0';
end Behavioral;
