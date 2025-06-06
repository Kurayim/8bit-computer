----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2025 12:12:29 AM
-- Design Name: 
-- Module Name: computer - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity computer is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        
        -- Input ports (e.g. switches, sensors)
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

        -- Output ports (e.g. LEDs, displays)
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
end computer;

architecture Behavioral of computer is
    
        -- Internal signals to connect CPU and Memory
    signal to_memory   : std_logic_vector(7 downto 0);
    signal from_memory : std_logic_vector(7 downto 0);
    signal address     : std_logic_vector(7 downto 0);
    signal write       : std_logic;

    component cpu
        Port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            from_memory : in  std_logic_vector(7 downto 0);
            to_memory   : out std_logic_vector(7 downto 0);
            address     : out std_logic_vector(7 downto 0);
            write       : out std_logic
        );
    end component;

    component memory
        Port (
            clock       : in  std_logic;
            reset       : in  std_logic;
            address     : in  std_logic_vector(7 downto 0);
            write       : in  std_logic;
            data_in     : in  std_logic_vector(7 downto 0);
            data_out    : out std_logic_vector(7 downto 0);

            -- Input ports
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

            -- Output ports
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

    -- Instantiate the CPU core
    u_cpu : cpu
        port map (
            clk         => clk,
            reset       => reset,
            from_memory => from_memory,
            to_memory   => to_memory,
            address     => address,
            write       => write
        );

    -- Instantiate the memory system (ROM, RAM, I/O)
    u_mem : memory
        port map (
            clock       => clk,
            reset       => reset,
            address     => address,
            write       => write,
            data_in     => to_memory,
            data_out    => from_memory,
            port_in_00  => port_in_00,
            port_in_01  => port_in_01,
            port_in_02  => port_in_02,
            port_in_03  => port_in_03,
            port_in_04  => port_in_04,
            port_in_05  => port_in_05,
            port_in_06  => port_in_06,
            port_in_07  => port_in_07,
            port_in_08  => port_in_08,
            port_in_09  => port_in_09,
            port_in_10  => port_in_10,
            port_in_11  => port_in_11,
            port_in_12  => port_in_12,
            port_in_13  => port_in_13,
            port_in_14  => port_in_14,
            port_in_15  => port_in_15,
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
    
end Behavioral;
