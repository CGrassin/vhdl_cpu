library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Constants is
	------------------------GENERAL SETTINGS-------------------------------------
	constant DataWidth	: Integer := 15; --16 bits
	constant ALURegWidth	: Integer := 7;  --8 bits
	constant AddressWidth: Integer := 7;  --8 bits
	constant OPCodeLength: Integer := 4;  --5 bits
	
	------------------------INSTRUCTION SET--------------------------------------
	--NOP!
	constant OPCodeNOP		: Std_Logic_Vector(OPCodeLength downto 0) := "00000";
	--Register control
	constant OPCodeGET		: Std_Logic_Vector(OPCodeLength downto 0) := "00001";
	constant OPCodeSET		: Std_Logic_Vector(OPCodeLength downto 0) := "00010";
	constant OPCodeSETL		: Std_Logic_Vector(OPCodeLength downto 0) := "00011";
	--PC control
	constant OPCodeGOTOIFD0	: Std_Logic_Vector(OPCodeLength downto 0) := "00100";
	constant OPCodeGOTOIFD1	: Std_Logic_Vector(OPCodeLength downto 0) := "00101";
	constant OPCodeGOTO		: Std_Logic_Vector(OPCodeLength downto 0) := "00110";
	--Arithmetic
	constant OPCodeADD		: Std_Logic_Vector(OPCodeLength downto 0) := "00111";
	constant OPCodeINC0		: Std_Logic_Vector(OPCodeLength downto 0) := "01000";
	constant OPCodeINC1		: Std_Logic_Vector(OPCodeLength downto 0) := "01001";
	constant OPCodeDEC0		: Std_Logic_Vector(OPCodeLength downto 0) := "01010";
	constant OPCodeDEC1		: Std_Logic_Vector(OPCodeLength downto 0) := "01011";
	constant OPCodeSUB		: Std_Logic_Vector(OPCodeLength downto 0) := "01100";
	--logic
	constant OPCodeAND		: Std_Logic_Vector(OPCodeLength downto 0) := "01101";
	constant OPCodeOR		   : Std_Logic_Vector(OPCodeLength downto 0) := "01110";
end Constants;

package body Constants is
end Constants;
