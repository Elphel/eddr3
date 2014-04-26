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
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                       27X18 Signed Multiplier Followed by Three-Input
// /___/   /\                   Adder plus ALU with Pipeline Registers
// \   \  /  \    Filename    : DSP48E2.v 
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  07/15/12 - Migrate from E1.
//  12/10/12 - Add dynamic registers
//  01/10/13 - 694456 - DIN_in/D_in connectivity issue
//  01/11/13 - DIN, D_DATA data width change (26/24) sync4 yml
//  02/13/13 - PCIN_47A change from internal feedback to PCIN(47) pin
//  03/06/13 - 701316 - A_B_reg no clk when REG=0
//  04/03/13 - yaml update
//  04/08/13 - 710304 - AREG, BREG, ACASCREG and BCASCREG dynamic registers mis sized.
//  04/22/13 - 714213 - ACOUT, BCOUT wrong logic
//  04/22/13 - 713695 - Zero mult result on USE_SIMD
//  04/22/13 - 713617 - CARRYCASCOUT behaviour
//  04/23/13 - 714772 - remove sensitivity to negedge GSR
//  04/23/13 - 713706 - change P_PDBK connection
//  05/07/13 - 716896 - AREG, BREG, ACASCREG and BCASCREG localparams mis sized.
//  05/07/13 - 716896 - ALUMODE/OPMODE_INV_REG mis sized
//  05/07/13 - 716896 - INMODE_INV_REG mis sized
//  05/07/13 - x_mac_cascd missing for sensitivity list.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module DSP48E2
#(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer ACASCREG = 1,
  parameter integer ADREG = 1,
  parameter integer ALUMODEREG = 1,
  parameter AMULTSEL = "A",
  parameter integer AREG = 1,
  parameter AUTORESET_PATDET = "NO_RESET",
  parameter AUTORESET_PRIORITY = "RESET",
  parameter A_INPUT = "DIRECT",
  parameter integer BCASCREG = 1,
  parameter BMULTSEL = "B",
  parameter integer BREG = 1,
  parameter B_INPUT = "DIRECT",
  parameter integer CARRYINREG = 1,
  parameter integer CARRYINSELREG = 1,
  parameter integer CREG = 1,
  parameter integer DREG = 1,
  parameter integer INMODEREG = 1,
  parameter [3:0] IS_ALUMODE_INVERTED = 4'b0000,
  parameter [0:0] IS_CARRYIN_INVERTED = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [4:0] IS_INMODE_INVERTED = 5'b00000,
  parameter [8:0] IS_OPMODE_INVERTED = 9'b000000000,
  parameter [0:0] IS_RSTALLCARRYIN_INVERTED = 1'b0,
  parameter [0:0] IS_RSTALUMODE_INVERTED = 1'b0,
  parameter [0:0] IS_RSTA_INVERTED = 1'b0,
  parameter [0:0] IS_RSTB_INVERTED = 1'b0,
  parameter [0:0] IS_RSTCTRL_INVERTED = 1'b0,
  parameter [0:0] IS_RSTC_INVERTED = 1'b0,
  parameter [0:0] IS_RSTD_INVERTED = 1'b0,
  parameter [0:0] IS_RSTINMODE_INVERTED = 1'b0,
  parameter [0:0] IS_RSTM_INVERTED = 1'b0,
  parameter [0:0] IS_RSTP_INVERTED = 1'b0,
  parameter [47:0] MASK = 48'h3FFFFFFFFFFF,
  parameter integer MREG = 1,
  parameter integer OPMODEREG = 1,
  parameter [47:0] PATTERN = 48'h000000000000,
  parameter PREADDINSEL = "A",
  parameter integer PREG = 1,
  parameter [47:0] RND = 48'h000000000000,
  parameter SEL_MASK = "MASK",
  parameter SEL_PATTERN = "PATTERN",
  parameter USE_MULT = "MULTIPLY",
  parameter USE_PATTERN_DETECT = "NO_PATDET",
  parameter USE_SIMD = "ONE48",
  parameter USE_WIDEXOR = "FALSE",
  parameter XORSIMD = "XOR24_48_96"
) (
  output [29:0] ACOUT,
  output [17:0] BCOUT,
  output CARRYCASCOUT,
  output [3:0] CARRYOUT,
  output MULTSIGNOUT,
  output OVERFLOW,
  output [47:0] P,
  output PATTERNBDETECT,
  output PATTERNDETECT,
  output [47:0] PCOUT,
  output UNDERFLOW,
  output [7:0] XOROUT,

  input [29:0] A,
  input [29:0] ACIN,
  input [3:0] ALUMODE,
  input [17:0] B,
  input [17:0] BCIN,
  input [47:0] C,
  input CARRYCASCIN,
  input CARRYIN,
  input [2:0] CARRYINSEL,
  input CEA1,
  input CEA2,
  input CEAD,
  input CEALUMODE,
  input CEB1,
  input CEB2,
  input CEC,
  input CECARRYIN,
  input CECTRL,
  input CED,
  input CEINMODE,
  input CEM,
  input CEP,
  input CLK,
  input [26:0] D,
  input [4:0] INMODE,
  input MULTSIGNIN,
  input [8:0] OPMODE,
  input [47:0] PCIN,
  input RSTA,
  input RSTALLCARRYIN,
  input RSTALUMODE,
  input RSTB,
  input RSTC,
  input RSTCTRL,
  input RSTD,
  input RSTINMODE,
  input RSTM,
  input RSTP
);
  
// define constants
  localparam MODULE_NAME = "DSP48E2";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
// logic depends on ACASCREG, AREG encoding the same
  localparam ACASCREG_0 = 1;
  localparam ACASCREG_1 = 0;
  localparam ACASCREG_2 = 2;
  localparam ADREG_0 = 1;
  localparam ADREG_1 = 0;
  localparam ALUMODEREG_0 = 1;
  localparam ALUMODEREG_1 = 0;
  localparam AMULTSEL_A = 0;
  localparam AMULTSEL_AD = 1;
  localparam AREG_0 = 1;
  localparam AREG_1 = 0;
  localparam AREG_2 = 2;
  localparam AUTORESET_PATDET_NO_RESET        = 0;
  localparam AUTORESET_PATDET_RESET_MATCH     = 1;
  localparam AUTORESET_PATDET_RESET_NOT_MATCH = 2;
  localparam AUTORESET_PRIORITY_CEP   = 1;
  localparam AUTORESET_PRIORITY_RESET = 0;
  localparam A_INPUT_CASCADE = 1;
  localparam A_INPUT_DIRECT = 0;
  localparam BCASCREG_0 = 1;
  localparam BCASCREG_1 = 0;
  localparam BCASCREG_2 = 2;
  localparam BMULTSEL_AD = 1;
  localparam BMULTSEL_B = 0;
  localparam BREG_0 = 1;
  localparam BREG_1 = 0;
  localparam BREG_2 = 2;
  localparam B_INPUT_CASCADE = 1;
  localparam B_INPUT_DIRECT  = 0;
  localparam CARRYINREG_0 = 1;
  localparam CARRYINREG_1 = 0;
  localparam CARRYINSELREG_0 = 1;
  localparam CARRYINSELREG_1 = 0;
  localparam CREG_0 = 1;
  localparam CREG_1 = 0;
  localparam DREG_0 = 1;
  localparam DREG_1 = 0;
  localparam INMODEREG_0 = 1;
  localparam INMODEREG_1 = 0;
  localparam MREG_0 = 1;
  localparam MREG_1 = 0;
  localparam OPMODEREG_0 = 1;
  localparam OPMODEREG_1 = 0;
  localparam PREADDINSEL_A = 0;
  localparam PREADDINSEL_B = 1;
  localparam PREG_0 = 1;
  localparam PREG_1 = 0;
  localparam SEL_MASK_C              = 1;
  localparam SEL_MASK_MASK           = 0;
  localparam SEL_MASK_ROUNDING_MODE1 = 2;
  localparam SEL_MASK_ROUNDING_MODE2 = 3;
  localparam SEL_PATTERN_C       = 1;
  localparam SEL_PATTERN_PATTERN = 0;
  localparam USE_MULT_DYNAMIC  = 1;
  localparam USE_MULT_MULTIPLY = 0;
  localparam USE_MULT_NONE     = 2;
  localparam USE_PATTERN_DETECT_NO_PATDET = 0;
  localparam USE_PATTERN_DETECT_PATDET    = 1;
  localparam USE_SIMD_FOUR12 = 7;
  localparam USE_SIMD_ONE48  = 0;
  localparam USE_SIMD_TWO24  = 2;
// USE_SIMD uses bits from actual encodings
  localparam USE_WIDEXOR_FALSE = 0;
  localparam USE_WIDEXOR_TRUE  = 1;
  localparam XORSIMD_XOR12       = 1;
  localparam XORSIMD_XOR24_48_96 = 0;

  `ifndef XIL_DR
  localparam [1:0] ACASCREG_REG = ACASCREG;
  localparam [0:0] ADREG_REG = ADREG;
  localparam [0:0] ALUMODEREG_REG = ALUMODEREG;
  localparam [16:1] AMULTSEL_REG = AMULTSEL;
  localparam [1:0] AREG_REG = AREG;
  localparam [120:1] AUTORESET_PATDET_REG = AUTORESET_PATDET;
  localparam [40:1] AUTORESET_PRIORITY_REG = AUTORESET_PRIORITY;
  localparam [56:1] A_INPUT_REG = A_INPUT;
  localparam [1:0] BCASCREG_REG = BCASCREG;
  localparam [16:1] BMULTSEL_REG = BMULTSEL;
  localparam [1:0] BREG_REG = BREG;
  localparam [56:1] B_INPUT_REG = B_INPUT;
  localparam [0:0] CARRYINREG_REG = CARRYINREG;
  localparam [0:0] CARRYINSELREG_REG = CARRYINSELREG;
  localparam [0:0] CREG_REG = CREG;
  localparam [0:0] DREG_REG = DREG;
  localparam [0:0] INMODEREG_REG = INMODEREG;
  localparam [3:0] IS_ALUMODE_INVERTED_REG = IS_ALUMODE_INVERTED;
  localparam [0:0] IS_CARRYIN_INVERTED_REG = IS_CARRYIN_INVERTED;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [4:0] IS_INMODE_INVERTED_REG = IS_INMODE_INVERTED;
  localparam [8:0] IS_OPMODE_INVERTED_REG = IS_OPMODE_INVERTED;
  localparam [0:0] IS_RSTALLCARRYIN_INVERTED_REG = IS_RSTALLCARRYIN_INVERTED;
  localparam [0:0] IS_RSTALUMODE_INVERTED_REG = IS_RSTALUMODE_INVERTED;
  localparam [0:0] IS_RSTA_INVERTED_REG = IS_RSTA_INVERTED;
  localparam [0:0] IS_RSTB_INVERTED_REG = IS_RSTB_INVERTED;
  localparam [0:0] IS_RSTCTRL_INVERTED_REG = IS_RSTCTRL_INVERTED;
  localparam [0:0] IS_RSTC_INVERTED_REG = IS_RSTC_INVERTED;
  localparam [0:0] IS_RSTD_INVERTED_REG = IS_RSTD_INVERTED;
  localparam [0:0] IS_RSTINMODE_INVERTED_REG = IS_RSTINMODE_INVERTED;
  localparam [0:0] IS_RSTM_INVERTED_REG = IS_RSTM_INVERTED;
  localparam [0:0] IS_RSTP_INVERTED_REG = IS_RSTP_INVERTED;
  localparam [47:0] MASK_REG = MASK;
  localparam [0:0] MREG_REG = MREG;
  localparam [0:0] OPMODEREG_REG = OPMODEREG;
  localparam [47:0] PATTERN_REG = PATTERN;
  localparam [8:1] PREADDINSEL_REG = PREADDINSEL;
  localparam [0:0] PREG_REG = PREG;
  localparam [47:0] RND_REG = RND;
  localparam [112:1] SEL_MASK_REG = SEL_MASK;
  localparam [56:1] SEL_PATTERN_REG = SEL_PATTERN;
  localparam [64:1] USE_MULT_REG = USE_MULT;
  localparam [72:1] USE_PATTERN_DETECT_REG = USE_PATTERN_DETECT;
  localparam [48:1] USE_SIMD_REG = USE_SIMD;
  localparam [40:1] USE_WIDEXOR_REG = USE_WIDEXOR;
  localparam [88:1] XORSIMD_REG = XORSIMD;
  `endif
  wire [1:0] ACASCREG_BIN;
  wire ADREG_BIN;
  wire ALUMODEREG_BIN;
  wire AMULTSEL_BIN;
  wire [1:0] AREG_BIN;
  wire [1:0] AUTORESET_PATDET_BIN;
  wire AUTORESET_PRIORITY_BIN;
  wire A_INPUT_BIN;
  wire [1:0] BCASCREG_BIN;
  wire BMULTSEL_BIN;
  wire [1:0] BREG_BIN;
  wire B_INPUT_BIN;
  wire CARRYINREG_BIN;
  wire CARRYINSELREG_BIN;
  wire CREG_BIN;
  wire DREG_BIN;
  wire INMODEREG_BIN;
  wire [3:0] IS_ALUMODE_INVERTED_BIN;
  wire IS_CARRYIN_INVERTED_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire [4:0] IS_INMODE_INVERTED_BIN;
  wire [8:0] IS_OPMODE_INVERTED_BIN;
  wire IS_RSTALLCARRYIN_INVERTED_BIN;
  wire IS_RSTALUMODE_INVERTED_BIN;
  wire IS_RSTA_INVERTED_BIN;
  wire IS_RSTB_INVERTED_BIN;
  wire IS_RSTCTRL_INVERTED_BIN;
  wire IS_RSTC_INVERTED_BIN;
  wire IS_RSTD_INVERTED_BIN;
  wire IS_RSTINMODE_INVERTED_BIN;
  wire IS_RSTM_INVERTED_BIN;
  wire IS_RSTP_INVERTED_BIN;
  wire [47:0] MASK_BIN;
  wire MREG_BIN;
  wire OPMODEREG_BIN;
  wire [47:0] PATTERN_BIN;
  wire PREADDINSEL_BIN;
  wire PREG_BIN;
  wire [47:0] RND_BIN;
  wire [1:0] SEL_MASK_BIN;
  wire SEL_PATTERN_BIN;
  wire [1:0] USE_MULT_BIN;
  wire USE_PATTERN_DETECT_BIN;
  wire [2:0] USE_SIMD_BIN;
  wire USE_WIDEXOR_BIN;
  wire XORSIMD_BIN;

  tri0 glblGSR = glbl.GSR;

  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "DSP48E2_dr.v"
  `endif

  wire ADDSUB_out;
  wire ALUMODE10_out;
  wire AMULT26_out;
  wire BMULT17_out;
  wire CARRYCASCOUT_out;
  wire CCOUT_FB_out;
  wire INMODE_2_out;
  wire MULTSIGN_ALU_out;
  wire MULTSIGNOUT_out;
  wire OVERFLOW_out;
  wire PATTERN_B_DETECT_out;
  wire PATTERN_DETECT_out;
  wire P_FDBK_47_out;
  wire UNDERFLOW_out;
  wire [17:0] B2B1_out;
  wire [17:0] B1_DATA_out;
  wire [17:0] B2_DATA_out;
  wire [17:0] BCOUT_out;
  wire [17:0] B_ALU_out;
  wire [26:0] A2A1_out;
  wire [26:0] AD_DATA_out;
  wire [26:0] D_DATA_out;
  wire [26:0] AD_out;
  wire [26:0] A1_DATA_out;
  wire [26:0] A2_DATA_out;
  wire [26:0] PREADD_AB_out;
  wire [29:0] ACOUT_out;
  wire [29:0] A_ALU_out;
  wire [3:0] COUT_out;
  wire [3:0] CARRYOUT_out;
  wire [44:0] U_out;
  wire [44:0] V_out;
  wire [44:0] U_DATA_out;
  wire [44:0] V_DATA_out;
  wire [47:0] ALU_OUT_out;
  wire [7:0] XOR_MX_out;
  wire [47:0] C_DATA_out;
  wire [47:0] PCOUT_out;
  wire [47:0] P_FDBK_out;
  wire [47:0] P_out;
  wire [7:0] XOROUT_out;

  wire ALUMODE10_delay;
  wire ADDSUB_delay;
  wire AMULT26_delay;
  wire BMULT17_delay;
  wire CARRYCASCOUT_delay;
  wire CCOUT_FB_delay;
  wire INMODE_2_delay;
  wire MULTSIGN_ALU_delay;
  wire MULTSIGNOUT_delay;
  wire OVERFLOW_delay;
  wire PATTERN_B_DETECT_delay;
  wire PATTERN_DETECT_delay;
  wire P_FDBK_47_delay;
  wire UNDERFLOW_delay;
  wire [17:0] B2B1_delay;
  wire [17:0] B1_DATA_delay;
  wire [17:0] B2_DATA_delay;
  wire [17:0] BCOUT_delay;
  wire [17:0] B_ALU_delay;
  wire [26:0] A2A1_delay;
  wire [26:0] AD_DATA_delay;
  wire [26:0] D_DATA_delay;
  wire [26:0] AD_delay;
  wire [26:0] A1_DATA_delay;
  wire [26:0] A2_DATA_delay;
  wire [26:0] PREADD_AB_delay;
  wire [29:0] ACOUT_delay;
  wire [29:0] A_ALU_delay;
  wire [3:0] COUT_delay;
  wire [3:0] CARRYOUT_delay;
  wire [44:0] U_delay;
  wire [44:0] V_delay;
  wire [44:0] U_DATA_delay;
  wire [44:0] V_DATA_delay;
  wire [47:0] ALU_OUT_delay;
  wire [7:0] XOR_MX_delay;
  wire [47:0] C_DATA_delay;
  wire [47:0] PCOUT_delay;
  wire [47:0] P_FDBK_delay;
  wire [47:0] P_delay;
  wire [7:0] XOROUT_delay;

  wire AMULT26_in;
  wire BMULT17_in;
  wire ADDSUB_in;
  wire ALUMODE10_in;
  wire CARRYCASCIN_in;
  wire CARRYIN_in;
  wire CCOUT_in;
  wire CEA1_in;
  wire CEA2_in;
  wire CEAD_in;
  wire CEALUMODE_in;
  wire CEB1_in;
  wire CEB2_in;
  wire CECARRYIN_in;
  wire CECTRL_in;
  wire CEC_in;
  wire CED_in;
  wire CEINMODE_in;
  wire CEM_in;
  wire CEP_in;
  wire CLK_in;
  wire INMODE_2_in;
  wire MULTSIGNIN_in;
  wire MULTSIGN_ALU_in;
  wire P_FDBK_47_in;
  wire RSTALLCARRYIN_in;
  wire RSTALUMODE_in;
  wire RSTA_in;
  wire RSTB_in;
  wire RSTCTRL_in;
  wire RSTC_in;
  wire RSTD_in;
  wire RSTINMODE_in;
  wire RSTM_in;
  wire RSTP_in;
  wire [17:0] B_ALU_in;
  wire [29:0] A_ALU_in;
  wire [17:0] B1_DATA_in;
  wire [17:0] B2B1_in;
  wire [17:0] B2_DATA_in;
  wire [17:0] BCIN_in;
  wire [17:0] B_in;
  wire [26:0] A1_DATA_in;
  wire [26:0] A2A1_in;
  wire [26:0] AD_DATA_in;
  wire [26:0] A2_DATA_in;
  wire [26:0] AD_in;
  wire [26:0] DIN_in;
  wire [26:0] D_DATA_in;
  wire [26:0] D_in;
  wire [26:0] PREADD_AB_in;
  wire [29:0] ACIN_in;
  wire [29:0] A_in;
  wire [2:0] CARRYINSEL_in;
  wire [3:0] ALUMODE_in;
  wire [3:0] COUT_in;
  wire [44:0] U_in;
  wire [44:0] V_in;
  wire [44:0] U_DATA_in;
  wire [44:0] V_DATA_in;
  wire [47:0] ALU_OUT_in;
  wire [47:0] C_DATA_in;
  wire [47:0] C_in;
  wire [47:0] PCIN_in;
  wire [47:0] P_FDBK_in;
  wire [4:0] INMODE_in;
  wire [7:0] XOR_MX_in;
  wire [8:0] OPMODE_in;

  wire CARRYCASCIN_delay;
  wire CARRYIN_delay;
  wire CEA1_delay;
  wire CEA2_delay;
  wire CEAD_delay;
  wire CEALUMODE_delay;
  wire CEB1_delay;
  wire CEB2_delay;
  wire CECARRYIN_delay;
  wire CECTRL_delay;
  wire CEC_delay;
  wire CED_delay;
  wire CEINMODE_delay;
  wire CEM_delay;
  wire CEP_delay;
  wire CLK_delay;
  wire MULTSIGNIN_delay;
  wire RSTALLCARRYIN_delay;
  wire RSTALUMODE_delay;
  wire RSTA_delay;
  wire RSTB_delay;
  wire RSTCTRL_delay;
  wire RSTC_delay;
  wire RSTD_delay;
  wire RSTINMODE_delay;
  wire RSTM_delay;
  wire RSTP_delay;
  wire [17:0] BCIN_delay;
  wire [17:0] B_delay;
  wire [26:0] D_delay;
  wire [29:0] ACIN_delay;
  wire [29:0] A_delay;
  wire [2:0] CARRYINSEL_delay;
  wire [3:0] ALUMODE_delay;
  wire [47:0] C_delay;
  wire [47:0] PCIN_delay;
  wire [4:0] INMODE_delay;
  wire [8:0] OPMODE_delay;
  
// DSP_ALU wires
  localparam MAX_ALU_FULL   = 48;
  localparam MAX_CARRYOUT   = 4;

  wire CARRYIN_mux;
  reg CARRYIN_reg = 1'b0;
  wire [3:0] ALUMODE_mux;
  reg  [3:0] ALUMODE_reg = 4'b0;
  wire [2:0] CARRYINSEL_mux;
  reg  [2:0] CARRYINSEL_reg = 3'b0;
  wire [8:0] OPMODE_mux;
  reg  [8:0] OPMODE_reg = 9'b0;
//  wire [47:0] ALU_OUT_tmp;
  wire [47:0] alu_o;

//  wire u_43_data;
  wire [47:0] x_mac_cascd;
  
  reg  [47:0] wmux = 48'b0;
  reg  [47:0] xmux = 48'b0;
  reg  [47:0] ymux = 48'b0;
  reg  [47:0] zmux = 48'b0;
  wire [47:0] z_optinv;
  
  wire cin;
  reg cin_b = 1'b0;
  wire rst_carryin_g;
  reg qmultcarryin = 1'b0;

  wire c_mult;
  wire ce_m_g;
  wire d_carryin_int;
  wire dr_carryin_int;
  wire multcarryin_data;

  reg invalid_opmode = 1'b1;
  reg opmode_valid_flag_dal = 1'b1; // used in OPMODE DRC
  reg ping_opmode_drc_check = 1'b0;

  wire [MAX_ALU_FULL-1:0] co;
  wire [MAX_ALU_FULL-1:0] s;
  wire [MAX_ALU_FULL-1:0] comux;
  wire [MAX_ALU_FULL-1:0] comux_w;
  wire [MAX_ALU_FULL-1:0] comux4simd;
  wire [MAX_ALU_FULL-1:0] smux;
  wire [MAX_ALU_FULL-1:0] smux_w;
//  wire [MAX_CARRYOUT-1:0] carryout_o_hw;
//  wire [MAX_CARRYOUT-1:0] carryout_o;
  wire [48:0] a_int;
  wire [47:0] b_int;
  wire [12:0] s0;
  wire cout0;
  wire intc1;
  wire co12_lsb;
  wire [12:0] s1;
  wire cout1;
  wire intc2;
  wire co24_lsb;
  wire [12:0] s2;
  wire cout2;
  wire intc3;
  wire co36_lsb;
  wire [13:0] s3;
  wire cout3;
  wire cout4;
  wire xor_12a;
  wire xor_12b;
  wire xor_12c;
  wire xor_12d;
  wire xor_12e;
  wire xor_12f;
  wire xor_12g;
  wire xor_12h;
  wire xor_24a;
  wire xor_24b;
  wire xor_24c;
  wire xor_24d;
  wire xor_48a;
  wire xor_48b;
  wire xor_96;
  wire cout_0;
  wire cout_1;
  wire cout_2;
  wire cout_3;
  wire mult_or_logic;

// DSP_A_B_DATA wires
  wire [29:0] A_ACIN_mux;
  wire [29:0] A1_reg_mux;
  wire [29:0] A2_reg_mux;
  reg [29:0] A1_reg = 30'b0;
  reg [29:0] A2_reg = 30'b0;
  wire [17:0] B_BCIN_mux;
  wire [17:0] B1_reg_mux;
  wire [17:0] B2_reg_mux;
  reg [17:0] B1_reg = 18'b0;
  reg [17:0] B2_reg = 18'b0;
  wire CLK_areg1;
  wire CLK_areg2;
  wire CLK_breg1;
  wire CLK_breg2;

// DSP_C_DATA wires
  reg [47:0] C_reg = 48'b0;
  wire CLK_creg;

// DSP_MULTIPLIER wires
  wire [17:0] b_mult_mux;
  wire [26:0] a_mult_mux;
  wire [44:0] mult;
  reg [43:0] ps_u_mask = 44'h55555555555;
  reg [43:0] ps_v_mask = 44'haaaaaaaaaaa;

// DSP_M_DATA wires
  reg [44:0] U_DATA_reg = 45'h100000000000;
  reg [44:0] V_DATA_reg = 45'h100000000000;
  wire CLK_mreg;

// DSP_OUTPUT wires
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

// DSP_PREADD wires
  wire [26:0] D_DATA_mux;

// DSP_PREADD_DATA wires
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
  assign #(out_delay) ACOUT = ACOUT_delay;
  assign #(out_delay) BCOUT = BCOUT_delay;
  assign #(out_delay) CARRYCASCOUT = CARRYCASCOUT_delay;
  assign #(out_delay) CARRYOUT = CARRYOUT_delay;
  assign #(out_delay) MULTSIGNOUT = MULTSIGNOUT_delay;
  assign #(out_delay) OVERFLOW = OVERFLOW_delay;
  assign #(out_delay) P = P_delay;
  assign #(out_delay) PATTERNBDETECT = PATTERN_B_DETECT_delay;
  assign #(out_delay) PATTERNDETECT = PATTERN_DETECT_delay;
  assign #(out_delay) PCOUT = PCOUT_delay;
  assign #(out_delay) UNDERFLOW = UNDERFLOW_delay;
  assign #(out_delay) XOROUT = XOROUT_delay;

  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) ACIN_delay = ACIN;
  assign #(in_delay) ALUMODE_delay = ALUMODE;
  assign #(in_delay) A_delay = A;
  assign #(in_delay) BCIN_delay = BCIN;
  assign #(in_delay) B_delay = B;
  assign #(in_delay) CARRYINSEL_delay = CARRYINSEL;
  assign #(in_delay) CARRYIN_delay = CARRYIN;
  assign #(in_delay) CEA1_delay = CEA1;
  assign #(in_delay) CEA2_delay = CEA2;
  assign #(in_delay) CEAD_delay = CEAD;
  assign #(in_delay) CEALUMODE_delay = CEALUMODE;
  assign #(in_delay) CEB1_delay = CEB1;
  assign #(in_delay) CEB2_delay = CEB2;
  assign #(in_delay) CECARRYIN_delay = CECARRYIN;
  assign #(in_delay) CECTRL_delay = CECTRL;
  assign #(in_delay) CEC_delay = CEC;
  assign #(in_delay) CED_delay = CED;
  assign #(in_delay) CEINMODE_delay = CEINMODE;
  assign #(in_delay) CEM_delay = CEM;
  assign #(in_delay) CEP_delay = CEP;
  assign #(in_delay) C_delay = C;
  assign #(in_delay) D_delay = D;
  assign #(in_delay) INMODE_delay = INMODE;
  assign #(in_delay) OPMODE_delay = OPMODE;
  assign #(in_delay) RSTALLCARRYIN_delay = RSTALLCARRYIN;
  assign #(in_delay) RSTALUMODE_delay = RSTALUMODE;
  assign #(in_delay) RSTA_delay = RSTA;
  assign #(in_delay) RSTB_delay = RSTB;
  assign #(in_delay) RSTCTRL_delay = RSTCTRL;
  assign #(in_delay) RSTC_delay = RSTC;
  assign #(in_delay) RSTD_delay = RSTD;
  assign #(in_delay) RSTINMODE_delay = RSTINMODE;
  assign #(in_delay) RSTM_delay = RSTM;
  assign #(in_delay) RSTP_delay = RSTP;

  assign #(in_delay) CARRYCASCIN_delay = CARRYCASCIN;
  assign #(in_delay) MULTSIGNIN_delay = MULTSIGNIN;
  assign #(in_delay) PCIN_delay = PCIN;

  assign ALUMODE10_delay = ALUMODE10_out;
  assign ALU_OUT_delay = ALU_OUT_out;
//  assign COUT_delay = ((OPMODE_mux[3:0] == 4'b0101) || (ALUMODE_mux[3:2] != 2'b00)) ? 4'hx : COUT_out;
  assign COUT_delay = COUT_out;
  assign MULTSIGN_ALU_delay = MULTSIGN_ALU_out;
  assign XOR_MX_delay = XOR_MX_out;
  assign CCOUT_FB_delay = CCOUT_FB_out;
  assign P_FDBK_delay = P_FDBK_out;
  assign P_FDBK_47_delay = P_FDBK_47_out;
  assign A2A1_delay = A2A1_out;
  assign ADDSUB_delay = ADDSUB_out;
  assign AMULT26_delay = AMULT26_out;
  assign AD_DATA_delay = AD_DATA_out;
  assign AD_delay = AD_out;
  assign A1_DATA_delay = A1_DATA_out;
  assign A2_DATA_delay = A2_DATA_out;
  assign ACOUT_delay = ACOUT_out;
  assign A_ALU_delay = A_ALU_out;
  assign B1_DATA_delay = B1_DATA_out;
  assign B2B1_delay = B2B1_out;
  assign B2_DATA_delay = B2_DATA_out;
  assign BCOUT_delay = BCOUT_out;
  assign BMULT17_delay = BMULT17_out;
  assign B_ALU_delay = B_ALU_out;
  assign CARRYCASCOUT_delay = CARRYCASCOUT_out;
  assign CARRYOUT_delay = CARRYOUT_out;
  assign C_DATA_delay = C_DATA_out;
  assign D_DATA_delay = D_DATA_out;
  assign INMODE_2_delay = INMODE_2_out;
  assign MULTSIGNOUT_delay = MULTSIGNOUT_out;
  assign OVERFLOW_delay = OVERFLOW_out;
  assign PATTERN_B_DETECT_delay = PATTERN_B_DETECT_out;
  assign PATTERN_DETECT_delay = PATTERN_DETECT_out;
  assign PCOUT_delay = PCOUT_out;
  assign PREADD_AB_delay = PREADD_AB_out;
  assign P_delay = P_out;
  assign UNDERFLOW_delay = UNDERFLOW_out;
  assign U_delay = U_out;
  assign V_delay = V_out;
  assign U_DATA_delay = U_DATA_out;
  assign V_DATA_delay = V_DATA_out;
  assign XOROUT_delay = XOROUT_out;

  assign AMULT26_in = AMULT26_delay;
  assign A_ALU_in = A_ALU_delay;
  assign BMULT17_in = BMULT17_delay;
  assign B_ALU_in = B_ALU_delay;
  assign CCOUT_in = CCOUT_FB_delay;
  assign P_FDBK_47_in = P_FDBK_47_delay;
  assign P_FDBK_in = P_FDBK_delay;
  assign U_DATA_in = (USE_SIMD_BIN == USE_SIMD_ONE48) ? U_DATA_delay : 45'h100000000000;
  assign V_DATA_in = (USE_SIMD_BIN == USE_SIMD_ONE48) ? V_DATA_delay : 45'h100000000000;
  assign ALUMODE10_in = ALUMODE10_delay;
  assign #1 ALU_OUT_in = ALU_OUT_delay; // break 0 delay feedback
  assign COUT_in = COUT_delay;
  assign MULTSIGN_ALU_in = MULTSIGN_ALU_delay;
  assign XOR_MX_in = XOR_MX_delay;
  assign A2A1_in = A2A1_delay;
  assign AD_DATA_in = AD_DATA_delay;
  assign B2B1_in = B2B1_delay;
  assign A1_DATA_in = A1_DATA_delay;
  assign A2_DATA_in = A2_DATA_delay;
  assign ACIN_in = ACIN_delay;
  assign ADDSUB_in = ADDSUB_delay;
  assign AD_in = AD_delay;
  assign ALUMODE_in = ALUMODE_delay ^ IS_ALUMODE_INVERTED_BIN;
  assign A_in = A_delay;
  assign B1_DATA_in = B1_DATA_delay;
  assign B2_DATA_in = B2_DATA_delay;
  assign BCIN_in = BCIN_delay;
  assign B_in = B_delay;
  assign CARRYCASCIN_in = CARRYCASCIN_delay;
  assign CARRYINSEL_in = CARRYINSEL_delay;
  assign CARRYIN_in = CARRYIN_delay ^ IS_CARRYIN_INVERTED_BIN;
  assign CEA1_in = CEA1_delay;
  assign CEA2_in = CEA2_delay;
  assign CEAD_in = CEAD_delay;
  assign CEALUMODE_in = CEALUMODE_delay;
  assign CEB1_in = CEB1_delay;
  assign CEB2_in = CEB2_delay;
  assign CECARRYIN_in = CECARRYIN_delay;
  assign CECTRL_in = CECTRL_delay;
  assign CEC_in = CEC_delay;
  assign CED_in = CED_delay;
  assign CEINMODE_in = CEINMODE_delay;
  assign CEM_in = CEM_delay;
  assign CEP_in = CEP_delay;
  assign CLK_in = CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_areg1  = (AREG_BIN == AREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_areg2  = (AREG_BIN == AREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_breg1  = (BREG_BIN == BREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_breg2  = (BREG_BIN == BREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_creg   = (CREG_BIN == CREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_mreg   = (MREG_BIN == MREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_preg   = (PREG_BIN == PREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_inmode = (INMODEREG_BIN == INMODEREG_0) ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_dreg   = (DREG_BIN == DREG_0)           ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign CLK_adreg  = (ADREG_BIN == ADREG_0)         ? 1'b0 : CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign C_DATA_in = C_DATA_delay;
  assign C_in = C_delay;
  assign DIN_in = D_delay;
  assign D_DATA_in = D_DATA_delay;
  assign D_in = D_delay;
  assign INMODE_2_in = INMODE_2_delay;
  assign INMODE_in = INMODE_delay ^ IS_INMODE_INVERTED_BIN;
  assign MULTSIGNIN_in = MULTSIGNIN_delay;
  assign OPMODE_in = OPMODE_delay ^ IS_OPMODE_INVERTED_BIN;
  assign PCIN_in = PCIN_delay;
  assign PREADD_AB_in = PREADD_AB_delay;
  assign RSTALLCARRYIN_in = RSTALLCARRYIN_delay ^ IS_RSTALLCARRYIN_INVERTED_BIN;
  assign RSTALUMODE_in = RSTALUMODE_delay ^ IS_RSTALUMODE_INVERTED_BIN;
  assign RSTA_in = RSTA_delay ^ IS_RSTA_INVERTED_BIN;
  assign RSTB_in = RSTB_delay ^ IS_RSTB_INVERTED_BIN;
  assign RSTCTRL_in = RSTCTRL_delay ^ IS_RSTCTRL_INVERTED_BIN;
  assign RSTC_in = RSTC_delay ^ IS_RSTC_INVERTED_BIN;
  assign RSTD_in = RSTD_delay ^ IS_RSTD_INVERTED_BIN;
  assign RSTINMODE_in = RSTINMODE_delay ^ IS_RSTINMODE_INVERTED_BIN;
  assign RSTM_in = RSTM_delay ^ IS_RSTM_INVERTED_BIN;
  assign RSTP_in = RSTP_delay ^ IS_RSTP_INVERTED_BIN;
  assign U_in = U_delay;
  assign V_in = V_delay;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign ACASCREG_BIN =
    (ACASCREG_REG == 1) ? ACASCREG_1 :
    (ACASCREG_REG == 0) ? ACASCREG_0 :
    (ACASCREG_REG == 2) ? ACASCREG_2 :
     ACASCREG_1;

  assign ADREG_BIN =
    (ADREG_REG == 1) ? ADREG_1 :
    (ADREG_REG == 0) ? ADREG_0 :
     ADREG_1;

  assign ALUMODEREG_BIN =
    (ALUMODEREG_REG == 1) ? ALUMODEREG_1 :
    (ALUMODEREG_REG == 0) ? ALUMODEREG_0 :
     ALUMODEREG_1;

  assign AMULTSEL_BIN = 
    (AMULTSEL_REG == "A") ? AMULTSEL_A :
    (AMULTSEL_REG == "AD") ? AMULTSEL_AD :
    AMULTSEL_A;

  assign AREG_BIN =
    (AREG_REG == 1) ? AREG_1 :
    (AREG_REG == 0) ? AREG_0 :
    (AREG_REG == 2) ? AREG_2 :
     AREG_1;

  assign AUTORESET_PATDET_BIN = 
    (AUTORESET_PATDET_REG == "NO_RESET") ? AUTORESET_PATDET_NO_RESET :
    (AUTORESET_PATDET_REG == "RESET_MATCH") ? AUTORESET_PATDET_RESET_MATCH :
    (AUTORESET_PATDET_REG == "RESET_NOT_MATCH") ? AUTORESET_PATDET_RESET_NOT_MATCH :
    AUTORESET_PATDET_NO_RESET;

  assign AUTORESET_PRIORITY_BIN = 
    (AUTORESET_PRIORITY_REG == "RESET") ? AUTORESET_PRIORITY_RESET :
    (AUTORESET_PRIORITY_REG == "CEP") ? AUTORESET_PRIORITY_CEP :
    AUTORESET_PRIORITY_RESET;

  assign A_INPUT_BIN = 
    (A_INPUT_REG == "DIRECT") ? A_INPUT_DIRECT :
    (A_INPUT_REG == "CASCADE") ? A_INPUT_CASCADE :
    A_INPUT_DIRECT;

  assign BCASCREG_BIN =
    (BCASCREG_REG == 1) ? BCASCREG_1 :
    (BCASCREG_REG == 0) ? BCASCREG_0 :
    (BCASCREG_REG == 2) ? BCASCREG_2 :
     BCASCREG_1;

  assign BMULTSEL_BIN = 
    (BMULTSEL_REG == "B") ? BMULTSEL_B :
    (BMULTSEL_REG == "AD") ? BMULTSEL_AD :
    BMULTSEL_B;

  assign BREG_BIN =
    (BREG_REG == 1) ? BREG_1 :
    (BREG_REG == 0) ? BREG_0 :
    (BREG_REG == 2) ? BREG_2 :
     BREG_1;

  assign B_INPUT_BIN =
    (B_INPUT_REG == "DIRECT") ? B_INPUT_DIRECT :
    (B_INPUT_REG == "CASCADE") ? B_INPUT_CASCADE :
     B_INPUT_DIRECT;

  assign CARRYINREG_BIN =
    (CARRYINREG_REG == 1) ? CARRYINREG_1 :
    (CARRYINREG_REG == 0) ? CARRYINREG_0 :
     CARRYINREG_1;

  assign CARRYINSELREG_BIN =
    (CARRYINSELREG_REG == 1) ? CARRYINSELREG_1 :
    (CARRYINSELREG_REG == 0) ? CARRYINSELREG_0 :
     CARRYINSELREG_1;

  assign CREG_BIN =
    (CREG_REG == 1) ? CREG_1 :
    (CREG_REG == 0) ? CREG_0 :
     CREG_1;

  assign DREG_BIN =
    (DREG_REG == 1) ? DREG_1 :
    (DREG_REG == 0) ? DREG_0 :
     DREG_1;

  assign INMODEREG_BIN =
    (INMODEREG_REG == 1) ? INMODEREG_1 :
    (INMODEREG_REG == 0) ? INMODEREG_0 :
     INMODEREG_1;

  assign IS_ALUMODE_INVERTED_BIN = IS_ALUMODE_INVERTED_REG;

  assign IS_CARRYIN_INVERTED_BIN = IS_CARRYIN_INVERTED_REG;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_INMODE_INVERTED_BIN = IS_INMODE_INVERTED_REG;

  assign IS_OPMODE_INVERTED_BIN = IS_OPMODE_INVERTED_REG;

  assign IS_RSTALLCARRYIN_INVERTED_BIN = IS_RSTALLCARRYIN_INVERTED_REG;

  assign IS_RSTALUMODE_INVERTED_BIN = IS_RSTALUMODE_INVERTED_REG;

  assign IS_RSTA_INVERTED_BIN = IS_RSTA_INVERTED_REG;

  assign IS_RSTB_INVERTED_BIN = IS_RSTB_INVERTED_REG;

  assign IS_RSTCTRL_INVERTED_BIN = IS_RSTCTRL_INVERTED_REG;

  assign IS_RSTC_INVERTED_BIN = IS_RSTC_INVERTED_REG;

  assign IS_RSTD_INVERTED_BIN = IS_RSTD_INVERTED_REG;

  assign IS_RSTINMODE_INVERTED_BIN = IS_RSTINMODE_INVERTED_REG;

  assign IS_RSTM_INVERTED_BIN = IS_RSTM_INVERTED_REG;

  assign IS_RSTP_INVERTED_BIN = IS_RSTP_INVERTED_REG;

  assign MASK_BIN = MASK_REG;

  assign MREG_BIN =
    (MREG_REG == 1) ? MREG_1 :
    (MREG_REG == 0) ? MREG_0 :
     MREG_1;

  assign OPMODEREG_BIN =
    (OPMODEREG_REG == 1) ? OPMODEREG_1 :
    (OPMODEREG_REG == 0) ? OPMODEREG_0 :
     OPMODEREG_1;

  assign PATTERN_BIN = PATTERN_REG;

  assign PREADDINSEL_BIN = 
    (PREADDINSEL_REG == "A") ? PREADDINSEL_A :
    (PREADDINSEL_REG == "B") ? PREADDINSEL_B :
    PREADDINSEL_A;

  assign PREG_BIN =
    (PREG_REG == 1) ? PREG_1 :
    (PREG_REG == 0) ? PREG_0 :
     PREG_1;

  assign RND_BIN = RND_REG;

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

  assign USE_MULT_BIN = 
    (USE_MULT_REG == "MULTIPLY") ? USE_MULT_MULTIPLY :
    (USE_MULT_REG == "DYNAMIC") ? USE_MULT_DYNAMIC :
    (USE_MULT_REG == "NONE") ? USE_MULT_NONE :
    USE_MULT_MULTIPLY;

  assign USE_PATTERN_DETECT_BIN = 
    (USE_PATTERN_DETECT_REG == "NO_PATDET") ? USE_PATTERN_DETECT_NO_PATDET :
    (USE_PATTERN_DETECT_REG == "PATDET") ? USE_PATTERN_DETECT_PATDET :
    USE_PATTERN_DETECT_NO_PATDET;

  assign USE_SIMD_BIN = 
    (USE_SIMD_REG == "ONE48") ? USE_SIMD_ONE48 :
    (USE_SIMD_REG == "FOUR12") ? USE_SIMD_FOUR12 :
    (USE_SIMD_REG == "TWO24") ? USE_SIMD_TWO24 :
    USE_SIMD_ONE48;

  assign USE_WIDEXOR_BIN = 
    (USE_WIDEXOR_REG == "FALSE") ? USE_WIDEXOR_FALSE :
    (USE_WIDEXOR_REG == "TRUE") ? USE_WIDEXOR_TRUE :
    USE_WIDEXOR_FALSE;

  assign XORSIMD_BIN = 
    (XORSIMD_REG == "XOR24_48_96") ? XORSIMD_XOR24_48_96 :
    (XORSIMD_REG == "XOR12") ? XORSIMD_XOR12 :
    XORSIMD_XOR24_48_96;


  always @ (trig_attr) begin
    #1;
//-------- AMULTSEL check
    if ((AMULTSEL_REG != "A") &&
        (AMULTSEL_REG != "AD")) begin
        $display("Attribute Syntax Error : The attribute AMULTSEL on %s instance %m is set to %s.  Legal values for this attribute are A or AD.", MODULE_NAME, AMULTSEL_REG);
        attr_err = 1'b1;
    end

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

//-------- A_INPUT check
    if ((A_INPUT_REG != "DIRECT") &&
        (A_INPUT_REG != "CASCADE")) begin
        $display("Attribute Syntax Error : The attribute A_INPUT on %s instance %m is set to %s.  Legal values for this attribute are DIRECT or CASCADE.", MODULE_NAME, A_INPUT_REG);
        attr_err = 1'b1;
    end

//-------- BMULTSEL check
    if ((BMULTSEL_REG != "B") &&
        (BMULTSEL_REG != "AD")) begin
        $display("Attribute Syntax Error : The attribute BMULTSEL on %s instance %m is set to %s.  Legal values for this attribute are B or AD.", MODULE_NAME, BMULTSEL_REG);
        attr_err = 1'b1;
    end

//-------- B_INPUT check
    if ((B_INPUT_REG != "DIRECT") &&
        (B_INPUT_REG != "CASCADE")) begin
        $display("Attribute Syntax Error : The attribute B_INPUT on %s instance %m is set to %s.  Legal values for this attribute are DIRECT or CASCADE.", MODULE_NAME, B_INPUT_REG);
        attr_err = 1'b1;
    end

//-------- PREADDINSEL check
    if ((PREADDINSEL_REG != "A") &&
        (PREADDINSEL_REG != "B")) begin
        $display("Attribute Syntax Error : The attribute PREADDINSEL on %s instance %m is set to %s.  Legal values for this attribute are A or B.", MODULE_NAME, PREADDINSEL_REG);
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

//-------- USE_MULT check
    if ((USE_MULT_REG != "MULTIPLY") && 
        (USE_MULT_REG != "DYNAMIC") && 
        (USE_MULT_REG != "NONE")) begin
        $display("Attribute Syntax Error : The attribute USE_MULT on %s instance %m is set to %s.  Legal values for this attribute are MULTIPLY, DYNAMIC or NONE.", MODULE_NAME, USE_MULT_REG);
        attr_err = 1'b1;
    end

//-------- USE_PATTERN_DETECT check
    if ((USE_PATTERN_DETECT_REG != "NO_PATDET") &&
        (USE_PATTERN_DETECT_REG != "PATDET")) begin
        $display("Attribute Syntax Error : The attribute USE_PATTERN_DETECT on %s instance %m is set to %s.  Legal values for this attribute are NO_PATDET or PATDET.", MODULE_NAME, USE_PATTERN_DETECT_REG);
        attr_err = 1'b1;
    end

//-------- USE_SIMD check
    if ((USE_SIMD_REG != "ONE48") &&
        (USE_SIMD_REG != "FOUR12") &&
        (USE_SIMD_REG != "TWO24")) begin
        $display("Attribute Syntax Error : The attribute USE_SIMD on %s instance %m is set to %s.  Legal values for this attribute are ONE48, FOUR12 or TWO24.", MODULE_NAME, USE_SIMD_REG);
        attr_err = 1'b1;
    end

//-------- USE_WIDEXOR check
    if ((USE_WIDEXOR_REG != "FALSE") &&
        (USE_WIDEXOR_REG != "TRUE")) begin
        $display("Attribute Syntax Error : The attribute USE_WIDEXOR on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, USE_WIDEXOR_REG);
        attr_err = 1'b1;
    end

//-------- XORSIMD check
    if ((XORSIMD_REG != "XOR24_48_96") &&
        (XORSIMD_REG != "XOR12")) begin
        $display("Attribute Syntax Error : The attribute XORSIMD on %s instance %m is set to %s.  Legal values for this attribute are XOR24_48_96 or XOR12.", MODULE_NAME, XORSIMD_REG);
        attr_err = 1'b1;
    end

//-------- ACASCREG check
    if ((ACASCREG_REG != 0) && (ACASCREG_REG != 1) && (ACASCREG_REG != 2))
    begin
      $display("Attribute Syntax Error : The attribute ACASCREG on %s instance %m is set to %d.  Legal values for this attribute are 0 to 2.", MODULE_NAME, ACASCREG_REG);
      attr_err = 1'b1;
    end

//-------- ADREG check
    if ((ADREG_REG != 0) && (ADREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute ADREG on %s instance %m is set to %d.  Legal values for this attribute are 0 or 1.", MODULE_NAME, ADREG_REG);
      attr_err = 1'b1;
    end

//-------- ALUMODEREG check
    if ((ALUMODEREG_REG != 0) && (ALUMODEREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute ALUMODEREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, ALUMODEREG_REG);
      attr_err = 1'b1;
    end

//-------- ACASCREG vs AREG check
    case (AREG_REG)
      0, 1 : if(AREG_REG != ACASCREG_REG) begin
        $display("Attribute Syntax Error : The attribute ACASCREG  on %s instance %m is set to %d.  ACASCREG has to be set to %d when attribute AREG = %d.", MODULE_NAME, ACASCREG_REG, AREG_REG, AREG_REG);
        attr_err = 1'b1;
        end
      2 : if(ACASCREG_REG == 0) begin
        $display("Attribute Syntax Error : The attribute ACASCREG  on %s instance %m is set to %d.  ACASCREG has to be set to either 2 or 1 when attribute AREG = %d.", MODULE_NAME, ACASCREG_REG, AREG_REG);
        attr_err = 1'b1;
        end
      default : begin
        $display("Attribute Syntax Error : The attribute AREG on %s instance %m is set to %d.  Legal values for this attribute are 0, 1 or 2.", MODULE_NAME, AREG_REG);
        attr_err = 1'b1;
        end
    endcase

//-------- BCASCREG check
    if ((BCASCREG_REG != 0) && (BCASCREG_REG != 1) && (BCASCREG_REG != 2))
    begin
      $display("Attribute Syntax Error : The attribute BCASCREG on %s instance %m is set to %d.  Legal values for this attribute are 0 to 2.", MODULE_NAME, BCASCREG_REG);
      attr_err = 1'b1;
    end

//-------- BCASCREG vs BREG check
    case (BREG_REG)
      0, 1 : if(BREG_REG != BCASCREG_REG) begin
        $display("Attribute Syntax Error : The attribute BCASCREG on %s instance %m is set to %d.  BCASCREG has to be set to %d when attribute BREG = %d.", MODULE_NAME, BCASCREG_REG, BREG_REG, BREG_REG);
        attr_err = 1'b1;
        end
      2 : if(BCASCREG_REG == 0) begin
        $display("Attribute Syntax Error : The attribute BCASCREG on %s instance %m is set to %d.  BCASCREG must be set to either 2 or 1 when attribute BREG = %d.", MODULE_NAME, BCASCREG_REG, BREG_REG);
        attr_err = 1'b1;
        end
      default : begin
        $display("Attribute Syntax Error : The attribute BREG on %s instance %m is set to %d.  Legal values for this attribute are 0, 1 or 2.", MODULE_NAME, BREG_REG);
        attr_err = 1'b1;
        end
    endcase

//-------- CARRYINREG check
    if ((CARRYINREG_REG != 0) && (CARRYINREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute CARRYINREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, CARRYINREG_REG);
      attr_err = 1'b1;
    end

//-------- CARRYINSELREG check
    if ((CARRYINSELREG_REG != 0) && (CARRYINSELREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute CARRYINSELREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, CARRYINSELREG_REG);
      attr_err = 1'b1;
    end

//-------- CREG check
    if ((CREG_REG != 0) && (CREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute CREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, CREG_REG);
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

//-------- MREG check
    if ((MREG_REG != 0) && (MREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute MREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, MREG_REG);
      attr_err = 1'b1;
    end

//-------- OPMODEREG check
    if ((OPMODEREG_REG != 0) && (OPMODEREG_REG != 1))
    begin
      $display("Attribute Syntax Error : The attribute OPMODEREG on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, OPMODEREG_REG);
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

// DSP_ALU
//*** GLOBAL hidden GSR pin
//  always @(glblGSR) begin
//	  if (glblGSR) begin
//        assign CARRYIN_reg = 1'b0;
//        assign CARRYINSEL_reg = 3'b0;
//        assign OPMODE_reg = 7'b0;
//        assign ALUMODE_reg = 4'b0;
//	  end
//	  else begin
//        deassign CARRYIN_reg;
//        deassign CARRYINSEL_reg;
//        deassign OPMODE_reg;
//        deassign ALUMODE_reg;
//     end
//  end

//*** W mux
  always @ (OPMODE_mux[8:7] or P_FDBK_in or RND_BIN or C_DATA_in)
     case (OPMODE_mux[8:7])
          2'b00 : wmux <= 48'b0;
          2'b01 : wmux <= P_FDBK_in;
          2'b10 : wmux <= RND_BIN;
          2'b11 : wmux <= C_DATA_in;
        default : wmux <= {48{1'bx}};
    endcase

//*** X mux
// To support MAC-cascade add multsignin to bit 1 of X
  assign x_mac_cascd = (OPMODE_mux[6:4] == 3'b100) ? {{46{1'b0}},MULTSIGNIN_in,1'b0} : {48{1'b0}};

  always @(U_DATA_in or P_FDBK_in or A_ALU_in or B_ALU_in or OPMODE_mux[1:0] or x_mac_cascd)
	  case (OPMODE_mux[1:0])
          2'b00 : xmux <= x_mac_cascd;
          2'b01 : xmux <= {{3{U_DATA_in[44]}}, U_DATA_in};
          2'b10 : xmux <= P_FDBK_in;
          2'b11 : xmux <= {A_ALU_in, B_ALU_in};
        default : xmux <= {48{1'bx}};
	  endcase


//*** Y mux
  always @(OPMODE_mux[3:2] or V_DATA_in or C_DATA_in)
	  case (OPMODE_mux[3:2])
          2'b00 : ymux <= 48'b0;
          2'b01 : ymux <= {{3{1'b0}}, V_DATA_in};
          2'b10 : ymux <= {48{1'b1}};
          2'b11 : ymux <= C_DATA_in;
        default : ymux <= {48{1'bx}};
     endcase


//*** Z mux
  always @(OPMODE_mux[6:4] or PCIN_in or P_FDBK_in or C_DATA_in or P_FDBK_47_in)
	  casex (OPMODE_mux[6:4])
         3'b000 : zmux <= 48'b0;
         3'b001 : zmux <= PCIN_in;
         3'b010 : zmux <= P_FDBK_in;
         3'b011 : zmux <= C_DATA_in;
         3'b100 : zmux <= P_FDBK_in;
         3'b101 : zmux <= {{9{PCIN_in[47]}},  {8{PCIN_in[47]}},   PCIN_in[47:17]};
         3'b11x : zmux <= {{9{P_FDBK_47_in}}, {8{P_FDBK_in[47]}}, P_FDBK_in[47:17]};
        default : zmux <= {48{1'bx}};
     endcase

//*** CARRYINSEL and OPMODE with 1 level of register
    always @(posedge CLK_in) begin
	   if (RSTCTRL_in || glblGSR) begin
         OPMODE_reg <= 9'b0;
	   end  
	   else if (CECTRL_in) begin
         OPMODE_reg <= OPMODE_in;
	   end
    end

    always @(posedge CLK_in) begin
	   if (RSTCTRL_in || glblGSR) begin
         CARRYINSEL_reg <= 3'b0;
	   end  
	   else if (CECTRL_in) begin
         CARRYINSEL_reg <= CARRYINSEL_in;
	   end
    end

    assign CARRYINSEL_mux = (CARRYINSELREG_BIN == CARRYINSELREG_1) ?
               CARRYINSEL_reg : CARRYINSEL_in;
    assign OPMODE_mux = (OPMODEREG_BIN == OPMODEREG_1) ?
               OPMODE_reg : OPMODE_in;

    always @(CARRYINSEL_mux or CARRYCASCIN_in or MULTSIGNIN_in or OPMODE_mux) begin
        if(CARRYINSEL_mux == 3'b010) begin 
           if(!((MULTSIGNIN_in === 1'bx) ||
                ((OPMODE_mux == 9'b001001000) && !(MULTSIGNIN_in === 1'bx)) ||
                ((MULTSIGNIN_in == 1'b0) && (CARRYCASCIN_in == 1'b0)))) begin
	      $display("DRC warning : CARRYCASCIN can only be used in the current %s instance %m if the previous %s is performing a two input ADD operation, or the current %s is configured in the MAC extend opmode 7'b1001000 at %.3f ns.", MODULE_NAME, MODULE_NAME, MODULE_NAME, $time);

// CR 619940 -- Enhanced DRC warning
              $display("DRC warning note : The simulation model does not know the placement of the %s slices used, so it cannot fully confirm the above warning. It is necessary to view the placement of the %s slices and ensure that these warnings are not being breached\n", MODULE_NAME, MODULE_NAME);
            end  
        end  
    end 

//*** ALUMODE with 1 level of register
    always @(posedge CLK_in) begin
	    if (RSTALUMODE_in || glblGSR)
          ALUMODE_reg <= 4'b0;
	    else if (CEALUMODE_in)
          ALUMODE_reg <= ALUMODE_in;
       end

    assign ALUMODE_mux = (ALUMODEREG_BIN == ALUMODEREG_1) ? ALUMODE_reg :
                                                            ALUMODE_in;

//------------------------------------------------------------------
//*** DRC for OPMODE
//------------------------------------------------------------------

// needs PREG from output block
// ~2000 lines code - skip for now - copy/rework from DSP48E1.

//--####################################################################
//--#####                         ALU                              #####
//--####################################################################

// ADDSUB block - first stage of ALU develops sums and carries for Final Adder
// Invert Z for subtract operation using alumode<0>
  assign z_optinv = {48{ALUMODE_mux[0]}} ^ zmux;

// Add W, X, Y, Z carry-save style; basically full adder logic below
  assign co = ((xmux & ymux)|(z_optinv & ymux)|(xmux & z_optinv));
// s has a fan-out of 2 (1) FA with W (2) second leg of XOR tree
  assign s  = (z_optinv^xmux^ymux);

// Mux S and CO to do 2 operands logic operations
// S = produce XOR/XNOR, NOT functions
// CO = produce AND/NAND, OR/NOR functions
  assign comux = ALUMODE_mux[2] ? 0  : co;
  assign smux =  ALUMODE_mux[3] ? co : s;

// Carry mux to handle SIMD mode 
// SIMD must be used here since addition of W requires carry propogation
  assign comux4simd = {
              comux[47:36],
              comux[35]&&~USE_SIMD_BIN[2],
              comux[34:24],
              comux[23]&&~USE_SIMD_BIN[1],
              comux[22:12],
              comux[11]&&~USE_SIMD_BIN[0],
              comux[10:0]
            };

// FA to combine W-mux with s and co
// comux must be shifted to properly reflect carry operation
  assign smux_w  =   smux ^ {comux4simd[46:0],1'b0} ^ wmux;
  assign comux_w = ((smux & {comux4simd[46:0],1'b0}) |
                    (wmux & {comux4simd[46:0],1'b0}) |
                    (smux & wmux));

// alumode10 indicates a subtraction, used to correct carryout polarity
  assign ALUMODE10_out = (ALUMODE_mux[0] & ALUMODE_mux[1]);

// prepare data for Final Adder
// a[0] is in fact the cin bit, adder inputs: a[48:1], b[47:0], cin= a[0]
  assign a_int = {comux_w, cin};
  assign b_int = smux_w;

// FINAL ADDER - second stage develops final sums and carries 
  assign s0        = a_int[11:0] + b_int[11:0];
  // invert if alumode10
  assign cout0     = ALUMODE10_out ^ (a_int[12] ^ s0[12] ^ comux[11]);
  // internal carry is zero'd out on mc_simd == 1
  assign intc1     = ~USE_SIMD_BIN[0] && s0[12];
  // next lsb is zero'd out on mc_simd == 1
  assign co12_lsb  = ~USE_SIMD_BIN[0] && a_int[12];
  //
  assign s1        = {a_int[23:13],co12_lsb} + b_int[23:12] + intc1;
  assign cout1     = ALUMODE10_out ^ (a_int[24] ^ s1[12] ^ comux[23]);
  assign intc2     = ~USE_SIMD_BIN[1] && s1[12];
  assign co24_lsb  = ~USE_SIMD_BIN[1] && a_int[24];
  //
  assign s2        = {a_int[35:25],co24_lsb} + b_int[35:24] + intc2;
  assign cout2     = ALUMODE10_out ^ (a_int[36] ^ s2[12] ^ comux[35]);
  assign intc3     = ~USE_SIMD_BIN[2] && s2[12];
  assign co36_lsb  = ~USE_SIMD_BIN[2] && a_int[36];
  //
  assign s3        = {a_int[48:37],co36_lsb} + {comux4simd[47],b_int[47:36]} + intc3;
  assign cout3     = ALUMODE10_out ^ s3[12];

// Not gated with alumode10 since used to propogate carry in wide multiply
// (above is true in Fuji - need to revisit for Olympus)
  assign cout4     = s3[13];

// Wide XOR
  assign xor_12a = USE_WIDEXOR_BIN ? ^s[5:0] : 0;
  assign xor_12b = USE_WIDEXOR_BIN ? ^s[11:6] : 0;
  assign xor_12c = USE_WIDEXOR_BIN ? ^s[17:12] : 0;
  assign xor_12d = USE_WIDEXOR_BIN ? ^s[23:18] : 0;
  assign xor_12e = USE_WIDEXOR_BIN ? ^s[29:24] : 0;
  assign xor_12f = USE_WIDEXOR_BIN ? ^s[35:30] : 0;
  assign xor_12g = USE_WIDEXOR_BIN ? ^s[41:36] : 0;
  assign xor_12h = USE_WIDEXOR_BIN ? ^s[47:42] : 0;

  assign xor_24a = xor_12a ^ xor_12b;
  assign xor_24b = xor_12c ^ xor_12d;
  assign xor_24c = xor_12e ^ xor_12f;
  assign xor_24d = xor_12g ^ xor_12h;

  assign xor_48a = xor_24a ^ xor_24b;
  assign xor_48b = xor_24c ^ xor_24d;

  assign xor_96 = xor_48a ^ xor_48b;

//  "X" carryout for multiply and logic operations
  assign mult_or_logic = ((OPMODE_mux[3:0] == 4'b0101) ||
                          (ALUMODE_mux[3:2] != 2'b00));
// allow carrycascout to not X in output atom
//  assign cout_3 = mult_or_logic ? 1'bx : cout3;
  assign cout_3 =                        cout3;
  assign cout_2 = mult_or_logic ? 1'bx : cout2;
  assign cout_1 = mult_or_logic ? 1'bx : cout1;
  assign cout_0 = mult_or_logic ? 1'bx : cout0;
// drive signals to Output Atom
// turn SIMD back on
//  assign COUT_out[3] = cout_3;
//  assign COUT_out[2] = cout_2;
//  assign COUT_out[1] = cout_1;
//  assign COUT_out[0] = cout_0;
// from E1
// restored functionality
  assign COUT_out[3] =                                     cout_3;
  assign COUT_out[2] = (USE_SIMD_BIN == USE_SIMD_FOUR12) ? cout_2 : 1'bx;
  assign COUT_out[1] = (USE_SIMD_BIN != USE_SIMD_ONE48 ) ? cout_1 : 1'bx;
  assign COUT_out[0] = (USE_SIMD_BIN == USE_SIMD_FOUR12) ? cout_0 : 1'bx;
  assign MULTSIGN_ALU_out = s3[13]; // from alu rtl but doesn't seem right
// from E1
//  assign MULTSIGN_ALU_out = (OPMODE_mux[6:4] == 3'b100) ? MULTSIGNIN_in :
//                                                          V_43_DATA_in;
  assign alu_o = {s3[11:0],s2[11:0],s1[11:0],s0[11:0]};
  assign ALU_OUT_out = ~ALUMODE_mux[1] ? alu_o : ~alu_o;
  assign XOR_MX_out[0] = XORSIMD_BIN ? xor_12a : xor_24a;
  assign XOR_MX_out[1] = XORSIMD_BIN ? xor_12b : xor_48a;
  assign XOR_MX_out[2] = XORSIMD_BIN ? xor_12c : xor_24b;
  assign XOR_MX_out[3] = XORSIMD_BIN ? xor_12d : xor_96;
  assign XOR_MX_out[4] = XORSIMD_BIN ? xor_12e : xor_24c;
  assign XOR_MX_out[5] = XORSIMD_BIN ? xor_12f : xor_48b;
  assign XOR_MX_out[6] = XORSIMD_BIN ? xor_12g : xor_24d;
  assign XOR_MX_out[7] = xor_12h;


//--########################### END ALU ################################
 
    
//*** CarryIn Mux and Register

//-------  input 0
    always @(posedge CLK_in) begin
	    if (RSTALLCARRYIN_in || glblGSR)
          CARRYIN_reg <= 1'b0;
	    else if (CECARRYIN_in)
          CARRYIN_reg <= CARRYIN_in;
       end

       assign CARRYIN_mux = (CARRYINREG_BIN == CARRYINREG_1) ? CARRYIN_reg : CARRYIN_in;

// INTERNAL CARRYIN REGISTER
  assign c_mult = !(AMULT26_in^BMULT17_in);
  assign ce_m_g   = CEM_in & ~glblGSR; // & gwe
  assign rst_carryin_g = RSTALLCARRYIN_in & ~glblGSR; // & gwe
  assign d_carryin_int  = ce_m_g ? c_mult : qmultcarryin;

// rstallcarryin is injected through data path
  assign dr_carryin_int = rst_carryin_g ? 0 : d_carryin_int;

  always @(posedge CLK_in) begin
    if (glblGSR)
       qmultcarryin <= 1'b0;
    else
       qmultcarryin <= dr_carryin_int;
  end

  // bypass register mux
  assign multcarryin_data = (MREG_BIN == MREG_1) ? qmultcarryin : c_mult;

  always @(CARRYINSEL_mux or CARRYIN_mux or PCIN_in[47] or CARRYCASCIN_in or CCOUT_in or P_FDBK_in[47] or multcarryin_data) begin
	case (CARRYINSEL_mux)
     3'b000  : cin_b <= ~CARRYIN_mux;
     3'b001  : cin_b <= PCIN_in[47];
     3'b010  : cin_b <= ~CARRYCASCIN_in;
     3'b011  : cin_b <= ~PCIN_in[47];
     3'b100  : cin_b <= ~CCOUT_in;
     3'b101  : cin_b <= P_FDBK_in[47];
     3'b110  : cin_b <= ~multcarryin_data;
     3'b111  : cin_b <= ~P_FDBK_in[47];
     default : cin_b <= 1'bx;
	endcase
   end
// disable carryin when performing logic operation
   assign cin = (ALUMODE_mux[3] || ALUMODE_mux[2]) ? 1'b0 : ~cin_b;

// DSP_A_B_DATA
//*********************************************************
//*** Input register A with 2 level deep of registers
//*********************************************************

    assign A_ACIN_mux = (A_INPUT_BIN == A_INPUT_CASCADE) ? ACIN_in : A_in;
//    assign CLK_areg1 =  (AREG_BIN == AREG_0) ? 1'b0 : CLK_in;
//    assign CLK_areg2 =  (AREG_BIN == AREG_0) ? 1'b0 : CLK_in;

    always @(posedge CLK_areg1) begin
       if      (RSTA_in || glblGSR) A1_reg <= 30'b0;
       else if (CEA1_in) A1_reg <= A_ACIN_mux;
       end

    assign A1_reg_mux = (AREG_BIN == AREG_2) ? A1_reg : A_ACIN_mux;

    always @(posedge CLK_areg2) begin
       if      (RSTA_in || glblGSR) A2_reg <= 30'b0;
       else if (CEA2_in) A2_reg <= A1_reg_mux;
       end

    assign A2_reg_mux = (AREG_BIN == AREG_0) ? A1_reg_mux : A2_reg;

// assumes encoding the same for ACASCREG and AREG
    assign ACOUT_out = (ACASCREG_BIN == AREG_BIN) ? A2_reg_mux : A1_reg;
    assign A1_DATA_out = A1_reg[26:0];
    assign A2_DATA_out = A2_reg_mux[26:0];
    assign A_ALU_out = A2_reg_mux;


//*********************************************************
//*** Input register B with 2 level deep of registers
//*********************************************************

    assign B_BCIN_mux = (B_INPUT_BIN == B_INPUT_CASCADE) ? BCIN_in : B_in;
//    assign CLK_breg1 =  (BREG_BIN == BREG_0) ? 1'b0 : CLK_in;
//    assign CLK_breg2 =  (BREG_BIN == BREG_0) ? 1'b0 : CLK_in;

    always @(posedge CLK_breg1) begin
       if      (RSTB_in || glblGSR) B1_reg <= 18'b0;
       else if (CEB1_in) B1_reg <= B_BCIN_mux;
       end

    assign B1_reg_mux = (BREG_BIN == BREG_2) ? B1_reg : B_BCIN_mux;

    always @(posedge CLK_breg2) begin
       if      (RSTB_in || glblGSR) B2_reg <= 18'b0;
       else if (CEB2_in) B2_reg <= B1_reg_mux;
       end

    assign B2_reg_mux = (BREG_BIN == BREG_0) ? B1_reg_mux : B2_reg;

// assumes encoding the same for BCASCREG and BREG
    assign BCOUT_out = (BCASCREG_BIN == BREG_BIN) ? B2_reg_mux : B1_reg;
    assign B1_DATA_out = B1_reg;
    assign B2_DATA_out = B2_reg_mux;
    assign B_ALU_out = B2_reg_mux;

// DSP_C_DATA
//*********************************************************
//*** Input register C with 1 level deep of register
//*********************************************************

//   assign CLK_creg = (CREG_BIN == CREG_1) ? CLK_in : 1'b0;

   always @(posedge CLK_creg) begin
      if      (RSTC_in || glblGSR) C_reg <= 48'b0;
      else if (CEC_in)  C_reg <= C_in;
      end

   assign C_DATA_out = (CREG_BIN == CREG_1) ? C_reg : C_in;

// DSP_MULTIPLIER
assign a_mult_mux = (AMULTSEL_BIN == AMULTSEL_A) ? A2A1_in : AD_DATA_in;
assign b_mult_mux = (BMULTSEL_BIN == BMULTSEL_B) ? B2B1_in : AD_DATA_in;

assign AMULT26_out = a_mult_mux[26];
assign BMULT17_out = b_mult_mux[17];
// U[44],V[44]  11 when mult[44]=0,  10 when mult[44]=1
assign U_out = {1'b1,      mult[43:0] & ps_u_mask};
assign V_out = {~mult[44], mult[43:0] & ps_v_mask};

assign mult = (USE_MULT_BIN == USE_MULT_NONE) ? 45'b0 :
        ({{18{a_mult_mux[26]}},a_mult_mux} * {{27{b_mult_mux[17]}},b_mult_mux});

// DSP_M_DATA
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

// DSP_OUTPUT
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
// DSP_PREADD
//*********************************************************
//*** Preaddsub AD
//*********************************************************
  assign D_DATA_mux = INMODE_2_in ? D_DATA_in : 27'b0;
  assign AD_out = ADDSUB_in ? (D_DATA_mux - PREADD_AB_in) : (D_DATA_mux + PREADD_AB_in);

// DSP_PREADD_DATA
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

always @ (OPMODE_mux) begin
    if (((OPMODE_mux[1:0] == 2'b11) && (USE_MULT_BIN == USE_MULT_MULTIPLY)) &&
        ((AREG_BIN==AREG_0 && BREG_BIN==BREG_0 && MREG_BIN==MREG_0) ||
         (AREG_BIN==AREG_0 && BREG_BIN==BREG_0 && PREG_BIN==PREG_0) ||
         (MREG_BIN==MREG_0 && PREG_BIN==PREG_0)))
       $display("OPMODE Input Warning : The OPMODE[1:0] (%b) to %s instance %m is invalid when using attributes USE_MULT = MULTIPLY and (A, B and M) or (A, B and P) or (M and P) are not REGISTERED at time %.3f ns. Please set USE_MULT to either NONE or DYNAMIC or REGISTER one of each group. (A or B) and (M or P) will satisfy the requirement.", OPMODE_mux[1:0], MODULE_NAME, $time/1000.0);
    if((OPMODE_mux[3:0] == 4'b0101) &&
        ((USE_MULT_BIN == USE_MULT_NONE) || (USE_SIMD_BIN != USE_SIMD_ONE48)))
       $display("OPMODE Input Warning : The OPMODE[3:0] (%b) to %s instance %m is invalid when using attributes USE_MULT = NONE, or USE_SIMD = TWO24 or FOUR12 at %.3f ns.", OPMODE_mux[3:0], MODULE_NAME, $time/1000.0);
    end


endmodule

`endcelldefine
