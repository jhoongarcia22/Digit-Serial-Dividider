----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 20:08:17
-- Design Name: 
-- Module Name: controlpath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controlpath is
    port (   
    clk: in std_logic;
    rst: in std_logic;    
           
           sel_rx : out STD_LOGIC;
           en_y : out STD_LOGIC;
           en_r : out STD_LOGIC;
           en_shift : out STD_LOGIC;     
    start: in std_logic;
    done: out std_logic
   
 
     );
end entity;

architecture rtl of controlpath is

component fsm is     
     port (   
    clk: in std_logic;
    rst: in std_logic;    
           
           sel_rx : out STD_LOGIC;
           en_y : out STD_LOGIC;
           en_r : out STD_LOGIC;
           en_shift : out STD_LOGIC;
           en_counter: out STD_LOGIC;
           clr_counter: out STD_LOGIC;
    ovf: in std_logic;
    start: in std_logic
   
 
     );
end component;

component reg is
	generic (N	:integer:=8 );
	
port(
 	clk: in 		std_logic;
 	en: in std_logic;
 	rst: in           std_logic;
 	clr: in           std_logic;
	d: in 		std_logic_vector(N-1 downto 0);
	q: out	std_logic_vector(N-1 downto 0)
	);
end component;

signal ovf,en_counter,clr_counter:std_logic;
signal counter_out,adder_out: std_logic_vector(4 downto 0);

begin

-- The Finite State Machine
fsm0: fsm port map( 
    clk=>clk,
    rst=>rst,
    sel_rx=>sel_rx,
    en_y=>en_y,
    en_r=>en_r,
    en_shift=>en_shift,
    en_counter=>en_counter,
    clr_counter=>clr_counter,
    ovf=>ovf,
    start=>start 
     );
     
-- The counter register
regr: reg 
    generic map(N=>5)
    port map(
    clk=>clk,
    rst=>rst,
    clr=>clr_counter,
    en=>en_counter,
    d=>adder_out,
    q=>counter_out
    );

-- The counter adder
adder_out<=std_logic_vector(unsigned(counter_out)+to_unsigned(1,5));

-- The comparator
ovf<='1' when counter_out=std_logic_vector(to_unsigned(23,5)) else '0';    
    
done<=ovf;    
     


end architecture;
