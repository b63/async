----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 08:46:51 AM
-- Design Name: 
-- Module Name: adder - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity adder_tb is
end;

architecture bench of adder_tb is
  signal x, y: std_logic_vector(1 downto 0);
  signal c: std_logic_vector(2 downto 0) := "000";
begin

  uut: entity work.adder port map ( x => x,
                        y => y,
                        c => c );

  stimulus: process
  variable bits : unsigned (3 downto 0);
  begin

    -- Put initialisation code here
    allloop: for i in 0 to 15 loop
        bits := to_unsigned(i, 4);
        x <= std_logic_vector(bits(1 downto 0));
        y <= std_logic_vector(bits(3 downto 2));
        wait for 10ns;
     end loop;
  end process stimulus;


end;
