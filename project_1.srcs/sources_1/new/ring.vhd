----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2022 02:11:08 PM
-- Design Name: 
-- Module Name: dualf_tb - Behavioral
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
use work.types.all;


entity ring is

    port (start : in std_logic := '0';
          value : out DRAILS_T (3-1 downto 0));
end;

architecture ring_imp of ring is
  constant N : natural := 3;
  constant DELAY : time := 2ps;
  
  signal inputs_1, outputs_1 :  DRAILS_T (N-1 downto 0);
  signal ack_in_1: std_logic := '0';
  signal ack_out_1: std_logic;
  
  signal inputs_2, outputs_2 :  DRAILS_T (N-1 downto 0);
  signal ack_in_2: std_logic := '0';
  signal ack_out_2: std_logic;

  signal inputs_3, outputs_3 :  DRAILS_T (N-1 downto 0);
  signal ack_in_3: std_logic := '0';
  signal ack_out_3: std_logic;

  signal fin, fout : std_logic_vector(N-1 downto 0);
  signal fdout :  DRAILS_T (N-1 downto 0);
  signal m_start: std_logic;
  constant zero : DRAILS_T(N-1 downto 0) := (others => ('0', '1'));
begin

  l1: entity work.CLATCH generic map (N => N, DELAY => DELAY)
                       port map (
                        inputs => inputs_1,
                        outputs => outputs_1,
                        ack_in => ack_in_1,
                        ack_out => ack_out_1);
                        
  l2: entity work.CLATCH generic map (N => N, ACK => '1', DELAY => DELAY)
                       port map (
                        inputs => inputs_2,
                        outputs => outputs_2,
                        ack_in => ack_in_2,
                        ack_out => ack_out_2);
                        
  l3: entity work.CLATCH generic map (N => N, ACK => '0', QSTATE => "000", DELAY => DELAY)
                       port map (
                        inputs => inputs_3,
                        outputs => outputs_3,
                        ack_in => ack_in_3,
                        ack_out => ack_out_3);
                        
   uut: entity work.DUALF generic map (BITS_IN => N, BITS_OUT => N)
                          port map (
                           dinputs => outputs_3,
                           sinputs => fout,
                           doutputs => fdout,
                           soutputs => fin);
                           
   -- ack_in_3 stays 0 if start is '0'
   m_start <= '0' when (start = '0') else ack_out_1;
   control: entity work.CTL generic map (BITS => 2)
                            port map (
                             inputs => std_logic_vector'(m_start & ack_out_1),
                             output => ack_in_3);
                             
  fout <= std_logic_vector(unsigned(fin) + 1);
  value <= fdout;
  
  inputs_1 <= fdout;
  inputs_2 <= outputs_1;
  inputs_3 <= outputs_2;
  
  ack_in_1 <= ack_out_2;
  ack_in_2 <= ack_out_3;
  
end;

