-- ============================================================================
-- Title      : data_path.vhd
-- Description: Implements the datapath of an 8-bit CPU including registers, buses,
--              and an ALU. Buses are controlled via multiplexers selected by control
--              signals. Data is routed through Bus1 and Bus2 to registers or memory.
--              ALU outputs results and status flags (NZVC).
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_path is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        Bus1_Sel   : in  std_logic_vector(1 downto 0);     -- Select source for Bus1
        Bus2_Sel   : in  std_logic_vector(1 downto 0);     -- Select source for Bus2
        A_Load     : in  std_logic;                        -- Enable loading register A
        B_Load     : in  std_logic;                        -- Enable loading register B
        PC_Load    : in  std_logic;                        -- Enable loading PC
        PC_Inc     : in  std_logic;                        -- Enable incrementing PC
        IR_Load    : in  std_logic;                        -- Enable loading Instruction Register
        MAR_Load   : in  std_logic;                        -- Enable loading Memory Address Register
        CCR_Load   : in  std_logic;                        -- Enable loading Condition Code Register
        ALU_Sel    : in  std_logic_vector(2 downto 0);     -- ALU operation selector
        from_memory: in  std_logic_vector(7 downto 0);     -- Data input from memory
        to_memory  : out std_logic_vector(7 downto 0);     -- Data output to memory
        address    : out std_logic_vector(7 downto 0);     -- Memory address
        IR         : out std_logic_vector(7 downto 0);     -- Instruction register output
        CCR        : out std_logic_vector(3 downto 0)      -- Condition flags output
    );
end data_path;

architecture Behavioral of data_path is
    signal Bus1, Bus2 : std_logic_vector(7 downto 0); -- Internal buses
    signal PC, A, B, MAR, IR_reg : std_logic_vector(7 downto 0); -- Registers
    signal ALU_Result : std_logic_vector(7 downto 0); -- ALU result
    signal NZVC : std_logic_vector(3 downto 0);       -- ALU flags

    component alu
        Port (
            A        : in  std_logic_vector(7 downto 0);
            B        : in  std_logic_vector(7 downto 0);
            ALU_Sel  : in  std_logic_vector(2 downto 0);
            Result   : out std_logic_vector(7 downto 0);
            NZVC     : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    -- Mux for Bus1: selects PC, A, or B to drive Bus1
    process(Bus1_Sel, PC, A, B)
    begin
        case Bus1_Sel is
            when "00" => Bus1 <= PC;
            when "01" => Bus1 <= A;
            when "10" => Bus1 <= B;
            when others => Bus1 <= (others => '0');
        end case;
    end process;

    -- Mux for Bus2: selects ALU result, Bus1 or from memory
    process(Bus2_Sel, ALU_Result, Bus1, from_memory)
    begin
        case Bus2_Sel is
            when "00" => Bus2 <= ALU_Result;
            when "01" => Bus2 <= Bus1;
            when "10" => Bus2 <= from_memory;
            when others => Bus2 <= (others => '0');
        end case;
    end process;

    -- PC register with load and increment
    process(clk, reset)
    begin
        if reset = '0' then
            PC <= (others => '0');
        elsif rising_edge(clk) then
            if PC_Load = '1' then
                PC <= Bus2;
            elsif PC_Inc = '1' then
                PC <= std_logic_vector(unsigned(PC) + 1);
            end if;
        end if;
    end process;

    -- A register
    process(clk, reset)
    begin
        if reset = '0' then
            A <= (others => '0');
        elsif rising_edge(clk) then
            if A_Load = '1' then
                A <= Bus2;
            end if;
        end if;
    end process;

    -- B register
    process(clk, reset)
    begin
        if reset = '0' then
            B <= (others => '0');
        elsif rising_edge(clk) then
            if B_Load = '1' then
                B <= Bus2;
            end if;
        end if;
    end process;

    -- Instruction Register
    process(clk, reset)
    begin
        if reset = '0' then
            IR_reg <= (others => '0');
        elsif rising_edge(clk) then
            if IR_Load = '1' then
                IR_reg <= Bus2;
            end if;
        end if;
    end process;

    -- Memory Address Register
    process(clk, reset)
    begin
        if reset = '0' then
            MAR <= (others => '0');
        elsif rising_edge(clk) then
            if MAR_Load = '1' then
                MAR <= Bus2;
            end if;
        end if;
    end process;

    -- Condition Code Register
    process(clk, reset)
    begin
        if reset = '0' then
            CCR <= (others => '0');
        elsif rising_edge(clk) then
            if CCR_Load = '1' then
                CCR <= NZVC;
            end if;
        end if;
    end process;

    -- Output assignments
    IR <= IR_reg;
    address <= MAR;
    to_memory <= Bus1;

    -- ALU instantiation
    alu_inst : alu port map (
        A => A,
        B => B,
        ALU_Sel => ALU_Sel,
        Result => ALU_Result,
        NZVC => NZVC
    );

end Behavioral;
