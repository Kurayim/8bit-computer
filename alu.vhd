----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2025 11:17:27 AM
-- Design Name: 
-- Module Name: alu - Behavioral
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
-- ============================================================================
-- Title       : 8-bit ALU (Arithmetic Logic Unit)
-- Description : This VHDL module implements a simple 8-bit ALU.
--               It performs basic arithmetic and logic operations based on a 
--               3-bit selector input.
--
-- Operations Supported:
--   "000" - A + B        (Addition)
--   "001" - B - A        (Subtraction)
--   "010" - A AND B      (Bitwise AND)
--   "011" - A OR B       (Bitwise OR)
--   "100" - A + 1        (Increment A)
--   "101" - A - 1        (Decrement A)
--
-- Inputs:
--   A       : 8-bit operand
--   B       : 8-bit operand
--   ALU_Sel : 3-bit control signal to select the operation
--
-- Outputs:
--   Result  : 8-bit output result of the ALU operation
--   NZVC    : 4-bit status flags:
--             N - Negative (Result is negative)
--             Z - Zero     (Result is zero)
--             V - Overflow (Signed overflow occurred)
--             C - Carry    (Unsigned carry out from MSB)
--
-- Compatibility: Designed for Xilinx Vivado
-- ============================================================================


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

entity alu is
    Port (
        A        : in  std_logic_vector(7 downto 0);
        B        : in  std_logic_vector(7 downto 0);
        ALU_Sel  : in  std_logic_vector(2 downto 0);  -- Select signal (3 bits)
        Result   : out std_logic_vector(7 downto 0);  -- ALU output
        NZVC     : out std_logic_vector(3 downto 0)   -- Flags: N,Z,V,C
    );
end alu;

architecture Behavioral of alu is

    signal ALU_Result : std_logic_vector(7 downto 0); -- ALU calculation result
    signal N, Z, V, C : std_logic; -- ALU status flags
    signal logic_and, logic_or : std_logic_vector(7 downto 0); -- signals for logic operations

begin

     process(A, B, ALU_Sel)
        variable Sum_uns : unsigned(8 downto 0);
        variable A_unsigned, B_unsigned : unsigned(7 downto 0);
    begin
        A_unsigned := unsigned(A);
        B_unsigned := unsigned(B);

        -- Calculate logic results once
        logic_and <= A and B;
        logic_or  <= A or B;

        case ALU_Sel is

            when "000" => -- A + B
                Sum_uns := ('0' & A_unsigned) + ('0' & B_unsigned);
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                if Sum_uns(7 downto 0) = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                if (A(7) = '0' and B(7) = '0' and Sum_uns(7) = '1') or
                   (A(7) = '1' and B(7) = '1' and Sum_uns(7) = '0') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8);

            when "001" => -- B - A
                Sum_uns := ('0' & B_unsigned) - ('0' & A_unsigned);
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                if Sum_uns(7 downto 0) = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                if (B(7) = '0' and A(7) = '1' and Sum_uns(7) = '1') or
                   (B(7) = '1' and A(7) = '0' and Sum_uns(7) = '0') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8);

            when "010" => -- A AND B
                ALU_Result <= logic_and;
                N <= logic_and(7);
                if logic_and = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                V <= '0';
                C <= '0';

            when "011" => -- A OR B
                ALU_Result <= logic_or;
                N <= logic_or(7);
                if logic_or = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                V <= '0';
                C <= '0';

            when "100" => -- A + 1 (Increment)
                Sum_uns := ('0' & A_unsigned) + 1;
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                if Sum_uns(7 downto 0) = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                if (A(7) = '0' and Sum_uns(7) = '1') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8);

            when "101" => -- A - 1 (Decrement)
                Sum_uns := ('0' & A_unsigned) - 1;
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                if Sum_uns(7 downto 0) = x"00" then
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                if (A(7) = '1' and Sum_uns(7) = '0') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8);

            when others =>
                ALU_Result <= (others => '0');
                N <= '0';
                Z <= '1';
                V <= '0';
                C <= '0';

        end case;
    end process;

    -- Output assignments
    Result <= ALU_Result;
    NZVC <= N & Z & V & C;

end Behavioral;
