///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2009 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  D Flip-Flop with Synchronous Reset and Clock Enable
// /___/   /\     Filename : FDRE.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:16 PST 2004
//  \___\/\___\
//
// Revision:
//    08/25/10 - Initial version.
//    10/20/10 - remove unused pin line from table.
//    12/08/11 - add MSGON and XON attribures (CR636891)
//    01/16/12 - 640813 - add MSGON and XON functionality
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision

`timescale  1 ps / 1 ps

`celldefine 
module FDRE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",
  parameter MSGON = "TRUE",
  parameter XON = "TRUE",
  `endif
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_C_INVERTED = 1'b0,
  parameter [0:0] IS_D_INVERTED = 1'b0,
  parameter [0:0] IS_R_INVERTED = 1'b0
)(
  output Q,
  
  input C,
  input CE,
  input D,
  input R
);
  
    wire o_out;
    wire D_dly, C_dly, CE_dly, R_dly;
    wire D_in,         CE_in,  R_in;
    wire IS_C_INVERTED_BIN;
    wire IS_D_INVERTED_BIN;
    wire IS_R_INVERTED_BIN;

    reg q_out = INIT;
    reg notifier;
    wire notifier1;
    reg rst_int, set_int;
    
`ifdef XIL_TIMING
    wire ngsr, nrst, in_out;
    wire in_clk_enable, ce_clk_enable, rst_clk_enable;
    wire in_clk_enable1, ce_clk_enable1, rst_clk_enable1;
`endif

    tri0 GSR = glbl.GSR;

    assign Q = q_out;

`ifdef XIL_TIMING
    not (nrst, R_in);
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

    always @(GSR)
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
       rst_int = 0;
   end
    
    sffsrce_fdre (o_out, IS_C_INVERTED_BIN, C_dly, D_in, CE_in, set_int, rst_int, R_in, notifier1);

    always @(o_out)
   q_out = o_out;
    
`ifndef XIL_TIMING
    
    assign C_dly = C;
    assign CE_dly = CE;
    assign D_dly = D;
    assign R_dly = R;
    
`endif
    assign IS_C_INVERTED_BIN = IS_C_INVERTED;
    assign IS_D_INVERTED_BIN = IS_D_INVERTED;
    assign IS_R_INVERTED_BIN = IS_R_INVERTED;

    assign D_in = D_dly ^ IS_D_INVERTED_BIN;
    assign R_in = R_dly ^ IS_R_INVERTED_BIN;
    assign CE_in = CE_dly;

  specify

        (C => Q) = (100:100:100, 100:100:100);

`ifdef XIL_TIMING
      
      $setuphold (posedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (posedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (posedge C, posedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (posedge C, negedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (posedge C, posedge R &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,R_dly);
      $setuphold (posedge C, negedge R &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,R_dly);
      
      $period (posedge C &&& CE, 0:0:0, notifier);
      $width (posedge C &&& CE, 0:0:0, 0, notifier);
      $width (negedge C &&& CE, 0:0:0, 0, notifier);

      $setuphold (negedge C, posedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (negedge C, negedge CE &&& (ce_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,CE_dly);
      $setuphold (negedge C, posedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (negedge C, negedge D &&& (in_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,D_dly);
      $setuphold (negedge C, posedge R &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,R_dly);
      $setuphold (negedge C, negedge R &&& (rst_clk_enable1!=0), 0:0:0, 0:0:0, notifier,,,C_dly,R_dly);
      $period (negedge C &&& CE, 0:0:0, notifier);

`endif
      
      specparam PATHPULSE$ = 0;

  endspecify

    
endmodule

`endcelldefine 


primitive sffsrce_fdre (q, ici, clk, d, ce, set, rst, srst, notifier);

  output q; reg q;
  input ici, clk, d, ce, set, rst, srst, notifier;

  table

//  ici  clk    d     ce   set   rst       srst notifier   q     q+;

// straight clk
     ?    ?     ?     ?     1     0        ?      ?   :   ?  :  1;
     ?    ?     ?     ?     ?     1        ?      ?   :   ?  :  0;

     0   (01)   ?     ?     0     0        1      ?   :   ?  :  0;
     0   (x1)   ?     ?     0     0        1      ?   :   0  :  0;
     0   (x1)   ?     ?     0     0        1      ?   :   1  :  x;
     0   (0x)   ?     ?     0     0        1      ?   :   0  :  0;
     0   (0x)   ?     ?     0     0        1      ?   :   1  :  x;

     0   (01)   0     1     0     0        0      ?   :   ?  :  0;
     0   (01)   1     1     0     0        0      ?   :   ?  :  1;
     0   (01)   x     1     0     0        0      ?   :   ?  :  x;
     0   (01)   0     x     0     0        0      ?   :   0  :  0;
     0   (01)   1     x     0     0        0      ?   :   1  :  1;

     0   (??)   ?     0     0     0        0      ?   :   ?  :  -;
     0   (1?)   ?     ?     0     0        ?      ?   :   ?  :  -;
     0   (?0)   ?     ?     0     0        ?      ?   :   ?  :  -;

     0   (01)   ?     0     0     0        x      ?   :   0  :  0;
     0   (01)   0     1     0     0        x      ?   :   ?  :  0;
//     0   (01)   ?     0     0     0        0      ?   :   1  :  1;
//     0   (01)   1     1     0     0        0      ?   :   ?  :  1;

     0   (?1)   ?     0     0     0        x      ?   :   0  :  0;
//     0   (?1)   ?     0     0     0        0      ?   :   1  :  1;
     0   (0?)   ?     0     0     0        x      ?   :   0  :  0;
//     0   (0?)   ?     0     0     0        0      ?   :   1  :  1;

     0   (01)   0     ?     0     x        0      ?   :   0  :  0;
     0   (01)   ?     0     0     x        x      ?   :   0  :  0;
     0   (01)   0     ?     0     x        x      ?   :   0  :  0;
     0   (01)   ?     ?     0     x        1      ?   :   ?  :  0;
     0   (01)   0     1     0     x        ?      ?   :   ?  :  0;

     0   (0?)   0     ?     0     x        0      ?   :   0  :  0;
     0   (0?)   ?     0     0     x        x      ?   :   0  :  0;
     0   (0?)   0     ?     0     x        x      ?   :   0  :  0;
     0   (0?)   ?     ?     0     x        1      ?   :   0  :  0;
     0   (?1)   0     ?     0     x        0      ?   :   0  :  0;
     0   (?1)   ?     0     0     x        x      ?   :   0  :  0;
     0   (?1)   0     ?     0     x        x      ?   :   0  :  0;
     0   (?1)   ?     ?     0     x        1      ?   :   0  :  0;

     0   (01)   1     ?     x     0        0      ?   :   1  :  1;
     0   (01)   ?     0     x     0        0      ?   :   1  :  1;
//     0   (01)   1     ?     x     0        0      ?   :   1  :  1;
     0   (01)   1     1     x     0        0      ?   :   ?  :  1;

     0   (0?)   1     ?     x     0        0      ?   :   1  :  1;
     0   (0?)   ?     0     x     0        0      ?   :   1  :  1;
//     0   (0?)   1     ?     x     0        0      ?   :   1  :  1;
     0   (?1)   1     ?     x     0        0      ?   :   1  :  1;
     0   (?1)   ?     0     x     0        0      ?   :   1  :  1;
//     0   (?1)   1     ?     x     0        0      ?   :   1  :  1;

     ?    ?     ?     ?     0    (?x)      ?      ?   :   0  :  0;
     ?    ?     ?     ?    (?x)   0        ?      ?   :   1  :  1;

     0   (?1)   1     ?     ?     0        0      ?   :   1  :  1;
     0   (?1)   0     ?     0     ?        ?      ?   :   0  :  0;
     0   (0?)   1     ?     ?     0        0      ?   :   1  :  1;
     0   (0?)   0     ?     0     ?        ?      ?   :   0  :  0;

// inverted clk
     1   (10)   ?     ?     0     0        1      ?   :   ?  :  0;
     1   (x0)   ?     ?     0     0        1      ?   :   0  :  0;
     1   (x0)   ?     ?     0     0        1      ?   :   1  :  x;
     1   (1x)   ?     ?     0     0        1      ?   :   0  :  0;
     1   (1x)   ?     ?     0     0        1      ?   :   1  :  x;

     1   (10)   0     1     0     0        0      ?   :   ?  :  0;
     1   (10)   1     1     0     0        0      ?   :   ?  :  1;
     1   (10)   x     1     0     0        0      ?   :   ?  :  x;
     1   (10)   0     x     0     0        0      ?   :   0  :  0;
     1   (10)   1     x     0     0        0      ?   :   1  :  1;

     1   (??)   ?     0     0     0        0      ?   :   ?  :  -;
     1   (0?)   ?     ?     0     0        ?      ?   :   ?  :  -;
     1   (?1)   ?     ?     0     0        ?      ?   :   ?  :  -;

     1   (10)   ?     0     0     0        x      ?   :   0  :  0;
     1   (10)   0     1     0     0        x      ?   :   ?  :  0;
//     1   (10)   ?     0     0     0        0      ?   :   1  :  1;
//     1   (10)   1     1     0     0        0      ?   :   ?  :  1;

     1   (?0)   ?     0     0     0        x      ?   :   0  :  0;
//     1   (?0)   ?     0     0     0        0      ?   :   1  :  1;
     1   (1?)   ?     0     0     0        x      ?   :   0  :  0;
//     1   (1?)   ?     0     0     0        0      ?   :   1  :  1;

     1   (10)   0     ?     0     x        0      ?   :   0  :  0;
     1   (10)   ?     0     0     x        x      ?   :   0  :  0;
     1   (10)   0     ?     0     x        x      ?   :   0  :  0;
     1   (10)   ?     ?     0     x        1      ?   :   ?  :  0;
     1   (10)   0     1     0     x        ?      ?   :   ?  :  0;

     1   (1?)   0     ?     0     x        0      ?   :   0  :  0;
     1   (1?)   ?     0     0     x        x      ?   :   0  :  0;
     1   (1?)   0     ?     0     x        x      ?   :   0  :  0;
     1   (1?)   ?     ?     0     x        1      ?   :   0  :  0;
     1   (?0)   0     ?     0     x        0      ?   :   0  :  0;
     1   (?0)   ?     0     0     x        x      ?   :   0  :  0;
     1   (?0)   0     ?     0     x        x      ?   :   0  :  0;
     1   (?0)   ?     ?     0     x        1      ?   :   0  :  0;

     1   (10)   1     ?     x     0        0      ?   :   1  :  1;
     1   (10)   ?     0     x     0        0      ?   :   1  :  1;
//     1   (10)   1     ?     x     0        0      ?   :   1  :  1;
     1   (10)   1     1     x     0        0      ?   :   ?  :  1;

     1   (1?)   1     ?     x     0        0      ?   :   1  :  1;
     1   (1?)   ?     0     x     0        0      ?   :   1  :  1;
//     1   (1?)   1     ?     x     0        0      ?   :   1  :  1;
     1   (?0)   1     ?     x     0        0      ?   :   1  :  1;
     1   (?0)   ?     0     x     0        0      ?   :   1  :  1;
//     1   (?0)   1     ?     x     0        0      ?   :   1  :  1;

     1   (?0)   1     ?     ?     0        0      ?   :   1  :  1;
     1   (?0)   0     ?     0     ?        ?      ?   :   0  :  0;
     1   (1?)   1     ?     ?     0        0      ?   :   1  :  1;
     1   (1?)   0     ?     0     ?        ?      ?   :   0  :  0;

// either
     ?    ?    (??)   ?     ?     ?        ?      ?   :   ?  :  -;
     ?    ?     ?    (??)   ?     ?        ?      ?   :   ?  :  -;
     ?    ?     ?     ?    (?0)   ?        ?      ?   :   ?  :  -;
     ?    ?     ?     ?     x    (?0)      ?      ?   :   ?  :  x;
     ?    ?     ?     ?     0    (?0)      ?      ?   :   ?  :  -;
     ?    ?     ?     ?     ?     ?       (??)    ?   :   ?  :  -;

     ?    ?     ?     ?     ?     ?        ?      *   :   ?  :  x;

  endtable

endprimitive
