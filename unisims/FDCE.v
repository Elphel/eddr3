///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2009 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 13.i
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  D Flip-Flop with Asynchronous Clear and Clock Enable
// /___/   /\     Filename : FDCE.v
// \   \  /  \    Timestamp : Tue Aug 24 13:37:09 PDT 2010
//  \___\/\___\
//
// Revision:
//    08/24/10 - Initial version.
//    10/20/10 - remove unused pin line from table.
//    11/01/11 - Disable timing check when set reset active (CR632017)
//    12/08/11 - add MSGON and XON attributes (CR636891)
//    01/16/12 - 640813 - add MSGON and XON functionality
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision

`timescale  1 ps / 1 ps

`celldefine 
module FDCE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",
  parameter MSGON = "TRUE",
  parameter XON = "TRUE",
  `endif
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_CLR_INVERTED = 1'b0,
  parameter [0:0] IS_C_INVERTED = 1'b0,
  parameter [0:0] IS_D_INVERTED = 1'b0
)(
  output Q,
  
  input C,
  input CE,
  input CLR,
  input D
);

    wire o_out;
    wire D_dly, C_dly, CE_dly, CLR_dly;
    wire D_in,  C_in,  CE_in,  CLR_in;

    reg q_out = INIT;
    reg notifier;
    wire notifier1;
    reg rst_int, set_int;
    wire [0:0] IS_CLR_INVERTED_BIN;
    wire [0:0] IS_C_INVERTED_BIN;
    wire [0:0] IS_D_INVERTED_BIN;
    
`ifdef XIL_TIMING
    wire ngsr, nrst, in_out;
    wire in_clk_enable, ce_clk_enable, rst_clk_enable;
    wire in_clk_enable1, ce_clk_enable1, rst_clk_enable1;
`endif

    tri0 GSR = glbl.GSR;

    assign Q = q_out;

`ifdef XIL_TIMING
    not (nrst, CLR_in);
    not (ngsr, GSR);
    xor (in_out, D_in, Q);

    and (in_clk_enable, ngsr, nrst, CE_in);
    and (ce_clk_enable, ngsr, nrst, in_out);
    and (rst_clk_enable, ngsr, CE_in, D_in);

    assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
    assign ce_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_clk_enable;
    assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
    assign rst_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : rst_clk_enable;
`else
    assign notifier1 = 1'bx;
`endif

    always @(GSR or CLR_dly)
   if (GSR) 
       if (INIT) begin
      set_int = 1;
      rst_int = 0;
       end
       else begin
      rst_int = 1;
      set_int = 0;
       end
   else begin
       set_int = 0;
       rst_int = CLR_dly ^ IS_CLR_INVERTED_BIN;
   end
    
    ffsrce_fdce (o_out, C_in, D_in, CE_in, set_int, rst_int, notifier1);

    always @(o_out)
   q_out = o_out;

    
`ifndef XIL_TIMING
    
    assign C_dly = C;
    assign CE_dly = CE;
    assign CLR_dly = CLR;
    assign D_dly = D;
    
`endif

    assign IS_CLR_INVERTED_BIN = IS_CLR_INVERTED;
    assign IS_C_INVERTED_BIN   = IS_C_INVERTED;
    assign IS_D_INVERTED_BIN   = IS_D_INVERTED;
    assign C_in   = C_dly   ^ IS_C_INVERTED_BIN;
    assign CE_in  = CE_dly;
    assign CLR_in = CLR_dly ^ IS_CLR_INVERTED_BIN;
    assign D_in   = D_dly   ^ IS_D_INVERTED_BIN;

  specify
      
      (C => Q) = (100:100:100, 100:100:100);

`ifdef XIL_TIMING

      (CLR => Q) = (0:0:0, 0:0:0);
      (negedge CLR *> (Q +: 0)) = (0:0:0, 0:0:0);
      (posedge CLR *> (Q +: 0)) = (0:0:0, 0:0:0);
      
      $setuphold (posedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (posedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (posedge C, posedge D  &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (posedge C, negedge D  &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      
      $recrem (negedge CLR, posedge C  &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLR_dly, C_dly);
      
      $period (posedge C &&& CE, 0:0:0, notifier);
      $width (posedge C &&& CE, 0:0:0, 0, notifier);
      $width (negedge C &&& CE, 0:0:0, 0, notifier);
      $width (posedge CLR, 0:0:0, 0, notifier);

      $setuphold (negedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (negedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (negedge C, posedge D  &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (negedge C, negedge D  &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $recrem (negedge CLR, negedge C  &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLR_dly, C_dly);
      $recrem (posedge CLR, posedge C  &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLR_dly, C_dly);
      $recrem (posedge CLR, negedge C  &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,CLR_dly, C_dly);
      $period (negedge C &&& CE, 0:0:0, notifier);
      $width (negedge CLR, 0:0:0, 0, notifier);

`endif
      
      specparam PATHPULSE$ = 0;

  endspecify

    
endmodule

`endcelldefine

primitive ffsrce_fdce (q, clk, d, ce, set, rst, notifier);

  output q; reg q;
  input clk, d, ce, set, rst, notifier;

  table

    //   clk    d     ce   set   rst   notifier    q     q+;

          ?     ?      ?    1     0       ?    :   ?  :  1;
          ?     ?      ?    ?     1       ?    :   ?  :  0;

         (01)   0      1    0     0       ?    :   ?  :  0;
         (01)   1      1    0     0       ?    :   ?  :  1;
         (01)   x      1    0     0       ?    :   ?  :  x;
         (01)   0      x    0     0       ?    :   0  :  0;
         (01)   1      x    0     0       ?    :   1  :  1;

         (??)   ?      0    ?     ?       ?    :   ?  :  -;
         (1?)   ?      ?    ?     ?       ?    :   ?  :  -;
         (?0)   ?      ?    ?     ?       ?    :   ?  :  -;

         (01)   0      1    0     x       ?    :   ?  :  0;
         (01)   1      1    x     0       ?    :   ?  :  1;

          ?     ?      ?    0    (?x)     ?    :   0  :  0;
          ?     ?      ?   (?x)   0       ?    :   1  :  1;
         (?1)   1      ?    ?     0       ?    :   1  :  1;
         (?1)   0      ?    0     ?       ?    :   0  :  0;
         (0?)   1      ?    ?     0       ?    :   1  :  1;
         (0?)   0      ?    0     ?       ?    :   0  :  0;

          ?    (??)    ?    ?     ?       ?    :   ?  :  -;
          ?     ?    (??)   ?     ?       ?    :   ?  :  -;
          ?     ?      ?   (?0)   ?       ?    :   ?  :  -;

          ?     ?      ?    x    (?0)     ?    :   ?  :  x;
          ?     ?      ?    0    (?0)     ?    :   ?  :  -;

          ?     ?      ?    ?     ?       *    :   ?  :  x;
  endtable

endprimitive
