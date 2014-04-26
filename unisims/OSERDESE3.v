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
// /___/   /\      Filename    : OSERDESE3.v
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
module OSERDESE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DATA_WIDTH = 8,
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_CLKDIV_INVERTED = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter ODDR_MODE = "FALSE",
  parameter OSERDES_D_BYPASS = "FALSE",
  parameter OSERDES_T_BYPASS = "FALSE"
)(
  output OQ,
  output T_OUT,

  input CLK,
  input CLKDIV,
  input [7:0] D,
  input RST,
  input T
);
  
// define constants
  localparam MODULE_NAME = "OSERDESE3";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [3:0] DATA_WIDTH_REG = DATA_WIDTH;
  localparam [0:0] INIT_REG = INIT;
  localparam [0:0] IS_CLKDIV_INVERTED_REG = IS_CLKDIV_INVERTED;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [0:0] IS_RST_INVERTED_REG = IS_RST_INVERTED;
  localparam [40:1] ODDR_MODE_REG = ODDR_MODE;
  localparam [40:1] OSERDES_D_BYPASS_REG = OSERDES_D_BYPASS;
  localparam [40:1] OSERDES_T_BYPASS_REG = OSERDES_T_BYPASS;
  `endif

  localparam [64:1] TBYTE_CTL_REG = "T";

  wire IS_CLKDIV_INVERTED_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire IS_RST_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "OSERDESE3_dr.v"
  `endif

  wire OQ_out;
  wire T_OUT_out;

  wire OQ_delay;
  wire T_OUT_delay;

  wire CLKDIV_in;
  wire CLK_in;
  wire OFD_CE_in;
  wire RST_in;
  wire T_in;
  wire [7:0] D_in;

  wire CLKDIV_delay;
  wire CLK_delay;
  wire RST_delay;
  wire T_delay;
  wire [7:0] D_delay;

  
  assign #(out_delay) OQ = OQ_delay;
  assign #(out_delay) T_OUT = T_OUT_delay;
  
`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLKDIV_delay = CLKDIV;
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) D_delay = D;
  assign #(in_delay) RST_delay = RST;
`endif //  `ifndef XIL_TIMING
// inputs with no timing checks

  assign #(in_delay) T_delay = T;

  assign OQ_delay = OQ_out;
  assign T_OUT_delay = T_OUT_out;

  assign CLKDIV_in = CLKDIV_delay ^ IS_CLKDIV_INVERTED_BIN;
  assign CLK_in = CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign D_in = D_delay;
  assign RST_in = RST_delay ^ IS_RST_INVERTED_BIN;
  assign T_in = T_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign IS_CLKDIV_INVERTED_BIN = IS_CLKDIV_INVERTED_REG;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_RST_INVERTED_BIN = IS_RST_INVERTED_REG;

  always @ (trig_attr) begin
    #1;
    if ((DATA_WIDTH_REG != 8) &&
        (DATA_WIDTH_REG != 2) &&
        (DATA_WIDTH_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute DATA_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 2 to 8.", MODULE_NAME, DATA_WIDTH_REG, 8);
      attr_err = 1'b1;
    end

    if ((INIT_REG < 1'b0) || (INIT_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute INIT on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, INIT_REG);
      attr_err = 1'b1;
    end

    if ((IS_CLKDIV_INVERTED_REG < 1'b0) || (IS_CLKDIV_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_CLKDIV_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLKDIV_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_CLK_INVERTED_REG < 1'b0) || (IS_CLK_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_CLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RST_INVERTED_REG < 1'b0) || (IS_RST_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RST_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RST_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((ODDR_MODE_REG != "FALSE") &&
        (ODDR_MODE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute ODDR_MODE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, ODDR_MODE_REG);
      attr_err = 1'b1;
    end

    if ((OSERDES_D_BYPASS_REG != "FALSE") &&
        (OSERDES_D_BYPASS_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute OSERDES_D_BYPASS on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, OSERDES_D_BYPASS_REG);
      attr_err = 1'b1;
    end

    if ((OSERDES_T_BYPASS_REG != "FALSE") &&
        (OSERDES_T_BYPASS_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute OSERDES_T_BYPASS on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, OSERDES_T_BYPASS_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end


  assign OFD_CE_in = 1'b0; // tie off

  SIP_OSERDESE3 SIP_OSERDESE3_INST (
    .DATA_WIDTH (DATA_WIDTH_REG),
    .INIT (INIT_REG),
    .ODDR_MODE (ODDR_MODE_REG),
    .OSERDES_D_BYPASS (OSERDES_D_BYPASS_REG),
    .OSERDES_T_BYPASS (OSERDES_T_BYPASS_REG),
    .TBYTE_CTL (TBYTE_CTL_REG),
    .OQ (OQ_out),
    .T_OUT (T_OUT_out),
    .CLK (CLK_in),
    .CLKDIV (CLKDIV_in),
    .D (D_in),
    .OFD_CE (OFD_CE_in),
    .RST (RST_in),
    .T (T_in),
    .GSR (glblGSR)
  );

    specify
    (CLK => OQ) = (0:0:0, 0:0:0);
    (CLKDIV => OQ) = (0:0:0, 0:0:0);
    (CLKDIV => T_OUT) = (0:0:0, 0:0:0);
    (D *> OQ) = (0:0:0, 0:0:0);
    (D *> T_OUT) = (0:0:0, 0:0:0);
    (T => T_OUT) = (0:0:0, 0:0:0);
    (negedge RST => (OQ +: 0)) = (0:0:0, 0:0:0);
    (posedge RST => (OQ +: 0)) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge CLK, 0:0:0, notifier);
    $period (negedge CLKDIV, 0:0:0, notifier);
    $period (posedge CLK, 0:0:0, notifier);
    $period (posedge CLKDIV, 0:0:0, notifier);
    $recrem ( negedge RST, negedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( negedge RST, negedge CLKDIV, 0:0:0, 0:0:0, notifier,,, RST_delay, CLKDIV_delay);
    $recrem ( negedge RST, posedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( negedge RST, posedge CLKDIV, 0:0:0, 0:0:0, notifier,,, RST_delay, CLKDIV_delay);
    $recrem ( posedge RST, negedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( posedge RST, negedge CLKDIV, 0:0:0, 0:0:0, notifier,,, RST_delay, CLKDIV_delay);
    $recrem ( posedge RST, posedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( posedge RST, posedge CLKDIV, 0:0:0, 0:0:0, notifier,,, RST_delay, CLKDIV_delay);
    $setuphold (negedge CLKDIV, negedge D, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, D_delay);
    $setuphold (negedge CLKDIV, negedge RST, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, RST_delay);
    $setuphold (negedge CLKDIV, posedge D, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, D_delay);
    $setuphold (negedge CLKDIV, posedge RST, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, RST_delay);
    $setuphold (posedge CLKDIV, negedge D, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, D_delay);
    $setuphold (posedge CLKDIV, negedge RST, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, RST_delay);
    $setuphold (posedge CLKDIV, posedge D, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, D_delay);
    $setuphold (posedge CLKDIV, posedge RST, 0:0:0, 0:0:0, notifier,,, CLKDIV_delay, RST_delay);
    $width (negedge CLKDIV, 0:0:0, 0, notifier);
    $width (posedge CLKDIV, 0:0:0, 0, notifier);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
