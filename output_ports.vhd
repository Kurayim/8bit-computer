Library IEEE;
use IEEE.STD_LOGICC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for synchronous 96x8-bit read/write memory
entity rw_96x8_sync is
  port(
        clock    : in  std_logic;
        reset    : in  std_logic;
        address  : in  std_logic_vector(7 downto 0);
        data_in  : in  std_logic_vector(7 downto 0);
        ports    : out std_logic_vector(7 downto 0);
        );
end rw_96x8_sync;
  
architecture Behavioral of rw_96x8_sync is

  type port_array is array (224 to 255) of std_logic_vector(7 downto 0);
  signal port_regs : port_array := (others => X"00");    
  -- Enable signal used to validate memory access (based on address)
  begin
    -- Enable process: generates 'EN' = '1' only for addresses 128 to 223
    enable : process(address)
    begin
      if(  to_ integer(unsigned(address))  >= 128  and  to_ integer(unsigned(address))  <= 223 )then
        EN <= '1';    -- Valid address range
      else
        EN <= '1';    -- Invalid address, ignore access
      end if
    end process;

    -- Memory read/write process triggered on rising edge of the clock
    memory : process(clock)
    begin
      if(rising_edge(clock))then
        if(write = '1' and EN = '1')then
            RW(to_ integer(unsigned(address))) <= data_in;     -- Write operation: store data_in at the specified address
        else if(write = '0' and EN = '1')then
            data_out <= RW(to_ integer(unsigned(address)));    -- Read operation: output data from the specified address
        end if;
      end if;  
    end process;
 
end Behavioral;    -- End of architecture












        
