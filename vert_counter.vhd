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

entity vert_counter is
    Port ( CLK : in STD_LOGIC; 
           VS : in STD_LOGIC;
           CNT_D : out STD_LOGIC);
end vert_counter;

architecture Behavioral of vert_counter is

begin

count_clock: process(CLK, VS)
variable currcount : STD_LOGIC_VECTOR(11 downto 0):= "000000000000";
begin
    if Rising_Edge(CLK) then
        if VS = '1' then
            currcount := currcount + 1;
            if currcount = "111111111111" then
                CNT_D <= '0';
            else
                CNT_D <= '1';
            end if;
        elsif VS = '0' then
            currcount := "000000000000";
            CNT_D <= '0';
        end if;  
    end if;
end process count_clock;                    

end Behavioral;
