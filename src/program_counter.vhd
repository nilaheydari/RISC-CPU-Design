library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity program_counter is
 port (
 clk : in std_logic;
 rst : in std_logic; 
 pc_out : out std_logic_vector(15 downto 0)
 );
end entity program_counter;
architecture rtl of program_counter is
 signal pc_reg : unsigned(15 downto 0) := (others => '0');
begin
 process(clk, rst)
 begin
 if rst = '1' then
 pc_reg <= (others => '0'); 
 elsif rising_edge(clk) then
 pc_reg <= pc_reg + 1; 
 end if;
 end process;
 pc_out <= std_logic_vector(pc_reg);
end architecture rtl;