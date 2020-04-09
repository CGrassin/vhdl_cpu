use work.Constants.all; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MicroProcessor is
    Port (
			  clk, reset : in  STD_LOGIC; --Comment for SELF-TEST
			  dataBus : inout  STD_LOGIC_VECTOR  (DataWidth downto 0);
           addressBus : out  STD_LOGIC_VECTOR (AddressWidth downto 0);
           ReadRAM,WriteRAM : out  STD_LOGIC);
end MicroProcessor;

architecture Behavioral of MicroProcessor is
	--ALU
	signal ALUD0ZeroFlag,ALUD1ZeroFlag :  STD_LOGIC;
   signal ALUDin,ALUDout :  STD_LOGIC_VECTOR (ALURegWidth downto 0);
	
	--Fetch (initially 1)
	signal fetch : STD_LOGIC :='1';
	
	--OPcode
	signal OPRegMux,OPReg : STD_LOGIC_VECTOR  (DataWidth downto 0);
	signal OPCode : STD_LOGIC_VECTOR  (OPCodeLength downto 0);
   signal OPResSel : STD_LOGIC_VECTOR (1 downto 0);
   signal OPOutSel : STD_LOGIC;
	signal OPData : STD_LOGIC_VECTOR (ALURegWidth downto 0);
	
	--PC
	signal PCMux,PC : STD_LOGIC_VECTOR(AddressWidth downto 0):="00000000";
	
	--SELF TEST! SHOULD BE COMMENTED
	--signal clk, reset :  STD_LOGIC;
begin
	--ALU
	ALU : entity work.ALU port map(reset=>reset,
											clk=>clk,
											OpCode=>OPCode,
											Din=>ALUDin,
											ResSel=>OPResSel,
											OutSel=>OPOutSel,
											D0ZeroFlag=>ALUD0ZeroFlag,
											D1ZeroFlag=>ALUD1ZeroFlag,
											Dout=>ALUDout);
	ALUDin <= OPData when OPCode=OPCodeSETL else
				 dataBus(ALURegWidth downto 0) when OPCode=OPCodeSET else
				 (others=>'0');
	
	--OPReg (to fetch instructions from RAM)
	fetch <= '1' when reset = '1' else not fetch when rising_edge(clk);
	OPRegMux <= dataBus when fetch = '1' else (others=>'0'); --NOP while fetching!
	OPReg <= OPRegMux when rising_edge(clk);
	OPCode <= OPReg(DataWidth downto DataWidth-OPCodeLength);
	OPOutSel <= OPReg(DataWidth-OPCodeLength-1);
	OPResSel <= OPReg(DataWidth-OPCodeLength-2 downto DataWidth-OPCodeLength-3);
	OPData <= OPReg(DataWidth-8 downto 0);
	
	--PC (to keep track of next instruction to fetch)
	PCMux <= OPData when (OPCode=OPCodeGOTO) or 
								(OPCode=OPCodeGOTOIFD0 and ALUD0ZeroFlag='1') or 
								(OPCode=OPCodeGOTOIFD1 and ALUD1ZeroFlag='1') else
				STD_LOGIC_VECTOR(unsigned(PC)+1) when fetch='1' else
				PC;
	PC <= (others=>'0') when reset = '1' else PCMux when rising_edge(clk);
	
	--Input/Output handling
	dataBus <= "00000000" & ALUDout when OPCode=OPCodeGET else (others=>'Z'); --Notice 'Z' !
	addressBus <= PC when fetch = '1' else
					  OPData when OPCode=OPCodeGET or OPCode=OPCodeSET else
					  (others=>'0');
	ReadRAM <= '1' when fetch = '1' or OPCode=OPCodeSET else '0';
	WriteRAM <= '1' when OPCode=OPCodeGET else '0';
	
	--SELF TEST! SHOULD BE COMMENTED
	--resetT : process begin
	--	reset <= '1'; wait for 10ps;
	--	reset <= '0'; wait;
	--end process;
	--clockT : process begin
	--	clk <= '1'; wait for 10ps;
	--	clk <= '0'; wait for 10ps;
	--end process;
	--signalsT : process begin
	--	dataBus <= OPCodeSETL & "0" & "01" & "00000001";
	--	wait for 40ps;
	--	dataBus <= OPCodeGET & "0" & "01" & "10110001";
	--	wait for 20ps;
	--	dataBus <= "ZZZZZZZZZZZZZZZZ";
	--	wait for 20ps;
	--	dataBus <= OPCodeGOTO & "0" & "01" & "00000000";
	--	wait;
	--end process;
end Behavioral;
