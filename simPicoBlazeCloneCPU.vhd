--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:05:07 12/02/2021
-- Design Name:   
-- Module Name:   D:/sapi/architektura/xilinx/PicoBlazeClone/simPicoBlazeCloneCPU.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: testPicoBLclone
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
 
ENTITY simPicoBlazeCloneCPU IS
END simPicoBlazeCloneCPU;
 
ARCHITECTURE behavior OF simPicoBlazeCloneCPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT testPicoBLclone
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         intreq : IN  std_logic;
         data_sw : IN  std_logic_vector(7 downto 0);
         intackn : OUT  std_logic;
         Leds : OUT  std_logic_vector(7 downto 0);
         segm : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal intreq : std_logic := '0';
   signal data_sw : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal intackn : std_logic;
   signal Leds : std_logic_vector(7 downto 0);
   signal segm : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: testPicoBLclone PORT MAP (
          rst => rst,
          clk => clk,
          intreq => intreq,
          data_sw => data_sw,
          intackn => intackn,
          Leds => Leds,
          segm => segm
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

      wait for clk_period*50;

      -- insert stimulus here 
	

      wait;
   end process;

END;
