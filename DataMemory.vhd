----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:31 10/12/2021 
-- Design Name: 
-- Module Name:    DataMemory - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           MRd : in  STD_LOGIC;
           MWr : in  STD_LOGIC;
           Sel_Adr : in  STD_LOGIC;
           DataOut_X : in  STD_LOGIC_VECTOR (15 downto 0);
           D_Mem_Adr_Dir : in  STD_LOGIC_VECTOR (5 downto 0);
           D_Mem_Adr_Indir : in  STD_LOGIC_VECTOR (5 downto 0);
           Data_Mem_Out : out  STD_LOGIC_VECTOR (15 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type DMemB is array (0 to 63) of std_logic_vector (15 downto 0);

begin
process(clk,reset,MRd,MWr,Sel_Adr)

variable Data_Memory : DMemB:=(x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");

begin

if reset='1' then
	Data_Memory:=(x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
	Data_Mem_Out<=x"0000";
else 
	if falling_edge(clk) then
		if MRd='1' and MWr='0' then
			if Sel_Adr='0' then
				Data_Mem_Out<=Data_Memory(conv_integer(unsigned(D_Mem_Adr_Dir)));
			end if;
			if Sel_Adr='1' then
				Data_Mem_Out<=Data_Memory(conv_integer(unsigned(D_Mem_Adr_Indir)));
			end if;
		elsif MRd='0' and MWr='1' then
			if Sel_Adr='0' then
				Data_Memory(conv_integer(unsigned(D_Mem_Adr_Dir))):=DataOut_X;
			end if;
			if Sel_Adr='1' then
				Data_Memory(conv_integer(unsigned(D_Mem_Adr_Indir))):=DataOut_X;
			end if;
		end if;
		if MRd='0' and MWr='0' then
			Data_Mem_Out<=x"0000";
		end if;
	end if;
	
end if;

end process;

	
end Behavioral;

