library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
begin

    process(A, B, ALU_Sel)
        variable Sum_uns : unsigned(8 downto 0); -- 9-bit for carry detection
        variable A_unsigned, B_unsigned : unsigned(7 downto 0); -- Unsigned versions of A and B
    begin
        A_unsigned := unsigned(A);
        B_unsigned := unsigned(B);

        case ALU_Sel is

            when "000" => -- ADD
                Sum_uns := ('0' & A_unsigned) + ('0' & B_unsigned); -- Extend A and B to 9 bits and add
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0)); -- Assign lower 8 bits to result

                -- Flags
                N <= Sum_uns(7);  -- Negative flag from MSB of result
                if Sum_uns(7 downto 0) = x"00" then -- Zero detection
                    Z <= '1';
                else
                    Z <= '0';
                end if;
                -- Overflow detection (signed overflow)
                if (A(7) = '0' and B(7) = '0' and Sum_uns(7) = '1') or
                   (A(7) = '1' and B(7) = '1' and Sum_uns(7) = '0') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8); -- Carry flag from 9th bit

            when "001" => -- SUB
                Sum_uns := ('0' & B_unsigned) - ('0' & A_unsigned); -- Subtract A from B
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));

                -- Flags
                N <= Sum_uns(7);
                if Sum_uns(7 downto 0) = x"00" then Z <= '1'; else Z <= '0'; end if;
                -- Overflow detection (signed subtraction overflow)
                if (B(7) = '0' and A(7) = '1' and Sum_uns(7) = '1') or
                   (B(7) = '1' and A(7) = '0' and Sum_uns(7) = '0') then
                    V <= '1';
                else
                    V <= '0';
                end if;
                C <= Sum_uns(8);

            when "010" => -- AND
                ALU_Result <= A and B;
                N <= ALU_Result(7); -- Negative from MSB
                Z <= '1' when ALU_Result = x"00" else '0'; -- Zero check
                V <= '0'; -- Overflow doesn't apply to logic ops
                C <= '0'; -- No carry in logic ops

            when "011" => -- OR
                ALU_Result <= A or B;
                N <= ALU_Result(7);
                Z <= '1' when ALU_Result = x"00" else '0';
                V <= '0';
                C <= '0';

            when "100" => -- INC A
                Sum_uns := ('0' & A_unsigned) + 1; -- Add 1 to A
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                Z <= '1' when Sum_uns(7 downto 0) = x"00" else '0';
                V <= '1' when (A(7) = '0' and Sum_uns(7) = '1') else '0'; -- Overflow detection
                C <= Sum_uns(8);

            when "101" => -- DEC A
                Sum_uns := ('0' & A_unsigned) - 1; -- Subtract 1 from A
                ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));
                N <= Sum_uns(7);
                Z <= '1' when Sum_uns(7 downto 0) = x"00" else '0';
                V <= '1' when (A(7) = '1' and Sum_uns(7) = '0') else '0'; -- Overflow detection
                C <= Sum_uns(8);

            when others => -- Default case: clear result and flags
                ALU_Result <= (others => '0');
                N <= '0'; Z <= '1'; V <= '0'; C <= '0';
        end case;
    end process;

    -- Assign outputs
    Result <= ALU_Result; -- Final ALU result
    NZVC <= N & Z & V & C; -- Combine flags into NZVC output

end Behavioral;
