/*******************************************************************************
 * Module: phy_top
 * Date:2014-04-30  
 * Author: Andrey Filippov
 * Description: Top module of the DDR3 phy
 *
 * Copyright (c) 2014 Elphel, Inc.
 * phy_top.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  phy_top.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  phy_top #(
    parameter IOSTANDARD_DQ =   "SSTL15_T_DCI",
    parameter IOSTANDARD_DQS =  "DIFF_SSTL15_T_DCI",
    parameter IOSTANDARD_CMDA = "SSTL15",
    parameter SLEW_DQ =         "SLOW",
    parameter SLEW_DQS =        "SLOW",
    parameter SLEW_CMDA =       "SLOW",
    parameter IBUF_LOW_PWR =    "TRUE",
    parameter IODELAY_GRP =     "IODELAY_MEMORY",
    parameter real REFCLK_FREQUENCY = 300.0,
    parameter HIGH_PERFORMANCE_MODE = "FALSE",
    parameter integer ADDRESS_NUMBER= 15
)(
    output  [ADDRESS_NUMBER-1:0] ddr3_a,   // output address ports (14:0) for 4Gb device
    output                 [2:0]ddr3_ba,  // output bank address ports
    output                       ddr3_we,  // output WE port
    output                       ddr3_ras, // output RAS port
    output                       ddr3_cas, // output CAS port
    output                       ddr3_cke, // output Clock Enable port
    output                       ddr3_odt, // output ODT port

    inout                 [15:0] dq,       // DQ  I/O pads
    inout                        dml,      // LDM  I/O pad (actually only output)
    inout                        dqsl,     // LDQS I/O pad
    inout                        ndqsl,    // ~LDQS I/O pad
    inout                        dmu,      // UDM  I/O pad (actually only output)
    inout                        dqsu,     // UDQS I/O pad
    inout                        ndqsu,    // ~UDQS I/O pad
    
    input                        clk,      // free-running system clock, same frequency as iclk (shared for R/W)
    input                        clk_div,  // free-running half clk frequency, front aligned to clk (shared for R/W)
    input                        rst_in,      // reset delays/serdes
    
    input [2*ADDRESS_NUMBER-1:0] in_a,     // input address, 2 bits per signal (first, second) (29:0) for 4Gb device
    input                  [5:0] in_ba,    // input bank address, 2 bits per signal (first, second)
    input                  [1:0] in_we,    // input WE, 2 bits (first, second)
    input                  [1:0] in_ras,   // input RAS, 2 bits (first, second)
    input                  [1:0] in_cas,   // input CAS, 2 bits (first, second)
    input                  [1:0] in_cke,   // input CKE, 2 bits (first, second)
    input                  [1:0] in_odt,   // input ODT, 2 bits (first, second)
    input                  [1:0] in_tri,   // tristate command/address outputs - same timing, but no odelay
    
    input                 [63:0] din,             // parallel data to be sent out (4 bits per DG I/))
    input                  [7:0] din_dm,          // parallel data to be sent out over DM
    input                  [7:0] tin_dq,          // tristate for data out (sent out earlier than data!) and dm 
    input                  [7:0] din_dqs,         // parallel data to be sent out over DQS
    input                  [7:0] tin_dqs,         // tristate for DQS out (sent out earlier than data!) 
    output                [63:0] dout,            // parallel data received from DDR3 memory, 4 bits per DQ I/O
    
    
    input                        inv_clk_div,     // invert clk_div for R channels (clk_div is shared between R and W)
    input                        dci_disable_dqs, // disable DCI termination during writes and idle for dqs
    input                        dci_disable_dq,  // disable DCI termination during writes and idle for dq and dm signals
    
    input                  [7:0] dly_data, // delay value (3 LSB - fine delay)
    input                  [6:0] dly_addr, // select which delay to program
    input                        ld_delay, // load delay data to selected iodelayl (clk_iv synchronous)
    input                        set       // clk_div synchronous set all delays from previously loaded values
);
  reg rst=1'b0;
  always @(posedge clk or posedge rst_in) begin
    if (rst_in) rst <= 1'b1;
    else        rst <= 1'b0;
  end
  wire  ld_data_l = (dly_addr[6:5] == 2'h0) && ld_delay ;             
  wire  ld_data_h = (dly_addr[6:5] == 2'h1) && ld_delay ;             
  wire  ld_cmda =   (dly_addr[6:5] == 2'h2) && ld_delay ;             
  
  cmd_addr #(
    .IODELAY_GRP(IODELAY_GRP),
    .IOSTANDARD(IOSTANDARD_CMDA),
    .SLEW(SLEW_CMDA),
    .REFCLK_FREQUENCY(REFCLK_FREQUENCY),
    .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE),
    .ADDRESS_NUMBER(ADDRESS_NUMBER)
  ) cmd_addr_i(
    .ddr3_a   (ddr3_a[ADDRESS_NUMBER-1:0]), // output address ports (14:0) for 4Gb device
    .ddr3_ba  (ddr3_ba[2:0]),             // output bank address ports
    .ddr3_we  (ddr3_we),                 // output WE port
    .ddr3_ras (ddr3_ras),                // output RAS port
    .ddr3_cas (ddr3_cas),                // output CAS port
    .ddr3_cke (ddr3_cke),                // output Clock Enable port
    .ddr3_odt (ddr3_odt),                // output ODT port
    .clk      (clk),                     // free-running system clock, same frequency as iclk (shared for R/W)
    .clk_div  (clk_div),                 // free-running half clk frequency, front aligned to clk (shared for R/W)
    .rst      (rst),                     // reset delays/serdes
    .in_a     (in_a[2*ADDRESS_NUMBER-1:0]), // input address, 2 bits per signal (first, second) (29:0) for 4Gb device
    .in_ba    (in_ba[5:0]),              // input bank address, 2 bits per signal (first, second)
    .in_we    (in_we[1:0]),              // input WE, 2 bits (first, second)
    .in_ras   (in_ras[1:0]),             // input RAS, 2 bits (first, second)
    .in_cas   (in_cas[1:0]),             // input CAS, 2 bits (first, second)
    .in_cke   (in_cke[1:0]),             // input CKE, 2 bits (first, second)
    .in_odt   (in_odt[1:0]),             // input ODT, 2 bits (first, second)
    .in_tri   (in_tri[1:0]),             // tristate command/address outputs - same timing, but no odelay
    .dly_data (dly_data[7:0]),           // delay value (3 LSB - fine delay)
    .dly_addr (dly_addr[4:0]),           // select which delay to program
    .ld_delay (ld_cmda),               // load delay data to selected iodelayl (clk_iv synchronous)
    .set      (set)                      // clk_div synchronous set all delays from previously loaded values
);

  byte_lane #(
    .IODELAY_GRP     (IODELAY_GRP),
    .IBUF_LOW_PWR    (IBUF_LOW_PWR),
    .IOSTANDARD_DQ   (IOSTANDARD_DQ),
    .IOSTANDARD_DQS  (IOSTANDARD_DQS),
    .SLEW_DQ         (SLEW_DQ),
    .SLEW_DQS        (SLEW_DQS),
    .REFCLK_FREQUENCY(REFCLK_FREQUENCY),
    .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE)
  ) byte_lane0_i (
    .dq              (dq[7:0]),          // DQ  I/O pads
    .dm              (dml),              // DM  I/O pad (actually only output)
    .dqs             (dqsl),             //  DQS I/O pad
    .ndqs            (ndqsl),            // ~DQS I/O pad
    .clk             (clk),              // free-running system clock, same frequency as iclk (shared for R/W)
    .clk_div         (clk_div),          // free-running half clk frequency, front aligned to clk (shared for R/W)
    .inv_clk_div     (inv_clk_div),      // invert clk_div for R channels (clk_div is shared between R and W)
    .rst             (rst),
    .dci_disable_dqs (dci_disable_dqs),  // disable DCI termination during writes and idle for dqs
    .dci_disable_dq  (dci_disable_dq),   // disable DCI termination during writes and idle for dq and dm signals
    .din             (din[31:0]),        // parallel data to be sent out (4 bits per DG I/))
    .din_dm          (din_dm[3:0]),      // parallel data to be sent out over DM
    .tin_dq          (tin_dq[3:0]),      // tristate for data out (sent out earlier than data!) and dm 
    .din_dqs         (din_dqs[3:0]),     // parallel data to be sent out over DQS
    .tin_dqs         (tin_dqs[3:0]),     // tristate for DQS out (sent out earlier than data!) 
    .dout            (dout[31:0]),       // parallel data received from DDR3 memory, 4 bits per DQ I/O
    .dly_data        (dly_data[7:0]),    // delay value (3 LSB - fine delay)
    .dly_addr        (dly_addr[4:0]),    // select which delay to program
    .ld_delay        (ld_data_l),        // load delay data to selected iodelayl (clk_iv synchronous)
    .set             (set)               // clk_div synchronous set all delays from previously loaded values
);

  byte_lane #(
    .IODELAY_GRP     (IODELAY_GRP),
    .IBUF_LOW_PWR    (IBUF_LOW_PWR),
    .IOSTANDARD_DQ   (IOSTANDARD_DQ),
    .IOSTANDARD_DQS  (IOSTANDARD_DQS),
    .SLEW_DQ         (SLEW_DQ),
    .SLEW_DQS        (SLEW_DQS),
    .REFCLK_FREQUENCY(REFCLK_FREQUENCY),
    .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE)
  ) byte_lane1_i (
    .dq              (dq[15:8]),         // DQ  I/O pads
    .dm              (dmu),              // DM  I/O pad (actually only output)
    .dqs             (dqsu),             //  DQS I/O pad
    .ndqs            (ndqsu),            // ~DQS I/O pad
    .clk             (clk),              // free-running system clock, same frequency as iclk (shared for R/W)
    .clk_div         (clk_div),          // free-running half clk frequency, front aligned to clk (shared for R/W)
    .inv_clk_div     (inv_clk_div),      // invert clk_div for R channels (clk_div is shared between R and W)
    .rst             (rst),
    .dci_disable_dqs (dci_disable_dqs),  // disable DCI termination during writes and idle for dqs
    .dci_disable_dq  (dci_disable_dq),   // disable DCI termination during writes and idle for dq and dm signals
    .din             (din[63:32]),       // parallel data to be sent out (4 bits per DG I/))
    .din_dm          (din_dm[7:4]),      // parallel data to be sent out over DM
    .tin_dq          (tin_dq[7:4]),      // tristate for data out (sent out earlier than data!) and dm 
    .din_dqs         (din_dqs[7:4]),     // parallel data to be sent out over DQS
    .tin_dqs         (tin_dqs[7:4]),     // tristate for DQS out (sent out earlier than data!) 
    .dout            (dout[63:32]),      // parallel data received from DDR3 memory, 4 bits per DQ I/O
    .dly_data        (dly_data[7:0]),    // delay value (3 LSB - fine delay)
    .dly_addr        (dly_addr[4:0]),    // select which delay to program
    .ld_delay        (ld_data_h),        // load delay data to selected iodelayl (clk_iv synchronous)
    .set             (set)               // clk_div synchronous set all delays from previously loaded values
);

endmodule

