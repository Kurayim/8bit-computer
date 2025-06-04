----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2025 11:59:43 AM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is

    constant CLK_PERIOD : time := 10 ns;

    signal A_tb       : std_logic_vector(7 downto 0) := (others => '0');
    signal B_tb       : std_logic_vector(7 downto 0) := (others => '0');
    signal ALU_Sel_tb : std_logic_vector(2 downto 0) := (others => '0');
    signal Result_tb  : std_logic_vector(7 downto 0);
    signal NZVC_tb    : std_logic_vector(3 downto 0);

    component alu
        port (
            A        : in  std_logic_vector(7 downto 0);
            B        : in  std_logic_vector(7 downto 0);
            ALU_Sel  : in  std_logic_vector(2 downto 0);
            Result   : out std_logic_vector(7 downto 0);
            NZVC     : out std_logic_vector(3 downto 0)
        );
    end component;

    type test_case is record
        A      : std_logic_vector(7 downto 0);
        B      : std_logic_vector(7 downto 0);
        sel    : std_logic_vector(2 downto 0);
    end record;

    type test_array is array(natural range <>) of test_case;

    constant tests : test_array := (
        (A => x"0F", B => x"01", sel => "000"), -- ADD
        (A => x"10", B => x"01", sel => "001"), -- SUB
        (A => x"FF", B => x"0F", sel => "010"), -- AND
        (A => x"F0", B => x"0F", sel => "011"), -- OR
        (A => x"7F", B => x"00", sel => "100"), -- INC A
        (A => x"80", B => x"00", sel => "101")  -- DEC A
    );

begin

    DUT: alu
        port map (
            A       => A_tb,
            B       => B_tb,
            ALU_Sel => ALU_Sel_tb,
            Result  => Result_tb,
            NZVC    => NZVC_tb
        );

    process
        variable line_out : line;
    begin
        for i in tests'range loop
            
            A_tb <= tests(i).A;
            B_tb <= tests(i).B;
            ALU_Sel_tb <= tests(i).sel;
            wait for CLK_PERIOD;

            
            write(line_out, string'("ALU_Sel: "));
            write(line_out, tests(i).sel);
            write(line_out, string'(" | A: "));
            write(line_out, (tests(i).A));
            write(line_out, string'(" | B: "));
            write(line_out, (tests(i).B));
            write(line_out, string'(" | Result: "));
            write(line_out, (Result_tb));
            write(line_out, string'(" | NZVC: "));
            write(line_out, NZVC_tb);
            writeline(output, line_out);

            wait for CLK_PERIOD;
        end loop;

        wait;
    end process;

end Behavioral;
