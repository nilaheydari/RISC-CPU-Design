library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        address     : in  std_logic_vector(7 downto 0);
        writeData   : in  std_logic_vector(15 downto 0);
        writeEnable : in  std_logic;
        readData    : out std_logic_vector(15 downto 0)
    );
end DataMemory;

architecture Behavioral of DataMemory is

    type mem_array is array (0 to 255) of std_logic_vector(15 downto 0);
    signal ram : mem_array := (
        5 => x"000F", -- Address 5 = 15
        others => (others => '0')
    );
begin

    process(clk, rst)
    begin
        if rst = '1' then
            --ram <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if writeEnable = '1' then
                ram(to_integer(unsigned(address))) <= writeData;
            end if;
        end if;
    end process;

    readData <= ram(to_integer(unsigned(address))); 

end Behavioral;