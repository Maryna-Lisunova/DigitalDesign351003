----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2026 01:08:50
-- Design Name: 
-- Module Name: Tsk1Test - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tsk1_test is
--  Port ( );
end tsk1_test;

architecture Behavioral of tsk1_test is
    component tsk1_top
        port (
            led_out : out std_logic_vector(15 downto 0);
            sw_in : in std_logic_vector(15 downto 0)
        );
    end component;

    signal led_out : std_logic_vector(15 downto 0);
    signal sw_in : std_logic_vector(15 downto 0);
    
    alias A : std_logic is sw_in(3);
    alias B : std_logic is sw_in(2);
    alias C : std_logic is sw_in(1);
    alias D : std_logic is sw_in(0);
begin
    U1 : tsk1_top port map(led_out => led_out, sw_in => sw_in);

    process
    begin
        for i in 0 to 15 loop
            sw_in <= std_logic_vector(to_unsigned(i, 16));
                    wait for 10 ns;
            report "A=" & std_logic'image(A) &
                   " B=" & std_logic'image(B) &
                   " C=" & std_logic'image(C) &
                   " D=" & std_logic'image(D) &
                   " => LED3=" & std_logic'image(led_out(3)) &
                   " LED2=" & std_logic'image(led_out(2)) &
                   " LED1=" & std_logic'image(led_out(1)) &
                   " LED0=" & std_logic'image(led_out(0));
        end loop;
        wait;
    end process;
end Behavioral;
