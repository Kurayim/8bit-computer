----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2025 12:41:49 PM
-- Design Name: 
-- Module Name: data_path_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_path_tb is
--  Port ( );
end data_path_tb;

architecture Behavioral of data_path_tb is
    -- Component Declaration
    component data_path
        Port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            Bus1_Sel   : in  std_logic_vector(1 downto 0);
            Bus2_Sel   : in  std_logic_vector(1 downto 0);
            A_Load     : in  std_logic;
            B_Load     : in  std_logic;
            PC_Load    : in  std_logic;
            PC_Inc     : in  std_logic;
            IR_Load    : in  std_logic;
            MAR_Load   : in  std_logic;
            CCR_Load   : in  std_logic;
            ALU_Sel    : in  std_logic_vector(2 downto 0);
            from_memory: in  std_logic_vector(7 downto 0);
            to_memory  : out std_logic_vector(7 downto 0);
            address    : out std_logic_vector(7 downto 0);
            IR         : out std_logic_vector(7 downto 0);
            CCR        : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signals
    signal clk, reset : std_logic := '0';
    signal Bus1_Sel, Bus2_Sel : std_logic_vector(1 downto 0);
    signal A_Load, B_Load, PC_Load, PC_Inc, IR_Load, MAR_Load, CCR_Load : std_logic;
    signal ALU_Sel : std_logic_vector(2 downto 0);
    signal from_memory : std_logic_vector(7 downto 0);
    signal to_memory, address, IR : std_logic_vector(7 downto 0);
    signal CCR : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    -- For simulation output
    file output_file : text open write_mode is "datapath_test_log.txt";

begin

    -- Instantiate the DUT
    DUT: data_path port map (
        clk         => clk,
        reset       => reset,
        Bus1_Sel    => Bus1_Sel,
        Bus2_Sel    => Bus2_Sel,
        A_Load      => A_Load,
        B_Load      => B_Load,
        PC_Load     => PC_Load,
        PC_Inc      => PC_Inc,
        IR_Load     => IR_Load,
        MAR_Load    => MAR_Load,
        CCR_Load    => CCR_Load,
        ALU_Sel     => ALU_Sel,
        from_memory => from_memory,
        to_memory   => to_memory,
        address     => address,
        IR          => IR,
        CCR         => CCR
    );

    -- Clock generation
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Test stimulus
    stim_proc : process
        variable L : line;
    begin
        -- Reset system
        reset <= '0';
        wait for 2 * CLK_PERIOD;
        reset <= '1';

        ---------------------------------------------------------
        -- TEST 1: Load A with constant value from memory
        ---------------------------------------------------------
        from_memory <= x"55";       -- Value to load
        Bus1_Sel <= "00";           -- Select PC for MAR
        Bus2_Sel <= "01";           -- Bus2 = Bus1 (PC)
        MAR_Load <= '1';            -- Load MAR
        wait for CLK_PERIOD;
        MAR_Load <= '0';

        Bus2_Sel <= "10";           -- Bus2 = from_memory
        A_Load <= '1';              -- Load A
        wait for CLK_PERIOD;
        A_Load <= '0';

        write(L, string'("Test 1 - Load A with x55: "));
        write(L, string'("to_memory = ")); write(L, to_memory);
        writeline(output_file, L);

        ---------------------------------------------------------
        -- TEST 2: Load B with x0A, Add A + B using ALU
        ---------------------------------------------------------
        from_memory <= x"0A";
        B_Load <= '1';
        wait for CLK_PERIOD;
        B_Load <= '0';

        -- ALU ADD: ALU_Sel = "000"
        ALU_Sel <= "000";
        Bus1_Sel <= "01";          -- A
        Bus2_Sel <= "10";          -- from_memory ignored here
        A_Load <= '1';             -- Load result back into A
        CCR_Load <= '1';           -- Load flags
        wait for CLK_PERIOD;
        A_Load <= '0';
        CCR_Load <= '0';

        write(L, string'("Test 2 - A + B: "));
        write(L, string'("ALU Result to A, CCR = "));
        write(L, CCR);
        writeline(output_file, L);

        ---------------------------------------------------------
        -- TEST 3: Increment PC
        ---------------------------------------------------------
        PC_Inc <= '1';
        wait for CLK_PERIOD;
        PC_Inc <= '0';

        write(L, string'("Test 3 - PC incremented, address = "));
        write(L, address);
        writeline(output_file, L);

        wait;
    end process;
    
end Behavioral;
