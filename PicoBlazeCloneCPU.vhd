----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:59 11/25/2021 
-- Design Name: 
-- Module Name:    PicoBlazeCloneCPU - Behavioral 
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

entity PicoBlazeCloneCPU is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Int : in  STD_LOGIC;
           PortIN : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (17 downto 0);
           PortID : out  STD_LOGIC_VECTOR (7 downto 0);
           PortOUT : out  STD_LOGIC_VECTOR (15 downto 0);
           ReadStrobe : out  STD_LOGIC;
           WriteStrobe : out  STD_LOGIC;
           Int_ack : out  STD_LOGIC;
           ProgMemAddress : out  STD_LOGIC_VECTOR (9 downto 0));
end PicoBlazeCloneCPU;

architecture Behavioral of PicoBlazeCloneCPU is

component ALU is
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
end component;


component DEMUX is
    Port ( DataOutY : in  STD_LOGIC_VECTOR (15 downto 0);
           DEMUX_Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           DY : out  STD_LOGIC_VECTOR (15 downto 0);
           D_Mem_Adr_indir : out  STD_LOGIC_VECTOR (5 downto 0);
           PortID_indir : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component DataMemory is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           MRd : in  STD_LOGIC;
           MWr : in  STD_LOGIC;
           Sel_Adr : in  STD_LOGIC;
           DataOut_X : in  STD_LOGIC_VECTOR (15 downto 0);
           D_Mem_Adr_Dir : in  STD_LOGIC_VECTOR (5 downto 0);
           D_Mem_Adr_Indir : in  STD_LOGIC_VECTOR (5 downto 0);
           Data_Mem_Out : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component IF_DEC is
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
end component;

component MUX is
    Port ( Data_Mem_Out : in  STD_LOGIC_VECTOR (15 downto 0);
           PortIntoCPU : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUresult : in  STD_LOGIC_VECTOR (15 downto 0);
           KK_Const : in  STD_LOGIC_VECTOR (7 downto 0);
           DY : in  STD_LOGIC_VECTOR (15 downto 0);
           DataX : out  STD_LOGIC_VECTOR (15 downto 0);
           MUX_Sel : in  STD_LOGIC_VECTOR (2 downto 0));
end component;

component PFC is
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
end component;

component PortLogic is
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
end component;

component RegBlock is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           RW : in  STD_LOGIC;
           Sx_adr : in  STD_LOGIC_VECTOR (3 downto 0);
           Sy_adr : in  STD_LOGIC_VECTOR (3 downto 0);
           DataX_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  DataY_in : in STD_LOGIC_VECTOR (15 downto 0);
           DataOut_X : out  STD_LOGIC_VECTOR (15 downto 0);
           DataOut_Y : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


signal clock, res, ior, iow, memr, memw, rwRW, Cy, Z, enableInterupt, requestInterupt, PortIDSel, AddrSel, execute : std_logic;
signal regAddrX, regAddrY, InstrCodeExt : std_logic_vector (3 downto 0);
signal RegINx, RegOUTx, RegOUTy, ALUResult, PortDataToCPU, DataMemOut, dy, PortDataIn, PortDataOut : std_logic_vector (15 downto 0);
signal instrCode, ScrPadAddrDIR, ScrPadAddrINDIR : std_logic_vector (5 downto 0);
signal InstrPhase : std_logic_vector (2 downto 0);
signal BranchExt, DEMUXSel : std_logic_vector ( 1 downto 0);
signal MUXSel : std_logic_vector (2 downto 0);
signal KK, PortIdDir, PortIdIndir, port_ID : std_logic_vector (7 downto 0);
signal BranchAddr, instrAddress : std_logic_vector (9 downto 0);
signal instr : std_logic_vector (17 downto 0);

begin

	inst_RegBlock : RegBlock port map(
		clk => clk,
		reset => reset,
		rw => rwRW,
		Sx_adr => regAddrX,
		Sy_adr => regAddrY,
		DataX_in => RegINx,
		DataY_in => x"0000",
		DataOut_X => RegOUTx,
		DataOut_Y => RegOUTy
	);
	
	inst_DataMemory : DataMemory port map(
		clk => clk,
		reset => reset,
		MRd => memr,
		MWr => memw,
		Sel_Adr => AddrSel,
		DataOut_X => RegOUTx,
		D_Mem_Adr_Dir => ScrPadAddrDIR,
		D_Mem_Adr_Indir => ScrPadAddrINDIR,
		Data_Mem_Out => DataMemOut
	);
	
	inst_ALU : ALU port map(
		clk => clk,
      reset => reset,
      OP1 => RegOUTx,
		OP2 => dy,
		instr_code => instrCode,
		AL_instr_code_ext => InstrCodeExt,
		KK_Const => KK,
		execute => execute,
		Carry => Cy,
		Zero => Z,
		ALUResult => ALUResult
	);
	
	inst_DEMUX : DEMUX port map(
		DataOutY => RegOUTy,
		DEMUX_Sel => DEMUXSel,
		DY => dy,
		D_Mem_Adr_indir => ScrPadAddrINDIR,
		PortID_indir => PortIdIndir
	);
	
	inst_IF_DEC : IF_DEC port map(
		clk => clk,
		InstrPhase => InstrPhase,
		--instruction => instr,
		instruction => Instruction,
		reset => reset,
		Sx_Adr => regAddrX,
		Sy_Adr => regAddrY,
		D_Mem_Adr_dir => ScrPadAddrDIR,
		Enable_Interrupt => enableInterupt,
		Instr_Code => instrCode,
		PortID_Dir => PortIdDir,
		Branch_Adr => BranchAddr,
		Al_Instr_Ext => InstrCodeExt,
		Branch_Instr_Ext => BranchExt,
		KK_Const => KK
	);
	
	inst_MUX : MUX port map(
		Data_Mem_Out => DataMemOut,
		PortIntoCPU => PortDataToCPU,
		ALUresult => ALUResult,
		KK_Const => KK,
		DY => dy,
		DataX => RegINx,
		MUX_Sel => MUXSel
	);
	
	inst_PortLogic : PortLogic port map(
		clk => clk,
		reset => reset,
		IORd => ior,
		IOWr => iow,
		PortID_Sel => PortIDSel,
		PortID_Dir => PortIdDir,
		PortID_Indir => PortIdIndir,
		DataOutX => RegOUTx,
		PortDataIN => PortDataIn,
		PortIntoCPU => PortDataToCPU,
		PortDataOut => PortDataOut,
		PortID => port_ID,
		ReadStrobe => ReadStrobe,
		WriteStrobe => WriteStrobe
	);
	
	inst_PFC : PFC port map(
		clk => clk,
		reset => reset,
		Instr_code => instrCode,
		Branch_Instr_Ext => BranchExt,
		Branch_addr => BranchAddr,
		Zero => Z,
		Carry => Cy,
		int_enable => enableInterupt,
		int_req => requestInterupt,
		inst_adress => ProgMemAddress,
		Instr_Phase => InstrPhase,
		RW => rwRW,
		MRd => memr,
		MWr => memw,
		IOWr => iow,
		IORd => ior,
		PortID_sel => PortIDSel,
		DEMUX_sel => DEMUXSel,
		MUX_sel => MUXSel,
		Execute => execute,
		int_ack => int_ack,
		Sel_Addr => AddrSel		
	);

	

end Behavioral;

