--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:32:43 11/01/2021
-- Design Name:   
-- Module Name:   D:/sapi/architektura/xilinx/PicoBlazeClone/testIF_DEC.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_DEC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testIF_DEC IS
END testIF_DEC;
 
ARCHITECTURE behavior OF testIF_DEC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_DEC
    PORT(
         clk : IN  std_logic;
         InstrPhase : IN  std_logic_vector(2 downto 0);
         instruction : IN  std_logic_vector(17 downto 0);
         reset : IN  std_logic;
         Sx_Adr : OUT  std_logic_vector(3 downto 0);
         Sy_Adr : OUT  std_logic_vector(3 downto 0);
         D_Mem_Adr_dir : OUT  std_logic_vector(5 downto 0);
         Enable_Interrupt : OUT  std_logic;
         Instr_Code : OUT  std_logic_vector(5 downto 0);
         PortID_Dir : OUT  std_logic_vector(7 downto 0);
         Branch_Adr : OUT  std_logic_vector(9 downto 0);
         Al_Instr_Ext : OUT  std_logic_vector(3 downto 0);
         Branch_Instr_Ext : OUT  std_logic_vector(1 downto 0);
         KK_Const : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal InstrPhase : std_logic_vector(2 downto 0) := (others => '0');
   signal instruction : std_logic_vector(17 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal Sx_Adr : std_logic_vector(3 downto 0);
   signal Sy_Adr : std_logic_vector(3 downto 0);
   signal D_Mem_Adr_dir : std_logic_vector(5 downto 0);
   signal Enable_Interrupt : std_logic;
   signal Instr_Code : std_logic_vector(5 downto 0);
   signal PortID_Dir : std_logic_vector(7 downto 0);
   signal Branch_Adr : std_logic_vector(9 downto 0);
   signal Al_Instr_Ext : std_logic_vector(3 downto 0);
   signal Branch_Instr_Ext : std_logic_vector(1 downto 0);
   signal KK_Const : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_DEC PORT MAP (
          clk => clk,
          InstrPhase => InstrPhase,
          instruction => instruction,
          reset => reset,
          Sx_Adr => Sx_Adr,
          Sy_Adr => Sy_Adr,
          D_Mem_Adr_dir => D_Mem_Adr_dir,
          Enable_Interrupt => Enable_Interrupt,
          Instr_Code => Instr_Code,
          PortID_Dir => PortID_Dir,
          Branch_Adr => Branch_Adr,
          Al_Instr_Ext => Al_Instr_Ext,
          Branch_Instr_Ext => Branch_Instr_Ext,
          KK_Const => KK_Const
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		instrPhase <= "000";
		reset <= '1';
		
		wait for clk_period;
		reset <= '0';
		
		instruction <= "000001001010010000";
		--instrPhase <= "00";
		
		wait for clk_period;
	
		instruction <= "001100010110100100";
		
		wait for clk_period;
		
		instruction <= "100000010000001010";
		
		wait for clk_period;
		
		instruction <= "000110100000101011";
		
		wait for clk_period;
		
		
		
		
		
      wait;
   end process;

END;
