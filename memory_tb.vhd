----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2025 10:16:31 AM
-- Design Name: 
-- Module Name: memory_tb - Behavioral
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


-- Testbench for the "memory" entity
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

entity memory_tb is
end memory_tb;


architecture Behavioral of memory_tb is

    constant CLK_PERIOD : time := 10 ns;

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal addr       : std_logic_vector(7 downto 0) := (others => '0');
    signal write_sig  : std_logic := '0';
    signal data_in    : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out   : std_logic_vector(7 downto 0);

    signal port_in    : std_logic_vector(7 downto 0) := X"55";

    signal port_out_00, port_out_01, port_out_02, port_out_03 : std_logic_vector(7 downto 0);
    signal port_out_04, port_out_05, port_out_06, port_out_07 : std_logic_vector(7 downto 0);
    signal port_out_08, port_out_09, port_out_10, port_out_11 : std_logic_vector(7 downto 0);
    signal port_out_12, port_out_13, port_out_14, port_out_15 : std_logic_vector(7 downto 0);

    component memory
        port(
            clock       : in  std_logic;
            reset       : in  std_logic;
            address     : in  std_logic_vector(7 downto 0);
            write       : in  std_logic;
            data_in     : in  std_logic_vector(7 downto 0);
            data_out    : out std_logic_vector(7 downto 0);

            port_in_00  : in  std_logic_vector(7 downto 0);
            port_in_01  : in  std_logic_vector(7 downto 0);
            port_in_02  : in  std_logic_vector(7 downto 0);
            port_in_03  : in  std_logic_vector(7 downto 0);
            port_in_04  : in  std_logic_vector(7 downto 0);
            port_in_05  : in  std_logic_vector(7 downto 0);
            port_in_06  : in  std_logic_vector(7 downto 0);
            port_in_07  : in  std_logic_vector(7 downto 0);
            port_in_08  : in  std_logic_vector(7 downto 0);
            port_in_09  : in  std_logic_vector(7 downto 0);
            port_in_10  : in  std_logic_vector(7 downto 0);
            port_in_11  : in  std_logic_vector(7 downto 0);
            port_in_12  : in  std_logic_vector(7 downto 0);
            port_in_13  : in  std_logic_vector(7 downto 0);
            port_in_14  : in  std_logic_vector(7 downto 0);
            port_in_15  : in  std_logic_vector(7 downto 0);

            port_out_00 : out std_logic_vector(7 downto 0);
            port_out_01 : out std_logic_vector(7 downto 0);
            port_out_02 : out std_logic_vector(7 downto 0);
            port_out_03 : out std_logic_vector(7 downto 0);
            port_out_04 : out std_logic_vector(7 downto 0);
            port_out_05 : out std_logic_vector(7 downto 0);
            port_out_06 : out std_logic_vector(7 downto 0);
            port_out_07 : out std_logic_vector(7 downto 0);
            port_out_08 : out std_logic_vector(7 downto 0);
            port_out_09 : out std_logic_vector(7 downto 0);
            port_out_10 : out std_logic_vector(7 downto 0);
            port_out_11 : out std_logic_vector(7 downto 0);
            port_out_12 : out std_logic_vector(7 downto 0);
            port_out_13 : out std_logic_vector(7 downto 0);
            port_out_14 : out std_logic_vector(7 downto 0);
            port_out_15 : out std_logic_vector(7 downto 0)
        );
    end component;
    
begin

    DUT: memory
        port map (
            clock       => clk,
            reset       => rst,
            address     => addr,
            write       => write_sig,
            data_in     => data_in,
            data_out    => data_out,

            port_in_00  => port_in,
            port_in_01  => port_in,
            port_in_02  => port_in,
            port_in_03  => port_in,
            port_in_04  => port_in,
            port_in_05  => port_in,
            port_in_06  => port_in,
            port_in_07  => port_in,
            port_in_08  => port_in,
            port_in_09  => port_in,
            port_in_10  => port_in,
            port_in_11  => port_in,
            port_in_12  => port_in,
            port_in_13  => port_in,
            port_in_14  => port_in,
            port_in_15  => port_in,

            port_out_00 => port_out_00,
            port_out_01 => port_out_01,
            port_out_02 => port_out_02,
            port_out_03 => port_out_03,
            port_out_04 => port_out_04,
            port_out_05 => port_out_05,
            port_out_06 => port_out_06,
            port_out_07 => port_out_07,
            port_out_08 => port_out_08,
            port_out_09 => port_out_09,
            port_out_10 => port_out_10,
            port_out_11 => port_out_11,
            port_out_12 => port_out_12,
            port_out_13 => port_out_13,
            port_out_14 => port_out_14,
            port_out_15 => port_out_15
        );

    clk_process : process
    begin
        while now < 3000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc : process
        variable vline : line;
    begin
        rst <= '0';
        wait for 2 * CLK_PERIOD;
        rst <= '1';

        -- Write to all addresses 0 to 239
        for i in 127 to 239 loop
            addr <= std_logic_vector(to_unsigned(i, 8));
            data_in <= std_logic_vector(to_unsigned(i + 1, 8));
            write_sig <= '1';
            wait for CLK_PERIOD;
        end loop;
        write_sig <= '0';

        wait for CLK_PERIOD;

        -- Read back from all addresses 0 to 239
        for i in 0 to 239 loop
            addr <= std_logic_vector(to_unsigned(i, 8));
            wait for CLK_PERIOD;
            write(vline, string'("Address: "));
            write(vline, i);
            write(vline, string'(" => Data: "));
            write(vline, data_out);
            writeline(output, vline);
        end loop;

        wait;
    end process;

end Behavioral;
