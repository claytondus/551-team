
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is 
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
    
    constant DIGIT_WIDTH:integer := 4;
    subtype DIGIT_TYPE is STD_LOGIC_VECTOR(DIGIT_WIDTH-1 downto 0);


end constants;