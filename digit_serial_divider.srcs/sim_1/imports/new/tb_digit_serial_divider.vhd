----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 20:52:54
-- Design Name: 
-- Module Name: tb_digit_serial_divider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;



entity tb_digit_serial_divider is
--  Port ( );
end tb_digit_serial_divider;

architecture rtl of tb_digit_serial_divider is

component digit_serial_divider is
Port (     x : in STD_LOGIC_VECTOR (23 downto 0);
           y : in STD_LOGIC_VECTOR (23 downto 0);
           q : out STD_LOGIC_VECTOR (23 downto 0);           
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           clk: in std_logic;
           rst: in std_logic
           );
end component;

signal x,y,q:std_logic_vector(23 downto 0);
signal start,done,clk,rst: std_logic;
-- Clock period for simulation
constant clk_period : time := 10 ns;

begin

-- EUT instance
divider0: digit_serial_divider
port map(  x=>x,
           y=>y,
           q=>q,
           start=>start,
           done=>done,
           clk=>clk,
           rst=>rst
);

process

begin

rst<='1';
wait for clk_period;
rst<='0';
--x<=std_logic_vector(to_unsigned(integer(1.789634233478*2**23),24));
--y<=std_logic_vector(to_unsigned(integer(1.974231473301*2**23),24));
x<=std_logic_vector(to_unsigned(integer(1*2**23),24));
y<=std_logic_vector(to_unsigned(integer(1.97*2**23),24));
start<='1';
wait for clk_period;
start<='0';

wait;


end process;

process
begin
clk<='0';
wait for clk_period/2;
clk<='1';
wait for clk_period/2;
end process;


end architecture;
