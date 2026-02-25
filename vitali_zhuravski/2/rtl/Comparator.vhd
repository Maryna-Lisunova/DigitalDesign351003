library ieee;
use ieee.std_logic_1164.all;

library work;
use work.delayed_components.all;

-- ?? ???? ??????? ????? ?????, ????? ? greater, ?
-- smaller ????? 0.

-- greater_out = greater_in + (not greater_in)first(not second) = 
--             = greater_in + first(not second)
-- smaller_out = smaller_in + (not smaller_in)(not first)second =
--             = smaller_in + (not first)second
entity COMPARATOR is
    port (
        greater_in : in std_logic;
        smaller_in : in std_logic;
        first : in std_logic;
        second : in std_logic;
        greater_out : out std_logic;
        smaller_out : out std_logic
    );
end COMPARATOR;

architecture structure of COMPARATOR is
    alias F : std_logic is first;
    alias S : std_logic is second;
    alias Gi : std_logic is greater_in;
    alias Si : std_logic is smaller_in;
    alias Go : std_logic is greater_out;
    alias So : std_logic is smaller_out;

    signal nFr : std_logic;
    signal nSr : std_logic;
    
    signal nF : std_logic;
    signal nS : std_logic;
    
    signal FnSr : std_logic;
    signal nFSr : std_logic;
    
    signal FnS : std_logic;
    signal nFS : std_logic;
begin
    U1 : DEL_INV port map(I => F, O => nFr);
    U2 : DEL_INV port map(I => S, O => nSr);
    
    W1 : DEL_WIRE port map(I => nFr, O => nF);
    W2 : DEL_WIRE port map(I => nSr, O => nS);
    
    U3 : DEL_AND2 port map(I0 => F, I1 => nS, O => FnSr);
    U4 : DEL_AND2 port map(I0 => nF, I1 => S, O => nFSr);
    
    W3 : DEL_WIRE port map(I => FnSr, O => FnS); 
    W4 : DEL_WIRE port map(I => nFSr, O => nFS); 
    
    U5 : DEL_OR2 port map(I0 => Gi, I1 => FnS, O => Go);
    U6 : DEL_OR2 port map(I0 => Si, I1 => nFS, O => So);
end structure;