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

entity dualf_tb is
end;

architecture bench of dualf_tb is
  constant N : natural := 2;
  constant DELAY : time := 1ps;
  
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
  signal start : std_logic := '0';
  constant zero : DRAILS_T(N-1 downto 0) := (others => ('0', '1'));
begin

  l1: entity work.CLATCH generic map (N => N, DELAY => 1ps, QSTATE => "00")
                       port map (
                        inputs => inputs_1,
                        outputs => outputs_1,
                        ack_in => ack_in_1,
                        ack_out => ack_out_1);
                        
  l2: entity work.CLATCH generic map (N => N, ACK => '1', DELAY => 1ps)
                       port map (
                        inputs => inputs_2,
                        outputs => outputs_2,
                        ack_in => ack_in_2,
                        ack_out => ack_out_2);
                        
  l3: entity work.CLATCH generic map (N => N, ACK => '0', QSTATE => "00", DELAY => 1ps)
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
                           
  fout <= std_logic_vector(unsigned(fin) + 0);
  inputs_1 <= fdout;
  inputs_2 <= outputs_1;
  inputs_3 <= outputs_2;
  
  ack_in_1 <= ack_out_2;
  ack_in_2 <= ack_out_3;
  ack_in_3 <= ack_out_1 ;
  
  stimulus: process
  begin
    wait for 5ps;
  end process stimulus;


end;

