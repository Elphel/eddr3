// $Header: 
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2012 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2012.3
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                 64-Deep by 8-bit Wide Multi Port RAM 
// /___/   /\     Filename : RAM64M8.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    07/02/12 - Initial version, from RAM64M
//    09/17/12 - 678604 - fix compilation errors
// End Revision

`timescale 1 ps/1 ps

`celldefine

module RAM64M8 # (
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [63:0] INIT_A = 64'h0000000000000000,
  parameter [63:0] INIT_B = 64'h0000000000000000,
  parameter [63:0] INIT_C = 64'h0000000000000000,
  parameter [63:0] INIT_D = 64'h0000000000000000,
  parameter [63:0] INIT_E = 64'h0000000000000000,
  parameter [63:0] INIT_F = 64'h0000000000000000,
  parameter [63:0] INIT_G = 64'h0000000000000000,
  parameter [63:0] INIT_H = 64'h0000000000000000,
  parameter [0:0] IS_WCLK_INVERTED = 1'b0
) (
  output DOA,
  output DOB,
  output DOC,
  output DOD,
  output DOE,
  output DOF,
  output DOG,
  output DOH,
  input [5:0] ADDRA,
  input [5:0] ADDRB,
  input [5:0] ADDRC,
  input [5:0] ADDRD,
  input [5:0] ADDRE,
  input [5:0] ADDRF,
  input [5:0] ADDRG,
  input [5:0] ADDRH,
  input  DIA,
  input  DIB,
  input  DIC,
  input  DID,
  input  DIE,
  input  DIF,
  input  DIG,
  input  DIH,
  input WCLK,
  input WE
);

  reg [63:0] mem_a, mem_b, mem_c, mem_d, mem_e, mem_f, mem_g, mem_h;
  wire [5:0] ADDRH_dly, ADDRH_in;
  wire DIA_dly, DIB_dly, DIC_dly, DID_dly, DIE_dly, DIF_dly, DIG_dly, DIH_dly;
  wire DIA_in, DIB_in, DIC_in, DID_in, DIE_in, DIF_in, DIG_in, DIH_in;
  wire WCLK_dly, WE_dly;
  wire WCLK_in, WE_in;
`ifdef XIL_TIMING
  reg notifier;
`endif

  initial begin
    mem_a = INIT_A;
    mem_b = INIT_B;
    mem_c = INIT_C;
    mem_d = INIT_D;
    mem_e = INIT_E;
    mem_f = INIT_F;
    mem_g = INIT_G;
    mem_h = INIT_H;
  end

  always @(posedge WCLK_in)
    if (WE_in) begin
      mem_a[ADDRH_in] <= #100 DIA_in;
      mem_b[ADDRH_in] <= #100 DIB_in;
      mem_c[ADDRH_in] <= #100 DIC_in;
      mem_d[ADDRH_in] <= #100 DID_in;
      mem_e[ADDRH_in] <= #100 DIE_in;
      mem_f[ADDRH_in] <= #100 DIF_in;
      mem_g[ADDRH_in] <= #100 DIG_in;
      mem_h[ADDRH_in] <= #100 DIH_in;
  end

   assign  DOA = mem_a[ADDRA];
   assign  DOB = mem_b[ADDRB];
   assign  DOC = mem_c[ADDRC];
   assign  DOD = mem_d[ADDRD];
   assign  DOE = mem_e[ADDRE];
   assign  DOF = mem_f[ADDRF];
   assign  DOG = mem_g[ADDRG];
   assign  DOH = mem_h[ADDRH_in];

`ifdef XIL_TIMING
  always @(notifier) begin
      mem_a[ADDRH_in] <= 1'bx;
      mem_b[ADDRH_in] <= 1'bx;
      mem_c[ADDRH_in] <= 1'bx;
      mem_d[ADDRH_in] <= 1'bx;
      mem_e[ADDRH_in] <= 1'bx;
      mem_f[ADDRH_in] <= 1'bx;
      mem_g[ADDRH_in] <= 1'bx;
      mem_h[ADDRH_in] <= 1'bx;
  end
`endif

`ifndef XIL_TIMING
    assign DIA_dly = DIA;
    assign DIB_dly = DIB;
    assign DIC_dly = DIC;
    assign DID_dly = DID;
    assign DIE_dly = DIE;
    assign DIF_dly = DIF;
    assign DIG_dly = DIG;
    assign DIH_dly = DIH;
    assign ADDRH_dly = ADDRH;
    assign WCLK_dly = WCLK;
    assign WE_dly = WE;
`endif

    assign WCLK_in = WCLK_dly ^ IS_WCLK_INVERTED;
    assign DIA_in = DIA_dly;
    assign DIB_in = DIB_dly;
    assign DIC_in = DIC_dly;
    assign DID_in = DID_dly;
    assign DIE_in = DIE_dly;
    assign DIF_in = DIF_dly;
    assign DIG_in = DIG_dly;
    assign DIH_in = DIH_dly;
    assign ADDRH_in = ADDRH_dly;
    assign WE_in = WE_dly;
    
`ifdef XIL_TIMING
  specify
     (WCLK => DOA) = (0:0:0, 0:0:0);
     (WCLK => DOB) = (0:0:0, 0:0:0);
     (WCLK => DOC) = (0:0:0, 0:0:0);
     (WCLK => DOD) = (0:0:0, 0:0:0);
     (WCLK => DOE) = (0:0:0, 0:0:0);
     (WCLK => DOF) = (0:0:0, 0:0:0);
     (WCLK => DOG) = (0:0:0, 0:0:0);
     (WCLK => DOH) = (0:0:0, 0:0:0);
     (ADDRA *> DOA) = (0:0:0, 0:0:0);
     (ADDRB *> DOB) = (0:0:0, 0:0:0);
     (ADDRC *> DOC) = (0:0:0, 0:0:0);
     (ADDRD *> DOD) = (0:0:0, 0:0:0);
     (ADDRE *> DOE) = (0:0:0, 0:0:0);
     (ADDRF *> DOF) = (0:0:0, 0:0:0);
     (ADDRG *> DOG) = (0:0:0, 0:0:0);
     (ADDRH *> DOH) = (0:0:0, 0:0:0);

     $setuphold (posedge WCLK, posedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
     $setuphold (posedge WCLK, negedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
     $setuphold (posedge WCLK, posedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
     $setuphold (posedge WCLK, negedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
     $setuphold (posedge WCLK, posedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
     $setuphold (posedge WCLK, negedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
     $setuphold (posedge WCLK, posedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);
     $setuphold (posedge WCLK, negedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);
     $setuphold (posedge WCLK, posedge DIE &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIE_dly);
     $setuphold (posedge WCLK, negedge DIE &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIE_dly);
     $setuphold (posedge WCLK, posedge DIF &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIF_dly);
     $setuphold (posedge WCLK, negedge DIF &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIF_dly);
     $setuphold (posedge WCLK, posedge DIG &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIG_dly);
     $setuphold (posedge WCLK, negedge DIG &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIG_dly);
     $setuphold (posedge WCLK, posedge DIH &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIH_dly);
     $setuphold (posedge WCLK, negedge DIH &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIH_dly);
     $setuphold (posedge WCLK, posedge ADDRH[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[0]);
     $setuphold (posedge WCLK, negedge ADDRH[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[0]);
     $setuphold (posedge WCLK, posedge ADDRH[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[1]);
     $setuphold (posedge WCLK, negedge ADDRH[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[1]);
     $setuphold (posedge WCLK, posedge ADDRH[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[2]);
     $setuphold (posedge WCLK, negedge ADDRH[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[2]);
     $setuphold (posedge WCLK, posedge ADDRH[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[3]);
     $setuphold (posedge WCLK, negedge ADDRH[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[3]);
     $setuphold (posedge WCLK, posedge ADDRH[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[4]);
     $setuphold (posedge WCLK, negedge ADDRH[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[4]);
     $setuphold (posedge WCLK, posedge ADDRH[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[5]);
     $setuphold (posedge WCLK, negedge ADDRH[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[5]);
     $setuphold (posedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
     $setuphold (posedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
     $period (posedge WCLK &&& WE, 0:0:0, notifier);

     $setuphold (negedge WCLK, posedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
     $setuphold (negedge WCLK, negedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
     $setuphold (negedge WCLK, posedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
     $setuphold (negedge WCLK, negedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
     $setuphold (negedge WCLK, posedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
     $setuphold (negedge WCLK, negedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
     $setuphold (negedge WCLK, posedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);
     $setuphold (negedge WCLK, negedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);
     $setuphold (negedge WCLK, posedge DIE &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIE_dly);
     $setuphold (negedge WCLK, negedge DIE &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIE_dly);
     $setuphold (negedge WCLK, posedge DIF &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIF_dly);
     $setuphold (negedge WCLK, negedge DIF &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIF_dly);
     $setuphold (negedge WCLK, posedge DIG &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIG_dly);
     $setuphold (negedge WCLK, negedge DIG &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIG_dly);
     $setuphold (negedge WCLK, posedge DIH &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIH_dly);
     $setuphold (negedge WCLK, negedge DIH &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIH_dly);
     $setuphold (negedge WCLK, posedge ADDRH[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[0]);
     $setuphold (negedge WCLK, negedge ADDRH[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[0]);
     $setuphold (negedge WCLK, posedge ADDRH[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[1]);
     $setuphold (negedge WCLK, negedge ADDRH[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[1]);
     $setuphold (negedge WCLK, posedge ADDRH[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[2]);
     $setuphold (negedge WCLK, negedge ADDRH[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[2]);
     $setuphold (negedge WCLK, posedge ADDRH[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[3]);
     $setuphold (negedge WCLK, negedge ADDRH[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[3]);
     $setuphold (negedge WCLK, posedge ADDRH[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[4]);
     $setuphold (negedge WCLK, negedge ADDRH[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[4]);
     $setuphold (negedge WCLK, posedge ADDRH[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[5]);
     $setuphold (negedge WCLK, negedge ADDRH[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRH_dly[5]);
     $setuphold (negedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
     $setuphold (negedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
     $period (negedge WCLK &&& WE, 0:0:0, notifier);

     specparam PATHPULSE$ = 0;
  endspecify
`endif
endmodule
`endcelldefine
