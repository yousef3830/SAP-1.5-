

 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RAM is	
	port(
	Read : in std_logic;
	Input_address : in std_logic_vector(3 downto 0);
	Output_data : out  std_logic_vector(7 downto 0)
	
	);
end RAM;


architecture RAM of RAM is	
type Memory  is array(0 to 15) of std_logic_vector(7 downto 0);

signal Ram : Memory :=(
	0  => "00001001" , --LDA @9h
1  => "01001111" , --SHL
2  => "00111111" , --SHR
3  => "00011010" , --ADD @10h
4  => "00101011" , --SUB @Bh
5  => "01011100" , --AND @Ch
6  => "01101101" , --OR @Dh
7  => "11101111" ,
8  => "11111111" ,
9  => "00000110" , --6
10 => "00001000" , --8
11 => "00000011" , --3
12 => "11100111" ,
13 => "00001111" ,
14 => "11111111" , 
15 => "11111111" );	

begin

	Output_data <= Ram(conv_integer(unsigned(Input_address))) when Read = '1' else (others => 'Z');

end RAM;
