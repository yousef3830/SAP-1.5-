library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity MAR is
Port ( Lm : in  STD_LOGIC;
clk : in  STD_LOGIC;
address_input : in STD_LOGIC_VECTOR (3 downto 0);
address_output : out std_logic_vector(3 downto 0)
);
end MAR;

		 
architecture Mar_reg of MAR is  
signal MAR_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');  -- "0000"
begin
	
	process(clk)
   begin
	 if rising_edge(clk)then 
		 if Lm = '1' then
			 MAR_content <= address_input;
			 

end if;
end if;	 
end process;
address_output <= MAR_content;
end Mar_reg;
