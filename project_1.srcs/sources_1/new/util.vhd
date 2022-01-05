----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 09:42:34 PM
-- Design Name: 
-- Module Name:  - 
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

package types is
    type DRAIL_T is record
        t: std_logic;
        f: std_logic;
    end record DRAIL_T;
    
    type DRAILS_T is array (natural range <>) of DRAIL_T;
    
    function drail_to_logic(drail : DRAIL_T)   return std_logic;
    function drails_to_logic(drails : DRAILS_T) return std_logic_vector;
    function logic_to_drail(bit : std_logic) return DRAIL_T;
    function logic_vec_to_drails(vec : std_logic_vector) return DRAILS_T;
end package;

package body types is
    function drail_to_logic(drail : DRAIL_T)
    return std_logic is
        variable r : std_logic := 'X';
    begin
        if (drail.t = '1' and drail.f = '0') then
            r := '1';
        elsif (drail.t = '0' and drail.f = '1') then
            r := '0';
        end if;
        return r;
    end drail_to_logic;
    
    function drails_to_logic(drails : DRAILS_T)
    return std_logic_vector is
        variable vec : std_logic_vector (drails'length-1 downto 0) := (others => 'U');
    begin
        for i in 0 to drails'length-1 loop
            vec(i) := drail_to_logic(drails(i));
        end loop;
        return vec;
    end drails_to_logic;
    
    function logic_to_drail(bit : std_logic)
    return DRAIL_T is
        variable drail : DRAIL_T := ('1', '1');
    begin
        if (bit = '1') then
            drail.t := '1';
            drail.f := '0';
        elsif (bit = '0') then
            drail.t := '0';
            drail.f := '1';
        else
            drail.t := '0';
            drail.f := '0';
        end if;
        return drail;
    end logic_to_drail;
    
    function logic_vec_to_drails(vec : std_logic_vector)
    return DRAILS_T is
        variable drails : DRAILS_T (vec'length-1 downto 0);
    begin
        for i in 0 to vec'length-1 loop
            drails(i) := logic_to_drail(vec(i));
        end loop;
        return drails;
    end logic_vec_to_drails;
end package body types;