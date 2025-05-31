----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 11:42:27 AM
-- Design Name: 
-- Module Name: rw_96x8_sync - Behavioral
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

-- Entity declaration for synchronous 96x8-bit read/write memory
entity rw_96x8_sync is
  port(
        clock    : in  std_logic;
        write    : in  std_logic;
        address  : in  std_logic_vector(7 downto 0);
        data_in  : in  std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
        );
end rw_96x8_sync;

-- Architecture block containing internal logic
architecture Behavioral of rw_96x8_sync is
  -- Define the memory array type: 96 entries of 8-bit vectors from address 128 to 223
  type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
  -- Signal instance of the memory
  signal RW : rw_type := (others => X"00");    
  -- Enable signal used to validate memory access (based on address)
  signal EN : std_logic;
  
begin


    -- Enable process: generates 'EN' = '1' only for addresses 128 to 223
    enable : process(address)
    begin
      if(  to_integer(unsigned(address))  >= 128     and     to_integer(unsigned(address))  <= 223 )then
        EN <= '1';    -- Valid address range
      else
        EN <= '0';    -- Invalid address, ignore access
      end if;
    end process;

    -- Memory read/write process triggered on rising edge of the clock
    memory : process(clock)
    begin
      if(rising_edge(clock))then
        if(write = '1' and EN = '1')then
            RW(to_integer(unsigned(address))) <= data_in;     -- Write operation: store data_in at the specified address
        elsif(write = '0' and EN = '1')then
            data_out <= RW(to_integer(unsigned(address)));    -- Read operation: output data from the specified address
        end if;
      end if;  
    end process;


end Behavioral;














