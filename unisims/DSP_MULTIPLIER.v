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
// \   \  /  \    Filename    : DSP_MULTIPLIER.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP_MULTIPLIER
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter AMULTSEL = "A",
  parameter BMULTSEL = "B",
  parameter USE_MULT = "MULTIPLY"
) (
  output AMULT26,
  output BMULT17,
  output [44:0] U,
  output [44:0] V,

  input [26:0] A2A1,
  input [26:0] AD_DATA,
  input [17:0] B2B1
);
  
// define constants
  localparam MODULE_NAME = "DSP_MULTIPLIER";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

  localparam AMULTSEL_A = 0;
  localparam AMULTSEL_AD = 1;
  localparam BMULTSEL_AD = 1;
  localparam BMULTSEL_B = 0;
  localparam USE_MULT_DYNAMIC  = 1;
  localparam USE_MULT_MULTIPLY = 0;
  localparam USE_MULT_NONE     = 2;

  `ifndef XIL_DR
  localparam [16:1] AMULTSEL_REG = AMULTSEL;
  localparam [16:1] BMULTSEL_REG = BMULTSEL;
  localparam [64:1] USE_MULT_REG = USE_MULT;
  `endif
  wire AMULTSEL_BIN;
  wire BMULTSEL_BIN;
  wire [1:0] USE_MULT_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING
  reg notifier;
  `endif

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP_MULTIPLIER_dr.v"
  `endif

  wire AMULT26_out;
  wire BMULT17_out;
  wire [44:0] U_out;
  wire [44:0] V_out;

  wire AMULT26_delay;
  wire BMULT17_delay;
  wire [44:0] U_delay;
  wire [44:0] V_delay;

  wire [17:0] B2B1_in;
  wire [26:0] A2A1_in;
  wire [26:0] AD_DATA_in;

  wire [17:0] B2B1_delay;
  wire [26:0] A2A1_delay;
  wire [26:0] AD_DATA_delay;
  
  wire [17:0] b_mult_mux;
  wire [26:0] a_mult_mux;
  wire [44:0] mult;
  reg [43:0] ps_u_mask = 44'h55555555555;
  reg [43:0] ps_v_mask = 44'haaaaaaaaaaa;

// input output assignments
  assign #(out_delay) AMULT26 = AMULT26_delay;
  assign #(out_delay) BMULT17 = BMULT17_delay;
  assign #(out_delay) U = U_delay;
  assign #(out_delay) V = V_delay;


// inputs with no timing checks

  assign #(in_delay) A2A1_delay = A2A1;
  assign #(in_delay) AD_DATA_delay = AD_DATA;
  assign #(in_delay) B2B1_delay = B2B1;

  assign AMULT26_delay = AMULT26_out;
  assign BMULT17_delay = BMULT17_out;
  assign U_delay = U_out;
  assign V_delay = V_out;

  assign A2A1_in = A2A1_delay;
  assign AD_DATA_in = AD_DATA_delay;
  assign B2B1_in = B2B1_delay;

  initial begin
  `ifndef XIL_TIMING
  $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
  `endif
//  $finish;
  #1;
  trig_attr = ~trig_attr;
  end

  assign AMULTSEL_BIN = 
    (AMULTSEL_REG == "A") ? AMULTSEL_A :
    (AMULTSEL_REG == "AD") ? AMULTSEL_AD :
    AMULTSEL_A;

  assign BMULTSEL_BIN = 
    (BMULTSEL_REG == "B") ? BMULTSEL_B :
    (BMULTSEL_REG == "AD") ? BMULTSEL_AD :
    BMULTSEL_B;

  assign USE_MULT_BIN = 
    (USE_MULT_REG == "MULTIPLY") ? USE_MULT_MULTIPLY :
    (USE_MULT_REG == "DYNAMIC") ? USE_MULT_DYNAMIC :
    (USE_MULT_REG == "NONE") ? USE_MULT_NONE :
    USE_MULT_MULTIPLY;


  always @ (trig_attr) begin
    #1;
//-------- AMULTSEL check
    if ((AMULTSEL_REG != "A") &&
        (AMULTSEL_REG != "AD")) begin
        $display("Attribute Syntax Error : The attribute AMULTSEL on %s instance %m is set to %s.  Legal values for this attribute are A or AD.", MODULE_NAME, AMULTSEL_REG);
        attr_err = 1'b1;
    end

//-------- BMULTSEL check
    if ((BMULTSEL_REG != "B") &&
        (BMULTSEL_REG != "AD")) begin
        $display("Attribute Syntax Error : The attribute BMULTSEL on %s instance %m is set to %s.  Legal values for this attribute are B or AD.", MODULE_NAME, BMULTSEL_REG);
        attr_err = 1'b1;
    end

//-------- USE_MULT check
    if ((USE_MULT_REG != "MULTIPLY") && 
        (USE_MULT_REG != "DYNAMIC") && 
        (USE_MULT_REG != "NONE")) begin
        $display("Attribute Syntax Error : The attribute USE_MULT on %s instance %m is set to %s.  Legal values for this attribute are MULTIPLY, DYNAMIC or NONE.", MODULE_NAME, USE_MULT_REG);
        attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

assign a_mult_mux = (AMULTSEL_BIN == AMULTSEL_A) ? A2A1_in : AD_DATA_in;
assign b_mult_mux = (BMULTSEL_BIN == BMULTSEL_B) ? B2B1_in : AD_DATA_in;

assign AMULT26_out = a_mult_mux[26];
assign BMULT17_out = b_mult_mux[17];
// U[44],V[44]  11 when mult[44]=0,  10 when mult[44]=1
assign U_out = {1'b1,      mult[43:0] & ps_u_mask};
assign V_out = {~mult[44], mult[43:0] & ps_v_mask};

assign mult = (USE_MULT_BIN == USE_MULT_NONE) ? 45'b0 :
        ({{18{a_mult_mux[26]}},a_mult_mux} * {{27{b_mult_mux[17]}},b_mult_mux});


  specify
    (A2A1 *> AMULT26) = (0:0:0, 0:0:0);
    (A2A1 *> U) = (0:0:0, 0:0:0);
    (A2A1 *> V) = (0:0:0, 0:0:0);
    (AD_DATA *> AMULT26) = (0:0:0, 0:0:0);
    (AD_DATA *> BMULT17) = (0:0:0, 0:0:0);
    (AD_DATA *> U) = (0:0:0, 0:0:0);
    (AD_DATA *> V) = (0:0:0, 0:0:0);
    (B2B1 *> BMULT17) = (0:0:0, 0:0:0);
    (B2B1 *> U) = (0:0:0, 0:0:0);
    (B2B1 *> V) = (0:0:0, 0:0:0);
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
