/*******************************************************************************
 * Module: ddrc_test01_testbench
 * Date:2014-05-20  
 * Author: Andrey Filippov
 * Description: testbench for ddrc_test01
 *
 * Copyright (c) 2014 Elphel, Inc.
 * ddrc_test01_testbench.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  ddrc_test01_testbench.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  ddrc_test01_testbench #(
    parameter PHASE_WIDTH =     8,
    parameter SLEW_DQ =         "SLOW",
    parameter SLEW_DQS =        "SLOW",
    parameter SLEW_CMDA =       "SLOW",
    parameter SLEW_CLK =        "SLOW",
    parameter IBUF_LOW_PWR =    "TRUE",
    parameter real REFCLK_FREQUENCY = 300.0,
    parameter HIGH_PERFORMANCE_MODE = "FALSE",
    parameter CLKIN_PERIOD          = 10, //ns >1.25, 600<Fvco<1200 // Hardware 150MHz , change to             | 6.667
    parameter CLKFBOUT_MULT =       8, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE  | 16
    parameter CLKFBOUT_MULT_REF =   9, // Fvco=Fclkin*CLKFBOUT_MULT_F/DIVCLK_DIVIDE, Fout=Fvco/CLKOUT#_DIVIDE  | 6
    parameter CLKFBOUT_DIV_REF =    3, // To get 300MHz for the reference clock
    parameter DIVCLK_DIVIDE=        1, //                                                                      | 3
    parameter CLKFBOUT_PHASE =      0.000,
    parameter SDCLK_PHASE =         0.000,
    parameter CLK_PHASE =           0.000,
    parameter CLK_DIV_PHASE =       0.000,
    parameter MCLK_PHASE =          90.000,
    parameter REF_JITTER1 =         0.010,
    parameter SS_EN =              "FALSE",
    parameter SS_MODE =      "CENTER_HIGH",
    parameter SS_MOD_PERIOD =       10000,
    parameter CMD_PAUSE_BITS=       6,
    parameter CMD_DONE_BIT=         6,
    parameter AXI_WR_ADDR_BITS =   13,
    parameter AXI_RD_ADDR_BITS =   13,
    parameter CONTROL_ADDR =        'h1000, // AXI write address of control write registers
    parameter CONTROL_ADDR_MASK =   'h1400, // AXI write address of control registers
    parameter STATUS_ADDR =         'h1400, // AXI write address of status read registers
    parameter STATUS_ADDR_MASK =    'h1400, // AXI write address of status registers
    parameter BUSY_WR_ADDR =        'h1800, // AXI write address to generate busy
    parameter BUSY_WR_ADDR_MASK =   'h1c00, // AXI write address mask to generate busy
    parameter CMD0_ADDR =           'h0800, // AXI write to command sequence memory
    parameter CMD0_ADDR_MASK =      'h1800, // AXI read address mask for the command sequence memory
    parameter PORT0_RD_ADDR =       'h0000, // AXI read address to generate busy
    parameter PORT0_RD_ADDR_MASK =  'h1c00, // AXI read address mask to generate busy
    parameter PORT1_WR_ADDR =       'h0400, // AXI read address to generate busy
    parameter PORT1_WR_ADDR_MASK =  'h1c00,  // AXI read address mask to generate busy
    // relative address parameters below to be ORed with CONTROL_ADDR and CONTROL_ADDR_MASK respectively
    parameter DLY_LD_REL =          'h080,  // address to generate delay load
    parameter DLY_LD_REL_MASK =     'h380,  // address mask to generate delay load
    parameter DLY_SET_REL =         'h070,  // address to generate delay set
    parameter DLY_SET_REL_MASK =    'h3ff,  // address mask to generate delay set
    parameter RUN_CHN_REL =         'h000,  // address to set sequnecer channel and  run (4 LSB-s - channel)
    parameter RUN_CHN_REL_MASK =    'h3f0,  // address mask to generate sequencer channel/run
    parameter PATTERNS_REL =        'h020,  // address to set DQM and DQS patterns (16'h0055)
    parameter PATTERNS_REL_MASK =   'h3ff,  // address mask to set DQM and DQS patterns
    parameter PAGES_REL =           'h021,  // address to set buffer pages {port1_page[1:0],port1_int_page[1:0],port0_page[1:0],port0_int_page[1:0]}
    parameter PAGES_REL_MASK =      'h3ff,  // address mask to set DQM and DQS patterns
    parameter CMDA_EN_REL =         'h022,  // address to enable('h823)/disable('h822) command/address outputs  
    parameter CMDA_EN_REL_MASK =    'h3fe,  // address mask for command/address outputs
    parameter EXTRA_REL =           'h024,  // address to set extra parameters (currently just inv_clk_div)
    parameter EXTRA_REL_MASK =      'h3ff,   // address mask for extra parameters
    
    // simulation-specific parameters
    parameter integer AXI_RDADDR_LATENCY=2,
    parameter integer AXI_WRADDR_LATENCY=4,
    parameter integer AXI_WRDATA_LATENCY=1,
    parameter integer AXI_TASK_HOLD=1.0 
)();
`ifdef IVERILOG              
//    $display("IVERILOG is defined");
    `include "IVERILOG_INCLUDE.v"
`else
//    $display("IVERILOG is not defined");
    parameter lxtname = "x393.lxt";
`endif
`define DEBUG_WR_SINGLE 1  
  // DDR3 signals
  wire        SDCLK;  // output
  wire        SDNCLK; // output
  wire [14:0] SDA;    // output[14:0] 
  wire [ 2:0] SDBA;   // output[2:0] 
  wire        SDWE;   // output
  wire        SDRAS;  // output
  wire        SDCAS;  // output
  wire        SDCKE;  // output
  wire        SDODT;  // output
  wire [15:0] SDD;    // inout[15:0] 
  wire        SDDML;  // inout
  wire        DQSL;   // inout
  wire        NDQSL;  // inout
  wire        SDDMU;  // inout
  wire        DQSU;   // inout
  wire        NDQSU;  // inout
  
  
  // Simulation signals
  reg [11:0] ARID_IN_r;
  reg [31:0] ARADDR_IN_r;
  reg  [3:0] ARLEN_IN_r;
  reg  [2:0] ARSIZE_IN_r;
  reg  [1:0] ARBURST_IN_r;
  reg [11:0] AWID_IN_r;
  reg [31:0] AWADDR_IN_r;
  reg  [3:0] AWLEN_IN_r;
  reg  [2:0] AWSIZE_IN_r;
  reg  [1:0] AWBURST_IN_r;

  reg [11:0] WID_IN_r;
  reg [31:0] WDATA_IN_r;
  reg [ 3:0] WSTRB_IN_r;
  reg        WLAST_IN_r;

  wire [ 9:0] SIMUL_AXI_ADDR_W; 
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire        SIMUL_AXI_MISMATCH;
  reg  [31:0] SIMUL_AXI_READ;
  reg  [ 9:0] SIMUL_AXI_ADDR;
  reg         SIMUL_AXI_FULL; // some data available



  reg        CLK;
  reg        RST;
  reg        AR_SET_CMD_r;
  wire       AR_READY;

  reg        AW_SET_CMD_r;
  wire       AW_READY;

  reg        W_SET_CMD_r;
  wire       W_READY;

  wire [11:0]  #(AXI_TASK_HOLD) ARID_IN = ARID_IN_r;
  wire [31:0]  #(AXI_TASK_HOLD) ARADDR_IN = ARADDR_IN_r;
  wire  [3:0]  #(AXI_TASK_HOLD) ARLEN_IN = ARLEN_IN_r;
  wire  [2:0]  #(AXI_TASK_HOLD) ARSIZE_IN = ARSIZE_IN_r;
  wire  [1:0]  #(AXI_TASK_HOLD) ARBURST_IN = ARBURST_IN_r;
  wire [11:0]  #(AXI_TASK_HOLD) AWID_IN = AWID_IN_r;
  wire [31:0]  #(AXI_TASK_HOLD) AWADDR_IN = AWADDR_IN_r;
  wire  [3:0]  #(AXI_TASK_HOLD) AWLEN_IN = AWLEN_IN_r;
  wire  [2:0]  #(AXI_TASK_HOLD) AWSIZE_IN = AWSIZE_IN_r;
  wire  [1:0]  #(AXI_TASK_HOLD) AWBURST_IN = AWBURST_IN_r;
  wire [11:0]  #(AXI_TASK_HOLD) WID_IN = WID_IN_r;
  wire [31:0]  #(AXI_TASK_HOLD) WDATA_IN = WDATA_IN_r;
  wire [ 3:0]  #(AXI_TASK_HOLD) WSTRB_IN = WSTRB_IN_r;
  wire         #(AXI_TASK_HOLD) WLAST_IN = WLAST_IN_r;
  wire         #(AXI_TASK_HOLD) AR_SET_CMD = AR_SET_CMD_r;
  wire         #(AXI_TASK_HOLD) AW_SET_CMD = AW_SET_CMD_r;
  wire         #(AXI_TASK_HOLD) W_SET_CMD =  W_SET_CMD_r;

  reg  [3:0] RD_LAG;  // ready signal lag in axi read channel (0 - RDY=1, 1..15 - RDY is asserted N cycles after valid)   
  reg  [3:0] B_LAG;   // ready signal lag in axi arete response channel (0 - RDY=1, 1..15 - RDY is asserted N cycles after valid)   

// Simulation modules interconnection
  wire [11:0] arid;
  wire [31:0] araddr;
  wire [3:0]  arlen;
  wire [2:0]  arsize;
  wire [1:0]  arburst;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [3:0]  arcache;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [2:0]  arprot;
  wire        arvalid;
  wire        arready;

  wire [11:0] awid;
  wire [31:0] awaddr;
  wire [3:0]  awlen;
  wire [2:0]  awsize;
  wire [1:0]  awburst;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [3:0]  awcache;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [2:0]  awprot;
  wire        awvalid;
  wire        awready;

  wire [11:0] wid;
  wire [31:0] wdata;
  wire [3:0]  wstrb;
  wire        wlast;
  wire        wvalid;
  wire        wready;
  
  wire [31:0] rdata;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [11:0] rid;
  wire        rlast;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire  [1:0] rresp;
  wire        rvalid;
  wire        rready;
  wire        rstb=rvalid && rready;

  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire  [1:0] bresp;
  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [11:0] bid;
  wire        bvalid;
  wire        bready;
  
always #(CLKIN_PERIOD/2) CLK <= ~CLK;

  initial begin
`ifdef IVERILOG              
    $display("IVERILOG is defined");
`else
    $display("IVERILOG is not defined");
`endif

`ifdef ICARUS              
    $display("ICARUS is defined");
`else
    $display("ICARUS is not defined");
`endif
  
    $dumpfile(lxtname);
  // SuppressWarnings VEditor : assigned in $readmem() system task
    $dumpvars(0,ddrc_test01_testbench);
    CLK <=1'b0;
    RST <= 1'b1;
    AR_SET_CMD_r <= 1'b0;
    AW_SET_CMD_r <= 1'b0;
    W_SET_CMD_r <= 1'b0;
    #100000; // same as glbl
    repeat (20) @(posedge CLK) ;
    RST <=1'b0;
    axi_set_b_lag(0); //(1);
    axi_set_rd_lag(0);
    axi_set_delays;
    // write memory
//    test_axi_1;
    // read memory
//    test_axi_2;
    repeat (512) @(posedge CLK) ;
    
#100;
    #10000;
    $display("finish testbench 1");
    $finish;
  end

// protect from never end
  initial begin
//  #10000000;
  #110000;
    $display("finish testbench 2");
  $finish;
  end



assign ddrc_test01_i.ps7_i.FCLKCLK=        {4{CLK}};
assign ddrc_test01_i.ps7_i.FCLKRESETN=     {4{~RST}};
// Read address
assign ddrc_test01_i.ps7_i.MAXIGP0ARADDR=  araddr;
assign ddrc_test01_i.ps7_i.MAXIGP0ARVALID= arvalid;
assign arready=                            ddrc_test01_i.ps7_i.MAXIGP0ARREADY;
assign ddrc_test01_i.ps7_i.MAXIGP0ARID=    arid; 
assign ddrc_test01_i.ps7_i.MAXIGP0ARLEN=   arlen;
assign ddrc_test01_i.ps7_i.MAXIGP0ARSIZE=  arsize[1:0]; // arsize[2] is not used
assign ddrc_test01_i.ps7_i.MAXIGP0ARBURST= arburst;
// Read data
assign rdata=                              ddrc_test01_i.ps7_i.MAXIGP0RDATA; 
assign rvalid=                             ddrc_test01_i.ps7_i.MAXIGP0RVALID;
assign ddrc_test01_i.ps7_i.MAXIGP0RREADY=  rready;
assign rid=                                ddrc_test01_i.ps7_i.MAXIGP0RID;
assign rlast=                              ddrc_test01_i.ps7_i.MAXIGP0RLAST;
assign rresp=                              ddrc_test01_i.ps7_i.MAXIGP0RRESP;
// Write address
assign ddrc_test01_i.ps7_i.MAXIGP0AWADDR=  awaddr;
assign ddrc_test01_i.ps7_i.MAXIGP0AWVALID= awvalid;

assign awready=                            ddrc_test01_i.ps7_i.MAXIGP0AWREADY;

//assign awready= AWREADY_AAAA;
assign ddrc_test01_i.ps7_i.MAXIGP0AWID=awid;

      // SuppressWarnings VEditor all
//  wire [ 1:0] AWLOCK;
      // SuppressWarnings VEditor all
//  wire [ 3:0] AWCACHE;
      // SuppressWarnings VEditor all
//  wire [ 2:0] AWPROT;
assign ddrc_test01_i.ps7_i.MAXIGP0AWLEN=   awlen;
assign ddrc_test01_i.ps7_i.MAXIGP0AWSIZE=  awsize[1:0]; // awsize[2] is not used
assign ddrc_test01_i.ps7_i.MAXIGP0AWBURST= awburst;
      // SuppressWarnings VEditor all
//  wire [ 3:0] AWQOS;
// Write data
assign ddrc_test01_i.ps7_i.MAXIGP0WDATA=   wdata;
assign ddrc_test01_i.ps7_i.MAXIGP0WVALID=  wvalid;
assign wready=                             ddrc_test01_i.ps7_i.MAXIGP0WREADY;
assign ddrc_test01_i.ps7_i.MAXIGP0WID=     wid;
assign ddrc_test01_i.ps7_i.MAXIGP0WLAST=   wlast;
assign ddrc_test01_i.ps7_i.MAXIGP0WSTRB=   wstrb;
// Write responce
assign bvalid=                             ddrc_test01_i.ps7_i.MAXIGP0BVALID;
assign ddrc_test01_i.ps7_i.MAXIGP0BREADY=  bready;
assign bid=                                ddrc_test01_i.ps7_i.MAXIGP0BID;
assign bresp=                              ddrc_test01_i.ps7_i.MAXIGP0BRESP;
  
// Top module under test
    ddrc_test01 #(
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
        .SDCLK_PHASE           (SDCLK_PHASE),
        .CLK_PHASE             (CLK_PHASE),
        .CLK_DIV_PHASE         (CLK_DIV_PHASE),
        .MCLK_PHASE            (MCLK_PHASE),
        .REF_JITTER1           (REF_JITTER1),
        .SS_EN                 (SS_EN),
        .SS_MODE               (SS_MODE),
        .SS_MOD_PERIOD         (SS_MOD_PERIOD),
        .CMD_PAUSE_BITS        (CMD_PAUSE_BITS),
        .CMD_DONE_BIT          (CMD_DONE_BIT),
        .AXI_WR_ADDR_BITS      (AXI_WR_ADDR_BITS),
        .AXI_RD_ADDR_BITS      (AXI_RD_ADDR_BITS),
        .CONTROL_ADDR          (CONTROL_ADDR),
        .CONTROL_ADDR_MASK     (CONTROL_ADDR_MASK),
        .STATUS_ADDR           (STATUS_ADDR),
        .STATUS_ADDR_MASK      (STATUS_ADDR_MASK),
        .BUSY_WR_ADDR          (BUSY_WR_ADDR),
        .BUSY_WR_ADDR_MASK     (BUSY_WR_ADDR_MASK),
        .CMD0_ADDR             (CMD0_ADDR),
        .CMD0_ADDR_MASK        (CMD0_ADDR_MASK),
        .PORT0_RD_ADDR         (PORT0_RD_ADDR),
        .PORT0_RD_ADDR_MASK    (PORT0_RD_ADDR_MASK),
        .PORT1_WR_ADDR         (PORT1_WR_ADDR),
        .PORT1_WR_ADDR_MASK    (PORT1_WR_ADDR_MASK),
        .DLY_LD_REL            (DLY_LD_REL),
        .DLY_LD_REL_MASK       (DLY_LD_REL_MASK),
        .DLY_SET_REL           (DLY_SET_REL),
        .DLY_SET_REL_MASK      (DLY_SET_REL_MASK),
        .RUN_CHN_REL           (RUN_CHN_REL),
        .RUN_CHN_REL_MASK      (RUN_CHN_REL_MASK),
        .PATTERNS_REL          (PATTERNS_REL),
        .PATTERNS_REL_MASK     (PATTERNS_REL_MASK),
        .PAGES_REL             (PAGES_REL),
        .PAGES_REL_MASK        (PAGES_REL_MASK),
        .CMDA_EN_REL           (CMDA_EN_REL),
        .CMDA_EN_REL_MASK      (CMDA_EN_REL_MASK),
        .EXTRA_REL             (EXTRA_REL),
        .EXTRA_REL_MASK        (EXTRA_REL_MASK)
        
    ) ddrc_test01_i (
        .SDCLK   (SDCLK), // output
        .SDNCLK  (SDNCLK), // output
        .SDA     (SDA[14:0]), // output[14:0] 
        .SDBA    (SDBA[2:0]), // output[2:0] 
        .SDWE    (SDWE), // output
        .SDRAS   (SDRAS), // output
        .SDCAS   (SDCAS), // output
        .SDCKE   (SDCKE), // output
        .SDODT   (SDODT), // output
        .SDD     (SDD[15:0]), // inout[15:0] 
        .SDDML   (SDDML), // inout
        .DQSL    (DQSL), // inout
        .NDQSL   (NDQSL), // inout
        .SDDMU   (SDDMU), // inout
        .DQSU    (DQSU), // inout
        .NDQSU   (NDQSU) // inout
    );
    
    
// Simulation modules    
simul_axi_master_rdaddr
#(
  .ID_WIDTH(12),
  .ADDRESS_WIDTH(32),
  .LATENCY(AXI_RDADDR_LATENCY),          // minimal delay between inout and output ( 0 - next cycle)
  .DEPTH(8),            // maximal number of commands in FIFO
  .DATA_DELAY(3.5),
  .VALID_DELAY(4.0)
) simul_axi_master_rdaddr_i (
    .clk(CLK),
    .reset(RST),
    .arid_in(ARID_IN[11:0]),
    .araddr_in(ARADDR_IN[31:0]),
    .arlen_in(ARLEN_IN[3:0]),
    .arsize_in(ARSIZE_IN[2:0]),
    .arburst_in(ARBURST_IN[1:0]),
    .arcache_in(4'b0),
    .arprot_in(3'b0), //     .arprot_in(2'b0),
    .arid(arid[11:0]),
    .araddr(araddr[31:0]),
    .arlen(arlen[3:0]),
    .arsize(arsize[2:0]),
    .arburst(arburst[1:0]),
    .arcache(arcache[3:0]),
    .arprot(arprot[2:0]),
    .arvalid(arvalid),
    .arready(arready),
    .set_cmd(AR_SET_CMD),  // latch all other input data at posedge of clock
    .ready(AR_READY)     // command/data FIFO can accept command
);

simul_axi_master_wraddr
#(
  .ID_WIDTH(12),
  .ADDRESS_WIDTH(32),
  .LATENCY(AXI_WRADDR_LATENCY),          // minimal delay between inout and output ( 0 - next cycle)
  .DEPTH(8),            // maximal number of commands in FIFO
  .DATA_DELAY(3.5),
  .VALID_DELAY(4.0)
) simul_axi_master_wraddr_i (
    .clk(CLK),
    .reset(RST),
    .awid_in(AWID_IN[11:0]),
    .awaddr_in(AWADDR_IN[31:0]),
    .awlen_in(AWLEN_IN[3:0]),
    .awsize_in(AWSIZE_IN[2:0]),
    .awburst_in(AWBURST_IN[1:0]),
    .awcache_in(4'b0),
    .awprot_in(3'b0), //.awprot_in(2'b0),
    .awid(awid[11:0]),
    .awaddr(awaddr[31:0]),
    .awlen(awlen[3:0]),
    .awsize(awsize[2:0]),
    .awburst(awburst[1:0]),
    .awcache(awcache[3:0]),
    .awprot(awprot[2:0]),
    .awvalid(awvalid),
    .awready(awready),
    .set_cmd(AW_SET_CMD),  // latch all other input data at posedge of clock
    .ready(AW_READY)     // command/data FIFO can accept command
);

simul_axi_master_wdata
#(
  .ID_WIDTH(12),
  .DATA_WIDTH(32),
  .WSTB_WIDTH(4),
  .LATENCY(AXI_WRDATA_LATENCY),          // minimal delay between inout and output ( 0 - next cycle)
  .DEPTH(8),            // maximal number of commands in FIFO
  .DATA_DELAY(3.2),
  .VALID_DELAY(3.6)
) simul_axi_master_wdata_i (
    .clk(CLK),
    .reset(RST),
    .wid_in(WID_IN[11:0]),
    .wdata_in(WDATA_IN[31:0]),
    .wstrb_in(WSTRB_IN[3:0]),
    .wlast_in(WLAST_IN),
    .wid(wid[11:0]),
    .wdata(wdata[31:0]),
    .wstrb(wstrb[3:0]),
    .wlast(wlast),
    .wvalid(wvalid),
    .wready(wready),
    .set_cmd(W_SET_CMD),  // latch all other input data at posedge of clock
    .ready(W_READY)        // command/data FIFO can accept command
);

simul_axi_slow_ready simul_axi_slow_ready_read_i(
    .clk(CLK),
    .reset(RST), //input         reset,
    .delay(RD_LAG), //input  [3:0]  delay,
    .valid(rvalid), // input         valid,
    .ready(rready)  //output        ready
    );

simul_axi_slow_ready simul_axi_slow_ready_write_resp_i(
    .clk(CLK),
    .reset(RST), //input         reset,
    .delay(B_LAG), //input  [3:0]  delay,
    .valid(bvalid), // input         valid,
    .ready(bready)  //output        ready
    );

simul_axi_read simul_axi_read_i(
  .clk(CLK),
  .reset(RST),
  .last(rlast),
  .data_stb(rstb),
  .raddr(ARADDR_IN[11:2]), 
  .rlen(ARLEN_IN),
  .rcmd(AR_SET_CMD),
  .addr_out(SIMUL_AXI_ADDR_W),
  .burst(),     // burst in progress - just debug
  .err_out());  // data last does not match predicted or FIFO over/under run - just debug
    
    
    
// SuppressWarnings VEditor all - these variables are just for viewing, not used anywhere else
  reg DEBUG1, DEBUG2, DEBUG3;
  
//  Tasks
// top simulation tasks
// base addresses  
    localparam BASEADDR_PORT0_RD = PORT0_RD_ADDR << 2; // 'h0000  << 2
    localparam BASEADDR_PORT1_WR = PORT1_WR_ADDR << 2; // 'h0000 << 2 = 'h000
    localparam BASEADDR_CMD0 =     CMD0_ADDR << 2;     // 'h0800 << 2 = 'h2000
//    localparam BASEADDR_CTRL =     CONTROL_ADDR << 2;
    localparam BASEADDR_CTRL =     (CONTROL_ADDR | BUSY_WR_ADDR) << 2; // with busy
    localparam BASEADDR_STATUS =   STATUS_ADDR << 2;   // 'h0800 << 2 = 'h2000
    localparam BASEADDR_DLY_LD =  BASEADDR_CTRL | (DLY_LD_REL <<2);  // 'h080, address to generate delay load
    localparam BASEADDR_DLY_SET = BASEADDR_CTRL | (DLY_SET_REL<<2);  // 'h070, address to generate delay set
    localparam BASEADDR_RUN_CHN = BASEADDR_CTRL | (RUN_CHN_REL<<2);  // 'h000, address to set sequnecer channel and  run (4 LSB-s - channel)
    localparam BASEADDR_PATTERNS =BASEADDR_CTRL | (PATTERNS_REL<<2); // 'h020, address to set DQM and DQS patterns (16'h0055)
    localparam BASEADDR_PAGES =   BASEADDR_CTRL | (PAGES_REL<<2);    // 'h021, address to set buffer pages {port1_page[1:0],port1_int_page[1:0],port0_page[1:0],port0_int_page[1:0]}
    localparam BASEADDR_CMDA_EN = BASEADDR_CTRL | (CMDA_EN_REL<<2);  // 'h022, address to enable('h823)/disable('h822) command/address outputs  
    localparam BASEADDR_EXTRA =   BASEADDR_CTRL | (EXTRA_REL<<2);    // 'h024, address to set extra parameters (currently just inv_clk_div)
    localparam BASEADDRESS_LANE0 = BASEADDR_DLY_LD;  
    localparam BASEADDRESS_LANE1 = BASEADDR_DLY_LD+('h20<<2);  
    localparam BASEADDRESS_CMDA  = BASEADDR_DLY_LD+('h40<<2);
    localparam BASEADDRESS_PHASE = BASEADDR_DLY_LD+('h60<<2);
      

    localparam DLY_LANE0= 152'h74737271706f6e6d6c7574737271706f6e6d6c; // idelay dqs, idelay dq[7:0, odelay dqm, odelay ddqs, odelay dq[7:0]
    localparam DLY_LANE1= 152'h74737271706f6e6d6c7574737271706f6e6d6c; // idelay dqs, idelay dq[7:0, odelay dqm, odelay ddqs, odelay dq[7:0]
    localparam DLY_CMDA=  256'h5f5e5d5c5b5a59585756555453525150004e4b4c4b4a49484746454443424140; // odelay odt, cke, cas, ras, we, ba2,ba1,ba0, X, a14,..,a0
//    localparam DLY_PHASE= 8'h25; // mmcm fine phase shift
    localparam DLY_PHASE= 8'hdb; // mmcm fine phase shift
    

// initialize delays
    task axi_set_delays;
     integer i;
     begin
        for (i=0;i<19;i=i+1) begin
            axi_write_single(BASEADDRESS_LANE0 + (i<<2), (DLY_LANE0 >> (i<<3)) & 32'hff);
        end
        for (i=0;i<19;i=i+1) begin
            axi_write_single(BASEADDRESS_LANE1 + (i<<2), (DLY_LANE1 >> (i<<3)) & 32'hff);
        end
        for (i=0;i<32;i=i+1) begin
            axi_write_single(BASEADDRESS_CMDA + (i<<2), (DLY_CMDA >> (i<<3)) & 32'hff);
        end
        axi_write_single(BASEADDR_DLY_SET, 0); // set all dealys - remove after fixed axi_set_phase
        axi_set_phase(DLY_PHASE);
        axi_write_single(BASEADDR_DLY_SET, 0); // set all dealys
     end
    endtask

    task axi_set_phase;
        input [PHASE_WIDTH-1:0] phase;
        begin
            axi_write_single(BASEADDRESS_PHASE, {{(32-PHASE_WIDTH){1'b0}},phase});
        end
    endtask


// Low-level tasks     
    task axi_set_rd_lag;
        input [3:0] lag;
        begin
            @(posedge CLK);
            RD_LAG <= lag;
        end
    endtask

    task axi_set_b_lag;
        input [3:0] lag;
        begin
            @(posedge CLK);
            B_LAG <= lag;
        end
    endtask
   
    reg [11:0] GLOBAL_WRITE_ID=0;
    
    task axi_write_single; // address in bytes, not words
        input [31:0] address;
        input [31:0] data;
        begin
`ifdef DEBUG_WR_SINGLE
          $display("axi_write_single %h:%h @ %t",address,data,$time);
`endif                
          axi_write_addr_data(
                    GLOBAL_WRITE_ID,    // id
//                    address << 2, // addr
                    address & 32'hfffffffc, // addr
                    data,
                    4'h0, // len - single
                    1,    // burst type - increment
                    1'b1, // data_en
                    4'hf, // wstrb
                    1'b1 // last
                );
          GLOBAL_WRITE_ID <= GLOBAL_WRITE_ID+1;
        end
    endtask
   
    task axi_write_addr_data;
        input [11:0] id;
        input [31:0] addr;
        input [31:0] data;
        input [ 3:0] len;
        input [ 1:0] burst;
        input        data_en; // if 0 - do not send data, only address
        input [ 3:0] wstrb;
        input        last;
        reg          data_sent;
//        wire         data_sent_d;
//        assign #(.1) data_sent_d= data_sent;
        begin
            wait (!CLK && AW_READY);
            AWID_IN_r    <= id;
            AWADDR_IN_r  <= addr;
            AWLEN_IN_r   <= len;
            AWSIZE_IN_r  <= 3'b010;
            AWBURST_IN_r <= burst;
            AW_SET_CMD_r <= 1'b1;
            if (data_en && W_READY) begin
                WID_IN_r <= id;
                WDATA_IN_r <= data;
                WSTRB_IN_r <= wstrb;
                WLAST_IN_r <= last;
                W_SET_CMD_r <= 1'b1; 
                data_sent <= 1'b1;
            end else begin
                data_sent <= 1'b0;
            end
            DEBUG1 <=1'b1;
            wait (CLK);
            DEBUG1 <=1'b0;
            AWID_IN_r    <= 'hz;
            AWADDR_IN_r  <= 'hz;
            AWLEN_IN_r   <= 'hz;
            AWSIZE_IN_r  <= 'hz;
            AWBURST_IN_r <= 'hz;
            AW_SET_CMD_r <= 1'b0;
            DEBUG2 <=1'b1;
            if (data_sent) begin
                WID_IN_r    <= 'hz;
                WDATA_IN_r  <= 'hz;
                WSTRB_IN_r  <= 'hz;
                WLAST_IN_r  <= 'hz;
                W_SET_CMD_r <= 1'b0; 
            end
// Now sent data if it was not sent simultaneously with the address
            if (data_en && !data_sent) begin
                DEBUG3 <=1'b1;
                wait (!CLK && W_READY);
                DEBUG3 <=1'b0;
                WID_IN_r    <= id;
                WDATA_IN_r  <= data;
                WSTRB_IN_r  <= wstrb;
                WLAST_IN_r  <= last;
                W_SET_CMD_r <= 1'b1; 
                wait (CLK);
                DEBUG3 <=1'bx;
                WID_IN_r    <= 'hz;
                WDATA_IN_r  <= 'hz;
                WSTRB_IN_r  <= 'hz;
                WLAST_IN_r  <= 'hz;
                W_SET_CMD_r <= 1'b0; 
            end
            DEBUG2 <=1'b0;
            #0.1;
            data_sent <= 1'b0;
            #0.1;
        end
    endtask

    task axi_write_data;
        input [11:0] id;
        input [31:0] data;
        input [ 3:0] wstrb;
        input        last;
        begin
            wait (!CLK && W_READY);
            WID_IN_r    <= id;
            WDATA_IN_r  <= data;
            WSTRB_IN_r  <= wstrb;
            WLAST_IN_r  <= last;
            W_SET_CMD_r <= 1'b1; 
            wait (CLK);
            WID_IN_r    <= 12'hz;
            WDATA_IN_r  <= 'hz;
            WSTRB_IN_r  <= 4'hz;
            WLAST_IN_r  <= 1'bz;
            W_SET_CMD_r <= 1'b0;
            #0.1;
        end
    endtask

    task axi_read_addr;
        input [11:0] id;
        input [31:0] addr;
        input [ 3:0] len;
        input [ 1:0] burst;
        begin
            wait (!CLK && AR_READY);
            ARID_IN_r    <= id;
            ARADDR_IN_r  <= addr;
            ARLEN_IN_r   <= len;
            ARSIZE_IN_r  <= 3'b010;
            ARBURST_IN_r <= burst;
            AR_SET_CMD_r <= 1'b1;
            wait (CLK);
            ARID_IN_r    <= 12'hz;
            ARADDR_IN_r  <= 'hz;
            ARLEN_IN_r   <= 4'hz;
            ARSIZE_IN_r  <= 3'hz;
            ARBURST_IN_r <= 2'hz;
            AR_SET_CMD_r <= 1'b0;
        end
    endtask

endmodule

