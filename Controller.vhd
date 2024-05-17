
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Controller is   
	
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
	
	
end Controller;



architecture controller of Controller is
type state is (idle,t1,t2,t3,t4,t5,t6);
signal present_state ,next_state : state := t1 ;
signal Control_signal : std_logic_vector (13 downto 0):= (others=> '0') ;
signal Hlt_signal : std_logic := '1';


begin
  
	process(Clk,Clr)
	begin
		
		if Clr ='0' then 
			Present_state <= idle;
		elsif rising_edge (Clk)	then
			present_state <= next_state;
		end if;
		end process;
	
	 process(present_state)
	 begin			 
		case present_state is 
			
			when idle => 
			control_signal <= (others=>'0');
			Hlt_signal <= '1';
			next_state <= t1;
			
			when t1 => 
			-- AR <- PC
			control_signal <= "00000001000001" ;
			next_state <= t2;
			
			when t2 =>
			--Pc <- PC+1
			control_signal <= "00000000000010" ;
			next_state <= t3;
			
			when t3 =>
			-- IR <- M[AR]
			control_signal <= "00100000001000" ;
			next_state <= t4;
			------------------------------------------------
			when t4 =>	  
			-- Hlt instruction 
			if instruction_in = "1111"		then
				Hlt_signal <= '0';
				control_signal <= "00000000000000" ;
				
			-- out instrucion ( out <- AC)
			elsif	instruction_in = "1110"				  then
				   control_signal <= "00000100010000" ;
				   
			elsif instruction_in = "0011"      then        -- shift right
			     control_signal <= "10010000100000" ;
			     
			     elsif instruction_in = "0100"      then        -- shift left
			     control_signal <= "10011000100000" ;
			
			else  
				 -- AR <- IR(0 - 3)
				 control_signal <= "00000001000100";
				   
				   
			end if;
				 next_state <= t5;
			
				 
			when t5 =>	 
				-- LDA	 AC <- M[AR]
			if instruction_in = "0000"	   then
				control_signal <= "00100000100000";
				
				-- ADD or sub or AND or OR		B <- M[AR]
			elsif( (instruction_in = "0001") or  (instruction_in = "0010")	or  (instruction_in = "0101") or  (instruction_in = "0110"))  then
				control_signal <= "00100010000000";
		 		
			else 
				control_signal <= "00000000000000";
			end if;
			next_state <= t6;
			
			when t6 =>
			  -- ADD
			if instruction_in = "0001"			 then
				control_signal <= "00010000100000";
			 -- SUB
			elsif instruction_in = "0010"  then
				control_signal <= "00011000100000";
			 -- AND
			 elsif instruction_in = "0101"  then
				control_signal <= "01010000100000";
				-- OR
				elsif instruction_in = "0110"  then
				control_signal <= "01011000100000";
			 
			else
				control_signal <= "00000000000000";
			end if;	 
			next_state <= t1;
			
			end case;
		 end process;
		 
		 -- put signals into output control
	Pc_En 	  <= 	control_signal(0);
	Pc_Inc	  <=	control_signal(1);
	Ir_En 	  <=	control_signal(2);
	Ir_Load   <=	control_signal(3);
	Ac_En 	  <=	control_signal(4);
	Ac_Load   <=	control_signal(5);
	Mar_Load  <=	control_signal(6);
	B_Load 	  <=	control_signal(7);
	out_Load  <=	control_signal(8);
	Alu_A0 	  <=	control_signal(9);
	Alu_En	  <=	control_signal(10);
	Ram_Read  <=	control_signal(11);
	Alu_A1 	  <=	control_signal(12);
	Alu_A2 	  <=	control_signal(13);
  Hlt <= Hlt_signal;

end controller;