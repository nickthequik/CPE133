----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2015 04:49:18 PM
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity adc is
    Port ( V_in : in STD_LOGIC;
           V_out : in STD_LOGIC;
           clk : in STD_LOGIC;
           d_rdy : out STD_LOGIC;
           do_out : out STD_LOGIC_VECTOR (15 downto 0));
end adc;

architecture Behavioral of adc is

component xadc_wiz_0 is 
    port
      (
       daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
       den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
       di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
       dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
       do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
       drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
       dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
       reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
       vauxp6          : in  STD_LOGIC;                         -- Auxiliary Channel 6
       vauxn6          : in  STD_LOGIC;
       busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
       channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
       eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
       eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
       alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
       vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
       vn_in           : in  STD_LOGIC
      );
end component;

signal ADC_addr : STD_LOGIC_VECTOR (6 downto 0);
signal ADC_enable : STD_LOGIC;

begin

ADC_addr <= "001" & x"6";

ADC : xadc_wiz_0 
    port map (daddr_in => ADC_addr,
              den_in =>  ADC_enable,     
              di_in => x"0000",
              dwe_in => '0',          
              do_out => do_out,      
              drdy_out => d_rdy,   
              dclk_in => clk,        
              reset_in => '0',
              vauxp6 => V_in,
              vauxn6 => V_out,    
              busy_out => open,       
              channel_out => open,    
              eoc_out => ADC_enable,       
              eos_out => open,
              alarm_out => open,       
              vp_in => '0',        
              vn_in => '0');          
              
end Behavioral;