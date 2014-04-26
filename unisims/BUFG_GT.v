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
//  /   /                        Clock Buffer with Divide 
// /___/   /\      Filename    : BUFG_GT.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    03/20/13 - Initial version.
//    05/06/13 - 716311 - match with hardware
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module BUFG_GT #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] IS_CLR_INVERTED = 1'b0
)(
  output O,

  input CE,
  input CEMASK,
  input CLR,
  input CLRMASK,
  input [2:0] DIV,
  input I
);
  
// define constants
  localparam MODULE_NAME = "BUFG_GT";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [0:0] IS_CLR_INVERTED_REG = IS_CLR_INVERTED;
  `endif

  wire IS_CLR_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "BUFG_GT_dr.v"
  `endif

  wire O_out;

  wire O_delay;

  wire CEMASK_in;
  wire CE_in;
  wire CLRMASK_in;
  wire CLR_in;
  wire I_in;
  wire [2:0] DIV_in;

  wire CEMASK_delay;
  wire CE_delay;
  wire CLRMASK_delay;
  wire CLR_delay;
  wire I_delay;
  wire [2:0] DIV_delay;

  integer clk_count=1, first_toggle_count=1, second_toggle_count=1;
  reg first_rise, first_half_period;
  reg  O_out_gl = 0;
  wire i_ce, i_inv, clr_inv;
  wire ce_masked, clrmask_inv, clr_masked;
  reg ce_en;
  reg ce_sync1, ce_sync, clr_sync1, clr_sync;
  
  assign #(out_delay) O = O_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) I_delay = I;

  assign #(in_delay) CEMASK_delay = CEMASK;
  assign #(in_delay) CE_delay = CE;
  assign #(in_delay) CLRMASK_delay = CLRMASK;

  assign #(in_delay) DIV_delay = DIV;
`endif //  `ifndef XIL_TIMING

// inputs with no timing checks

  assign #(in_delay) CLR_delay = CLR;

  assign O_delay = O_out;

  assign CEMASK_in = CEMASK_delay;
  assign CE_in = CE_delay;
  assign CLRMASK_in = CLRMASK_delay;
  assign CLR_in = CLR_delay ^ IS_CLR_INVERTED_BIN;
  assign DIV_in = DIV_delay;
  assign I_in = I_delay;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign IS_CLR_INVERTED_BIN = IS_CLR_INVERTED_REG;

  always @ (trig_attr) begin
    #1;
    if ((IS_CLR_INVERTED_REG != 1'b0) && (IS_CLR_INVERTED_REG != 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_CLR_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLR_INVERTED_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end

always@(DIV_in)
  begin
    case (DIV_in)
      3'b000 : begin
                 first_toggle_count = 1;
                 second_toggle_count = 1;
               end
      3'b001 : begin
                 first_toggle_count = 2;
                 second_toggle_count = 2;
               end
      3'b010 : begin
                 first_toggle_count = 2;
                 second_toggle_count = 4;
               end
      3'b011 : begin
                 first_toggle_count = 4;
                 second_toggle_count = 4;
               end
      3'b100 : begin
                 first_toggle_count = 4;
                 second_toggle_count = 6;
               end
      3'b101 : begin
                 first_toggle_count = 6;
                 second_toggle_count = 6;
               end
      3'b110 : begin
                 first_toggle_count = 6;
                 second_toggle_count = 8;
               end
      3'b111 : begin
                 first_toggle_count = 8;
                 second_toggle_count = 8;
               end
    endcase // case(BUFG_GT)

  end // 

  always
  begin
    if (glblGSR == 1'b1) begin
      assign O_out_gl = 1'b0;
      assign clk_count = 0;
      assign first_rise = 1'b1;
      assign first_half_period = 1'b0;
    end
    else if (glblGSR == 1'b0) begin
      deassign O_out_gl;
      deassign clk_count;
      deassign first_rise;
      deassign first_half_period;
    end
    @(glblGSR);
  end

  always @(posedge I_in, negedge glblGSR)
  begin
    if (glblGSR == 1'b1)
    begin
      ce_sync1 <= 1'b0;
      ce_sync <= 1'b0;
    end
    else
    begin
      ce_sync1 <= CE_in;
      ce_sync <= ce_sync1;
    end
  end  

  assign clr_inv = ~CLR_in;

  always @(posedge I_in, negedge clr_inv)
  begin
    if(~clr_inv)
    begin
      clr_sync1 <= 1'b0;
      clr_sync  <= 1'b0;
    end
    else
      {clr_sync, clr_sync1} <= {clr_sync1, 1'b1};
  end    
 
  assign clr_out = ~clr_sync;
  assign i_inv = ~I_in;
  assign clrmask_inv = ~CLRMASK_in;
  assign ce_masked = ce_sync | CEMASK_in;
  assign clr_masked = clr_out & clrmask_inv;

  always @(i_inv, glblGSR, ce_masked, clr_masked)
  begin
    if (glblGSR || clr_masked)
      ce_en <= 1'b0;
    else if (i_inv)
      ce_en <= ce_masked;
  end

  assign i_ce = I_in & ce_en;

  always @(i_ce or posedge glblGSR or posedge clr_masked) begin
    if (first_toggle_count == 1) begin
      O_out_gl = i_ce;
    end
    else begin
      if(clr_masked == 1'b1 || glblGSR == 1'b1) begin
        O_out_gl = 1'b0;
        clk_count = 1;
        first_half_period = 1'b1;
        first_rise = 1'b1;
      end
      else if(clr_masked == 1'b0 && glblGSR == 1'b0) begin
        if (i_ce == 1'b1 && first_rise == 1'b1) begin
          O_out_gl = 1'b1;
          clk_count = 1;
          first_half_period = 1'b1;
          first_rise = 1'b0;
        end
        else if (clk_count == second_toggle_count && first_half_period == 1'b0) begin
          O_out_gl = ~O_out_gl;
          clk_count = 1;
          first_half_period = 1'b1;
        end
        else if (clk_count == first_toggle_count && first_half_period == 1'b1) begin
          O_out_gl = ~O_out_gl;
          clk_count = 1;
          first_half_period = 1'b0;
        end
        else if (first_rise == 1'b0) begin
          clk_count = clk_count + 1;
        end
      end
    end
  end
 
  assign #1 O_out =  O_out_gl;

    specify
    ( CLR *> O) = (0:0:0, 0:0:0);
    ( CLRMASK *> O) = (0:0:0, 0:0:0);
    ( I *> O) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $recrem ( negedge CLRMASK, posedge I, 0:0:0, 0:0:0);
    $setuphold (posedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (posedge I, negedge CEMASK, 0:0:0, 0:0:0, notifier,,, I_delay, CEMASK_delay);
    $setuphold (posedge I, negedge CLRMASK, 0:0:0, 0:0:0, notifier,,, I_delay, CLRMASK_delay);
    $setuphold (posedge I, negedge DIV, 0:0:0, 0:0:0, notifier,,, I_delay, DIV_delay);
`endif

    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
