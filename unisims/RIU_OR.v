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
// /___/   /\      Filename    : RIU_OR.v
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
module RIU_OR 
  `ifdef XIL_TIMING //Simprim adding LOC only 
#(
  parameter LOC = "UNPLACED"  
)
  `endif
(
  output [15:0] RIU_RD_DATA,
  output RIU_RD_VALID,

  input [15:0] RIU_RD_DATA_LOW,
  input [15:0] RIU_RD_DATA_UPP,
  input RIU_RD_VALID_LOW,
  input RIU_RD_VALID_UPP
);
  
// define constants
  localparam MODULE_NAME = "RIU_OR";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers


  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  
  wire RIU_RD_VALID_out;
  wire [15:0] RIU_RD_DATA_out;

  wire RIU_RD_VALID_delay;
  wire [15:0] RIU_RD_DATA_delay;

  wire RIU_RD_VALID_LOW_in;
  wire RIU_RD_VALID_UPP_in;
  wire [15:0] RIU_RD_DATA_LOW_in;
  wire [15:0] RIU_RD_DATA_UPP_in;

  wire RIU_RD_VALID_LOW_delay;
  wire RIU_RD_VALID_UPP_delay;
  wire [15:0] RIU_RD_DATA_LOW_delay;
  wire [15:0] RIU_RD_DATA_UPP_delay;
  
// input output assignments
  assign #(out_delay) RIU_RD_DATA = RIU_RD_DATA_delay;
  assign #(out_delay) RIU_RD_VALID = RIU_RD_VALID_delay;

  assign #(in_delay) RIU_RD_DATA_LOW_delay = RIU_RD_DATA_LOW;
  assign #(in_delay) RIU_RD_DATA_UPP_delay = RIU_RD_DATA_UPP;
  assign #(in_delay) RIU_RD_VALID_LOW_delay = RIU_RD_VALID_LOW;
  assign #(in_delay) RIU_RD_VALID_UPP_delay = RIU_RD_VALID_UPP;

  assign RIU_RD_DATA_delay = RIU_RD_DATA_out;
  assign RIU_RD_VALID_delay = RIU_RD_VALID_out;

  assign RIU_RD_DATA_LOW_in = RIU_RD_DATA_LOW_delay;
  assign RIU_RD_DATA_UPP_in = RIU_RD_DATA_UPP_delay;
  assign RIU_RD_VALID_LOW_in = RIU_RD_VALID_LOW_delay;
  assign RIU_RD_VALID_UPP_in = RIU_RD_VALID_UPP_delay;

  assign RIU_RD_DATA_out = RIU_RD_DATA_UPP_in | RIU_RD_DATA_LOW_in;
  assign RIU_RD_VALID_out =   RIU_RD_VALID_UPP_in | RIU_RD_VALID_LOW_in;

  specify
    (RIU_RD_DATA_LOW *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RIU_RD_DATA_UPP *> RIU_RD_DATA) = (0:0:0, 0:0:0);
    (RIU_RD_VALID_LOW => RIU_RD_VALID) = (0:0:0, 0:0:0);
    (RIU_RD_VALID_UPP => RIU_RD_VALID) = (0:0:0, 0:0:0);
    specparam PATHPULSE$ = 0;
  endspecify


endmodule

`endcelldefine
