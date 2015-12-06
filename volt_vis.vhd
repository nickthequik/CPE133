----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2015 05:40:43 PM
-- Design Name: 
-- Module Name: volt_vis - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity volt_vis is
    Port ( CLK : in STD_LOGIC;
           V_in : in STD_LOGIC;
           V_out : in STD_LOGIC;
           V_value : out STD_LOGIC_VECTOR (9 downto 0);
           DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
           SSD : out STD_LOGIC_VECTOR (7 downto 0));
end volt_vis;

architecture Behavioral of volt_vis is

component adc is 
    Port ( V_in : in STD_LOGIC;
           V_out : in STD_LOGIC;
           clk : in STD_LOGIC;
           d_rdy : out STD_LOGIC;
           do_out : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component sseg_dec is 
    Port ( ALU_VAL : in std_logic_vector(9 downto 0); 
		   SIGN : in std_logic;
	       VALID : in std_logic;
           CLK : in std_logic;
           DISP_EN : out std_logic_vector(3 downto 0);
           SEGMENTS : out std_logic_vector(7 downto 0));
end component;

signal valid, sign : STD_LOGIC;
signal value : STD_LOGIC_VECTOR (15 downto 0);  

begin

valid <= '1';
sign <= '0';
V_value <= value(15 downto 6);

adc0 : adc 
    port map( V_in => V_in,
              V_out => V_out,
              clk => CLK,
              d_rdy => open,
              do_out => value);                  --15:4 2^10

sseg0 : sseg_dec
    port map( ALU_VAL => value(15 downto 6),                  
              SIGN => sign,
              VALID => valid,
              CLK => CLK,
              DISP_EN => DISP_EN,
              SEGMENTS => SSD);

end Behavioral;
