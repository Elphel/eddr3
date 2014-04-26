// $Header: $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2012.3
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Static Synchronous RAM 512-Deep by 1-Wide
// /___/   /\     Filename : RAM512X1S.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    07/02/12 - Initial version, from RAM256X1S
//    09/17/12 - 678488 fix file name
// End Revision

`timescale  1 ps / 1 ps

`celldefine

module RAM512X1S # (
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
`endif
    parameter [511:0] INIT = 512'h0,
    parameter [0:0] IS_WCLK_INVERTED = 1'b0
) (
    output O,
    input [8:0] A,
    input D,
    input WCLK,
    input WE
);

    reg  [511:0] mem;
    wire [8:0] A_dly, A_in;

`ifdef XIL_TIMING
    reg notifier;
`endif
    wire D_dly, WCLK_dly, WE_dly;
    wire D_in, WCLK_in, WE_in;
    
    assign O = mem[A_in];

    initial 
        mem = INIT;

    always @(posedge WCLK_in) 
        if (WE_in == 1'b1) mem[A_in] <= #100 D_in;
    
`ifdef XIL_TIMING
    always @(notifier) mem[A_in] <= 1'bx;
`endif
    
`ifndef XIL_TIMING
    assign A_dly = A;
    assign D_dly = D;
    assign WCLK_dly = WCLK;
    assign WE_dly = WE;
`endif
    
    assign WCLK_in = WCLK_dly ^ IS_WCLK_INVERTED;
    assign A_in = A_dly;
    assign D_in = D_dly;
    assign WE_in = WE_dly;

`ifdef XIL_TIMING
 specify
    (WCLK => O) = (0:0:0, 0:0:0);
    (A *> O) = (0:0:0, 0:0:0);
    $setuphold (posedge WCLK, posedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
    $setuphold (posedge WCLK, negedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
    $setuphold (posedge WCLK, posedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
    $setuphold (posedge WCLK, negedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
    $setuphold (posedge WCLK, posedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
    $setuphold (posedge WCLK, negedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
    $setuphold (posedge WCLK, posedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
    $setuphold (posedge WCLK, negedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
    $setuphold (posedge WCLK, posedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
    $setuphold (posedge WCLK, negedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
    $setuphold (posedge WCLK, posedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
    $setuphold (posedge WCLK, negedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
    $setuphold (posedge WCLK, posedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
    $setuphold (posedge WCLK, negedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
    $setuphold (posedge WCLK, posedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
    $setuphold (posedge WCLK, negedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
    $setuphold (posedge WCLK, posedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
    $setuphold (posedge WCLK, negedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
    $setuphold (posedge WCLK, posedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
    $setuphold (posedge WCLK, negedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
    $setuphold (posedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
    $setuphold (posedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
    $period (posedge WCLK &&& WE, 0:0:0, notifier);

    $setuphold (negedge WCLK, posedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
    $setuphold (negedge WCLK, negedge D &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,D_dly);
    $setuphold (negedge WCLK, posedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
    $setuphold (negedge WCLK, negedge A[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[0]);
    $setuphold (negedge WCLK, posedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
    $setuphold (negedge WCLK, negedge A[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[1]);
    $setuphold (negedge WCLK, posedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
    $setuphold (negedge WCLK, negedge A[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[2]);
    $setuphold (negedge WCLK, posedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
    $setuphold (negedge WCLK, negedge A[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[3]);
    $setuphold (negedge WCLK, posedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
    $setuphold (negedge WCLK, negedge A[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[4]);
    $setuphold (negedge WCLK, posedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
    $setuphold (negedge WCLK, negedge A[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[5]);
    $setuphold (negedge WCLK, posedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
    $setuphold (negedge WCLK, negedge A[6] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[6]);
    $setuphold (negedge WCLK, posedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
    $setuphold (negedge WCLK, negedge A[7] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[7]);
    $setuphold (negedge WCLK, posedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
    $setuphold (negedge WCLK, negedge A[8] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,A_dly[8]);
    $setuphold (negedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
    $setuphold (negedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
    $period (negedge WCLK &&& WE, 0:0:0, notifier);

    specparam PATHPULSE$ = 0;
  endspecify
`endif
endmodule
`endcelldefine

