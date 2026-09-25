library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port (
        address : in  STD_LOGIC_VECTOR (3 downto 0);
        instruction : out STD_LOGIC_VECTOR (15 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

type memory_type is array (0 to 15) of STD_LOGIC_VECTOR(15 downto 0);

signal mem : memory_type := (

0 => "0000000100100011", -- ADD R1, R2, R3 (12 = 8 + 4)
1 => "0001000100100011", -- XOR R1, R2, R3 (12 = 8 XOR 4)
2 => "0010010000000101", -- LOAD R4, 5(R0) 
3 => "0001001000110001", 

others => (others => '0')
);

begin

instruction <= mem(to_integer(unsigned(address)));

end Behavioral;