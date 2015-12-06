----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2015 05:23:31 PM
-- Design Name: 
-- Module Name: FF_Array - Behavioral
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

entity FF_Array is
  Port ( CLK : in STD_LOGIC;
         EN : in STD_LOGIC;
         A : in STD_LOGIC_VECTOR(9 downto 0);
         LV : out STD_LOGIC_VECTOR(9 downto 0):= "0000000000" );
end FF_Array;

architecture Behavioral of FF_Array is
signal inter : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
begin
comp: process(CLK, A, EN)   
    begin
        if rising_edge(CLK) then
            if EN <= '1' then
                LV <= A;
                inter <= A;           
            else 
                LV <= inter;
            end if;
        end if;
    end process comp; 


end Behavioral;
