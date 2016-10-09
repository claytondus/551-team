----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2015 12:35:40 PM
-- Design Name: 
-- Module Name: Lab4Sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Lab1Sim is
--  Port ( );
end Lab1Sim;

architecture Behavioral of Lab1Sim is

component ALU is
     Port ( Input : in STD_LOGIC_VECTOR (7 downto 0);
       OpCode : in STD_LOGIC_VECTOR (4 downto 0);
       button, clk : in std_logic; 
       s0, s1, s2, s3 : inout STD_LOGIC;
       A0data, B0data : out std_logic_vector(7 downto 0);
       seg : out STD_LOGIC_VECTOR (0 to 6);
       neg, one, one2, one3, one4 : out STD_LOGIC);
end component;
signal clk, button : std_logic := '0';
signal opt : std_logic_vector (4 downto 0) := "00000";
signal datain : std_logic_vector (7 downto 0) := "00000001";
signal A0, B0 : std_logic_vector (7 downto 0) := "00000000";
begin
Sim: ALU port map(Input => datain, clk => clk, button => button, OpCode => opt, A0data => A0, B0data => B0);

process
begin 
if clk = '0' then
clk <= '1';
wait for 1 ns;
else
clk <= '0';
wait for 1 ns;
end if;
end process;

process
begin
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00000010";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00010";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --Addition Tested.
wait for 10 ns;
opt <= "00001";
datain <= "00000011";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00011";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --Subtraction done.
wait for 10 ns;
button <= '0';
opt <= "00000";
datain <= "01110000";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00001100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "00000";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --Multiplication done.
wait for 10 ns;
opt <= "00000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "11111111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "00101";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00000100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00101";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00001000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00101";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --AND done.
wait for 10 ns;
opt <= "00000";
datain <= "00001100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "11111111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "00110";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00000100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00110";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00001000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00110";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00000";
datain <= "00000000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00110";
button <= '0';
wait for 10 ns;
button <= '1';  --OR done.
wait for 10 ns;
opt <= "00000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "11111111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "00111";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00000100";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00001";
datain <= "00001000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --XOR done.
wait for 10 ns;
opt <= "01000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00000";
datain <= "01100001";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "01000";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --NOT done.
wait for 10 ns;
button <= '0';
datain <= "00000001";
opt <= "00001";
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "01001";
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --LSL done.
wait for 10 ns;
button <= '0';
opt <= "01010";
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --LSR done.
wait for 10 ns;
button <= '0';
opt <= "01011";
wait for 10 ns;
button <= '1';
wait for 10 ns;
opt <= "00000";
datain <= "11101111";
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
opt <= "01011"; 
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --ASR done.
wait for 10 ns;
button <= '0';
opt <= "01100"; 
wait for 10 ns;
button <= '1';
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --RSL done.
wait for 10 ns;
button <= '0';
opt <= "01101";
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';
wait for 10 ns;
button <= '0';
wait for 10 ns;
button <= '1';  --RSR done.   
wait;
end process;


end Behavioral;
