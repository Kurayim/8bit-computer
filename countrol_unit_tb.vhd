----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2025 10:34:43 PM
-- Design Name: 
-- Module Name: countrol_unit_tb - Behavioral
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

-- Entity declaration for the testbench (no ports)
entity countrol_unit_tb is
end countrol_unit_tb;

architecture Behavioral of countrol_unit_tb is

        -- Declaration of the Unit Under Test (UUT)
    component control_unit
        Port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            IR         : in  std_logic_vector(7 downto 0);
            CCR_Result : in  std_logic_vector(3 downto 0);
            IR_Load    : out std_logic;
            MAR_Load   : out std_logic;
            PC_Load    : out std_logic;
            PC_Inc     : out std_logic;
            A_Load     : out std_logic;
            B_Load     : out std_logic;
            CCR_Load   : out std_logic;
            ALU_Sel    : out std_logic_vector(2 downto 0);
            Bus1_Sel   : out std_logic_vector(1 downto 0);
            Bus2_Sel   : out std_logic_vector(1 downto 0);
            write      : out std_logic
        );
    end component;

    -- Signal declarations for testbench
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal IR         : std_logic_vector(7 downto 0) := (others => '0');
    signal CCR_Result : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs from the control unit
    signal IR_Load, MAR_Load, PC_Load, PC_Inc : std_logic;
    signal A_Load, B_Load, CCR_Load, write    : std_logic;
    signal ALU_Sel : std_logic_vector(2 downto 0);
    signal Bus1_Sel, Bus2_Sel : std_logic_vector(1 downto 0);

    -- Clock period constant
    constant CLK_PERIOD : time := 10 ns;

    -- Instruction opcodes
    constant LDA_IMM : std_logic_vector(7 downto 0) := X"86";
    constant LDB_IMM : std_logic_vector(7 downto 0) := X"88";
    constant STA_DIR : std_logic_vector(7 downto 0) := X"96";
    constant STB_DIR : std_logic_vector(7 downto 0) := X"97";
    constant ADD_AB  : std_logic_vector(7 downto 0) := X"42";
    constant BRA     : std_logic_vector(7 downto 0) := X"20";
    constant BEQ     : std_logic_vector(7 downto 0) := X"23";

begin

        -- Instantiate the control unit
    DUT: control_unit
        port map (
            clk        => clk,
            reset      => reset,
            IR         => IR,
            CCR_Result => CCR_Result,
            IR_Load    => IR_Load,
            MAR_Load   => MAR_Load,
            PC_Load    => PC_Load,
            PC_Inc     => PC_Inc,
            A_Load     => A_Load,
            B_Load     => B_Load,
            CCR_Load   => CCR_Load,
            ALU_Sel    => ALU_Sel,
            Bus1_Sel   => Bus1_Sel,
            Bus2_Sel   => Bus2_Sel,
            write      => write
        );

    -- Clock generation process: 10ns period
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

    -- Stimulus process: apply test instructions
    stim_proc : process
        variable L : line;  -- Used for optional print/log
    begin
        -- Apply reset
        reset <= '0';
        wait for CLK_PERIOD;
        reset <= '1';

        wait for CLK_PERIOD;

        -- Test LDA_IMM Instruction
        IR <= LDA_IMM;
        wait for 4 * CLK_PERIOD;

        -- Test LDB_IMM Instruction
        IR <= LDB_IMM;
        wait for 4 * CLK_PERIOD;

        -- Test STA_DIR Instruction
        IR <= STA_DIR;
        wait for 4 * CLK_PERIOD;

        -- Test STB_DIR Instruction
        IR <= STB_DIR;
        wait for 4 * CLK_PERIOD;

        -- Test ADD_AB Instruction
        IR <= ADD_AB;
        wait for 2 * CLK_PERIOD;

        -- Test BRA Instruction
        IR <= BRA;
        wait for 3 * CLK_PERIOD;

        -- Test BEQ Instruction with Zero Flag set
        IR <= BEQ;
        CCR_Result <= "0100"; -- Z=1
        wait for 3 * CLK_PERIOD;

        -- Test BEQ Instruction with Zero Flag clear
        IR <= BEQ;
        CCR_Result <= "0000"; -- Z=0
        wait for 3 * CLK_PERIOD;

        wait;
    end process;

end Behavioral;
