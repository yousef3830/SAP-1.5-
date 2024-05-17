
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity IR is
	port(
	
clk : in  STD_LOGIC;  
clr : in  STD_LOGIC;
Li : in  STD_LOGIC;
Ei : in  STD_LOGIC;
inst_in : in  STD_LOGIC_VECTOR (7 downto 0);
opcod_out: out  STD_LOGIC_VECTOR (3 downto 0);
addr_out : out  STD_LOGIC_VECTOR (3 downto 0));
	
end IR;


				 
architecture IR_reg of IR is  
signal ir_signal :std_logic_vector(7 downto 0):=(others=>'0');

begin
	
	process(clk,clr)
   begin
if clr='0' then 	
ir_signal<=(others=>'0');
elsif falling_edge(clk)then 
	if li='1' then
		ir_signal<=inst_in;

end if;
end if;	 
end process;
opcod_out <= ir_signal(7 downto 4); 

addr_out <= ir_signal(3 downto 0) when Ei = '1' else (others => 'Z');
end IR_reg;