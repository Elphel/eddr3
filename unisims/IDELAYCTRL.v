// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/virtex4/IDELAYCTRL.v,v 1.10 2007/07/25 18:30:30 fphillip Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Input Delay Controller
// /___/   /\     Filename : IDELAYCTRL.v
// \   \  /  \    Timestamp : Thu Mar 11 16:44:07 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter and initialized outpus.
//    04/10/07 - CR 436682 fix, disable activity when rst is high
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
// End Revision

`timescale 1 ps / 1 ps 

`celldefine

module IDELAYCTRL (RDY, REFCLK, RST);

    output RDY;


`ifdef XIL_TIMING

    parameter LOC = "UNPLACED";
    reg notifier;

`endif


    input REFCLK;
    input RST;

    wire refclk_in;
    wire rst_in;

    time clock_edge;
    reg [63:0] period;
    reg clock_low, clock_high;
    reg clock_posedge, clock_negedge;
    reg lost, rdy_out = 0;

    assign RDY = rdy_out;
    assign refclk_in = REFCLK;
    assign rst_in = RST;
    

    always @(rst_in, lost) begin

	if ((rst_in == 1'b1) || (lost == 1))
	    
	    rdy_out <= 1'b0;

	else if (rst_in == 1'b0 && lost == 0)

	    rdy_out <= 1'b1;

    end

   
    initial begin
	clock_edge <= 0;
	clock_high <= 0;
	clock_low <= 0;
	lost <= 1;
	period <= 0;
    end


    always @(posedge refclk_in) begin
      if(rst_in == 1'b0) begin
	clock_edge <= $time;
	if (period != 0 && (($time - clock_edge) <= (1.5 * period)))
	    period <= $time - clock_edge;
	else if (period != 0 && (($time - clock_edge) > (1.5 * period)))
	    period <= 0;
	else if ((period == 0) && (clock_edge != 0))
	    period <= $time - clock_edge;
      end
    end
    
    always @(posedge refclk_in) begin
	clock_low <= 1'b0;
	clock_high <= 1'b1;
	if (period != 0)
	    lost <= 1'b0;
	clock_posedge <= 1'b0;
	#((period * 9.1) / 10)
	if ((clock_low != 1'b1) && (clock_posedge != 1'b1))
	    lost <= 1;
    end
    
    always @(posedge refclk_in) begin
	clock_negedge <= 1'b1;
    end
    
    always @(negedge refclk_in) begin
	clock_posedge <= 1'b1;
    end
    
    always @(negedge refclk_in) begin
	clock_high  <= 1'b0;
	clock_low   <= 1'b1;
	if (period != 0)
	    lost <= 1'b0;
	clock_negedge <= 1'b0;
	#((period * 9.1) / 10)
	if ((clock_high != 1'b1) && (clock_negedge != 1'b1))
	    lost <= 1;
    end

//*** Timing Checks Start here


    specify

`ifdef XIL_TIMING

        (RST => RDY) = (0:0:0, 0:0:0);
	$period (posedge REFCLK, 0:0:0, notifier);

`endif
	
	(REFCLK => RDY) = (100:100:100, 100:100:100);
	specparam PATHPULSE$ = 0;
	
    endspecify

    
endmodule // IDELAYCTRL

`endcelldefine


