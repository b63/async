----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2022 12:21:48 PM
-- Design Name: 
-- Module Name: DUALF - Behavioral
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

library work;
use work.types.all;

entity DUALF is
    generic (BITS_IN: natural := 2; BITS_OUT: natural := 2);
    port ( dinputs:  in    DRAILS_T (BITS_IN-1 downto 0);
           sinputs:  in    std_logic_vector(BITS_IN-1 downto 0);
           doutputs: out DRAILS_T (BITS_OUT-1 downto 0);
           soutputs: out std_logic_vector(BITS_IN-1 downto 0));
           
end DUALF;

architecture DUALF_imp of DUALF is
    signal dinput_or: std_logic_vector (BITS_IN-1 downto 0);
    signal all_valid: std_logic := '0';
    constant all_ones : std_logic_vector (BITS_IN-1 downto 0) := (others => '1');
begin
    GEN_OR: for i in 0 to BITS_IN-1 generate
        dinput_or(i) <= dinputs(i).t or dinputs(i).f;
        soutputs(i) <= dinputs(i).t;
        doutputs(i) <= dinputs(i) when (all_valid = '0') else
                        DRAIL_T'('1', '0') when (sinputs(i) = '1') else
                        DRAIL_T'('0', '1');
    end generate;
    
    all_valid <= '1' when (dinput_or = all_ones) else '0';
end DUALF_imp;
