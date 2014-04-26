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
// /___/   /\      Filename    : OBUFTE3.v
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
module OBUFTE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DRIVE = 12,
  parameter IOSTANDARD = "DEFAULT"
)(
  output O,

  input I,
  input T
);
  
// define constants
  localparam MODULE_NAME = "OBUFTE3";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam IOSTANDARD_DEFAULT = 0;

//  `ifndef XIL_DR
  localparam [4:0] DRIVE_REG = DRIVE;
  localparam [56:1] IOSTANDARD_REG = IOSTANDARD;
//  `endif

  wire [4:0] DRIVE_BIN;
  wire IOSTANDARD_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
//  `ifdef XIL_DR
//  `include "OBUFTE3_dr.v"
//  `endif

  wire O_out;

  wire O_delay;

  wire I_in;
  wire T_in;

  wire I_delay;
  wire T_delay;

  
  assign #(out_delay) O = O_delay;
  

// inputs with no timing checks

  assign #(in_delay) I_delay = I;
  assign #(in_delay) T_delay = T;

  assign O_delay = O_out;

  assign I_in = I_delay;
  assign T_in = T_delay;

  wire ts;

  tri0 GTS = glbl.GTS;

  or O1 (ts, GTS, T_in);
  bufif0 T1 (O_out, I_in, ts);

  initial begin
     `ifndef XIL_TIMING
    $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
    $finish;
    `endif
  #1;
  trig_attr = ~trig_attr;
  end

  assign DRIVE_BIN = DRIVE_REG;

  assign IOSTANDARD_BIN = 
    (IOSTANDARD_REG == "DEFAULT") ? IOSTANDARD_DEFAULT :
    IOSTANDARD_DEFAULT;

  always @ (trig_attr) begin
    #1;
    if ((DRIVE_REG < 2) || (DRIVE_REG > 24)) begin
      $display("Attribute Syntax Error : The attribute DRIVE on %s instance %m is set to %d.  Legal values for this attribute are  2 to 24.", MODULE_NAME, DRIVE_REG);
      attr_err = 1'b1;
    end

    if ((IOSTANDARD_REG != "DEFAULT")) begin
      $display("Attribute Syntax Error : The attribute IOSTANDARD on %s instance %m is set to %s.  Legal values for this attribute are DEFAULT.", MODULE_NAME, IOSTANDARD_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

  
  endmodule

`endcelldefine
