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
// /___/   /\      Filename    : RXTX_BITSLICE.v
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
module RXTX_BITSLICE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter FIFO_SYNC_MODE = "FALSE",
  parameter [0:0] INIT = 1'b1,
  parameter [0:0] IS_RX_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RX_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_RX_RST_INVERTED = 1'b0,
  parameter [0:0] IS_TX_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_TX_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_TX_RST_INVERTED = 1'b0,
  parameter PRE_EMPHASIS = "OFF",
  parameter RX_DATA_TYPE = "NONE",
  parameter integer RX_DATA_WIDTH = 8,
  parameter RX_DELAY_FORMAT = "TIME",
  parameter RX_DELAY_TYPE = "FIXED",
  parameter integer RX_DELAY_VALUE = 0,
  parameter real RX_REFCLK_FREQUENCY = 300.0,
  parameter RX_UPDATE_MODE = "ASYNC",
  parameter TBYTE_CTL = "TBYTE_IN",
  parameter integer TX_DATA_WIDTH = 8,
  parameter TX_DELAY_FORMAT = "TIME",
  parameter TX_DELAY_TYPE = "FIXED",
  parameter integer TX_DELAY_VALUE = 0,
  parameter TX_OUTPUT_PHASE_90 = "FALSE",
  parameter real TX_REFCLK_FREQUENCY = 300.0,
  parameter TX_UPDATE_MODE = "ASYNC"
)(
  output FIFO_EMPTY,
  output FIFO_WRCLK_OUT,
  output O,
  output [7:0] Q,
  output [34:0] RX_BIT_CTRL_OUT,
  output [8:0] RX_CNTVALUEOUT,
  output [29:0] TX_BIT_CTRL_OUT,
  output [8:0] TX_CNTVALUEOUT,
  output T_OUT,

  input [7:0] D,
  input DATAIN,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input [23:0] RX_BIT_CTRL_IN,
  input RX_CE,
  input RX_CLK,
  input [8:0] RX_CNTVALUEIN,
  input RX_EN_VTC,
  input RX_INC,
  input RX_LOAD,
  input RX_RST,
  input RX_RST_DLY,
  input T,
  input TBYTE_IN,
  input [26:0] TX_BIT_CTRL_IN,
  input TX_CE,
  input TX_CLK,
  input [8:0] TX_CNTVALUEIN,
  input TX_EN_VTC,
  input TX_INC,
  input TX_LOAD,
  input TX_RST,
  input TX_RST_DLY
);
  
// define constants
  localparam MODULE_NAME = "RXTX_BITSLICE";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [40:1] FIFO_SYNC_MODE_REG = FIFO_SYNC_MODE;
  localparam [0:0] INIT_REG = INIT;
  localparam [0:0] IS_RX_CLK_INVERTED_REG = IS_RX_CLK_INVERTED;
  localparam [0:0] IS_RX_RST_DLY_INVERTED_REG = IS_RX_RST_DLY_INVERTED;
  localparam [0:0] IS_RX_RST_INVERTED_REG = IS_RX_RST_INVERTED;
  localparam [0:0] IS_TX_CLK_INVERTED_REG = IS_TX_CLK_INVERTED;
  localparam [0:0] IS_TX_RST_DLY_INVERTED_REG = IS_TX_RST_DLY_INVERTED;
  localparam [0:0] IS_TX_RST_INVERTED_REG = IS_TX_RST_INVERTED;
  localparam [24:1] PRE_EMPHASIS_REG = PRE_EMPHASIS;
  localparam [112:1] RX_DATA_TYPE_REG = RX_DATA_TYPE;
  localparam [3:0] RX_DATA_WIDTH_REG = RX_DATA_WIDTH;
  localparam [40:1] RX_DELAY_FORMAT_REG = RX_DELAY_FORMAT;
  localparam [64:1] RX_DELAY_TYPE_REG = RX_DELAY_TYPE;
  localparam [10:0] RX_DELAY_VALUE_REG = RX_DELAY_VALUE;
  localparam real RX_REFCLK_FREQUENCY_REG = RX_REFCLK_FREQUENCY;
  localparam [48:1] RX_UPDATE_MODE_REG = RX_UPDATE_MODE;
  localparam [64:1] TBYTE_CTL_REG = TBYTE_CTL;
  localparam [3:0] TX_DATA_WIDTH_REG = TX_DATA_WIDTH;
  localparam [40:1] TX_DELAY_FORMAT_REG = TX_DELAY_FORMAT;
  localparam [64:1] TX_DELAY_TYPE_REG = TX_DELAY_TYPE;
  localparam [10:0] TX_DELAY_VALUE_REG = TX_DELAY_VALUE;
  localparam [40:1] TX_OUTPUT_PHASE_90_REG = TX_OUTPUT_PHASE_90;
  localparam real TX_REFCLK_FREQUENCY_REG = TX_REFCLK_FREQUENCY;
  localparam [48:1] TX_UPDATE_MODE_REG = TX_UPDATE_MODE;
  `endif

  localparam [40:1] DDR_DIS_DQS_REG = "TRUE";
  localparam [40:1] LOOPBACK_REG = "FALSE";
  localparam [0:0] RECALIBRATE_EN_REG = 1'b0;
  localparam [0:0] RX_DC_ADJ_EN_REG = 1'b0;
  localparam [2:0] RX_FDLY_REG = 3'b000;
  localparam [2:0] RX_FDLY_RES_REG = 3'b000;
  reg [63:0] RX_REFCLK_FREQUENCY_INT = RX_REFCLK_FREQUENCY * 1000;
  localparam [40:1] TXRX_LOOPBACK_REG = "FALSE";
  localparam [0:0] TX_DC_ADJ_EN_REG = 1'b0;
  localparam [2:0] TX_FDLY_REG = 3'b000;
  localparam [2:0] TX_FDLY_RES_REG = 3'b000;
  reg [63:0] TX_REFCLK_FREQUENCY_INT = TX_REFCLK_FREQUENCY * 1000;
  localparam [40:1] XIPHY_BITSLICE_MODE_REG = "TRUE";
  localparam [8*5:1] RX_Q4_ROUTETHRU_REG = "FALSE";
  localparam [8*5:1] RX_Q5_ROUTETHRU_REG = "FALSE";
  localparam [8*5:1] TX_Q_ROUTETHRU_REG = "FALSE";
  localparam [8*5:1] TX_T_OUT_ROUTETHRU_REG = "FALSE";

  wire IS_RX_CLK_INVERTED_BIN;
  wire IS_RX_RST_DLY_INVERTED_BIN;
  wire IS_RX_RST_INVERTED_BIN;
  wire IS_TX_CLK_INVERTED_BIN;
  wire IS_TX_RST_DLY_INVERTED_BIN;
  wire IS_TX_RST_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "RXTX_BITSLICE_dr.v"
  `endif

  wire FIFO_EMPTY_out;
  wire FIFO_WRCLK_OUT_out;
  wire O_out;
  wire TX2RX_CASC_OUT_out;
  wire T_OUT_out;
  wire [29:0] TX_BIT_CTRL_OUT_out;
  wire [34:0] RX_BIT_CTRL_OUT_out;
  wire [7:0] Q_out;
  wire [8:0] RX_CNTVALUEOUT_out;
  wire [8:0] TX_CNTVALUEOUT_out;

  wire FIFO_EMPTY_delay;
  wire FIFO_WRCLK_OUT_delay;
  wire O_delay;
  wire T_OUT_delay;
  wire [29:0] TX_BIT_CTRL_OUT_delay;
  wire [34:0] RX_BIT_CTRL_OUT_delay;
  wire [7:0] Q_delay;
  wire [8:0] RX_CNTVALUEOUT_delay;
  wire [8:0] TX_CNTVALUEOUT_delay;

  wire DATAIN_in;
  wire FIFO_RD_CLK_in;
  wire FIFO_RD_EN_in;
  wire IFD_CE_in;
  wire OFD_CE_in;
  wire RX2TX_CASC_RETURN_IN_in;
  wire RX_CE_in;
  wire RX_CLKDIV_in;
  wire RX_CLK_C_B_in;
  wire RX_CLK_C_in;
  wire RX_CLK_in;
  wire RX_DATAIN1_in;
  wire RX_EN_VTC_in;
  wire RX_INC_in;
  wire RX_LOAD_in;
  wire RX_RST_DLY_in;
  wire RX_RST_in;
  wire TBYTE_IN_in;
  wire TX2RX_CASC_IN_in;
  wire TX_CE_in;
  wire TX_CLK_in;
  wire TX_EN_VTC_in;
  wire TX_INC_in;
  wire TX_LOAD_in;
  wire TX_OCLKDIV_in;
  wire TX_OCLK_in;
  wire TX_RST_DLY_in;
  wire TX_RST_in;
  wire T_in;
  wire [23:0] RX_BIT_CTRL_IN_in;
  wire [26:0] TX_BIT_CTRL_IN_in;
  wire [7:0] D_in;
  wire [8:0] RX_CNTVALUEIN_in;
  wire [8:0] TX_CNTVALUEIN_in;

  wire DATAIN_delay;
  wire FIFO_RD_CLK_delay;
  wire FIFO_RD_EN_delay;
  wire RX_CE_delay;
  wire RX_CLK_delay;
  wire RX_EN_VTC_delay;
  wire RX_INC_delay;
  wire RX_LOAD_delay;
  wire RX_RST_DLY_delay;
  wire RX_RST_delay;
  wire TBYTE_IN_delay;
  wire TX_CE_delay;
  wire TX_CLK_delay;
  wire TX_EN_VTC_delay;
  wire TX_INC_delay;
  wire TX_LOAD_delay;
  wire TX_RST_DLY_delay;
  wire TX_RST_delay;
  wire T_delay;
  wire [23:0] RX_BIT_CTRL_IN_delay;
  wire [26:0] TX_BIT_CTRL_IN_delay;
  wire [7:0] D_delay;
  wire [8:0] RX_CNTVALUEIN_delay;
  wire [8:0] TX_CNTVALUEIN_delay;

  wire IDELAY_DATAIN0_out;
  wire IDELAY_DATAOUT_out;
  wire OSERDES_Q_out;
  wire BITSLICE_WRITE_Q_out;
  wire ODELAY_DATAIN0_out;
  wire ODELAY_DATAOUT_out;

  
  assign #(out_delay) FIFO_EMPTY = FIFO_EMPTY_delay;
  assign #(out_delay) FIFO_WRCLK_OUT = FIFO_WRCLK_OUT_delay;
  assign #(out_delay) O = O_delay;
  assign #(out_delay) Q = Q_delay;
  assign #(out_delay) RX_BIT_CTRL_OUT = RX_BIT_CTRL_OUT_delay;
  assign #(out_delay) RX_CNTVALUEOUT = RX_CNTVALUEOUT_delay;
  assign #(out_delay) TX_BIT_CTRL_OUT = TX_BIT_CTRL_OUT_delay;
  assign #(out_delay) TX_CNTVALUEOUT = TX_CNTVALUEOUT_delay;
  assign #(out_delay) T_OUT = T_OUT_delay;
  
`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) FIFO_RD_CLK_delay = FIFO_RD_CLK;
  assign #(inclk_delay) RX_CLK_delay = RX_CLK;
  assign #(inclk_delay) TX_CLK_delay = TX_CLK;

  assign #(in_delay) DATAIN_delay = DATAIN;
  assign #(in_delay) D_delay = D;
  assign #(in_delay) FIFO_RD_EN_delay = FIFO_RD_EN;
  assign #(in_delay) RX_BIT_CTRL_IN_delay = RX_BIT_CTRL_IN;
  assign #(in_delay) RX_CE_delay = RX_CE;
  assign #(in_delay) RX_CNTVALUEIN_delay = RX_CNTVALUEIN;
  assign #(in_delay) RX_INC_delay = RX_INC;
  assign #(in_delay) RX_LOAD_delay = RX_LOAD;
  assign #(in_delay) RX_RST_DLY_delay = RX_RST_DLY;
  assign #(in_delay) RX_RST_delay = RX_RST;
  assign #(in_delay) TX_BIT_CTRL_IN_delay = TX_BIT_CTRL_IN;
  assign #(in_delay) TX_CE_delay = TX_CE;
  assign #(in_delay) TX_CNTVALUEIN_delay = TX_CNTVALUEIN;
  assign #(in_delay) TX_INC_delay = TX_INC;
  assign #(in_delay) TX_LOAD_delay = TX_LOAD;
  assign #(in_delay) TX_RST_DLY_delay = TX_RST_DLY;
  assign #(in_delay) TX_RST_delay = TX_RST;
`endif //  `ifndef XIL_TIMING
// inputs with no timing checks

  assign #(in_delay) RX_EN_VTC_delay = RX_EN_VTC;
  assign #(in_delay) TBYTE_IN_delay = TBYTE_IN;
  assign #(in_delay) TX_EN_VTC_delay = TX_EN_VTC;
  assign #(in_delay) T_delay = T;

  assign FIFO_EMPTY_delay = FIFO_EMPTY_out;
  assign FIFO_WRCLK_OUT_delay = FIFO_WRCLK_OUT_out;
  assign O_delay = O_out;
  assign Q_delay = Q_out;
  assign RX_BIT_CTRL_OUT_delay = RX_BIT_CTRL_OUT_out;
  assign RX_CNTVALUEOUT_delay = RX_CNTVALUEOUT_out;
  assign TX_BIT_CTRL_OUT_delay = TX_BIT_CTRL_OUT_out;
  assign TX_CNTVALUEOUT_delay = TX_CNTVALUEOUT_out;
  assign T_OUT_delay = T_OUT_out;

  assign DATAIN_in = DATAIN_delay;
  assign D_in = D_delay;
  assign FIFO_RD_CLK_in = FIFO_RD_CLK_delay;
  assign FIFO_RD_EN_in = FIFO_RD_EN_delay;
  assign RX_BIT_CTRL_IN_in = RX_BIT_CTRL_IN_delay;
  assign RX_CE_in = RX_CE_delay;
  assign RX_CLK_in = RX_CLK_delay ^ IS_RX_CLK_INVERTED_BIN;
  assign RX_CNTVALUEIN_in = RX_CNTVALUEIN_delay;
  assign RX_EN_VTC_in = RX_EN_VTC_delay;
  assign RX_INC_in = RX_INC_delay;
  assign RX_LOAD_in = RX_LOAD_delay;
  assign RX_RST_DLY_in = RX_RST_DLY_delay ^ IS_RX_RST_DLY_INVERTED_BIN;
  assign RX_RST_in = RX_RST_delay ^ IS_RX_RST_INVERTED_BIN;
  assign TBYTE_IN_in = TBYTE_IN_delay;
  assign TX_BIT_CTRL_IN_in = TX_BIT_CTRL_IN_delay;
  assign TX_CE_in = TX_CE_delay;
  assign TX_CLK_in = TX_CLK_delay ^ IS_TX_CLK_INVERTED_BIN;
  assign TX_CNTVALUEIN_in = TX_CNTVALUEIN_delay;
  assign TX_EN_VTC_in = TX_EN_VTC_delay;
  assign TX_INC_in = TX_INC_delay;
  assign TX_LOAD_in = TX_LOAD_delay;
  assign TX_RST_DLY_in = TX_RST_DLY_delay ^ IS_TX_RST_DLY_INVERTED_BIN;
  assign TX_RST_in = TX_RST_delay ^ IS_TX_RST_INVERTED_BIN;
  assign T_in = T_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign IS_RX_CLK_INVERTED_BIN = IS_RX_CLK_INVERTED_REG;

  assign IS_RX_RST_DLY_INVERTED_BIN = IS_RX_RST_DLY_INVERTED_REG;

  assign IS_RX_RST_INVERTED_BIN = IS_RX_RST_INVERTED_REG;

  assign IS_TX_CLK_INVERTED_BIN = IS_TX_CLK_INVERTED_REG;

  assign IS_TX_RST_DLY_INVERTED_BIN = IS_TX_RST_DLY_INVERTED_REG;

  assign IS_TX_RST_INVERTED_BIN = IS_TX_RST_INVERTED_REG;

  always @ (trig_attr) begin
    #1;
    if ((FIFO_SYNC_MODE_REG != "FALSE") &&
        (FIFO_SYNC_MODE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute FIFO_SYNC_MODE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, FIFO_SYNC_MODE_REG);
      attr_err = 1'b1;
    end

    if ((INIT_REG < 1'b0) || (INIT_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute INIT on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, INIT_REG);
      attr_err = 1'b1;
    end

    if ((IS_RX_CLK_INVERTED_REG < 1'b0) || (IS_RX_CLK_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RX_CLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RX_CLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RX_RST_DLY_INVERTED_REG < 1'b0) || (IS_RX_RST_DLY_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RX_RST_DLY_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RX_RST_DLY_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RX_RST_INVERTED_REG < 1'b0) || (IS_RX_RST_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RX_RST_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RX_RST_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_TX_CLK_INVERTED_REG < 1'b0) || (IS_TX_CLK_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_TX_CLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_TX_CLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_TX_RST_DLY_INVERTED_REG < 1'b0) || (IS_TX_RST_DLY_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_TX_RST_DLY_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_TX_RST_DLY_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_TX_RST_INVERTED_REG < 1'b0) || (IS_TX_RST_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_TX_RST_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_TX_RST_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((PRE_EMPHASIS_REG != "OFF") &&
        (PRE_EMPHASIS_REG != "ON")) begin
      $display("Attribute Syntax Error : The attribute PRE_EMPHASIS on %s instance %m is set to %s.  Legal values for this attribute are OFF or ON.", MODULE_NAME, PRE_EMPHASIS_REG);
      attr_err = 1'b1;
    end

    if ((RX_DATA_TYPE_REG != "NONE") &&
        (RX_DATA_TYPE_REG != "CLOCK") &&
        (RX_DATA_TYPE_REG != "DATA") &&
        (RX_DATA_TYPE_REG != "DATA_AND_CLOCK")) begin
      $display("Attribute Syntax Error : The attribute RX_DATA_TYPE on %s instance %m is set to %s.  Legal values for this attribute are NONE, CLOCK, DATA or DATA_AND_CLOCK.", MODULE_NAME, RX_DATA_TYPE_REG);
      attr_err = 1'b1;
    end

    if ((RX_DATA_WIDTH_REG != 8) &&
        (RX_DATA_WIDTH_REG != 2) &&
        (RX_DATA_WIDTH_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute RX_DATA_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 2 to 8.", MODULE_NAME, RX_DATA_WIDTH_REG, 8);
      attr_err = 1'b1;
    end

    if ((RX_DELAY_FORMAT_REG != "TIME") &&
        (RX_DELAY_FORMAT_REG != "COUNT")) begin
      $display("Attribute Syntax Error : The attribute RX_DELAY_FORMAT on %s instance %m is set to %s.  Legal values for this attribute are TIME or COUNT.", MODULE_NAME, RX_DELAY_FORMAT_REG);
      attr_err = 1'b1;
    end

    if ((RX_DELAY_TYPE_REG != "FIXED") &&
        (RX_DELAY_TYPE_REG != "VARIABLE") &&
        (RX_DELAY_TYPE_REG != "VAR_LOAD")) begin
      $display("Attribute Syntax Error : The attribute RX_DELAY_TYPE on %s instance %m is set to %s.  Legal values for this attribute are FIXED, VARIABLE or VAR_LOAD.", MODULE_NAME, RX_DELAY_TYPE_REG);
      attr_err = 1'b1;
    end

    if ((RX_DELAY_VALUE_REG < 0) || (RX_DELAY_VALUE_REG > 1250)) begin
      $display("Attribute Syntax Error : The attribute RX_DELAY_VALUE on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1250.", MODULE_NAME, RX_DELAY_VALUE_REG);
      attr_err = 1'b1;
    end

    if ((RX_UPDATE_MODE_REG != "ASYNC") &&
        (RX_UPDATE_MODE_REG != "MANUAL") &&
        (RX_UPDATE_MODE_REG != "SYNC")) begin
      $display("Attribute Syntax Error : The attribute RX_UPDATE_MODE on %s instance %m is set to %s.  Legal values for this attribute are ASYNC, MANUAL or SYNC.", MODULE_NAME, RX_UPDATE_MODE_REG);
      attr_err = 1'b1;
    end

    if ((TBYTE_CTL_REG != "TBYTE_IN") &&
        (TBYTE_CTL_REG != "T")) begin
      $display("Attribute Syntax Error : The attribute TBYTE_CTL on %s instance %m is set to %s.  Legal values for this attribute are TBYTE_IN or T.", MODULE_NAME, TBYTE_CTL_REG);
      attr_err = 1'b1;
    end

    if ((TX_DATA_WIDTH_REG != 8) &&
        (TX_DATA_WIDTH_REG != 2) &&
        (TX_DATA_WIDTH_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute TX_DATA_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 2 to 8.", MODULE_NAME, TX_DATA_WIDTH_REG, 8);
      attr_err = 1'b1;
    end

    if ((TX_DELAY_FORMAT_REG != "TIME") &&
        (TX_DELAY_FORMAT_REG != "COUNT")) begin
      $display("Attribute Syntax Error : The attribute TX_DELAY_FORMAT on %s instance %m is set to %s.  Legal values for this attribute are TIME or COUNT.", MODULE_NAME, TX_DELAY_FORMAT_REG);
      attr_err = 1'b1;
    end

    if ((TX_DELAY_TYPE_REG != "FIXED") &&
        (TX_DELAY_TYPE_REG != "VARIABLE") &&
        (TX_DELAY_TYPE_REG != "VAR_LOAD")) begin
      $display("Attribute Syntax Error : The attribute TX_DELAY_TYPE on %s instance %m is set to %s.  Legal values for this attribute are FIXED, VARIABLE or VAR_LOAD.", MODULE_NAME, TX_DELAY_TYPE_REG);
      attr_err = 1'b1;
    end

    if ((TX_DELAY_VALUE_REG < 0) || (TX_DELAY_VALUE_REG > 1250)) begin
      $display("Attribute Syntax Error : The attribute TX_DELAY_VALUE on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1250.", MODULE_NAME, TX_DELAY_VALUE_REG);
      attr_err = 1'b1;
    end

    if ((TX_OUTPUT_PHASE_90_REG != "FALSE") &&
        (TX_OUTPUT_PHASE_90_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute TX_OUTPUT_PHASE_90 on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, TX_OUTPUT_PHASE_90_REG);
      attr_err = 1'b1;
    end

    if ((TX_UPDATE_MODE_REG != "ASYNC") &&
        (TX_UPDATE_MODE_REG != "MANUAL") &&
        (TX_UPDATE_MODE_REG != "SYNC")) begin
      $display("Attribute Syntax Error : The attribute TX_UPDATE_MODE on %s instance %m is set to %s.  Legal values for this attribute are ASYNC, MANUAL or SYNC.", MODULE_NAME, TX_UPDATE_MODE_REG);
      attr_err = 1'b1;
    end

    if (RX_REFCLK_FREQUENCY_REG >= 300.0 && RX_REFCLK_FREQUENCY_REG <= 1333.0) begin // float
      RX_REFCLK_FREQUENCY_INT <= RX_REFCLK_FREQUENCY_REG * 1000;
    end
    else begin
      $display("Attribute Syntax Error : The attribute RX_REFCLK_FREQUENCY on %s instance %m is set to %f.  Legal values for this attribute are  300.0 to 1333.0.", MODULE_NAME, RX_REFCLK_FREQUENCY_REG);
      attr_err = 1'b1;
    end

    if (TX_REFCLK_FREQUENCY_REG >= 300.0 && TX_REFCLK_FREQUENCY_REG <= 1333.0) begin // float
      TX_REFCLK_FREQUENCY_INT <= TX_REFCLK_FREQUENCY_REG * 1000;
    end
    else begin
      $display("Attribute Syntax Error : The attribute TX_REFCLK_FREQUENCY on %s instance %m is set to %f.  Legal values for this attribute are  300.0 to 1333.0.", MODULE_NAME, TX_REFCLK_FREQUENCY_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

  assign RX_CLKDIV_in = 1'b1; // tie off
  assign RX_CLK_C_B_in = 1'b1; // tie off
  assign RX_CLK_C_in = 1'b1; // tie off
  assign TX_OCLKDIV_in = 1'b1; // tie off
  assign TX_OCLK_in = 1'b1; // tie off

  assign IFD_CE_in = 1'b0; // tie off
  assign OFD_CE_in = 1'b0; // tie off
  assign RX2TX_CASC_RETURN_IN_in = 1'b1; // tie off
  assign RX_DATAIN1_in = 1'b0; // tie off
  assign TX2RX_CASC_IN_in = 1'b1; // tie off

  SIP_RXTX_BITSLICE SIP_RXTX_BITSLICE_INST (
    .DDR_DIS_DQS (DDR_DIS_DQS_REG),
    .FIFO_SYNC_MODE (FIFO_SYNC_MODE_REG),
    .INIT (INIT_REG),
    .LOOPBACK (LOOPBACK_REG),
    .PRE_EMPHASIS (PRE_EMPHASIS_REG),
    .RECALIBRATE_EN (RECALIBRATE_EN_REG),
    .RX_DATA_TYPE (RX_DATA_TYPE_REG),
    .RX_DATA_WIDTH (RX_DATA_WIDTH_REG),
    .RX_DC_ADJ_EN (RX_DC_ADJ_EN_REG),
    .RX_DELAY_FORMAT (RX_DELAY_FORMAT_REG),
    .RX_DELAY_TYPE (RX_DELAY_TYPE_REG),
    .RX_DELAY_VALUE (RX_DELAY_VALUE_REG),
    .RX_FDLY (RX_FDLY_REG),
    .RX_FDLY_RES (RX_FDLY_RES_REG),
    .RX_REFCLK_FREQUENCY (RX_REFCLK_FREQUENCY_INT),
    .RX_UPDATE_MODE (RX_UPDATE_MODE_REG),
    .TBYTE_CTL (TBYTE_CTL_REG),
    .TXRX_LOOPBACK (TXRX_LOOPBACK_REG),
    .TX_DATA_WIDTH (TX_DATA_WIDTH_REG),
    .TX_DC_ADJ_EN (TX_DC_ADJ_EN_REG),
    .TX_DELAY_FORMAT (TX_DELAY_FORMAT_REG),
    .TX_DELAY_TYPE (TX_DELAY_TYPE_REG),
    .TX_DELAY_VALUE (TX_DELAY_VALUE_REG),
    .TX_FDLY (TX_FDLY_REG),
    .TX_FDLY_RES (TX_FDLY_RES_REG),
    .TX_OUTPUT_PHASE_90 (TX_OUTPUT_PHASE_90_REG),
    .TX_REFCLK_FREQUENCY (TX_REFCLK_FREQUENCY_INT),
    .TX_UPDATE_MODE (TX_UPDATE_MODE_REG),
    .XIPHY_BITSLICE_MODE (XIPHY_BITSLICE_MODE_REG),
    .RX_Q4_ROUTETHRU (RX_Q4_ROUTETHRU_REG),
    .RX_Q5_ROUTETHRU (RX_Q5_ROUTETHRU_REG),
    .TX_Q_ROUTETHRU (TX_Q_ROUTETHRU_REG),
    .TX_T_OUT_ROUTETHRU (TX_T_OUT_ROUTETHRU_REG),
    .FIFO_EMPTY (FIFO_EMPTY_out),
    .FIFO_WRCLK_OUT (FIFO_WRCLK_OUT_out),
    .O (O_out),
    .Q (Q_out),
    .RX_BIT_CTRL_OUT (RX_BIT_CTRL_OUT_out),
    .RX_CNTVALUEOUT (RX_CNTVALUEOUT_out),
    .TX2RX_CASC_OUT (TX2RX_CASC_OUT_out),
    .TX_BIT_CTRL_OUT (TX_BIT_CTRL_OUT_out),
    .TX_CNTVALUEOUT (TX_CNTVALUEOUT_out),
    .T_OUT (T_OUT_out),
    .D (D_in),
    .DATAIN (DATAIN_in),
    .FIFO_RD_CLK (FIFO_RD_CLK_in),
    .FIFO_RD_EN (FIFO_RD_EN_in),
    .IFD_CE (IFD_CE_in),
    .OFD_CE (OFD_CE_in),
    .RX2TX_CASC_RETURN_IN (RX2TX_CASC_RETURN_IN_in),
    .RX_BIT_CTRL_IN (RX_BIT_CTRL_IN_in),
    .RX_CE (RX_CE_in),
    .RX_CLK (RX_CLK_in),
    .RX_CLKDIV (RX_CLKDIV_in),
    .RX_CLK_C (RX_CLK_C_in),
    .RX_CLK_C_B (RX_CLK_C_B_in),
    .RX_CNTVALUEIN (RX_CNTVALUEIN_in),
    .RX_DATAIN1 (RX_DATAIN1_in),
    .RX_EN_VTC (RX_EN_VTC_in),
    .RX_INC (RX_INC_in),
    .RX_LOAD (RX_LOAD_in),
    .RX_RST (RX_RST_in),
    .RX_RST_DLY (RX_RST_DLY_in),
    .T (T_in),
    .TBYTE_IN (TBYTE_IN_in),
    .TX2RX_CASC_IN (TX2RX_CASC_IN_in),
    .TX_BIT_CTRL_IN (TX_BIT_CTRL_IN_in),
    .TX_CE (TX_CE_in),
    .TX_CLK (TX_CLK_in),
    .TX_CNTVALUEIN (TX_CNTVALUEIN_in),
    .TX_EN_VTC (TX_EN_VTC_in),
    .TX_INC (TX_INC_in),
    .TX_LOAD (TX_LOAD_in),
    .TX_OCLK (TX_OCLK_in),
    .TX_OCLKDIV (TX_OCLKDIV_in),
    .TX_RST (TX_RST_in),
    .TX_RST_DLY (TX_RST_DLY_in),
    .SIM_IDELAY_DATAIN0(IDELAY_DATAIN0_out),
    .SIM_IDELAY_DATAOUT(IDELAY_DATAOUT_out),
    .SIM_OSERDES_Q(OSERDES_Q_out),
    .SIM_BITSLICE_WRITE_Q(BITSLICE_WRITE_Q_out),
    .SIM_ODELAY_DATAIN0(ODELAY_DATAIN0_out),
    .SIM_ODELAY_DATAOUT(ODELAY_DATAOUT_out),
    .GSR (glblGSR)
  );

    specify
    (D *> O) = (0:0:0, 0:0:0);
    (D *> T_OUT) = (0:0:0, 0:0:0);
    (DATAIN *> Q) = (0:0:0, 0:0:0);
    (DATAIN *> RX_BIT_CTRL_OUT) = (0:0:0, 0:0:0);
    (FIFO_RD_CLK *> Q) = (0:0:0, 0:0:0);
    (FIFO_RD_CLK => FIFO_EMPTY) = (0:0:0, 0:0:0);
    (RX_BIT_CTRL_IN *> Q) = (0:0:0, 0:0:0);
    (TBYTE_IN => T_OUT) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN *> O) = (0:0:0, 0:0:0);
    (TX_BIT_CTRL_IN *> T_OUT) = (0:0:0, 0:0:0);
    (negedge RX_RST *> (Q +: 0)) = (0:0:0, 0:0:0);
    (negedge TX_RST => (O +: 0)) = (0:0:0, 0:0:0);
    (posedge RX_RST *> (Q +: 0)) = (0:0:0, 0:0:0);
    (posedge TX_RST => (O +: 0)) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge FIFO_RD_CLK, 0:0:0, notifier);
    $period (negedge RX_BIT_CTRL_IN[21], 0:0:0, notifier);
    $period (negedge RX_CLK, 0:0:0, notifier);
    $period (negedge TX_BIT_CTRL_IN[0], 0:0:0, notifier);
    $period (negedge TX_BIT_CTRL_IN[25], 0:0:0, notifier);
    $period (negedge TX_BIT_CTRL_IN[26], 0:0:0, notifier);
    $period (negedge TX_CLK, 0:0:0, notifier);
    $period (posedge FIFO_RD_CLK, 0:0:0, notifier);
    $period (posedge RX_BIT_CTRL_IN[21], 0:0:0, notifier);
    $period (posedge RX_CLK, 0:0:0, notifier);
    $period (posedge TX_BIT_CTRL_IN[0], 0:0:0, notifier);
    $period (posedge TX_BIT_CTRL_IN[25], 0:0:0, notifier);
    $period (posedge TX_BIT_CTRL_IN[26], 0:0:0, notifier);
    $period (posedge TX_CLK, 0:0:0, notifier);
    $recrem ( negedge RX_RST, posedge FIFO_RD_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_delay, FIFO_RD_CLK_delay);
    $recrem ( negedge RX_RST, posedge RX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, RX_RST_delay, RX_BIT_CTRL_IN_delay);
    $recrem ( negedge RX_RST_DLY, negedge RX_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_CLK_delay);
    $recrem ( negedge RX_RST_DLY, posedge RX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_BIT_CTRL_IN_delay);
    $recrem ( negedge RX_RST_DLY, posedge RX_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_CLK_delay);
    $recrem ( negedge TX_RST, negedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( negedge TX_RST, posedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( negedge TX_RST_DLY, negedge TX_CLK, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_CLK_delay);
    $recrem ( negedge TX_RST_DLY, posedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( negedge TX_RST_DLY, posedge TX_CLK, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_CLK_delay);
    $recrem ( posedge RX_RST, posedge FIFO_RD_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_delay, FIFO_RD_CLK_delay);
    $recrem ( posedge RX_RST, posedge RX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, RX_RST_delay, RX_BIT_CTRL_IN_delay);
    $recrem ( posedge RX_RST_DLY, negedge RX_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_CLK_delay);
    $recrem ( posedge RX_RST_DLY, posedge RX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_BIT_CTRL_IN_delay);
    $recrem ( posedge RX_RST_DLY, posedge RX_CLK, 0:0:0, 0:0:0, notifier,,, RX_RST_DLY_delay, RX_CLK_delay);
    $recrem ( posedge TX_RST, negedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( posedge TX_RST, posedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( posedge TX_RST_DLY, negedge TX_CLK, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_CLK_delay);
    $recrem ( posedge TX_RST_DLY, posedge TX_BIT_CTRL_IN, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_BIT_CTRL_IN_delay);
    $recrem ( posedge TX_RST_DLY, posedge TX_CLK, 0:0:0, 0:0:0, notifier,,, TX_RST_DLY_delay, TX_CLK_delay);
    $setuphold (negedge RX_CLK, negedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CE_delay);
    $setuphold (negedge RX_CLK, negedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CNTVALUEIN_delay);
    $setuphold (negedge RX_CLK, negedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_INC_delay);
    $setuphold (negedge RX_CLK, negedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_LOAD_delay);
    $setuphold (negedge RX_CLK, posedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CE_delay);
    $setuphold (negedge RX_CLK, posedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CNTVALUEIN_delay);
    $setuphold (negedge RX_CLK, posedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_INC_delay);
    $setuphold (negedge RX_CLK, posedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_LOAD_delay);
    $setuphold (negedge TX_BIT_CTRL_IN, negedge D, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, D_delay);
    $setuphold (negedge TX_BIT_CTRL_IN, posedge D, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, D_delay);
    $setuphold (negedge TX_CLK, negedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CE_delay);
    $setuphold (negedge TX_CLK, negedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CNTVALUEIN_delay);
    $setuphold (negedge TX_CLK, negedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_INC_delay);
    $setuphold (negedge TX_CLK, negedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_LOAD_delay);
    $setuphold (negedge TX_CLK, posedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CE_delay);
    $setuphold (negedge TX_CLK, posedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CNTVALUEIN_delay);
    $setuphold (negedge TX_CLK, posedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_INC_delay);
    $setuphold (negedge TX_CLK, posedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_LOAD_delay);
    $setuphold (posedge FIFO_RD_CLK, negedge FIFO_RD_EN, 0:0:0, 0:0:0, notifier,,, FIFO_RD_CLK_delay, FIFO_RD_EN_delay);
    $setuphold (posedge FIFO_RD_CLK, posedge FIFO_RD_EN, 0:0:0, 0:0:0, notifier,,, FIFO_RD_CLK_delay, FIFO_RD_EN_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, negedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_CE_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, negedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_CNTVALUEIN_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, negedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_INC_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, negedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_LOAD_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, posedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_CE_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, posedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_CNTVALUEIN_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, posedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_INC_delay);
    $setuphold (posedge RX_BIT_CTRL_IN, posedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_BIT_CTRL_IN_delay, RX_LOAD_delay);
    $setuphold (posedge RX_CLK, negedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CE_delay);
    $setuphold (posedge RX_CLK, negedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CNTVALUEIN_delay);
    $setuphold (posedge RX_CLK, negedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_INC_delay);
    $setuphold (posedge RX_CLK, negedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_LOAD_delay);
    $setuphold (posedge RX_CLK, posedge RX_CE, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CE_delay);
    $setuphold (posedge RX_CLK, posedge RX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_CNTVALUEIN_delay);
    $setuphold (posedge RX_CLK, posedge RX_INC, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_INC_delay);
    $setuphold (posedge RX_CLK, posedge RX_LOAD, 0:0:0, 0:0:0, notifier,,, RX_CLK_delay, RX_LOAD_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge D, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, D_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge DATAIN, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, DATAIN_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_CE_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_CNTVALUEIN_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_INC_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, negedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_LOAD_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge D, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, D_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge DATAIN, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, DATAIN_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_CE_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_CNTVALUEIN_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_INC_delay);
    $setuphold (posedge TX_BIT_CTRL_IN, posedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_BIT_CTRL_IN_delay, TX_LOAD_delay);
    $setuphold (posedge TX_CLK, negedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CE_delay);
    $setuphold (posedge TX_CLK, negedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CNTVALUEIN_delay);
    $setuphold (posedge TX_CLK, negedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_INC_delay);
    $setuphold (posedge TX_CLK, negedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_LOAD_delay);
    $setuphold (posedge TX_CLK, posedge TX_CE, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CE_delay);
    $setuphold (posedge TX_CLK, posedge TX_CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_CNTVALUEIN_delay);
    $setuphold (posedge TX_CLK, posedge TX_INC, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_INC_delay);
    $setuphold (posedge TX_CLK, posedge TX_LOAD, 0:0:0, 0:0:0, notifier,,, TX_CLK_delay, TX_LOAD_delay);
    $width (negedge FIFO_RD_CLK, 0:0:0, 0, notifier);
    $width (negedge RX_BIT_CTRL_IN, 0:0:0, 0, notifier);
    $width (negedge RX_CLK, 0:0:0, 0, notifier);
    $width (negedge TX_BIT_CTRL_IN, 0:0:0, 0, notifier);
    $width (negedge TX_CLK, 0:0:0, 0, notifier);
    $width (posedge FIFO_RD_CLK, 0:0:0, 0, notifier);
    $width (posedge RX_BIT_CTRL_IN, 0:0:0, 0, notifier);
    $width (posedge RX_CLK, 0:0:0, 0, notifier);
    $width (posedge TX_BIT_CTRL_IN, 0:0:0, 0, notifier);
    $width (posedge TX_CLK, 0:0:0, 0, notifier);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
