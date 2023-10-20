--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:26:59 12/09/2021
-- Design Name:   
-- Module Name:   D:/sapi/architektura/xilinx/PicoBlazeClone/test_PFC.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PFC
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
 
ENTITY test_PFC IS
END test_PFC;
 
ARCHITECTURE behavior OF test_PFC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PFC
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         Instr_code : IN  std_logic_vector(5 downto 0);
         Branch_Instr_Ext : IN  std_logic_vector(1 downto 0);
         Branch_addr : IN  std_logic_vector(9 downto 0);
         Zero : IN  std_logic;
         Carry : IN  std_logic;
         int_enable : IN  std_logic;
         int_req : IN  std_logic;
         inst_adress : OUT  std_logic_vector(9 downto 0);
         Instr_Phase : OUT  std_logic_vector(2 downto 0);
         RW : OUT  std_logic;
         MRd : OUT  std_logic;
         MWr : OUT  std_logic;
         IOWr : OUT  std_logic;
         IORd : OUT  std_logic;
         PortID_sel : OUT  std_logic;
         DEMUX_sel : OUT  std_logic_vector(1 downto 0);
         MUX_sel : OUT  std_logic_vector(2 downto 0);
         Execute : OUT  std_logic;
         int_ack : OUT  std_logic;
         Sel_Addr : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal Instr_code : std_logic_vector(5 downto 0) := (others => '0');
   signal Branch_Instr_Ext : std_logic_vector(1 downto 0) := (others => '0');
   signal Branch_addr : std_logic_vector(9 downto 0) := (others => '0');
   signal Zero : std_logic := '0';
   signal Carry : std_logic := '0';
   signal int_enable : std_logic := '0';
   signal int_req : std_logic := '0';

 	--Outputs
   signal inst_adress : std_logic_vector(9 downto 0);
   signal Instr_Phase : std_logic_vector(2 downto 0);
   signal RW : std_logic;
   signal MRd : std_logic;
   signal MWr : std_logic;
   signal IOWr : std_logic;
   signal IORd : std_logic;
   signal PortID_sel : std_logic;
   signal DEMUX_sel : std_logic_vector(1 downto 0);
   signal MUX_sel : std_logic_vector(2 downto 0);
   signal Execute : std_logic;
   signal int_ack : std_logic;
   signal Sel_Addr : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PFC PORT MAP (
          clk => clk,
          reset => reset,
          Instr_code => Instr_code,
          Branch_Instr_Ext => Branch_Instr_Ext,
          Branch_addr => Branch_addr,
          Zero => Zero,
          Carry => Carry,
          int_enable => int_enable,
          int_req => int_req,
          inst_adress => inst_adress,
          Instr_Phase => Instr_Phase,
          RW => RW,
          MRd => MRd,
          MWr => MWr,
          IOWr => IOWr,
          IORd => IORd,
          PortID_sel => PortID_sel,
          DEMUX_sel => DEMUX_sel,
          MUX_sel => MUX_sel,
          Execute => Execute,
          int_ack => int_ack,
          Sel_Addr => Sel_Addr
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
		
		instr_code <= "001010";
		
		wait for clk_period * 10;

      wait;
   end process;

END;
