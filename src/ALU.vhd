library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        A      : in  std_logic_vector(15 downto 0);
        B      : in  std_logic_vector(15 downto 0);
        ALUOp  : in  std_logic_vector(2 downto 0);
        Result : out std_logic_vector(15 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
begin

process(A,B,ALUOp)
begin
    case ALUOp is

        when "000" => 
            Result <= std_logic_vector(signed(A) + signed(B)); -- ADD

        when "001" => 
            Result <= std_logic_vector(signed(A) - signed(B)); -- SUB

        when "010" =>
            Result <= A and B;

        when "011" =>
            Result <= A or B;

        when "100" =>
            Result <= A xor B;

        when "101" =>
            Result <= not A;

        when "110" =>
            Result <= std_logic_vector(shift_left(unsigned(A),1));

        when "111" =>
            Result <= std_logic_vector(shift_right(unsigned(A),1));

        when others =>
            Result <= (others => '0');

    end case;
end process;

end Behavioral;