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
// /___/   /\      Filename    : BUFGCE_DIV.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    04/30/12 - Initial version.
//    02/28/13 - 703678 - update BUFGCE_DIVIDE attribute type.
//    06/20/13 - 723918 - Add latch on CE to match HW
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module BUFGCE_DIV #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer BUFGCE_DIVIDE = 1,
  parameter [0:0] IS_CE_INVERTED = 1'b0,
  parameter [0:0] IS_CLR_INVERTED = 1'b0,
  parameter [0:0] IS_I_INVERTED = 1'b0
)(
  output O,

  input CE,
  input CLR,
  input I
);
  
// define constants
  localparam MODULE_NAME = "BUFGCE_DIV";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;


  `ifndef XIL_DR
  localparam BUFGCE_DIVIDE_REG = BUFGCE_DIVIDE;
  localparam IS_CE_INVERTED_REG = IS_CE_INVERTED;
  localparam IS_CLR_INVERTED_REG = IS_CLR_INVERTED;
  localparam IS_I_INVERTED_REG = IS_I_INVERTED;
  `endif
  wire BUFGCE_DIVIDE_BIN;
  wire IS_CE_INVERTED_BIN;
  wire IS_CLR_INVERTED_BIN;
  wire IS_I_INVERTED_BIN;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "BUFGCE_DIV_dr.v"
  `endif

  wire O_out;

  wire O_delay;

  wire CE_in;
  wire CLR_in;
  wire I_in;

  wire CE_delay;
  wire CLR_delay;
  wire I_delay;

  integer clk_count=1, first_toggle_count=1, second_toggle_count=1;    
  reg first_rise, first_half_period;
  reg  o_out_divide = 0;
  wire i_ce, i_inv;
  reg ce_en;
    

// input output assignments
  assign #(out_delay) O = O_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) I_delay = I;

  assign #(in_delay) CE_delay = CE;
  assign #(in_delay) CLR_delay = CLR;
`endif //  `ifndef XIL_TIMING

  assign O_delay = O_out;

  assign CE_in = CE_delay ^ IS_CE_INVERTED_BIN;
  assign CLR_in = CLR_delay ^ IS_CLR_INVERTED_BIN;
  assign I_in = I_delay ^ IS_I_INVERTED_BIN;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign BUFGCE_DIVIDE_BIN = BUFGCE_DIVIDE_REG;

  assign IS_CE_INVERTED_BIN = IS_CE_INVERTED_REG;

  assign IS_CLR_INVERTED_BIN = IS_CLR_INVERTED_REG;

  assign IS_I_INVERTED_BIN = IS_I_INVERTED_REG;

  always @ (trig_attr) begin
    #1;
    if ((BUFGCE_DIVIDE_REG < 1) && (BUFGCE_DIVIDE_REG > 8)) // decimal
    begin
      $display("Attribute Syntax Error : The attribute BUFGCE_DIVIDE on %s instance %m is set to %d.  Legal values for this attribute are  1 to 8.", MODULE_NAME, BUFGCE_DIVIDE_REG);
      attr_err = 1'b1;
    end

    if ((IS_CE_INVERTED_REG != 1'b0) && (IS_CE_INVERTED_REG != 1'b1)) // binary
    begin
      $display("Attribute Syntax Error : The attribute IS_CE_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CE_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_CLR_INVERTED_REG != 1'b0) && (IS_CLR_INVERTED_REG != 1'b1)) // binary
    begin
      $display("Attribute Syntax Error : The attribute IS_CLR_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLR_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_I_INVERTED_REG != 1'b0) && (IS_I_INVERTED_REG != 1'b1)) // binary
    begin
      $display("Attribute Syntax Error : The attribute IS_I_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_I_INVERTED_REG);
      attr_err = 1'b1;
    end

    case (BUFGCE_DIVIDE_REG)
      1 : begin 
       first_toggle_count = 1;
       second_toggle_count = 1;
     end
      2 : begin 
       first_toggle_count = 2;
       second_toggle_count = 2;
          end
      3 : begin 
       first_toggle_count = 2;
       second_toggle_count = 4;
     end
      4 : begin
       first_toggle_count = 4;
       second_toggle_count = 4;
     end
      5 : begin 
       first_toggle_count = 4;
       second_toggle_count = 6;
     end
      6 : begin 
       first_toggle_count = 6;
       second_toggle_count = 6;
     end
      7 : begin 
       first_toggle_count = 6;
       second_toggle_count = 8;
     end
      8 : begin 
       first_toggle_count = 8;
       second_toggle_count = 8;
          end
    endcase // case(BUFGCE_DIV)

  if (attr_err == 1'b1) $finish;
  end

  always begin
    if (glblGSR == 1'b1) begin
      assign o_out_divide = 1'b0;
      assign clk_count = 0;
      assign first_rise = 1'b1;
      assign first_half_period = 1'b0;
    end   
    else if (glblGSR == 1'b0) begin
      deassign o_out_divide;       
      deassign clk_count;
      deassign first_rise;
      deassign first_half_period;
    end
    @(glblGSR);
  end

  assign i_inv = ~I_in;

  always @(glblGSR, CLR_in, I_in, CE_in)
  begin
    if(glblGSR || CLR_in)
      ce_en <= 1'b0;
    else if (~I_in)
      ce_en <= CE_in;
  end    

  assign i_ce = I_in & ce_en;

  always @(i_ce or posedge glblGSR or posedge CLR_in) begin 
    if (first_toggle_count == 1) begin
      o_out_divide = i_ce;
    end
    else begin
      if(CLR_in == 1'b1 || glblGSR == 1'b1) begin
        o_out_divide = 1'b0;
        clk_count = 1;
        first_half_period = 1'b1;
        first_rise = 1'b1;
      end
      else if(CLR_in == 1'b0 && glblGSR == 1'b0) begin
        if (i_ce == 1'b1 && first_rise == 1'b1) begin
          o_out_divide = 1'b1;
          clk_count = 1;
          first_half_period = 1'b1;
          first_rise = 1'b0;
        end
        else if (clk_count == second_toggle_count && first_half_period == 1'b0) begin
          o_out_divide = ~o_out_divide;
          clk_count = 1;   
          first_half_period = 1'b1;
        end
        else if (clk_count == first_toggle_count && first_half_period == 1'b1) begin
          o_out_divide = ~o_out_divide;
          clk_count = 1;   
          first_half_period = 1'b0;
        end
        else if (first_rise == 1'b0) begin
          clk_count = clk_count + 1;
        end
      end
    end    
  end    
    
//  assign O_out = (period_toggle == 0) ? I_in : o_out_divide;
  assign O_out = o_out_divide;

    specify
    ( CLR *> O) = (0:0:0, 0:0:0);
    ( I *> O) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge I, 0:0:0, notifier);
    $period (posedge I, 0:0:0, notifier);
    $recrem ( negedge CLR, negedge I, 0:0:0, 0:0:0, notifier,,, CLR_delay, I_delay);
    $recrem ( negedge CLR, posedge I, 0:0:0, 0:0:0, notifier,,, CLR_delay, I_delay);
    $recrem ( posedge CLR, negedge I, 0:0:0, 0:0:0, notifier,,, CLR_delay, I_delay);
    $recrem ( posedge CLR, posedge I, 0:0:0, 0:0:0, notifier,,, CLR_delay, I_delay);
    $setuphold (negedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (negedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (posedge I, negedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
    $setuphold (posedge I, posedge CE, 0:0:0, 0:0:0, notifier,,, I_delay, CE_delay);
// not needed ?
    $setuphold (negedge I, negedge CLR, 0:0:0, 0:0:0, notifier,,, I_delay, CLR_delay);
    $setuphold (negedge I, posedge CLR, 0:0:0, 0:0:0, notifier,,, I_delay, CLR_delay);
    $setuphold (posedge I, negedge CLR, 0:0:0, 0:0:0, notifier,,, I_delay, CLR_delay);
    $setuphold (posedge I, posedge CLR, 0:0:0, 0:0:0, notifier,,, I_delay, CLR_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine



