----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 12:00:06 PM
-- Design Name: 
-- Module Name: rw_96x8_sync_tb - Behavioral
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

entity rw_96x8_sync_tb is
end rw_96x8_sync_tb;

architecture Behavioral of rw_96x8_sync_tb is

    -- Component Under Test
    component rw_96x8_sync
        port (
            clock    : in  std_logic;
            write    : in  std_logic;
            address  : in  std_logic_vector(7 downto 0);
            data_in  : in  std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Testbench signals
    signal clock_tb    : std_logic := '0';
    signal write_tb    : std_logic := '0';
    signal address_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal data_in_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out_tb : std_logic_vector(7 downto 0);
    
    constant CLK_PERIOD : time := 20 ns;

begin
    
    -- Instantiate DUT
    UUT: rw_96x8_sync
        port map (
                clock    => clock_tb,
                write    => write_tb,
                address  => address_tb,
                data_in  => data_in_tb,
                data_out => data_out_tb
                );
                    
    -- Clock process
    clock_proc : process
    begin
        while now < 10000 ns loop
            clock_tb <= '0';
            wait for CLK_PERIOD / 2;
            clock_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    
    
    -- Stimulus process
    stim_proc : process
        variable L    : line;
        variable data : integer := 0;
    begin
        wait for CLK_PERIOD;


        write_tb <= '1';

        for add_w in 128 to 223 loop
            address_tb <= std_logic_vector(to_unsigned(add_w, 8));
            data_in_tb <= std_logic_vector(to_unsigned(data, 8));
            data := data + 1;
            wait for CLK_PERIOD;

            write(L, string'("Write in address "));
            write(L, add_w);
            write(L, string'(" = "));
            write(L, data_in_tb);
            writeline(output, L);
        end loop;


        -- Read from all three addresses
        write_tb <= '0';

        for add_r in 128 to 223 loop
            address_tb <= std_logic_vector(to_unsigned(add_r, 8));
            wait for CLK_PERIOD;

            write(L, string'("Read from address "));
            write(L, add_r);
            write(L, string'(" = "));
            write(L, data_out_tb);
            writeline(output, L);
        end loop;

        wait;
    end process;
    
    
    
    
end Behavioral;

























