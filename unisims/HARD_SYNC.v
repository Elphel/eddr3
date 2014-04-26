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
// /___/   /\      Filename    : HARD_SYNC.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  01/30/13 Initial version
//  05/08/13 712367 - fix blocking assignments
//  05/17/13 718960 - fix BIN encoding
//  05/17/13 719092 - remove SR, add IS_CLK_INVERTED
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module HARD_SYNC #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter integer LATENCY = 2
)(
  output DOUT,

  input CLK,
  input DIN
);
  
// define constants
  localparam MODULE_NAME = "HARD_SYNC";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam [0:0] LATENCY_2 = 1'b0;
  localparam [0:0] LATENCY_3 = 1'b1;

  `ifndef XIL_DR
  localparam [0:0] INIT_REG = INIT;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [1:0] LATENCY_REG = LATENCY;
  `endif

  wire INIT_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire LATENCY_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "HARD_SYNC_dr.v"
  `endif

  wire DOUT_out;

  wire DOUT_delay;

  wire CLK_in;
  wire DIN_in;

  wire CLK_delay;
  wire DIN_delay;
  
// input output assignments
  assign #(out_delay) DOUT = DOUT_delay;

  assign #(in_delay) CLK_delay = CLK;
  assign #(in_delay) DIN_delay = DIN;

  assign DOUT_delay = DOUT_out;

  assign CLK_in = CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign DIN_in = DIN_delay;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign INIT_BIN = INIT_REG;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign LATENCY_BIN = 
    (LATENCY_REG == 2) ? LATENCY_2 :
    (LATENCY_REG == 3) ? LATENCY_3 :
    LATENCY_2;

  always @ (trig_attr) begin
    #1;
    if ((LATENCY_REG != 2) && (LATENCY_REG != 3)) begin
      $display("Attribute Syntax Error : The attribute LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  2 to 3.", MODULE_NAME, LATENCY_REG);
      attr_err = 1'b1;
    end

    if ((INIT_REG != 1'b0) && (INIT_REG != 1'b1)) begin
      $display("Attribute Syntax Error : The attribute INIT on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, INIT_REG);
      attr_err = 1'b1;
    end

    if ((IS_CLK_INVERTED_REG != 1'b0) && (IS_CLK_INVERTED_REG != 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_CLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLK_INVERTED_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

reg D1_reg, D2_reg, D3_reg;

assign DOUT_out = (LATENCY_BIN == LATENCY_2) ? D2_reg : D3_reg;

always @ (posedge CLK_in or posedge glblGSR) begin
   if (glblGSR == 1'b1) begin
      D3_reg <= INIT_BIN;
      D2_reg <= INIT_BIN;
      D1_reg <= INIT_BIN;
      end
   else begin
      D3_reg <= D2_reg;
      D2_reg <= D1_reg;
      D1_reg <= DIN_in;
      end
   end

  specify
    (CLK *> DOUT) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $setuphold (negedge CLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (negedge CLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (posedge CLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
    $setuphold (posedge CLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, DIN_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
