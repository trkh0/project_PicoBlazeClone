--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:27 10/05/2021
-- Design Name:   
-- Module Name:   C:/Diak/TorokHunor/PicoBlazeClone/testRegBlock.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegBlock
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
 
ENTITY testRegBlock IS
END testRegBlock;
 
ARCHITECTURE behavior OF testRegBlock IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegBlock
    PORT(
         clk : IN  std_logic;
			reset : IN std_logic;
         RW : IN  std_logic;
         Sx_adr : IN  std_logic_vector(3 downto 0);
         Sy_adr : IN  std_logic_vector(3 downto 0);
         DataX_in : IN  std_logic_vector(15 downto 0);
			DataY_in : IN  std_logic_vector(15 downto 0);
         DataOut_X : OUT  std_logic_vector(15 downto 0);
         DataOut_Y : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal reset : std_logic := '0';
   signal RW : std_logic := '0';
   signal Sx_adr : std_logic_vector(3 downto 0) := (others => '0');
   signal Sy_adr : std_logic_vector(3 downto 0) := (others => '0');
   signal DataX_in : std_logic_vector(15 downto 0) := (others => '0');
	signal DataY_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal DataOut_X : std_logic_vector(15 downto 0);
   signal DataOut_Y : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegBlock PORT MAP (
          clk => clk,
			 reset => reset,
          RW => RW,
          Sx_adr => Sx_adr,
          Sy_adr => Sy_adr,
          DataX_in => DataX_in,
			 DataY_in => DataY_in,
          DataOut_X => DataOut_X,
          DataOut_Y => DataOut_Y
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
		RW<='0';
		Sx_adr <= x"1";
		DataX_in <=x"FFFF";
		RW<='1';
		wait for clk_period;
		
		RW<='0';
		Sx_adr <= x"5";
		DataX_in <= x"ABAB";
		RW<='1';
		
		wait for clk_period;
		
		RW<='1';
		Sy_adr <= x"5";
		Sx_adr <= x"1";
		RW<='0';
		wait for clk_period;
		
      wait;
   end process;

END;
