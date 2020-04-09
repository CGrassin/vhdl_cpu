use work.Constants.all; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUTestBench is
end ALUTestBench;

architecture Behavioral of ALUTestBench is

	signal reset,clk :   STD_LOGIC;
   signal OpCode : STD_LOGIC_VECTOR (OPCodeLength downto 0);
   signal Din :   STD_LOGIC_VECTOR (ALURegWidth downto 0);
   signal ResSel :   STD_LOGIC_VECTOR (1 downto 0);
   signal OutSel :   STD_LOGIC;
   signal D0ZeroFlag,D1ZeroFlag :  STD_LOGIC;
   signal Dout :  STD_LOGIC_VECTOR (ALURegWidth downto 0);
	
begin
	ALU : entity work.ALU port map(reset,clk,OpCode,Din,ResSel,OutSel,D0ZeroFlag,D1ZeroFlag,Dout);
	
	--SIGNALS
	process 
	begin
		OpCode <= OPCodeNOP;
		ResSel <= "01";
		OutSel <= '0';
		Din <= "00000000";
		wait for 20ps;
		OpCode <= OPCodeSETL;
		ResSel <= "01";
		OutSel <= '0';
		Din <= "00000001";
		wait for 20ps;
		OpCode <= OPCodeSETL;
		ResSel <= "10";
		OutSel <= '0';
		Din <= "00000010";
		wait for 20ps;
		OpCode <= OPCodeADD;
		ResSel <= "10";
		OutSel <= '1';
		Din <= "00000000";
		wait;
	end process;
	
	--RESET
	process 
	begin
		reset <= '1';
		wait for 10ps;
		reset <= '0';
		wait;
	end process;
	
	--Clock
	process 
	begin
		clk <= '1';
		wait for 10ps;
		clk <= '0';
		wait for 10ps;
	end process;
	
end Behavioral;

