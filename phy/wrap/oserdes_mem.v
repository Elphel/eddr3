/*******************************************************************************
 * Module: oserdes_mem
 * Date:2014-04-26  
 * Author: Andrey Filippov
 * Description: OSERDESE2/OSERDESE1 wrapper to use for DDR3 memory w/o phasers
 *
 * Copyright (c) 2014 Elphel, Inc.
 * oserdes_mem.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  oserdes_mem.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps
//`define IVERILOG // uncomment just to chenck syntax (by the editor) in the corresponding branch
module  oserdes_mem(
    input        clk,      // serial output clock
    input        clk_div,  // oclk divided by 2, front aligned
    input        rst,      // reset
    input  [3:0] din,      // parallel data in
    input  [3:0] tin,      // parallel tri-state in
    output       dout_dly, // data out to be connected to odelay input
    output       dout_iob, // data out to be connected directly to the output buffer
    output       tout_dly, // tristate out to be connected to odelay input
    output       tout_iob  // tristate out to be connected directly to the tristate control of the output buffer
);
/*
    Serialized data will go through odelay elements (with fine delay adjustment), tristate output will
    go directly. Luckily the active time for DQ/DQS may be extended (there is at least 1 full clock period
    between READ and WRITE DQS active (more for DQ), so extending write preamble and postabmble by 1/2 period
    seems to be OK.
*/

`ifndef IVERILOG  // Not using simulator - instantiate actual ISERDESE2 (can not be simulated because of encrypted ) 
           OSERDESE2 #(
               .DATA_RATE_OQ         ("DDR"),
               .DATA_RATE_TQ         ("DDR"),
               .DATA_WIDTH           (4),
               .INIT_OQ              (1'b0),
               .INIT_TQ              (1'b0),
               .SERDES_MODE          ("MASTER"),
               .SRVAL_OQ             (1'b0),
               .SRVAL_TQ             (1'b0),
               .TRISTATE_WIDTH       (4),
               .TBYTE_CTL            ("FALSE"), 
               .TBYTE_SRC            ("FALSE")
            ) oserdes_i (
                .OFB                 (dout_dly),
                .OQ                  (dout_iob),
                .SHIFTOUT1           (),
                .SHIFTOUT2           (),
                .TFB                 (tout_dly),
                .TQ                  (tout_iob),
                .CLK                 (clk),
                .CLKDIV              (clk_div),
                .D1                  (din[0]),
                .D2                  (din[1]),
                .D3                  (din[2]),
                .D4                  (din[3]),
                .D5                  (),
                .D6                  (),
                .D7                  (),
                .D8                  (),
               .OCE                  (1'b1),
               .RST                  (rst),
               .SHIFTIN1             (),
               .SHIFTIN2             (),
               .T1                   (tin[0]),
               .T2                   (tin[1]),
               .T3                   (tin[2]),
               .T4                   (tin[3]),
               .TCE                  (1'b1),
               .TBYTEOUT             (),
               .TBYTEIN              ()
             );
`else // Simulating, use Virtex 6 module that does not have encrypted functionality
     OSERDESE1 #(
               .DATA_RATE_OQ         ("DDR"),
               .DATA_RATE_TQ         ("DDR"),
               .DATA_WIDTH           (4),
               .DDR3_DATA            (1), //For DDR3 DQ, DQS: 1, Address, ctrl, clock - 0
               .INIT_OQ              (1'b0),
               .INIT_TQ              (1'b0),
               .INTERFACE_TYPE       ("DEFAULT"), //"DEFAULT", "MEMORY_DDR3" 
               .ODELAY_USED          (0),         // 1 available only for MEMORY_DDR3
               .SERDES_MODE          ("MASTER"),
               .SRVAL_OQ             (1'b0),
               .SRVAL_TQ             (1'b0),
               .TRISTATE_WIDTH       (4)
            ) oserdes_i (
               .OFB                 (dout_dly),
               .OQ                  (dout_iob),
               .SHIFTOUT1           (),
               .SHIFTOUT2           (),
               .TFB                 (tout_dly),
               .TQ                  (tout_iob),
               .CLK                 (clk),
               .CLKDIV              (clk_div),
               .D1                  (din[0]),
               .D2                  (din[1]),
               .D3                  (din[2]),
               .D4                  (din[3]),
               .D5                  (),
               .D6                  (),
               .OCE                 (1'b1),
               .RST                 (rst),
               .SHIFTIN1            (),
               .SHIFTIN2            (),
               .T1                  (tin[0]),
               .T2                  (tin[1]),
               .T3                  (tin[2]),
               .T4                  (tin[3]),
               .TCE                 (1'b1),
               // not in OSERDES2E:
               .WC                  (1'b0),
               .OCBEXTEND           (),
               .CLKPERF             (1'b0),
               .CLKPERFDELAY        (1'b0),
               .ODV                 (1'b0)
             );
`endif
endmodule

