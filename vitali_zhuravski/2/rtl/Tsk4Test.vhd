----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.02.2026 23:42:02
-- Design Name: 
-- Module Name: Tsk4Test - Behavioral
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

entity tsk4_test is
--  Port ( );
end tsk4_test;

architecture Behavioral of tsk4_test is
    component tsk4_top
        port (
            led_out : out std_logic_vector(15 downto 0);
            sw_in : in std_logic_vector(15 downto 0)
        );
    end component;

    signal led_out : std_logic_vector(15 downto 0);
    signal sw_in : std_logic_vector(15 downto 0);
    
    alias input : std_logic_vector(7 downto 0) is sw_in(7 downto 0);
    alias num1 : std_logic_vector(2 downto 0) is input(5 downto 3);
    alias num2 : std_logic_vector(2 downto 0) is input(2 downto 0);
    alias greater_in : std_logic is input(7);
    alias smaller_in : std_logic is input(6);
begin
    U1 : tsk4_top port map(led_out => led_out, sw_in => sw_in);
    process
    begin
        for i in 0 to 191 loop
            sw_in <= std_logic_vector(to_unsigned(i, 16));
                    wait for 55 ns;
            report "Gi=" & std_logic'image(greater_in) &
                   " Si=" & std_logic'image(smaller_in) &
                   " N1=" & integer'image(to_integer(unsigned(num1))) &
                   " N2=" & integer'image(to_integer(unsigned(num2))) &
                   " => Go=" & std_logic'image(led_out(1)) &
                   " So=" & std_logic'image(led_out(0));
        end loop;
        wait;
    end process;
end Behavioral;
