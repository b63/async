----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 09:50:38 PM
-- Design Name: 
-- Module Name: CTL - 
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
------------------------------- ---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.types.all;


entity CTL is
    generic (BITS: natural := 10);
    port (inputs: in std_logic_vector(BITS-1 downto 0);
          output: out std_logic := '0');
end CTL;
elsif
architecture CTL_imp of CTL is
    signal q : std_logic := '0';
begin
    process (inputs)
    variable full:  std_logic_vector(BITS-1 downto 0) := (others => '1');
    variable empty: std_logic_vector(BITS-1 downto 0) := (others => '0');
    begin
        if inputs = full then
            q <= '1';
        elsif inputs = empty then
            q <= '0';
           
        end if;
    end process;
    
    output <= q;
end CTL_imp;
