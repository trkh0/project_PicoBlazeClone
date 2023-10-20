----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:23 10/05/2021 
-- Design Name: 
-- Module Name:    RegBlock - Behavioral 
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

entity RegBlock is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           RW : in  STD_LOGIC;
           Sx_adr : in  STD_LOGIC_VECTOR (3 downto 0);
           Sy_adr : in  STD_LOGIC_VECTOR (3 downto 0);
           DataX_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  DataY_in : in STD_LOGIC_VECTOR (15 downto 0);
           DataOut_X : out  STD_LOGIC_VECTOR (15 downto 0);
           DataOut_Y : out  STD_LOGIC_VECTOR (15 downto 0));
end RegBlock;

architecture Behavioral of RegBlock is

type regB is array (0 to 15) of std_logic_vector (15 downto 0);

begin

process(clk,reset,RW,Sx_adr,Sy_adr)

variable Registers : regB:=(x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");

begin
if reset='1' then
	Registers:=(x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
	DataOut_X<=x"0000";
	DataOut_Y<=x"0000";
else
	if falling_edge(clk) then
		if RW='0' then
			DataOut_X<=Registers(conv_integer(unsigned(Sx_adr)));
			DataOut_Y<=Registers(conv_integer(unsigned(Sy_adr)));
		end if;
		if RW='1' then
			Registers(conv_integer(unsigned(Sx_adr))):=DataX_in;
			Registers(conv_integer(unsigned(Sy_adr))):=DataY_in;
		end if;
	end if;
end if;

end process;


end Behavioral;

