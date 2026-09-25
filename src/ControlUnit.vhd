library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port (
        opcode    : in  STD_LOGIC_VECTOR(3 downto 0);
        RegWrite  : out STD_LOGIC;
        ALUSrc    : out STD_LOGIC;
        MemRead   : out STD_LOGIC;
        MemWrite  : out STD_LOGIC;
        Branch    : out STD_LOGIC;
        ALUOp     : out STD_LOGIC_VECTOR(2 downto 0) 
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(opcode)
    begin     
      
        RegWrite <= '0';
        ALUSrc   <= '0';
        MemRead  <= '0';
        MemWrite <= '0';
        Branch   <= '0';
        ALUOp    <= "000";

        case opcode is
            when "0000" => -- ADD
                RegWrite <= '1';
                ALUSrc   <= '0';
                ALUOp    <= "000"; 

            when "0001" => -- XOR
                RegWrite <= '1';
                ALUSrc   <= '0';
                ALUOp    <= "100";

            when "0010" => -- LOAD
                RegWrite <= '1';
                ALUSrc   <= '1';
                MemRead  <= '1';
                ALUOp    <= "000"; 

            when "0011" => -- STORE
                ALUSrc   <= '1';
                MemWrite <= '1';
                ALUOp    <= "000";

            when "0100" => -- BRANCH
                Branch   <= '1';
                ALUOp    <= "001"; 

            when others =>
                null;
        end case;
    end process;
end Behavioral;