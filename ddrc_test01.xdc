#################################################################################
# Filename: ddrc_test01.xdc
# Date:2014-05-20  
# Author: Andrey Filippov
# Description: DDR3 controller test with axi constraints
#
# Copyright (c) 2014 Elphel, Inc.
# ddrc_test01.xdc is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
#  ddrc_test01.xdc is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/> .
#################################################################################

#    output                       SDRST, // output SDRST, active low
set_property IOSTANDARD SSTL15 [get_ports {SDRST}]
set_property PACKAGE_PIN J4 [get_ports {SDRST}]

#    output                       SDCLK, // DDR3 clock differential output, positive
set_property IOSTANDARD DIFF_SSTL15 [get_ports {SDCLK}]
set_property PACKAGE_PIN K3 [get_ports {SDCLK}]

#    output                       SDNCLK,// DDR3 clock differential output, negative
set_property IOSTANDARD DIFF_SSTL15 [get_ports {SDNCLK}]
set_property PACKAGE_PIN K2 [get_ports {SDNCLK}]

#    output  [ADDRESS_NUMBER-1:0] SDA,   // output address ports (14:0) for 4Gb device
set_property IOSTANDARD SSTL15 [get_ports {SDA[0]}]
set_property PACKAGE_PIN N3 [get_ports {SDA[0]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[1]}]
set_property PACKAGE_PIN H2 [get_ports {SDA[1]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[2]}]
set_property PACKAGE_PIN M2 [get_ports {SDA[2]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[3]}]
set_property PACKAGE_PIN P5 [get_ports {SDA[3]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[4]}]
set_property PACKAGE_PIN H1 [get_ports {SDA[4]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[5]}]
set_property PACKAGE_PIN M3 [get_ports {SDA[5]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[6]}]
set_property PACKAGE_PIN J1 [get_ports {SDA[6]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[7]}]
set_property PACKAGE_PIN P4 [get_ports {SDA[7]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[8]}]
set_property PACKAGE_PIN K1 [get_ports {SDA[8]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[9]}]
set_property PACKAGE_PIN P3 [get_ports {SDA[9]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[10]}]
set_property PACKAGE_PIN F2 [get_ports {SDA[10]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[11]}]
set_property PACKAGE_PIN H3 [get_ports {SDA[11]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[12]}]
set_property PACKAGE_PIN G3 [get_ports {SDA[12]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[13]}]
set_property PACKAGE_PIN N2 [get_ports {SDA[13]}]

set_property IOSTANDARD SSTL15 [get_ports {SDA[14]}]
set_property PACKAGE_PIN J3 [get_ports {SDA[14]}]


#    output                 [2:0] SDBA,  // output bank address ports
set_property IOSTANDARD SSTL15 [get_ports {SDBA[0]}]
set_property PACKAGE_PIN N1 [get_ports {SDBA[0]}]

set_property IOSTANDARD SSTL15 [get_ports {SDBA[1]}]
set_property PACKAGE_PIN F1 [get_ports {SDBA[1]}]

set_property IOSTANDARD SSTL15 [get_ports {SDBA[2]}]
set_property PACKAGE_PIN P1 [get_ports {SDBA[2]}]

#    output                       SDWE,  // output WE port
set_property IOSTANDARD SSTL15 [get_ports {SDWE}]
set_property PACKAGE_PIN G4 [get_ports {SDWE}]

#    output                       SDRAS, // output RAS port
set_property IOSTANDARD SSTL15 [get_ports {SDRAS}]
set_property PACKAGE_PIN L2 [get_ports {SDRAS}]

#    output                       SDCAS, // output CAS port
set_property IOSTANDARD SSTL15 [get_ports {SDCAS}]
set_property PACKAGE_PIN L1 [get_ports {SDCAS}]

#    output                       SDCKE, // output Clock Enable port
set_property IOSTANDARD SSTL15 [get_ports {SDCKE}]
set_property PACKAGE_PIN E1 [get_ports {SDCKE}]

#    output                       SDODT, // output ODT port
set_property IOSTANDARD SSTL15 [get_ports {SDODT}]
set_property PACKAGE_PIN M7 [get_ports {SDODT}]
#

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[0]}]
set_property PACKAGE_PIN K6 [get_ports {SDD[0]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[1]}]
set_property PACKAGE_PIN L4 [get_ports {SDD[1]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[2]}]
set_property PACKAGE_PIN K7 [get_ports {SDD[2]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[3]}]
set_property PACKAGE_PIN K4 [get_ports {SDD[3]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[4]}]
set_property PACKAGE_PIN L6 [get_ports {SDD[4]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[5]}]
set_property PACKAGE_PIN M4 [get_ports {SDD[5]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[6]}]
set_property PACKAGE_PIN L7 [get_ports {SDD[6]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[7]}]
set_property PACKAGE_PIN N5 [get_ports {SDD[7]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[8]}]
set_property PACKAGE_PIN H5 [get_ports {SDD[8]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[9]}]
set_property PACKAGE_PIN J6 [get_ports {SDD[9]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[10]}]
set_property PACKAGE_PIN G5 [get_ports {SDD[10]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[11]}]
set_property PACKAGE_PIN H6 [get_ports {SDD[11]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[12]}]
set_property PACKAGE_PIN F5 [get_ports {SDD[12]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[13]}]
set_property PACKAGE_PIN F7 [get_ports {SDD[13]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[14]}]
set_property PACKAGE_PIN F4 [get_ports {SDD[14]}]

#    inout                 [15:0] SDD,       // DQ  I/O pads
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDD[15]}]
set_property PACKAGE_PIN F6 [get_ports {SDD[15]}]

#    inout                        DQSL,     // LDQS I/O pad
set_property PACKAGE_PIN N7 [get_ports {DQSL}]
set_property SLEW FAST [get_ports {DQSL}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {DQSL}]

#    inout                        NDQSL,    // ~LDQS I/O pad
set_property PACKAGE_PIN N6 [get_ports {NDQSL}]
set_property SLEW FAST [get_ports {NDQSL}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {NDQSL}]

#    inout                        DQSU,     // UDQS I/O pad
set_property PACKAGE_PIN H7 [get_ports {DQSU}]
#set_property SLEW FAST [get_ports {DQSU}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {DQSU}]

#    inout                        NDQSU,    // ~UDQS I/O pad
set_property PACKAGE_PIN G7 [get_ports {NDQSU}]
#set_property SLEW FAST [get_ports {NDQSU}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {NDQSU}]

#    inout                        SDDML,      // LDM  I/O pad (actually only output)
#set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDDML}]
set_property IOSTANDARD SSTL15 [get_ports {SDDML}]
set_property PACKAGE_PIN L5 [get_ports {SDDML}]

#    inout                        SDDMU,      // UDM  I/O pad (actually only output)
#set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDDMU}]
set_property IOSTANDARD SSTL15 [get_ports {SDDMU}]
set_property PACKAGE_PIN J5 [get_ports {SDDMU}]


# Global constraints

set_property INTERNAL_VREF  0.750 [get_iobanks 34]
set_property DCI_CASCADE 34 [get_iobanks 35]
set_property INTERNAL_VREF  0.750 [get_iobanks 35]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
