use work.Constants.all; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAMController is
    Port (
			  outLEDs : out STD_LOGIC_VECTOR(7 downto 0); --Test ONLY
			  clk, reset : in  STD_LOGIC;
			  dataBus : inout  STD_LOGIC_VECTOR  (DataWidth downto 0);
           addressBus : in  STD_LOGIC_VECTOR (AddressWidth downto 0);
           ReadRAM,WriteRAM : in  STD_LOGIC);
end RAMController;

architecture Behavioral of RAMController is
	CONSTANT RAMsize :integer := 4;
	TYPE RAM_type is array (0 to  RAMsize) of std_logic_vector (DataWidth downto 0);
	
	signal RAM : RAM_type := (
	OPCodeSETL & "0" & "01" & "00000001",
	OPCodeINC0 & "0" & "01" & "00000000",
	OPCodeGET  & "0" & "00" & "00000100",
	OPCodeGOTO & "0" & "00" & "00000001",
	"0000000000000000"
	);

	signal RAMbuffer : STD_LOGIC_VECTOR  (DataWidth downto 0);
begin
	dataBus <= RAM(to_integer(unsigned(addressBus))) when  ReadRAM='1' and WriteRAM='0' else ( others => 'Z' );
	RAMbuffer <= dataBus when  ReadRAM='0' and WriteRAM='1' else RAM(to_integer(unsigned(addressBus)));
	RAM(to_integer(unsigned(addressBus))) <= RAMbuffer when rising_edge(clk);

	--FOR TEST ONLY (wire RAM(4)) to outside
	outLEDs <= RAM(4)(7 downto 0);
	
end Behavioral;

