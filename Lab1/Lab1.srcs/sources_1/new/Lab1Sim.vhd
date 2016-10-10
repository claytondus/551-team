----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/1/2016 12:35:40 PM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.constants.ALL;

entity Lab1Sim is
end Lab1Sim;

architecture Behavioral of Lab1Sim is

    component ALU is
         port ( 
            Input           : in REG_TYPE;
            OpCode          : in OPCODE_TYPE;
            button, clk     : in STD_LOGIC; 
            s0, s1, s2, s3  : inout STD_LOGIC;
            A0data, B0data  : out REG_TYPE;
            seg             : out SEG_TYPE;
            neg, one, one2, one3, one4 : out STD_LOGIC);
    end component;
    
    signal clk, button : std_logic := '0';
    signal opt : OPCODE_TYPE := OPCODE_WRITE_A0;
    signal data_in : REG_TYPE := "00000000";
    signal A0, B0 : REG_TYPE := "00000000";
    
    constant INTERVAL:time   := 10 ns;
    constant CLK_PERIOD:time := 1 ns;
    
    procedure press (signal button: out std_logic) is
    begin
        button <= '1';
        wait for INTERVAL;
        button <= '0';
        wait for INTERVAL;
    end press;
    
    --http://pastebin.com/RudNJETG
    function to_hstring(s: in std_logic_vector) return string is
    --- Locals to make the indexing easier
            constant s_norm: std_logic_vector(s'length-1 downto 0) := s;
            variable result: string (s'length/4 downto 1);
     
    --- A subtype to keep the VHDL compiler happy
    --- (the rules about data types in a CASE are quite strict)
            subtype slv4 is std_logic_vector(3 downto 0);
     
    begin
            assert (8 mod 4) = 0
                    report "SLV must be a multiple of 4 bits"
            severity FAILURE;
     
            for i in result'range loop
                    case slv4'(s_norm((i-1)*4+3 downto (i-1)*4)) is
                    when "0000" => result(i) := '0';
                    when "0001" => result(i) := '1';
                    when "0010" => result(i) := '2';
                    when "0011" => result(i) := '3';
                    when "0100" => result(i) := '4';
                    when "0101" => result(i) := '5';
                    when "0110" => result(i) := '6';
                    when "0111" => result(i) := '7';
                    when "1000" => result(i) := '8';
                    when "1001" => result(i) := '9';
                    when "1010" => result(i) := 'a';
                    when "1011" => result(i) := 'b';
                    when "1100" => result(i) := 'c';
                    when "1101" => result(i) := 'd';
                    when "1110" => result(i) := 'e';
                    when "1111" => result(i) := 'f';
                    when others => result(i) := 'X';
                    end case;
            end loop;
     
            return result;
    end;
    
    procedure test_op ( a0_in, b0_in, a0_expected, b0_expected: in REG_TYPE;
                        opcode_in: in OPCODE_TYPE;
                        opcode_text: in string;
                        signal A0data, B0data: in REG_TYPE;
                        signal opt: out OPCODE_TYPE;
                        signal data_in: out REG_TYPE;
                        signal button: out STD_LOGIC) is
    begin
        report "";
        report "--- Starting " & opcode_text & " test ------------------";
        report "A0: " & to_hstring(a0_in);
        report "B0: " & to_hstring(b0_in);
        
        --Arrange
        opt <= OPCODE_WRITE_A0;
        data_in <= a0_in;
        press(button);
        
        opt <= OPCODE_WRITE_B0;
        data_in <= b0_in;
        press(button);
        
        --Act
        opt <= opcode_in;
        press(button);
        
        report "A0 after: " & to_hstring(A0data);
        report "B0 after: " & to_hstring(B0data);
        
        --Assert
        assert(A0data = a0_expected)
        report opcode_text & " operation error, expected A0 = " & to_hstring(a0_expected) & " got A0 = " & to_hstring(A0data)
        severity failure;
        
        assert(B0data = b0_expected)
        report opcode_text & " operation error, expected B0 = " & to_hstring(b0_expected) & " got B0 = " & to_hstring(B0data)
        severity failure;
        
        report "--- Finishing " & opcode_text & " test ------------------";
    end test_op;
    


begin
    Sim: ALU port map(Input => data_in, clk => clk, button => button, OpCode => opt, A0data => A0, B0data => B0);
    
    process
    begin 
        if clk = '0' then
            clk <= '1';
            wait for CLK_PERIOD;
        else
            clk <= '0';
            wait for CLK_PERIOD;
        end if;
    end process;
    
    process 
    begin
        wait for 20 ns;
        report "----------------------------------------";
        report "--- ALU Testbench ----------------------";
        report "----------------------------------------";
        
        --        A0     B0   A0 exp B0 exp
        test_op(x"02", x"02", x"04", x"02", OPCODE_ADD, "ADD", A0, B0, opt, data_in, button);
        test_op(x"F3", x"4D", x"40", x"4D", OPCODE_ADD, "ADD", A0, B0, opt, data_in, button);
        test_op(x"DA", x"E4", x"BE", x"E4", OPCODE_ADD, "ADD", A0, B0, opt, data_in, button);
        
        test_op(x"0F", x"02", x"0D", x"02", OPCODE_SUBTRACT, "SUBTRACT", A0, B0, opt, data_in, button);
        test_op(x"42", x"4D", x"F5", x"4D", OPCODE_SUBTRACT, "SUBTRACT", A0, B0, opt, data_in, button);
        test_op(x"F2", x"9E", x"54", x"9E", OPCODE_SUBTRACT, "SUBTRACT", A0, B0, opt, data_in, button);
        
        test_op(x"20", x"20", x"04", x"00", OPCODE_MULTIPLY, "MULTIPLY", A0, B0, opt, data_in, button);
        test_op(x"45", x"E4", x"F8", x"74", OPCODE_MULTIPLY, "MULTIPLY", A0, B0, opt, data_in, button);
        test_op(x"DA", x"AD", x"0C", x"52", OPCODE_MULTIPLY, "MULTIPLY", A0, B0, opt, data_in, button);
        
        test_op(x"DA", x"AD", x"88", x"AD", OPCODE_AND, "AND", A0, B0, opt, data_in, button);
        test_op(x"F3", x"05", x"01", x"05", OPCODE_AND, "AND", A0, B0, opt, data_in, button);
        test_op(x"C4", x"C3", x"C0", x"C3", OPCODE_AND, "AND", A0, B0, opt, data_in, button);
        
        test_op(x"DA", x"AD", x"FF", x"AD", OPCODE_OR, "OR", A0, B0, opt, data_in, button);
        test_op(x"F3", x"05", x"F7", x"05", OPCODE_OR, "OR", A0, B0, opt, data_in, button);
        test_op(x"C4", x"C3", x"C7", x"C3", OPCODE_OR, "OR", A0, B0, opt, data_in, button);
        
        test_op(x"C4", x"C3", x"07", x"C3", OPCODE_XOR, "XOR", A0, B0, opt, data_in, button);
        test_op(x"2E", x"7E", x"50", x"7E", OPCODE_XOR, "XOR", A0, B0, opt, data_in, button);
        test_op(x"85", x"F3", x"76", x"F3", OPCODE_XOR, "XOR", A0, B0, opt, data_in, button);
        
        test_op(x"85", x"00", x"7A", x"00", OPCODE_NOT, "NOT", A0, B0, opt, data_in, button);
        test_op(x"2E", x"00", x"D1", x"00", OPCODE_NOT, "NOT", A0, B0, opt, data_in, button);
        test_op(x"DB", x"00", x"24", x"00", OPCODE_NOT, "NOT", A0, B0, opt, data_in, button);
        
        test_op(x"85", x"01", x"0A", x"01", OPCODE_LSL, "LSL", A0, B0, opt, data_in, button);
        test_op(x"AA", x"02", x"A8", x"02", OPCODE_LSL, "LSL", A0, B0, opt, data_in, button);
        test_op(x"02", x"04", x"20", x"04", OPCODE_LSL, "LSL", A0, B0, opt, data_in, button);
        
        test_op(x"85", x"01", x"42", x"01", OPCODE_LSR, "LSR", A0, B0, opt, data_in, button);
        test_op(x"AA", x"02", x"2A", x"02", OPCODE_LSR, "LSR", A0, B0, opt, data_in, button);
        test_op(x"02", x"04", x"00", x"04", OPCODE_LSR, "LSR", A0, B0, opt, data_in, button);
     
        test_op(x"90", x"07", x"FF", x"07", OPCODE_ASR, "ASR", A0, B0, opt, data_in, button);
        test_op(x"04", x"02", x"01", x"02", OPCODE_ASR, "ASR", A0, B0, opt, data_in, button);
        test_op(x"F3", x"02", x"FC", x"02", OPCODE_ASR, "ASR", A0, B0, opt, data_in, button);
        
        test_op(x"3C", x"02", x"F0", x"02", OPCODE_RSL, "RSL", A0, B0, opt, data_in, button);
        test_op(x"3C", x"03", x"E1", x"03", OPCODE_RSL, "RSL", A0, B0, opt, data_in, button);
        test_op(x"7A", x"01", x"F4", x"01", OPCODE_RSL, "RSL", A0, B0, opt, data_in, button);
        
        test_op(x"3C", x"02", x"0F", x"02", OPCODE_RSR, "RSR", A0, B0, opt, data_in, button);
        test_op(x"3C", x"03", x"87", x"03", OPCODE_RSR, "RSR", A0, B0, opt, data_in, button);
        test_op(x"7A", x"01", x"3D", x"01", OPCODE_RSR, "RSR", A0, B0, opt, data_in, button);
        
        
        report "----------------------------------------";
        report "--- ALU Testbench Complete -------------";
        report "--- ALL TESTS PASSED -------------------";
        report "----------------------------------------";
        
        wait;
    end process;


end Behavioral;
