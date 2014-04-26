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
// \   \  /  \    Filename    : DSP_M_DATA.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  04/22/13 - 713695 - Zero mult result on USE_SIMD
//  04/23/13 - 714772 - remove sensitivity to negedge GSR
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP_M_DATA
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RSTM_INVERTED = 1'b0,
  parameter integer MREG = 1
) (
  output [44:0] U_DATA,
  output [44:0] V_DATA,

  input CEM,
  input CLK,
  input RSTM,
  input [44:0] U,
  input [44:0] V
);
  
// define constants
  localparam MODULE_NAME = "DSP_M_DATA";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam MREG_0 = 1;
  localparam MREG_1 = 0;

  `ifndef XIL_DR
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [0:0] IS_RSTM_INVERTED_REG = IS_RSTM_INVERTED;
  localparam [0:0] MREG_REG = MREG;
  `endif
  wire IS_CLK_INVERTED_BIN;
  wire IS_RSTM_INVERTED_BIN;
  wire MREG_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING
  reg notifier;
  `endif

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP_M_DATA_dr.v"
  `endif

  wire [44:0] U_DATA_out;
  wire [44:0] V_DATA_out;

  wire [44:0] U_DATA_delay;
  wire [44:0] V_DATA_delay;

  wire CEM_in;
  wire CLK_in;
  wire RSTM_in;
  wire [44:0] U_in;
  wire [44:0] V_in;

  wire CEM_delay;
  wire CLK_delay;
  wire RSTM_delay;
  wire [44:0] U_delay;
  wire [44:0] V_delay;
  
  reg [44:0] U_DATA_reg = 45'h100000000000;
  reg [44:0] V_DATA_reg = 45'h100000000000;
  wire CLK_mreg;

// input output assignments
  assign #(out_delay) U_DATA = U_DATA_delay;
  assign #(out_delay) V_DATA = V_DATA_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) CEM_delay = CEM;
  assign #(in_delay) RSTM_delay = RSTM;
  assign #(in_delay) U_delay = U;
  assign #(in_delay) V_delay = V;
`endif


  assign U_DATA_delay = U_DATA_out;
  assign V_DATA_delay = V_DATA_out;

  assign CEM_in = CEM_delay;
  assign CLK_mreg   = (MREG_BIN == MREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign RSTM_in = RSTM_delay ^ IS_RSTM_INVERTED_BIN;
  assign U_in = U_delay;
  assign V_in = V_delay;

  initial begin
  `ifndef XIL_TIMING
  $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
  `endif
//  $finish;
  #1;
  trig_attr = ~trig_attr;
  end

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_RSTM_INVERTED_BIN = IS_RSTM_INVERTED_REG;

  assign MREG_BIN =
    (MREG_REG == 1) ? MREG_1 :
    (MREG_REG == 0) ? MREG_0 :
     MREG_1;


  always @ (trig_attr) begin
    #1;
//-------- MREG check
    if ((MREG_REG != 0) && (MREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute MREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, MREG_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

//*********************************************************
//*** Multiplier outputs U, V  with 1 level deep of register
//*********************************************************

   assign U_DATA_out    = (MREG_BIN == MREG_1) ? U_DATA_reg    : U_in;
   assign V_DATA_out    = (MREG_BIN == MREG_1) ? V_DATA_reg    : V_in;
//   assign CLK_mreg =      (MREG_BIN == MREG_1) ? CLK_in        : 1'b0;

   always @(posedge CLK_mreg) begin
      if  (RSTM_in || glblGSR) begin
          U_DATA_reg <= 45'h100000000000;
          V_DATA_reg <= 45'h100000000000;
          end
      else if (CEM_in)  begin
          U_DATA_reg <= U_in;
          V_DATA_reg <= V_in;
          end
      end


  specify
    (CLK *> U_DATA) = (0:0:0, 0:0:0);
    (CLK *> V_DATA) = (0:0:0, 0:0:0);
    (U *> U_DATA) = (0:0:0, 0:0:0);
    (V *> V_DATA) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim 
    $setuphold (negedge CLK, negedge CEM, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEM_delay);
    $setuphold (negedge CLK, negedge RSTM, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTM_delay);
    $setuphold (negedge CLK, negedge U, 0:0:0, 0:0:0, notifier,,, CLK_delay, U_delay);
    $setuphold (negedge CLK, negedge V, 0:0:0, 0:0:0, notifier,,, CLK_delay, V_delay);
    $setuphold (negedge CLK, posedge CEM, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEM_delay);
    $setuphold (negedge CLK, posedge RSTM, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTM_delay);
    $setuphold (negedge CLK, posedge U, 0:0:0, 0:0:0, notifier,,, CLK_delay, U_delay);
    $setuphold (negedge CLK, posedge V, 0:0:0, 0:0:0, notifier,,, CLK_delay, V_delay);
    $setuphold (posedge CLK, negedge CEM, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEM_delay);
    $setuphold (posedge CLK, negedge RSTM, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTM_delay);
    $setuphold (posedge CLK, negedge U, 0:0:0, 0:0:0, notifier,,, CLK_delay, U_delay);
    $setuphold (posedge CLK, negedge V, 0:0:0, 0:0:0, notifier,,, CLK_delay, V_delay);
    $setuphold (posedge CLK, posedge CEM, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEM_delay);
    $setuphold (posedge CLK, posedge RSTM, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTM_delay);
    $setuphold (posedge CLK, posedge U, 0:0:0, 0:0:0, notifier,,, CLK_delay, U_delay);
    $setuphold (posedge CLK, posedge V, 0:0:0, 0:0:0, notifier,,, CLK_delay, V_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
