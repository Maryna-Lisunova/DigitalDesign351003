library ieee;
use ieee.std_logic_1164.all;

-- nor, >>2, and, -

entity tsk5_top is
    port (
        led_out : out std_logic_vector(15 downto 0);
        sw_in : in std_logic_vector(15 downto 0)
    );
end tsk5_top;

architecture rtl of tsk5_top is
    signal sub_prev : std_logic_vector(6 downto 0);
    alias first_arg : std_logic_vector(5 downto 0) is sw_in(15 downto 10);
    alias second_arg : std_logic_vector(5 downto 0) is sw_in(9 downto 4);
    alias result : std_logic_vector(5 downto 0) is led_out(5 downto 0);
begin
    led_out(15 downto 6) <= "0000000000";
    process (sw_in)
    begin
        -- nor
        if (sw_in(0) = '1') then
            result <= first_arg(5 downto 0) nor second_arg(5 downto 0);
        -- >>2
        elsif (sw_in(1) = '1') then
            result(5 downto 4) <= "00";
            result(3 downto 0) <= first_arg(5 downto 2);
        -- and
        elsif (sw_in(2) = '1') then
            result <= first_arg(5 downto 0) and second_arg(5 downto 0);
        -- -
        elsif (sw_in(3) = '1') then
            sub_prev(0) <= '0';
            for i in 0 to 5 loop
                sub_prev(i + 1) <= (sub_prev(i) or second_arg(i)) and
                                    ((not first_arg(i)) or sub_prev(i)) and
                                    ((not first_arg(i)) or second_arg(i));
                result(i) <= (first_arg(i) or sub_prev(i) or second_arg(i)) and
                                (first_arg(i) or (not sub_prev(i)) or (not second_arg(i))) and
                                ((not first_arg(i)) or sub_prev(i) or (not second_arg(i))) and
                                (not(first_arg(i)) or (not sub_prev(i)) or second_arg(i));
            end loop;
        else
            result <= "000000";
        end if;
    end process;
end rtl;