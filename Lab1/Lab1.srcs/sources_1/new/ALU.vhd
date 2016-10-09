
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity ALU is
    port ( Input : in STD_LOGIC_VECTOR (7 downto 0);
           OpCode : in STD_LOGIC_VECTOR (4 downto 0);
           button, clk : in std_logic; 
           s0, s1, s2, s3 : inout STD_LOGIC;
           A0data, B0data : out std_logic_vector(7 downto 0);
           seg : out STD_LOGIC_VECTOR (0 to 6);
           neg, one, one2, one3, one4 : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

    signal A0, B0 : std_logic_vector (7 downto 0);  --8-bit register values. 
    signal segA, segB : std_logic := '0'; --Used to display A and B on the segment displays. 
    signal prevbutton, clkprev : std_logic := '0'; --Used to record previous values of signals.
    signal clkdiv : std_logic_vector (16 downto 0) := "00000000000000000";

begin

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
            when "00000" => A0 <= Input;    --Read in A0
            when "00001" => B0 <= Input;    --Read in B0
            when "00010" => A0 <= std_logic_vector(signed(A0) + signed(B0));      --Addition
            when "00011" => A0 <= std_logic_vector(signed(A0) - signed(B0));      --Subtraction
            when "00100" => mult := std_logic_vector(signed(A0) * signed(B0));    --Multiplication
                A0 <= mult(15 downto 8);    --Splits the product into A0 and B0.
                B0 <= mult(7 downto 0);
            when "00101" => A0 <= A0 and B0; --AND
            when "00110" => A0 <= A0 or B0; --OR
            when "00111" => A0 <= A0 xor B0; --XOR
            when "01000" => A0 <= not A0; --NOT
            when "01001" => A0 <= std_logic_vector(shift_left(unsigned(A0), to_integer(unsigned(B0))));  --LSL
            when "01010" => A0 <= std_logic_vector(shift_right(unsigned(A0), to_integer(unsigned(B0))));  --LSR
            when "01011" => A0 <= std_logic_vector(shift_left(signed(A0), to_integer(unsigned(B0))));  --ASR
            when "01100" => A0 <= std_logic_vector(rotate_left(unsigned(A0), to_integer(unsigned(B0))));  --RSL
            when "01101" => A0 <= std_logic_vector(rotate_right(unsigned(A0), to_integer(unsigned(B0))));  --RSR
            when "01110" => segA <= '1'; segB <= '0'; neg <= A0(7);  --Reads A0
            when "01111" => segB <= '1'; segA <= '0'; neg <= B0(7); --Reads B0
            when "10000" => segA <= '1'; segB <= '1'; neg <= A0(7); --Reads A0 and B0 in both segment displays
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
                case A0(7 downto 4) is    
                    when "0000"=> seg <="0000001";  -- '0'
                    when "0001"=> seg <="1001111";  -- '1'
                    when "0010"=> seg <="0010010";  -- '2'
                    when "0011"=> seg <="0000110";  -- '3'
                    when "0100"=> seg <="1001100";  -- '4'
                    when "0101"=> seg <="0100100";  -- '5'
                    when "0110"=> seg <="0100000";  -- '6'
                    when "0111"=> seg <="0001111";  -- '7'
                    when "1000"=> seg <="0000000";  -- '8'
                    when "1001"=> seg <="0000100";  -- '9'
                    when "1010"=> seg <="0001000";  -- 'A'
                    when "1011"=> seg <="1100000";  -- 'B'
                    when "1100"=> seg <="0110001";  -- 'C'
                    when "1101"=> seg <="1000010";  -- 'D'
                    when "1110"=> seg <="0110000";  -- 'E'
                    when "1111"=> seg <="0111000";  --'F'
                    when others => seg <= "1111111";
                end case;
            else
                seg <= "1111111";
            end if;
        elsif (s0 = '0') then --A0 second digit when both numbers are displayed
            s0 <= '1';
            s1 <= '0';
  
            if (segA = '1' and segB = '1') then
                case A0(3 downto 0) is    
                    when "0000"=> seg <="0000001";  -- '0'
                    when "0001"=> seg <="1001111";  -- '1'
                    when "0010"=> seg <="0010010";  -- '2'
                    when "0011"=> seg <="0000110";  -- '3'
                    when "0100"=> seg <="1001100";  -- '4'
                    when "0101"=> seg <="0100100";  -- '5'
                    when "0110"=> seg <="0100000";  -- '6'
                    when "0111"=> seg <="0001111";  -- '7'
                    when "1000"=> seg <="0000000";  -- '8'
                    when "1001"=> seg <="0000100";  -- '9'
                    when "1010"=> seg <="0001000";  -- 'A'
                    when "1011"=> seg <="1100000";  -- 'B'
                    when "1100"=> seg <="0110001";  -- 'C'
                    when "1101"=> seg <="1000010";  -- 'D'
                    when "1110"=> seg <="0110000";  -- 'E'
                    when "1111"=> seg <="0111000";  --'F'
                    when others => seg <= "1111111";
                end case;
            else
                seg <= "1111111";
            end if;
        elsif (s1 = '0') then    --B0 or A0 first digit
            s2 <= '0';
            s1 <= '1';
            if (segB = '1') then
                case B0(7 downto 4) is    
                    when "0000"=> seg <="0000001";  -- '0'
                    when "0001"=> seg <="1001111";  -- '1'
                    when "0010"=> seg <="0010010";  -- '2'
                    when "0011"=> seg <="0000110";  -- '3'
                    when "0100"=> seg <="1001100";  -- '4'
                    when "0101"=> seg <="0100100";  -- '5'
                    when "0110"=> seg <="0100000";  -- '6'
                    when "0111"=> seg <="0001111";  -- '7'
                    when "1000"=> seg <="0000000";  -- '8'
                    when "1001"=> seg <="0000100";  -- '9'
                    when "1010"=> seg <="0001000";  -- 'A'
                    when "1011"=> seg <="1100000";  -- 'B'
                    when "1100"=> seg <="0110001";  -- 'C'
                    when "1101"=> seg <="1000010";  -- 'D'
                    when "1110"=> seg <="0110000";  -- 'E'
                    when "1111"=> seg <="0111000";  --'F'
                    when others => seg <= "1111111";
                end case;
            elsif (segA = '1') then
                case A0(7 downto 4) is    
                    when "0000"=> seg <="0000001";  -- '0'
                    when "0001"=> seg <="1001111";  -- '1'
                    when "0010"=> seg <="0010010";  -- '2'
                    when "0011"=> seg <="0000110";  -- '3'
                    when "0100"=> seg <="1001100";  -- '4'
                    when "0101"=> seg <="0100100";  -- '5'
                    when "0110"=> seg <="0100000";  -- '6'
                    when "0111"=> seg <="0001111";  -- '7'
                    when "1000"=> seg <="0000000";  -- '8'
                    when "1001"=> seg <="0000100";  -- '9'
                    when "1010"=> seg <="0001000";  -- 'A'
                    when "1011"=> seg <="1100000";  -- 'B'
                    when "1100"=> seg <="0110001";  -- 'C'
                    when "1101"=> seg <="1000010";  -- 'D'
                    when "1110"=> seg <="0110000";  -- 'E'
                    when "1111"=> seg <="0111000";  --'F'
                    when others => seg <= "1111111";
                end case;
            else
                seg <= "1111111";
            end if;
        elsif (s2 = '0') then --B0 second digit
            s2 <= '1';
            s3 <= '0';
    
            if (segB = '1') then
                case B0(3 downto 0) is    
                    when "0000"=> seg <="0000001";  -- '0'
                    when "0001"=> seg <="1001111";  -- '1'
                    when "0010"=> seg <="0010010";  -- '2'
                    when "0011"=> seg <="0000110";  -- '3'
                    when "0100"=> seg <="1001100";  -- '4'
                    when "0101"=> seg <="0100100";  -- '5'
                    when "0110"=> seg <="0100000";  -- '6'
                    when "0111"=> seg <="0001111";  -- '7'
                    when "1000"=> seg <="0000000";  -- '8'
                    when "1001"=> seg <="0000100";  -- '9'
                    when "1010"=> seg <="0001000";  -- 'A'
                    when "1011"=> seg <="1100000";  -- 'B'
                    when "1100"=> seg <="0110001";  -- 'C'
                    when "1101"=> seg <="1000010";  -- 'D'
                    when "1110"=> seg <="0110000";  -- 'E'
                    when "1111"=> seg <="0111000";  --'F'
                    when others => seg <= "1111111";
                end case;
            elsif (segA = '1') then
                    case A0(3 downto 0) is    
                        when "0000"=> seg <="0000001";  -- '0'
                        when "0001"=> seg <="1001111";  -- '1'
                        when "0010"=> seg <="0010010";  -- '2'
                        when "0011"=> seg <="0000110";  -- '3'
                        when "0100"=> seg <="1001100";  -- '4'
                        when "0101"=> seg <="0100100";  -- '5'
                        when "0110"=> seg <="0100000";  -- '6'
                        when "0111"=> seg <="0001111";  -- '7'
                        when "1000"=> seg <="0000000";  -- '8'
                        when "1001"=> seg <="0000100";  -- '9'
                        when "1010"=> seg <="0001000";  -- 'A'
                        when "1011"=> seg <="1100000";  -- 'B'
                        when "1100"=> seg <="0110001";  -- 'C'
                        when "1101"=> seg <="1000010";  -- 'D'
                        when "1110"=> seg <="0110000";  -- 'E'
                        when "1111"=> seg <="0111000";  --'F'
                        when others => seg <= "1111111";
                    end case;            
            else
                seg <= "1111111";
            end if;
         
        
        end if;
    end if;
    clkprev <= clkdiv(16);
    prevbutton <= button;   --Records the state of the button.
end if;  
end process;    
end Behavioral;
