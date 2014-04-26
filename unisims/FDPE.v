///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2009 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 13.i 
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  D Flip-Flop with Asynchronous Preset and Clock Enable
// /___/   /\     Filename : FDPE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:16 PST 2004
//  \___\/\___\
//
// Revision:
//    08/25/10 - Initial version.
//    10/20/10 - remove unused pin line from table.
//    11/01/11 - Disable timing check when set reset active (CR632017)
//    12/08/11 - add MSGON and XON attribures (CR636891)
//    01/16/12 - 640813 - add MSGON and XON functionality
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision

`timescale  1 ps / 1 ps

`celldefine 
module FDPE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",
  parameter MSGON = "TRUE",
  parameter XON = "TRUE",
  `endif
  parameter [0:0] INIT = 1'b1,
  parameter [0:0] IS_C_INVERTED = 1'b0,
  parameter [0:0] IS_D_INVERTED = 1'b0,
  parameter [0:0] IS_PRE_INVERTED = 1'b0
)(
  output Q,
  
  input C,
  input CE,
  input D,
  input PRE
);

    wire o_out;
    wire D_dly, C_dly, CE_dly, PRE_dly;
    wire D_in,  C_in,  CE_in,  PRE_in;

    reg q_out = INIT;
    reg notifier;
    wire notifier1;
    reg rst_int, set_int;
    wire [0:0] IS_C_INVERTED_BIN;
    wire [0:0] IS_D_INVERTED_BIN;
    wire [0:0] IS_PRE_INVERTED_BIN;

`ifdef XIL_TIMING
  wire ni, ngsr,  nset, in_out;
  wire in_clk_enable, ce_clk_enable, set_clk_enable;
  wire in_clk_enable1, ce_clk_enable1, set_clk_enable1;
`endif

    
    tri0 GSR = glbl.GSR;

    assign Q = q_out;

`ifdef XIL_TIMING
  not (ni, D_in);
  not (nset, PRE_in);
  not (ngsr, GSR);
  xor (in_out, D_in, Q);

  and (in_clk_enable, ngsr,  nset, CE_in);
  and (ce_clk_enable, ngsr,  nset, in_out);
  and (set_clk_enable, ngsr, CE_in,  ni);

    assign notifier1 = (XON == "FALSE") ?  1'bx : notifier;
    assign in_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : in_clk_enable;
    assign ce_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_clk_enable;
    assign set_clk_enable1 = (MSGON =="FALSE") ? 1'b0 : set_clk_enable;
`else
    assign notifier1 = 1'bx;
`endif

    always @(GSR or PRE_dly)
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
       set_int = PRE_dly ^ IS_PRE_INVERTED_BIN;
       rst_int = 0;
   end
    
    ffsrce_fdpe (o_out, C_in, D_in, CE_in, set_int, rst_int, notifier1);

    always @(o_out)
       q_out = o_out;
  

`ifndef XIL_TIMING
    
    assign C_dly = C;
    assign CE_dly = CE;
    assign D_dly = D;
    assign PRE_dly = PRE;
    
`endif

    assign IS_C_INVERTED_BIN   = IS_C_INVERTED;
    assign IS_D_INVERTED_BIN   = IS_D_INVERTED;
    assign IS_PRE_INVERTED_BIN = IS_PRE_INVERTED;
    assign C_in   = C_dly   ^ IS_C_INVERTED_BIN;
    assign CE_in  = CE_dly;
    assign D_in   = D_dly   ^ IS_D_INVERTED_BIN;
    assign PRE_in = PRE_dly ^ IS_PRE_INVERTED_BIN;

  specify

      (C => Q) = (100:100:100, 100:100:100);

`ifdef XIL_TIMING
      
      (PRE => Q) = (0:0:0, 0:0:0);
      (negedge PRE *> (Q +: 1)) = (0:0:0, 0:0:0);
      (posedge PRE *> (Q +: 1)) = (0:0:0, 0:0:0);

      
        $setuphold (posedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
        $setuphold (posedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
        $setuphold (posedge C, posedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
        $setuphold (posedge C, negedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      
      $recrem (negedge PRE, posedge C &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,PRE_dly, C_dly);
      
      $period (posedge C &&& CE, 0:0:0, notifier);
      $width (posedge C &&& CE, 0:0:0, 0, notifier);
      $width (negedge C &&& CE, 0:0:0, 0, notifier);
      $width (posedge PRE, 0:0:0, 0, notifier);

        $setuphold (negedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
        $setuphold (negedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
        $setuphold (negedge C, posedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
        $setuphold (negedge C, negedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $recrem (posedge PRE, posedge C &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,PRE_dly, C_dly);
      $recrem (negedge PRE, negedge C &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,PRE_dly, C_dly);
      $recrem (posedge PRE, negedge C &&& (set_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,PRE_dly, C_dly);
      $period (negedge C &&& CE, 0:0:0, notifier);
      $width (negedge PRE, 0:0:0, 0, notifier);

`endif

      specparam PATHPULSE$ = 0;

  endspecify

    
endmodule

`endcelldefine 

primitive ffsrce_fdpe (q, clk, d, ce, set, rst, notifier);

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
