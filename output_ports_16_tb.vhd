----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 01:07:13 PM
-- Design Name: 
-- Module Name: output_ports_16_tb - Behavioral
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

entity output_ports_16_tb is
end output_ports_16_tb;

architecture Behavioral of output_ports_16_tb is
    
    component output_ports_16
        port(
            clock        : in  std_logic;
            reset        : in  std_logic;
            write        : in  std_logic;
            address      : in  std_logic_vector(7 downto 0);
            data_in      : in  std_logic_vector(7 downto 0);
            port_out_00  : out std_logic_vector(7 downto 0);
            port_out_01  : out std_logic_vector(7 downto 0);
            port_out_02  : out std_logic_vector(7 downto 0);
            port_out_03  : out std_logic_vector(7 downto 0);
            port_out_04  : out std_logic_vector(7 downto 0);
            port_out_05  : out std_logic_vector(7 downto 0);
            port_out_06  : out std_logic_vector(7 downto 0);
            port_out_07  : out std_logic_vector(7 downto 0);
            port_out_08  : out std_logic_vector(7 downto 0);
            port_out_09  : out std_logic_vector(7 downto 0);
            port_out_10  : out std_logic_vector(7 downto 0);
            port_out_11  : out std_logic_vector(7 downto 0);
            port_out_12  : out std_logic_vector(7 downto 0);
            port_out_13  : out std_logic_vector(7 downto 0);
            port_out_14  : out std_logic_vector(7 downto 0);
            port_out_15  : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal clk_tb     : std_logic := '0';
    signal rst_tb     : std_logic := '0';
    signal wr_tb      : std_logic := '0';
    signal addr_tb    : std_logic_vector(7 downto 0) := (others => '0');
    signal data_tb    : std_logic_vector(7 downto 0) := (others => '0');
    signal ports      : std_logic_vector(7 downto 0);

    signal port_0  : std_logic_vector(7 downto 0);
    signal port_1  : std_logic_vector(7 downto 0);
    signal port_2  : std_logic_vector(7 downto 0);
    signal port_3  : std_logic_vector(7 downto 0);
    signal port_4  : std_logic_vector(7 downto 0);
    signal port_5  : std_logic_vector(7 downto 0);
    signal port_6  : std_logic_vector(7 downto 0);
    signal port_7  : std_logic_vector(7 downto 0);
    signal port_8  : std_logic_vector(7 downto 0);
    signal port_9  : std_logic_vector(7 downto 0);
    signal port_10 : std_logic_vector(7 downto 0);
    signal port_11 : std_logic_vector(7 downto 0);
    signal port_12 : std_logic_vector(7 downto 0);
    signal port_13 : std_logic_vector(7 downto 0);
    signal port_14 : std_logic_vector(7 downto 0);
    signal port_15 : std_logic_vector(7 downto 0);
    -- Clock constant
    constant CLK_PERIOD : time := 20 ns;
    
begin
        -- Instantiate DUT
    uut: output_ports_16
        port map (
            clock        => clk_tb,
            reset        => rst_tb,
            write        => wr_tb,
            address      => addr_tb,
            data_in      => data_tb,
            port_out_00  => port_0,
            port_out_01  => port_1,
            port_out_02  => port_2,
            port_out_03  => port_3,
            port_out_04  => port_4,
            port_out_05  => port_5,
            port_out_06  => port_6,
            port_out_07  => port_7,
            port_out_08  => port_8,
            port_out_09  => port_9,
            port_out_10  => port_10,
            port_out_11  => port_11,
            port_out_12  => port_12,
            port_out_13  => port_13,
            port_out_14  => port_14,
            port_out_15  => port_15
        );
    -- Clock generation
    clk_gen : process
    begin
        while now < 600 ns loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    
    
    
        -- Stimulus process
    stim_proc : process
        variable i : integer;
    begin
        -- Apply reset
        rst_tb <= '0';
        wait for 20 ns;
        rst_tb <= '1';
        wait for CLK_PERIOD;

        -- Write unique data to each port (x"E0" to x"EF")
        wr_tb <= '1';
        for i in 0 to 16 loop
            addr_tb <= std_logic_vector(to_unsigned(16#E0# + i, 8));
            data_tb <= std_logic_vector(to_unsigned(i * 10, 8));  -- Arbitrary test data
            wait for CLK_PERIOD;
        end loop;
        
        wait for CLK_PERIOD;


        
        wr_tb <= '0';

        -- Wait and observe output
        wait for 100 ns;
        wait;
    end process;
        
        

end Behavioral;




























