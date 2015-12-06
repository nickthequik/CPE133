----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 10:01:08 AM
-- Design Name: 
-- Module Name: servo_driver - Behavioral
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

entity servo_driver is
    Port ( CLK : in STD_LOGIC;
           BTN_0 : in STD_LOGIC;
           BTN_1 : in STD_LOGIC;
           SERVO : out STD_LOGIC);
end servo_driver;

architecture Behavioral of servo_driver is

component pwm_control is
    Port (
          CLK : in STD_LOGIC;
          DIR : in STD_LOGIC_VECTOR (1 downto 0);
          EN : in STD_LOGIC;
          SERVO : out STD_LOGIC);
end component;

component clk_div2 is
    Port (  
           clk : in std_logic;
           sclk : out std_logic);
end component;

signal direction : STD_LOGIC_VECTOR (1 downto 0);
signal inter_clk : STD_LOGIC;

begin

process(BTN_0, BTN_1)
begin 
    if BTN_0 = '0' and BTN_1 = '0' then
        direction <= "00";
    elsif BTN_0 = '1' and BTN_1 = '0' then
        direction <= "01";
    elsif BTN_0 = '0' and BTN_1 = '1' then
        direction <= "10";
    else
        direction <= "00";
    end if;
end process; 

pwm_control_0 : pwm_control 
    port map( 
              CLK => inter_clk,
              DIR => direction,
              EN => '1',
              SERVO => SERVO);
              
clk_div2_0 : clk_div2
    port map(
              clk => CLK,
              sclk => inter_clk);

end Behavioral;
