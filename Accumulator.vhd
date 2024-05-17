
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Accumulator is	 
	port(
	Clk : in std_logic;
	Load : in std_logic;
	En : in std_logic;
	Input_data : in std_logic_vector(7 downto 0);
	Output_ALU : out std_logic_vector(7 downto 0);
	 Output_BUS : out std_logic_vector(7 downto 0)
	);
end Accumulator;

--}} End of automatically maintained section

architecture Accumulator_body of Accumulator is


	signal data_signal : std_logic_vector(7 downto 0) := (others => '0');
begin
	process(Clk)
	  begin
	if rising_edge(Clk) then
		if Load =  '1' then
			data_signal <= Input_data ;
			end if;
			end if;
	
	end process;
	Output_BUS <= data_signal when En = '1' else (others => 'Z');
  Output_ALU <= data_signal;
end Accumulator_body;
