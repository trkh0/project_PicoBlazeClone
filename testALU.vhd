--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:13:56 11/01/2021
-- Design Name:   
-- Module Name:   D:/sapi/architektura/xilinx/PicoBlazeClone/testALU.vhd
-- Project Name:  PicoBlazeClone
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY testALU IS
END testALU;
 
ARCHITECTURE behavior OF testALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         OP1 : IN  std_logic_vector(15 downto 0);
         OP2 : IN  std_logic_vector(15 downto 0);
         instr_code : IN  std_logic_vector(5 downto 0);
         AL_instr_code_ext : IN  std_logic_vector(3 downto 0);
         KK_Const : IN  std_logic_vector(7 downto 0);
         execute : IN  std_logic;
         Carry : OUT  std_logic;
         Zero : OUT  std_logic;
         ALUResult : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal OP1 : std_logic_vector(15 downto 0) := (others => '0');
   signal OP2 : std_logic_vector(15 downto 0) := (others => '0');
   signal instr_code : std_logic_vector(5 downto 0) := (others => '0');
   signal AL_instr_code_ext : std_logic_vector(3 downto 0) := (others => '0');
   signal KK_Const : std_logic_vector(7 downto 0) := (others => '0');
   signal execute : std_logic := '0';

 	--Outputs
   signal Carry : std_logic;
   signal Zero : std_logic;
   signal ALUResult : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          clk => clk,
          reset => reset,
          OP1 => OP1,
          OP2 => OP2,
          instr_code => instr_code,
          AL_instr_code_ext => AL_instr_code_ext,
          KK_Const => KK_Const,
          execute => execute,
          Carry => Carry,
          Zero => Zero,
          ALUResult => ALUResult
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
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		
		execute <= '0';
		instr_code <= "001011";
		OP1 <= x"00FF";
		OP2 <= x"00FF";
		execute <= '1';
		
		wait for clk_period;
		
		execute <= '0';
		instr_code <= "001011";
		OP1 <= x"00FF";
		OP2 <= x"0000";
		execute <= '1';
		
		wait for clk_period;
		
		execute <= '0';
		instr_code <= "010011";
		OP1 <= x"00FF";
		OP2 <= x"0000";
		execute <= '1';
		
		wait for clk_period;
		
		execute <= '0';
		instr_code <= "010011";
		OP1 <= x"00FF";
		OP2 <= x"000F";
		execute <= '1';
		
		wait for clk_period;
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		
		execute <= '0';
		instr_code <= "011001";
		OP1 <= x"00F9";
		OP2 <= x"0001";
		execute <= '1';
		
		wait for clk_period;
		
		execute <= '0';
		instr_code <= "011001";
		OP1 <= x"00FF";
		OP2 <= x"0000";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "001010";
		OP1 <= x"00FF";
		KK_Const <= x"00";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "001100";
		OP1 <= x"00F0";
		KK_Const <= x"00";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "001110";
		OP1 <= x"000F";
		KK_Const <= x"FF";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "010101";
		OP1 <= x"000F";
		OP2 <= x"00FF";
		execute <= '1';
		
		wait for clk_period;
		
		execute <= '0';
		instr_code <= "001110";
		OP1 <= x"000F";
		KK_Const <= x"FF";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "011000";
		OP1 <= x"00F9";
		KK_Const <= x"01";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "011100";
		OP1 <= x"00FF";
		KK_Const <= x"0F";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "011101";
		OP1 <= x"00FF";
		OP2 <= x"000F";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "100000";
		AL_instr_code_ext <= "1110";
		OP1 <= "0010010101101001";
		execute <= '1';
		
		wait for clk_period;

		execute <= '0';
		instr_code <= "100000";
		AL_instr_code_ext <= "1111";
		OP1 <= "0010010101101001";
		execute <= '1';
		
		wait for clk_period;
		
      wait;
   end process;

END;
