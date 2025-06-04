----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2025 01:42:47 AM
-- Design Name: 
-- Module Name: rom_128x8_sync - Behavioral
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

entity rom_128x8_sync is
    Port (
        clock    : in  std_logic;                          -- Clock input
        address  : in  std_logic_vector(6 downto 0);       -- 7-bit address input (0 to 127)
        data_out : out std_logic_vector(7 downto 0)      -- 8-bit data output
    );
 end rom_128x8_sync;


architecture Behavioral of rom_128x8_sync is

    constant LDA_IMM : std_logic_vector(7 downto 0) := X"86";
    constant LDA_DIR : std_logic_vector(7 downto 0) := X"87";
    constant LDB_IMM : std_logic_vector(7 downto 0) := X"88";
    constant LDB_DIR : std_logic_vector(7 downto 0) := X"89";
    constant STA_DIR : std_logic_vector(7 downto 0) := X"86";
    constant STB_DIR : std_logic_vector(7 downto 0) := X"86";
    constant ADD_AB  : std_logic_vector(7 downto 0) := X"86";
    constant BRA     : std_logic_vector(7 downto 0) := X"86";
    constant BRQ     : std_logic_vector(7 downto 0) := X"86";
    
    -- ROM array declaration: 128 x 8-bit
    type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);
    
    
    -- Example ROM content
    constant ROM : rom_type := (0       => LDA_IMM,
                                1       => X"AA",
                                2       => STA_DIR,
                                3       => X"E0",
                                4       => X"00",
                                5       => X"00",
                                others  => X"00");
    signal EN : std_logic;
    
    
    
    begin
    
         -- Enable process: validate address range
        enable : process(address)
        begin
            if((to_integer(unsigned(address)) >= 0 )  and  (to_integer(unsigned(address)) <= 127)) then
                EN <= '1';
            else
                EN <= '0';
            end if;
        end process;
        
        
        
        -- ROM read process: synchronous read
        memory : process(clock)
            begin
            if(rising_edge(clock))then
                if(EN = '1')then
                   -- data_out <= ROM(to_integer(unsigned(address)));
                   data_out <= ROM(to_integer(unsigned(address)));
                end if;
             end if;
        end process;
    
    
end Behavioral;



























