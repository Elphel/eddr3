/*******************************************************************************
 * Module: ddr3c16
 * Date:2014-05-16  
 * Author: Andrey Filippov
 * Description: ddr3 controller, 16 channel
 *
 * Copyright (c) 2014 Elphel, Inc.
 * ddr3c16.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  ddr3c16.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  ddr3c16   #(
    parameter PHASE_WIDTH =     8,
    parameter SLEW_DQ =         "SLOW",
    parameter SLEW_DQS =        "SLOW",
    parameter SLEW_CMDA =       "SLOW",
    parameter SLEW_CLK =       "SLOW",
    parameter IBUF_LOW_PWR =    "TRUE",
    parameter real REFCLK_FREQUENCY = 300.0,
    parameter HIGH_PERFORMANCE_MODE = "FALSE",
    parameter CLKIN_PERIOD          = 10, //ns >1.25, 600<Fvco<1200
    parameter CLKFBOUT_MULT =       8, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE
    parameter CLKFBOUT_MULT_REF =   9, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE
    parameter CLKFBOUT_DIV_REF =    3, // To get 300MHz for the reference clock
    parameter DIVCLK_DIVIDE=        1,
    parameter CLKFBOUT_PHASE =      0.000,
    parameter ICLK_PHASE =          0.000,
    parameter CLK_PHASE =           0.000,
    parameter CLK_DIV_PHASE =       0.000,
    parameter MCLK_PHASE =          90.000,
    parameter REF_JITTER1 =         0.010,
    parameter SS_EN =              "FALSE",
    parameter SS_MODE =      "CENTER_HIGH",
    parameter SS_MOD_PERIOD =       10000,
    parameter DQSTRI_FIRST=    4'h3, // DQS tri-state control word, first when enabling output 
    parameter DQSTRI_LAST=     4'hc, // DQS tri-state control word, first after disabling output
    parameter DQTRI_FIRST=     4'h7, // DQ tri-state control word, first when enabling output 
    parameter DQTRI_LAST=      4'he  // DQ tri-state control word, first after disabling output
    
)(
    // DDR3 interface
    output                       SDCLK, // DDR3 clock differential output, positive
    output                       SDNCLK,// DDR3 clock differential output, negative
    output  [ADDRESS_NUMBER-1:0] SDA,   // output address ports (14:0) for 4Gb device
    output                 [2:0] SDBA,  // output bank address ports
    output                       SDWE,  // output WE port
    output                       SDRAS, // output RAS port
    output                       SDCAS, // output CAS port
    output                       SDCKE, // output Clock Enable port
    output                       SDODT, // output ODT port

    inout                 [15:0] SDD,       // DQ  I/O pads
    inout                        SDDML,      // LDM  I/O pad (actually only output)
    inout                        DQSL,     // LDQS I/O pad
    inout                        NDQSL,    // ~LDQS I/O pad
    inout                        SDDMU,      // UDM  I/O pad (actually only output)
    inout                        DQSU,     // UDQS I/O pad
    inout                        NDQSU,    // ~UDQS I/O pad
// clocks, reset
    input                        clk_in,
    input                        rst_in,
    output                       mclk,     // global clock, half DDR3 clock, synchronizes all I/O thorough the command port
// command port 0 (filled by software - 32w->64r) - used for mode set, refresh, write levelling, ...
    input                        cmd0_we,
    input                [9:0]   cmd0_addr,
    input               [31:0]   cmd0_data,
// TODO: add automatic command port1 , filled by the PL, 36w 36r, used for actual page R/W
    input                        cmd1_we,
    input                [9:0]   cmd1_addr,
    input               [35:0]   cmd1_data,
// Controller run interface, posedge mclk
    input               [10:0]   run_addr, // controller sequencer start address (0..11'h1ff - cmd0, 11'h400..11'h7ff - cmd1)
    input                [3:0]   run_chn,  // data channel to use
    input                        run_seq,  // start controller sequence 
    output                       run_done, // controller sequence finished   
// inteface to control I/O delays and mmcm
    input                  [7:0] dly_data, // delay value (3 LSB - fine delay)
    input                  [6:0] dly_addr, // select which delay to program
    input                        ld_delay, // load delay data to selected iodelayl (clk_div synchronous)
    input                        set,       // clk_div synchronous set all delays from previously loaded values
    output                       locked,
    output                       ps_rdy,
    output     [PHASE_WIDTH-1:0] ps_out, 
// read port 0
    input                        port0_clk,
    input                        port0_re,
    input                        port0_regen, 
    input                [1:0]   port0_page,
    input                [1:0]   port0_int_page,
    input                [7:0]   port0_addr,
    output              [31:0]   port0_data,
// write port 1
    input                        port1_clk,
    input                        port1_we,
    input                [1:0]   port1_page,
    input                [1:0]   port1_int_page,
    input                [7:0]   port1_addr,
    input               [31:0]   port1_data,
    // extras
    input                        cmda_tri, // tristate command and address lines // not likely to be used
    input                        inv_clk_div,
    input                 [7:0]  dqs_pattern, // 8'h55
    input                 [7:0]  dqm_pattern  // 8'h00
    
);
    localparam ADDRESS_NUMBER = 15;
    
    wire                 [35:0]  phy_cmd; // input[35:0] 
    wire                  [6:0]  buf_addr; // output[6:0] 
    wire                 [63:0]  buf_wdata; // output[63:0] 
    wire                 [63:0]  buf_rdata; // input[63:0] 
    wire                         buf_wr; // output
    wire                         buf_rd; // output
    
    
    phy_cmd #(
        .ADDRESS_NUMBER        (ADDRESS_NUMBER),
        .PHASE_WIDTH           (PHASE_WIDTH),
        .SLEW_DQ               (SLEW_DQ),
        .SLEW_DQS              (SLEW_DQS),
        .SLEW_CMDA             (SLEW_CMDA),
        .SLEW_CLK              (SLEW_CLK),
        .IBUF_LOW_PWR          (IBUF_LOW_PWR),
        .REFCLK_FREQUENCY      (REFCLK_FREQUENCY),
        .HIGH_PERFORMANCE_MODE (HIGH_PERFORMANCE_MODE),
        .CLKIN_PERIOD          (CLKIN_PERIOD),
        .CLKFBOUT_MULT         (CLKFBOUT_MULT),
        .CLKFBOUT_MULT_REF     (CLKFBOUT_MULT_REF),
        .CLKFBOUT_DIV_REF      (CLKFBOUT_DIV_REF),
        .DIVCLK_DIVIDE         (DIVCLK_DIVIDE),
        .CLKFBOUT_PHASE        (CLKFBOUT_PHASE),
        .ICLK_PHASE            (ICLK_PHASE),
        .CLK_PHASE             (CLK_PHASE),
        .CLK_DIV_PHASE         (CLK_DIV_PHASE),
        .MCLK_PHASE            (MCLK_PHASE),
        .REF_JITTER1           (REF_JITTER1),
        .SS_EN                 (SS_EN),
        .SS_MODE               (SS_MODE),
        .SS_MOD_PERIOD         (SS_MOD_PERIOD)
    ) phy_cmd_i (
        .SDCLK               (SDCLK), // output
        .SDNCLK              (SDNCLK), // output
        .SDA                 (SDA[ADDRESS_NUMBER-1:0]), // output[14:0] 
        .SDBA                (SDBA[2:0]), // output[2:0] 
        .SDWE                (SDWE), // output
        .SDRAS               (SDRAS), // output
        .SDCAS               (SDCAS), // output
        .SDCKE               (SDCKE), // output
        .SDODT               (SDODT), // output
        .SDD                 (SDD[15:0]), // inout[15:0] 
        .SDDML               (SDDML), // inout
        .DQSL                (DQSL), // inout
        .NDQSL               (NDQSL), // inout
        .SDDMU               (SDDMU), // inout
        .DQSU                (DQSU), // inout
        .NDQSU               (NDQSU), // inout
        .clk_in              (clk_in), // input
        .rst_in              (rst_in), // input
        .mclk                (mclk), // output
        .dly_data            (dly_data[7:0]), // input[7:0] 
        .dly_addr            (dly_addr[6:0]), // input[6:0] 
        .ld_delay            (ld_delay), // input
        .set                 (set), // input
        .locked              (locked), // output
        .ps_rdy              (ps_rdy), // output
        .ps_out              (ps_out[7:0]), // output[7:0] 
        .phy_cmd             (phy_cmd[35:0]), // input[35:0] 
        .buf_addr            (buf_addr[6:0]), // output[6:0] 
        .buf_wdata           (buf_wdata[63:0]), // output[63:0] 
        .buf_rdata           (buf_rdata[63:0]), // input[63:0] 
        .buf_wr              (buf_wr), // output
        .buf_rd              (buf_rd), // output
        .cmda_tri            (cmda_tri), // input
        .inv_clk_div         (inv_clk_div), // input
        .dqs_pattern         (dqs_pattern), // input[7:0] 
        .dqm_pattern         (dqm_pattern) // input[7:0] 
    );



endmodule

