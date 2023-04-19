----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 14:22:29
-- Design Name: 
-- Module Name: datapath - rtl
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

entity datapath is
    Port ( x : in STD_LOGIC_VECTOR (23 downto 0);
           y : in STD_LOGIC_VECTOR (23 downto 0);
           q : out STD_LOGIC_VECTOR (23 downto 0);
           sel_rx : in STD_LOGIC;
           en_y : in STD_LOGIC;
           en_r : in STD_LOGIC;
           en_shift : in STD_LOGIC;                   
           clk: in std_logic;
           rst: in std_logic
           );
end entity;

architecture rtl of datapath is

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

component shift_reg is
	generic (N	:integer:=8 );
	
port(
 	clk: in 		std_logic;
 	en: in std_logic;
 	rst: in           std_logic;
 	clr: in           std_logic;
	serial_in: in 		std_logic;
	q: out	std_logic_vector(N-1 downto 0)
	);
end component;

signal mux_rx_out,mux_ri_out,reg_r_out,reg_y_out,sub_out,internal_y: std_logic_vector(24 downto 0);
signal not_internal_carry,internal_carry,aux_carry: std_logic;
begin

-- The r X mutiplexer
mux_rx_out<=mux_ri_out(23 downto 0) & '0' when (sel_rx='0') else  '0' & x;

-- The remainder register
regr: reg 
    generic map(N=>25)
    port map(
    clk=>clk,
    rst=>rst,
    clr=>'0',
    en=>en_r,
    d=>mux_rx_out,
    q=>reg_r_out
    );

-- The y register
internal_y<='0' &y;
regy: reg 
    generic map(N=>25)
    port map(
    clk=>clk,
    rst=>rst,
    clr=>'0',
    en=>en_y,
    d=>internal_y,
    q=>reg_y_out
    );
    
-- The subtractor
sub_out<=std_logic_vector(unsigned(reg_r_out)-unsigned(reg_y_out));
internal_carry<=sub_out(24);
not_internal_carry<=not(internal_carry);
aux_carry<=not_internal_carry;

-- The residue mutiplexer
mux_ri_out<=reg_r_out when (aux_carry='0') else   sub_out;




-- The shift register
shift_reg0: shift_reg 
    generic map(N=>24)
    port map(
    clk=>clk,
    rst=>rst,
    clr=>'0',
    en=>en_shift,
    serial_in=>not_internal_carry,
    q=>q
    );

end architecture;
