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
// /___/   /\      Filename    : IOBUFE3.v
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
module IOBUFE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DRIVE = 12,
  parameter IBUF_LOW_PWR = "TRUE",
  parameter IOSTANDARD = "DEFAULT",
  parameter integer SIM_INPUT_BUFFER_OFFSET = 0
)(
  output O,

  inout IO,
  input I,
  input [3:0] OSC,
  input OSC_EN,
  input T,
  input VREF
);
  
// define constants
  localparam MODULE_NAME = "IOBUFE3";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;
  //localparam signed [6:0] SIM_INPUT_BUFFER_OFFSET = -7'd50;

// Parameter encodings and registers
  localparam IBUF_LOW_PWR_FALSE = 1;
  localparam IBUF_LOW_PWR_TRUE = 0;
  localparam IOSTANDARD_DEFAULT = 0;


//  `ifndef XIL_DR
  localparam [40:1] IBUF_LOW_PWR_REG = IBUF_LOW_PWR;
  localparam [56:1] IOSTANDARD_REG = IOSTANDARD;
  localparam [4:0] DRIVE_REG = DRIVE;
  localparam integer SIM_INPUT_BUFFER_OFFSET_REG = SIM_INPUT_BUFFER_OFFSET;
 // `endif

  wire IBUF_LOW_PWR_BIN;
  wire IOSTANDARD_BIN;
  wire [4:0] DRIVE_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
//  `ifdef XIL_DR
//  `include "IOBUFE3_dr.v"
//  `endif

  wire O_out;
  reg O_OSC_in;

  wire O_delay;

  wire I_in;
  wire T_in;
  wire IO_in;
  wire IO_out;
  wire OSC_EN_in;
  wire VREF_in;
  wire [3:0] OSC_in;

  wire I_delay;
  wire T_delay;
  wire IO_delay_O;
  wire IO_delay_I;
  wire OSC_EN_delay;
  wire VREF_delay;
  wire [3:0] OSC_delay;

  
  assign #(out_delay) O = O_delay;
  

// inputs with no timing checks

  assign #(in_delay) I_delay = I;
  assign #(in_delay) T_delay = T;
  assign #(in_delay) IO_delay_I = IO;
  assign #(in_delay) IO = IO_delay_O;
  assign #(in_delay) OSC_EN_delay = OSC_EN;
  assign #(in_delay) OSC_delay = OSC;
  assign #(in_delay) VREF_delay = VREF;

  assign O_delay = O_out;
  assign IO_delay_O = IO_out;

  assign I_in = I_delay;
  assign T_in = T_delay;
  assign IO_in = IO_delay_I;
  assign OSC_EN_in = OSC_EN_delay;
  assign OSC_in = OSC_delay;
  assign VREF_in = VREF_delay;
  
  wire ts;
  integer OSC_int = 0;

  tri0 GTS = glbl.GTS;

  or O1 (ts, GTS, T_in);
  bufif0 T1 (IO_out, I_in, ts);

  
  assign O_out = (OSC_EN_in) ? O_OSC_in : IO_in;
 
  always @ (OSC_in or OSC_EN_in) begin
      OSC_int = OSC_in[2:0] * 5;
  if (OSC_in[3] == 1'b0 )
      OSC_int =  -1*OSC_int;
  
   if(OSC_EN_in == 1'b1) begin
    if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) < 0)
        O_OSC_in <= 1'b0;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) > 0)  
        O_OSC_in <= 1'b1;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) == 0)
        O_OSC_in <= ~O_OSC_in;
   end
  end

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end
   initial begin
    if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int)< 0)
        O_OSC_in <= 1'b0;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) > 0)  
        O_OSC_in <= 1'b1;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) == 0)
        O_OSC_in <= 1'bx;
  end 
  
  assign DRIVE_BIN = DRIVE_REG;

  assign IBUF_LOW_PWR_BIN =
    (IBUF_LOW_PWR_REG == "FALSE") ? IBUF_LOW_PWR_FALSE :
    (IBUF_LOW_PWR_REG == "TRUE")  ? IBUF_LOW_PWR_TRUE  :
    IBUF_LOW_PWR_TRUE;

  assign IOSTANDARD_BIN = 
    (IOSTANDARD_REG == "DEFAULT") ? IOSTANDARD_DEFAULT :
    IOSTANDARD_DEFAULT;
 
  always @ (trig_attr) begin
    #1;
    if ((IOSTANDARD_REG != "DEFAULT")) begin
      $display("Attribute Syntax Error : The attribute IOSTANDARD on %s instance %m is set to %s.  Legal values for this attribute are DEFAULT.", MODULE_NAME, IOSTANDARD_REG);
      attr_err = 1'b1;
    end
    if ((DRIVE_REG < 2) || (DRIVE_REG > 24)) begin
      $display("Attribute Syntax Error : The attribute DRIVE on %s instance %m is set to %d.  Legal values for this attribute are  2 to 24.", MODULE_NAME, DRIVE_REG);
      attr_err = 1'b1;
    end
    if ((SIM_INPUT_BUFFER_OFFSET_REG < -50) || (SIM_INPUT_BUFFER_OFFSET_REG > 50)) begin
      $display("Attribute Syntax Error : The attribute SIM_INPUT_BUFFER_OFFSET on %s instance %m is set to %d.  Legal values for this attribute are  -50 to 50.", MODULE_NAME, SIM_INPUT_BUFFER_OFFSET_REG);
      attr_err = 1'b1;
    end

    if (IBUF_LOW_PWR_REG != "TRUE" && IBUF_LOW_PWR_REG != "FALSE") begin
      $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, IBUF_LOW_PWR_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

  
  endmodule

`endcelldefine
