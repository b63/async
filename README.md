# Soft-core Asynchoronous CPU
Vivado project for implementing a soft-core asynchronous microprocessor in VHDL on a Xilinx FPGA.

VHDL source files are in `project_1.srcs/`. The `project_1.srcs/sources_1` subdirectory contains design sources,
and the other  subdirectories contain simulation-only sources (VHDL test benches).

Description of VHDL source files:
   - [CLATCH.vhd](project_1.srcs/sources_1/imports/new/CLATCH.vhd): implemention of N-bit basic Latch using C-Element
   - [CTL.vhd](project_1.srcs/sources_1/imports/new/CTL.vhd): implementation N-bit [Muller C-element](https://en.wikipedia.org/wiki/C-element)
   - [util.vhd](project_1.srcs/sources_1/new/util.vhd): new types and auxillary functions 
   - [DUALF.vhd](project_1.srcs/sources_1/new/DUALF.vhd): functional block for dual-rail 4-phase signaling

