/*******************************************************************************
 * Module: fifo_same_clock
 * Date:2014-05-20  
 * Author: Andrey Filippov
 * Description: Configurable synchronous FIFO using the same clock for read and write
 *
 * Copyright (c) 2014 Elphel, Inc.
 * fifo_same_clock.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  fifo_same_clock.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module fifo_same_clock
#(
  parameter integer DATA_WIDTH=16,
  parameter integer DATA_DEPTH=4
)
    (
  input                   rst,      // reset, active high
  input                   clk,      // clock - positive edge
  input                   we,       // write enable
  input                   re,       // read enable
  input  [DATA_WIDTH-1:0] data_in,  // input data
  output [DATA_WIDTH-1:0] data_out, // output data
  output reg              nempty,   // FIFO has some data
  output reg              full,     // FIFO full
  output reg              half_full // FIFO half full
  );
    localparam integer DATA_2DEPTH=(1<<DATA_DEPTH)-1;
    reg  [DATA_DEPTH  :0] fill=0;
    reg                   just_one=0;
    reg  [DATA_WIDTH-1:0] inreg;
    reg  [DATA_WIDTH-1:0] outreg;
    reg  [DATA_DEPTH-1:0] ra;
    reg  [DATA_DEPTH-1:0] wa;
    wire [DATA_DEPTH  :0] next_fill;
    reg  wem;
    wire rem;
    reg  out_full=0; //output register full
    reg  [DATA_WIDTH-1:0]   ram [0:DATA_2DEPTH];
//    assign next_fill = fill[4:0]+((we && ~re)?1:((~we && re)?5'b11111:5'b00000));
//    assign data_out  = just_one?inreg:outreg;
    assign data_out  = out_full?outreg:inreg;
    assign rem = (!out_full || re)&& (just_one? wem : re); 

 //   assign next_fill = fill[4:0]+((we && ~rem)?1:((~we && rem)?5'b11111:5'b00000));
 // TODO: verify rem is not needed instead of re
    assign next_fill = fill[4:0]+((we && ~re)?1:((~we && re)?5'b11111:5'b00000));


    always @ (posedge  clk or posedge  rst) begin
      if   (rst) fill <= 0;
      else if (we && ~re) fill <= fill+1;
      else if (~we && re) fill <= fill-1;
      if (rst)      wa <= 0;
      else if (wem) wa <= wa+1;
      if (rst)      ra <= 1; // 0;
      else if (re)  ra <= ra+1; //now ra is 1 ahead
      else if (!nempty) ra <= wa+1; // Just recover from bit errors TODO: fix
      
      if (rst)      nempty <= 0;
      else          nempty <= (next_fill != 0);

      if (rst)             out_full <= 0;
      else if (rem && ~re) out_full <= 1;
      else if (re && ~rem) out_full <= 0;
      
    end
    always @ (posedge  clk) begin
      if (wem) ram[wa] <= inreg;
      just_one <= (next_fill == 1);
      half_full <=(fill & (1<<(DATA_DEPTH-1)))!=0;
      full <=     (fill & (1<< DATA_DEPTH   ))!=0;
      if (we)  inreg  <= data_in;
      if (rem) outreg <= just_one?inreg:ram[ra];
      wem <= we;
    end
endmodule
