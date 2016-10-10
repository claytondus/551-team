----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2016 03:25:11 PM
-- Design Name: 
-- Module Name: constants - 
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

package constants is

    constant OPCODE_WIDTH:integer := 5;
    subtype OPCODE_TYPE is STD_LOGIC_VECTOR(OPCODE_WIDTH-1 downto 0);
        
    constant OPCODE_WRITE_A0:OPCODE_TYPE    := "00000";
    constant OPCODE_WRITE_B0:OPCODE_TYPE    := "00001";
    constant OPCODE_ADD:OPCODE_TYPE         := "00010";
    constant OPCODE_SUBTRACT:OPCODE_TYPE    := "00011";
    constant OPCODE_MULTIPLY:OPCODE_TYPE    := "00100";
    constant OPCODE_AND:OPCODE_TYPE         := "00101";
    constant OPCODE_OR:OPCODE_TYPE          := "00110";
    constant OPCODE_XOR:OPCODE_TYPE         := "00111";
    constant OPCODE_NOT:OPCODE_TYPE         := "01000";
    constant OPCODE_LSL:OPCODE_TYPE         := "01001";
    constant OPCODE_LSR:OPCODE_TYPE         := "01010";
    constant OPCODE_ASR:OPCODE_TYPE         := "01011";
    constant OPCODE_RSL:OPCODE_TYPE         := "01100";
    constant OPCODE_RSR:OPCODE_TYPE         := "01101";
    constant OPCODE_READ_A0:OPCODE_TYPE     := "01110";
    constant OPCODE_READ_B0:OPCODE_TYPE     := "01111";
    constant OPCODE_READ_A0_B0:OPCODE_TYPE  := "10000";
    
    constant SEG_WIDTH:integer := 7;
    subtype SEG_TYPE is STD_LOGIC_VECTOR(0 to SEG_WIDTH-1);
        
    constant SEG_0:SEG_TYPE := "0000001";
    constant SEG_1:SEG_TYPE := "1001111";
    constant SEG_2:SEG_TYPE := "0010010";
    constant SEG_3:SEG_TYPE := "0000110";
    constant SEG_4:SEG_TYPE := "1001100";
    constant SEG_5:SEG_TYPE := "0100100";
    constant SEG_6:SEG_TYPE := "0100000";
    constant SEG_7:SEG_TYPE := "0001111";
    constant SEG_8:SEG_TYPE := "0000000";
    constant SEG_9:SEG_TYPE := "0000100";
    constant SEG_A:SEG_TYPE := "0001000";
    constant SEG_B:SEG_TYPE := "1100000";
    constant SEG_C:SEG_TYPE := "0110001";
    constant SEG_D:SEG_TYPE := "1000010";
    constant SEG_E:SEG_TYPE := "0110000";
    constant SEG_F:SEG_TYPE := "0111000";
    constant SEG_OFF:SEG_TYPE := "1111111";
    
    constant REG_WIDTH:integer := 8;
    subtype REG_TYPE is STD_LOGIC_VECTOR(REG_WIDTH-1 downto 0);
    
    constant DIGIT_WIDTH:integer := 4;
    subtype DIGIT_TYPE is STD_LOGIC_VECTOR(DIGIT_WIDTH-1 downto 0);
    
end constants;


