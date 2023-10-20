----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:12 10/19/2021 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
    Port ( Data_Mem_Out : in  STD_LOGIC_VECTOR (15 downto 0);
           PortIntoCPU : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUresult : in  STD_LOGIC_VECTOR (15 downto 0);
           KK_Const : in  STD_LOGIC_VECTOR (7 downto 0);
           DY : in  STD_LOGIC_VECTOR (15 downto 0);
           DataX : out  STD_LOGIC_VECTOR (15 downto 0);
           MUX_Sel : in  STD_LOGIC_VECTOR (2 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

process(MUX_sel, Data_Mem_Out, PortIntoCPU,ALUresult,KK_Const, DY)
begin
	case MUX_Sel is
		When "000" =>
			DataX <= Data_Mem_Out;
		When "001" =>
			DataX <= PortIntoCPU;
		When "010" =>
			DataX <= ALUresult;
		When "011" =>
			DataX(7 downto 0) <= KK_Const;
			DataX(15 downto 8) <= x"00";
		When "100" =>
			DataX <= DY;
		When others => null;
	end case;

end process;


end Behavioral;

