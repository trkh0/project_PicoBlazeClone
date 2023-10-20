--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:35 10/12/2021
-- Design Name:   
-- Module Name:   D:/sapi/architektura/xilinx/PicoBlazeClone/testDataMemory.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DataMemory
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
 
ENTITY testDataMemory IS
END testDataMemory;
 
ARCHITECTURE behavior OF testDataMemory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         MRd : IN  std_logic;
         MWr : IN  std_logic;
         Sel_Adr : IN  std_logic;
         DataOut_X : IN  std_logic_vector(15 downto 0);
         D_Mem_Adr_Dir : IN  std_logic_vector(5 downto 0);
         D_Mem_Adr_Indir : IN  std_logic_vector(5 downto 0);
         Data_Mem_Out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal MRd : std_logic := '0';
   signal MWr : std_logic := '0';
   signal Sel_Adr : std_logic := '0';
   signal DataOut_X : std_logic_vector(15 downto 0) := (others => '0');
   signal D_Mem_Adr_Dir : std_logic_vector(5 downto 0) := (others => '0');
   signal D_Mem_Adr_Indir : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Data_Mem_Out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          clk => clk,
          reset => reset,
          MRd => MRd,
          MWr => MWr,
          Sel_Adr => Sel_Adr,
          DataOut_X => DataOut_X,
          D_Mem_Adr_Dir => D_Mem_Adr_Dir,
          D_Mem_Adr_Indir => D_Mem_Adr_Indir,
          Data_Mem_Out => Data_Mem_Out
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
		--write
		Sel_Adr <= '0';
		D_Mem_Adr_Dir <= "000010";
		DataOut_X <= x"03FF";
		wait for clk_period;
		MRd <= '0';
		MWr <= '1';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
		Sel_Adr <= '1';
		D_Mem_Adr_Indir <= "100010";
		DataOut_X <= x"FFFF";
		wait for clk_period;
		MRd <= '0';
		MWr <= '1';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
		Sel_Adr <= '1';
		D_Mem_Adr_Indir <= "111111";
		DataOut_X <= x"0001";
		wait for clk_period;
		MRd <= '0';
		MWr <= '1';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
		
		
		--read
		Sel_Adr <= '0';
		D_Mem_Adr_Dir <= "000010";
		wait for clk_period;
		MRd <= '1';
		MWr <= '0';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
		Sel_Adr <= '1';
		D_Mem_Adr_Indir <= "100010";
		wait for clk_period;
		MRd <= '1';
		MWr <= '0';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
		Sel_Adr <= '1';
		D_Mem_Adr_Indir <= "111111";
		wait for clk_period;
		MRd <= '1';
		MWr <= '0';
		wait for clk_period;
		MRd <='0';
		MWr <='0';
	
		wait for clk_period;

      wait;
   end process;

END;
