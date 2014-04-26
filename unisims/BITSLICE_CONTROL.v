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
// /___/   /\      Filename    : BITSLICE_CONTROL.v
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
module BITSLICE_CONTROL #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CTRL_CLK = "EXTERNAL",
  parameter DIV_MODE = "DIV2",
  parameter EN_CLK_TO_EXT_NORTH = "DISABLE",
  parameter EN_CLK_TO_EXT_SOUTH = "DISABLE",
  parameter EN_DYN_ODLY_MODE = "FALSE",
  parameter EN_OTHER_NCLK = "FALSE",
  parameter EN_OTHER_PCLK = "FALSE",
  parameter IDLY_VT_TRACK = "TRUE",
  parameter INV_RXCLK = "FALSE",
  parameter ODLY_VT_TRACK = "TRUE",
  parameter QDLY_VT_TRACK = "TRUE",
  parameter [5:0] READ_IDLE_COUNT = 6'h00,
  parameter REFCLK_SRC = "PLLCLK",
  parameter integer ROUNDING_FACTOR = 16,
  parameter RXGATE_EXTEND = "FALSE",
  parameter RX_CLK_PHASE_N = "SHIFT_0",
  parameter RX_CLK_PHASE_P = "SHIFT_0",
  parameter RX_GATING = "DISABLE",
  parameter SELF_CALIBRATE = "ENABLE",
  parameter SERIAL_MODE = "FALSE",
  parameter TX_GATING = "DISABLE"
)(
  output BISC_START_OUT,
  output BISC_STOP_OUT,
  output CLK_TO_EXT_NORTH,
  output CLK_TO_EXT_SOUTH,
  output DLY_RDY,
  output [6:0] DYN_DCI,
  output NCLK_NIBBLE_OUT,
  output PCLK_NIBBLE_OUT,
  output [15:0] RIU_RD_DATA,
  output RIU_VALID,
  output [23:0] RX_BIT_CTRL_OUT0,
  output [23:0] RX_BIT_CTRL_OUT1,
  output [23:0] RX_BIT_CTRL_OUT2,
  output [23:0] RX_BIT_CTRL_OUT3,
  output [23:0] RX_BIT_CTRL_OUT4,
  output [23:0] RX_BIT_CTRL_OUT5,
  output [23:0] RX_BIT_CTRL_OUT6,
  output [26:0] TX_BIT_CTRL_OUT0,
  output [26:0] TX_BIT_CTRL_OUT1,
  output [26:0] TX_BIT_CTRL_OUT2,
  output [26:0] TX_BIT_CTRL_OUT3,
  output [26:0] TX_BIT_CTRL_OUT4,
  output [26:0] TX_BIT_CTRL_OUT5,
  output [26:0] TX_BIT_CTRL_OUT6,
  output [34:0] TX_BIT_CTRL_OUT_TRI,
  output VTC_RDY,

  input BISC_START_IN,
  input BISC_STOP_IN,
  input CLK_FROM_EXT,
  input EN_VTC,
  input NCLK_NIBBLE_IN,
  input PCLK_NIBBLE_IN,
  input [3:0] PHY_RDCS0,
  input [3:0] PHY_RDCS1,
  input [3:0] PHY_RDEN,
  input [3:0] PHY_WRCS0,
  input [3:0] PHY_WRCS1,
  input PLL_CLK,
  input REFCLK,
  input [5:0] RIU_ADDR,
  input RIU_CLK,
  input RIU_NIBBLE_SEL,
  input [15:0] RIU_WR_DATA,
  input RIU_WR_EN,
  input RST,
  input [34:0] RX_BIT_CTRL_IN0,
  input [34:0] RX_BIT_CTRL_IN1,
  input [34:0] RX_BIT_CTRL_IN2,
  input [34:0] RX_BIT_CTRL_IN3,
  input [34:0] RX_BIT_CTRL_IN4,
  input [34:0] RX_BIT_CTRL_IN5,
  input [34:0] RX_BIT_CTRL_IN6,
  input [3:0] TBYTE_IN,
  input [29:0] TX_BIT_CTRL_IN0,
  input [29:0] TX_BIT_CTRL_IN1,
  input [29:0] TX_BIT_CTRL_IN2,
  input [29:0] TX_BIT_CTRL_IN3,
  input [29:0] TX_BIT_CTRL_IN4,
  input [29:0] TX_BIT_CTRL_IN5,
  input [29:0] TX_BIT_CTRL_IN6,
  input [10:0] TX_BIT_CTRL_IN_TRI
);
  
// define constants
  localparam MODULE_NAME = "BITSLICE_CONTROL";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [64:1] CTRL_CLK_REG = CTRL_CLK;
  localparam [32:1] DIV_MODE_REG = DIV_MODE;
  localparam [56:1] EN_CLK_TO_EXT_NORTH_REG = EN_CLK_TO_EXT_NORTH;
  localparam [56:1] EN_CLK_TO_EXT_SOUTH_REG = EN_CLK_TO_EXT_SOUTH;
  localparam [40:1] EN_DYN_ODLY_MODE_REG = EN_DYN_ODLY_MODE;
  localparam [40:1] EN_OTHER_NCLK_REG = EN_OTHER_NCLK;
  localparam [40:1] EN_OTHER_PCLK_REG = EN_OTHER_PCLK;
  localparam [40:1] IDLY_VT_TRACK_REG = IDLY_VT_TRACK;
  localparam [40:1] INV_RXCLK_REG = INV_RXCLK;
  localparam [40:1] ODLY_VT_TRACK_REG = ODLY_VT_TRACK;
  localparam [40:1] QDLY_VT_TRACK_REG = QDLY_VT_TRACK;
  localparam [5:0] READ_IDLE_COUNT_REG = READ_IDLE_COUNT;
  localparam [48:1] REFCLK_SRC_REG = REFCLK_SRC;
  localparam [7:0] ROUNDING_FACTOR_REG = ROUNDING_FACTOR;
  localparam [40:1] RXGATE_EXTEND_REG = RXGATE_EXTEND;
  localparam [64:1] RX_CLK_PHASE_N_REG = RX_CLK_PHASE_N;
  localparam [64:1] RX_CLK_PHASE_P_REG = RX_CLK_PHASE_P;
  localparam [56:1] RX_GATING_REG = RX_GATING;
  localparam [56:1] SELF_CALIBRATE_REG = SELF_CALIBRATE;
  localparam [40:1] SERIAL_MODE_REG = SERIAL_MODE;
  localparam [56:1] TX_GATING_REG = TX_GATING;
  `endif

  localparam [56:1] CONTROL_DLY_TEST_EN_REG = "DISABLE";
  localparam [40:1] DC_ADJ_EN_REG = "FALSE";
  localparam [12:0] DLY_RNK0_REG = 13'h0000;
  localparam [12:0] DLY_RNK1_REG = 13'h0000;
  localparam [12:0] DLY_RNK2_REG = 13'h0000;
  localparam [12:0] DLY_RNK3_REG = 13'h0000;
  localparam [2:0] FDLY_REG = 3'b000;
  localparam [2:0] FDLY_RES_REG = 3'b000;
  localparam [7:0] INCDEC_CRSE_REG = 8'h08;
  localparam [9:0] MON_REG = 10'h000;
  localparam [8:0] NQTR_REG = 9'h000;
  localparam [8:0] PQTR_REG = 9'h000;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "BITSLICE_CONTROL_dr.v"
  `endif

  wire BISC_START_OUT_out;
  wire BISC_STOP_OUT_out;
  wire CLK_TO_EXT_NORTH_out;
  wire CLK_TO_EXT_SOUTH_out;
  wire DLY_RDY_out;
  wire DLY_TEST_OUT_out;
  wire LOCAL_DIV_CLK_out;
  wire MASTER_PD_OUT_out;
  wire NCLK_NIBBLE_OUT_out;
  wire PCLK_NIBBLE_OUT_out;
  wire RIU_VALID_out;
  wire VTC_RDY_out;
  wire [15:0] RIU_RD_DATA_out;
  wire [23:0] RX_BIT_CTRL_OUT0_out;
  wire [23:0] RX_BIT_CTRL_OUT1_out;
  wire [23:0] RX_BIT_CTRL_OUT2_out;
  wire [23:0] RX_BIT_CTRL_OUT3_out;
  wire [23:0] RX_BIT_CTRL_OUT4_out;
  wire [23:0] RX_BIT_CTRL_OUT5_out;
  wire [23:0] RX_BIT_CTRL_OUT6_out;
  wire [26:0] TX_BIT_CTRL_OUT0_out;
  wire [26:0] TX_BIT_CTRL_OUT1_out;
  wire [26:0] TX_BIT_CTRL_OUT2_out;
  wire [26:0] TX_BIT_CTRL_OUT3_out;
  wire [26:0] TX_BIT_CTRL_OUT4_out;
  wire [26:0] TX_BIT_CTRL_OUT5_out;
  wire [26:0] TX_BIT_CTRL_OUT6_out;
  wire [34:0] TX_BIT_CTRL_OUT_TRI_out;
  wire [6:0] DYN_DCI_out;

  wire BISC_START_OUT_delay;
  wire BISC_STOP_OUT_delay;
  wire CLK_TO_EXT_NORTH_delay;
  wire CLK_TO_EXT_SOUTH_delay;
  wire DLY_RDY_delay;
  wire NCLK_NIBBLE_OUT_delay;
  wire PCLK_NIBBLE_OUT_delay;
  wire RIU_VALID_delay;
  wire VTC_RDY_delay;
  wire [15:0] RIU_RD_DATA_delay;
  wire [23:0] RX_BIT_CTRL_OUT0_delay;
  wire [23:0] RX_BIT_CTRL_OUT1_delay;
  wire [23:0] RX_BIT_CTRL_OUT2_delay;
  wire [23:0] RX_BIT_CTRL_OUT3_delay;
  wire [23:0] RX_BIT_CTRL_OUT4_delay;
  wire [23:0] RX_BIT_CTRL_OUT5_delay;
  wire [23:0] RX_BIT_CTRL_OUT6_delay;
  wire [26:0] TX_BIT_CTRL_OUT0_delay;
  wire [26:0] TX_BIT_CTRL_OUT1_delay;
  wire [26:0] TX_BIT_CTRL_OUT2_delay;
  wire [26:0] TX_BIT_CTRL_OUT3_delay;
  wire [26:0] TX_BIT_CTRL_OUT4_delay;
  wire [26:0] TX_BIT_CTRL_OUT5_delay;
  wire [26:0] TX_BIT_CTRL_OUT6_delay;
  wire [34:0] TX_BIT_CTRL_OUT_TRI_delay;
  wire [6:0] DYN_DCI_delay;

  wire BISC_START_IN_in;
  wire BISC_STOP_IN_in;
  wire CLK_FROM_EXT_in;
  wire CLK_STOP_in;
  wire DLY_TEST_IN_in;
  wire EN_VTC_in;
  wire NCLK_NIBBLE_IN_in;
  wire PCLK_NIBBLE_IN_in;
  wire PLL_CLK_in;
  wire REFCLK_in;
  wire RIU_CLK_in;
  wire RIU_NIBBLE_SEL_in;
  wire RIU_WR_EN_in;
  wire RST_in;
  wire SCAN_INT_in;
  wire [10:0] TX_BIT_CTRL_IN_TRI_in;
  wire [15:0] RIU_WR_DATA_in;
  wire [29:0] TX_BIT_CTRL_IN0_in;
  wire [29:0] TX_BIT_CTRL_IN1_in;
  wire [29:0] TX_BIT_CTRL_IN2_in;
  wire [29:0] TX_BIT_CTRL_IN3_in;
  wire [29:0] TX_BIT_CTRL_IN4_in;
  wire [29:0] TX_BIT_CTRL_IN5_in;
  wire [29:0] TX_BIT_CTRL_IN6_in;
  wire [34:0] RX_BIT_CTRL_IN0_in;
  wire [34:0] RX_BIT_CTRL_IN1_in;
  wire [34:0] RX_BIT_CTRL_IN2_in;
  wire [34:0] RX_BIT_CTRL_IN3_in;
  wire [34:0] RX_BIT_CTRL_IN4_in;
  wire [34:0] RX_BIT_CTRL_IN5_in;
  wire [34:0] RX_BIT_CTRL_IN6_in;
  wire [3:0] PHY_RDCS0_in;
  wire [3:0] PHY_RDCS1_in;
  wire [3:0] PHY_RDEN_in;
  wire [3:0] PHY_WRCS0_in;
  wire [3:0] PHY_WRCS1_in;
  wire [3:0] TBYTE_IN_in;
  wire [5:0] RIU_ADDR_in;

  wire BISC_START_IN_delay;
  wire BISC_STOP_IN_delay;
  wire CLK_FROM_EXT_delay;
  wire EN_VTC_delay;
  wire NCLK_NIBBLE_IN_delay;
  wire PCLK_NIBBLE_IN_delay;
  wire PLL_CLK_delay;
  wire REFCLK_delay;
  wire RIU_CLK_delay;
  wire RIU_NIBBLE_SEL_delay;
  wire RIU_WR_EN_delay;
  wire RST_delay;
  wire [10:0] TX_BIT_CTRL_IN_TRI_delay;
  wire [15:0] RIU_WR_DATA_delay;
  wire [29:0] TX_BIT_CTRL_IN0_delay;
  wire [29:0] TX_BIT_CTRL_IN1_delay;
  wire [29:0] TX_BIT_CTRL_IN2_delay;
  wire [29:0] TX_BIT_CTRL_IN3_delay;
  wire [29:0] TX_BIT_CTRL_IN4_delay;
  wire [29:0] TX_BIT_CTRL_IN5_delay;
  wire [29:0] TX_BIT_CTRL_IN6_delay;
  wire [34:0] RX_BIT_CTRL_IN0_delay;
  wire [34:0] RX_BIT_CTRL_IN1_delay;
  wire [34:0] RX_BIT_CTRL_IN2_delay;
  wire [34:0] RX_BIT_CTRL_IN3_delay;
  wire [34:0] RX_BIT_CTRL_IN4_delay;
  wire [34:0] RX_BIT_CTRL_IN5_delay;
  wire [34:0] RX_BIT_CTRL_IN6_delay;
  wire [3:0] PHY_RDCS0_delay;
  wire [3:0] PHY_RDCS1_delay;
  wire [3:0] PHY_RDEN_delay;
  wire [3:0] PHY_WRCS0_delay;
  wire [3:0] PHY_WRCS1_delay;
  wire [3:0] TBYTE_IN_delay;
  wire [5:0] RIU_ADDR_delay;

  
  assign #(out_delay) BISC_START_OUT = BISC_START_OUT_delay;
  assign #(out_delay) BISC_STOP_OUT = BISC_STOP_OUT_delay;
  assign #(out_delay) CLK_TO_EXT_NORTH = CLK_TO_EXT_NORTH_delay;
  assign #(out_delay) CLK_TO_EXT_SOUTH = CLK_TO_EXT_SOUTH_delay;
  assign #(out_delay) DLY_RDY = DLY_RDY_delay;
  assign #(out_delay) DYN_DCI = DYN_DCI_delay;
  assign #(out_delay) NCLK_NIBBLE_OUT = NCLK_NIBBLE_OUT_delay;
  assign #(out_delay) PCLK_NIBBLE_OUT = PCLK_NIBBLE_OUT_delay;
  assign #(out_delay) RIU_RD_DATA = RIU_RD_DATA_delay;
  assign #(out_delay) RIU_VALID = RIU_VALID_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT0 = RX_BIT_CTRL_OUT0_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT1 = RX_BIT_CTRL_OUT1_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT2 = RX_BIT_CTRL_OUT2_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT3 = RX_BIT_CTRL_OUT3_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT4 = RX_BIT_CTRL_OUT4_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT5 = RX_BIT_CTRL_OUT5_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT6 = RX_BIT_CTRL_OUT6_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT0 = TX_BIT_CTRL_OUT0_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT1 = TX_BIT_CTRL_OUT1_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT2 = TX_BIT_CTRL_OUT2_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT3 = TX_BIT_CTRL_OUT3_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT4 = TX_BIT_CTRL_OUT4_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT5 = TX_BIT_CTRL_OUT5_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT6 = TX_BIT_CTRL_OUT6_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT_TRI = TX_BIT_CTRL_OUT_TRI_delay;
  assign #(out_delay) VTC_RDY = VTC_RDY_delay;
  
`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) RIU_CLK_delay = RIU_CLK;

  assign #(in_delay) CLK_FROM_EXT_delay = CLK_FROM_EXT;
  assign #(in_delay) EN_VTC_delay = EN_VTC;
  assign #(in_delay) PHY_RDCS0_delay = PHY_RDCS0;
  assign #(in_delay) PHY_RDCS1_delay = PHY_RDCS1;
  assign #(in_delay) PHY_RDEN_delay = PHY_RDEN;
  assign #(in_delay) PHY_WRCS0_delay = PHY_WRCS0;
  assign #(in_delay) PHY_WRCS1_delay = PHY_WRCS1;
  assign #(in_delay) PLL_CLK_delay = PLL_CLK;
  assign #(in_delay) RIU_ADDR_delay = RIU_ADDR;
  assign #(in_delay) RIU_NIBBLE_SEL_delay = RIU_NIBBLE_SEL;
  assign #(in_delay) RIU_WR_DATA_delay = RIU_WR_DATA;
  assign #(in_delay) RIU_WR_EN_delay = RIU_WR_EN;
  assign #(in_delay) RST_delay = RST;
  assign #(in_delay) RX_BIT_CTRL_IN0_delay = RX_BIT_CTRL_IN0;
  assign #(in_delay) RX_BIT_CTRL_IN1_delay = RX_BIT_CTRL_IN1;
  assign #(in_delay) RX_BIT_CTRL_IN2_delay = RX_BIT_CTRL_IN2;
  assign #(in_delay) RX_BIT_CTRL_IN3_delay = RX_BIT_CTRL_IN3;
  assign #(in_delay) RX_BIT_CTRL_IN4_delay = RX_BIT_CTRL_IN4;
  assign #(in_delay) RX_BIT_CTRL_IN5_delay = RX_BIT_CTRL_IN5;
  assign #(in_delay) RX_BIT_CTRL_IN6_delay = RX_BIT_CTRL_IN6;
  assign #(in_delay) TBYTE_IN_delay = TBYTE_IN;
  assign #(in_delay) TX_BIT_CTRL_IN0_delay = TX_BIT_CTRL_IN0;
  assign #(in_delay) TX_BIT_CTRL_IN1_delay = TX_BIT_CTRL_IN1;
  assign #(in_delay) TX_BIT_CTRL_IN2_delay = TX_BIT_CTRL_IN2;
  assign #(in_delay) TX_BIT_CTRL_IN3_delay = TX_BIT_CTRL_IN3;
  assign #(in_delay) TX_BIT_CTRL_IN4_delay = TX_BIT_CTRL_IN4;
  assign #(in_delay) TX_BIT_CTRL_IN5_delay = TX_BIT_CTRL_IN5;
  assign #(in_delay) TX_BIT_CTRL_IN6_delay = TX_BIT_CTRL_IN6;
  assign #(in_delay) TX_BIT_CTRL_IN_TRI_delay = TX_BIT_CTRL_IN_TRI;
`endif //  `ifndef XIL_TIMING
// inputs with no timing checks
  assign #(inclk_delay) REFCLK_delay = REFCLK;

  assign #(in_delay) BISC_START_IN_delay = BISC_START_IN;
  assign #(in_delay) BISC_STOP_IN_delay = BISC_STOP_IN;
  assign #(in_delay) NCLK_NIBBLE_IN_delay = NCLK_NIBBLE_IN;
  assign #(in_delay) PCLK_NIBBLE_IN_delay = PCLK_NIBBLE_IN;

  assign BISC_START_OUT_delay = BISC_START_OUT_out;
  assign BISC_STOP_OUT_delay = BISC_STOP_OUT_out;
  assign CLK_TO_EXT_NORTH_delay = CLK_TO_EXT_NORTH_out;
  assign CLK_TO_EXT_SOUTH_delay = CLK_TO_EXT_SOUTH_out;
  assign DLY_RDY_delay = DLY_RDY_out;
  assign DYN_DCI_delay = DYN_DCI_out;
  assign NCLK_NIBBLE_OUT_delay = NCLK_NIBBLE_OUT_out;
  assign PCLK_NIBBLE_OUT_delay = PCLK_NIBBLE_OUT_out;
  assign RIU_RD_DATA_delay = RIU_RD_DATA_out;
  assign RIU_VALID_delay = RIU_VALID_out;
  assign RX_BIT_CTRL_OUT0_delay = RX_BIT_CTRL_OUT0_out;
  assign RX_BIT_CTRL_OUT1_delay = RX_BIT_CTRL_OUT1_out;
  assign RX_BIT_CTRL_OUT2_delay = RX_BIT_CTRL_OUT2_out;
  assign RX_BIT_CTRL_OUT3_delay = RX_BIT_CTRL_OUT3_out;
  assign RX_BIT_CTRL_OUT4_delay = RX_BIT_CTRL_OUT4_out;
  assign RX_BIT_CTRL_OUT5_delay = RX_BIT_CTRL_OUT5_out;
  assign RX_BIT_CTRL_OUT6_delay = RX_BIT_CTRL_OUT6_out;
  assign TX_BIT_CTRL_OUT0_delay = TX_BIT_CTRL_OUT0_out;
  assign TX_BIT_CTRL_OUT1_delay = TX_BIT_CTRL_OUT1_out;
  assign TX_BIT_CTRL_OUT2_delay = TX_BIT_CTRL_OUT2_out;
  assign TX_BIT_CTRL_OUT3_delay = TX_BIT_CTRL_OUT3_out;
  assign TX_BIT_CTRL_OUT4_delay = TX_BIT_CTRL_OUT4_out;
  assign TX_BIT_CTRL_OUT5_delay = TX_BIT_CTRL_OUT5_out;
  assign TX_BIT_CTRL_OUT6_delay = TX_BIT_CTRL_OUT6_out;
  assign TX_BIT_CTRL_OUT_TRI_delay = TX_BIT_CTRL_OUT_TRI_out;
  assign VTC_RDY_delay = VTC_RDY_out;

  assign BISC_START_IN_in = BISC_START_IN_delay;
  assign BISC_STOP_IN_in = BISC_STOP_IN_delay;
  assign CLK_FROM_EXT_in = CLK_FROM_EXT_delay;
  assign EN_VTC_in = EN_VTC_delay;
  assign NCLK_NIBBLE_IN_in = NCLK_NIBBLE_IN_delay;
  assign PCLK_NIBBLE_IN_in = PCLK_NIBBLE_IN_delay;
  assign PHY_RDCS0_in = PHY_RDCS0_delay;
  assign PHY_RDCS1_in = PHY_RDCS1_delay;
  assign PHY_RDEN_in = PHY_RDEN_delay;
  assign PHY_WRCS0_in = PHY_WRCS0_delay;
  assign PHY_WRCS1_in = PHY_WRCS1_delay;
  assign PLL_CLK_in = PLL_CLK_delay;
  assign REFCLK_in = REFCLK_delay;
  assign RIU_ADDR_in = RIU_ADDR_delay;
  assign RIU_CLK_in = RIU_CLK_delay;
  assign RIU_NIBBLE_SEL_in = RIU_NIBBLE_SEL_delay;
  assign RIU_WR_DATA_in = RIU_WR_DATA_delay;
  assign RIU_WR_EN_in = RIU_WR_EN_delay;
  assign RST_in = RST_delay;
  assign RX_BIT_CTRL_IN0_in = RX_BIT_CTRL_IN0_delay;
  assign RX_BIT_CTRL_IN1_in = RX_BIT_CTRL_IN1_delay;
  assign RX_BIT_CTRL_IN2_in = RX_BIT_CTRL_IN2_delay;
  assign RX_BIT_CTRL_IN3_in = RX_BIT_CTRL_IN3_delay;
  assign RX_BIT_CTRL_IN4_in = RX_BIT_CTRL_IN4_delay;
  assign RX_BIT_CTRL_IN5_in = RX_BIT_CTRL_IN5_delay;
  assign RX_BIT_CTRL_IN6_in = RX_BIT_CTRL_IN6_delay;
  assign TBYTE_IN_in = TBYTE_IN_delay;
  assign TX_BIT_CTRL_IN0_in = TX_BIT_CTRL_IN0_delay;
  assign TX_BIT_CTRL_IN1_in = TX_BIT_CTRL_IN1_delay;
  assign TX_BIT_CTRL_IN2_in = TX_BIT_CTRL_IN2_delay;
  assign TX_BIT_CTRL_IN3_in = TX_BIT_CTRL_IN3_delay;
  assign TX_BIT_CTRL_IN4_in = TX_BIT_CTRL_IN4_delay;
  assign TX_BIT_CTRL_IN5_in = TX_BIT_CTRL_IN5_delay;
  assign TX_BIT_CTRL_IN6_in = TX_BIT_CTRL_IN6_delay;
  assign TX_BIT_CTRL_IN_TRI_in = TX_BIT_CTRL_IN_TRI_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
    #1;
    if ((CTRL_CLK_REG != "EXTERNAL") &&
        (CTRL_CLK_REG != "INTERNAL")) begin
      $display("Attribute Syntax Error : The attribute CTRL_CLK on %s instance %m is set to %s.  Legal values for this attribute are EXTERNAL or INTERNAL.", MODULE_NAME, CTRL_CLK_REG);
      attr_err = 1'b1;
    end

    if ((DIV_MODE_REG != "DIV2") &&
        (DIV_MODE_REG != "DIV4")) begin
      $display("Attribute Syntax Error : The attribute DIV_MODE on %s instance %m is set to %s.  Legal values for this attribute are DIV2 or DIV4.", MODULE_NAME, DIV_MODE_REG);
      attr_err = 1'b1;
    end

    if ((EN_CLK_TO_EXT_NORTH_REG != "DISABLE") &&
        (EN_CLK_TO_EXT_NORTH_REG != "ENABLE")) begin
      $display("Attribute Syntax Error : The attribute EN_CLK_TO_EXT_NORTH on %s instance %m is set to %s.  Legal values for this attribute are DISABLE or ENABLE.", MODULE_NAME, EN_CLK_TO_EXT_NORTH_REG);
      attr_err = 1'b1;
    end

    if ((EN_CLK_TO_EXT_SOUTH_REG != "DISABLE") &&
        (EN_CLK_TO_EXT_SOUTH_REG != "ENABLE")) begin
      $display("Attribute Syntax Error : The attribute EN_CLK_TO_EXT_SOUTH on %s instance %m is set to %s.  Legal values for this attribute are DISABLE or ENABLE.", MODULE_NAME, EN_CLK_TO_EXT_SOUTH_REG);
      attr_err = 1'b1;
    end

    if ((EN_DYN_ODLY_MODE_REG != "FALSE") &&
        (EN_DYN_ODLY_MODE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute EN_DYN_ODLY_MODE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_DYN_ODLY_MODE_REG);
      attr_err = 1'b1;
    end

    if ((EN_OTHER_NCLK_REG != "FALSE") &&
        (EN_OTHER_NCLK_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute EN_OTHER_NCLK on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_OTHER_NCLK_REG);
      attr_err = 1'b1;
    end

    if ((EN_OTHER_PCLK_REG != "FALSE") &&
        (EN_OTHER_PCLK_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute EN_OTHER_PCLK on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_OTHER_PCLK_REG);
      attr_err = 1'b1;
    end

    if ((IDLY_VT_TRACK_REG != "TRUE") &&
        (IDLY_VT_TRACK_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute IDLY_VT_TRACK on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, IDLY_VT_TRACK_REG);
      attr_err = 1'b1;
    end

    if ((INV_RXCLK_REG != "FALSE") &&
        (INV_RXCLK_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute INV_RXCLK on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, INV_RXCLK_REG);
      attr_err = 1'b1;
    end

    if ((ODLY_VT_TRACK_REG != "TRUE") &&
        (ODLY_VT_TRACK_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute ODLY_VT_TRACK on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, ODLY_VT_TRACK_REG);
      attr_err = 1'b1;
    end

    if ((QDLY_VT_TRACK_REG != "TRUE") &&
        (QDLY_VT_TRACK_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute QDLY_VT_TRACK on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, QDLY_VT_TRACK_REG);
      attr_err = 1'b1;
    end

    if ((REFCLK_SRC_REG != "PLLCLK") &&
        (REFCLK_SRC_REG != "REFCLK")) begin
      $display("Attribute Syntax Error : The attribute REFCLK_SRC on %s instance %m is set to %s.  Legal values for this attribute are PLLCLK or REFCLK.", MODULE_NAME, REFCLK_SRC_REG);
      attr_err = 1'b1;
    end

    if ((ROUNDING_FACTOR_REG != 16) &&
        (ROUNDING_FACTOR_REG != 2) &&
        (ROUNDING_FACTOR_REG != 4) &&
        (ROUNDING_FACTOR_REG != 8) &&
        (ROUNDING_FACTOR_REG != 32) &&
        (ROUNDING_FACTOR_REG != 64) &&
        (ROUNDING_FACTOR_REG != 128)) begin
      $display("Attribute Syntax Error : The attribute ROUNDING_FACTOR on %s instance %m is set to %d.  Legal values for this attribute are 2 to 128.", MODULE_NAME, ROUNDING_FACTOR_REG, 16);
      attr_err = 1'b1;
    end

    if ((RXGATE_EXTEND_REG != "FALSE") &&
        (RXGATE_EXTEND_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute RXGATE_EXTEND on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, RXGATE_EXTEND_REG);
      attr_err = 1'b1;
    end

    if ((RX_CLK_PHASE_N_REG != "SHIFT_0") &&
        (RX_CLK_PHASE_N_REG != "SHIFT_90")) begin
      $display("Attribute Syntax Error : The attribute RX_CLK_PHASE_N on %s instance %m is set to %s.  Legal values for this attribute are SHIFT_0 or SHIFT_90.", MODULE_NAME, RX_CLK_PHASE_N_REG);
      attr_err = 1'b1;
    end

    if ((RX_CLK_PHASE_P_REG != "SHIFT_0") &&
        (RX_CLK_PHASE_P_REG != "SHIFT_90")) begin
      $display("Attribute Syntax Error : The attribute RX_CLK_PHASE_P on %s instance %m is set to %s.  Legal values for this attribute are SHIFT_0 or SHIFT_90.", MODULE_NAME, RX_CLK_PHASE_P_REG);
      attr_err = 1'b1;
    end

    if ((RX_GATING_REG != "DISABLE") &&
        (RX_GATING_REG != "ENABLE")) begin
      $display("Attribute Syntax Error : The attribute RX_GATING on %s instance %m is set to %s.  Legal values for this attribute are DISABLE or ENABLE.", MODULE_NAME, RX_GATING_REG);
      attr_err = 1'b1;
    end

    if ((SELF_CALIBRATE_REG != "ENABLE") &&
        (SELF_CALIBRATE_REG != "DISABLE")) begin
      $display("Attribute Syntax Error : The attribute SELF_CALIBRATE on %s instance %m is set to %s.  Legal values for this attribute are ENABLE or DISABLE.", MODULE_NAME, SELF_CALIBRATE_REG);
      attr_err = 1'b1;
    end

    if ((SERIAL_MODE_REG != "FALSE") &&
        (SERIAL_MODE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute SERIAL_MODE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, SERIAL_MODE_REG);
      attr_err = 1'b1;
    end

    if ((TX_GATING_REG != "DISABLE") &&
        (TX_GATING_REG != "ENABLE")) begin
      $display("Attribute Syntax Error : The attribute TX_GATING on %s instance %m is set to %s.  Legal values for this attribute are DISABLE or ENABLE.", MODULE_NAME, TX_GATING_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end


  assign CLK_STOP_in = 1'b1; // tie off
  assign DLY_TEST_IN_in = 1'b0; // tie off
  assign SCAN_INT_in = 1'b1; // tie off

  SIP_BITSLICE_CONTROL SIP_BITSLICE_CONTROL_INST (
    .CONTROL_DLY_TEST_EN (CONTROL_DLY_TEST_EN_REG),
    .CTRL_CLK (CTRL_CLK_REG),
    .DC_ADJ_EN (DC_ADJ_EN_REG),
    .DIV_MODE (DIV_MODE_REG),
    .DLY_RNK0 (DLY_RNK0_REG),
    .DLY_RNK1 (DLY_RNK1_REG),
    .DLY_RNK2 (DLY_RNK2_REG),
    .DLY_RNK3 (DLY_RNK3_REG),
    .EN_CLK_TO_EXT_NORTH (EN_CLK_TO_EXT_NORTH_REG),
    .EN_CLK_TO_EXT_SOUTH (EN_CLK_TO_EXT_SOUTH_REG),
    .EN_DYN_ODLY_MODE (EN_DYN_ODLY_MODE_REG),
    .EN_OTHER_NCLK (EN_OTHER_NCLK_REG),
    .EN_OTHER_PCLK (EN_OTHER_PCLK_REG),
    .FDLY (FDLY_REG),
    .FDLY_RES (FDLY_RES_REG),
    .IDLY_VT_TRACK (IDLY_VT_TRACK_REG),
    .INCDEC_CRSE (INCDEC_CRSE_REG),
    .INV_RXCLK (INV_RXCLK_REG),
    .MON (MON_REG),
    .NQTR (NQTR_REG),
    .ODLY_VT_TRACK (ODLY_VT_TRACK_REG),
    .PQTR (PQTR_REG),
    .QDLY_VT_TRACK (QDLY_VT_TRACK_REG),
    .READ_IDLE_COUNT (READ_IDLE_COUNT_REG),
    .REFCLK_SRC (REFCLK_SRC_REG),
    .ROUNDING_FACTOR (ROUNDING_FACTOR_REG),
    .RXGATE_EXTEND (RXGATE_EXTEND_REG),
    .RX_CLK_PHASE_N (RX_CLK_PHASE_N_REG),
    .RX_CLK_PHASE_P (RX_CLK_PHASE_P_REG),
    .RX_GATING (RX_GATING_REG),
    .SELF_CALIBRATE (SELF_CALIBRATE_REG),
    .SERIAL_MODE (SERIAL_MODE_REG),
    .TX_GATING (TX_GATING_REG),
    .BISC_START_OUT (BISC_START_OUT_out),
    .BISC_STOP_OUT (BISC_STOP_OUT_out),
    .CLK_TO_EXT_NORTH (CLK_TO_EXT_NORTH_out),
    .CLK_TO_EXT_SOUTH (CLK_TO_EXT_SOUTH_out),
    .DLY_RDY (DLY_RDY_out),
    .DLY_TEST_OUT (DLY_TEST_OUT_out),
    .DYN_DCI (DYN_DCI_out),
    .LOCAL_DIV_CLK (LOCAL_DIV_CLK_out),
    .MASTER_PD_OUT (MASTER_PD_OUT_out),
    .NCLK_NIBBLE_OUT (NCLK_NIBBLE_OUT_out),
    .PCLK_NIBBLE_OUT (PCLK_NIBBLE_OUT_out),
    .RIU_RD_DATA (RIU_RD_DATA_out),
    .RIU_VALID (RIU_VALID_out),
    .RX_BIT_CTRL_OUT0 (RX_BIT_CTRL_OUT0_out),
    .RX_BIT_CTRL_OUT1 (RX_BIT_CTRL_OUT1_out),
    .RX_BIT_CTRL_OUT2 (RX_BIT_CTRL_OUT2_out),
    .RX_BIT_CTRL_OUT3 (RX_BIT_CTRL_OUT3_out),
    .RX_BIT_CTRL_OUT4 (RX_BIT_CTRL_OUT4_out),
    .RX_BIT_CTRL_OUT5 (RX_BIT_CTRL_OUT5_out),
    .RX_BIT_CTRL_OUT6 (RX_BIT_CTRL_OUT6_out),
    .TX_BIT_CTRL_OUT0 (TX_BIT_CTRL_OUT0_out),
    .TX_BIT_CTRL_OUT1 (TX_BIT_CTRL_OUT1_out),
    .TX_BIT_CTRL_OUT2 (TX_BIT_CTRL_OUT2_out),
    .TX_BIT_CTRL_OUT3 (TX_BIT_CTRL_OUT3_out),
    .TX_BIT_CTRL_OUT4 (TX_BIT_CTRL_OUT4_out),
    .TX_BIT_CTRL_OUT5 (TX_BIT_CTRL_OUT5_out),
    .TX_BIT_CTRL_OUT6 (TX_BIT_CTRL_OUT6_out),
    .TX_BIT_CTRL_OUT_TRI (TX_BIT_CTRL_OUT_TRI_out),
    .VTC_RDY (VTC_RDY_out),
    .BISC_START_IN (BISC_START_IN_in),
    .BISC_STOP_IN (BISC_STOP_IN_in),
    .CLK_FROM_EXT (CLK_FROM_EXT_in),
    .CLK_STOP (CLK_STOP_in),
    .DLY_TEST_IN (DLY_TEST_IN_in),
    .EN_VTC (EN_VTC_in),
    .NCLK_NIBBLE_IN (NCLK_NIBBLE_IN_in),
    .PCLK_NIBBLE_IN (PCLK_NIBBLE_IN_in),
    .PHY_RDCS0 (PHY_RDCS0_in),
    .PHY_RDCS1 (PHY_RDCS1_in),
    .PHY_RDEN (PHY_RDEN_in),
    .PHY_WRCS0 (PHY_WRCS0_in),
    .PHY_WRCS1 (PHY_WRCS1_in),
    .PLL_CLK (PLL_CLK_in),
    .REFCLK (REFCLK_in),
    .RIU_ADDR (RIU_ADDR_in),
    .RIU_CLK (RIU_CLK_in),
    .RIU_NIBBLE_SEL (RIU_NIBBLE_SEL_in),
    .RIU_WR_DATA (RIU_WR_DATA_in),
    .RIU_WR_EN (RIU_WR_EN_in),
    .RST (RST_in),
    .RX_BIT_CTRL_IN0 (RX_BIT_CTRL_IN0_in),
    .RX_BIT_CTRL_IN1 (RX_BIT_CTRL_IN1_in),
    .RX_BIT_CTRL_IN2 (RX_BIT_CTRL_IN2_in),
    .RX_BIT_CTRL_IN3 (RX_BIT_CTRL_IN3_in),
    .RX_BIT_CTRL_IN4 (RX_BIT_CTRL_IN4_in),
    .RX_BIT_CTRL_IN5 (RX_BIT_CTRL_IN5_in),
    .RX_BIT_CTRL_IN6 (RX_BIT_CTRL_IN6_in),
    .SCAN_INT (SCAN_INT_in),
    .TBYTE_IN (TBYTE_IN_in),
    .TX_BIT_CTRL_IN0 (TX_BIT_CTRL_IN0_in),
    .TX_BIT_CTRL_IN1 (TX_BIT_CTRL_IN1_in),
    .TX_BIT_CTRL_IN2 (TX_BIT_CTRL_IN2_in),
    .TX_BIT_CTRL_IN3 (TX_BIT_CTRL_IN3_in),
    .TX_BIT_CTRL_IN4 (TX_BIT_CTRL_IN4_in),
    .TX_BIT_CTRL_IN5 (TX_BIT_CTRL_IN5_in),
    .TX_BIT_CTRL_IN6 (TX_BIT_CTRL_IN6_in),
    .TX_BIT_CTRL_IN_TRI (TX_BIT_CTRL_IN_TRI_in),
    .GSR (glblGSR)
  );

    specify
    (CLK_FROM_EXT *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (CLK_FROM_EXT => CLK_TO_EXT_NORTH) = (0:0:0, 0:0:0);
    (CLK_FROM_EXT => CLK_TO_EXT_SOUTH) = (0:0:0, 0:0:0);
    (CLK_FROM_EXT => NCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (CLK_FROM_EXT => PCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (NCLK_NIBBLE_IN *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (PCLK_NIBBLE_IN *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (PLL_CLK *> DYN_DCI) = (0:0:0, 0:0:0);
    (PLL_CLK *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT0) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT1) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT2) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT3) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT4) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT5) = (0:0:0, 0:0:0);
    (PLL_CLK *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT0) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT1) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT2) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT3) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT4) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT5) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (PLL_CLK *> TX_BIT_CTRL_OUT_TRI) = (0:0:0, 0:0:0);
    (PLL_CLK => CLK_TO_EXT_NORTH) = (0:0:0, 0:0:0);
    (PLL_CLK => CLK_TO_EXT_SOUTH) = (0:0:0, 0:0:0);
    (PLL_CLK => DLY_RDY) = (0:0:0, 0:0:0);
    (PLL_CLK => NCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (PLL_CLK => PCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (PLL_CLK => RIU_VALID) = (0:0:0, 0:0:0);
    (PLL_CLK => VTC_RDY) = (0:0:0, 0:0:0);
    (RIU_CLK *> DYN_DCI) = (0:0:0, 0:0:0);
    (RIU_CLK *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT0) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT1) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT2) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT3) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT4) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT5) = (0:0:0, 0:0:0);
    (RIU_CLK *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT0) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT1) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT2) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT3) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT4) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT5) = (0:0:0, 0:0:0);
    (RIU_CLK *> TX_BIT_CTRL_OUT_TRI) = (0:0:0, 0:0:0);
    (RIU_CLK => CLK_TO_EXT_NORTH) = (0:0:0, 0:0:0);
    (RIU_CLK => CLK_TO_EXT_SOUTH) = (0:0:0, 0:0:0);
    (RIU_CLK => DLY_RDY) = (0:0:0, 0:0:0);
    (RIU_CLK => NCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (RIU_CLK => PCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (RIU_CLK => RIU_VALID) = (0:0:0, 0:0:0);
    (RIU_CLK => VTC_RDY) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> CLK_TO_EXT_NORTH) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> CLK_TO_EXT_SOUTH) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> NCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> PCLK_NIBBLE_OUT) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN0 *> RX_BIT_CTRL_OUT6) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN1 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN2 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN3 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN4 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN5 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN6 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN0 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN1 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN2 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN3 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN4 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN5 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN6 *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN_TRI *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (negedge RST *> (DYN_DCI +: 0)) = (0:0:0, 0:0:0);
    (negedge RST *> (RIU_RD_DATA +: 0)) = (0:0:0, 0:0:0);
    (negedge RST => (CLK_TO_EXT_NORTH +: 0)) = (0:0:0, 0:0:0);
    (negedge RST => (CLK_TO_EXT_SOUTH +: 0)) = (0:0:0, 0:0:0);
    (negedge RST => (DLY_RDY +: 0)) = (0:0:0, 0:0:0);
    (negedge RST => (RIU_VALID +: 0)) = (0:0:0, 0:0:0);
    (negedge RST => (VTC_RDY +: 0)) = (0:0:0, 0:0:0);
    (posedge RST *> (RIU_RD_DATA +: 0)) = (0:0:0, 0:0:0);
    (posedge RST => (CLK_TO_EXT_NORTH +: 0)) = (0:0:0, 0:0:0);
    (posedge RST => (CLK_TO_EXT_SOUTH +: 0)) = (0:0:0, 0:0:0);
    (posedge RST => (RIU_VALID +: 0)) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge CLK_FROM_EXT, 0:0:0, notifier);
    $period (negedge PLL_CLK, 0:0:0, notifier);
    $period (negedge RIU_CLK, 0:0:0, notifier);
    $period (posedge CLK_FROM_EXT, 0:0:0, notifier);
    $period (posedge PLL_CLK, 0:0:0, notifier);
    $period (posedge RIU_CLK, 0:0:0, notifier);
    $recrem ( negedge CLK_FROM_EXT, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $recrem ( negedge CLK_FROM_EXT, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $recrem ( negedge PLL_CLK, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge PLL_CLK, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge RST, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge RST, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge RX_BIT_CTRL_IN0, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge RX_BIT_CTRL_IN0, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, PLL_CLK_delay);
    $recrem ( negedge RX_BIT_CTRL_IN0, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, CLK_FROM_EXT_delay);
    $recrem ( negedge RX_BIT_CTRL_IN0, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, PLL_CLK_delay);
    $recrem ( posedge CLK_FROM_EXT, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $recrem ( posedge CLK_FROM_EXT, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $recrem ( posedge PLL_CLK, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge PLL_CLK, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge RST, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge RST, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge RX_BIT_CTRL_IN0, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge RX_BIT_CTRL_IN0, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, PLL_CLK_delay);
    $recrem ( posedge RX_BIT_CTRL_IN0, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, CLK_FROM_EXT_delay);
    $recrem ( posedge RX_BIT_CTRL_IN0, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN0_delay, PLL_CLK_delay);
    $setuphold (negedge CLK_FROM_EXT, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $setuphold (negedge CLK_FROM_EXT, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $setuphold (negedge PLL_CLK, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $setuphold (negedge PLL_CLK, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $setuphold (posedge CLK_FROM_EXT, negedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $setuphold (posedge CLK_FROM_EXT, posedge PLL_CLK, 0:0:0, 0:0:0, notifier,,, CLK_FROM_EXT_delay, PLL_CLK_delay);
    $setuphold (posedge PLL_CLK, negedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $setuphold (posedge PLL_CLK, negedge EN_VTC, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, EN_VTC_delay);
    $setuphold (posedge PLL_CLK, negedge PHY_RDCS0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDCS0_delay);
    $setuphold (posedge PLL_CLK, negedge PHY_RDCS1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDCS1_delay);
    $setuphold (posedge PLL_CLK, negedge PHY_RDEN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDEN_delay);
    $setuphold (posedge PLL_CLK, negedge PHY_WRCS0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_WRCS0_delay);
    $setuphold (posedge PLL_CLK, negedge PHY_WRCS1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_WRCS1_delay);
    $setuphold (posedge PLL_CLK, negedge RIU_ADDR, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_ADDR_delay);
    $setuphold (posedge PLL_CLK, negedge RIU_NIBBLE_SEL, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_NIBBLE_SEL_delay);
    $setuphold (posedge PLL_CLK, negedge RIU_WR_DATA, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_WR_DATA_delay);
    $setuphold (posedge PLL_CLK, negedge RIU_WR_EN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_WR_EN_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN0_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN1_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN2_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN3_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN4_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN5_delay);
    $setuphold (posedge PLL_CLK, negedge RX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN6_delay);
    $setuphold (posedge PLL_CLK, negedge TBYTE_IN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TBYTE_IN_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN0_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN1_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN2_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN3_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN4_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN5_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN6_delay);
    $setuphold (posedge PLL_CLK, negedge TX_BIT_CTRL_IN_TRI, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN_TRI_delay);
    $setuphold (posedge PLL_CLK, posedge CLK_FROM_EXT, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, CLK_FROM_EXT_delay);
    $setuphold (posedge PLL_CLK, posedge EN_VTC, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, EN_VTC_delay);
    $setuphold (posedge PLL_CLK, posedge PHY_RDCS0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDCS0_delay);
    $setuphold (posedge PLL_CLK, posedge PHY_RDCS1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDCS1_delay);
    $setuphold (posedge PLL_CLK, posedge PHY_RDEN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_RDEN_delay);
    $setuphold (posedge PLL_CLK, posedge PHY_WRCS0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_WRCS0_delay);
    $setuphold (posedge PLL_CLK, posedge PHY_WRCS1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, PHY_WRCS1_delay);
    $setuphold (posedge PLL_CLK, posedge RIU_ADDR, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_ADDR_delay);
    $setuphold (posedge PLL_CLK, posedge RIU_NIBBLE_SEL, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_NIBBLE_SEL_delay);
    $setuphold (posedge PLL_CLK, posedge RIU_WR_DATA, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_WR_DATA_delay);
    $setuphold (posedge PLL_CLK, posedge RIU_WR_EN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RIU_WR_EN_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN0_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN1_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN2_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN3_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN4_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN5_delay);
    $setuphold (posedge PLL_CLK, posedge RX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, RX_BIT_CTRL_IN6_delay);
    $setuphold (posedge PLL_CLK, posedge TBYTE_IN, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TBYTE_IN_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN0_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN1_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN2_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN3_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN4_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN5_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN6_delay);
    $setuphold (posedge PLL_CLK, posedge TX_BIT_CTRL_IN_TRI, 0:0:0, 0:0:0, notifier,,, PLL_CLK_delay, TX_BIT_CTRL_IN_TRI_delay);
    $setuphold (posedge RIU_CLK, negedge EN_VTC, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, EN_VTC_delay);
    $setuphold (posedge RIU_CLK, negedge RIU_ADDR, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_ADDR_delay);
    $setuphold (posedge RIU_CLK, negedge RIU_NIBBLE_SEL, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_NIBBLE_SEL_delay);
    $setuphold (posedge RIU_CLK, negedge RIU_WR_DATA, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_WR_DATA_delay);
    $setuphold (posedge RIU_CLK, negedge RIU_WR_EN, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_WR_EN_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN0_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN1_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN2_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN3_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN4_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN5_delay);
    $setuphold (posedge RIU_CLK, negedge RX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN6_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN0_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN1_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN2_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN3_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN4_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN5_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN6_delay);
    $setuphold (posedge RIU_CLK, negedge TX_BIT_CTRL_IN_TRI, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN_TRI_delay);
    $setuphold (posedge RIU_CLK, posedge EN_VTC, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, EN_VTC_delay);
    $setuphold (posedge RIU_CLK, posedge RIU_ADDR, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_ADDR_delay);
    $setuphold (posedge RIU_CLK, posedge RIU_NIBBLE_SEL, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_NIBBLE_SEL_delay);
    $setuphold (posedge RIU_CLK, posedge RIU_WR_DATA, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_WR_DATA_delay);
    $setuphold (posedge RIU_CLK, posedge RIU_WR_EN, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RIU_WR_EN_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN0_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN1_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN2_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN3_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN4_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN5_delay);
    $setuphold (posedge RIU_CLK, posedge RX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, RX_BIT_CTRL_IN6_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN0, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN0_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN1, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN1_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN2, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN2_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN3, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN3_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN4, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN4_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN5, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN5_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN6, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN6_delay);
    $setuphold (posedge RIU_CLK, posedge TX_BIT_CTRL_IN_TRI, 0:0:0, 0:0:0, notifier,,, RIU_CLK_delay, TX_BIT_CTRL_IN_TRI_delay);
    $width (negedge CLK_FROM_EXT, 0:0:0, 0, notifier);
    $width (negedge PLL_CLK, 0:0:0, 0, notifier);
    $width (negedge RIU_CLK, 0:0:0, 0, notifier);
    $width (posedge CLK_FROM_EXT, 0:0:0, 0, notifier);
    $width (posedge PLL_CLK, 0:0:0, 0, notifier);
    $width (posedge RIU_CLK, 0:0:0, 0, notifier);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
