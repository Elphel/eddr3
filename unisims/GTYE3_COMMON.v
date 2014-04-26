///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 2011 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2012.2
//  \   \          Description : Xilinx Unified Simulation Library Component
//  /   /                        
// /___/   /\      Filename    : GTYE3_COMMON.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

  `celldefine
module GTYE3_COMMON #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [15:0] A_SDM1DATA1_0 = 16'b0000000000000000,
  parameter [8:0] A_SDM1DATA1_1 = 9'b000000000,
  parameter [15:0] BIAS_CFG0 = 16'h0000,
  parameter [15:0] BIAS_CFG1 = 16'h0000,
  parameter [15:0] BIAS_CFG2 = 16'h0000,
  parameter [15:0] BIAS_CFG3 = 16'h0000,
  parameter [15:0] BIAS_CFG4 = 16'h0000,
  parameter [9:0] BIAS_CFG_RSVD = 10'b0000000000,
  parameter [15:0] COMMON_CFG0 = 16'h0000,
  parameter [15:0] COMMON_CFG1 = 16'h0000,
  parameter [15:0] POR_CFG = 16'h0004,
  parameter [15:0] PPF0_CFG = 16'h0FFF,
  parameter [15:0] PPF1_CFG = 16'h0FFF,
  parameter QPLL0CLKOUT_RATE = "FULL",
  parameter [15:0] QPLL0_CFG0 = 16'h301C,
  parameter [15:0] QPLL0_CFG1 = 16'h0000,
  parameter [15:0] QPLL0_CFG1_G3 = 16'h0020,
  parameter [15:0] QPLL0_CFG2 = 16'h0780,
  parameter [15:0] QPLL0_CFG2_G3 = 16'h0780,
  parameter [15:0] QPLL0_CFG3 = 16'h0120,
  parameter [15:0] QPLL0_CFG4 = 16'h0021,
  parameter [9:0] QPLL0_CP = 10'b0000011111,
  parameter [9:0] QPLL0_CP_G3 = 10'b0000011111,
  parameter integer QPLL0_FBDIV = 66,
  parameter integer QPLL0_FBDIV_G3 = 80,
  parameter [15:0] QPLL0_INIT_CFG0 = 16'h0000,
  parameter [7:0] QPLL0_INIT_CFG1 = 8'h00,
  parameter [15:0] QPLL0_LOCK_CFG = 16'h21E8,
  parameter [15:0] QPLL0_LOCK_CFG_G3 = 16'h21E8,
  parameter [9:0] QPLL0_LPF = 10'b1111111111,
  parameter [9:0] QPLL0_LPF_G3 = 10'b1111111111,
  parameter integer QPLL0_REFCLK_DIV = 2,
  parameter [15:0] QPLL0_SDM_CFG0 = 16'b0000000001000000,
  parameter [15:0] QPLL0_SDM_CFG1 = 16'b0000000000000000,
  parameter [15:0] QPLL0_SDM_CFG2 = 16'b0000000000000000,
  parameter QPLL1CLKOUT_RATE = "FULL",
  parameter [15:0] QPLL1_CFG0 = 16'h301C,
  parameter [15:0] QPLL1_CFG1 = 16'h0000,
  parameter [15:0] QPLL1_CFG1_G3 = 16'h0020,
  parameter [15:0] QPLL1_CFG2 = 16'h0780,
  parameter [15:0] QPLL1_CFG2_G3 = 16'h0780,
  parameter [15:0] QPLL1_CFG3 = 16'h0120,
  parameter [15:0] QPLL1_CFG4 = 16'h0021,
  parameter [9:0] QPLL1_CP = 10'b0000011111,
  parameter [9:0] QPLL1_CP_G3 = 10'b0000011111,
  parameter integer QPLL1_FBDIV = 66,
  parameter integer QPLL1_FBDIV_G3 = 80,
  parameter [15:0] QPLL1_INIT_CFG0 = 16'h0000,
  parameter [7:0] QPLL1_INIT_CFG1 = 8'h00,
  parameter [15:0] QPLL1_LOCK_CFG = 16'h21E8,
  parameter [15:0] QPLL1_LOCK_CFG_G3 = 16'h21E8,
  parameter [9:0] QPLL1_LPF = 10'b1111111111,
  parameter [9:0] QPLL1_LPF_G3 = 10'b1111111111,
  parameter integer QPLL1_REFCLK_DIV = 2,
  parameter [15:0] QPLL1_SDM_CFG0 = 16'b0000000001000000,
  parameter [15:0] QPLL1_SDM_CFG1 = 16'b0000000000000000,
  parameter [15:0] QPLL1_SDM_CFG2 = 16'b0000000000000000,
  parameter [15:0] RSVD_ATTR0 = 16'h0000,
  parameter [15:0] RSVD_ATTR1 = 16'h0000,
  parameter [15:0] RSVD_ATTR2 = 16'h0000,
  parameter [15:0] RSVD_ATTR3 = 16'h0000,
  parameter [1:0] RXRECCLKOUT0_SEL = 2'b00,
  parameter [1:0] RXRECCLKOUT1_SEL = 2'b00,
  parameter [0:0] SARC_EN = 1'b1,
  parameter [0:0] SARC_SEL = 1'b0,
  parameter [15:0] SDM0INITSEED0_0 = 16'b0000000000000000,
  parameter [8:0] SDM0INITSEED0_1 = 9'b000000000,
  parameter [15:0] SDM1INITSEED0_0 = 16'b0000000000000000,
  parameter [8:0] SDM1INITSEED0_1 = 9'b000000000,
  parameter [2:0] SIM_QPLL0REFCLK_SEL = 3'b001,
  parameter [2:0] SIM_QPLL1REFCLK_SEL = 3'b001,
  parameter SIM_RESET_SPEEDUP = "TRUE",
  parameter SIM_VERSION = "Ver_1"
)(
  output [15:0] DRPDO,
  output DRPRDY,
  output [7:0] PMARSVDOUT0,
  output [7:0] PMARSVDOUT1,
  output QPLL0FBCLKLOST,
  output QPLL0LOCK,
  output QPLL0OUTCLK,
  output QPLL0OUTREFCLK,
  output QPLL0REFCLKLOST,
  output QPLL1FBCLKLOST,
  output QPLL1LOCK,
  output QPLL1OUTCLK,
  output QPLL1OUTREFCLK,
  output QPLL1REFCLKLOST,
  output [7:0] QPLLDMONITOR0,
  output [7:0] QPLLDMONITOR1,
  output REFCLKOUTMONITOR0,
  output REFCLKOUTMONITOR1,
  output [1:0] RXRECCLK0_SEL,
  output [1:0] RXRECCLK1_SEL,
  output [3:0] SDM0FINALOUT,
  output [14:0] SDM0TESTDATA,
  output [3:0] SDM1FINALOUT,
  output [14:0] SDM1TESTDATA,

  input BGBYPASSB,
  input BGMONITORENB,
  input BGPDB,
  input [4:0] BGRCALOVRD,
  input BGRCALOVRDENB,
  input [9:0] DRPADDR,
  input DRPCLK,
  input [15:0] DRPDI,
  input DRPEN,
  input DRPWE,
  input GTGREFCLK0,
  input GTGREFCLK1,
  input GTNORTHREFCLK00,
  input GTNORTHREFCLK01,
  input GTNORTHREFCLK10,
  input GTNORTHREFCLK11,
  input GTREFCLK00,
  input GTREFCLK01,
  input GTREFCLK10,
  input GTREFCLK11,
  input GTSOUTHREFCLK00,
  input GTSOUTHREFCLK01,
  input GTSOUTHREFCLK10,
  input GTSOUTHREFCLK11,
  input [7:0] PMARSVD0,
  input [7:0] PMARSVD1,
  input QPLL0CLKRSVD0,
  input QPLL0LOCKDETCLK,
  input QPLL0LOCKEN,
  input QPLL0PD,
  input [2:0] QPLL0REFCLKSEL,
  input QPLL0RESET,
  input QPLL1CLKRSVD0,
  input QPLL1LOCKDETCLK,
  input QPLL1LOCKEN,
  input QPLL1PD,
  input [2:0] QPLL1REFCLKSEL,
  input QPLL1RESET,
  input [7:0] QPLLRSVD1,
  input [4:0] QPLLRSVD2,
  input [4:0] QPLLRSVD3,
  input [7:0] QPLLRSVD4,
  input RCALENB,
  input [24:0] SDM0DATA,
  input SDM0RESET,
  input [1:0] SDM0WIDTH,
  input [24:0] SDM1DATA,
  input SDM1RESET,
  input [1:0] SDM1WIDTH
);
  
// define constants
  localparam MODULE_NAME = "GTYE3_COMMON";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [15:0] A_SDM1DATA1_0_REG = A_SDM1DATA1_0;
  localparam [8:0] A_SDM1DATA1_1_REG = A_SDM1DATA1_1;
  localparam [15:0] BIAS_CFG0_REG = BIAS_CFG0;
  localparam [15:0] BIAS_CFG1_REG = BIAS_CFG1;
  localparam [15:0] BIAS_CFG2_REG = BIAS_CFG2;
  localparam [15:0] BIAS_CFG3_REG = BIAS_CFG3;
  localparam [15:0] BIAS_CFG4_REG = BIAS_CFG4;
  localparam [9:0] BIAS_CFG_RSVD_REG = BIAS_CFG_RSVD;
  localparam [15:0] COMMON_CFG0_REG = COMMON_CFG0;
  localparam [15:0] COMMON_CFG1_REG = COMMON_CFG1;
  localparam [15:0] POR_CFG_REG = POR_CFG;
  localparam [15:0] PPF0_CFG_REG = PPF0_CFG;
  localparam [15:0] PPF1_CFG_REG = PPF1_CFG;
  localparam [32:1] QPLL0CLKOUT_RATE_REG = QPLL0CLKOUT_RATE;
  localparam [15:0] QPLL0_CFG0_REG = QPLL0_CFG0;
  localparam [15:0] QPLL0_CFG1_REG = QPLL0_CFG1;
  localparam [15:0] QPLL0_CFG1_G3_REG = QPLL0_CFG1_G3;
  localparam [15:0] QPLL0_CFG2_REG = QPLL0_CFG2;
  localparam [15:0] QPLL0_CFG2_G3_REG = QPLL0_CFG2_G3;
  localparam [15:0] QPLL0_CFG3_REG = QPLL0_CFG3;
  localparam [15:0] QPLL0_CFG4_REG = QPLL0_CFG4;
  localparam [9:0] QPLL0_CP_REG = QPLL0_CP;
  localparam [9:0] QPLL0_CP_G3_REG = QPLL0_CP_G3;
  localparam [7:0] QPLL0_FBDIV_REG = QPLL0_FBDIV;
  localparam [7:0] QPLL0_FBDIV_G3_REG = QPLL0_FBDIV_G3;
  localparam [15:0] QPLL0_INIT_CFG0_REG = QPLL0_INIT_CFG0;
  localparam [7:0] QPLL0_INIT_CFG1_REG = QPLL0_INIT_CFG1;
  localparam [15:0] QPLL0_LOCK_CFG_REG = QPLL0_LOCK_CFG;
  localparam [15:0] QPLL0_LOCK_CFG_G3_REG = QPLL0_LOCK_CFG_G3;
  localparam [9:0] QPLL0_LPF_REG = QPLL0_LPF;
  localparam [9:0] QPLL0_LPF_G3_REG = QPLL0_LPF_G3;
  localparam [4:0] QPLL0_REFCLK_DIV_REG = QPLL0_REFCLK_DIV;
  localparam [15:0] QPLL0_SDM_CFG0_REG = QPLL0_SDM_CFG0;
  localparam [15:0] QPLL0_SDM_CFG1_REG = QPLL0_SDM_CFG1;
  localparam [15:0] QPLL0_SDM_CFG2_REG = QPLL0_SDM_CFG2;
  localparam [32:1] QPLL1CLKOUT_RATE_REG = QPLL1CLKOUT_RATE;
  localparam [15:0] QPLL1_CFG0_REG = QPLL1_CFG0;
  localparam [15:0] QPLL1_CFG1_REG = QPLL1_CFG1;
  localparam [15:0] QPLL1_CFG1_G3_REG = QPLL1_CFG1_G3;
  localparam [15:0] QPLL1_CFG2_REG = QPLL1_CFG2;
  localparam [15:0] QPLL1_CFG2_G3_REG = QPLL1_CFG2_G3;
  localparam [15:0] QPLL1_CFG3_REG = QPLL1_CFG3;
  localparam [15:0] QPLL1_CFG4_REG = QPLL1_CFG4;
  localparam [9:0] QPLL1_CP_REG = QPLL1_CP;
  localparam [9:0] QPLL1_CP_G3_REG = QPLL1_CP_G3;
  localparam [7:0] QPLL1_FBDIV_REG = QPLL1_FBDIV;
  localparam [7:0] QPLL1_FBDIV_G3_REG = QPLL1_FBDIV_G3;
  localparam [15:0] QPLL1_INIT_CFG0_REG = QPLL1_INIT_CFG0;
  localparam [7:0] QPLL1_INIT_CFG1_REG = QPLL1_INIT_CFG1;
  localparam [15:0] QPLL1_LOCK_CFG_REG = QPLL1_LOCK_CFG;
  localparam [15:0] QPLL1_LOCK_CFG_G3_REG = QPLL1_LOCK_CFG_G3;
  localparam [9:0] QPLL1_LPF_REG = QPLL1_LPF;
  localparam [9:0] QPLL1_LPF_G3_REG = QPLL1_LPF_G3;
  localparam [4:0] QPLL1_REFCLK_DIV_REG = QPLL1_REFCLK_DIV;
  localparam [15:0] QPLL1_SDM_CFG0_REG = QPLL1_SDM_CFG0;
  localparam [15:0] QPLL1_SDM_CFG1_REG = QPLL1_SDM_CFG1;
  localparam [15:0] QPLL1_SDM_CFG2_REG = QPLL1_SDM_CFG2;
  localparam [15:0] RSVD_ATTR0_REG = RSVD_ATTR0;
  localparam [15:0] RSVD_ATTR1_REG = RSVD_ATTR1;
  localparam [15:0] RSVD_ATTR2_REG = RSVD_ATTR2;
  localparam [15:0] RSVD_ATTR3_REG = RSVD_ATTR3;
  localparam [1:0] RXRECCLKOUT0_SEL_REG = RXRECCLKOUT0_SEL;
  localparam [1:0] RXRECCLKOUT1_SEL_REG = RXRECCLKOUT1_SEL;
  localparam [0:0] SARC_EN_REG = SARC_EN;
  localparam [0:0] SARC_SEL_REG = SARC_SEL;
  localparam [15:0] SDM0INITSEED0_0_REG = SDM0INITSEED0_0;
  localparam [8:0] SDM0INITSEED0_1_REG = SDM0INITSEED0_1;
  localparam [15:0] SDM1INITSEED0_0_REG = SDM1INITSEED0_0;
  localparam [8:0] SDM1INITSEED0_1_REG = SDM1INITSEED0_1;
  localparam [2:0] SIM_QPLL0REFCLK_SEL_REG = SIM_QPLL0REFCLK_SEL;
  localparam [2:0] SIM_QPLL1REFCLK_SEL_REG = SIM_QPLL1REFCLK_SEL;
  localparam [40:1] SIM_RESET_SPEEDUP_REG = SIM_RESET_SPEEDUP;
  localparam [56:1] SIM_VERSION_REG = SIM_VERSION;
  `endif

  localparam [0:0] AEN_BGBS0_REG = 1'b0;
  localparam [0:0] AEN_BGBS1_REG = 1'b0;
  localparam [0:0] AEN_MASTER0_REG = 1'b0;
  localparam [0:0] AEN_MASTER1_REG = 1'b0;
  localparam [0:0] AEN_PD0_REG = 1'b0;
  localparam [0:0] AEN_PD1_REG = 1'b0;
  localparam [0:0] AEN_QPLL0_REG = 1'b0;
  localparam [0:0] AEN_QPLL1_REG = 1'b0;
  localparam [0:0] AEN_REFCLK0_REG = 1'b0;
  localparam [0:0] AEN_REFCLK1_REG = 1'b0;
  localparam [0:0] AEN_RESET0_REG = 1'b0;
  localparam [0:0] AEN_RESET1_REG = 1'b0;
  localparam [0:0] AEN_SDMDATA0_REG = 1'b0;
  localparam [0:0] AEN_SDMDATA1_REG = 1'b0;
  localparam [0:0] AEN_SDMRESET0_REG = 1'b0;
  localparam [0:0] AEN_SDMRESET1_REG = 1'b0;
  localparam [0:0] AEN_SDMWIDTH0_REG = 1'b0;
  localparam [0:0] AEN_SDMWIDTH1_REG = 1'b0;
  localparam [3:0] AQDMUXSEL1_REG = 4'b0000;
  localparam [3:0] AVCC_SENSE_SEL_REG = 4'b0000;
  localparam [3:0] AVTT_SENSE_SEL_REG = 4'b0000;
  localparam [0:0] A_BGMONITOREN_REG = 1'b0;
  localparam [0:0] A_BGPD_REG = 1'b0;
  localparam [0:0] A_GTREFCLKPD0_REG = 1'b0;
  localparam [0:0] A_GTREFCLKPD1_REG = 1'b0;
  localparam [0:0] A_QPLL0LOCKEN_REG = 1'b0;
  localparam [0:0] A_QPLL0PD_REG = 1'b0;
  localparam [0:0] A_QPLL0RESET_REG = 1'b0;
  localparam [0:0] A_QPLL1LOCKEN_REG = 1'b0;
  localparam [0:0] A_QPLL1PD_REG = 1'b0;
  localparam [0:0] A_QPLL1RESET_REG = 1'b0;
  localparam [15:0] A_SDM0DATA1_0_REG = 16'b0000000000000000;
  localparam [8:0] A_SDM0DATA1_1_REG = 9'b000000000;
  localparam [0:0] A_SDMRESET0_REG = 1'b0;
  localparam [0:0] A_SDMRESET1_REG = 1'b0;
  localparam [1:0] COMMON_AMUX_SEL0_REG = 2'b00;
  localparam [1:0] COMMON_AMUX_SEL1_REG = 2'b00;
  localparam [0:0] COMMON_INSTANTIATED_REG = 1'b1;
  localparam [2:0] QPLL0_AMONITOR_SEL_REG = 3'b000;
  localparam [0:0] QPLL0_IPS_EN_REG = 1'b1;
  localparam [2:0] QPLL0_IPS_REFCLK_SEL_REG = 3'b000;
  localparam [2:0] QPLL1_AMONITOR_SEL_REG = 3'b000;
  localparam [0:0] QPLL1_IPS_EN_REG = 1'b1;
  localparam [2:0] QPLL1_IPS_REFCLK_SEL_REG = 3'b000;
  localparam [0:0] RCALSAP_TESTEN_REG = 1'b0;
  localparam [0:0] RCAL_APROBE_REG = 1'b0;
  localparam [0:0] REFCLK0_EN_DC_COUP_REG = 1'b0;
  localparam [0:0] REFCLK0_VCM_HIGH_REG = 1'b0;
  localparam [0:0] REFCLK0_VCM_LOW_REG = 1'b0;
  localparam [0:0] REFCLK1_EN_DC_COUP_REG = 1'b0;
  localparam [0:0] REFCLK1_VCM_HIGH_REG = 1'b0;
  localparam [0:0] REFCLK1_VCM_LOW_REG = 1'b0;
  localparam [1:0] VCCAUX_SENSE_SEL_REG = 2'b00;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "GTYE3_COMMON_dr.v"
  `endif

  wire DRPRDY_out;
  wire QPLL0FBCLKLOST_out;
  wire QPLL0LOCK_out;
  wire QPLL0OUTCLK_out;
  wire QPLL0OUTREFCLK_out;
  wire QPLL0REFCLKLOST_out;
  wire QPLL1FBCLKLOST_out;
  wire QPLL1LOCK_out;
  wire QPLL1OUTCLK_out;
  wire QPLL1OUTREFCLK_out;
  wire QPLL1REFCLKLOST_out;
  wire REFCLKOUTMONITOR0_out;
  wire REFCLKOUTMONITOR1_out;
  wire [14:0] SDM0TESTDATA_out;
  wire [14:0] SDM1TESTDATA_out;
  wire [15:0] DRPDO_out;
  wire [1:0] RXRECCLK0_SEL_out;
  wire [1:0] RXRECCLK1_SEL_out;
  wire [3:0] SARCCLK_out;
  wire [3:0] SDM0FINALOUT_out;
  wire [3:0] SDM1FINALOUT_out;
  wire [7:0] PMARSVDOUT0_out;
  wire [7:0] PMARSVDOUT1_out;
  wire [7:0] PMASCANOUT_out;
  wire [7:0] QPLLDMONITOR0_out;
  wire [7:0] QPLLDMONITOR1_out;

  wire DRPRDY_delay;
  wire QPLL0FBCLKLOST_delay;
  wire QPLL0LOCK_delay;
  wire QPLL0OUTCLK_delay;
  wire QPLL0OUTREFCLK_delay;
  wire QPLL0REFCLKLOST_delay;
  wire QPLL1FBCLKLOST_delay;
  wire QPLL1LOCK_delay;
  wire QPLL1OUTCLK_delay;
  wire QPLL1OUTREFCLK_delay;
  wire QPLL1REFCLKLOST_delay;
  wire REFCLKOUTMONITOR0_delay;
  wire REFCLKOUTMONITOR1_delay;
  wire [14:0] SDM0TESTDATA_delay;
  wire [14:0] SDM1TESTDATA_delay;
  wire [15:0] DRPDO_delay;
  wire [1:0] RXRECCLK0_SEL_delay;
  wire [1:0] RXRECCLK1_SEL_delay;
  wire [3:0] SDM0FINALOUT_delay;
  wire [3:0] SDM1FINALOUT_delay;
  wire [7:0] PMARSVDOUT0_delay;
  wire [7:0] PMARSVDOUT1_delay;
  wire [7:0] QPLLDMONITOR0_delay;
  wire [7:0] QPLLDMONITOR1_delay;

  wire BGBYPASSB_in;
  wire BGMONITORENB_in;
  wire BGPDB_in;
  wire BGRCALOVRDENB_in;
  wire DRPCLK_in;
  wire DRPEN_in;
  wire DRPWE_in;
  wire GTGREFCLK0_in;
  wire GTGREFCLK1_in;
  wire GTNORTHREFCLK00_in;
  wire GTNORTHREFCLK01_in;
  wire GTNORTHREFCLK10_in;
  wire GTNORTHREFCLK11_in;
  wire GTREFCLK00_in;
  wire GTREFCLK01_in;
  wire GTREFCLK10_in;
  wire GTREFCLK11_in;
  wire GTSOUTHREFCLK00_in;
  wire GTSOUTHREFCLK01_in;
  wire GTSOUTHREFCLK10_in;
  wire GTSOUTHREFCLK11_in;
  wire PMASCANENB_in;
  wire QDPMASCANMODEB_in;
  wire QDPMASCANRSTEN_in;
  wire QPLL0CLKRSVD0_in;
  wire QPLL0LOCKDETCLK_in;
  wire QPLL0LOCKEN_in;
  wire QPLL0PD_in;
  wire QPLL0RESET_in;
  wire QPLL1CLKRSVD0_in;
  wire QPLL1LOCKDETCLK_in;
  wire QPLL1LOCKEN_in;
  wire QPLL1PD_in;
  wire QPLL1RESET_in;
  wire RCALENB_in;
  wire SDM0RESET_in;
  wire SDM1RESET_in;
  wire [15:0] DRPDI_in;
  wire [1:0] SDM0WIDTH_in;
  wire [1:0] SDM1WIDTH_in;
  wire [24:0] SDM0DATA_in;
  wire [24:0] SDM1DATA_in;
  wire [2:0] QPLL0REFCLKSEL_in;
  wire [2:0] QPLL1REFCLKSEL_in;
  wire [3:0] RXRECCLK_in;
  wire [4:0] BGRCALOVRD_in;
  wire [4:0] QPLLRSVD2_in;
  wire [4:0] QPLLRSVD3_in;
  wire [7:0] PMARSVD0_in;
  wire [7:0] PMARSVD1_in;
  wire [7:0] PMASCANCLK_in;
  wire [7:0] PMASCANIN_in;
  wire [7:0] QPLLRSVD1_in;
  wire [7:0] QPLLRSVD4_in;
  wire [9:0] DRPADDR_in;

  wire BGBYPASSB_delay;
  wire BGMONITORENB_delay;
  wire BGPDB_delay;
  wire BGRCALOVRDENB_delay;
  wire DRPCLK_delay;
  wire DRPEN_delay;
  wire DRPWE_delay;
  wire GTGREFCLK0_delay;
  wire GTGREFCLK1_delay;
  wire GTNORTHREFCLK00_delay;
  wire GTNORTHREFCLK01_delay;
  wire GTNORTHREFCLK10_delay;
  wire GTNORTHREFCLK11_delay;
  wire GTREFCLK00_delay;
  wire GTREFCLK01_delay;
  wire GTREFCLK10_delay;
  wire GTREFCLK11_delay;
  wire GTSOUTHREFCLK00_delay;
  wire GTSOUTHREFCLK01_delay;
  wire GTSOUTHREFCLK10_delay;
  wire GTSOUTHREFCLK11_delay;
  wire QPLL0CLKRSVD0_delay;
  wire QPLL0LOCKDETCLK_delay;
  wire QPLL0LOCKEN_delay;
  wire QPLL0PD_delay;
  wire QPLL0RESET_delay;
  wire QPLL1CLKRSVD0_delay;
  wire QPLL1LOCKDETCLK_delay;
  wire QPLL1LOCKEN_delay;
  wire QPLL1PD_delay;
  wire QPLL1RESET_delay;
  wire RCALENB_delay;
  wire SDM0RESET_delay;
  wire SDM1RESET_delay;
  wire [15:0] DRPDI_delay;
  wire [1:0] SDM0WIDTH_delay;
  wire [1:0] SDM1WIDTH_delay;
  wire [24:0] SDM0DATA_delay;
  wire [24:0] SDM1DATA_delay;
  wire [2:0] QPLL0REFCLKSEL_delay;
  wire [2:0] QPLL1REFCLKSEL_delay;
  wire [4:0] BGRCALOVRD_delay;
  wire [4:0] QPLLRSVD2_delay;
  wire [4:0] QPLLRSVD3_delay;
  wire [7:0] PMARSVD0_delay;
  wire [7:0] PMARSVD1_delay;
  wire [7:0] QPLLRSVD1_delay;
  wire [7:0] QPLLRSVD4_delay;
  wire [9:0] DRPADDR_delay;

  
  assign #(out_delay) DRPDO = DRPDO_delay;
  assign #(out_delay) DRPRDY = DRPRDY_delay;
  assign #(out_delay) PMARSVDOUT0 = PMARSVDOUT0_delay;
  assign #(out_delay) PMARSVDOUT1 = PMARSVDOUT1_delay;
  assign #(out_delay) QPLL0FBCLKLOST = QPLL0FBCLKLOST_delay;
  assign #(out_delay) QPLL0LOCK = QPLL0LOCK_delay;
  assign #(out_delay) QPLL0OUTCLK = QPLL0OUTCLK_delay;
  assign #(out_delay) QPLL0OUTREFCLK = QPLL0OUTREFCLK_delay;
  assign #(out_delay) QPLL0REFCLKLOST = QPLL0REFCLKLOST_delay;
  assign #(out_delay) QPLL1FBCLKLOST = QPLL1FBCLKLOST_delay;
  assign #(out_delay) QPLL1LOCK = QPLL1LOCK_delay;
  assign #(out_delay) QPLL1OUTCLK = QPLL1OUTCLK_delay;
  assign #(out_delay) QPLL1OUTREFCLK = QPLL1OUTREFCLK_delay;
  assign #(out_delay) QPLL1REFCLKLOST = QPLL1REFCLKLOST_delay;
  assign #(out_delay) QPLLDMONITOR0 = QPLLDMONITOR0_delay;
  assign #(out_delay) QPLLDMONITOR1 = QPLLDMONITOR1_delay;
  assign #(out_delay) REFCLKOUTMONITOR0 = REFCLKOUTMONITOR0_delay;
  assign #(out_delay) REFCLKOUTMONITOR1 = REFCLKOUTMONITOR1_delay;
  assign #(out_delay) RXRECCLK0_SEL = RXRECCLK0_SEL_delay;
  assign #(out_delay) RXRECCLK1_SEL = RXRECCLK1_SEL_delay;
  assign #(out_delay) SDM0FINALOUT = SDM0FINALOUT_delay;
  assign #(out_delay) SDM0TESTDATA = SDM0TESTDATA_delay;
  assign #(out_delay) SDM1FINALOUT = SDM1FINALOUT_delay;
  assign #(out_delay) SDM1TESTDATA = SDM1TESTDATA_delay;
  

// inputs with no timing checks
  assign #(inclk_delay) DRPCLK_delay = DRPCLK;
  assign #(inclk_delay) GTGREFCLK0_delay = GTGREFCLK0;
  assign #(inclk_delay) GTGREFCLK1_delay = GTGREFCLK1;
  assign #(inclk_delay) GTNORTHREFCLK00_delay = GTNORTHREFCLK00;
  assign #(inclk_delay) GTNORTHREFCLK01_delay = GTNORTHREFCLK01;
  assign #(inclk_delay) GTNORTHREFCLK10_delay = GTNORTHREFCLK10;
  assign #(inclk_delay) GTNORTHREFCLK11_delay = GTNORTHREFCLK11;
  assign #(inclk_delay) GTREFCLK00_delay = GTREFCLK00;
  assign #(inclk_delay) GTREFCLK01_delay = GTREFCLK01;
  assign #(inclk_delay) GTREFCLK10_delay = GTREFCLK10;
  assign #(inclk_delay) GTREFCLK11_delay = GTREFCLK11;
  assign #(inclk_delay) GTSOUTHREFCLK00_delay = GTSOUTHREFCLK00;
  assign #(inclk_delay) GTSOUTHREFCLK01_delay = GTSOUTHREFCLK01;
  assign #(inclk_delay) GTSOUTHREFCLK10_delay = GTSOUTHREFCLK10;
  assign #(inclk_delay) GTSOUTHREFCLK11_delay = GTSOUTHREFCLK11;
  assign #(inclk_delay) QPLL0CLKRSVD0_delay = QPLL0CLKRSVD0;
  assign #(inclk_delay) QPLL0LOCKDETCLK_delay = QPLL0LOCKDETCLK;
  assign #(inclk_delay) QPLL1CLKRSVD0_delay = QPLL1CLKRSVD0;
  assign #(inclk_delay) QPLL1LOCKDETCLK_delay = QPLL1LOCKDETCLK;

  assign #(in_delay) BGBYPASSB_delay = BGBYPASSB;
  assign #(in_delay) BGMONITORENB_delay = BGMONITORENB;
  assign #(in_delay) BGPDB_delay = BGPDB;
  assign #(in_delay) BGRCALOVRDENB_delay = BGRCALOVRDENB;
  assign #(in_delay) BGRCALOVRD_delay = BGRCALOVRD;
  assign #(in_delay) DRPADDR_delay = DRPADDR;
  assign #(in_delay) DRPDI_delay = DRPDI;
  assign #(in_delay) DRPEN_delay = DRPEN;
  assign #(in_delay) DRPWE_delay = DRPWE;
  assign #(in_delay) PMARSVD0_delay = PMARSVD0;
  assign #(in_delay) PMARSVD1_delay = PMARSVD1;
  assign #(in_delay) QPLL0LOCKEN_delay = QPLL0LOCKEN;
  assign #(in_delay) QPLL0PD_delay = QPLL0PD;
  assign #(in_delay) QPLL0REFCLKSEL_delay = QPLL0REFCLKSEL;
  assign #(in_delay) QPLL0RESET_delay = QPLL0RESET;
  assign #(in_delay) QPLL1LOCKEN_delay = QPLL1LOCKEN;
  assign #(in_delay) QPLL1PD_delay = QPLL1PD;
  assign #(in_delay) QPLL1REFCLKSEL_delay = QPLL1REFCLKSEL;
  assign #(in_delay) QPLL1RESET_delay = QPLL1RESET;
  assign #(in_delay) QPLLRSVD1_delay = QPLLRSVD1;
  assign #(in_delay) QPLLRSVD2_delay = QPLLRSVD2;
  assign #(in_delay) QPLLRSVD3_delay = QPLLRSVD3;
  assign #(in_delay) QPLLRSVD4_delay = QPLLRSVD4;
  assign #(in_delay) RCALENB_delay = RCALENB;
  assign #(in_delay) SDM0DATA_delay = SDM0DATA;
  assign #(in_delay) SDM0RESET_delay = SDM0RESET;
  assign #(in_delay) SDM0WIDTH_delay = SDM0WIDTH;
  assign #(in_delay) SDM1DATA_delay = SDM1DATA;
  assign #(in_delay) SDM1RESET_delay = SDM1RESET;
  assign #(in_delay) SDM1WIDTH_delay = SDM1WIDTH;

  assign DRPDO_delay = DRPDO_out;
  assign DRPRDY_delay = DRPRDY_out;
  assign PMARSVDOUT0_delay = PMARSVDOUT0_out;
  assign PMARSVDOUT1_delay = PMARSVDOUT1_out;
  assign QPLL0FBCLKLOST_delay = QPLL0FBCLKLOST_out;
  assign QPLL0LOCK_delay = QPLL0LOCK_out;
  assign QPLL0OUTCLK_delay = QPLL0OUTCLK_out;
  assign QPLL0OUTREFCLK_delay = QPLL0OUTREFCLK_out;
  assign QPLL0REFCLKLOST_delay = QPLL0REFCLKLOST_out;
  assign QPLL1FBCLKLOST_delay = QPLL1FBCLKLOST_out;
  assign QPLL1LOCK_delay = QPLL1LOCK_out;
  assign QPLL1OUTCLK_delay = QPLL1OUTCLK_out;
  assign QPLL1OUTREFCLK_delay = QPLL1OUTREFCLK_out;
  assign QPLL1REFCLKLOST_delay = QPLL1REFCLKLOST_out;
  assign QPLLDMONITOR0_delay = QPLLDMONITOR0_out;
  assign QPLLDMONITOR1_delay = QPLLDMONITOR1_out;
  assign REFCLKOUTMONITOR0_delay = REFCLKOUTMONITOR0_out;
  assign REFCLKOUTMONITOR1_delay = REFCLKOUTMONITOR1_out;
  assign RXRECCLK0_SEL_delay = RXRECCLK0_SEL_out;
  assign RXRECCLK1_SEL_delay = RXRECCLK1_SEL_out;
  assign SDM0FINALOUT_delay = SDM0FINALOUT_out;
  assign SDM0TESTDATA_delay = SDM0TESTDATA_out;
  assign SDM1FINALOUT_delay = SDM1FINALOUT_out;
  assign SDM1TESTDATA_delay = SDM1TESTDATA_out;

  assign BGBYPASSB_in = BGBYPASSB_delay;
  assign BGMONITORENB_in = BGMONITORENB_delay;
  assign BGPDB_in = BGPDB_delay;
  assign BGRCALOVRDENB_in = BGRCALOVRDENB_delay;
  assign BGRCALOVRD_in = BGRCALOVRD_delay;
  assign DRPADDR_in = DRPADDR_delay;
  assign DRPCLK_in = DRPCLK_delay;
  assign DRPDI_in = DRPDI_delay;
  assign DRPEN_in = DRPEN_delay;
  assign DRPWE_in = DRPWE_delay;
  assign GTGREFCLK0_in = GTGREFCLK0_delay;
  assign GTGREFCLK1_in = GTGREFCLK1_delay;
  assign GTNORTHREFCLK00_in = GTNORTHREFCLK00_delay;
  assign GTNORTHREFCLK01_in = GTNORTHREFCLK01_delay;
  assign GTNORTHREFCLK10_in = GTNORTHREFCLK10_delay;
  assign GTNORTHREFCLK11_in = GTNORTHREFCLK11_delay;
  assign GTREFCLK00_in = GTREFCLK00_delay;
  assign GTREFCLK01_in = GTREFCLK01_delay;
  assign GTREFCLK10_in = GTREFCLK10_delay;
  assign GTREFCLK11_in = GTREFCLK11_delay;
  assign GTSOUTHREFCLK00_in = GTSOUTHREFCLK00_delay;
  assign GTSOUTHREFCLK01_in = GTSOUTHREFCLK01_delay;
  assign GTSOUTHREFCLK10_in = GTSOUTHREFCLK10_delay;
  assign GTSOUTHREFCLK11_in = GTSOUTHREFCLK11_delay;
  assign PMARSVD0_in = PMARSVD0_delay;
  assign PMARSVD1_in = PMARSVD1_delay;
  assign QPLL0CLKRSVD0_in = QPLL0CLKRSVD0_delay;
  assign QPLL0LOCKDETCLK_in = QPLL0LOCKDETCLK_delay;
  assign QPLL0LOCKEN_in = QPLL0LOCKEN_delay;
  assign QPLL0PD_in = QPLL0PD_delay;
  assign QPLL0REFCLKSEL_in = QPLL0REFCLKSEL_delay;
  assign QPLL0RESET_in = QPLL0RESET_delay;
  assign QPLL1CLKRSVD0_in = QPLL1CLKRSVD0_delay;
  assign QPLL1LOCKDETCLK_in = QPLL1LOCKDETCLK_delay;
  assign QPLL1LOCKEN_in = QPLL1LOCKEN_delay;
  assign QPLL1PD_in = QPLL1PD_delay;
  assign QPLL1REFCLKSEL_in = QPLL1REFCLKSEL_delay;
  assign QPLL1RESET_in = QPLL1RESET_delay;
  assign QPLLRSVD1_in = QPLLRSVD1_delay;
  assign QPLLRSVD2_in = QPLLRSVD2_delay;
  assign QPLLRSVD3_in = QPLLRSVD3_delay;
  assign QPLLRSVD4_in = QPLLRSVD4_delay;
  assign RCALENB_in = RCALENB_delay;
  assign SDM0DATA_in = SDM0DATA_delay;
  assign SDM0RESET_in = SDM0RESET_delay;
  assign SDM0WIDTH_in = SDM0WIDTH_delay;
  assign SDM1DATA_in = SDM1DATA_delay;
  assign SDM1RESET_in = SDM1RESET_delay;
  assign SDM1WIDTH_in = SDM1WIDTH_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
    #1;
    if ((A_SDM1DATA1_0_REG < 16'b0000000000000000) || (A_SDM1DATA1_0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute A_SDM1DATA1_0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, A_SDM1DATA1_0_REG);
      attr_err = 1'b1;
    end

    if ((A_SDM1DATA1_1_REG < 9'b000000000) || (A_SDM1DATA1_1_REG > 9'b111111111)) begin
      $display("Attribute Syntax Error : The attribute A_SDM1DATA1_1 on %s instance %m is set to %b.  Legal values for this attribute are 9'b000000000 to 9'b111111111.", MODULE_NAME, A_SDM1DATA1_1_REG);
      attr_err = 1'b1;
    end

    if ((BIAS_CFG_RSVD_REG < 10'b0000000000) || (BIAS_CFG_RSVD_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute BIAS_CFG_RSVD on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, BIAS_CFG_RSVD_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0CLKOUT_RATE_REG != "FULL") &&
        (QPLL0CLKOUT_RATE_REG != "HALF")) begin
      $display("Attribute Syntax Error : The attribute QPLL0CLKOUT_RATE on %s instance %m is set to %s.  Legal values for this attribute are FULL or HALF.", MODULE_NAME, QPLL0CLKOUT_RATE_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_CP_G3_REG < 10'b0000000000) || (QPLL0_CP_G3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_CP_G3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL0_CP_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_CP_REG < 10'b0000000000) || (QPLL0_CP_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_CP on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL0_CP_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_FBDIV_G3_REG < 16) || (QPLL0_FBDIV_G3_REG > 160)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_FBDIV_G3 on %s instance %m is set to %d.  Legal values for this attribute are  16 to 160.", MODULE_NAME, QPLL0_FBDIV_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_FBDIV_REG < 16) || (QPLL0_FBDIV_REG > 160)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_FBDIV on %s instance %m is set to %d.  Legal values for this attribute are  16 to 160.", MODULE_NAME, QPLL0_FBDIV_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_LPF_G3_REG < 10'b0000000000) || (QPLL0_LPF_G3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_LPF_G3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL0_LPF_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_LPF_REG < 10'b0000000000) || (QPLL0_LPF_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_LPF on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL0_LPF_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_REFCLK_DIV_REG != 2) &&
        (QPLL0_REFCLK_DIV_REG != 1) &&
        (QPLL0_REFCLK_DIV_REG != 3) &&
        (QPLL0_REFCLK_DIV_REG != 4) &&
        (QPLL0_REFCLK_DIV_REG != 5) &&
        (QPLL0_REFCLK_DIV_REG != 6) &&
        (QPLL0_REFCLK_DIV_REG != 8) &&
        (QPLL0_REFCLK_DIV_REG != 10) &&
        (QPLL0_REFCLK_DIV_REG != 12) &&
        (QPLL0_REFCLK_DIV_REG != 16) &&
        (QPLL0_REFCLK_DIV_REG != 20)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_REFCLK_DIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 20.", MODULE_NAME, QPLL0_REFCLK_DIV_REG, 2);
      attr_err = 1'b1;
    end

    if ((QPLL0_SDM_CFG0_REG < 16'b0000000000000000) || (QPLL0_SDM_CFG0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_SDM_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL0_SDM_CFG0_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_SDM_CFG1_REG < 16'b0000000000000000) || (QPLL0_SDM_CFG1_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_SDM_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL0_SDM_CFG1_REG);
      attr_err = 1'b1;
    end

    if ((QPLL0_SDM_CFG2_REG < 16'b0000000000000000) || (QPLL0_SDM_CFG2_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL0_SDM_CFG2 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL0_SDM_CFG2_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1CLKOUT_RATE_REG != "FULL") &&
        (QPLL1CLKOUT_RATE_REG != "HALF")) begin
      $display("Attribute Syntax Error : The attribute QPLL1CLKOUT_RATE on %s instance %m is set to %s.  Legal values for this attribute are FULL or HALF.", MODULE_NAME, QPLL1CLKOUT_RATE_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_CP_G3_REG < 10'b0000000000) || (QPLL1_CP_G3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_CP_G3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL1_CP_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_CP_REG < 10'b0000000000) || (QPLL1_CP_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_CP on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL1_CP_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_FBDIV_G3_REG < 16) || (QPLL1_FBDIV_G3_REG > 160)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_FBDIV_G3 on %s instance %m is set to %d.  Legal values for this attribute are  16 to 160.", MODULE_NAME, QPLL1_FBDIV_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_FBDIV_REG < 16) || (QPLL1_FBDIV_REG > 160)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_FBDIV on %s instance %m is set to %d.  Legal values for this attribute are  16 to 160.", MODULE_NAME, QPLL1_FBDIV_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_LPF_G3_REG < 10'b0000000000) || (QPLL1_LPF_G3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_LPF_G3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL1_LPF_G3_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_LPF_REG < 10'b0000000000) || (QPLL1_LPF_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_LPF on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, QPLL1_LPF_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_REFCLK_DIV_REG != 2) &&
        (QPLL1_REFCLK_DIV_REG != 1) &&
        (QPLL1_REFCLK_DIV_REG != 3) &&
        (QPLL1_REFCLK_DIV_REG != 4) &&
        (QPLL1_REFCLK_DIV_REG != 5) &&
        (QPLL1_REFCLK_DIV_REG != 6) &&
        (QPLL1_REFCLK_DIV_REG != 8) &&
        (QPLL1_REFCLK_DIV_REG != 10) &&
        (QPLL1_REFCLK_DIV_REG != 12) &&
        (QPLL1_REFCLK_DIV_REG != 16) &&
        (QPLL1_REFCLK_DIV_REG != 20)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_REFCLK_DIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 20.", MODULE_NAME, QPLL1_REFCLK_DIV_REG, 2);
      attr_err = 1'b1;
    end

    if ((QPLL1_SDM_CFG0_REG < 16'b0000000000000000) || (QPLL1_SDM_CFG0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_SDM_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL1_SDM_CFG0_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_SDM_CFG1_REG < 16'b0000000000000000) || (QPLL1_SDM_CFG1_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_SDM_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL1_SDM_CFG1_REG);
      attr_err = 1'b1;
    end

    if ((QPLL1_SDM_CFG2_REG < 16'b0000000000000000) || (QPLL1_SDM_CFG2_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute QPLL1_SDM_CFG2 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, QPLL1_SDM_CFG2_REG);
      attr_err = 1'b1;
    end

    if ((RXRECCLKOUT0_SEL_REG < 2'b00) || (RXRECCLKOUT0_SEL_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RXRECCLKOUT0_SEL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RXRECCLKOUT0_SEL_REG);
      attr_err = 1'b1;
    end

    if ((RXRECCLKOUT1_SEL_REG < 2'b00) || (RXRECCLKOUT1_SEL_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RXRECCLKOUT1_SEL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RXRECCLKOUT1_SEL_REG);
      attr_err = 1'b1;
    end

    if ((SARC_EN_REG < 1'b0) || (SARC_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute SARC_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, SARC_EN_REG);
      attr_err = 1'b1;
    end

    if ((SARC_SEL_REG < 1'b0) || (SARC_SEL_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute SARC_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, SARC_SEL_REG);
      attr_err = 1'b1;
    end

    if ((SDM0INITSEED0_0_REG < 16'b0000000000000000) || (SDM0INITSEED0_0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute SDM0INITSEED0_0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, SDM0INITSEED0_0_REG);
      attr_err = 1'b1;
    end

    if ((SDM0INITSEED0_1_REG < 9'b000000000) || (SDM0INITSEED0_1_REG > 9'b111111111)) begin
      $display("Attribute Syntax Error : The attribute SDM0INITSEED0_1 on %s instance %m is set to %b.  Legal values for this attribute are 9'b000000000 to 9'b111111111.", MODULE_NAME, SDM0INITSEED0_1_REG);
      attr_err = 1'b1;
    end

    if ((SDM1INITSEED0_0_REG < 16'b0000000000000000) || (SDM1INITSEED0_0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute SDM1INITSEED0_0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, SDM1INITSEED0_0_REG);
      attr_err = 1'b1;
    end

    if ((SDM1INITSEED0_1_REG < 9'b000000000) || (SDM1INITSEED0_1_REG > 9'b111111111)) begin
      $display("Attribute Syntax Error : The attribute SDM1INITSEED0_1 on %s instance %m is set to %b.  Legal values for this attribute are 9'b000000000 to 9'b111111111.", MODULE_NAME, SDM1INITSEED0_1_REG);
      attr_err = 1'b1;
    end

    if ((SIM_QPLL0REFCLK_SEL_REG < 3'b000) || (SIM_QPLL0REFCLK_SEL_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute SIM_QPLL0REFCLK_SEL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, SIM_QPLL0REFCLK_SEL_REG);
      attr_err = 1'b1;
    end

    if ((SIM_QPLL1REFCLK_SEL_REG < 3'b000) || (SIM_QPLL1REFCLK_SEL_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute SIM_QPLL1REFCLK_SEL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, SIM_QPLL1REFCLK_SEL_REG);
      attr_err = 1'b1;
    end

    if ((SIM_RESET_SPEEDUP_REG != "TRUE") &&
        (SIM_RESET_SPEEDUP_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute SIM_RESET_SPEEDUP on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SIM_RESET_SPEEDUP_REG);
      attr_err = 1'b1;
    end

    if ((SIM_VERSION_REG != "Ver_1") &&
        (SIM_VERSION_REG != "Ver_1_1") &&
        (SIM_VERSION_REG != "Ver_2")) begin
      $display("Attribute Syntax Error : The attribute SIM_VERSION on %s instance %m is set to %s.  Legal values for this attribute are Ver_1, Ver_1_1 or Ver_2.", MODULE_NAME, SIM_VERSION_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

  assign PMASCANCLK_in = 8'b11111111; // tie off

  assign PMASCANENB_in = 1'b1; // tie off
  assign PMASCANIN_in = 8'b11111111; // tie off
  assign QDPMASCANMODEB_in = 1'b1; // tie off
  assign QDPMASCANRSTEN_in = 1'b1; // tie off
  assign RXRECCLK_in = 4'b1111; // tie off

  SIP_GTYE3_COMMON SIP_GTYE3_COMMON_INST (
    .AEN_BGBS0 (AEN_BGBS0_REG),
    .AEN_BGBS1 (AEN_BGBS1_REG),
    .AEN_MASTER0 (AEN_MASTER0_REG),
    .AEN_MASTER1 (AEN_MASTER1_REG),
    .AEN_PD0 (AEN_PD0_REG),
    .AEN_PD1 (AEN_PD1_REG),
    .AEN_QPLL0 (AEN_QPLL0_REG),
    .AEN_QPLL1 (AEN_QPLL1_REG),
    .AEN_REFCLK0 (AEN_REFCLK0_REG),
    .AEN_REFCLK1 (AEN_REFCLK1_REG),
    .AEN_RESET0 (AEN_RESET0_REG),
    .AEN_RESET1 (AEN_RESET1_REG),
    .AEN_SDMDATA0 (AEN_SDMDATA0_REG),
    .AEN_SDMDATA1 (AEN_SDMDATA1_REG),
    .AEN_SDMRESET0 (AEN_SDMRESET0_REG),
    .AEN_SDMRESET1 (AEN_SDMRESET1_REG),
    .AEN_SDMWIDTH0 (AEN_SDMWIDTH0_REG),
    .AEN_SDMWIDTH1 (AEN_SDMWIDTH1_REG),
    .AQDMUXSEL1 (AQDMUXSEL1_REG),
    .AVCC_SENSE_SEL (AVCC_SENSE_SEL_REG),
    .AVTT_SENSE_SEL (AVTT_SENSE_SEL_REG),
    .A_BGMONITOREN (A_BGMONITOREN_REG),
    .A_BGPD (A_BGPD_REG),
    .A_GTREFCLKPD0 (A_GTREFCLKPD0_REG),
    .A_GTREFCLKPD1 (A_GTREFCLKPD1_REG),
    .A_QPLL0LOCKEN (A_QPLL0LOCKEN_REG),
    .A_QPLL0PD (A_QPLL0PD_REG),
    .A_QPLL0RESET (A_QPLL0RESET_REG),
    .A_QPLL1LOCKEN (A_QPLL1LOCKEN_REG),
    .A_QPLL1PD (A_QPLL1PD_REG),
    .A_QPLL1RESET (A_QPLL1RESET_REG),
    .A_SDM0DATA1_0 (A_SDM0DATA1_0_REG),
    .A_SDM0DATA1_1 (A_SDM0DATA1_1_REG),
    .A_SDM1DATA1_0 (A_SDM1DATA1_0_REG),
    .A_SDM1DATA1_1 (A_SDM1DATA1_1_REG),
    .A_SDMRESET0 (A_SDMRESET0_REG),
    .A_SDMRESET1 (A_SDMRESET1_REG),
    .BIAS_CFG0 (BIAS_CFG0_REG),
    .BIAS_CFG1 (BIAS_CFG1_REG),
    .BIAS_CFG2 (BIAS_CFG2_REG),
    .BIAS_CFG3 (BIAS_CFG3_REG),
    .BIAS_CFG4 (BIAS_CFG4_REG),
    .BIAS_CFG_RSVD (BIAS_CFG_RSVD_REG),
    .COMMON_AMUX_SEL0 (COMMON_AMUX_SEL0_REG),
    .COMMON_AMUX_SEL1 (COMMON_AMUX_SEL1_REG),
    .COMMON_CFG0 (COMMON_CFG0_REG),
    .COMMON_CFG1 (COMMON_CFG1_REG),
    .COMMON_INSTANTIATED (COMMON_INSTANTIATED_REG),
    .POR_CFG (POR_CFG_REG),
    .PPF0_CFG (PPF0_CFG_REG),
    .PPF1_CFG (PPF1_CFG_REG),
    .QPLL0CLKOUT_RATE (QPLL0CLKOUT_RATE_REG),
    .QPLL0_AMONITOR_SEL (QPLL0_AMONITOR_SEL_REG),
    .QPLL0_CFG0 (QPLL0_CFG0_REG),
    .QPLL0_CFG1 (QPLL0_CFG1_REG),
    .QPLL0_CFG1_G3 (QPLL0_CFG1_G3_REG),
    .QPLL0_CFG2 (QPLL0_CFG2_REG),
    .QPLL0_CFG2_G3 (QPLL0_CFG2_G3_REG),
    .QPLL0_CFG3 (QPLL0_CFG3_REG),
    .QPLL0_CFG4 (QPLL0_CFG4_REG),
    .QPLL0_CP (QPLL0_CP_REG),
    .QPLL0_CP_G3 (QPLL0_CP_G3_REG),
    .QPLL0_FBDIV (QPLL0_FBDIV_REG),
    .QPLL0_FBDIV_G3 (QPLL0_FBDIV_G3_REG),
    .QPLL0_INIT_CFG0 (QPLL0_INIT_CFG0_REG),
    .QPLL0_INIT_CFG1 (QPLL0_INIT_CFG1_REG),
    .QPLL0_IPS_EN (QPLL0_IPS_EN_REG),
    .QPLL0_IPS_REFCLK_SEL (QPLL0_IPS_REFCLK_SEL_REG),
    .QPLL0_LOCK_CFG (QPLL0_LOCK_CFG_REG),
    .QPLL0_LOCK_CFG_G3 (QPLL0_LOCK_CFG_G3_REG),
    .QPLL0_LPF (QPLL0_LPF_REG),
    .QPLL0_LPF_G3 (QPLL0_LPF_G3_REG),
    .QPLL0_REFCLK_DIV (QPLL0_REFCLK_DIV_REG),
    .QPLL0_SDM_CFG0 (QPLL0_SDM_CFG0_REG),
    .QPLL0_SDM_CFG1 (QPLL0_SDM_CFG1_REG),
    .QPLL0_SDM_CFG2 (QPLL0_SDM_CFG2_REG),
    .QPLL1CLKOUT_RATE (QPLL1CLKOUT_RATE_REG),
    .QPLL1_AMONITOR_SEL (QPLL1_AMONITOR_SEL_REG),
    .QPLL1_CFG0 (QPLL1_CFG0_REG),
    .QPLL1_CFG1 (QPLL1_CFG1_REG),
    .QPLL1_CFG1_G3 (QPLL1_CFG1_G3_REG),
    .QPLL1_CFG2 (QPLL1_CFG2_REG),
    .QPLL1_CFG2_G3 (QPLL1_CFG2_G3_REG),
    .QPLL1_CFG3 (QPLL1_CFG3_REG),
    .QPLL1_CFG4 (QPLL1_CFG4_REG),
    .QPLL1_CP (QPLL1_CP_REG),
    .QPLL1_CP_G3 (QPLL1_CP_G3_REG),
    .QPLL1_FBDIV (QPLL1_FBDIV_REG),
    .QPLL1_FBDIV_G3 (QPLL1_FBDIV_G3_REG),
    .QPLL1_INIT_CFG0 (QPLL1_INIT_CFG0_REG),
    .QPLL1_INIT_CFG1 (QPLL1_INIT_CFG1_REG),
    .QPLL1_IPS_EN (QPLL1_IPS_EN_REG),
    .QPLL1_IPS_REFCLK_SEL (QPLL1_IPS_REFCLK_SEL_REG),
    .QPLL1_LOCK_CFG (QPLL1_LOCK_CFG_REG),
    .QPLL1_LOCK_CFG_G3 (QPLL1_LOCK_CFG_G3_REG),
    .QPLL1_LPF (QPLL1_LPF_REG),
    .QPLL1_LPF_G3 (QPLL1_LPF_G3_REG),
    .QPLL1_REFCLK_DIV (QPLL1_REFCLK_DIV_REG),
    .QPLL1_SDM_CFG0 (QPLL1_SDM_CFG0_REG),
    .QPLL1_SDM_CFG1 (QPLL1_SDM_CFG1_REG),
    .QPLL1_SDM_CFG2 (QPLL1_SDM_CFG2_REG),
    .RCALSAP_TESTEN (RCALSAP_TESTEN_REG),
    .RCAL_APROBE (RCAL_APROBE_REG),
    .REFCLK0_EN_DC_COUP (REFCLK0_EN_DC_COUP_REG),
    .REFCLK0_VCM_HIGH (REFCLK0_VCM_HIGH_REG),
    .REFCLK0_VCM_LOW (REFCLK0_VCM_LOW_REG),
    .REFCLK1_EN_DC_COUP (REFCLK1_EN_DC_COUP_REG),
    .REFCLK1_VCM_HIGH (REFCLK1_VCM_HIGH_REG),
    .REFCLK1_VCM_LOW (REFCLK1_VCM_LOW_REG),
    .RSVD_ATTR0 (RSVD_ATTR0_REG),
    .RSVD_ATTR1 (RSVD_ATTR1_REG),
    .RSVD_ATTR2 (RSVD_ATTR2_REG),
    .RSVD_ATTR3 (RSVD_ATTR3_REG),
    .RXRECCLKOUT0_SEL (RXRECCLKOUT0_SEL_REG),
    .RXRECCLKOUT1_SEL (RXRECCLKOUT1_SEL_REG),
    .SARC_EN (SARC_EN_REG),
    .SARC_SEL (SARC_SEL_REG),
    .SDM0INITSEED0_0 (SDM0INITSEED0_0_REG),
    .SDM0INITSEED0_1 (SDM0INITSEED0_1_REG),
    .SDM1INITSEED0_0 (SDM1INITSEED0_0_REG),
    .SDM1INITSEED0_1 (SDM1INITSEED0_1_REG),
    .VCCAUX_SENSE_SEL (VCCAUX_SENSE_SEL_REG),
    .DRPDO (DRPDO_out),
    .DRPRDY (DRPRDY_out),
    .PMARSVDOUT0 (PMARSVDOUT0_out),
    .PMARSVDOUT1 (PMARSVDOUT1_out),
    .PMASCANOUT (PMASCANOUT_out),
    .QPLL0FBCLKLOST (QPLL0FBCLKLOST_out),
    .QPLL0LOCK (QPLL0LOCK_out),
    .QPLL0OUTCLK (QPLL0OUTCLK_out),
    .QPLL0OUTREFCLK (QPLL0OUTREFCLK_out),
    .QPLL0REFCLKLOST (QPLL0REFCLKLOST_out),
    .QPLL1FBCLKLOST (QPLL1FBCLKLOST_out),
    .QPLL1LOCK (QPLL1LOCK_out),
    .QPLL1OUTCLK (QPLL1OUTCLK_out),
    .QPLL1OUTREFCLK (QPLL1OUTREFCLK_out),
    .QPLL1REFCLKLOST (QPLL1REFCLKLOST_out),
    .QPLLDMONITOR0 (QPLLDMONITOR0_out),
    .QPLLDMONITOR1 (QPLLDMONITOR1_out),
    .REFCLKOUTMONITOR0 (REFCLKOUTMONITOR0_out),
    .REFCLKOUTMONITOR1 (REFCLKOUTMONITOR1_out),
    .RXRECCLK0_SEL (RXRECCLK0_SEL_out),
    .RXRECCLK1_SEL (RXRECCLK1_SEL_out),
    .SARCCLK (SARCCLK_out),
    .SDM0FINALOUT (SDM0FINALOUT_out),
    .SDM0TESTDATA (SDM0TESTDATA_out),
    .SDM1FINALOUT (SDM1FINALOUT_out),
    .SDM1TESTDATA (SDM1TESTDATA_out),
    .BGBYPASSB (BGBYPASSB_in),
    .BGMONITORENB (BGMONITORENB_in),
    .BGPDB (BGPDB_in),
    .BGRCALOVRD (BGRCALOVRD_in),
    .BGRCALOVRDENB (BGRCALOVRDENB_in),
    .DRPADDR (DRPADDR_in),
    .DRPCLK (DRPCLK_in),
    .DRPDI (DRPDI_in),
    .DRPEN (DRPEN_in),
    .DRPWE (DRPWE_in),
    .GTGREFCLK0 (GTGREFCLK0_in),
    .GTGREFCLK1 (GTGREFCLK1_in),
    .GTNORTHREFCLK00 (GTNORTHREFCLK00_in),
    .GTNORTHREFCLK01 (GTNORTHREFCLK01_in),
    .GTNORTHREFCLK10 (GTNORTHREFCLK10_in),
    .GTNORTHREFCLK11 (GTNORTHREFCLK11_in),
    .GTREFCLK00 (GTREFCLK00_in),
    .GTREFCLK01 (GTREFCLK01_in),
    .GTREFCLK10 (GTREFCLK10_in),
    .GTREFCLK11 (GTREFCLK11_in),
    .GTSOUTHREFCLK00 (GTSOUTHREFCLK00_in),
    .GTSOUTHREFCLK01 (GTSOUTHREFCLK01_in),
    .GTSOUTHREFCLK10 (GTSOUTHREFCLK10_in),
    .GTSOUTHREFCLK11 (GTSOUTHREFCLK11_in),
    .PMARSVD0 (PMARSVD0_in),
    .PMARSVD1 (PMARSVD1_in),
    .PMASCANCLK (PMASCANCLK_in),
    .PMASCANENB (PMASCANENB_in),
    .PMASCANIN (PMASCANIN_in),
    .QDPMASCANMODEB (QDPMASCANMODEB_in),
    .QDPMASCANRSTEN (QDPMASCANRSTEN_in),
    .QPLL0CLKRSVD0 (QPLL0CLKRSVD0_in),
    .QPLL0LOCKDETCLK (QPLL0LOCKDETCLK_in),
    .QPLL0LOCKEN (QPLL0LOCKEN_in),
    .QPLL0PD (QPLL0PD_in),
    .QPLL0REFCLKSEL (QPLL0REFCLKSEL_in),
    .QPLL0RESET (QPLL0RESET_in),
    .QPLL1CLKRSVD0 (QPLL1CLKRSVD0_in),
    .QPLL1LOCKDETCLK (QPLL1LOCKDETCLK_in),
    .QPLL1LOCKEN (QPLL1LOCKEN_in),
    .QPLL1PD (QPLL1PD_in),
    .QPLL1REFCLKSEL (QPLL1REFCLKSEL_in),
    .QPLL1RESET (QPLL1RESET_in),
    .QPLLRSVD1 (QPLLRSVD1_in),
    .QPLLRSVD2 (QPLLRSVD2_in),
    .QPLLRSVD3 (QPLLRSVD3_in),
    .QPLLRSVD4 (QPLLRSVD4_in),
    .RCALENB (RCALENB_in),
    .RXRECCLK (RXRECCLK_in),
    .SDM0DATA (SDM0DATA_in),
    .SDM0RESET (SDM0RESET_in),
    .SDM0WIDTH (SDM0WIDTH_in),
    .SDM1DATA (SDM1DATA_in),
    .SDM1RESET (SDM1RESET_in),
    .SDM1WIDTH (SDM1WIDTH_in),
    .GSR (glblGSR)
  );

  
  endmodule

`endcelldefine
