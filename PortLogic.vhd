----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:24:47 11/16/2021 
-- Design Name: 
-- Module Name:    PortLogic - Behavioral 
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

entity PortLogic is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           IORd : in  STD_LOGIC;
           IOWr : in  STD_LOGIC;
           PortID_Sel : in  STD_LOGIC;
           PortID_Dir : in  STD_LOGIC_VECTOR (7 downto 0);
           PortID_Indir : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOutX : in  STD_LOGIC_VECTOR (15 downto 0);
           PortDataIN : in  STD_LOGIC_VECTOR (15 downto 0);
           PortIntoCPU : out  STD_LOGIC_VECTOR (15 downto 0);
           PortDataOut : out  STD_LOGIC_VECTOR (15 downto 0);
           PortID : out  STD_LOGIC_VECTOR (7 downto 0);
           ReadStrobe : out  STD_LOGIC;
           WriteStrobe : out  STD_LOGIC);
end PortLogic;

architecture Behavioral of PortLogic is

signal StepNr : std_logic_vector (1 downto 0);
signal DataBUFF : std_logic_vector(15 downto 0);

begin

process(reset, clk, IORd, IOWr)
begin
	if reset = '1' then
		null;
		--ReadStrobe <= '0';
		--WriteStrobe <= '0';
	else
		if rising_edge(clk) then
			if IORd = '1' or IOWr = '1' then
				if StepNr = "00" then
					StepNr <= "01";
				elsif StepNr = "01" then
					StepNr <= "10";
				elsif StepNr = "10" then
					StepNr <= "00";
				end if;

			end if;
		end if;
	end if;
end process;
process(clk, reset, StepNr, IORd, IOWr)

begin	

	if reset = '1' then
		PortIntoCPU <= "0000000000000000";
		PortDataOut <= "0000000000000000";
		PortID <= "00000000";
	else
		if falling_edge(clk) then
			case StepNr is
				When "00" =>
					if IORd = '1' then
						 ReadStrobe <= '1';
					end if;
					if IOWr = '1' then
						DataBUFF <= DataOutX;
					end if;
					if PortID_Sel ='0' then
						PortID <= PortID_Dir;
					else
						PortID <= PortID_Indir;
					end if;
				When "01" =>
					if IORd = '1' then
						 DataBUFF <= PortDataIN;
						 ReadStrobe <= '1';
					end if;
					if IOWr = '1' then
						PortDataOut <= DataBUFF;
						WriteStrobe <= '1';
					end if;
				When "10" => 
					ReadStrobe <= '0';
					if IOWr = '1' then
						PortIntoCPU <= DataBUFF;
					end if;
					WriteStrobe <= '0';
				When others =>
					null;
			end case;
		end if;
	end if;

end process;

end Behavioral;

