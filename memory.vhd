----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2025 12:34:27 PM
-- Design Name: 
-- Module Name: memory - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
     
entity memory is
    port(
        clock       : in  std_logic;
        reset       : in  std_logic;
        address     : in  std_logic_vector(7 downto 0);
        write       : in  std_logic;
        data_in     : in  std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0);
        -- Input ports (e.g. switches, sensors, etc.)
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
end memory;
  
architecture Behavioral of memory is

    -- Internal signals for memory outputs
    signal rom_data_out : std_logic_vector(7 downto 0);
    signal ram_data_out : std_logic_vector(7 downto 0);

    -- Component Declarations
    component rom_128x8_sync
        port(
            clock    : in  std_logic;
            address  : in  std_logic_vector(6 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    component rw_96x8_sync
        port(
            clock     : in  std_logic;
            write     : in  std_logic;
            address   : in  std_logic_vector(7 downto 0);
            data_in   : in  std_logic_vector(7 downto 0);
            data_out  : out std_logic_vector(7 downto 0)
        );
    end component;

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

begin

    -- Program Memory (ROM)
    u_rom : rom_128x8_sync
        port map (
            clock    => clock,
            address  => address(6 downto 0),
            data_out => rom_data_out
        );

    -- Data Memory (RAM)
    u_ram : rw_96x8_sync
        port map (
            clock     => clock,
            write     => write,
            address   => address,
            data_in   => data_in,
            data_out  => ram_data_out
        );

    -- Output Ports (e.g., LEDs)
    u_out : output_ports_16
        port map (
            clock        => clock,
            reset        => reset,
            write        => write,
            address      => address,
            data_in      => data_in,
            port_out_00  => port_out_00,
            port_out_01  => port_out_01,
            port_out_02  => port_out_02,
            port_out_03  => port_out_03,
            port_out_04  => port_out_04,
            port_out_05  => port_out_05,
            port_out_06  => port_out_06,
            port_out_07  => port_out_07,
            port_out_08  => port_out_08,
            port_out_09  => port_out_09,
            port_out_10  => port_out_10,
            port_out_11  => port_out_11,
            port_out_12  => port_out_12,
            port_out_13  => port_out_13,
            port_out_14  => port_out_14,
            port_out_15  => port_out_15
        );

    -- Multiplexer for data_out bus
    mux_process : process(address, rom_data_out, ram_data_out,
        port_in_00, port_in_01, port_in_02, port_in_03,
        port_in_04, port_in_05, port_in_06, port_in_07,
        port_in_08, port_in_09, port_in_10, port_in_11,
        port_in_12, port_in_13, port_in_14, port_in_15)
    begin
        if to_integer(unsigned(address)) >= 0 and to_integer(unsigned(address)) <= 127 then
            data_out <= rom_data_out;
        elsif to_integer(unsigned(address)) >= 128 and to_integer(unsigned(address)) <= 223 then
            data_out <= ram_data_out;
        elsif address = x"F0" then data_out <= port_in_00;
        elsif address = x"F1" then data_out <= port_in_01;
        elsif address = x"F2" then data_out <= port_in_02;
        elsif address = x"F3" then data_out <= port_in_03;
        elsif address = x"F4" then data_out <= port_in_04;
        elsif address = x"F5" then data_out <= port_in_05;
        elsif address = x"F6" then data_out <= port_in_06;
        elsif address = x"F7" then data_out <= port_in_07;
        elsif address = x"F8" then data_out <= port_in_08;
        elsif address = x"F9" then data_out <= port_in_09;
        elsif address = x"FA" then data_out <= port_in_10;
        elsif address = x"FB" then data_out <= port_in_11;
        elsif address = x"FC" then data_out <= port_in_12;
        elsif address = x"FD" then data_out <= port_in_13;
        elsif address = x"FE" then data_out <= port_in_14;
        elsif address = x"FF" then data_out <= port_in_15;
        else
            data_out <= (others => '0');
        end if;
    end process;

end Behavioral;

