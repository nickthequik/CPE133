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

entity max_counter is
    Port ( CLK : in STD_LOGIC;
           FSM_RST: in STD_LOGIC;
           RESET : in STD_LOGIC; 
           MC : in STD_LOGIC;
           CNT_RU : out STD_LOGIC);
end max_counter;

architecture Behavioral of max_counter is

begin

count_clock: process(CLK, FSM_RST, RESET, MC)
variable currcount : STD_LOGIC_VECTOR(12 downto 0):= "0000000000000";
begin
        if RESET  = '1' or FSM_RST = '1' then 
            currcount := "0000000000000";
            CNT_RU <= '0';
        elsif Rising_Edge(CLK) then
            if MC = '0' then
                currcount := currcount + 1;
                CNT_RU <= '0';
            elsif MC = '1' then
                currcount := currcount - 1;
                if currcount = "000000000000" then
                    CNT_RU <= '0';
                else
                    CNT_RU <= '1';
                end if;
            end if;  
        end if;
end process count_clock;                 

end Behavioral;
