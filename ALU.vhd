----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:16 10/26/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           OP1 : in  STD_LOGIC_VECTOR (15 downto 0);
           OP2 : in  STD_LOGIC_VECTOR (15 downto 0);
           instr_code : in  STD_LOGIC_VECTOR (5 downto 0);
           AL_instr_code_ext : in  STD_LOGIC_VECTOR (3 downto 0);
           KK_Const : in  STD_LOGIC_VECTOR (7 downto 0);
           execute : in  STD_LOGIC;
           Carry : out  STD_LOGIC;
           Zero : out  STD_LOGIC;
           ALUResult : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
signal Cy, Z : std_logic := '0';
begin

process(clk,reset,instr_code,AL_instr_code_ext,execute)


variable result_tmp : std_logic_vector (16 downto 0) := "00000000000000000";

begin


if reset='1' then
	Carry<='0';
	Zero<='0';
	ALUResult<="0000000000000000";
else
	if falling_edge(clk) then
		if execute='1' then
			case instr_code is
				When "001010" => --AND sX, kk	+
					Cy <= '0';
					result_tmp(7 downto 0) := OP1 (7 downto 0) and KK_Const;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "001011" => --AND sX, sY	+
					Cy <= '0';
					result_tmp(7 downto 0) := OP1(7 downto 0) and OP2(7 downto 0);
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "001100" => --OR sX, kk	+
					Cy <= '0';
					result_tmp(7 downto 0) := OP1(7 downto 0) or KK_Const;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "001101" => --OR sX, sY	+
					Cy <= '0';
					result_tmp(7 downto 0) := OP1(7 downto 0) or OP2(7 downto 0);
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "001110" => --XOR sX, kk +
					Cy <= '0';
					result_tmp(7 downto 0) := OP1(7 downto 0) xor KK_Const;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "001111" => --XOR sX, sY	+
					Cy <= '0';
					result_tmp(7 downto 0) := OP1(7 downto 0) xor OP2(7 downto 0);
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "010010" => --MULT8 sX, kk +
					Cy <= '0';
					result_tmp := (OP1(7 downto 0) * KK_Const);
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "010011" => --MULT8 sX, sY	+
					Cy <= '0';
					result_tmp(15 downto 0) := OP1(7 downto 0) * OP2(7 downto 0);
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "010100" => --COMP sX, kk	+
					if OP1(7 downto 0) = KK_Const then
						Z <= '1';
					else 
						Z <= '0';
					end if;
					if OP1(7 downto 0) < KK_Const then
						Cy <= '1';
					else
						Cy <= '0';
					end if;
					result_tmp := "00000000000000000";
				When "010101" => --COMP sX, sY	+
					if OP1(7 downto 0) = OP2(7 downto 0) then
						Z <= '1';
					else 
						Z <= '0';
					end if;
					if OP1(7 downto 0) < OP2(7 downto 0) then
						Cy <= '1';
					else
						Cy <= '0';
					end if;
					result_tmp := "00000000000000000";
				When "011000" => --ADD sX, kk	+
					result_tmp := ("000000000" & OP1(7 downto 0)) + ("000000000" & KK_Const);
					if result_tmp(16) = '1' then
						Cy <= '1';
					else 
						Cy <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011001" => --ADD sX, sY	+
					result_tmp := ("000000000" & OP1(7 downto 0)) + ("000000000" & OP2(7 downto 0));
					if result_tmp(16) = '1' then
						Cy  <= '1';
					else 
						Cy  <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011010" => --ADDCY sX, sY	+
					result_tmp := ("000000000" & OP1(7 downto 0)) + ("000000000" & KK_Const);
					if result_tmp(16) = '1' then
						Cy  <= '1';
					else 
						Cy  <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011011" => --ADDCY sX, sY	+
					result_tmp := ("000000000" & OP1(7 downto 0)) + ("000000000" & OP2(7 downto 0));
					if result_tmp(16) = '1' then
						Cy  <= '1';
					else 
						Cy  <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011100" => --SUB sX, kk	+
					result_tmp :=  ("000000000" & OP1(7 downto 0)) - ("000000000" & KK_Const);
					if KK_Const > OP1(7 downto 0) then
						Cy <= '1';
					else 
						Cy <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011101" => --SUB sX, sY	+
					result_tmp := ("000000000" & OP1(7 downto 0)) - ("000000000" & OP2(7 downto 0));
					if OP2(7 downto 0) > OP1(7 downto 0) then
						Cy <= '1';
					else 
						Cy <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011110" => --SUBCY sX, kk	+
					result_tmp := ("000000000" & OP1(7 downto 0)) - ("000000000" & KK_Const);
					if KK_Const > OP1(7 downto 0) then
						Cy <= '1';
					else 
						Cy <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "011111" => --SUBCY sX, sY +
					result_tmp := ("000000000" & OP1(7 downto 0)) - ("000000000" & OP2(7 downto 0));
					if OP2(7 downto 0) > OP1(7 downto 0) then
						Cy <= '1';
					else 
						Cy <='0';
					end if;
					if result_tmp = "00000000000000000" then 
						Z <= '1';
					else
						Z <= '0';
					end if;
				When "100000" => --SRR
					if AL_instr_code_ext(3) = '1' then
						case AL_instr_code_ext(2 downto 0) is
							When "110" => --SR0
								result_tmp(15) := '0';
								result_tmp(14 downto 0) := OP1(15 downto 1);
								Cy <= OP1(0);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "111" => --SR1
								result_tmp(15) := '1';
								result_tmp(14 downto 0) := OP1(15 downto 1);
								Cy <= OP1(0);	
								Z <= '0';
							When "010" => --SRX
								result_tmp(15) := OP1(15);
								result_tmp(14 downto 0) := OP1(15 downto 1);
								Cy <= OP1(0);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "000" => --SRA
								result_tmp(15) := OP1(0);
								result_tmp(14 downto 0) := OP1(15 downto 1);
								Cy <= OP1(0);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "100" => --RR
								result_tmp(15) := OP1(1);
								result_tmp(14 downto 0) := OP1(15 downto 1);
								Cy <= OP1(1);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When others => null;
						end case;
					end if;
					
					if AL_instr_code_ext(3) = '0' then
						case AL_instr_code_ext(2 downto 0) is
							When "110" => --SL0
								result_tmp(0) := '0';
								result_tmp(15 downto 1) := OP1(14 downto 0);
								Cy <= OP1(15);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "111" => --SL1
								result_tmp(0) := '1';
								result_tmp(15 downto 1) := OP1(14 downto 0);
								Cy <= OP1(15);	
								Z <= '0';
							When "010" => --SLX
								result_tmp(0) := OP1(0);
								result_tmp(15 downto 1) := OP1(14 downto 0);
								Cy <= OP1(15);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "000" => --SLA
								result_tmp(0) := OP1(15);
								result_tmp(15 downto 1) := OP1(14 downto 0);
								Cy <= OP1(15);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When "100" => --RL
								result_tmp(0) := OP1(14);
								result_tmp(15 downto 1) := OP1(14 downto 0);
								Cy <= OP1(15);
								if result_tmp = "00000000000000000" then 
									Z <= '1';
								else
									Z <= '0';
								end if;
							When others => null;
						end case;
					end if;		
				When others => null;
			end case;
		end if;
	end if;
end if;

Carry <= Cy;
Zero <= Z;
ALUResult <= result_tmp(15 downto 0);		

end process;
		
			


end Behavioral;

