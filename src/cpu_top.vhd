library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_top is
    Port(
        clk     : in std_logic;
        rst     : in std_logic;
        ALU_Out : out std_logic_vector(15 downto 0);
        Mem_Out : out std_logic_vector(15 downto 0)
    );
end cpu_top;

architecture Behavioral of cpu_top is

   
    signal pc_out : std_logic_vector(15 downto 0);

    
    signal instruction : std_logic_vector(15 downto 0);

  
    signal opcode : std_logic_vector(3 downto 0);
    signal rd     : std_logic_vector(3 downto 0);
    signal rs     : std_logic_vector(3 downto 0);
    signal rt     : std_logic_vector(3 downto 0);
    signal imm_8  : std_logic_vector(7 downto 0); 

   
    signal rdata1 : std_logic_vector(15 downto 0);
    signal rdata2 : std_logic_vector(15 downto 0);

   
    signal RegWrite : std_logic;
    signal ALUSrc   : std_logic;
    signal MemRead  : std_logic;
    signal MemWrite : std_logic;
    signal Branch   : std_logic;

    signal ALUOp : std_logic_vector(2 downto 0);

  
    signal alu_B      : std_logic_vector(15 downto 0);
    signal alu_result : std_logic_vector(15 downto 0);

    
    signal imm_ext : std_logic_vector(15 downto 0);

   
    signal mem_data : std_logic_vector(15 downto 0);

    
    signal write_data : std_logic_vector(15 downto 0);

begin

    ------------------------------------------------
    -- Program Counter
    ------------------------------------------------
    PC: entity work.program_counter
    port map(
        clk    => clk,
        rst    => rst,
        pc_out => pc_out
    );

    ------------------------------------------------
    -- Instruction Memory
    ------------------------------------------------
    IM: entity work.InstructionMemory
    port map(
        address     => pc_out(3 downto 0),
        instruction => instruction
    );

    ------------------------------------------------
    -- Decode instruction
    ------------------------------------------------
    opcode <= instruction(15 downto 12);
    rd     <= instruction(11 downto 8);
    rs     <= instruction(7 downto 4);
    rt     <= instruction(3 downto 0);
    imm_8  <= instruction(7 downto 0); 

    ------------------------------------------------
    -- Control Unit
    ------------------------------------------------
    CU: entity work.ControlUnit
    port map(
        opcode   => opcode,
        RegWrite => RegWrite,
        ALUSrc   => ALUSrc,
        MemRead  => MemRead,
        MemWrite => MemWrite,
        Branch   => Branch,
        ALUOp    => ALUOp
    );



    ------------------------------------------------
    -- Register File
    ------------------------------------------------
    RF: entity work.RegisterFile
    port map(
        clk       => clk,
        rst       => rst,          
        readaddr1 => rs,          
        readaddr2 => rt,          
        writeaddr => rd,           
        writeEn   => RegWrite,   
        writedata => write_data,
        readdata1 => rdata1,       
        readdata2 => rdata2      
    );

    ------------------------------------------------
    -- Sign Extend
    ------------------------------------------------
    SE: entity work.sign_extend
    port map(
        input_8bit   => imm_8,     
        output_16bit => imm_ext    
    );

    ------------------------------------------------
    -- MUX (register or immediate)
    ------------------------------------------------
    MUX1: entity work.mux_2to1
    port map(
        a   => rdata2,            
		  b   => imm_ext,            
        sel => ALUSrc,
        y   => alu_B               
    );

    ------------------------------------------------
    -- ALU
    ------------------------------------------------
    ALU1: entity work.ALU
    port map(
        A      => rdata1,
        B      => alu_B,
        ALUOp  => ALUOp,        
        Result => alu_result      
    );

    ------------------------------------------------
    -- Data Memory
    ------------------------------------------------
    DM: entity work.DataMemory
    port map(
        clk         => clk,
        rst         => rst,                   
        address     => alu_result(7 downto 0),
        writeData   => rdata2,
        writeEnable => MemWrite,              
        readData    => mem_data               
    );

    ------------------------------------------------
    -- Write Back MUX
    ------------------------------------------------
    write_data <= mem_data when MemRead='1' else alu_result;

    ------------------------------------------------
    -- outputs for simulation
    ------------------------------------------------
    ALU_Out <= alu_result;
    Mem_Out <= mem_data;

end Behavioral;