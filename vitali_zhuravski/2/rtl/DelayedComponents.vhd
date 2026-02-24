library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package delayed_components is
    constant INV_DELAY : time := 1 ns;
    
    component DEL_INV is
        generic (
            delay : time := INV_DELAY
        );
        port (
            I : in std_logic;
            O : out std_logic
        );
    end component;
end delayed_components;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;
use work.delayed_components.all;

entity DEL_INV is
    generic (
        delay : time := INV_DELAY
    );
    port (
        I : in std_logic;
        O : out std_logic
    );
end DEL_INV;

architecture rtl of DEL_INV is
begin
    O <= not I after delay;
end rtl;