----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 04:51:09 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( BTN_L, BTN_R, BTN_U, BTN_D, BTN_C : in STD_LOGIC;
           CNT_L, CNT_RU, CNT_D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           HS, VS, MC : out STD_LOGIC;
           SERVO_L, SERVO_R, SERVO_U, SERVO_D : out STD_LOGIC;
           STAT : out STD_LOGIC_VECTOR (4 downto 0);
           CNT_RST : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is
    type state is (man, hor_sweep, hor_max, vert_sweep, vert_max);
    signal PS : state;
    signal NS : state;
begin

sync_proc: process(CLK, NS)
begin
    if rising_edge(CLK) then
        PS <= NS;
    end if;
end process sync_proc;

comb_proc: process(PS, BTN_L, BTN_R, BTN_U, BTN_D, BTN_C, CNT_L, CNT_RU, CNT_D)
begin
    SERVO_L <= '0'; SERVO_R <= '0';SERVO_U <= '0';SERVO_D <= '0';
    case PS is
        when man => 
            STAT <= "00001";
            if (BTN_C = '1') then 
                NS <= hor_sweep;
                CNT_RST <= '0';
                HS <= '1';
                VS <= '0';
                MC <= '0';
            else
                if (BTN_L = '1') then 
                    SERVO_L <= '1'; SERVO_R <= '0';
                else 
                    SERVO_L <= '0'; 
                end if;
                if (BTN_R = '1') then 
                    SERVO_R <= '1'; SERVO_L <= '0';
                else 
                    SERVO_R <= '0'; 
                end if;
                if (BTN_U = '1') then 
                    SERVO_U <= '1'; SERVO_D <= '0';
                else 
                    SERVO_U <= '0'; 
                end if;
                if (BTN_D = '1') then 
                    SERVO_D <= '1'; SERVO_U <= '0';
                else 
                    SERVO_D <= '0'; 
                end if;
                NS <= man;
                CNT_RST <= '1';
                HS <= '0';
                VS <= '0';
                MC <= '0';
            end if;
        when hor_sweep =>
            STAT <= "00010";
            SERVO_U <= '0'; SERVO_D <= '0';
            CNT_RST <= '0';
            if (CNT_L = '1') then 
                SERVO_L <= '1'; SERVO_R <= '0';
                HS <= '1';
                VS <= '0';
                MC <= '0';
                NS <= hor_sweep;
            else
                SERVO_L <= '0'; SERVO_R <= '0'; 
                NS <= hor_max;
                HS <= '0';
                VS <= '0';
                MC <= '1';
            end if;
        when hor_max =>
            STAT <= "00100";
            SERVO_U <= '0'; SERVO_D <= '0';
            CNT_RST <= '0';
            if (CNT_RU = '1') then
                SERVO_R <= '1'; SERVO_L <= '0';
                HS <= '0';
                VS <= '0';
                MC <= '1';
                NS <= hor_max;
            else
                SERVO_R <= '0'; SERVO_L <= '0';
                NS <= vert_sweep;
                MC <= '0';
                VS <= '1';
                HS <= '0';
            end if;
        when vert_sweep =>
            STAT <= "01000";
            SERVO_L <= '0'; SERVO_R <= '0';
            CNT_RST <= '0';
            if (CNT_D = '1') then
                SERVO_D <= '1'; SERVO_U <= '0';
                NS <= vert_sweep;
                HS <= '0';
                VS <= '1';
                MC <= '0';
            else
                SERVO_D <= '0'; SERVO_U <= '0';
                NS <= vert_max;
                HS <= '0';
                VS <= '0';
                MC <= '1';
            end if;
        when vert_max =>
            STAT <= "10000";
            SERVO_L <= '0'; SERVO_R <= '0';
            CNT_RST <= '0';
            if (CNT_RU = '1') then 
                SERVO_U <= '1'; SERVO_D <= '0';
                NS <= vert_max;
                HS <= '0';
                VS <= '0';
                MC <= '1';
            else
                SERVO_U <= '0'; SERVO_D <= '0';
                NS <= man;
                HS <= '0';
                VS <= '0';
                MC <= '0';
            end if;
        when others =>
            NS <= man; SERVO_L <= '0'; SERVO_R <= '0'; SERVO_U <= '0'; SERVO_D <= '0';
            CNT_RST <= '1'; HS <= '0'; VS <= '0'; MC <= '0';
            STAT <= "00000"; 
     end case;
end process comb_proc;

end Behavioral;
