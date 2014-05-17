/*******************************************************************************
 * Module: test_phy_top_01
 * Date:2014-05-14  
 * Author: Andrey Filippov
 * Description: minimal instance of phy_top to test synthesis
 *
 * Copyright (c) 2014 Elphel, Inc.
 * test_phy_top_01.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  test_phy_top_01.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  test_phy_top_01#(
    parameter ADDRESS_NUMBER =      15,
    parameter SLEW_DQ =             "SLOW",
    parameter SLEW_DQS =            "SLOW",
    parameter SLEW_CMDA =           "SLOW",
    parameter SLEW_CLK =            "SLOW",
    parameter IBUF_LOW_PWR =        "TRUE",
    parameter IODELAY_GRP =         "IODELAY_MEMORY",
    parameter real REFCLK_FREQUENCY = 300.0,
    parameter HIGH_PERFORMANCE_MODE = "FALSE",
    parameter CLKFBOUT_PHASE =      0.000,
    parameter ICLK_PHASE =          0.000,
    parameter CLK_PHASE =           0.000,
    parameter CLK_DIV_PHASE =       0.000,
    parameter MCLK_PHASE =          0.000,
    parameter CLKIN_PERIOD          = 10, //ns >1.25, 600<Fvco<1200
    parameter CLKFBOUT_MULT =       8, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE
    parameter CLKFBOUT_MULT_REF =   9, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE
    parameter CLKFBOUT_DIV_REF =    3, // To get 300MHz for the reference clock
    parameter DIVCLK_DIVIDE=        1,
    parameter REF_JITTER1 =         0.010,
    parameter SS_EN =              "FALSE",
    parameter SS_MODE =      "CENTER_HIGH",
    parameter SS_MOD_PERIOD =       10000
      
    )
(
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
    
    input                        clk_in,   // master input clock, initially assuming 100MHz
    input                        rst_in,      // reset delays/serdes\
    input                        fake_din,
    input                        fake_en,
    input                        fake_oe,
    output                       fake_dout
);
// SuppressWarnings VEditor 
  (* keep = "true" *) wire clk; // output
// SuppressWarnings VEditor 
  (* keep = "true" *) wire clk_div; // output
// SuppressWarnings VEditor 
  (* keep = "true" *) wire mclk; // output
// SuppressWarnings VEditor 
  (* keep = "true" *) wire [63:0] dout; // output[63:0] 
// SuppressWarnings VEditor 
  (* keep = "true" *) wire locked; // output
// SuppressWarnings VEditor 
  (* keep = "true" *) wire ps_rdy; // output
// SuppressWarnings VEditor 
  (* keep = "true" *) wire [7:0]ps_out;// output[7:0] 
    reg [2*ADDRESS_NUMBER-1:0] in_a;     // input address, 2 bits per signal (first, second) (29:0) for 4Gb device
    reg                  [5:0] in_ba;    // input bank address, 2 bits per signal (first, second)
    reg                  [1:0] in_we;    // input WE, 2 bits (first, second)
    reg                  [1:0] in_ras;   // input RAS, 2 bits (first, second)
    reg                  [1:0] in_cas;   // input CAS, 2 bits (first, second)
    reg                  [1:0] in_cke;   // input CKE, 2 bits (first, second)
    reg                  [1:0] in_odt;   // input ODT, 2 bits (first, second)
//    reg                  [1:0] in_tri;   // tristate command/address outputs - same timing, but no odelay
    reg                        in_tri;   // tristate command/address outputs - same timing, but no odelay
    reg                 [63:0] din;             // parallel data to be sent out (4 bits per DG I/))
    reg                  [7:0] din_dm;          // parallel data to be sent out over DM
    reg                  [7:0] tin_dq;          // tristate for data out (sent out earlier than data!) and dm 
    reg                  [7:0] din_dqs;         // parallel data to be sent out over DQS
    reg                  [7:0] tin_dqs;         // tristate for DQS out (sent out earlier than data!) 
    reg                        inv_clk_div;     // invert clk_div for R channels (clk_div is shared between R and W)
    reg                        dci_disable_dqs; // disable DCI termination during writes and idle for dqs
    reg                        dci_disable_dq;  // disable DCI termination during writes and idle for dq and dm signals
    reg                  [7:0] dly_data; // delay value (3 LSB - fine delay)
    reg                  [6:0] dly_addr; // select which delay to program
    reg                        ld_delay; // load delay data to selected iodelayl (clk_div synchronous)
    reg                        set;       // clk_div synchronous set all delays from previously loaded values
    
    reg                 [63:0] dout_r;
    reg                        locked_r;
    reg                 [ 7:0] ps_out_r;
    
// Create fake data sources for all input
    assign  fake_dout= locked_r;
    always @ (posedge mclk) begin
        if (!fake_oe) begin
            dout_r <= dout;
            locked_r <=locked;
            ps_out_r <=ps_out;
        end else if (fake_en) begin
            {locked_r,dout_r,ps_out_r} <= {dout_r,ps_out_r,1'b0}; 
        end 
    
        if (fake_en)
      {
        in_a,
        in_ba,
        in_we,
        in_ras,
        in_cas,
        in_cke,
        in_odt,
        in_tri,
        din,
        din_dm,
        tin_dq,
        din_dqs,
        tin_dqs,
        inv_clk_div,
        dci_disable_dqs,
        dci_disable_dq,
        dly_data,
        dly_addr,
        ld_delay,
        set
      } <= {
        fake_din,
        in_a,
        in_ba,
        in_we,
        in_ras,
        in_cas,
        in_cke,
        in_odt,
        in_tri,
        din,
        din_dm,
        tin_dq,
        din_dqs,
        tin_dqs,
        inv_clk_div,
        dci_disable_dqs,
        dci_disable_dq,
        dly_data,
        dly_addr,
        ld_delay
      };
    end

    phy_top #(
        .IOSTANDARD_DQ           ("SSTL15_T_DCI"),
        .IOSTANDARD_DQS          ("DIFF_SSTL15_T_DCI"),
        .IOSTANDARD_CMDA         ("SSTL15"),
        .IOSTANDARD_CLK          ("DIFF_SSTL15"),
        .SLEW_DQ               (SLEW_DQ),
        .SLEW_DQS              (SLEW_DQS),
        .SLEW_CMDA             (SLEW_CMDA),
        .SLEW_CLK              (SLEW_CLK),
        .IBUF_LOW_PWR          (IBUF_LOW_PWR),
        .IODELAY_GRP           (IODELAY_GRP),
        .REFCLK_FREQUENCY      (REFCLK_FREQUENCY),
        .HIGH_PERFORMANCE_MODE (HIGH_PERFORMANCE_MODE),
        .ADDRESS_NUMBER        (ADDRESS_NUMBER),
        .PHASE_WIDTH             (8),
        .BANDWIDTH               ("OPTIMIZED"),
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
    ) phy_top_i (
        .ddr3_clk           (SDCLK), // output
        .ddr3_nclk          (SDNCLK), // output
        .ddr3_a             (SDA[14:0]), // output[14:0] 
        .ddr3_ba            (SDBA[2:0]), // output[2:0] 
        .ddr3_we            (SDWE), // output
        .ddr3_ras           (SDRAS), // output
        .ddr3_cas           (SDCAS), // output
        .ddr3_cke           (SDCKE), // output
        .ddr3_odt           (SDODT), // output
        .dq                 (SDD[15:0]), // inout[15:0] 
        .dml                (SDDML), // inout
        .dqsl               (DQSL), // inout
        .ndqsl              (NDQSL), // inout
        .dmu                (SDDMU), // inout
        .dqsu               (DQSU), // inout
        .ndqsu              (NDQSU), // inout
        
        .clk_in             (clk_in), // input
        .clk                (clk), // output
        .clk_div            (clk_div), // output
        .mclk               (mclk), // output
        .rst_in             (rst_in), // input
        .in_a            (in_a), // input[29:0] 
        .in_ba           (in_ba), // input[5:0] 
        .in_we           (in_we), // input[1:0] 
        .in_ras          (in_ras), // input[1:0] 
        .in_cas          (in_cas), // input[1:0] 
        .in_cke          (in_cke), // input[1:0] 
        .in_odt          (in_odt), // input[1:0] 
        .in_tri          (in_tri), // input[1:0] 
        .din             (din), // input[63:0] 
        .din_dm          (din_dm), // input[7:0] 
        .tin_dq          (tin_dq), // input[7:0] 
        .din_dqs         (din_dqs), // input[7:0] 
        .tin_dqs         (tin_dqs), // input[7:0] 
        .dout               (dout[63:0]), // output[63:0] 
        .inv_clk_div     (inv_clk_div), // input
        .dci_disable_dqs (dci_disable_dqs), // input
        .dci_disable_dq  (dci_disable_dq), // input
        .dly_data        (dly_data), // input[7:0] 
        .dly_addr        (dly_addr), // input[6:0] 
        .ld_delay        (ld_delay), // input
        .set             (set), // input
        .locked             (locked), // output
        .ps_rdy             (ps_rdy), // output
        .ps_out             (ps_out[7:0]) // output[7:0] 
    );

endmodule

