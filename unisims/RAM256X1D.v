// $Header: $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2012.3
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Static Dual Port Synchronous RAM 256-Deep by 1-Wide
// /___/   /\     Filename : RAMD256.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    07/02/12 - Initial version, from RAM128X1D
// End Revision

`timescale 1 ps/1 ps

`celldefine

module RAM256X1D # (
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
`endif
    parameter [255:0] INIT = 256'h0000000000000000000000000000000000000000000000000000000000000000,
    parameter [0:0] IS_WCLK_INVERTED = 1'b0
)  (
    output DPO,
    output SPO,
    input  [7:0] A,
    input  D,
    input  [7:0] DPRA,
    input  WCLK,
    input  WE
);

    reg  [255:0] mem;
    wire [7:0] A_dly, A_in;
    wire WCLK_dly, WE_dly, D_dly;
    wire WCLK_in, WE_in, D_in;
`ifdef XIL_TIMING
    reg notifier;
`endif

    assign SPO = mem[A_in];
    assign DPO = mem[DPRA];

    initial 
        mem = INIT;

    always @(posedge WCLK_in) 
        if (WE_in == 1'b1) mem[A_in] <= #100 D_in;

`ifdef XIL_TIMING
    always @(notifier) 
        mem[A_in] = 1'bx;
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
	(WCLK => DPO) = (0:0:0, 0:0:0);
	(WCLK => SPO) = (0:0:0, 0:0:0);
	(A[0] => SPO) = (0:0:0, 0:0:0);
	(A[1] => SPO) = (0:0:0, 0:0:0);
	(A[2] => SPO) = (0:0:0, 0:0:0);
	(A[3] => SPO) = (0:0:0, 0:0:0);
	(A[4] => SPO) = (0:0:0, 0:0:0);
	(A[5] => SPO) = (0:0:0, 0:0:0);
	(A[6] => SPO) = (0:0:0, 0:0:0);
	(A[7] => SPO) = (0:0:0, 0:0:0);
	(DPRA[0] => DPO) = (0:0:0, 0:0:0);
	(DPRA[1] => DPO) = (0:0:0, 0:0:0);
	(DPRA[2] => DPO) = (0:0:0, 0:0:0);
	(DPRA[3] => DPO) = (0:0:0, 0:0:0);
	(DPRA[4] => DPO) = (0:0:0, 0:0:0);
	(DPRA[5] => DPO) = (0:0:0, 0:0:0);
	(DPRA[6] => DPO) = (0:0:0, 0:0:0);
	(DPRA[7] => DPO) = (0:0:0, 0:0:0);
	
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
	$setuphold (negedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
	$setuphold (negedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
   $period (negedge WCLK &&& WE, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;
  endspecify
`endif
endmodule
`endcelldefine
