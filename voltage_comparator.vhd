----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2015 05:54:25 PM
-- Design Name: 
-- Module Name: voltage_comparator - Behavioral
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

entity voltage_comparator is
    Port ( PV : in STD_LOGIC_VECTOR (9 downto 0);
           LV : in STD_LOGIC_VECTOR (9 downto 0);
           GT : out STD_LOGIC);
end voltage_comparator;

architecture Behavioral of voltage_comparator is

begin
comp : process(PV, LV)
begin
    if PV(9 downto 4) > LV(9 downto 4) then 
        GT <= '1';
    else GT <= '0';
    end if;
end process comp;

end Behavioral;
