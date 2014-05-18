/*
** -----------------------------------------------------------------------------**
** macros353.v
**
** I/O pads related circuitry
**
** Copyright (C) 2002 Elphel, Inc
**
** -----------------------------------------------------------------------------**
**  This file is part of X353
**  X353 is free software - hardware description language (HDL) code.
** 
**  This program is free software: you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation, either version 3 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License
**  along with this program.  If not, see <http://www.gnu.org/licenses/>.
** -----------------------------------------------------------------------------**
**
*/
// just make more convenient A[3:0] instead of 4 one-bit inputs
// TODO: Replace direct instances of SRL16 to imporve portability
/*
module MSRL16 (Q, A, CLK, D);
    output Q;
    input  [3:0] A;
    input  CLK, D;
    SRL16 i_q(.Q(Q), .A0(A[0]), .A1(A[1]), .A2(A[2]), .A3(A[3]), .CLK(CLK), .D(D));
endmodule


module MSRL16_1 (Q, A, CLK, D);
    output Q;
    input  [3:0] A;
    input  CLK, D;
    SRL16_1 i_q(.Q(Q), .A0(A[0]), .A1(A[1]), .A2(A[2]), .A3(A[3]), .CLK(CLK), .D(D));
endmodule
*/

/*
module myRAM_WxD_D(D,WE,clk,AW,AR,QW,QR);
parameter DATA_WIDTH=16;
parameter DATA_DEPTH=4;
parameter DATA_2DEPTH=(1<<DATA_DEPTH)-1;
    input	 [DATA_WIDTH-1:0]	D;
    input				WE,clk;
    input	 [DATA_DEPTH-1:0]	AW;
    input	 [DATA_DEPTH-1:0]	AR;
    output [DATA_WIDTH-1:0]	QW;
    output [DATA_WIDTH-1:0]	QR;
    reg	 [DATA_WIDTH-1:0]	ram [0:DATA_2DEPTH];
    always @ (posedge clk) if (WE) ram[AW] <= D; 
    assign	QW= ram[AW];
    assign	QR= ram[AR];
endmodule
*/
module ram_WxD
#(
  parameter integer DATA_WIDTH=16,
  parameter integer DATA_DEPTH=4,
  parameter integer DATA_2DEPTH=(1<<DATA_DEPTH)-1
)
    (
  input  [DATA_WIDTH-1:0] D,
  input                   WE,
  input                   clk,
  input  [DATA_DEPTH-1:0] AW,
  input  [DATA_DEPTH-1:0] AR,
  output [DATA_WIDTH-1:0] QW,
  output [DATA_WIDTH-1:0] QR);
  
    reg	 [DATA_WIDTH-1:0]	ram [0:DATA_2DEPTH];
    always @(posedge clk) if (WE) ram[AW] <= D; 
    assign	QW= ram[AW];
    assign	QR= ram[AR];
endmodule

/*
FIFO with minimal latency 1, uses 1 register slice on the data input, output - 1 mux after register
*/

module fifo_reg_W_D
#(
  parameter integer DATA_WIDTH=16,
  parameter integer DATA_DEPTH=4,
  parameter integer DATA_2DEPTH=(1<<DATA_DEPTH)-1
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
    reg  [DATA_DEPTH  :0] fill=0;
    reg                   just_one=0;
    reg  [DATA_WIDTH-1:0] inreg;
    reg  [DATA_WIDTH-1:0] outreg;
    reg  [DATA_DEPTH-1:0] ra;
    reg  [DATA_DEPTH-1:0] wa;
    wire [DATA_DEPTH  :0] next_fill;
    reg  wem;
    wire rem;
    reg  [DATA_WIDTH-1:0]   ram [0:DATA_2DEPTH];
//    wire  [DATA_DEPTH  :0] pre_next_fill= ((we && ~re)?1:((~we && re)?-1:0));
    assign next_fill = fill[4:0]+((we && ~re)?1:((~we && re)?5'b11111:5'b00000));
//    assign next_fill = fill+((we && ~re)?1:((~we && re)?-1:0));
//    assign next_fill[DATA_DEPTH  :0] = fill[DATA_DEPTH  :0]+pre_next_fill[DATA_DEPTH  :0];
//    assign next_fill[DATA_DEPTH  :0] = fill[DATA_DEPTH  :0]+1;
//    assign next_fill[DATA_DEPTH  :0] = fill[DATA_DEPTH  :0]+((we && ~re)?5'b1:0);
//    assign next_fill[4  :0] = fill[4  :0]+((we && ~re)?5'b1:0);
    assign data_out  = just_one?inreg:outreg;
    assign rem = just_one? wem : re; 
    always @ (posedge  clk or posedge  rst) begin
      if   (rst) fill <= 0;
//      else       fill <= next_fill;
//      else       fill <= fill+1;
//      else       fill <= fill[4  :0]+((we && ~re)?1:((~we && re)?-1:0));
//      else       fill <= fill[4  :0]+((we && ~re)?5'b00001:((~we && re)?5'b11111:5'b00000));
      else if (we && ~re) fill <= fill+1;
      else if (~we && re) fill <= fill-1;
      if (rst)      wa <= 0;
      else if (wem) wa <= wa+1;
      if (rst)      ra <= 1; // 0;
//      else if (re)  ra <= ra+1; //wrong?
//      else if (rem)  ra <= ra+1; //may be still wrong
      else if (re)  ra <= ra+1; //now ra is 1 ahead
      else if (!nempty) ra <= wa+1; // Just recover from bit errors TODO: fix
      
      if (rst)      nempty <= 0;
      else          nempty <= (next_fill != 0);
      
    end
    always @ (posedge  clk) begin
      if (wem) ram[wa] <= inreg;
      just_one <= (next_fill == 1);
//      nempty   <= (next_fill != 0);
      half_full <=(fill & (1<<(DATA_DEPTH-1)))!=0;
      full <=     (fill & (1<< DATA_DEPTH   ))!=0;
      if (we)  inreg  <= data_in;
      if (rem) outreg <= just_one?inreg:ram[ra];
      wem <= we;
    end
endmodule
//    tri0 GSR = glbl.GSR;
