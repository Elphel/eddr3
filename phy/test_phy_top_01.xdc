
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
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDDML}]
set_property PACKAGE_PIN L5 [get_ports {SDDML}]

#    inout                        SDDMU,      // UDM  I/O pad (actually only output)
set_property IOSTANDARD SSTL15_T_DCI [get_ports {SDDMU}]
set_property PACKAGE_PIN J5 [get_ports {SDDMU}]


########### Other (fake - just for testing) pins ##################
#    input                        clk_in,   // master input clock, initially assuming 100MHz
set_property IOSTANDARD SSTL15 [get_ports {clk_in}]
set_property PACKAGE_PIN M5 [get_ports {clk_in}]
### borrowing fake inputs from a sensor port #########
#    input                        rst_in,      // reset delays/serdes
set_property IOSTANDARD SSTL15 [get_ports {rst_in}]
set_property PACKAGE_PIN U10 [get_ports {rst_in}]

#    input                        fake_din,
set_property IOSTANDARD SSTL15 [get_ports {fake_din}]
set_property PACKAGE_PIN T9 [get_ports {fake_din}]
#    input                        fake_en
set_property IOSTANDARD SSTL15 [get_ports {fake_en}]
set_property PACKAGE_PIN T10 [get_ports {fake_en}]

#    input                        fake_oe,
set_property IOSTANDARD SSTL15 [get_ports {fake_oe}]
set_property PACKAGE_PIN V8 [get_ports {fake_oe}]
#    output                       fake_dout
set_property IOSTANDARD SSTL15 [get_ports {fake_dout}]
set_property PACKAGE_PIN W8 [get_ports {fake_dout}]




set_property INTERNAL_VREF  0.750 [get_iobanks 34]
#set_property DCI_CASCADE{slave_banks} [get_iobanks master_bank]
# Designate Bank 14 as a master DCI Cascade bank and Banks 15 and 16 as its slaves
# set_property DCI_CASCADE {15 16} [get_iobanks 14]

set_property DCI_CASCADE 34 [get_iobanks 35]
set_property INTERNAL_VREF  0.750 [get_iobanks 35]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]


#ERROR: [Place 30-574] Poor placement for routing between an IO pin and BUFG. If this sub optimal condition is acceptable
# for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to demote this message to a WARNING.
# However, the use of this override is highly discouraged. These examples can be used directly in the .xdc file to override
# this clock rule.
#	< set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_ref_in_IBUF] >
#	clk_ref_in_IBUF_inst (IBUF.O) is locked to IOB_X1Y123
#	ref_clk_i (BUFG.I) is provisionally placed by clockplacer on BUFGCTRL_X0Y31
# Resolution: Poor placement of an IO pin and a BUFG has resulted in the router using a non-dedicated path between the two.
# There are several things that could trigger this DRC, each of which can cause unpredictable clock insertion delays that
# result in poor timing.  This DRC could be caused by any of the following: (a) a clock port was placed on a pin that is
# not a CCIO-pin (b)the BUFG has not been placed in the same half of the device or SLR as the CCIO-pin (c) a single ended
# clock has been placed on the N-Side of a differential pair CCIO-pin.

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_ref_in_IBUF]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets *]

#trying to force BUFR to use fabric input
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets dqs_single_i/dqs_in_dly_i/dqs_received]
#puts [get_property CLOCK_DEDICATED_ROUTE [get_nets dqs_single_i/dqs_in_dly_i/dqs_received]]