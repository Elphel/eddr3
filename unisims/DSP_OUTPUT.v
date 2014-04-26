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
// \   \  /  \    Filename    : DSP_OUTPUT.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  04/03/13 - yaml update
//  04/23/13 - 714772 - remove sensitivity to negedge GSR
//  04/23/13 - 713706 - change P_PDBK connection
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP_OUTPUT
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter AUTORESET_PATDET = "NO_RESET",
  parameter AUTORESET_PRIORITY = "RESET",
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RSTP_INVERTED = 1'b0,
  parameter [47:0] MASK = 48'h3FFFFFFFFFFF,
  parameter [47:0] PATTERN = 48'h000000000000,
  parameter integer PREG = 1,
  parameter SEL_MASK = "MASK",
  parameter SEL_PATTERN = "PATTERN",
  parameter USE_PATTERN_DETECT = "NO_PATDET"
) (
  output CARRYCASCOUT,
  output [3:0] CARRYOUT,
  output CCOUT_FB,
  output MULTSIGNOUT,
  output OVERFLOW,
  output [47:0] P,
  output PATTERN_B_DETECT,
  output PATTERN_DETECT,
  output [47:0] PCOUT,
  output [47:0] P_FDBK,
  output P_FDBK_47,
  output UNDERFLOW,
  output [7:0] XOROUT,

  input ALUMODE10,
  input [47:0] ALU_OUT,
  input CEP,
  input CLK,
  input [3:0] COUT,
  input [47:0] C_DATA,
  input MULTSIGN_ALU,
  input RSTP,
  input [7:0] XOR_MX
);
  
// define constants
  localparam MODULE_NAME = "DSP_OUTPUT";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam AUTORESET_PATDET_NO_RESET        = 0;
  localparam AUTORESET_PATDET_RESET_MATCH     = 1;
  localparam AUTORESET_PATDET_RESET_NOT_MATCH = 2;
  localparam AUTORESET_PRIORITY_CEP   = 1;
  localparam AUTORESET_PRIORITY_RESET = 0;
  localparam PREG_0 = 1;
  localparam PREG_1 = 0;
  localparam SEL_MASK_C              = 1;
  localparam SEL_MASK_MASK           = 0;
  localparam SEL_MASK_ROUNDING_MODE1 = 2;
  localparam SEL_MASK_ROUNDING_MODE2 = 3;
  localparam SEL_PATTERN_C       = 1;
  localparam SEL_PATTERN_PATTERN = 0;
  localparam USE_PATTERN_DETECT_NO_PATDET = 0;
  localparam USE_PATTERN_DETECT_PATDET    = 1;

  `ifndef XIL_DR
  localparam [120:1] AUTORESET_PATDET_REG = AUTORESET_PATDET;
  localparam [40:1] AUTORESET_PRIORITY_REG = AUTORESET_PRIORITY;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [0:0] IS_RSTP_INVERTED_REG = IS_RSTP_INVERTED;
  localparam [47:0] MASK_REG = MASK;
  localparam [47:0] PATTERN_REG = PATTERN;
  localparam [0:0] PREG_REG = PREG;
  localparam [112:1] SEL_MASK_REG = SEL_MASK;
  localparam [56:1] SEL_PATTERN_REG = SEL_PATTERN;
  localparam [72:1] USE_PATTERN_DETECT_REG = USE_PATTERN_DETECT;
  `endif
  wire [1:0] AUTORESET_PATDET_BIN;
  wire AUTORESET_PRIORITY_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire IS_RSTP_INVERTED_BIN;
  wire [47:0] MASK_BIN;
  wire [47:0] PATTERN_BIN;
  wire PREG_BIN;
  wire [1:0] SEL_MASK_BIN;
  wire SEL_PATTERN_BIN;
  wire USE_PATTERN_DETECT_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING
  reg notifier;
  `endif

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP_OUTPUT_dr.v"
  `endif

  wire CARRYCASCOUT_out;
  wire CCOUT_FB_out;
  wire MULTSIGNOUT_out;
  wire OVERFLOW_out;
  wire PATTERN_B_DETECT_out;
  wire PATTERN_DETECT_out;
  wire P_FDBK_47_out;
  wire UNDERFLOW_out;
  wire [3:0] CARRYOUT_out;
  wire [47:0] PCOUT_out;
  wire [47:0] P_FDBK_out;
  wire [47:0] P_out;
  wire [7:0] XOROUT_out;

  wire CARRYCASCOUT_delay;
  wire CCOUT_FB_delay;
  wire MULTSIGNOUT_delay;
  wire OVERFLOW_delay;
  wire PATTERN_B_DETECT_delay;
  wire PATTERN_DETECT_delay;
  wire P_FDBK_47_delay;
  wire UNDERFLOW_delay;
  wire [3:0] CARRYOUT_delay;
  wire [47:0] PCOUT_delay;
  wire [47:0] P_FDBK_delay;
  wire [47:0] P_delay;
  wire [7:0] XOROUT_delay;

  wire ALUMODE10_in;
  wire CEP_in;
  wire CLK_in;
  wire MULTSIGN_ALU_in;
  wire RSTP_in;
  wire [3:0] COUT_in;
  wire [47:0] ALU_OUT_in;
  wire [47:0] C_DATA_in;
  wire [7:0] XOR_MX_in;

  wire ALUMODE10_delay;
  wire CEP_delay;
  wire CLK_delay;
  wire MULTSIGN_ALU_delay;
  wire RSTP_delay;
  wire [3:0] COUT_delay;
  wire [47:0] ALU_OUT_delay;
  wire [47:0] C_DATA_delay;
  wire [7:0] XOR_MX_delay;
  
  wire the_auto_reset_patdet;
  wire auto_reset_pri;
//  reg  [47:0] the_mask = 0;
  wire [47:0] the_mask;
  wire [47:0] the_pattern;
  reg opmode_valid_flag_dou = 1'b1; // TODO

//  reg [3:0] COUT_reg = 4'b0xxx;
  reg [3:0] COUT_reg = 4'b0000;
  reg ALUMODE10_reg = 1'b0;
  wire ALUMODE10_mux;
  reg MULTSIGN_ALU_reg = 1'b0;
  reg [47:0] ALU_OUT_reg = 48'b0;
  reg [7:0] XOR_MX_reg = 8'b0;

  wire pdet_o;
  wire pdetb_o;
  wire pdet_o_mux;
  wire pdetb_o_mux;
  wire overflow_data;
  wire underflow_data;
  reg  pdet_o_reg1 = 1'b0;
  reg  pdet_o_reg2 = 1'b0;
  reg  pdetb_o_reg1 = 1'b0;
  reg  pdetb_o_reg2 = 1'b0;
  wire CLK_preg;

// input output assignments
  assign #(out_delay) CARRYCASCOUT = CARRYCASCOUT_delay;
  assign #(out_delay) CARRYOUT = CARRYOUT_delay;
  assign #(out_delay) CCOUT_FB = CCOUT_FB_delay;
  assign #(out_delay) MULTSIGNOUT = MULTSIGNOUT_delay;
  assign #(out_delay) OVERFLOW = OVERFLOW_delay;
  assign #(out_delay) P = P_delay;
  assign #(out_delay) PATTERN_B_DETECT = PATTERN_B_DETECT_delay;
  assign #(out_delay) PATTERN_DETECT = PATTERN_DETECT_delay;
  assign #(out_delay) PCOUT = PCOUT_delay;
  assign #(out_delay) P_FDBK = P_FDBK_delay;
  assign #(out_delay) P_FDBK_47 = P_FDBK_47_delay;
  assign #(out_delay) UNDERFLOW = UNDERFLOW_delay;
  assign #(out_delay) XOROUT = XOROUT_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) ALUMODE10_delay = ALUMODE10;
  assign #(in_delay) ALU_OUT_delay = ALU_OUT;
  assign #(in_delay) CEP_delay = CEP;
  assign #(in_delay) COUT_delay = COUT;
  assign #(in_delay) C_DATA_delay = C_DATA;
  assign #(in_delay) MULTSIGN_ALU_delay = MULTSIGN_ALU;
  assign #(in_delay) RSTP_delay = RSTP;
  assign #(in_delay) XOR_MX_delay = XOR_MX;
`endif


  assign CCOUT_FB_delay = CCOUT_FB_out;
  assign P_FDBK_delay = P_FDBK_out;
  assign P_FDBK_47_delay = P_FDBK_47_out;
  assign CARRYCASCOUT_delay = CARRYCASCOUT_out;
  assign CARRYOUT_delay = CARRYOUT_out;
  assign MULTSIGNOUT_delay = MULTSIGNOUT_out;
  assign OVERFLOW_delay = OVERFLOW_out;
  assign PATTERN_B_DETECT_delay = PATTERN_B_DETECT_out;
  assign PATTERN_DETECT_delay = PATTERN_DETECT_out;
  assign PCOUT_delay = PCOUT_out;
  assign P_delay = P_out;
  assign UNDERFLOW_delay = UNDERFLOW_out;
  assign XOROUT_delay = XOROUT_out;

  assign ALUMODE10_in = ALUMODE10_delay;
  assign #1 ALU_OUT_in = ALU_OUT_delay; // break 0 delay feedback
  assign COUT_in = COUT_delay;
  assign MULTSIGN_ALU_in = MULTSIGN_ALU_delay;
  assign XOR_MX_in = XOR_MX_delay;
  assign CEP_in = CEP_delay;
  assign CLK_preg   = (PREG_BIN == PREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign C_DATA_in = C_DATA_delay;
  assign RSTP_in = RSTP_delay ^ IS_RSTP_INVERTED_BIN;

  initial begin
  `ifndef XIL_TIMING
  $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
  `endif
//  $finish;
  #1;
  trig_attr = ~trig_attr;
  end

  assign AUTORESET_PATDET_BIN = 
    (AUTORESET_PATDET_REG == "NO_RESET") ? AUTORESET_PATDET_NO_RESET :
    (AUTORESET_PATDET_REG == "RESET_MATCH") ? AUTORESET_PATDET_RESET_MATCH :
    (AUTORESET_PATDET_REG == "RESET_NOT_MATCH") ? AUTORESET_PATDET_RESET_NOT_MATCH :
    AUTORESET_PATDET_NO_RESET;

  assign AUTORESET_PRIORITY_BIN = 
    (AUTORESET_PRIORITY_REG == "RESET") ? AUTORESET_PRIORITY_RESET :
    (AUTORESET_PRIORITY_REG == "CEP") ? AUTORESET_PRIORITY_CEP :
    AUTORESET_PRIORITY_RESET;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_RSTP_INVERTED_BIN = IS_RSTP_INVERTED_REG;

  assign MASK_BIN = MASK_REG;

  assign PATTERN_BIN = PATTERN_REG;

  assign PREG_BIN =
    (PREG_REG == 1) ? PREG_1 :
    (PREG_REG == 0) ? PREG_0 :
     PREG_1;

  assign SEL_MASK_BIN = 
    (SEL_MASK_REG == "MASK") ? SEL_MASK_MASK :
    (SEL_MASK_REG == "C") ? SEL_MASK_C :
    (SEL_MASK_REG == "ROUNDING_MODE1") ? SEL_MASK_ROUNDING_MODE1 :
    (SEL_MASK_REG == "ROUNDING_MODE2") ? SEL_MASK_ROUNDING_MODE2 :
    SEL_MASK_MASK;

  assign SEL_PATTERN_BIN = 
    (SEL_PATTERN_REG == "PATTERN") ? SEL_PATTERN_PATTERN :
    (SEL_PATTERN_REG == "C") ? SEL_PATTERN_C :
    SEL_PATTERN_PATTERN;

  assign USE_PATTERN_DETECT_BIN = 
    (USE_PATTERN_DETECT_REG == "NO_PATDET") ? USE_PATTERN_DETECT_NO_PATDET :
    (USE_PATTERN_DETECT_REG == "PATDET") ? USE_PATTERN_DETECT_PATDET :
    USE_PATTERN_DETECT_NO_PATDET;


  always @ (trig_attr) begin
    #1;
//-------- AUTORESET_PATDET check
    if ((AUTORESET_PATDET_REG != "NO_RESET") &&
        (AUTORESET_PATDET_REG != "RESET_MATCH") &&
        (AUTORESET_PATDET_REG != "RESET_NOT_MATCH")) begin
        $display("Attribute Syntax Error : The attribute AUTORESET_PATDET on %s instance %m is set to %s.  Legal values for this attribute are NO_RESET, RESET_MATCH or RESET_NOT_MATCH.", MODULE_NAME, AUTORESET_PATDET_REG);
        attr_err = 1'b1;
    end

//-------- AUTORESET_PRIORITY check
    if ((AUTORESET_PRIORITY_REG != "RESET") &&
        (AUTORESET_PRIORITY_REG != "CEP")) begin
        $display("Attribute Syntax Error : The attribute AUTORESET_PRIORITY on %s instance %m is set to %s.  Legal values for this attribute are RESET or CEP.", MODULE_NAME, AUTORESET_PRIORITY_REG);
        attr_err = 1'b1;
    end

//-------- SEL_MASK check
    if ((SEL_MASK_REG != "MASK") &&
        (SEL_MASK_REG != "C") &&
        (SEL_MASK_REG != "ROUNDING_MODE1") &&
        (SEL_MASK_REG != "ROUNDING_MODE2")) begin
        $display("Attribute Syntax Error : The attribute SEL_MASK on %s instance %m is set to %s.  Legal values for this attribute are MASK, C, ROUNDING_MODE1 or ROUNDING_MODE2.", MODULE_NAME, SEL_MASK_REG);
        attr_err = 1'b1;
    end

//-------- SEL_PATTERN check
    if ((SEL_PATTERN_REG != "PATTERN") &&
        (SEL_PATTERN_REG != "C")) begin
        $display("Attribute Syntax Error : The attribute SEL_PATTERN on %s instance %m is set to %s.  Legal values for this attribute are PATTERN or C.", MODULE_NAME, SEL_PATTERN_REG);
        attr_err = 1'b1;
    end

//-------- USE_PATTERN_DETECT check
    if ((USE_PATTERN_DETECT_REG != "NO_PATDET") &&
        (USE_PATTERN_DETECT_REG != "PATDET")) begin
        $display("Attribute Syntax Error : The attribute USE_PATTERN_DETECT on %s instance %m is set to %s.  Legal values for this attribute are NO_PATDET or PATDET.", MODULE_NAME, USE_PATTERN_DETECT_REG);
        attr_err = 1'b1;
    end

//-------- PREG check
    if ((PREG_REG != 0) && (PREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute PREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, PREG_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

//--####################################################################
//--#####                    Pattern Detector                      #####
//--####################################################################

    // select pattern
    assign the_pattern = (SEL_PATTERN_BIN == SEL_PATTERN_PATTERN) ? PATTERN_BIN : C_DATA_in;

    // select mask
    assign the_mask = (SEL_MASK_BIN == SEL_MASK_C)              ?    C_DATA_in       :
                      (SEL_MASK_BIN == SEL_MASK_ROUNDING_MODE1) ? {~(C_DATA_in[46:0]),1'b0} :
                      (SEL_MASK_BIN == SEL_MASK_ROUNDING_MODE2) ? {~(C_DATA_in[45:0]),2'b0} :
                      MASK_BIN; // default or (SEL_MASK_BIN == SEL_MASK_MASK)
//    always @(C_DATA_in or SEL_MASK_BIN or MASK_BIN) begin
//        case(SEL_MASK_BIN)
//              SEL_MASK_MASK           : the_mask <=  MASK_BIN;
//              SEL_MASK_C              : the_mask <=  C_DATA_in;
//              SEL_MASK_ROUNDING_MODE1 : the_mask <= ~(C_DATA_in << 1);
//              SEL_MASK_ROUNDING_MODE2 : the_mask <= ~(C_DATA_in << 2);
//              default                 : the_mask <=  MASK_BIN;
//        endcase
//    end

    //--  now do the pattern detection

   assign pdet_o  = &(~(the_pattern ^ ALU_OUT_in) | the_mask);
   assign pdetb_o = &( (the_pattern ^ ALU_OUT_in) | the_mask);

   assign PATTERN_DETECT_out   = opmode_valid_flag_dou ? pdet_o_mux  : 1'bx;
   assign PATTERN_B_DETECT_out = opmode_valid_flag_dou ? pdetb_o_mux : 1'bx;

//   assign CLK_preg =  (PREG_BIN == PREG_1) ? CLK_in : 1'b0;

//*** Output register PATTERN DETECT and UNDERFLOW / OVERFLOW 

   always @(posedge CLK_preg) begin
     if(RSTP_in || glblGSR || the_auto_reset_patdet)
       begin
         pdet_o_reg1  <= 1'b0;
         pdet_o_reg2  <= 1'b0;
         pdetb_o_reg1 <= 1'b0;
         pdetb_o_reg2 <= 1'b0;
       end
     else if(CEP_in)
       begin
       //-- the previous values are used in Underflow/Overflow
         pdet_o_reg2  <= pdet_o_reg1;
         pdet_o_reg1  <= pdet_o;
         pdetb_o_reg2 <= pdetb_o_reg1;
         pdetb_o_reg1 <= pdetb_o;
       end
     end

    assign pdet_o_mux     = (PREG_BIN == PREG_1) ? pdet_o_reg1  : pdet_o;
    assign pdetb_o_mux    = (PREG_BIN == PREG_1) ? pdetb_o_reg1 : pdetb_o;
    assign overflow_data  = (PREG_BIN == PREG_1) ? pdet_o_reg2  : pdet_o;
    assign underflow_data = (PREG_BIN == PREG_1) ? pdetb_o_reg2 : pdetb_o;

//--####################################################################
//--#####                     AUTORESET_PATDET                     #####
//--####################################################################
    assign auto_reset_pri = (AUTORESET_PRIORITY_BIN == AUTORESET_PRIORITY_RESET) || CEP_in;

    assign the_auto_reset_patdet =
         (AUTORESET_PATDET_BIN == AUTORESET_PATDET_RESET_MATCH) ?
                     auto_reset_pri && pdet_o_mux :
         (AUTORESET_PATDET_BIN == AUTORESET_PATDET_RESET_NOT_MATCH) ?
                     auto_reset_pri && overflow_data && ~pdet_o_mux : 1'b0; // NO_RESET

//--####################################################################
//--#### CARRYOUT, CARRYCASCOUT. MULTSIGNOUT, PCOUT and XOROUT reg ##### 
//--####################################################################
//*** register with 1 level of register
   always @(posedge CLK_preg) begin
        if(RSTP_in || glblGSR || the_auto_reset_patdet) begin
//           COUT_reg         <= 4'b0xxx;
           COUT_reg         <= 4'b0000;
           ALUMODE10_reg    <= 1'b0;
           MULTSIGN_ALU_reg <= 1'b0;
           ALU_OUT_reg      <= 48'b0;
           XOR_MX_reg       <= 8'b0;
           end
        else if (CEP_in) begin
           COUT_reg         <= COUT_in;
           ALUMODE10_reg    <= ALUMODE10_in;
           MULTSIGN_ALU_reg <= MULTSIGN_ALU_in;
           ALU_OUT_reg      <= ALU_OUT_in;
           XOR_MX_reg       <= XOR_MX_in;
           end
    end

    assign CARRYOUT_out     = (PREG_BIN == PREG_1) ? COUT_reg         : COUT_in;
    assign MULTSIGNOUT_out  = (PREG_BIN == PREG_1) ? MULTSIGN_ALU_reg : MULTSIGN_ALU_in;
    assign P_out            = (PREG_BIN == PREG_1) ? ALU_OUT_reg      : ALU_OUT_in;
    assign ALUMODE10_mux    = (PREG_BIN == PREG_1) ? ALUMODE10_reg    : ALUMODE10_in;
    assign XOROUT_out       = (PREG_BIN == PREG_1) ? XOR_MX_reg      : XOR_MX_in;
    assign CCOUT_FB_out     = ALUMODE10_reg ^ COUT_reg[3];
    assign CARRYCASCOUT_out = ALUMODE10_mux ^ CARRYOUT_out[3];
//    assign P_FDBK_out       = (PREG_BIN == PREG_1) ? ALU_OUT_reg      : ALU_OUT_in;
//    assign P_FDBK_47_out    = (PREG_BIN == PREG_1) ? ALU_OUT_reg[47]  : ALU_OUT_in[47];
    assign P_FDBK_out       = ALU_OUT_reg;
    assign P_FDBK_47_out    = ALU_OUT_reg[47];
    assign PCOUT_out        = (PREG_BIN == PREG_1) ? ALU_OUT_reg      : ALU_OUT_in;

//--####################################################################
//--#####                    Underflow / Overflow                  #####
//--####################################################################
    assign OVERFLOW_out  = ((USE_PATTERN_DETECT_BIN == USE_PATTERN_DETECT_PATDET) ||
                            (PREG_BIN == PREG_1)) ?
                            ~pdet_o_mux && ~pdetb_o_mux && overflow_data : 1'bx;
    assign UNDERFLOW_out = ((USE_PATTERN_DETECT_BIN == USE_PATTERN_DETECT_PATDET) ||
                            (PREG_BIN == PREG_1)) ?
                            ~pdet_o_mux && ~pdetb_o_mux && underflow_data : 1'bx;

  specify
    (ALUMODE10 => CARRYCASCOUT) = (0:0:0, 0:0:0);
    (ALU_OUT *> P) = (0:0:0, 0:0:0);
    (ALU_OUT *> PATTERN_B_DETECT) = (0:0:0, 0:0:0);
    (ALU_OUT *> PATTERN_DETECT) = (0:0:0, 0:0:0);
    (ALU_OUT *> PCOUT) = (0:0:0, 0:0:0);
    (CLK *> CARRYOUT) = (0:0:0, 0:0:0);
    (CLK *> P) = (0:0:0, 0:0:0);
    (CLK *> PCOUT) = (0:0:0, 0:0:0);
    (CLK *> P_FDBK) = (0:0:0, 0:0:0);
    (CLK *> XOROUT) = (0:0:0, 0:0:0);
    (CLK => CARRYCASCOUT) = (0:0:0, 0:0:0);
    (CLK => CCOUT_FB) = (0:0:0, 0:0:0);
    (CLK => MULTSIGNOUT) = (0:0:0, 0:0:0);
    (CLK => OVERFLOW) = (0:0:0, 0:0:0);
    (CLK => PATTERN_B_DETECT) = (0:0:0, 0:0:0);
    (CLK => PATTERN_DETECT) = (0:0:0, 0:0:0);
    (CLK => P_FDBK_47) = (0:0:0, 0:0:0);
    (CLK => UNDERFLOW) = (0:0:0, 0:0:0);
    (COUT *> CARRYCASCOUT) = (0:0:0, 0:0:0);
    (COUT *> CARRYOUT) = (0:0:0, 0:0:0);
    (C_DATA *> PATTERN_B_DETECT) = (0:0:0, 0:0:0);
    (C_DATA *> PATTERN_DETECT) = (0:0:0, 0:0:0);
    (MULTSIGN_ALU => MULTSIGNOUT) = (0:0:0, 0:0:0);
    (XOR_MX *> XOROUT) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim 
    $period (negedge CLK, 0:0:0, notifier);
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (negedge CLK, negedge ALUMODE10, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALUMODE10_delay);
    $setuphold (negedge CLK, negedge ALU_OUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALU_OUT_delay);
    $setuphold (negedge CLK, negedge CEP, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEP_delay);
    $setuphold (negedge CLK, negedge COUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, COUT_delay);
    $setuphold (negedge CLK, negedge C_DATA, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_DATA_delay);
    $setuphold (negedge CLK, negedge MULTSIGN_ALU, 0:0:0, 0:0:0, notifier,,, CLK_delay, MULTSIGN_ALU_delay);
    $setuphold (negedge CLK, negedge RSTP, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTP_delay);
    $setuphold (negedge CLK, negedge XOR_MX, 0:0:0, 0:0:0, notifier,,, CLK_delay, XOR_MX_delay);
    $setuphold (negedge CLK, posedge ALUMODE10, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALUMODE10_delay);
    $setuphold (negedge CLK, posedge ALU_OUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALU_OUT_delay);
    $setuphold (negedge CLK, posedge CEP, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEP_delay);
    $setuphold (negedge CLK, posedge COUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, COUT_delay);
    $setuphold (negedge CLK, posedge C_DATA, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_DATA_delay);
    $setuphold (negedge CLK, posedge MULTSIGN_ALU, 0:0:0, 0:0:0, notifier,,, CLK_delay, MULTSIGN_ALU_delay);
    $setuphold (negedge CLK, posedge RSTP, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTP_delay);
    $setuphold (negedge CLK, posedge XOR_MX, 0:0:0, 0:0:0, notifier,,, CLK_delay, XOR_MX_delay);
    $setuphold (posedge CLK, negedge ALUMODE10, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALUMODE10_delay);
    $setuphold (posedge CLK, negedge ALU_OUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALU_OUT_delay);
    $setuphold (posedge CLK, negedge CEP, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEP_delay);
    $setuphold (posedge CLK, negedge COUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, COUT_delay);
    $setuphold (posedge CLK, negedge C_DATA, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_DATA_delay);
    $setuphold (posedge CLK, negedge MULTSIGN_ALU, 0:0:0, 0:0:0, notifier,,, CLK_delay, MULTSIGN_ALU_delay);
    $setuphold (posedge CLK, negedge RSTP, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTP_delay);
    $setuphold (posedge CLK, negedge XOR_MX, 0:0:0, 0:0:0, notifier,,, CLK_delay, XOR_MX_delay);
    $setuphold (posedge CLK, posedge ALUMODE10, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALUMODE10_delay);
    $setuphold (posedge CLK, posedge ALU_OUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, ALU_OUT_delay);
    $setuphold (posedge CLK, posedge CEP, 0:0:0, 0:0:0, notifier,,, CLK_delay, CEP_delay);
    $setuphold (posedge CLK, posedge COUT, 0:0:0, 0:0:0, notifier,,, CLK_delay, COUT_delay);
    $setuphold (posedge CLK, posedge C_DATA, 0:0:0, 0:0:0, notifier,,, CLK_delay, C_DATA_delay);
    $setuphold (posedge CLK, posedge MULTSIGN_ALU, 0:0:0, 0:0:0, notifier,,, CLK_delay, MULTSIGN_ALU_delay);
    $setuphold (posedge CLK, posedge RSTP, 0:0:0, 0:0:0, notifier,,, CLK_delay, RSTP_delay);
    $setuphold (posedge CLK, posedge XOR_MX, 0:0:0, 0:0:0, notifier,,, CLK_delay, XOR_MX_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
