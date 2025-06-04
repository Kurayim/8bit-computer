----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2025 12:25:52 AM
-- Design Name: 
-- Module Name: computer_tb - Behavioral
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

entity computer_tb is
--  Port ( );
end computer_tb;

architecture Behavioral of computer_tb is

    -- Define a type for an array of 16 bytes (8-bit std_logic_vector)
    type byte_array is array (15 downto 0) of std_logic_vector(7 downto 0);

    -- Clock signal
    signal clk       : std_logic := '0';
    -- Reset signal (active high)
    signal reset     : std_logic := '1';
    -- Input ports array
    signal port_in   : byte_array := (others => (others => '0'));
    -- Output ports array
    signal port_out  : byte_array;

begin

    -- Clock generation process: 50 MHz clock (20 ns period)
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Instantiate the Device Under Test (DUT)
    UUT: entity work.computer
        port map (
            clk        => clk,
            reset      => reset,
            port_in_00 => port_in(0),
            port_in_01 => port_in(1),
            port_in_02 => port_in(2),
            port_in_03 => port_in(3),
            port_in_04 => port_in(4),
            port_in_05 => port_in(5),
            port_in_06 => port_in(6),
            port_in_07 => port_in(7),
            port_in_08 => port_in(8),
            port_in_09 => port_in(9),
            port_in_10 => port_in(10),
            port_in_11 => port_in(11),
            port_in_12 => port_in(12),
            port_in_13 => port_in(13),
            port_in_14 => port_in(14),
            port_in_15 => port_in(15),

            port_out_00 => port_out(0),
            port_out_01 => port_out(1),
            port_out_02 => port_out(2),
            port_out_03 => port_out(3),
            port_out_04 => port_out(4),
            port_out_05 => port_out(5),
            port_out_06 => port_out(6),
            port_out_07 => port_out(7),
            port_out_08 => port_out(8),
            port_out_09 => port_out(9),
            port_out_10 => port_out(10),
            port_out_11 => port_out(11),
            port_out_12 => port_out(12),
            port_out_13 => port_out(13),
            port_out_14 => port_out(14),
            port_out_15 => port_out(15)
        );

    -- Stimulus process: drives input signals and controls reset
    stim_proc: process
    begin
        -- Hold reset high initially
        reset <= '1';
        wait for 25 ns;

        -- Release reset (set to 0)
        reset <= '0';

        -- Apply test inputs: each port_in gets its index value as unsigned number
        for i in 0 to 15 loop
            port_in(i) <= std_logic_vector(to_unsigned(i, 8));
        end loop;

        -- Wait for 200 ns for DUT to process inputs and produce outputs
        wait for 200 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
