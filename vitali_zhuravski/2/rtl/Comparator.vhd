library ieee;
use ieee.std_logic_1164.all;

library work;
use work.delayed_components.all;

-- ?? ???? ??????? ????? ?????, ????? ? greater, ?
-- smaller ????? 0.

-- greater_out = greater_in + first(not second)(not smaller_in)
-- smaller_out = smaller_in + (not first)second(not greater_in)
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

    signal nSnSMr : std_logic;
    signal nFnGRr : std_logic;
    
    signal nSnSM : std_logic;
    signal nFnGR : std_logic;
    
    signal FnSnSMr : std_logic;
    signal nFSnGRr : std_logic;
    
    signal FnSnSM : std_logic;
    signal nFSnGR : std_logic;
begin
    U1 : DEL_NOR2 port map(I0 => S, I1 => Si, O => nSnSMr);
    U2 : DEL_NOR2 port map(I0 => F, I1 => Gi, O => nFnGRr);
    
    W1 : DEL_WIRE port map(I => nSnSMr, O => nSnSM);
    W2 : DEL_WIRE port map(I => nFnGRr, O => nFnGR);
    
    U3 : DEL_AND2 port map(I0 => F, I1 => nSnSM, O => FnSnSMr);
    U4 : DEL_AND2 port map(I0 => S, I1 => nFnGR, O => nFSnGRr);
    
    W3 : DEL_WIRE port map(I => FnSnSMr, O => FnSnSM); 
    W4 : DEL_WIRE port map(I => nFSnGRr, O => nFSnGR); 
    
    U5 : DEL_OR2 port map(I0 => Gi, I1 => FnSnSM, O => Go);
    U6 : DEL_OR2 port map(I0 => Si, I1 => nFSnGR, O => So);
end structure;