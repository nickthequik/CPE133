----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2015 03:39:56 PM
-- Design Name: 
-- Module Name: sp_optimizer - Behavioral
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

entity sp_optimizer is
    Port ( BTN_L, BTN_R, BTN_U, BTN_D, BTN_C: in STD_LOGIC;
           CLK : in STD_LOGIC;
           V_in : in STD_LOGIC;
           V_out : in STD_LOGIC;
           DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
           SSD : out STD_LOGIC_VECTOR (7 downto 0);
           SERVO_H, SERVO_V : out STD_LOGIC;
           STAT : out STD_LOGIC_VECTOR (4 downto 0));
end sp_optimizer;

architecture Behavioral of sp_optimizer is

component FSM is
    Port ( BTN_L, BTN_R, BTN_U, BTN_D, BTN_C : in STD_LOGIC;
           CNT_L, CNT_RU, CNT_D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           HS, VS, MC : out STD_LOGIC;
           SERVO_L, SERVO_R, SERVO_U, SERVO_D : out STD_LOGIC;
           STAT : out STD_LOGIC_VECTOR (4 downto 0);
           CNT_RST : out STD_LOGIC);
end component;

component servo_driver is
    Port ( CLK : in STD_LOGIC;
           BTN_0 : in STD_LOGIC;
           BTN_1 : in STD_LOGIC;
           SERVO : out STD_LOGIC);
end component;

component volt_vis is
    Port ( CLK : in STD_LOGIC;
           V_in : in STD_LOGIC;
           V_out : in STD_LOGIC;
           V_value : out STD_LOGIC_VECTOR (9 downto 0);
           DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
           SSD : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component voltage_comparator is
    Port ( PV : in STD_LOGIC_VECTOR (9 downto 0);
           LV : in STD_LOGIC_VECTOR (9 downto 0);
           GT : out STD_LOGIC);
end component;

component max_counter is
    Port ( CLK : in STD_LOGIC;
           FSM_RST : in STD_LOGIC;
           RESET : in STD_LOGIC; 
           MC : in STD_LOGIC;
           CNT_RU : out STD_LOGIC);
end component;

component horiz_counter is
    Port ( CLK : in STD_LOGIC;
           HS : in STD_LOGIC;
           CNT_L : out STD_LOGIC);
end component;

component vert_counter is
    Port ( CLK : in STD_LOGIC; 
           VS : in STD_LOGIC;
           CNT_D : out STD_LOGIC);
end component;

component FF_Array is
  Port ( CLK : in STD_LOGIC;
         EN : in STD_LOGIC;
         A : in STD_LOGIC_VECTOR(9 downto 0);
         LV : out STD_LOGIC_VECTOR(9 downto 0):= "0000000000" );
end component;

component clock_div is
    Port ( clk : in std_logic;
           sclk : out std_logic);
end component;

signal hs, vs, mc : STD_LOGIC; 
signal cnt_l, cnt_ru, cnt_d : STD_LOGIC; 
signal max_volt, volt : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
signal servo_l, servo_r, servo_u, servo_d : STD_LOGIC;
signal reset : STD_LOGIC;
signal div_clk : STD_LOGIC;
signal cnt_rst : STD_LOGIC;

begin

fsm0: FSM
    port map( BTN_L => BTN_L,
              BTN_R => BTN_R,
              BTN_U => BTN_U,
              BTN_D => BTN_D,
              BTN_C => BTN_C,
              CNT_L => cnt_l,
              CNT_RU => cnt_ru,
              CNT_D => cnt_d,
              CLK => div_clk,
              HS => hs,
              VS => vs,
              MC => mc,
              SERVO_L => servo_l,
              SERVO_R => servo_r,
              SERVO_U => servo_u,
              SERVO_D => servo_d,
              STAT => STAT,
              CNT_RST => cnt_rst);
              
servo_driver0: servo_driver
    port map( CLK => CLK,
              BTN_0 => servo_l,
              BTN_1 => servo_r,
              SERVO => SERVO_H);
           
servo_driver1: servo_driver
    port map( CLK => CLK,
              BTN_0 => servo_u,
              BTN_1 => servo_d,
              SERVO => SERVO_V);

volt_vis0: volt_vis
    port map( CLK => CLK,
              V_in => V_in,
              V_out => V_out,
              V_value => volt,
              DISP_EN => DISP_EN,
              SSD => SSD);

voltage_comparator0: voltage_comparator
    port map( PV => volt,
              LV => max_volt,
              GT => reset);

cd0: clock_div
    port map( clk => CLK,
              sclk => div_clk);
              
max_counter0: max_counter
    port map( CLK => div_clk,
              FSM_RST => cnt_rst,
              RESET => reset, 
              MC => mc,
              CNT_RU => cnt_ru);

horiz_counter0: horiz_counter
    port map( CLK => div_clk,
              HS => hs,
              CNT_L => cnt_l);

vert_counter0: vert_counter
    port map( CLK => div_clk, 
              VS => vs,
              CNT_D => cnt_d);

FF_Array0: FF_Array
  port map( CLK => CLK,
            EN => reset,
            A => volt,
            LV => max_volt);

end Behavioral;
