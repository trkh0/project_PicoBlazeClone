----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:31:01 11/11/2018 
-- Design Name: 
-- Module Name:    testPicoBLclone - Behavioral 
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

entity testPicoBLclone is
    Port ( 	rst:	in std_logic;									--reset input
				clk:	in std_logic;									--clock input
				intreq:	in std_logic;									
				
				-- lcd input signals
			--	DB:	out std_logic_vector(7 downto 0);		--output bus, used for data transfer
			-- RS:	out std_logic;  								--register selection pin
			--	RW:	out std_logic;									--selects between read/write modes
			--	E:		out std_logic;									--enable signal for starting the 
				data_sw : in std_logic_vector(7 downto 0);
				intackn:		out std_logic;
				Leds:		out std_logic_vector(7 downto 0);
				segm:		out std_logic_vector(7 downto 0)
				);
end testPicoBLclone;

architecture Behavioral of testPicoBLclone is
	COMPONENT PicoBlazeCloneCPU
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		Int : IN std_logic;
		PortIN : IN std_logic_vector(15 downto 0);
		Instruction : IN std_logic_vector(17 downto 0);          
		PortID : OUT std_logic_vector(7 downto 0);
		PortOUT : OUT std_logic_vector(15 downto 0);
		ReadStrobe : OUT std_logic;
		WriteStrobe : OUT std_logic;
		Int_ack : OUT std_logic;
		ProgMemAddress : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;
	
	COMPONENT test
	PORT(
		address : IN std_logic_vector(9 downto 0);
		clk : IN std_logic;          
		instruction : OUT std_logic_vector(17 downto 0)
		);
	END COMPONENT;



signal addr : std_logic_vector(9 downto 0);
signal instr : std_logic_vector(17 downto 0);

	signal port_id: std_logic_vector(7 downto 0);
	signal out_port, in_port: std_logic_vector(15 downto 0);
	signal read_strobe, write_strobe : std_logic;

begin

	
	Inst_proba: test PORT MAP(
		address => addr,
		instruction => instr,
		clk => clk
	);

	Inst_PicoBlazeCloneCPU: PicoBlazeCloneCPU PORT MAP(
		clk => clk,
		reset => rst,
		Int => Intreq,
		PortIN => in_port,
		Instruction => instr,
		PortID => port_id,
		PortOUT => out_port,
		ReadStrobe => read_strobe,
		WriteStrobe => write_strobe,
		Int_ack => intackn,
		ProgMemAddress => addr 
	);

writemux: process(clk, write_strobe)
variable data_leds : std_logic_vector(7 downto 0);
variable segm7 : std_logic_vector(7 downto 0);
begin
if clk'event and clk='0' then
	if write_strobe='1' and port_id=x"02" then
		data_leds := out_port(7 downto 0);
		segm7 := out_port(15 downto 8);
	end if;
end if;
		Leds <= data_leds;	
		segm <= segm7;	
end process writemux;

readmux: process(clk, read_strobe)
begin
if clk'event and clk='0' then
	if read_strobe='1' and port_id=x"02" then
		in_port(7 downto 0)<=data_sw;
		in_port(15 downto 8)<=data_sw;
	end if;
end if;	
end process readmux;

end Behavioral;

