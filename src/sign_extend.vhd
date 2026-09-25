library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sign_extend is
    Port ( input_8bit  : in  STD_LOGIC_VECTOR (7 downto 0);
           output_16bit : out STD_LOGIC_VECTOR (15 downto 0));
end sign_extend;

architecture Behavioral of sign_extend is
begin
    process(input_8bit)
    begin
        output_16bit(15 downto 8) <= (others => input_8bit(7));
        output_16bit(7 downto 0)  <= input_8bit;
    end process;
end Behavioral;