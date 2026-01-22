library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_seg_decoder is
    port (
        count_in : in integer range 0 to 8;
        seg_out  : out std_logic_vector(6 downto 0)
    );
end seven_seg_decoder;

architecture behavioral of seven_seg_decoder is
begin
    with count_in select
    seg_out <=
        "0000001" when 0,
        "1001111" when 1,
        "0010010" when 2,
        "0000110" when 3,
        "1001100" when 4,
        "0100100" when 5,
        "0100000" when 6,
        "0001111" when 7,
        "0000000" when 8,
        "1111111" when others;
end behavioral;