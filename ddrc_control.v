/*******************************************************************************
 * Module: ddrc_control
 * Date:2014-05-19  
 * Author: Andrey Filippov
 * Description: Temporary module with DDRC control / command registers
 *
 * Copyright (c) 2014 Elphel, Inc.
 * ddrc_control.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  ddrc_control.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  ddrc_control #(
    parameter AXI_WR_ADDR_BITS=   12,
    parameter SELECT_ADDR =      'h800, // address to select this module
    parameter SELECT_ADDR_MASK = 'h800, // address mask to select this  module
    parameter BUSY_ADDR =        'hc00, // address to generate busy
    parameter BUSY_ADDR_MASK =   'hc00  // address mask to generate busy
)(
    input                         clk,
    input                         mclk,
    input                         rst,
    input  [AXI_WR_ADDR_BITS-1:0] pre_waddr,     // AXI write address, before actual writes (to generate busy), valid@start_burst
    input                         start_wburst, // burst start - should generate ~ready (should be AND-ed with !busy internally) 
    input  [AXI_WR_ADDR_BITS-1:0] waddr,        // write address, valid with wr_en
    input                         wr_en,        // write enable 
    input                  [31:0] wdata,        // write data, valid with waddr and wr_en
    output                        busy,          // interface busy (combinatorial delay from start_wburst and pre_addr
// control signals
// control: sequencer run    
    output                 [10:0] run_addr, // Start address of the physical sequencer (MSB = 0 - "manual", 1 -"auto")
    output                 [ 3:0] run_chn,  // channel number to use for I/O buffers
    output                        run_seq,  // single mclk pulse to start sequencer
//    input                        run_done; // output - will go through other channel - sequencer done (add busy?)
// control: delays and mmcm setup    
    output                 [ 7:0] dly_data, // 8-bit IDELAY/ODELAY (fine) and MMCM phase shift
    output                 [ 6:0] dly_addr, // address to select delay register
    output                        ld_delay, // write dly_data to dly_address, one mclk active pulse
    output                        set,      // transfer (activate) all delays simultaneosly, 1 mclk pulse 
// control: additional signals
    output                        cmda_tri,    // tri-state all command and address lines to DDR chip
    output                        inv_clk_div, // invert clk_div to ISERDES
    output                 [ 7:0] dqs_pattern, // DQS pattern during write (normally 8'h55)
    output                 [ 7:0] dqm_pattern, // DQM pattern (just for testing, should be 8'h0)
// control: buffers pages
    output                 [ 1:0] port0_page,     // port 0 buffer read page (to be controlled by arbiter later, set to 2'b0)
    output                 [ 1:0] port0_int_page, // port 0 PHY-side write to buffer page (to be controlled by arbiter later, set to 2'b0)
    output                 [ 1:0] port1_page,     // port 1 buffer write page (to be controlled by arbiter later, set to 2'b0)
    output                 [ 1:0] port1_int_page  // port 1 PHY-side buffer read page (to be controlled by arbiter later, set to 2'b0) 

);
    reg busy_r=0;
    reg selected_r=0;
    
//    assign busy=busy_r && start_wburst?(((pre_addr ^ SELECT_ADDR) & SELECT_ADDR_MASK)==0): selected_r;
    assign busy=busy_r && start_wburst?(((pre_waddr ^ BUSY_ADDR) & BUSY_ADDR_MASK)==0): selected_r;

endmodule

