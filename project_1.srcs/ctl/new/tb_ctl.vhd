----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 08:11:43 PM
-- Design Name: 
-- Module Name: ctl_tb - Behavioral
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

library work;

entity tb_ctl is
end;

architecture bench of tb_ctl is
    constant N : integer := 2;
  signal inputs: std_logic_vector(1 downto 0);
  signal output: std_logic;
begin

  uut: entity work.CTL generic map (BITS => N)
                       port map ( inputs => inputs,
                        output => output);

  stimulus: process
  begin

    -- Put initialisation code here
    --allloop: for i in 0 to 15 loop
    --    bits := to_unsigned(i, 4);
    --    inputs <= std_logic_vector(bits);
    --    wait for 2ps;
    --  end loop;
    
    -- check that default is zero  
    inputs <= "UU"; wait for 2ps;
    inputs <= "XX"; wait for 2ps;
    -- set to zero
    inputs <= "00"; wait for 2ps;
    -- set to one
    inputs <= "11"; wait for 2ps;
    -- check that state doesn't change
    inputs <= "01"; wait for 2ps;
    inputs <= "10"; wait for 2ps;
    inputs <= "01"; wait for 2ps;
    inputs <= "XX"; wait for 2ps;
    inputs <= "ZU"; wait for 2ps;
    inputs <= "X1"; wait for 2ps;
    inputs <= "1X"; wait for 2ps;
    -- set to zero 
    inputs <= "00"; wait for 2ps;
    
  end process stimulus;


end;
