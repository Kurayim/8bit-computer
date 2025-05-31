Library IEEE;
use IEEE.STD_LOGICC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for synchronous 96x8-bit read/write memory
entity output_ports_16 is
  port(
        clock        : in  std_logic;
        reset        : in  std_logic;
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
        port_out_15  : out std_logic_vector(7 downto 0);
        );
end output_ports_16;
  
architecture Behavioral of output_ports_16 is



  begin
    
    P0 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_00 <= data_in;
          end if;
        end if
    end process;


     P1 : process(clock, reset)
     begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E1")then
            port_out_01 <= data_in;
          end if;
        end if
    end process;


    P2 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E2")then
            port_out_02 <= data_in;
          end if;
        end if;
    end process;

    P3 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E3")then
            port_out_03 <= data_in;
          end if;
        end if;
    end process;

    P4 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E4")then
            port_out_04 <= data_in;
          end if;
        end if;
    end process;

    P5 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E5")then
            port_out_05 <= data_in;
          end if;
        end if;
    end process;

    P6 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E6")then
            port_out_06 <= data_in;
          end if;
        end if;
    end process;

    P7 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E7")then
            port_out_07 <= data_in;
          end if;
        end if;
    end process;

    P8 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E8")then
            port_out_08 <= data_in;
          end if;
        end if;
    end process;

    P9 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E9")then
            port_out_09 <= data_in;
          end if;
        end if;
    end process;

    P10 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_10 <= data_in;
          end if;
        end if;
    end process;

    P11 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_11 <= data_in;
          end if;
        end if;
    end process;
        
    P12 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_12 <= data_in;
          end if;
        end if;
    end process;

    P13 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_13 <= data_in;
          end if;
        end if;
    end process;

    P14 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_14 <= data_in;
          end if;
        end if;
    end process;

    P15 : process(clock, reset)
    begin
        if(reset = '0')then
          port_out_00 <= X"00";
        else if(rising_edge(clock))then
          if(write = '1'  and  address = X"E0")then
            port_out_15 <= data_in;
          end if;
        end if;
    end process;

 
end Behavioral;    -- End of architecture












        
