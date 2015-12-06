----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2015 07:59:24 PM
-- Design Name: 
-- Module Name: pwm_control - Behavioral
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

entity pwm_control is
    Port (
          CLK : in STD_LOGIC;
          DIR : in STD_LOGIC_VECTOR (1 downto 0);
          EN : in STD_LOGIC;
          SERVO : out STD_LOGIC);
end pwm_control;

architecture Behavioral of pwm_control is

---change time_high and time_low to change the period and duty cycle of the pwm wave (1300 = ccw, 1500 = stopped, 1700 = cw)
begin
    process(CLK, DIR, EN)
        constant time_high_stopped : INTEGER := (1500);
        constant time_high_ccw : INTEGER := (1520);
        constant time_high_cw : INTEGER := (1480);
        constant time_low : INTEGER := (20000);
        variable th_cntr : INTEGER range 0 to 2047 := 0;
        variable tl_cntr : INTEGER range 0 to 32767 := 0;
        begin
            if EN = '1' then 
                if rising_edge(CLK) then
                    ---stopping the servo
                    if DIR = "00" then  
                        if tl_cntr <= time_low then
                            tl_cntr := tl_cntr + 1;
                            SERVO <= '0';
                        elsif th_cntr <= time_high_stopped then
                            th_cntr := th_cntr + 1;
                            SERVO <= '1'; 
                        else
                            tl_cntr := 0;
                            th_cntr := 0;
                            SERVO <= '0';
                        end if;                             
                     ---servo clock wise
                     elsif DIR = "01" then  
                        if tl_cntr <= time_low then
                            tl_cntr := tl_cntr + 1;
                            SERVO <= '0';
                        elsif th_cntr <= time_high_ccw then
                            th_cntr := th_cntr + 1;
                            SERVO <= '1'; 
                        else
                            tl_cntr := 0;
                            th_cntr := 0;
                            SERVO <= '0';
                        end if;
                      ---servo counter clockwise
                      elsif DIR = "10" then  
                        if tl_cntr <= time_low then
                            tl_cntr := tl_cntr + 1;
                            SERVO <= '0';
                        elsif th_cntr <= time_high_cw then
                            th_cntr := th_cntr + 1;
                            SERVO <= '1'; 
                        else
                            tl_cntr := 0;
                            th_cntr := 0;
                            SERVO <= '0';
                        end if;                       
                      end if;
                    end if;
                  end if; 
                
    end process;
    
                
end Behavioral;
