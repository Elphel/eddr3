///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2009 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.i (L.40)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                       Latch used as 2-input AND Gate
// /___/   /\     Filename : AND2B1L.v
// \   \  /  \    Timestamp : Wed Apr 22 17:10:55 PDT 2009
//  \___\/\___\
//
// Revision:
//    04/01/08 - Initial version.
//    04/14/09 - Invert SRI not DI (CR517897)
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision

`timescale  1 ps / 1 ps

`celldefine

module AND2B1L #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",
  `endif
  parameter [0:0] IS_SRI_INVERTED = 1'b0
)(
  output O,
  
  input DI,
  input SRI
);
  
    tri0 GSR = glbl.GSR;
    wire o_out, sri_b;
    wire SRI_in;


    assign O = (GSR) ? 0 : o_out;

    not A0 (sri_b, SRI_in);
    and A1 (o_out, sri_b, DI);

    assign SRI_in = IS_SRI_INVERTED ^ SRI;

`ifdef XIL_TIMING

  specify
                                                                                 
        (DI => O) = (0:0:0, 0:0:0);
        (SRI => O) = (0:0:0, 0:0:0);
        specparam PATHPULSE$ = 0;

  endspecify

`endif

endmodule

`endcelldefine
