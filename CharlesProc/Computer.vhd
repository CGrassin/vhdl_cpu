use work.Constants.all; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Computer is
    Port ( 
			clk,reset : in  STD_LOGIC; -- Comment for SELF-TEST
			outLEDs:out STD_LOGIC_VECTOR(7 downto 0)
			); 
end Computer;

architecture Behavioral of Computer is
	signal dataBus :   STD_LOGIC_VECTOR  (DataWidth downto 0);
   signal addressBus :   STD_LOGIC_VECTOR (AddressWidth downto 0);
   signal ReadRAM,WriteRAM :   STD_LOGIC;
	
	--signal clk,reset : STD_LOGIC; -- Uncomment for SELF-TEST
begin
	CPU : entity work.Microprocessor port map(clk=>clk,reset=>reset,dataBus=>dataBus ,addressBus=>addressBus,ReadRAM=>ReadRAM,WriteRAM=>WriteRAM);
	RAM : entity work.RAMController port map(clk=>clk,reset=>reset,dataBus=>dataBus ,addressBus=>addressBus,ReadRAM=>ReadRAM,WriteRAM=>WriteRAM,outLEDs=>outLEDs);

	--SELF TEST! SHOULD BE COMMENTED
	--resetT : process begin
	--	reset <= '1'; wait for 10ps;
	--	reset <= '0'; wait;
	--end process;
	--clockT : process begin
	--	clk <= '1'; wait for 10ps;
	--	clk <= '0'; wait for 10ps;
	--end process;
end Behavioral;

