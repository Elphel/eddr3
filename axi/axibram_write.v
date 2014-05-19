/*******************************************************************************
 * Module: axibram_write
 * Date:2014-03-18  
 * Author: Andrey Filippov
 * Description: Read block RAM memory (or memories?) over AXI PS Master GP0
 * Memory is supposed to be fast enough
 *
 * Copyright (c) 2014 Elphel, Inc.
 * axibram_write.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  axibram_write.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
module  axibram_write #(
    parameter ADDRESS_BITS = 10 // number of memory address bits
)(
   input         aclk,    // clock - should be buffered
//   input         aresetn, // reset, active low
   input         rst,     // reset, active highw
   
// AXI Write Address
   input  [31:0] awaddr,  // AWADDR[31:0], input
   input         awvalid, // AWVALID, input
   output        awready, // AWREADY, output
   input  [11:0] awid,    // AWID[11:0], input
//   input  [ 1:0] awlock,  // AWLOCK[1:0], input
//   input  [ 3:0] awcache, // AWCACHE[3:0], input
//   input  [ 2:0] awprot,  // AWPROT[2:0], input
   input  [ 3:0] awlen,   // AWLEN[3:0], input
   input  [ 1:0] awsize,  // AWSIZE[1:0], input
   input  [ 1:0] awburst, // AWBURST[1:0], input
//   input  [ 3:0] awqos,   // AWQOS[3:0], input
// AXI PS Master GP0: Write Data
   input  [31:0] wdata,   // WDATA[31:0], input
   input         wvalid,  // WVALID, input
   output        wready,  // WREADY, output
   input  [11:0] wid,     // WID[11:0], input
   input         wlast,   // WLAST, input
   input  [ 3:0] wstb,    // WSTRB[3:0], input
// AXI PS Master GP0: Write Responce
   output        bvalid,  // BVALID, output
   input         bready,  // BREADY, input
   output [11:0] bid,     // BID[11:0], output
   output [ 1:0] bresp,    // BRESP[1:0], output
   
// BRAM (and other write modules) interface
   output [ADDRESS_BITS-1:0] pre_awaddr, // same as awaddr_out, early address to decode and return dev_ready
   output        start_burst, // start of write burst, valid pre_awaddr, save externally to control ext. dev_ready multiplexer
   input         dev_ready,   // extrernal combinatorial ready signal, multiplexed from different sources according to pre_awaddr@start_burst
    
   output        bram_wclk,
   output  [ADDRESS_BITS-1:0] bram_waddr,
   output        bram_wen,    // external memory wreite enable, (internally combined with registered dev_ready
   output  [3:0] bram_wstb, 
   output [31:0] bram_wdata
);
//    wire rst=~aresetn;
// **** Write channel: ****
    wire aw_nempty;
    wire aw_half_full;
    assign awready=~aw_half_full;
    wire [ 1:0] awburst_out;
    // SuppressWarnings VEditor all 
    wire [ 1:0] awsize_out; // not used
    wire [ 3:0] awlen_out;
    wire [ADDRESS_BITS-1:0] awaddr_out;
    // SuppressWarnings VEditor all 
    wire [11:0] awid_out;   // not used
    wire w_nempty;
    wire w_half_full;
    assign wready=~w_half_full;
    wire [31:0] wdata_out;
    // SuppressWarnings VEditor all 
    wire        wlast_out;   // not used
    wire [ 3:0] wstb_out;    // WSTRB[3:0], input
    wire [11:0] wid_out;
    reg         write_in_progress=0;
    reg  [ADDRESS_BITS-1:0] write_address;       // transfer address (not including lower bits 
    reg  [ 3:0] write_left;          // number of read transfers
// will ignore arsize - assuming always 32 bits  (a*size[2:0]==2)
    reg  [ 1:0] wburst;             // registered burst type
    reg  [ 3:0] wlen;               // registered awlen type (for wrapped over transfers)
    wire [ADDRESS_BITS-1:0] next_wr_address_w;  // next transfer address;
    wire        bram_we_w;          // write BRAM memory 
    wire        start_write_burst_w;
    wire        write_in_progress_w;
    reg         dev_ready_r;        // device, selected at start burst
    assign      next_wr_address_w=
      wburst[1]?
        (wburst[0]? {ADDRESS_BITS{1'b0}}:((write_address[ADDRESS_BITS-1:0]+1) & {{(ADDRESS_BITS-4){1'b1}}, ~wlen[3:0]})):
        (wburst[0]? (write_address[ADDRESS_BITS-1:0]+1):(write_address[ADDRESS_BITS-1:0]));
        
    assign      bram_we_w= w_nempty &&  write_in_progress && dev_ready_r;
    assign start_write_burst_w=aw_nempty && (!write_in_progress || (w_nempty && (write_left[3:0]==4'b0)));
    assign write_in_progress_w=aw_nempty || (write_in_progress && !(w_nempty && (write_left[3:0]==4'b0))); 
    
    always @ (posedge  aclk or posedge  rst) begin
      if   (rst)                    wburst[1:0] <= 0;
      else if (start_write_burst_w) wburst[1:0] <= awburst_out[1:0];

      if   (rst)                    wlen[3:0] <= 0;
      else if (start_write_burst_w) wlen[3:0] <= awlen_out[3:0];
    
      if   (rst) write_in_progress <= 0;
      else       write_in_progress <= write_in_progress_w;

      if   (rst) write_left <= 0;
      else if (start_write_burst_w) write_left <= awlen_out[3:0]; // precedence over inc
      else if (bram_we_w)           write_left <= write_left-1;
            
      if   (rst)                    write_address <= {ADDRESS_BITS{1'b0}};
      else if (start_write_burst_w) write_address <= awaddr_out[ADDRESS_BITS-1:0]; // precedence over inc
      else if (bram_we_w)           write_address <= next_wr_address_w;
      
      if (rst) dev_ready_r <= 1'b0;
      else     dev_ready_r <= dev_ready;
    end
// **** Write responce channel ****    
    wire [ 1:0] bresp_in;
    assign bresp_in=2'b0;
        
/*
   output        bvalid,  // BVALID, output
   input         bready,  // BREADY, input
   output [11:0] bid,     // BID[11:0], output
   output [ 1:0] bresp    // BRESP[1:0], output

*/
/*    
    reg bram_reg_re_r;
    always @ (posedge aclk) begin
        bram_reg_re_r <= bram_reg_re_w;
    end
*/

// external memory interface (write only)
   assign pre_awaddr=awaddr_out[ADDRESS_BITS-1:0];
   assign start_burst=start_write_burst_w;
   
   assign  bram_wclk  = aclk;
   assign  bram_waddr = write_address[ADDRESS_BITS-1:0];
   assign  bram_wen   = bram_we_w; 
   assign  bram_wstb   = wstb_out[3:0]; 
   assign  bram_wdata = wdata_out[31:0];
    
fifo_reg_W_D   #( .DATA_WIDTH(20+ADDRESS_BITS),.DATA_DEPTH(4))    
    waddr_i (
        .rst(rst),
        .clk(aclk),
        .we(awvalid && awready),
        .re(start_write_burst_w),
        .data_in({awid[11:0], awburst[1:0],awsize[1:0],awlen[3:0],awaddr[ADDRESS_BITS+1:2]}),
        .data_out({awid_out[11:0], awburst_out[1:0],awsize_out[1:0],awlen_out[3:0],awaddr_out[ADDRESS_BITS-1:0]}),
        .nempty(aw_nempty),
        .full(),
        .half_full(aw_half_full)
    );
fifo_reg_W_D   #( .DATA_WIDTH(49),.DATA_DEPTH(4))    
    wdata_i (
        .rst(rst),
        .clk(aclk),
        .we(wvalid && wready),
        .re(bram_we_w), //start_write_burst_w), // wrong
        .data_in({wid[11:0],wlast,wstb[3:0],wdata[31:0]}),
        .data_out({wid_out[11:0],wlast_out,wstb_out[3:0],wdata_out[31:0]}),
        .nempty(w_nempty),
        .full(),
        .half_full(w_half_full)
    );
fifo_reg_W_D  #( .DATA_WIDTH(14),.DATA_DEPTH(4))    
    wresp_i (
        .rst(rst),
        .clk(aclk),
        .we(bram_we_w),
        .re(bready && bvalid),
        .data_in({wid_out[11:0],bresp_in[1:0]}),
        .data_out({bid[11:0],bresp[1:0]}),
        .nempty(bvalid),
        .full(),
        .half_full()
    );

endmodule
