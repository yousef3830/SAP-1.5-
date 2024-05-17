								 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SAP1 is
  port(
  Clk : in std_logic;
  Clr : in std_logic;
  Output_data : out std_logic_vector(7 downto 0)
  );
  
end SAP1;

architecture SAP of SAP1 is

	component PC is
	
	port(Clk:in std_logic;
	Clr:in std_logic;
	En:in std_logic;
	Inc:in std_logic;
	Pc_out:out std_logic_vector(3 downto 0));
	
	end component;
	--------------------------------------------------------------------------------------
	component Controller is   
	
	port( Clk: in std_logic;
	Clr: in std_logic;
	instruction_in : in std_logic_vector (3 downto 0);
	Pc_En : out std_logic ;
	Pc_Inc : out std_logic;
	Ir_En : out std_logic;
	Ir_Load : out std_logic;
	Ac_En : out std_logic;
	Ac_Load : out std_logic;
	Mar_Load :out std_logic;
	B_Load : out std_logic;
	out_Load :out std_logic;
	Alu_A0 : out std_logic;
	Alu_A1 : out std_logic;
	Alu_A2 : out std_logic;
	Alu_En: out std_logic;
	Ram_Read : out std_logic;
	Hlt : out std_logic);
	
	
end component;
	----------------------------------------------------------------------------------
	component RAM is	
	port(
	Read : in std_logic;
	Input_address : in std_logic_vector(3 downto 0);
	Output_data : out  std_logic_vector(7 downto 0)
	
	);
end component;
----------------------------------------------------------------------------------

component IR is
	port(
	
clk : in  STD_LOGIC;  
clr : in  STD_LOGIC;
Li : in  STD_LOGIC;
Ei : in  STD_LOGIC;
inst_in : in  STD_LOGIC_VECTOR (7 downto 0);
opcod_out: out  STD_LOGIC_VECTOR (3 downto 0);
addr_out : out  STD_LOGIC_VECTOR (3 downto 0));
	
end component;

---------------------------------------------------------------------------------------

	component Accumulator is	 
	port(
	Clk : in std_logic;
	Load : in std_logic;
	En : in std_logic;
	Input_data : in std_logic_vector(7 downto 0);
	Output_ALU : out std_logic_vector(7 downto 0);
	 Output_BUS : out std_logic_vector(7 downto 0)
	);
end component;
---------------------------------------------------------------------------------------------

component MAR is
Port ( Lm : in  STD_LOGIC;
clk : in  STD_LOGIC;
address_input : in STD_LOGIC_VECTOR (3 downto 0);
address_output : out std_logic_vector(3 downto 0)
);
end component;
--------------------------------------------------------------------------------------

	component B is
	port(
	Clk : in std_logic;
	Load : in std_logic;
	Input_data : in std_logic_vector(7 downto 0);
	Output_data : out std_logic_vector(7 downto 0)
	);
	end component;

	-----------------------------------------------------------------------------------------
	
	component Output is
	
	port ( Clk:in std_logic;
	Load:in std_logic;
	Input_data: in std_logic_vector (7 downto 0);
	Output_data:out std_logic_vector (7 downto 0)
	);
	
end component;
-----------------------------------------------------------------------------------------


	component ALU is	
	
	port ( A0 :in std_logic;
	  A1 :in std_logic;
	  A2 :in std_logic;
	En :in std_logic;
	RegB_input:in std_logic_vector (7 downto 0);
	Ac_input:in std_logic_vector (7 downto 0);
	Output_ALU :out std_logic_vector (7 downto 0));
	
end component;
--------------------------------------------------------------------------------------------------

signal operand1 , operand2, Data_Bus : std_logic_vector(7 downto 0);
signal SAP_Clk : std_logic := Clk ;
signal Control_signal : std_logic_vector(13 downto 0) := (others => '0');
signal MAR_Out , IR_Out : std_logic_vector(3 downto 0) := (others => '0');
signal Hlt1 : std_logic := '1';
	  begin
		  SAP_Clk <= Clk and Hlt1;
		  
		  PC1 : PC port map(SAP_Clk,Clr,Control_signal(0),Control_signal(1),Data_Bus(3 downto 0));
		    
		  control : Controller port map(Clk,Clr,IR_Out,Control_signal(0),Control_signal(1),Control_signal(2),Control_signal(3),Control_signal(4),Control_signal(5),Control_signal(6),Control_signal(7),Control_signal(8),Control_signal(9),Control_signal(12),Control_signal(13),Control_signal(10),Control_signal(11),Hlt1);
		    
		  ram1 : RAM port map(Control_signal(11),MAR_Out,Data_Bus);
		    
		  ir1 : IR port map(SAP_Clk,Clr,Control_signal(3),Control_signal(2),Data_Bus,IR_Out,Data_Bus(3 downto 0));
		    
		  ac1 : Accumulator port map(SAP_Clk,Control_signal(5),Control_signal(4),Data_Bus,operand1,Data_Bus);
		    
		  mar1 : MAR port map(Control_signal(6) , SAP_Clk, Data_Bus(3 downto 0),MAR_Out);   
		    
		  output_reg1 : Output port map(SAP_Clk,Control_signal(8), Data_Bus,Output_data);
		    
		  alu1 : ALU  port map(Control_signal(9) , Control_signal(12), Control_signal(13),Control_signal(10), operand2, operand1,Data_Bus);
		    
		  B1 : B port map(SAP_Clk,Control_signal(7),Data_Bus,operand2);
		  
end SAP;

