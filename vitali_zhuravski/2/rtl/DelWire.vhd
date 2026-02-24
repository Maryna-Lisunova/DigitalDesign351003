library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;
use work.delayed_components.all;

entity DEL_WIRE is
    generic (
        delay : time := WIRE_DELAY
    );
    port (
        I : in std_logic;
        O : out std_logic
    );
end DEL_WIRE;

architecture rtl of DEL_WIRE is
begin
    O <= I after delay;
end rtl;