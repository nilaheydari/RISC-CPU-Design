library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cpu_top is

end tb_cpu_top;

architecture behavior of tb_cpu_top is

   
    component cpu_top
    Port(
        clk     : in std_logic;
        rst     : in std_logic;
        ALU_Out : out std_logic_vector(15 downto 0);
        Mem_Out : out std_logic_vector(15 downto 0)
    );
    end component;

   
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

 
    signal ALU_Out : std_logic_vector(15 downto 0);
    signal Mem_Out : std_logic_vector(15 downto 0);

   
    constant clk_period : time := 10 ns;

begin

   
    uut: cpu_top port map (
        clk     => clk,
        rst     => rst,
        ALU_Out => ALU_Out,
        Mem_Out => Mem_Out
    );

    
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

   
    stim_proc: process
    begin		
       
        rst <= '1';
        wait for 20 ns;	
        
       
        rst <= '0';

        
        wait for 200 ns;
        
       
        wait;
    end process;

end behavior;