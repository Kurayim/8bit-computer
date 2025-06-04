----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2025 10:31:42 PM
-- Design Name: 
-- Module Name: countrol_unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        IR         : in  std_logic_vector(7 downto 0);
        CCR_Result : in  std_logic_vector(3 downto 0);

        -- Control signals to data path
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
end control_unit;

architecture Behavioral of control_unit is

    -- Define constants for opcodes
    constant LDA_IMM : std_logic_vector(7 downto 0) := X"86"; -- Load A Immediate
    constant LDA_DIR : std_logic_vector(7 downto 0) := X"87"; -- Load A Direct
    constant LDB_IMM : std_logic_vector(7 downto 0) := X"88"; -- Load B Immediate
    constant LDB_DIR : std_logic_vector(7 downto 0) := X"89"; -- Load B Direct
    constant STA_DIR : std_logic_vector(7 downto 0) := X"96"; -- Store A to memory
    constant STB_DIR : std_logic_vector(7 downto 0) := X"97"; -- Store B to memory
    constant ADD_AB  : std_logic_vector(7 downto 0) := X"42"; -- Add A and B
    constant BRA     : std_logic_vector(7 downto 0) := X"20"; -- Branch Always
    constant BEQ     : std_logic_vector(7 downto 0) := X"23"; -- Branch if Equal

    -- Define state type for FSM
    type state_type is (
        S_FETCH_0, S_FETCH_1, S_FETCH_2, S_DECODE_3,
        S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6,
        S_LDB_IMM_4, S_LDB_IMM_5,
        S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6,
        S_STB_DIR_4, S_STB_DIR_5, S_STB_DIR_6,
        S_ADD_AB_4,
        S_BRA_4, S_BRA_5,
        S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7
    );

    signal current_state, next_state : state_type;

begin

    -- STATE MEMORY: update current state on clock
    process(clk, reset)
    begin
        if reset = '0' then
            current_state <= S_FETCH_0; -- On reset, start fetch cycle
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- NEXT STATE LOGIC: determine transitions
    process(current_state, IR, CCR_Result)
    begin
        case current_state is
            when S_FETCH_0 => next_state <= S_FETCH_1; -- Fetch: MAR <= PC
            when S_FETCH_1 => next_state <= S_FETCH_2; -- Increment PC
            when S_FETCH_2 => next_state <= S_DECODE_3; -- Load IR from memory
            when S_DECODE_3 =>
                if IR = LDA_IMM then
                    next_state <= S_LDA_IMM_4;
                elsif IR = LDB_IMM then
                    next_state <= S_LDB_IMM_4;
                elsif IR = STA_DIR then
                    next_state <= S_STA_DIR_4;
                elsif IR = STB_DIR then
                    next_state <= S_STB_DIR_4;
                elsif IR = ADD_AB then
                    next_state <= S_ADD_AB_4;
                elsif IR = BRA then
                    next_state <= S_BRA_4;
                elsif IR = BEQ and CCR_Result(2) = '1' then
                    next_state <= S_BEQ_4; -- Branch if Z flag is set
                elsif IR = BEQ and CCR_Result(2) = '0' then
                    next_state <= S_BEQ_7; -- Skip branch
                else
                    next_state <= S_FETCH_0; -- Unknown instruction
                end if;
            when others => next_state <= S_FETCH_0;
        end case;
    end process;

    -- OUTPUT LOGIC: generate control signals based on state
    process(current_state)
    begin
        -- Default values for all control signals
        IR_Load <= '0'; MAR_Load <= '0'; PC_Load <= '0'; PC_Inc <= '0';
        A_Load <= '0'; B_Load <= '0'; CCR_Load <= '0';
        ALU_Sel <= "000"; Bus1_Sel <= "00"; Bus2_Sel <= "00";
        write <= '0';

        case current_state is
            when S_FETCH_0 => -- PC -> MAR
                MAR_Load <= '1';
                Bus1_Sel <= "00"; -- Select PC to Bus1
                Bus2_Sel <= "01"; -- Select Bus1 to Bus2
            when S_FETCH_1 => -- PC++
                PC_Inc <= '1';
            when S_FETCH_2 => -- Load IR
                IR_Load <= '1';
                Bus2_Sel <= "10"; -- from_memory -> Bus2

            when S_LDA_IMM_4 => PC_Inc <= '1';
            when S_LDA_IMM_5 => A_Load <= '1'; Bus2_Sel <= "10";

            when S_LDB_IMM_4 => PC_Inc <= '1';
            when S_LDB_IMM_5 => B_Load <= '1'; Bus2_Sel <= "10";

            when S_STA_DIR_4 => PC_Inc <= '1';
            when S_STA_DIR_5 => MAR_Load <= '1'; Bus2_Sel <= "10";
            when S_STA_DIR_6 => write <= '1'; Bus1_Sel <= "01"; -- A to Bus1

            when S_STB_DIR_4 => PC_Inc <= '1';
            when S_STB_DIR_5 => MAR_Load <= '1'; Bus2_Sel <= "10";
            when S_STB_DIR_6 => write <= '1'; Bus1_Sel <= "10"; -- B to Bus1

            when S_ADD_AB_4 => ALU_Sel <= "000"; A_Load <= '1'; CCR_Load <= '1';

            when S_BRA_4 => PC_Load <= '1'; Bus2_Sel <= "10";
            when S_BEQ_4 => PC_Load <= '1'; Bus2_Sel <= "10";
            when others => null;
        end case;
    end process;

end Behavioral;
