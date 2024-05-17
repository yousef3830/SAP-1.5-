
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is	
	
	port ( A0 :in std_logic;
	  A1 :in std_logic;
	  A2 :in std_logic;
	En :in std_logic;
	RegB_input:in std_logic_vector (7 downto 0);
	Ac_input:in std_logic_vector (7 downto 0);
	Output_ALU :out std_logic_vector (7 downto 0));
	
end ALU;



architecture A_S of ALU is
begin

	Output_ALU <= RegB_input + Ac_input when ( ( En = '1') and A2 = '0' and A1 = '0' and A0 = '0') 
	else Ac_input - RegB_input when (  En = '1' and A2 = '0' and A1 = '0' and A0 = '1' ) 
	  else (Ac_input and RegB_input) when (  En = '1' and A2 = '0' and A1 = '1' and A0 = '0')
	  else (Ac_input or RegB_input) when (  En = '1' and A2 = '0' and A1 = '1' and A0 = '1' )
	    else  ('0' & Ac_input(7 downto 1))    when (  En = '1' and A2 = '1' and A1 = '0' and A0 = '0')  -- ('0' & Ac_input(7 downto 1))
	     else  ( Ac_input(6 downto 0) &'0')   when (  En = '1' and A2 = '1' and A1 = '0' and A0 = '1')                              
	else (others => 'Z') ;
	
end  A_S;