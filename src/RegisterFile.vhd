library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity RegisterFile is
 port (
 clk : in std_logic;
 rst : in std_logic;
 readaddr1 : in std_logic_vector(3 downto 0);
 readaddr2 : in std_logic_vector(3 downto 0);
 writeaddr : in std_logic_vector(3 downto 0);
 writeEn : in std_logic;
 writedata : in std_logic_vector(15 downto 0);
 readdata1 : out std_logic_vector(15 downto 0);
 readdata2 : out std_logic_vector(15 downto 0)
 );
end RegisterFile;
architecture rtl of RegisterFile is
 type reg_array is array (0 to 15) of std_logic_vector(15 downto 0);
 signal registers : reg_array := (
     2 => x"0008", -- R2 = 8
     3 => x"0004", -- R3 = 4
     others => (others => '0')
 );
begin
 process(clk)
 begin
 if rising_edge(clk) then
 if rst = '1' then
 --registers <= (others => (others => '0'));
 elsif writeEn = '1' then
 registers(to_integer(unsigned(writeaddr))) <= writedata;
 end if;
 end if;
 end process;
 readdata1 <= registers(to_integer(unsigned(readaddr1)));
 readdata2 <= registers(to_integer(unsigned(readaddr2)));
end rtl;