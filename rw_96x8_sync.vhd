Library IEEE;
use IEEE.STD_LOGICC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rw_96x8_sync is
  port(
        clock   : in std_logic;
        reset   : in std_logic;
        address : in std_logic_vector(6 downto 0);
        data_in : out std_logic_vector(7 downto 0);
        );
end rw_96x8_sync;

architecture Behavioral of rw_96x8_sync is


  
  begin




    
end Behavioral;
