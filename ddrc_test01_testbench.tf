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
    parameter SDRST_ACT_REL =       'h024,  // address to activate('h825)/deactivate('h8242) active-low reset signal to DDR3 memory  
    parameter SDRST_ACT_REL_MASK =  'h3fe,  // address mask for reset DDR3
    parameter CKE_EN_REL =          'h026,  // address to enable('h827)/disable('h826) CKE signal to memory   
    parameter CKE_EN_REL_MASK =     'h3fe,  // address mask for command/address outputs
    parameter EXTRA_REL =           'h028,  // address to set extra parameters (currently just inv_clk_div)
    parameter EXTRA_REL_MASK =      'h3ff,  // address mask for extra parameters
    
    // simulation-specific parameters
    parameter integer AXI_RDADDR_LATENCY=2,
    parameter integer AXI_WRADDR_LATENCY=4,
    parameter integer AXI_WRDATA_LATENCY=1,
    parameter integer AXI_TASK_HOLD=1.0,
    parameter integer ADDRESS_NUMBER=15 
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
  wire        SDRST;
  wire        SDCLK;  // output
  wire        SDNCLK; // output
  wire [ADDRESS_NUMBER-1:0] SDA;    // output[14:0] 
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

  // SuppressWarnings VEditor : assigned in $readmem() system task
  wire [ 9:0] SIMUL_AXI_ADDR_W; 
  // SuppressWarnings VEditor
  wire        SIMUL_AXI_MISMATCH;
  // SuppressWarnings VEditor
  reg  [31:0] SIMUL_AXI_READ;
  // SuppressWarnings VEditor
  reg  [ 9:0] SIMUL_AXI_ADDR;
  // SuppressWarnings VEditor
  reg         SIMUL_AXI_FULL; // some data available

  reg  [31:0] registered_rdata;

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
  // SuppressWarnings VEditor : assigned in $readmem(14) system task
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
    read_status; // ps ready goes false with some delay
//    read_status;
    wait_phase_shifter_ready;
//    repeat (40) begin
//    read_status;
//    end
    enable_cmda(1);
    repeat (16) @(posedge CLK) ;
    activate_sdrst(0); // was enabled at system reset
    #5000; // actually 500 usec required
    repeat (16) @(posedge CLK) ;
    enable_cke(1);
    repeat (16) @(posedge CLK) ;
    set_mrs(1);
    #100;
//    $finish;
    run_sequence(0);
//#100;
    $display("finish testbench 0");
    $finish;
    
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
        .SDRST_ACT_REL         (SDRST_ACT_REL),  
        .SDRST_ACT_REL_MASK    (SDRST_ACT_REL_MASK),
        .CKE_EN_REL            (CKE_EN_REL),   
        .CKE_EN_REL_MASK       (CKE_EN_REL_MASK),
        .EXTRA_REL             (EXTRA_REL),
        .EXTRA_REL_MASK        (EXTRA_REL_MASK)
        
    ) ddrc_test01_i (
        .SDRST   (SDRST), // DDR3 reset (active low)
        .SDCLK   (SDCLK), // output 
        .SDNCLK  (SDNCLK), // outputread_and_wait(BASEADDR_STATUS)
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
// Micron DDR3 memory model
    /* Instance of Micron DDR3 memory model */
    ddr3 #(
        .TCK_MIN             (2500),
        .TJIT_PER            (100),
        .TJIT_CC             (200),
        .TERR_2PER           (147),
        .TERR_3PER           (175),
        .TERR_4PER           (194),
        .TERR_5PER           (209),
        .TERR_6PER           (222),
        .TERR_7PER           (232),
        .TERR_8PER           (241),
        .TERR_9PER           (249),
        .TERR_10PER          (257),
        .TERR_11PER          (263),
        .TERR_12PER          (269),
        .TDS                 (125),
        .TDH                 (150),
        .TDQSQ               (200),
        .TDQSS               (0.25),
        .TDSS                (0.20),
        .TDSH                (0.20),
        .TDQSCK              (400),
        .TQSH                (0.38),
        .TQSL                (0.38),
        .TDIPW               (600),
        .TIPW                (900),
        .TIS                 (350),
        .TIH                 (275),
        .TRAS_MIN            (37500),
        .TRC                 (52500),
        .TRCD                (15000),
        .TRP                 (15000),
        .TXP                 (7500),
        .TCKE                (7500),
        .TAON                (400),
        .TWLS                (325),
        .TWLH                (325),
        .TWLO                (9000),
        .TAA_MIN             (15000),
        .CL_TIME             (15000),
        .TDQSCK_DLLDIS       (400),
        .TRRD                (10000),
        .TFAW                (40000),
        .CL_MIN              (5),
        .CL_MAX              (14),
        .AL_MIN              (0),
        .AL_MAX              (2),
        .WR_MIN              (5),
        .WR_MAX              (16),
        .BL_MIN              (4),
        .BL_MAX              (8),
        .CWL_MIN             (5),
        .CWL_MAX             (10),
        .TCK_MAX             (3300),
        .TCH_AVG_MIN         (0.47),
        .TCL_AVG_MIN         (0.47),
        .TCH_AVG_MAX         (0.53),
        .TCL_AVG_MAX         (0.53),
        .TCH_ABS_MIN         (0.43),
        .TCL_ABS_MIN         (0.43),
        .TCKE_TCK            (3),
        .TAA_MAX             (20000),
        .TQH                 (0.38),
        .TRPRE               (0.90),
        .TRPST               (0.30),
        .TDQSH               (0.45),
        .TDQSL               (0.45),
        .TWPRE               (0.90),
        .TWPST               (0.30),
        .TCCD                (4),
        .TCCD_DG             (2),
        .TRAS_MAX            (60e9),
        .TWR                 (15000),
        .TMRD                (4),
        .TMOD                (15000),
        .TMOD_TCK            (12),
        .TRRD_TCK            (4),
        .TRRD_DG             (3000),
        .TRRD_DG_TCK         (2),
        .TRTP                (7500),
        .TRTP_TCK            (4),
        .TWTR                (7500),
        .TWTR_DG             (3750),
        .TWTR_TCK            (4),
        .TWTR_DG_TCK         (2),
        .TDLLK               (512),
        .TRFC_MIN            (260000),
        .TRFC_MAX            (70200000),
        .TXP_TCK             (3),
        .TXPDLL              (24000),
        .TXPDLL_TCK          (10),
        .TACTPDEN            (1),
        .TPRPDEN             (1),
        .TREFPDEN            (1),
        .TCPDED              (1),
        .TPD_MAX             (70200000),
        .TXPR                (270000),
        .TXPR_TCK            (5),
        .TXS                 (270000),
        .TXS_TCK             (5),
        .TXSDLL              (512),
        .TISXR               (350),
        .TCKSRE              (10000),
        .TCKSRE_TCK          (5),
        .TCKSRX              (10000),
        .TCKSRX_TCK          (5),
        .TCKESR_TCK          (4),
        .TAOF                (0.7),
        .TAONPD              (8500),
        .TAOFPD              (8500),
        .ODTH4               (4),
        .ODTH8               (6),
        .TADC                (0.7),
        .TWLMRD              (40),
        .TWLDQSEN            (25),
        .TWLOE               (2000),
        .DM_BITS             (2),
        .ADDR_BITS           (15),
        .ROW_BITS            (15),
        .COL_BITS            (10),
        .DQ_BITS             (16),
        .DQS_BITS            (2),
        .BA_BITS             (3),
        .MEM_BITS            (10),
        .AP                  (10),
        .BC                  (12),
        .BL_BITS             (3),
        .BO_BITS             (2),
        .CS_BITS             (1),
        .RANKS               (1),
        .RZQ                 (240),
        .PRE_DEF_PAT         (8'hAA),
        .STOP_ON_ERROR       (1),
        .DEBUG               (1),
        .BUS_DELAY           (0),
        .RANDOM_OUT_DELAY    (0),
        .RANDOM_SEED         (31913),
        .RDQSEN_PRE          (2),
        .RDQSEN_PST          (1),
        .RDQS_PRE            (2),
        .RDQS_PST            (1),
        .RDQEN_PRE           (0),
        .RDQEN_PST           (0),
        .WDQS_PRE            (2),
        .WDQS_PST            (1),
        .check_strict_mrbits (1),
        .check_strict_timing (1),
        .feature_pasr        (1),
        .feature_truebl4     (0),
        .feature_odt_hi      (0),
        .PERTCKAVG           (512),
        .LOAD_MODE           (4'b0000),
        .REFRESH             (4'b0001),
        .PRECHARGE           (4'b0010),
        .ACTIVATE            (4'b0011),
        .WRITE               (4'b0100),
        .READ                (4'b0101),
        .ZQ                  (4'b0110),
        .NOP                 (4'b0111),
        .PWR_DOWN            (4'b1000),
        .SELF_REF            (4'b1001),
        .RFF_BITS            (128),
        .RFF_CHUNK           (32),
        .SAME_BANK           (2'd0),
        .DIFF_BANK           (2'd1),
        .DIFF_GROUP          (2'd2),
        .SIMUL_500US         (5),
        .SIMUL_200US         (2)
    ) ddr3_i (
        .rst_n   (SDRST),         // input 
        .ck      (SDCLK),         // input 
        .ck_n    (SDNCLK),        // input 
        .cke     (SDCKE),         // input 
        .cs_n    (1'b0),          // input 
        .ras_n   (SDRAS),         // input 
        .cas_n   (SDCAS),         // input 
        .we_n    (SDWE),          // input 
        .dm_tdqs ({SDDMU,SDDML}), // inout[1:0] 
        .ba      (SDBA[2:0]),     // input[2:0] 
        .addr    (SDA[14:0]),     // input[14:0] 
        .dq      (SDD[15:0]),     // inout[15:0] 
        .dqs     ({DQSU,DQSL}),   // inout[1:0] 
        .dqs_n   ({NDQSU,NDQSL}), // inout[1:0] 
        .tdqs_n  (),              // output[1:0] 
        .odt     (SDODT)          // input 
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
    .valid(bvalid), // input       ADDRESS_NUMBER+2:0  valid,
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
 
// SuppressWarnings VEditor
    localparam BASEADDR_PORT0_RD = PORT0_RD_ADDR << 2; // 'h0000  << 2
// SuppressWarnings VEditor
    localparam BASEADDR_PORT1_WR = PORT1_WR_ADDR << 2; // 'h0000 << 2 = 'h000
    localparam BASEADDR_CMD0 =     CMD0_ADDR << 2;     // 'h0800 << 2 = 'h2000
//    localparam BASEADDR_CTRL =     CONTROL_ADDR << 2;
    localparam BASEADDR_CTRL =     (CONTROL_ADDR | BUSY_WR_ADDR) << 2; // with busy
    localparam BASEADDR_STATUS =   STATUS_ADDR << 2;   // 'h0800 << 2 = 'h2000
    localparam BASEADDR_DLY_LD =  BASEADDR_CTRL | (DLY_LD_REL <<2);  // 'h080, address to generate delay load
    localparam BASEADDR_DLY_SET = BASEADDR_CTRL | (DLY_SET_REL<<2);  // 'h070, address to generate delay set
    localparam BASEADDR_RUN_CHN = BASEADDR_CTRL | (RUN_CHN_REL<<2);  // 'h000, address to set sequnecer channel and  run (4 LSB-s - channel)
// SuppressWarnings VEditor
    localparam BASEADDR_PATTERNS =BASEADDR_CTRL | (PATTERNS_REL<<2); // 'h020, address to set DQM and DQS patterns (16'h0055)
// SuppressWarnings VEditor
    localparam BASEADDR_PAGES =   BASEADDR_CTRL | (PAGES_REL<<2);    // 'h021, address to set buffer pages {port1_page[1:0],port1_int_page[1:0],port0_page[1:0],port0_int_page[1:0]}
    localparam BASEADDR_CMDA_EN = BASEADDR_CTRL | (CMDA_EN_REL<<2);  // 'h022, address to enable('h823)/disable('h822) command/address outputs  
    localparam BASEADDR_SDRST_ACT = BASEADDR_CTRL | (SDRST_ACT_REL<<2); // address to activate('h825)/deactivate('h824) active-low reset signal to DDR3 memory     
    localparam BASEADDR_CKE_EN =  BASEADDR_CTRL | (CKE_EN_REL<<2);   //   
// SuppressWarnings VEditor
    localparam BASEADDR_EXTRA =   BASEADDR_CTRL | (EXTRA_REL<<2);    // 'h028, address to set extra parameters (currently just inv_clk_div)
    
    localparam BASEADDRESS_LANE0 = BASEADDR_DLY_LD;  
    localparam BASEADDRESS_LANE1 = BASEADDR_DLY_LD+('h20<<2);  
    localparam BASEADDRESS_CMDA  = BASEADDR_DLY_LD+('h40<<2);
    localparam BASEADDRESS_PHASE = BASEADDR_DLY_LD+('h60<<2);
    localparam PSHIFTER_RDY_MASK = 'h100;
      

    localparam DLY_LANE0= 152'h74737271706f6e6d6c7574737271706f6e6d6c; // idelay dqs, idelay dq[7:0, odelay dqm, odelay ddqs, odelay dq[7:0]
    localparam DLY_LANE1= 152'h74737271706f6e6d6c7574737271706f6e6d6c; // idelay dqs, idelay dq[7:0, odelay dqm, odelay ddqs, odelay dq[7:0]
    localparam DLY_CMDA=  256'h5f5e5d5c5b5a59585756555453525150004e4b4c4b4a49484746454443424140; // odelay odt, cke, cas, ras, we, ba2,ba1,ba0, X, a14,..,a0
//    localparam DLY_PHASE= 8'h25; // mmcm fine phase shift
    localparam DLY_PHASE= 8'hdb; // mmcm fine phase shift

    task run_sequence;
        input [7:0] start_addr; // word
// BASEADDR_RUN_CHN        
        begin
            $display("run_sequence 0 @ %t",$time);
            axi_write_single(BASEADDR_RUN_CHN, {24'h0,start_addr});
            $display("run_sequence 1 @ %t",$time);
            #1000; // 90; // 92 - does not work ?
            $display("run_sequence 2 @ %t",$time);
        end
    endtask
    task enable_cmda;
        input en;
        begin
            if (en) 
                axi_write_single(BASEADDR_CMDA_EN+4, 0);
            else 
                axi_write_single(BASEADDR_CMDA_EN, 0);
        end
    endtask
    task enable_cke;
        input en;
        begin
            if (en) 
                axi_write_single(BASEADDR_CKE_EN+4, 0);
            else 
                axi_write_single(BASEADDR_CKE_EN, 0);
        //BASEADDR_CMDA_EN
        end
    endtask

    task activate_sdrst;
        input en;
        begin
            if (en) 
                axi_write_single(BASEADDR_SDRST_ACT+4, 0);
            else 
                axi_write_single(BASEADDR_SDRST_ACT, 0);
        //BASEADDR_CMDA_EN
        end
    endtask

    task set_mrs;
        input reset_dll;
//        reg [ADDRESS_NUMBER+2:0] mr0;
//        reg [ADDRESS_NUMBER+2:0] mr1;
//        reg [ADDRESS_NUMBER+2:0] mr2;
//        reg [ADDRESS_NUMBER+2:0] mr3;
        reg [17:0] mr0;
        reg [17:0] mr1;
        reg [17:0] mr2;
        reg [17:0] mr3;
        reg [31:0] cmd_addr;
        reg [31:0] data;
        begin
            mr0 <= ddr3_mr0 (
               1'h0,      //       pd; // precharge power down 0 - dll off (slow exit), 1 - dll on (fast exit) 
               3'h2,      // [2:0] wr; // write recovery (encode ceil(tWR/tCK)) // 3'b010:  6
               reset_dll, //       dll_rst; // 1 - dll reset (self clearing bit)
               4'h2,      // [3:0] cl; // CAS latency: // 0010:  5
               1'h0,      //       bt; // read burst type: 0 sequential (nibble), 1 - interleaverun_seqd
               2'h0);       // [1:0] bl; // burst length: // 2'b00 - fixed BL8
 
             mr1 <= ddr3_mr1 (
                1'h0,     //       qoff; // output enable: 0 - DQ, DQS operate in normal mode, 1 - DQ, DQS are disabled
                1'h0,     //       tdqs; // termination data strobe (for x8 devices) 0 - disabled, 1 - enabled
                3'h2,     // [2:0] rtt;  // on-die termination resistance: //  3'b010 - RZQ/2 (120 Ohm)
                1'h0,     //       wlev; // write leveling
                2'h0,     //       ods;  // output drive strength: //  2'b00 - RZQ/6 - 40 Ohm
                2'h0,     // [1:0] al;   // additive latency: 2'b00 - disabled (AL=0)
                1'b0);    //       dll;  // 0 - DLL enabled (normal), 1 - DLL disabled
               
             mr2 <= ddr3_mr2 (
                2'h0,     // [1:0] rtt_wr; // Dynamic ODT : //  2'b00 - disabled, 2'b01 - RZQ/4 = 60 Ohm, 2'b10 - RZQ/2 = 120 Ohm
                1'h0,     //       srt;    // Self-refresh temperature 0 - normal (0-85C), 1 - extended (<=95C)
                1'h0,     //       asr;    // Auto self-refresh 0 - disabled (manual), 1 - enabled (auto)
                3'h0);    // [2:0] cwl;    // CAS write latency:3'b000  5CK (tCK >= 2.5ns), 3'b001  6CK (1.875ns <= tCK < 2.5ns)

             mr3 <= ddr3_mr3 (
                1'h0,     //       mpr;    // MPR mode: 0 - normal, 1 - dataflow from MPR
                2'h0);    // [1:0] mpr_rf; // MPR read function: 2'b00: predefined pattern 0101...
             cmd_addr <= BASEADDR_CMD0;   
             wait (~CLK);
             data <=  encode_seq_word(
                mr2[14:0],              // [14:0] phy_addr_in;
                mr2[17:15],             // [ 2:0] phy_bank_in; //TODO: debug!
                3'b111,                               // [ 2:0] phy_rcw_in; // {ras,cas,we}, positive
                1'b0,                                 //        phy_odt_in; // may be optimized?
                1'b0,                                 // phy_cke_inv; // may be optimized?
                1'b0,                                 // phy_sel_in; // first/second half-cycle, oter will be nop (cke+odt applicable to both)
                1'b0,                                 // phy_dq_en_in;
                1'b0,                                 // phy_dqs_ddrc_sequenceren_in;
                1'b0,                                 // phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
                1'b0,                                 // phy_buf_wr;   // connect to external buffer
                1'b0);                               // phy_buf_rd;   // connect to external buffer
             wait (CLK);
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;
             wait (~CLK);                
//             data <= encode_seq_skip(2,0);
             data <= encode_seq_skip(1,0);  // 6 cycles between mrs commands
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;
             wait (~CLK);
             data <=  encode_seq_word(
                mr3[14:0],              // [14:0] phy_addr_in;
                mr3[17:15],             // [ 2:0] phy_bank_in; //TODO: debug!
                3'b111,                               // [ 2:0] phy_rcw_in; // {ras,cas,we}, positive
                1'b0,                                 //        phy_odt_in; // may be optimized?
                1'b0,                                 // phy_cke_inv; // may be optimized?
                1'b0,                                 // phy_sel_in; // first/second half-cycle, other will be nop (cke+odt applicable to both)
                1'b0,                                 // phy_dq_eddrc_sequencern_in;
                1'b0,                                 // phy_dqs_en_in;
                1'b0,                                 // phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
                1'b0,                                 // phy_buf_wr;   // connect to external buffer
                1'b0);                               // phy_buf_rd;   // connect to external buffer
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;
             wait (~CLK);                
//             data <= encode_seq_skip(2,0); // TODO: function - does not check arguments number
             data <= encode_seq_skip(0,0); // 5 cycles between mrs commands (next command has phy_sel_in == 1)
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;

             wait (~CLK);
             data <=  encode_seq_word(
                mr1[14:0],              // [14:0] phy_addr_in;
                mr1[17:15],             // [ 2:0] phy_bank_in; //TODO: debug!
                3'b111,                               // [ 2:0] phy_rcw_in; // {ras,cas,we}, positive
                1'b0,                                 //        phy_odt_in; // may be optimized?
                1'b0,                                 // phy_cke_inv; // may be optimized?
                1'b1,                                 // phy_sel_in == 1 (test); // first/second half-cycle,
                1'b0,                                 // phy_dq_en_in;
                1'b0,                                 // phy_dqs_en_in;
                1'b0,                                 // phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
                1'b0,                                 // phy_buf_wr;   // connect to external buffer
                1'b0);                               // phy_buf_rd;   // connect to external buffer
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;
             wait (~CLK);                
             data <= encode_seq_skip(2,0); //  7 cycles between mrs commands ( prev. command had phy_sel_in == 1)
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;

             wait (~CLK);
             data <=  encode_seq_word(
                mr0[14:0],              // [14:0] phy_addr_in;
                mr0[17:15],             // [ 2:0] phy_bank_in; //TODO: debug!
                3'b111,                               // [ 2:0] phy_rcw_in; // {ras,cas,we}, positive
                1'b0,                                 //        phy_odt_in; // may be optimized?
                1'b0,                                 // phy_cke_inv; // may be optimized?
                1'b0,                                 // phy_sel_in; // first/second half-cycle, other will be nop (cke+odt applicable to both)
                1'b0,                                 // phy_dq_en_in;
                1'b0,                                 // phy_dqs_en_in;
                1'b0,                                 // phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
                1'b0,                                 // phy_buf_wr;   // connect to external buffer
                1'b0);                                // phy_buf_rd;   // connect to external buffer
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;

             wait (~CLK);                
             data <= encode_seq_skip(10,1); // sequence done bit, skip length is ignored
             wait (CLK);                
             axi_write_single(cmd_addr, data);
             cmd_addr <= cmd_addr + 4;


             
// TODO: Function of function does not work - debug             
/*             
             axi_write_single(cmd_addr,
              encode_seq_word(
                mr2[14:0],              // [14:0] phy_addr_in;
                mr2[17:15],             // [ 2:0] phy_bank_in; //TODO: debug!
                3'b111,                               // [ 2:0] phy_rcw_in; // {ras,cas,we}, positive
                1'b0,                                 //        phy_odt_in; // may be optimized?
                1'b0,                                 // phy_cke_inv; // may be optimized?
                1'b0,                                 // phy_sel_in; // first/second half-cycle, other will be nop (cke+odt applicable to both)
                1'b0,                                 // phy_dq_en_in;
                1'b0,                                 // phy_dqs_en_in;
                1'b0,                                 // phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
                1'b0,                                 // phy_buf_wr;   // connect to external buffer
                1'b0));                               // phy_buf_rd;   // connect to external buffer
             
 */            
        end
    endtask
        
    function [31:0] encode_seq_word;
        input               [14:0] phy_addr_in;  // also provides pause length when the command is NOP
        input               [ 2:0] phy_bank_in;
        input               [ 2:0] phy_rcw_in; // {ras,cas,we}
        input                      phy_odt_in; // may be optimized?
        input                      phy_cke_inv; // invert CKE 
        input                      phy_sel_in; // fitst/second half-cycle, oter will be nop (cke+odt applicable to both)
        input                      phy_dq_en_in;
        input                      phy_dqs_en_in;
        input                      phy_dci_en_in;      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
        input                      phy_buf_wr;   // connect to external buffer
        input                      phy_buf_rd;   // connect to external buffer
        begin
            encode_seq_word={
            phy_addr_in[14:0],
            phy_bank_in[2:0],
            phy_rcw_in[2:0],      // {ras,cas,we}, positive logic (3'b0 - NOP)
            phy_odt_in,      // may be optimized?
            phy_cke_inv,     // invert CKE
            phy_sel_in,      // first/second half-cycle, other will be nop (cke+odt applicable to both)
            phy_dq_en_in,    //phy_dq_tri_in,   // tristate DQ  lines (internal timing sequencer for 0->1 and 1->0)
            phy_dqs_en_in,   //phy_dqs_tri_in,  // tristate DQS lines (internal timing sequencer for 0->1 and 1->0)
            phy_dci_en_in,   //phy_dci_in,      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
            phy_buf_wr,      // connect to external buffer (but only if not paused)
            phy_buf_rd,      // connect to external buffer (but only if not paused)
            3'h0      // Reserved for future use
            };
        end
    endfunction
//    parameter CMD_PAUSE_BITS=       6, // numer of (address) bits to encode pause
//    parameter CMD_DONE_BIT=         6  // bit number (address) to signal sequence done
    
    function [31:0] encode_seq_skip;
        input [CMD_PAUSE_BITS-1:0] skip;
        input done;
        begin
            encode_seq_skip={
            {14-CMD_DONE_BIT{1'b0}},
            done,
            skip[CMD_PAUSE_BITS-1:0],
            3'b0, //phy_bank_in[2:0],
            3'b0, // phy_rcw_in[2:0],      // {ras,cas,we}
            1'b0, // phy_odt_in,      // may be optimized?
            1'b0, // phy_cke_in,      // may be optimized?
            1'b0, // phy_sel_in,      // fitst/second half-cycle, oter will be nop (cke+odt applicable to both)
            1'b0, // phy_dq_en_in, //phy_dq_tri_in,   // tristate DQ  lines (internal timing sequencer for 0->1 and 1->0)
            1'b0, // phy_dqs_en_in, //phy_dqs_tri_in,  // tristate DQS lines (internal timing sequencer for 0->1 and 1->0)
            1'b0, // phy_dci_en_in, //phy_dci_in,      // DCI disable, both DQ and DQS lines (internal logic and timing sequencer for 0->1 and 1->0)
            1'b0, // phy_buf_wr,   // connect to external buffer (but only if not paused)
            1'b0, // phy_buf_rd,    // connect to external buffer (but only if not paused)
            3'h0      // Reserved for future use
            };
        
        end
        
    endfunction
    

    function [ADDRESS_NUMBER+2:0] ddr3_mr0;
        input       pd; // precharge power down 0 - dll off (slow exit), 1 - dll on (fast exit) 
        input [2:0] wr; // write recovery:
                        // 3'b000: 16
                        // 3'b001:  5
                        // 3'b010:  6
                        // 3'b011:  7
                        // 3'b100:  8
                        // 3'b101: 10
                        // 3'b110: 12
                        // 3'b111: 14
        input       dll_rst; // 1 - dll reset (self clearing bit)
        input [3:0] cl; // CAS latency:
                        // 0000: reserved                   
                        // 0010:  5                   
                        // 0100:  6                   
                        // 0110:  7                 
                        // 1000:  8                 
                        // 1010:  9                 
                        // 1100: 10                   
                        // 1110: 11                   
                        // 0001: 12                  
                        // 0011: 13                  
                        // 0101: 14
        input       bt; // read burst type: 0 sequential (nibble), 1 - interleaved
        input [1:0] bl; // burst length:
                        // 2'b00 - fixed BL8
                        // 2'b01 - 4 or 8 on-the-fly by A12                                     
                        // 2'b10 - fixed BL4 (chop)
                        // 2'b11 - reserved
        begin
          ddr3_mr0 = {
              3'b0,
              {ADDRESS_NUMBER-13{1'b0}},
              pd,       // MR0.12 
              wr,       // MR0.11_9
              dll_rst,  // MR0.8
              1'b0,     // MR0.7
              cl[3:1],  // MR0.6_4
              bt,       // MR0.3
              cl[0],    // MR0.2
              bl[1:0]}; // MR0.1_0
        end
    
    endfunction
    
    function [ADDRESS_NUMBER+2:0] ddr3_mr1;
        input       qoff; // output enable: 0 - DQ, DQS operate in normal mode, 1 - DQ, DQS are disabled
        input       tdqs; // termination data strobe (for x8 devices) 0 - disabled, 1 - enabled
        input [2:0] rtt;  // on-die termination resistance:
                          //  3'b000 - disabled
                          //  3'b001 - RZQ/4 (60 Ohm)
                          //  3'b010 - RZQ/2 (120 Ohm)
                          //  3'b011 - RZQ/6 (40 Ohm)
                          //  3'b100 - RZQ/12(20 Ohm)
                          //  3'b101 - RZQ/8 (30 Ohm)
                          //  3'b11x - reserved
        input       wlev; // write leveling
        input [1:0] ods;  // output drive strength:
                          //  2'b00 - RZQ/6 - 40 Ohm
                          //  2'b01 - RZQ/7 - 34 Ohm
                          //  2'b1x - reserved
        input [1:0] al;   // additive latency:
                          //  2'b00 - disabled (AL=0)
                          //  2'b01 - AL=CL-1;
                          //  2'b10 - AL=CL-2
                          //  2'b11 - reserved
        input       dll;  // 0 - DLL enabled (normal), 1 - DLL disabled
        begin
            ddr3_mr1 = {
              3'h1,
              {ADDRESS_NUMBER-13{1'b0}},
              qoff,       // MR1.12 
              tdqs,       // MR1.11
              1'b0,       // MR1.10
              rtt[2],     // MR1.9
              1'b0,       // MR1.8
              wlev,       // MR1.7 
              rtt[1],     // MR1.6 
              ods[1],     // MR1.5 
              al[1:0],    // MR1.4_3 
              rtt[0],     // MR1.2 
              ods[0],     // MR1.1 
              dll};       // MR1.0 
        end                            
    endfunction

    function [ADDRESS_NUMBER+2:0] ddr3_mr2;
        input [1:0] rtt_wr; // Dynamic ODT :
                            //  2'b00 - disabled
                            //  2'b01 - RZQ/4 = 60 Ohm
                            //  2'b10 - RZQ/2 = 120 Ohm
                            //  2'b11 - reserved
        input       srt;    // Self-refresh temperature 0 - normal (0-85C), 1 - extended (<=95C)
        input       asr;    // Auto self-refresh 0 - disabled (manual), 1 - enabled (auto)
        input [2:0] cwl;    // CAS write latency:
                            //  3'b000  5CK (           tCK >= 2.5ns)  
                            //  3'b001  6CK (1.875ns <= tCK < 2.5ns)  
                            //  3'b010  7CK (1.5ns   <= tCK < 1.875ns)  
                            //  3'b011  8CK (1.25ns  <= tCK < 1.5ns)  
                            //  3'b100  9CK (1.071ns <= tCK < 1.25ns)  
                            //  3'b101 10CK (0.938ns <= tCK < 1.071ns)  
                            //  3'b11x reserved  
        begin
            ddr3_mr2 = {
              3'h2,
              {ADDRESS_NUMBER-11{1'b0}},
              rtt_wr[1:0], // MR2.10_9
              1'b0,        // MR2.8
              srt,         // MR2.7
              asr,         // MR2.6
              cwl[2:0],    // MR2.5_3
              3'b0};       // MR2.2_0 
        end                            
    endfunction
        
    function [ADDRESS_NUMBER+2:0] ddr3_mr3;
        input       mpr;    // MPR mode: 0 - normal, 1 - dataflow from MPR
        input [1:0] mpr_rf; // MPR read function:
                            //  2'b00: predefined pattern 0101...
                            //  2'b1x, 2'bx1 - reserved
        begin
            ddr3_mr3 = {
              3'h3,
              {ADDRESS_NUMBER-3{1'b0}},
              mpr,          // MR3.2
              mpr_rf[1:0]}; // MR3.1_0 
        end                            
    endfunction

    
    reg [7:0] target_phase=0;

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
            target_phase <= phase;
        end
    endtask
/*
    assign rdata={21'b0,run_busy,locked,ps_rdy,ps_out[7:0]};
*/    
    task wait_phase_shifter_ready;
        begin
            read_status;
            while (((registered_rdata & PSHIFTER_RDY_MASK) == 0) || (((registered_rdata ^ {24'h0,target_phase}) & 'hff) != 0)) read_status;
        end
    endtask
    
    
    task read_status;
        begin
            read_and_wait(BASEADDR_STATUS);
        end    
    endtask
    
/*
   // read memory
    task test_axi_2;
        integer i; //,j;
        begin
            axi_set_rd_lag(0);
            for (i=0;i<1024;i=i+16) begin
                axi_read_addr(
                    i,    // id
                    i<<2, // addr
                    4'hf, // len
                    1     // burst type - increment
                );
                if ((i==256) || (i==384)) begin
                    repeat (512) @(posedge CLK) ;
                end
                if (( i & 'h7f)==0) begin
                  if (( i & 'h80)==0) axi_set_rd_lag(1);
                  else axi_set_rd_lag(0);
                end
            end
//            assign aaa=bbb; // task internals were not parsed
        end
    endtask    task read_status;
        begin
            read_and_wait(BASEADDR_STATUS);
        end    
    endtask
    

*/

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
    reg [11:0] GLOBAL_READ_ID=0;

    task read_and_wait;
    input [31:0] address;
    begin
        axi_read_addr(
            GLOBAL_READ_ID,    // id
            address & 32'hfffffffc, // addr
            4'h0, // len - single
            1     // burst type - increment
            );
        GLOBAL_READ_ID <= GLOBAL_READ_ID+1;
        wait (!CLK && rvalid && rready);
        wait (CLK);
        registered_rdata <= rdata;
    end
    endtask
    
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
// SuppressWarnings VEditor - not yet used
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

    task axi_read_addr;`ifndef IVERILOG
(* dont_touch = "true" *)
`endif
    
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

