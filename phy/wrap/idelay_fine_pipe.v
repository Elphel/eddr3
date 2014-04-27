/*******************************************************************************
 * Module: idelay_fine_pipe
 * Date:2014-04-25  
 * Author: Andrey Filippov
 * Description: IDELAYE2_FINEDELAY wrapper with fine control pipelined
 *
 * Copyright (c) 2014 Elphel, Inc.
 * idelay_fine_pipe.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  idelay_fine_pipe.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  idelay_fine_pipe
//SuppressWarnings VEditor - IODELAY_GRP used in (* *) construnt
# ( parameter  IODELAY_GRP  = "IODELAY_MEMORY",
    parameter integer DELAY_VALUE = 0,
    parameter real REFCLK_FREQUENCY = 200.0,
    parameter HIGH_PERFORMANCE_MODE    = "FALSE"
) (
    input clk,
    input rst,
    input set,
    input ld,
    input [7:0] delay,
    input data_in,
    output data_out
);
    
    reg [2:0] fdly_pre=DELAY_VALUE[2:0], fdly=DELAY_VALUE[2:0];
    always @ (posedge clk or posedge rst) begin
        if (rst)      fdly_pre <= DELAY_VALUE[2:0];
        else if (ld)  fdly_pre <= delay[2:0];
        if (rst)      fdly <= DELAY_VALUE[2:0];
        else if (set) fdly <= fdly_pre;
    end
(* IODELAY_GROUP = IODELAY_GRP *) IDELAYE2_FINEDELAY
     #(
        .CINVCTRL_SEL("FALSE"),
        .DELAY_SRC("IDATAIN"),
        .FINEDELAY("ADD_DLY"),
        .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE),
        .IDELAY_TYPE("VAR_LOAD_PIPE"),
        .IDELAY_VALUE(DELAY_VALUE>>3),
        .IS_C_INVERTED(1'b0),
        .IS_DATAIN_INVERTED(1'b0),
        .IS_IDATAIN_INVERTED(1'b0),
        .PIPE_SEL("TRUE"),
        .REFCLK_FREQUENCY(REFCLK_FREQUENCY),
        .SIGNAL_PATTERN("DATA")
    )
    idelay2_finedelay_i(
        .CNTVALUEOUT(),
        .DATAOUT(data_out),
        .C(clk),
        .CE(1'b0),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(delay[7:3]),
        .DATAIN(1'b0),
        .IDATAIN(data_in),
        .IFDLY(fdly),
        .INC(1'b0),
        .LD(set),
        .LDPIPEEN(ld),
        .REGRST(rst)
    );

endmodule

