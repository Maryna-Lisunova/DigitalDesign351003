library ieee;
use ieee.std_logic_1164.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.delayed_components.all;

-- 3: nAnBCD = (A nor B)CD
-- 2: nAnBCnD = (A nor B)CnD = (A nor B)(C xor D)C
-- 1: nAnBnCD = (A nor B)nCD = (A nor B)(C xor D)D
-- 0: nAnBnCnD = (A nor B)nCnD = (A nor B)(C nor D)

entity tsk3_top is
    port (
        led_out : out std_logic_vector(15 downto 0);
        sw_in : in std_logic_vector(15 downto 0)
    );
end tsk3_top;

architecture structure of tsk3_top is
    alias A : std_logic is sw_in(3);
    alias B : std_logic is sw_in(2);
    alias C : std_logic is sw_in(1);
    alias D : std_logic is sw_in(0);
    
    signal nC : std_logic;
    signal nD : std_logic;
    
    signal nAnB : std_logic;
    signal nAnBC : std_logic;
    signal nAnBnC : std_logic;
    signal CD : std_logic;
begin
    led_out(15 downto 4) <= "000000000000";
    
    U1 : DEL_INV port map (I => C, O => nC);
    U2 : DEL_INV port map (I => D, O => nD);
    
    U3 : DEL_NOR2 port map (I0 => A, I1 => B, O => nAnB);
    U4 : DEL_AND2 port map (I0 => nAnB, I1 => C, O => nAnBC);
    U5 : DEL_AND2 port map (I0 => nAnB, I1 => nC, O => nAnBnC);
    
    U6 : DEL_AND2 port map (I0 => nAnBC, I1 => D, O => led_out(3));
    U7 : DEL_AND2 port map (I0 => nAnBC, I1 => nD, O => led_out(2));
    U8 : DEL_AND2 port map (I0 => nAnBnC, I1 => D, O => led_out(1));
    U9 : DEL_AND2 port map (I0 => nAnBnC, I1 => nD, O => led_out(0));
end structure;