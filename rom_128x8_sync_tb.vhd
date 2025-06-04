----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2025 03:41:56 AM
-- Design Name: 
-- Module Name: rom_128x8_sync_tb - Behavioral
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

entity rom_128x8_sync_tb is
--  Port ( );
end rom_128x8_sync_tb;

architecture Behavioral of rom_128x8_sync_tb is

    -- DUT component declaration
    component rom_128x8_sync is
        Port (
            clock    : in  std_logic;                          -- Clock input
            address  : in  std_logic_vector(6 downto 0);       -- 7-bit address input (0 to 127)
            data_out : out std_logic_vector(7 downto 0)      -- 8-bit data output
        );
    end component;
     
    -- Testbench signals
    signal clock_tb    : std_logic := '0';
    signal address_tb  : std_logic_vector(6 downto 0) := (others => '0');
    signal data_out_tb : std_logic_vector(7 downto 0);

    -- Clock period constant
    constant CLK_PERIOD : time := 20 ns;
    
    -- Output file declaration
    file output_file : text open write_mode is "rom_output.txt";
    
begin
    
    -- Instantioate the DUT
    UUT: rom_128x8_sync
        port map(
            clock    => clock_tb,
            address  => address_tb,
            data_out => data_out_tb
        );
        
     -- Clock generation process
     clk_proc : process
     begin
        while now < 200 ns loop
            clock_tb <= '0';
            wait for CLK_PERIOD / 2;
            clock_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
     end process;
     
     -- Simulus process
     sim_proc : process
        variable v_line : line;
     begin
        wait for 10 ns;
        
        for counter in 0 to 127 loop
            address_tb <= std_logic_vector(to_unsigned(counter, 7));
            wait for CLK_PERIOD;
            -- Print current address and data_out to console
            write(v_line, string'("Address: "));
            write(v_line, counter);
            write(v_line, string'("  =>  Date: "));
            write(v_line, data_out_tb);            
            
            -- In console
            --writeline(output, v_line);
            -- In text file
            writeline(output_file, v_line);
                   
        end loop;
        wait;
     end process;
    
    
    
end Behavioral;

































