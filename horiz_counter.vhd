----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2015 05:36:48 PM
-- Design Name: 
-- Module Name: max_counter - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity horiz_counter is
    Port ( CLK : in STD_LOGIC;
           HS : in STD_LOGIC;
           CNT_L : out STD_LOGIC);
end horiz_counter;

architecture Behavioral of horiz_counter is

begin

count_clock: process(CLK, HS)
variable currcount : STD_LOGIC_VECTOR(12 downto 0):= "0000000000000";
begin
    if Rising_Edge(CLK) then
        if HS = '1' then
            currcount := currcount + 1;
            if currcount = "1111111111111" then
                CNT_L <= '0';
            else
                CNT_L <= '1';
            end if;
        elsif HS = '0' then
            currcount := "0000000000000";
            CNT_L <= '0';
        end if;  
    end if;
end process count_clock;                 

end Behavioral;
