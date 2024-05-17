library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity B is
	port(
	Clk : in std_logic;
	Load : in std_logic;
	Input_data : in std_logic_vector(7 downto 0);
	Output_data : out std_logic_vector(7 downto 0)
	);
end B;


architecture B_Register of B is
  signal B_content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
	process(Clk)
	begin
	if rising_edge(Clk)  then
		if Load = '1' then 
			B_content <= Input_data;
			end if;
			end if;
		end process;
Output_data <= B_content;
end B_Register;

