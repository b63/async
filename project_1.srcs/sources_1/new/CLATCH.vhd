----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/03/2022 09:48:12 PM
-- Design Name: 
-- Module Name: CLATCH - CLATCH_imp
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

library work;
use work.types.all;

entity CLATCH is
    generic (N : natural := 1);
    port ( inputs : in    DRAILS_T (N-1 downto 0);
           outputs: out   DRAILS_T (N-1 downto 0);
           ack:     inout std_logic := '0');
end CLATCH;

architecture CLATCH_imp of CLATCH is
    signal inv_ack : std_logic := not ack;
    signal m_ack : std_logic := '0';
    --signal m_outputs: DRAILS_T (N-1 downto 0);
    signal m_outputs_or: std_logic_vector (N-1 downto 0);
begin
    GEN_CTL: for i in 0 to N-1 generate
        UTRUE:  entity work.CTL generic map (BITS => 2)
                        port map ( inputs => std_logic_vector'(inv_ack & inputs(i).t), output => outputs(i).t);
        UFALSE: entity work.CTL generic map (BITS => 2)
                         port map (inputs => std_logic_vector'(inv_ack & inputs(i).f), output => outputs(i).f);
        m_outputs_or(i) <= m_outputs(i).t or m_outputs(i).f;
    end generate GEN_CTL;
    
    END_CTL: entity work.CTL generic map (BITS => N)
                      port map (inputs => m_outputs_or, output => m_ack);
    ack <= m_ack;
end CLATCH_imp;
