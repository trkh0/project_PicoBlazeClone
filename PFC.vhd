-- 
-- Create Date:    15:48:03 11/18/2021 
-- Design Name: 
-- Module Name:    PFC - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PFC is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Instr_code : in  STD_LOGIC_VECTOR (5 downto 0);
           Branch_Instr_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           Branch_addr : in  STD_LOGIC_VECTOR (9 downto 0);
           Zero : in  STD_LOGIC;
           Carry : in  STD_LOGIC;
           int_enable : in  STD_LOGIC;
           int_req : in  STD_LOGIC;
           inst_adress : out  STD_LOGIC_VECTOR (9 downto 0);
           Instr_Phase : out  STD_LOGIC_VECTOR (2 downto 0);
           RW : out  STD_LOGIC;
           MRd : out  STD_LOGIC;
           MWr : out  STD_LOGIC;
           IOWr : out  STD_LOGIC;
           IORd : out  STD_LOGIC;
           PortID_sel : out  STD_LOGIC;
           DEMUX_sel : out  STD_LOGIC_vector (1 downto 0);
           MUX_sel : out  STD_LOGIC_vector (2 downto 0);
           Execute : out  STD_LOGIC;
           int_ack : out  STD_LOGIC;
           Sel_Addr : out  STD_LOGIC);
end PFC;

architecture Behavioral of PFC is

type stackType is array (0 to 31) of std_logic_vector (9 downto 0);


signal BranchBits : std_logic_vector (9 downto 0);
signal JUMPStatus, CALLStatus, RETStatus, INTStatus : std_logic;
signal internal_reset : std_logic := '0';
signal PhaseNr : std_logic_vector (2 downto 0);
signal PC : std_logic_vector (9 downto 0);
-- signal SP : std_logic_vector (4 downto 0);
signal SP : integer range 0 to 31 := 0;

begin

	
	BranchBits <= Instr_code & Branch_Instr_Ext & Carry & Zero;
	
	--------------------------
	BranchStatus : process(clk, reset, Instr_code, Branch_Instr_Ext , Carry, Zero)
	begin
		if reset = '1' then
			JUMPStatus <= '1'; CALLStatus <= '0'; RETStatus <= '0';
		else
			if rising_edge(clk) then
				case BranchBits is --CONDITIONAL
					when "1101010001" | "1101010011" => JUMPStatus <= '1'; CALLStatus <= '0'; RETStatus <= '0'; -- JUMP Z, addr
					when "1101010100" | "1101010110" => JUMPStatus <= '1'; CALLStatus <= '0'; RETStatus <= '0'; -- JUMP NZ, addr
					when "1101011011" | "1101011010" => JUMPStatus <= '1'; CALLStatus <= '0'; RETStatus <= '0'; -- JUMP C, addr
					when "1101011101" | "1101011100" => JUMPStatus <= '1'; CALLStatus <= '0'; RETStatus <= '0'; -- JUMP NC, addr
					
					when "1100010001" | "1100010011" => JUMPStatus <= '0'; CALLStatus <= '1'; RETStatus <= '0'; -- CALL Z, addr
					when "1100010100" | "1100010110" => JUMPStatus <= '0'; CALLStatus <= '1'; RETStatus <= '0'; -- CALL NZ, addr
					when "1100011011" | "1100011010" => JUMPStatus <= '0'; CALLStatus <= '1'; RETStatus <= '0'; -- CALL C, addr
					when "1100011101" | "1100011100" => JUMPStatus <= '0'; CALLStatus <= '1'; RETStatus <= '0'; -- CALL NC, addr
					
					when "1100110001" | "1100110011" => JUMPStatus <= '0'; CALLStatus <= '0'; RETStatus <= '1'; -- RETURN Z, addr
					when "1100110110" | "1100110100" => JUMPStatus <= '0'; CALLStatus <= '0'; RETStatus <= '1'; -- RETURN NZ, addr
					when "1100111011" | "1100111010" => JUMPStatus <= '0'; CALLStatus <= '0'; RETStatus <= '1'; -- RETURN C, addr
					when "1100111100" | "1100111101" => JUMPStatus <= '0'; CALLStatus <= '0'; RETStatus <= '1'; -- RETURN NC, addr
					
					
					when others => 
						case Instr_code is --UNCONDITIONAL
							when "110010" => JUMPStatus<='0'; CALLStatus<='0'; RETStatus<='1'; -- RETURN
							when "110100" => JUMPStatus<='1'; CALLStatus<='0'; RETStatus<='0'; -- JUMP
							when "110000" => JUMPStatus<='0'; CALLStatus<='1'; RETStatus<='0'; -- CALL
							when others => JUMPStatus<='0'; CALLStatus<='0'; RETStatus<='0';
						end case;
					
				end case;
			end if;
		end if;
	end process;
	--------------------------
	
	--------------------------
	InterruptStatus_process : process(clk, reset, int_enable, int_req, int_enable)
	begin
	
		
	if reset = '1' then
		INTStatus <= '0';
		int_ack <= '0';
	else
		if rising_edge(clk) then
			if int_req = '1' and int_enable = '1'  then
				int_ack <= '1';
				INTStatus <= '1';
			end if;
			if int_req = '0' or int_enable = '0' then
				int_ack <= '0';
			end if;
			if RETStatus = '1' then
				INTStatus <= '0';
			end if;
		end if;

	end if;
	
	end process;
	--------------------------
	
	--------------------------
	PhaseCounter_process : process(clk, reset, internal_reset)
	begin
	
	if reset = '1' or internal_reset = '1' then
		PhaseNr <= "000";
	else 
		if rising_edge(clk) then
			if PhaseNr < "110" then
				PhaseNr <= PhaseNr + 1;
			else 
				PhaseNr <= "000";
			end if;
		end if;
	end if;
	Instr_Phase <= PhaseNr;
	
	end process;
	
	ProgramFlowControl_process : process(clk, reset, JUMPStatus, CALLStatus, RETStatus, INTStatus, Branch_addr, PhaseNr)
	
	variable stack : stackType := (others=>"0000000000");
	
	begin
	
	if reset = '1' then
		inst_adress <= "0000000000";
		--internal_reset <= '1';
	else
		if falling_edge(clk) then
			if PhaseNr = "000" and JUMPStatus = '0' and CallStatus = '0' and RETStatus = '0' and INTStatus = '0' then
				PC <= PC + '1';
				--inst_adress <= "0000000000";
			end if;
			if JUMPStatus = '1' then
				PC <= Branch_addr;
			end if;
			if CALLStatus = '1' then
				stack(SP) := PC;
				SP <= SP + 1;
				PC <= Branch_addr;
			end if;
			if RETStatus = '1' then
				SP <= SP - 1;
				PC <= stack(SP);
			end if;
			if INTStatus = '1' then
				stack(SP) := PC;
				SP <= SP + 1;
				PC <= "1111111111";
				internal_reset <= '1';
			end if;
			inst_adress <= PC;
		end if;
	end if;
	
	end process;
	--------------------------
	--------------------------
	
	ControlSignalGenerator : process(clk, reset, instr_code, PhaseNr)
	begin
	
	if reset = '1' then
		execute <= '0';
	else
		if falling_edge(clk) then
			case instr_code is
				when "000000" => --LOAD sx, kk
					 case PhaseNr is
						when "001" => MUX_sel <= "011";
						when "010" => RW <= '1';
						when "011" => RW <= '0';
						when others => null;
					end case;
					
				when "000001" => --LOAD sx, sy
					 case PhaseNr is
						when "001" => RW <= '0'; MUX_sel <= "100"; DEMUX_sel <= "00";
						when "010" => RW <= '1';
						when "011" => RW <= '0';
						when others => null;
					end case;
					
				when "000100" => --INP sx, pp
					case PhaseNr is
						when "001" => RW <= '0'; MUX_sel <= "001"; PortID_sel <= '0'; IORd <= '1'; IOWr <= '0';
						when "010" => IORd <= '1'; MUX_sel <= "001";
						when "011" => IORd <= '1'; MUX_sel <= "001"; RW <= '1';
						when "100" => IORd <= '0'; RW <= '0';
						when others => null;
					end case;
					
				when "000101" => --INP sx, sy
					case PhaseNr is
						when "001" => RW <= '0'; MUX_sel <= "001"; PortID_sel <= '1'; IORd <= '1'; IOWr <= '0'; DEMUX_sel <= "10";
						when "010" => IORd <= '1'; MUX_sel <= "001"; DEMUX_sel <= "10";
						when "011" => IORd <= '1'; MUX_sel <= "001"; RW <= '1'; DEMUX_sel <= "10";
						when "100" => IORd <= '0'; RW <= '0';
						when others => null;
					end case;
					
				when "000110" => --FETCH sx, spAddr
					 case PhaseNr is
						when "001" => RW <= '0'; MRd <= '1'; MWr <= '0'; Sel_Addr <= '0';
						when "010" => MUX_sel <= "000"; 
						when "011" => MUX_sel <= "000"; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
				
				when "000111" => --FETCH sx, sy
					 case PhaseNr is
						when "001" => RW <= '0'; MRd <= '1'; MWr <= '0'; Sel_Addr <= '1'; DEMUX_sel <= "01";
						when "010" => MUX_sel <= "000"; DEMUX_sel <= "01";
						when "011" => MUX_sel <= "000"; RW <= '1'; DEMUX_sel <= "01";
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "101100" => --OUTP sx, pp
					case PhaseNr is
						when "001" => RW <= '0'; PortID_sel <= '0'; IORd <= '0'; IOWr <= '1';
						when "010" => IOWr <= '1';
						when "011" => IORd <= '0'; RW <= '0';
						when others => null;
					end case;
					
				when "101101" => --OUTP sx, sy
					case PhaseNr is
						when "001" => RW <= '0'; PortID_sel <= '1'; IORd <= '0'; IOWr <= '1'; DEMUX_sel <= "10";
						when "010" => IOWr <= '1'; DEMUX_sel <= "10";
						when "011" => IOWr <= '0'; RW <= '0';
						when others => null;
					end case;
					
				when "101110" => --STORE sx, spAddr
					 case PhaseNr is
						when "001" => RW <= '0'; MRd <= '1'; MWr <= '0'; Sel_Addr <= '0';
						when "010" => MRd <='0'; MWr <= '1'; 
						when "011" => MWr <= '0';
						when others => null;
					end case;
					
				when "101111" => --STORE sx, sy
					 case PhaseNr is
						when "001" => RW <= '0'; MRd <= '1'; MWr <= '0'; Sel_Addr <= '1'; DEMUX_sel <= "01";
						when "010" => MRd <='0'; MWr <= '1'; DEMUX_sel <= "01";
						when "011" => MWr <= '0';
						when others => null;
					end case;
				
				when "001010" => --AND sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "001011" => --AND sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
				
				when "001100" => --OR sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "001101" => --OR sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "001110" => --XOR sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "001111" => --XOR sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "010010" => --MULT8 sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "010011" => --MULT8 sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
				
				when "010100" => --COMP sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "010101" => --COMP sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1';
						when "011" => Execute <= '0';
						when others => null;
					end case;
					
				when "011000" => --ADD sX, kk
					case PhaseNr is
						when "001" => RW <= '0'; MUX_sel <= "010";
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => RW <= '1';
						when "100" => RW <= '0'; Execute <= '0';
						when others => null;
					end case;
					
				when "011001" => --ADD sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0'; MUX_sel <= "010";
						when "010" => DEMUX_sel <= "00"; Execute <= '1'; MUX_sel <= "010";
						when "011" => RW <= '1';
						when "100" => RW <= '0'; Execute <= '0';
						when others => null;
					end case;
					
				when "011010" => --ADDCY sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "011011" => --ADDCY sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "011100" => --SUB sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => RW <= '1';
						when "100" => RW <= '0'; Execute <= '0';
						when others => null;
					end case;
					
				when "011101" => --SUB sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1'; MUX_sel <= "010";
						when "011" => RW <= '1';
						when "100" => RW <= '0'; Execute <= '0';
						when others => null;
					end case;
					
				when "011110" => --SUBCY sX, kk
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "011111" => --SUBCY sX, sY
					case PhaseNr is
						when "001" => DEMUX_sel <= "00"; RW <= '0';
						when "010" => DEMUX_sel <= "00"; Execute <= '1'; MUX_sel <= "010";
						when "011" => Execute <= '0'; RW <= '1';
						when "100" => RW <= '0';
						when others => null;
					end case;
					
				when "100000" => --SRR, SRL
					case PhaseNr is
						when "001" => RW <= '0';
						when "010" => Execute <= '1'; MUX_sel <= "010";
						when "011" => RW <= '1';
						when "100" => RW <= '0'; Execute <= '0';
						when others => null;
					end case;
					
				when others => null;
			end case;
		end if;
	end if;
	end process;
	
	
end Behavioral;
	