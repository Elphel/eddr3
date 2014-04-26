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
// /___/   /\      Filename    : IBUFCTRL.v
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
module IBUFCTRL #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter ISTANDARD = "UNUSED",
  parameter USE_IBUFDISABLE = "FALSE"
)(
  output O,

  input I,
  input IBUFDISABLE,
  input INTERMDISABLE,
  input T
);
  
// define constants
  localparam MODULE_NAME = "IBUFCTRL";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam ISTANDARD_UNUSED = 0;
  localparam USE_IBUFDISABLE_FALSE = 1;
  localparam USE_IBUFDISABLE_TRUE = 0;

  integer USE_IBUFDISABLE_BIN;
  localparam [40:1] USE_IBUFDISABLE_REG = USE_IBUFDISABLE;
  localparam [56:1] ISTANDARD_REG = ISTANDARD;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
  wire O_out;

  wire O_delay;
  wire ISTANDARD_BIN;

  wire IBUFDISABLE_in;
  wire INTERMDISABLE_in;
  wire I_in;
  wire T_in;

  wire IBUFDISABLE_delay;
  wire INTERMDISABLE_delay;
  wire I_delay;
  wire T_delay;
  wire NOT_T_OR_IBUFDISABLE;
  
// input output assignments
  assign #(out_delay) O = O_delay;

// inputs with no timing checks

  assign #(in_delay) IBUFDISABLE_delay = IBUFDISABLE;
  assign #(in_delay) INTERMDISABLE_delay = INTERMDISABLE;
  assign #(in_delay) I_delay = I;
  assign #(in_delay) T_delay = T;

  assign O_delay = O_out;

  assign IBUFDISABLE_in = IBUFDISABLE_delay;
  assign INTERMDISABLE_in = INTERMDISABLE_delay;
  assign I_in = I_delay;
  assign T_in = T_delay;

  initial begin
    `ifndef XIL_TIMING
    $display("ERROR: SIMPRIM primitive %s instance %m is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the SIMPRIM library.", MODULE_NAME);
    $finish;
    `endif
  #1;
  trig_attr = ~trig_attr;
  end
 assign ISTANDARD_BIN = 
    (ISTANDARD_REG == "UNUSED") ? ISTANDARD_UNUSED :
    ISTANDARD_UNUSED;

  always @ (trig_attr) begin
    #1;
    if ((ISTANDARD_REG != "UNUSED") && (ISTANDARD_REG != "DEFAULT")) begin
      $display("Attribute Syntax Error : The attribute ISTANDARD on %s instance %m is set to %s.  Legal values for this attribute are UNUSED.", MODULE_NAME, ISTANDARD_REG);
      attr_err = 1'b1;
    end

    case (USE_IBUFDISABLE_REG)
      "TRUE" : USE_IBUFDISABLE_BIN = USE_IBUFDISABLE_TRUE;
      "FALSE" : USE_IBUFDISABLE_BIN = USE_IBUFDISABLE_FALSE;
      default : begin
        $display("Attribute Syntax Error : The attribute USE_IBUFDISABLE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, USE_IBUFDISABLE_REG);
        attr_err = 1'b1;
      end
    endcase

  if (attr_err == 1'b1) $finish;
  end

 generate
       case (USE_IBUFDISABLE)
          "TRUE" :  begin
              assign NOT_T_OR_IBUFDISABLE = ~T_in || IBUFDISABLE_in;
              assign O_out = (NOT_T_OR_IBUFDISABLE == 0)? I_in : (NOT_T_OR_IBUFDISABLE == 1)? 1'b0  : 1'bx;
              end
          "FALSE"  : begin
              assign O_out = I_in;
              end   
       endcase
 endgenerate       
         
  specify
    (I => O) = (0:0:0, 0:0:0);
    (IBUFDISABLE => O) = (0:0:0, 0:0:0);
    (INTERMDISABLE => O) = (0:0:0, 0:0:0);
    (T => O) = (0:0:0, 0:0:0);
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
