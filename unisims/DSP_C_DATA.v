// $Header: $
///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 2012 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   /
// /___/  \  /    Vendor      : Xilinx
// \   \   \/     Version     : 2012.2
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /         
// /___/   /\     
// \   \  /  \    Filename    : DSP_C_DATA.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  04/23/13 - 714772 - remove sensitivity to negedge GSR
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP_C_DATA
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer CREG = 1,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RSTC_INVERTED = 1'b0
) (
  output [47:0] C_DATA,

  input [47:0] C,
  input CEC,
  input CLK,
  input RSTC
);
  
// define constants
  localparam MODULE_NAME = "DSP_C_DATA";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam CREG_0 = 1;
  localparam CREG_1 = 0;

  `ifndef XIL_DR
  localparam [0:0] CREG_REG = CREG;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [0:0] IS_RSTC_INVERTED_REG = IS_RSTC_INVERTED;
  `endif
  wire CREG_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire IS_RSTC_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING
  reg notifier;
  `endif

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP_C_DATA_dr.v"
  `endif

  wire [47:0] C_DATA_out;

  wire [47:0] C_DATA_delay;

  wire CEC_in;
  wire CLK_in;
  wire RSTC_in;
  wire [47:0] C_in;

  wire CEC_delay;
  wire CLK_delay;
  wire RSTC_delay;
  wire [47:0] C_delay;
  
  reg [47:0] C_reg = 48'b0;
  wire CLK_creg;

// input output assignments
  assign #(out_delay) C_DATA = C_DATA_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) CEC_delay = CEC;
  assign #(in_delay) C_delay = C;
  assign #(in_delay) RSTC_delay = RSTC;
`endif


  assign C_DATA_delay = C_DATA_out;

  assign CEC_in = CEC_delay;
  assign CLK_creg   = (CREG_BIN == CREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign C_in = C_delay;
  assign RSTC_in = RSTC_delay ^ IS_RSTC_INVERTED_BIN;

  initial begin
  `ifndef XIL_TIMING
  $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
  `endif
//  $finish;
  #1;
  trig_attr = ~trig_attr;
  end

  assign CREG_BIN =
    (CREG_REG == 1) ? CREG_1 :
    (CREG_REG == 0) ? CREG_0 :
     CREG_1;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_RSTC_INVERTED_BIN = IS_RSTC_INVERTED_REG;


  always @ (trig_attr) begin
    #1;
//-------- CREG check
    if ((CREG_REG != 0) && (CREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute CREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, CREG_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

//*********************************************************
//*** Input register C with 1 level deep of register
//*********************************************************

//   assign CLK_creg = (CREG_BIN == CREG_1) ? CLK_in : 1'b0;

   always @(posedge CLK_creg) begin
      if      (RSTC_in || glblGSR) C_reg <= 48'b0;
      else if (CEC_in)  C_reg <= C_in;
      end

   assign C_DATA_out = (CREG_BIN == CREG_1) ? C_reg : C_in;


  specify
    (C *> C_DATA) = (0:0:0, 0:0:0);
    (CLK *> C_DATA) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim 
    $setuphold (negedge CLK, negedge C, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_delay);
    $setuphold (negedge CLK, negedge CEC, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEC_delay);
    $setuphold (negedge CLK, negedge RSTC, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTC_delay);
    $setuphold (negedge CLK, posedge C, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_delay);
    $setuphold (negedge CLK, posedge CEC, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEC_delay);
    $setuphold (negedge CLK, posedge RSTC, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTC_delay);
    $setuphold (posedge CLK, negedge C, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_delay);
    $setuphold (posedge CLK, negedge CEC, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEC_delay);
    $setuphold (posedge CLK, negedge RSTC, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTC_delay);
    $setuphold (posedge CLK, posedge C, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_delay);
    $setuphold (posedge CLK, posedge CEC, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEC_delay);
    $setuphold (posedge CLK, posedge RSTC, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTC_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
