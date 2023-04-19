----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 20:35:48
-- Design Name: 
-- Module Name: digit_serial_divider - rtl
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit_serial_divider is
Port (     x : in STD_LOGIC_VECTOR (23 downto 0);
           y : in STD_LOGIC_VECTOR (23 downto 0);
           q : out STD_LOGIC_VECTOR (23 downto 0);           
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           clk: in std_logic;
           rst: in std_logic
           );
end digit_serial_divider;

architecture rtl of digit_serial_divider is
component controlpath is
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
end component;

component datapath is
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
end component;

signal  sel_rx,sel_ri,en_y,en_r,en_shift,carry: STD_LOGIC;

begin

datapath0: datapath port map(
           x=>x,
           y=>y,
           q=>q,
           sel_rx=>sel_rx,
           en_y=>en_y,
           en_r=>en_r,
           en_shift=>en_shift,                   
           clk=>clk,
           rst=>rst);

controlpath0: controlpath port map(
           start=>start,           
           sel_rx=>sel_rx,
           en_y=>en_y,
           en_r=>en_r,
           en_shift=>en_shift,  
           done=>done,                 
           clk=>clk,
           rst=>rst
);


end rtl;
