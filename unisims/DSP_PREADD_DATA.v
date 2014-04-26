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
// \   \  /  \    Filename    : DSP_PREADD_DATA.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  01/11/13 - DIN, D_DATA data width change (26/24) sync4 yml
//  04/23/13 - 714772 - remove sensitivity to negedge GSR
//  05/07/13 - 716896 - INMODE_INV_REG mis sized
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP_PREADD_DATA
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer ADREG = 1,
  parameter AMULTSEL = "A",
  parameter BMULTSEL = "B",
  parameter integer DREG = 1,
  parameter integer INMODEREG = 1,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [4:0] IS_INMODE_INVERTED = 5'b00000,
  parameter [0:0] IS_RSTD_INVERTED = 1'b0,
  parameter [0:0] IS_RSTINMODE_INVERTED = 1'b0,
  parameter PREADDINSEL = "A",
  parameter USE_MULT = "MULTIPLY"
) (
  output [26:0] A2A1,
  output ADDSUB,
  output [26:0] AD_DATA,
  output [17:0] B2B1,
  output [26:0] D_DATA,
  output INMODE_2,
  output [26:0] PREADD_AB,

  input [26:0] A1_DATA,
  input [26:0] A2_DATA,
  input [26:0] AD,
  input [17:0] B1_DATA,
  input [17:0] B2_DATA,
  input CEAD,
  input CED,
  input CEINMODE,
  input CLK,
  input [26:0] DIN,
  input [4:0] INMODE,
  input RSTD,
  input RSTINMODE
);
  
// define constants
  localparam MODULE_NAME = "DSP_PREADD_DATA";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam ADREG_0 = 1;
  localparam ADREG_1 = 0;
  localparam AMULTSEL_A = 0;
  localparam AMULTSEL_AD = 1;
  localparam BMULTSEL_AD = 1;
  localparam BMULTSEL_B = 0;
  localparam DREG_0 = 1;
  localparam DREG_1 = 0;
  localparam INMODEREG_0 = 1;
  localparam INMODEREG_1 = 0;
  localparam PREADDINSEL_A = 0;
  localparam PREADDINSEL_B = 1;
  localparam USE_MULT_DYNAMIC  = 1;
  localparam USE_MULT_MULTIPLY = 0;
  localparam USE_MULT_NONE     = 2;

  `ifndef XIL_DR
  localparam [0:0] ADREG_REG = ADREG;
  localparam [16:1] AMULTSEL_REG = AMULTSEL;
  localparam [16:1] BMULTSEL_REG = BMULTSEL;
  localparam [0:0] DREG_REG = DREG;
  localparam [0:0] INMODEREG_REG = INMODEREG;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [4:0] IS_INMODE_INVERTED_REG = IS_INMODE_INVERTED;
  localparam [0:0] IS_RSTD_INVERTED_REG = IS_RSTD_INVERTED;
  localparam [0:0] IS_RSTINMODE_INVERTED_REG = IS_RSTINMODE_INVERTED;
  localparam [8:1] PREADDINSEL_REG = PREADDINSEL;
  localparam [64:1] USE_MULT_REG = USE_MULT;
  `endif
  wire ADREG_BIN;
  wire AMULTSEL_BIN;
  wire BMULTSEL_BIN;
  wire DREG_BIN;
  wire INMODEREG_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire [4:0] IS_INMODE_INVERTED_BIN;
  wire IS_RSTD_INVERTED_BIN;
  wire IS_RSTINMODE_INVERTED_BIN;
  wire PREADDINSEL_BIN;
  wire [1:0] USE_MULT_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING
  reg notifier;
  `endif

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP_PREADD_DATA_dr.v"
  `endif

  wire ADDSUB_out;
  wire INMODE_2_out;
  wire [17:0] B2B1_out;
  wire [26:0] A2A1_out;
  wire [26:0] AD_DATA_out;
  wire [26:0] D_DATA_out;
  wire [26:0] PREADD_AB_out;

  wire ADDSUB_delay;
  wire INMODE_2_delay;
  wire [17:0] B2B1_delay;
  wire [26:0] A2A1_delay;
  wire [26:0] AD_DATA_delay;
  wire [26:0] D_DATA_delay;
  wire [26:0] PREADD_AB_delay;

  wire CEAD_in;
  wire CED_in;
  wire CEINMODE_in;
  wire CLK_in;
  wire RSTD_in;
  wire RSTINMODE_in;
  wire [17:0] B1_DATA_in;
  wire [17:0] B2_DATA_in;
  wire [26:0] A1_DATA_in;
  wire [26:0] A2_DATA_in;
  wire [26:0] AD_in;
  wire [26:0] DIN_in;
  wire [4:0] INMODE_in;

  wire CEAD_delay;
  wire CED_delay;
  wire CEINMODE_delay;
  wire CLK_delay;
  wire RSTD_delay;
  wire RSTINMODE_delay;
  wire [17:0] B1_DATA_delay;
  wire [17:0] B2_DATA_delay;
  wire [26:0] A1_DATA_delay;
  wire [26:0] A2_DATA_delay;
  wire [26:0] AD_delay;
  wire [26:0] DIN_delay;
  wire [4:0] INMODE_delay;
  
  wire [26:0] a1a2_i_mux;
  wire [17:0] b1b2_i_mux;
  wire [4:0]  INMODE_mux;
  reg  [4:0]  INMODE_reg = 5'b0;
  reg  [26:0] AD_DATA_reg = 27'b0;
  reg  [26:0] D_DATA_reg = 27'b0;
  wire CLK_inmode;
  wire CLK_dreg;
  wire CLK_adreg;

// input output assignments
  assign #(out_delay) A2A1 = A2A1_delay;
  assign #(out_delay) ADDSUB = ADDSUB_delay;
  assign #(out_delay) AD_DATA = AD_DATA_delay;
  assign #(out_delay) B2B1 = B2B1_delay;
  assign #(out_delay) D_DATA = D_DATA_delay;
  assign #(out_delay) INMODE_2 = INMODE_2_delay;
  assign #(out_delay) PREADD_AB = PREADD_AB_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) AD_delay = AD;
  assign #(in_delay) CEAD_delay = CEAD;
  assign #(in_delay) CED_delay = CED;
  assign #(in_delay) CEINMODE_delay = CEINMODE;
  assign #(in_delay) DIN_delay = DIN;
  assign #(in_delay) INMODE_delay = INMODE;
  assign #(in_delay) RSTD_delay = RSTD;
  assign #(in_delay) RSTINMODE_delay = RSTINMODE;
`endif

// inputs with no timing checks

  assign #(in_delay) A1_DATA_delay = A1_DATA;
  assign #(in_delay) A2_DATA_delay = A2_DATA;
  assign #(in_delay) B1_DATA_delay = B1_DATA;
  assign #(in_delay) B2_DATA_delay = B2_DATA;

  assign A2A1_delay = A2A1_out;
  assign ADDSUB_delay = ADDSUB_out;
  assign AD_DATA_delay = AD_DATA_out;
  assign B2B1_delay = B2B1_out;
  assign D_DATA_delay = D_DATA_out;
  assign INMODE_2_delay = INMODE_2_out;
  assign PREADD_AB_delay = PREADD_AB_out;

  assign A1_DATA_in = A1_DATA_delay;
  assign A2_DATA_in = A2_DATA_delay;
  assign AD_in = AD_delay;
  assign B1_DATA_in = B1_DATA_delay;
  assign B2_DATA_in = B2_DATA_delay;
  assign CEAD_in = CEAD_delay;
  assign CED_in = CED_delay;
  assign CEINMODE_in = CEINMODE_delay;
  assign CLK_inmode = (INMODEREG_BIN == INMODEREG_0) ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_dreg   = (DREG_BIN == DREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_adreg  = (ADREG_BIN == ADREG_0)         ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign DIN_in = DIN_delay;
  assign INMODE_in = INMODE_delay ^ IS_INMODE_INVERTED_BIN;
  assign RSTD_in = RSTD_delay ^ IS_RSTD_INVERTED_BIN;
  assign RSTINMODE_in = RSTINMODE_delay ^ IS_RSTINMODE_INVERTED_BIN;

  initial begin
  `ifndef XIL_TIMING
  $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
  `endif
//  $finish;
  #1;
  trig_attr = ~trig_attr;
  end

  assign ADREG_BIN =
    (ADREG_REG == 1) ? ADREG_1 :
    (ADREG_REG == 0) ? ADREG_0 :
     ADREG_1;

  assign AMULTSEL_BIN = 
    (AMULTSEL_REG == "A") ? AMULTSEL_A :
    (AMULTSEL_REG == "AD") ? AMULTSEL_AD :
    AMULTSEL_A;

  assign BMULTSEL_BIN = 
    (BMULTSEL_REG == "B") ? BMULTSEL_B :
    (BMULTSEL_REG == "AD") ? BMULTSEL_AD :
    BMULTSEL_B;

  assign DREG_BIN =
    (DREG_REG == 1) ? DREG_1 :
    (DREG_REG == 0) ? DREG_0 :
     DREG_1;

  assign INMODEREG_BIN =
    (INMODEREG_REG == 1) ? INMODEREG_1 :
    (INMODEREG_REG == 0) ? INMODEREG_0 :
     INMODEREG_1;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_INMODE_INVERTED_BIN = IS_INMODE_INVERTED_REG;

  assign IS_RSTD_INVERTED_BIN = IS_RSTD_INVERTED_REG;

  assign IS_RSTINMODE_INVERTED_BIN = IS_RSTINMODE_INVERTED_REG;

  assign PREADDINSEL_BIN = 
    (PREADDINSEL_REG == "A") ? PREADDINSEL_A :
    (PREADDINSEL_REG == "B") ? PREADDINSEL_B :
    PREADDINSEL_A;

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

//-------- PREADDINSEL check
    if ((PREADDINSEL_REG != "A") &&
        (PREADDINSEL_REG != "B")) begin
        $display("Attribute Syntax Error : The attribute PREADDINSEL on %s instance %m is set to %s.  Legal values for this attribute are A or B.", MODULE_NAME, PREADDINSEL_REG);
        attr_err = 1'b1;
    end

//-------- USE_MULT check
    if ((USE_MULT_REG != "MULTIPLY") && 
        (USE_MULT_REG != "DYNAMIC") && 
        (USE_MULT_REG != "NONE")) begin
        $display("Attribute Syntax Error : The attribute USE_MULT on %s instance %m is set to %s.  Legal values for this attribute are MULTIPLY, DYNAMIC or NONE.", MODULE_NAME, USE_MULT_REG);
        attr_err = 1'b1;
    end

//-------- ADREG check
    if ((ADREG_REG != 0) && (ADREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute ADREG on %s instance %m is set to %d.  Legal values for this attribute are 0 or 1.", MODULE_NAME, ADREG_REG);
      attr_err = 1'b1;
    end

//-------- DREG check
    if ((DREG_REG != 0) && (DREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute DREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, DREG_REG);
      attr_err = 1'b1;
    end

//-------- INMODEREG check
    if ((INMODEREG_REG != 0) && (INMODEREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute INMODEREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, INMODEREG_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

   assign a1a2_i_mux = INMODE_mux[0] ? A1_DATA_in : A2_DATA_in;
   assign b1b2_i_mux = INMODE_mux[4] ? B1_DATA_in : B2_DATA_in;
   assign A2A1_out = ((PREADDINSEL_BIN==PREADDINSEL_A) && INMODE_mux[1]) ? 27'b0 : a1a2_i_mux;
   assign B2B1_out = ((PREADDINSEL_BIN==PREADDINSEL_B) && INMODE_mux[1]) ? 18'b0 : b1b2_i_mux;
   assign ADDSUB_out = INMODE_mux[3];
   assign INMODE_2_out = INMODE_mux[2];

//   assign PREADD_AB_out = PREADDINSEL_BIN ? {9'b0, B2B1_out} : A2A1_out;
   assign PREADD_AB_out = PREADDINSEL_BIN ? {{9{B2B1_out[17]}}, B2B1_out} : A2A1_out;

//*********************************************************
//**********  INMODE signal registering        ************
//*********************************************************
// new 
//   assign CLK_inmode = (INMODEREG_BIN == INMODEREG_1) ? CLK_in : 1'b0;

   always @(posedge CLK_inmode) begin
      if (RSTINMODE_in || glblGSR)
         INMODE_reg <= 5'b0;
      else if (CEINMODE_in)
         INMODE_reg <= INMODE_in;
   end

   assign INMODE_mux = (INMODEREG_BIN == INMODEREG_1) ? INMODE_reg : INMODE_in;

//*********************************************************
//*** Input register D with 1 level deep of register
//*********************************************************
//   assign CLK_dreg = (DREG_BIN == DREG_1) ? CLK_in : 1'b0;

   always @(posedge CLK_dreg) begin
      if      (RSTD_in || glblGSR) D_DATA_reg <= 27'b0;
      else if (CED_in)  D_DATA_reg <= DIN_in;
   end

   assign D_DATA_out = (DREG_BIN == DREG_1) ? D_DATA_reg : DIN_in;

//*********************************************************
//*** Input register AD with 1 level deep of register
//*********************************************************
//   assign CLK_adreg = (ADREG_BIN == ADREG_1) ? CLK_in : 1'b0;

   always @(posedge CLK_adreg) begin
      if      (RSTD_in || glblGSR) AD_DATA_reg <= 27'b0;
      else if (CEAD_in) AD_DATA_reg <= AD_in;
   end

   assign AD_DATA_out = (ADREG_BIN == ADREG_1) ? AD_DATA_reg : AD_in;


  specify
    (A1_DATA *> A2A1) = (0:0:0, 0:0:0);
    (A1_DATA *> PREADD_AB) = (0:0:0, 0:0:0);
    (A2_DATA *> A2A1) = (0:0:0, 0:0:0);
    (A2_DATA *> PREADD_AB) = (0:0:0, 0:0:0);
    (AD *> AD_DATA) = (0:0:0, 0:0:0);
    (B1_DATA *> B2B1) = (0:0:0, 0:0:0);
    (B1_DATA *> PREADD_AB) = (0:0:0, 0:0:0);
    (B2_DATA *> B2B1) = (0:0:0, 0:0:0);
    (B2_DATA *> PREADD_AB) = (0:0:0, 0:0:0);
    (CLK *> A2A1) = (0:0:0, 0:0:0);
    (CLK *> AD_DATA) = (0:0:0, 0:0:0);
    (CLK *> B2B1) = (0:0:0, 0:0:0);
    (CLK *> D_DATA) = (0:0:0, 0:0:0);
    (CLK *> PREADD_AB) = (0:0:0, 0:0:0);
    (CLK => ADDSUB) = (0:0:0, 0:0:0);
    (CLK => INMODE_2) = (0:0:0, 0:0:0);
    (DIN *> D_DATA) = (0:0:0, 0:0:0);
    (INMODE *> A2A1) = (0:0:0, 0:0:0);
    (INMODE *> ADDSUB) = (0:0:0, 0:0:0);
    (INMODE *> B2B1) = (0:0:0, 0:0:0);
    (INMODE *> INMODE_2) = (0:0:0, 0:0:0);
    (INMODE *> PREADD_AB) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim 
    $setuphold (negedge CLK, negedge AD, 0:0:0, 0:0:0, notifier,,, CLK_delay, AD_delay);
    $setuphold (negedge CLK, negedge CEAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEAD_delay);
    $setuphold (negedge CLK, negedge CED, 0:0:0, 0:0:0, notifier,,, CLK_delay, CED_delay);
    $setuphold (negedge CLK, negedge CEINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEINMODE_delay);
    $setuphold (negedge CLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (negedge CLK, negedge INMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, INMODE_delay);
    $setuphold (negedge CLK, negedge RSTD, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTD_delay);
    $setuphold (negedge CLK, negedge RSTINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTINMODE_delay);
    $setuphold (negedge CLK, posedge AD, 0:0:0, 0:0:0, notifier,,, CLK_delay, AD_delay);
    $setuphold (negedge CLK, posedge CEAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEAD_delay);
    $setuphold (negedge CLK, posedge CED, 0:0:0, 0:0:0, notifier,,, CLK_delay, CED_delay);
    $setuphold (negedge CLK, posedge CEINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEINMODE_delay);
    $setuphold (negedge CLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (negedge CLK, posedge INMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, INMODE_delay);
    $setuphold (negedge CLK, posedge RSTD, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTD_delay);
    $setuphold (negedge CLK, posedge RSTINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTINMODE_delay);
    $setuphold (posedge CLK, negedge AD, 0:0:0, 0:0:0, notifier,,, CLK_delay, AD_delay);
    $setuphold (posedge CLK, negedge CEAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEAD_delay);
    $setuphold (posedge CLK, negedge CED, 0:0:0, 0:0:0, notifier,,, CLK_delay, CED_delay);
    $setuphold (posedge CLK, negedge CEINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEINMODE_delay);
    $setuphold (posedge CLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (posedge CLK, negedge INMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, INMODE_delay);
    $setuphold (posedge CLK, negedge RSTD, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTD_delay);
    $setuphold (posedge CLK, negedge RSTINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTINMODE_delay);
    $setuphold (posedge CLK, posedge AD, 0:0:0, 0:0:0, notifier,,, CLK_delay, AD_delay);
    $setuphold (posedge CLK, posedge CEAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEAD_delay);
    $setuphold (posedge CLK, posedge CED, 0:0:0, 0:0:0, notifier,,, CLK_delay, CED_delay);
    $setuphold (posedge CLK, posedge CEINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEINMODE_delay);
    $setuphold (posedge CLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (posedge CLK, posedge INMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, INMODE_delay);
    $setuphold (posedge CLK, posedge RSTD, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTD_delay);
    $setuphold (posedge CLK, posedge RSTINMODE, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTINMODE_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
