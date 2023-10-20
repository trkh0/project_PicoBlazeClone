----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:15 10/19/2021 
-- Design Name: 
-- Module Name:    IF_DEC - Behavioral 
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

entity IF_DEC is
    Port ( clk : in  STD_LOGIC;
           InstrPhase : in  STD_LOGIC_VECTOR (2 downto 0);
           instruction : in  STD_LOGIC_VECTOR (17 downto 0);
           reset : in  STD_LOGIC;
           Sx_Adr : out  STD_LOGIC_VECTOR (3 downto 0);
           Sy_Adr : out  STD_LOGIC_VECTOR (3 downto 0);
           D_Mem_Adr_dir : out  STD_LOGIC_VECTOR (5 downto 0);
           Enable_Interrupt : out  STD_LOGIC;
           Instr_Code : out  STD_LOGIC_VECTOR (5 downto 0);
           PortID_Dir : out  STD_LOGIC_VECTOR (7 downto 0);
           Branch_Adr : out  STD_LOGIC_VECTOR (9 downto 0);
           Al_Instr_Ext : out  STD_LOGIC_VECTOR (3 downto 0);
           Branch_Instr_Ext : out  STD_LOGIC_VECTOR (1 downto 0);
           KK_Const : out  STD_LOGIC_VECTOR (7 downto 0));
end IF_DEC;

architecture Behavioral of IF_DEC is

begin

process(clk, reset,InstrPhase,instruction)
begin

if reset='1' then
	Sx_Adr<="0000";
	Sy_Adr<="0000";
	D_Mem_Adr_dir<="000000";
	Enable_Interrupt<='0';
	Instr_Code<="000000";
	PortID_Dir<="00000000";
	Branch_Adr<="0000000000";
	Al_Instr_Ext<="0000";
	Branch_Instr_Ext<="00";
	KK_Const<="00000000";
else
	if falling_edge(clk) then
		if InstrPhase="000" then
			Instr_Code <= instruction(17 downto 12);
			case instruction(17 downto 12) is
				--Data transfer instructions
				When "000000" => --1*
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "000001" => --2
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "000100" => --3
					Sx_Adr <= instruction(11 downto 8);
					PortID_Dir <= instruction(7 downto 0);
				When "000101" => --4
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "000110" => --5
					Sx_Adr <= instruction(11 downto 8);
					D_Mem_Adr_dir <= instruction(5 downto 0);
				When "000111" => --6
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "101100" => --7
					Sx_Adr <= instruction(11 downto 8);
					PortID_dir <= instruction(7 downto 0);
				When "101101" => --8
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "101110" => --9
					Sx_Adr <= instruction(11 downto 8);
					D_Mem_Adr_dir <= instruction(5 downto 0);
				When "101111" => --10
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				--Aritmetic/logic instructions
				When "001010" => --1
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "001011" => --2
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "001100" => --3
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "001101" => --4
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "001110" => --5
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "001111" => --6
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "010010" => --7
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "010011" => --8
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "010100" => --9
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "010101" => --10
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "011000" => --11
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "011001" => --12
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "011010" => --13
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "011011" => --14
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "011100" => --15
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "011101" => --16
					Sx_Adr <= instruction(11 downto 8);
					Sy_Adr <= instruction(7 downto 4);
				When "011110" => --17
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "011111" => --18
					Sx_Adr <= instruction(11 downto 8);
					KK_Const <= instruction(7 downto 0);
				When "100000" => --19-23
					Sx_Adr <= instruction(11 downto 8);
					Al_Instr_Ext <= instruction(3 downto 0);
				--Branch instructions
				When "110100" | "110101" => --1-4
					Branch_Instr_Ext <= instruction(11 downto 10);
					Branch_Adr <= instruction(9 downto 0);
				When "110000" | "110001" => --5-8
					Branch_Instr_Ext <= instruction(11 downto 10);
					Branch_Adr <= instruction(9 downto 0);
				When "110010" | "110011" => --9-12
					Branch_Instr_Ext <= instruction(11 downto 10);
					Branch_Adr <= "0000000000";
				When "111000" => --13,14
					Enable_Interrupt <= instruction(0);
				When "111100" => --15,16
					Enable_Interrupt <= instruction(0);
				When others => null;
				end case;
			end if;
		end if;
end if;


end process;


end Behavioral;

