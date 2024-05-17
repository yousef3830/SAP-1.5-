library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Output is
	
	port ( Clk:in std_logic;
	Load:in std_logic;
	Input_data: in std_logic_vector (7 downto 0);
	Output_data:out std_logic_vector (7 downto 0));
	
end Output;


architecture Output_Register of Output is  
signal OUT_content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
	process(Clk)
	begin  
	if rising_edge (Clk) then
		if Load = '1'  then 
			OUT_content <= Input_data;
		end if;
	end if;
		
		
		end process;				
		Output_data <= OUT_content;
end Output_Register;
