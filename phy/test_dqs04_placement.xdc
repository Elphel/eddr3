set_property PACKAGE_PIN N7 [get_ports {dqs}]
set_property SLEW FAST [get_ports {dqs}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {dqs}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dqs}]

set_property PACKAGE_PIN N6 [get_ports {ndqs}]
set_property SLEW FAST [get_ports {ndqs}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ndqs}]


#    input       dqs_data,
#    inout       dqs,
#    inout       ndqs,
#    output      dqs_received,
#    input       dqs_tri


#set_property IOSTANDARD LVCMOS15 [get_ports {rst}]
#set_property IOSTANDARD LVCMOS15 [get_ports {refclk}]
#set_property IOSTANDARD LVCMOS15 [get_ports {clk_in}]
#set_property IOSTANDARD LVCMOS15 [get_ports {set}]
#set_property IOSTANDARD LVCMOS15 [get_ports {ld_dly_data}]
#set_property IOSTANDARD LVCMOS15 [get_ports {ld_dly_tri}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[7]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[6]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[5]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[4]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[3]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[2]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[1]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[0]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {data_in[3]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {data_in[2]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {data_in[1]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {data_in[0]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {tri_in[3]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {tri_in[2]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {tri_in[1]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {tri_in[0]}]

set_property IOSTANDARD LVCMOS15 [get_ports {dqs_received}]
set_property PACKAGE_PIN K4 [get_ports {dqs_received}]
set_property IOSTANDARD LVCMOS15 [get_ports {dqs_data}]
set_property PACKAGE_PIN K6 [get_ports {dqs_data}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dly_ready}]
#set_property IOSTANDARD LVCMOS15 [get_ports {dqs_date}]
set_property IOSTANDARD LVCMOS15 [get_ports {dqs_tri}]
set_property PACKAGE_PIN K7 [get_ports {dqs_tri}]

#    input       dqs_data,
#    inout       dqs,
#    inout       ndqs,
#    output      dqs_received,
#    input       dqs_tri,

set_property IOSTANDARD LVCMOS15 [get_ports {clk_in}]
set_property PACKAGE_PIN M5 [get_ports {clk_in}]
set_property IOSTANDARD LVCMOS15 [get_ports {clk_ref_in}]
set_property PACKAGE_PIN L4 [get_ports {clk_ref_in}]
set_property IOSTANDARD LVCMOS15 [get_ports {rst}]
set_property PACKAGE_PIN L5 [get_ports {rst}]
set_property IOSTANDARD LVCMOS15 [get_ports {dly_ready}]
set_property PACKAGE_PIN M2 [get_ports {dly_ready}]


#    input       clk_in,
#    input       clk_ref_in,
#    input       rst,
#    output      dly_ready

set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[4]}]
set_property PACKAGE_PIN J1 [get_ports {dly_data[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[3]}]
set_property PACKAGE_PIN J3 [get_ports {dly_data[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[2]}]
set_property PACKAGE_PIN J4 [get_ports {dly_data[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[1]}]
set_property PACKAGE_PIN J5 [get_ports {dly_data[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {dly_data[0]}]
set_property PACKAGE_PIN J6 [get_ports {dly_data[0]}]



set_property IOSTANDARD LVCMOS15 [get_ports {set}]
set_property PACKAGE_PIN L6 [get_ports {set}]
set_property IOSTANDARD LVCMOS15 [get_ports {ld}]
set_property PACKAGE_PIN L7 [get_ports {ld}]




#    input rst,    // reset
#    input refclk, // 200MHz/300MHz for delay calibration
#    input clk_in,
#    input set,
#    input ld_dly_data,
#    input ld_dly_tri,
#    input [7:0] dly_data,
#    input [3:0] data_in,
#    input [3:0] tri_in,
#    inout       dqs,
#    inout       ndqs,
#    output      dqs_received,
#    output      dly_ready,
#    input       dqs_tri_a,
#    output      dqs_tri





#set_property PACKAGE_PIN A1 [get_ports {COUNT[2]}]
#set_property PACKAGE_PIN B2 [get_ports {COUNT[1]}]
#set_property PACKAGE_PIN C2 [get_ports {COUNT[0]}]
#set_property PULLUP true [get_ports {COUNT[3]}]
#set_property PULLUP true [get_ports {COUNT[2]}]
#set_property PULLUP true [get_ports {COUNT[1]}]
#set_property PULLUP true [get_ports {COUNT[0]}]
#set_property PACKAGE_PIN A4 [get_ports ENABLE]
#set_property PACKAGE_PIN B4 [get_ports RESET]

#set_property PACKAGE_PIN C1 [get_ports CLK]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLK_IBUF]

#set_property IOSTANDARD LVCMOS18 [get_ports {COUNT[3]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {COUNT[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {COUNT[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {COUNT[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports ENABLE]
#set_property IOSTANDARD LVCMOS18 [get_ports RESET]
#set_property IOSTANDARD LVCMOS18 [get_ports CLK]


set_property INTERNAL_VREF  0.750 [get_iobanks 34]
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

# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_ref_in_IBUF]
