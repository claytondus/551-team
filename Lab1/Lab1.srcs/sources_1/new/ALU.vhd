
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.constants.all;


entity ALU is
    port ( Input : in REG_TYPE;
           OpCode : in OPCODE_TYPE;
           button, clk : in STD_LOGIC; 
           s0, s1, s2, s3 : inout STD_LOGIC;
           A0data, B0data : out REG_TYPE;
           seg : out SEG_TYPE;
           neg, one, one2, one3, one4 : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

    signal A0, B0 : REG_TYPE;  --8-bit register values. 
    signal segA, segB : std_logic := '0'; --Used to display A and B on the segment displays. 
    signal prevbutton, clkprev : std_logic := '0'; --Used to record previous values of signals.
    signal clkdiv : std_logic_vector (16 downto 0) := "00000000000000000";
  
    function decode_seg(input: in DIGIT_TYPE) return SEG_TYPE is
    begin
        case input is    
            when "0000" => return SEG_0;
            when "0001" => return SEG_1;
            when "0010" => return SEG_2;
            when "0011" => return SEG_3;
            when "0100" => return SEG_4;
            when "0101" => return SEG_5;
            when "0110" => return SEG_6;
            when "0111" => return SEG_7;
            when "1000" => return SEG_8;
            when "1001" => return SEG_9;
            when "1010" => return SEG_A;
            when "1011" => return SEG_B;
            when "1100" => return SEG_C;
            when "1101" => return SEG_D;
            when "1110" => return SEG_E;
            when "1111" => return SEG_F;
            when others => return SEG_OFF;
        end case;        
    end decode_seg;
    
begin

--Static signal assignments
one <= '1'; --Set as a constant one to keep first 4 segment displays off.
one2 <= '1';
one3 <= '1';
one4 <= '1';
A0data <= A0;
B0data <= B0;


process (clk)
    variable mult : std_logic_vector (15 downto 0); --Used to assist with multiplication
    variable negative : std_logic;
begin
    if (clk'event and clk = '1') then

        clkdiv <= std_logic_vector(unsigned(clkdiv) + 1); --Increments the clock divider for the segment display.
        if (button = '1' and prevbutton = '0') then   --The button only works once per button press.
            case OpCode is
                when OPCODE_WRITE_A0 => A0 <= Input;    
                when OPCODE_WRITE_B0 => B0 <= Input;    
                when OPCODE_ADD => A0 <= std_logic_vector(signed(A0) + signed(B0));      
                when OPCODE_SUBTRACT => A0 <= std_logic_vector(signed(A0) - signed(B0));      
                when OPCODE_MULTIPLY => mult := std_logic_vector(signed(A0) * signed(B0));    
                    A0 <= mult(15 downto 8);    --Splits the product into A0 and B0.
                    B0 <= mult(7 downto 0);
                when OPCODE_AND => A0 <= A0 and B0; 
                when OPCODE_OR => A0 <= A0 or B0; 
                when OPCODE_XOR => A0 <= A0 xor B0; 
                when OPCODE_NOT => A0 <= not A0; 
                when OPCODE_LSL => A0 <= std_logic_vector(shift_left(unsigned(A0), to_integer(unsigned(B0))));  --LSL
                when OPCODE_LSR => A0 <= std_logic_vector(shift_right(unsigned(A0), to_integer(unsigned(B0))));  --LSR
                when OPCODE_ASR => A0 <= std_logic_vector(shift_right(signed(A0), to_integer(unsigned(B0))));  --ASR
                when OPCODE_RSL => A0 <= std_logic_vector(rotate_left(unsigned(A0), to_integer(unsigned(B0))));  --RSL
                when OPCODE_RSR => A0 <= std_logic_vector(rotate_right(unsigned(A0), to_integer(unsigned(B0))));  --RSR
                when OPCODE_READ_A0 => segA <= '1'; segB <= '0'; neg <= A0(7);  --Reads A0
                when OPCODE_READ_B0 => segA <= '0'; segB <= '1'; neg <= B0(7); --Reads B0
                when OPCODE_READ_A0_B0 => segA <= '1'; segB <= '1'; neg <= A0(7); --Reads A0 and B0 in both segment displays
                when others => segA <= '0';     --Turn off all display when an illegal Op Code is used.
                    segB <= '0';
                    neg <= '0';
            end case;
        end if;
        if (clkdiv(16) = '1' and clkprev = '0') then    --Switches the segment display periodically, fast enough to appear contiguous to the human eye.
            if (s3 = '0') then    --A0 first digit when both numbers are displayed
                s0 <= '0';
                s3 <= '1';
                if (segA = '1' and segB = '1') then
                    seg <= decode_seg(A0(7 downto 4));
                else
                    seg <= SEG_OFF;
                end if;
            elsif (s0 = '0') then --A0 second digit when both numbers are displayed
                s0 <= '1';
                s1 <= '0';
                if (segA = '1' and segB = '1') then
                    seg <= decode_seg(A0(3 downto 0));
                else
                    seg <= SEG_OFF;
                end if;
            elsif (s1 = '0') then    --B0 or A0 first digit
                s2 <= '0';
                s1 <= '1';
                if (segB = '1') then
                    seg <= decode_seg(B0(7 downto 4));
                elsif (segA = '1') then
                    seg <= decode_seg(A0(7 downto 4));
                else
                    seg <= SEG_OFF;
                end if;
            elsif (s2 = '0') then --B0 second digit
                s2 <= '1';
                s3 <= '0';
                if (segB = '1') then
                    seg <= decode_seg(B0(3 downto 0));
                elsif (segA = '1') then
                    seg <= decode_seg(A0(3 downto 0));
                else
                    seg <= SEG_OFF;
                end if;
            else
                --NOP
            end if;
        end if;
        clkprev <= clkdiv(16);
        prevbutton <= button;   --Records the state of the button.
    end if;  
end process;    
end Behavioral;
