----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:40 10/19/2021 
-- Design Name: 
-- Module Name:    DEMUX - Behavioral 
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

entity DEMUX is
    Port ( DataOutY : in  STD_LOGIC_VECTOR (15 downto 0);
           DEMUX_Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           DY : out  STD_LOGIC_VECTOR (15 downto 0);
           D_Mem_Adr_indir : out  STD_LOGIC_VECTOR (5 downto 0);
           PortID_indir : out  STD_LOGIC_VECTOR (7 downto 0));
end DEMUX;

architecture Behavioral of DEMUX is

begin

D_Mem_Adr_indir <= DataOutY(5 downto 0)
	when DEMUX_Sel = "01" else "000000";

DY <= DataOutY
	when DEMUX_Sel = "00" else "0000000000000000";

PortID_indir <= DataOutY(7 downto 0)
	when DEMUX_Sel = "10" else "00000000";


end Behavioral;

