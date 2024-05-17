library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity PC is
	
	port(Clk:in std_logic;
	Clr:in std_logic;
	En:in std_logic;
	Inc:in std_logic;
	Pc_out:out std_logic_vector(3 downto 0));
	
	
end PC;


architecture PC_Register of PC is  

signal Pc_signal:std_logic_vector (3 downto 0):="0000";

begin
	process(Clk,Clr) 
	
	begin	
		if Clr='0' then PC_signal <="0000";
			
		elsif  
			
			falling_edge (Clk) then
			
			if Inc='1' then
				Pc_signal<=Pc_signal+1;	
				
				end if;
		end if;		
		
		end process;
	
	  Pc_out <= Pc_signal when En='1'	
	  
	  else "ZZZZ";
		
end PC_Register;