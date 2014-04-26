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
//  /   /                        Clock Buffer 
// /___/   /\      Filename    : BUFCE_ROW.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    05/15/12 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module BUFCE_ROW #(
  `ifdef XIL_TIMING //Simprim
  parameter LOC = "UNPLACED",
  `endif
  parameter CE_TYPE = "SYNC",
  parameter [0:0] IS_CE_INVERTED = 1'b0,
  parameter [0:0] IS_I_INVERTED = 1'b0
)(
  output O,

  input CE,
  input I
);

// define constants
  localparam MODULE_NAME = "BUFCE_ROW";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam CE_TYPE_ASYNC = 1;
  localparam CE_TYPE_SYNC = 0;

  `ifndef XIL_DR
  localparam CE_TYPE_REG = CE_TYPE;
  localparam IS_CE_INVERTED_REG = IS_CE_INVERTED;
  localparam IS_I_INVERTED_REG = IS_I_INVERTED;
  `endif
  wire CE_TYPE_BIN;
  wire IS_CE_INVERTED_BIN;
  wire IS_I_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "BUFCE_ROW_dr.v"
  `endif

  wire O_out;

  wire O_delay;

  wire CE_in;
  wire I_in;

  wire CE_delay;
  wire I_delay;

  wire ce_inv, ice, CE_TYPE_INV;
  reg enable_clk;
  
// input output assignments
  assign #(out_delay) O = O_delay;

  assign #(in_delay) CE_delay = CE;
  assign #(in_delay) I_delay = I;

  assign O_delay = O_out;

  assign CE_in = IS_CE_INVERTED_BIN ? ~CE_delay : CE_delay;
  assign I_in = IS_I_INVERTED_BIN ? ~I_delay : I_delay;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

    
  assign CE_TYPE_BIN = 
    (CE_TYPE_REG == "SYNC") ? CE_TYPE_SYNC :
    (CE_TYPE_REG == "ASYNC") ? CE_TYPE_ASYNC :
    CE_TYPE_SYNC;

  assign IS_CE_INVERTED_BIN = IS_CE_INVERTED_REG;
  assign IS_I_INVERTED_BIN = IS_I_INVERTED_REG;

  always @ (trig_attr) begin
    #1;
    case (CE_TYPE_REG) // string
      "SYNC" : /*    */;
      "ASYNC" : /*    */;
      default : begin
        $display("Attribute Syntax Error : The attribute CE_TYPE on %s instance %m is set to %s.  Legal values for this attribute are SYNC or ASYNC.", MODULE_NAME, CE_TYPE_REG);
        attr_err = 1'b1;
      end
    endcase

    if ((IS_CE_INVERTED_REG >= 1'b0) && (IS_CE_INVERTED_REG <= 1'b1)) // binary
      /*    */;
    else begin
      $display("Attribute Syntax Error : The attribute IS_CE_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CE_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_I_INVERTED_REG >= 1'b0) && (IS_I_INVERTED_REG <= 1'b1)) // binary
      /*    */;
    else begin
      $display("Attribute Syntax Error : The attribute IS_I_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_I_INVERTED_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end


  assign CE_TYPE_INV = ~CE_TYPE_BIN;
  assign ce_inv = ~CE_in;
  assign ice = ~(CE_TYPE_INV & I_in);


  always @(ice or ce_inv or glblGSR) begin
  if (glblGSR)
    enable_clk <= 1'b1;
  else if (ice)
    enable_clk <= ~ce_inv;
  end    

  assign O_out = enable_clk & I_in ;

  specify
    (CE *> O) = (0:0:0, 0:0:0);
    (I *> O) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $setuphold (negedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (negedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (posedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (posedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
