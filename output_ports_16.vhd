----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 12:39:50 PM
-- Design Name: 
-- Module Name: output_ports_16 - Behavioral
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


Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity output_ports_16 is
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
end output_ports_16;

architecture Behavioral of output_ports_16 is


    
begin

    P0 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_00 <= data_in;
          end if;
        end if;
    end process;
    
    
    
P1 : process(clock, reset)
     begin
        if(reset = '0')then
          port_out_01 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E1")then
            port_out_01 <= data_in;
          end if;
        end if;
    end process;


    P2 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_02 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E2")then
            port_out_02 <= data_in;
          end if;
        end if;
    end process;

    P3 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_03 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E3")then
            port_out_03 <= data_in;
          end if;
        end if;
    end process;

    P4 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_04 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E4")then
            port_out_04 <= data_in;
          end if;
        end if;
    end process;

    P5 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_05 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E5")then
            port_out_05 <= data_in;
          end if;
        end if;
    end process;

    P6 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_06 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E6")then
            port_out_06 <= data_in;
          end if;
        end if;
    end process;

    P7 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_07 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E7")then
            port_out_07 <= data_in;
          end if;
        end if;
    end process;

    P8 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_08 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E8")then
            port_out_08 <= data_in;
          end if;
        end if;
    end process;

    P9 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_09 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"E9")then
            port_out_09 <= data_in;
          end if;
        end if;
    end process;

    P10 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_10 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"EA")then
            port_out_10 <= data_in;
          end if;
        end if;
    end process;

    P11 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_11 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"EB")then
            port_out_11 <= data_in;
          end if;
        end if;
    end process;
        
    P12 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_12 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"EC")then
            port_out_12 <= data_in;
          end if;
        end if;
    end process;

    P13 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_13 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"ED")then
            port_out_13 <= data_in;
          end if;
        end if;
    end process;

    P14 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_14 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"EF")then
            port_out_14 <= data_in;
          end if;
        end if;
    end process;

    P15 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_15 <= X"00";
        elsif(rising_edge(clock))then
          if(write = '1'  and  address = X"F0")then
            port_out_15 <= data_in;
          end if;
        end if;
    end process;

end Behavioral;


























