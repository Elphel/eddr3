///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 2011 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2012.4
//  \   \          Description : Xilinx Unified Simulation Library Component
//  /   /                     
// /___/   /\      Filename    : FIFO36E2.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  11/30/2012 - intial
//  12/12/2012 - yaml update, 691724 and 691715
//  02/07/2013 - 699628 - correction to DO_PIPELINED mode
//  02/28/2013 - update to keep in sync with RAMB models
//  03/18/2013 - 707083 reads should clear FULL when RD & WR in CDC.
//  03/22/2013 - sync5 yaml update, port ordering, *RSTBUSY
//  03/25/2013 - 707652 - RST = 1 n enters RST sequence but does not hold it there.
//  03/25/2013 - 707719 - Add sync5 cascade feature
//  03/27/2013 - 708820 - FULL flag deassert during WREN ind clocks.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module FIFO36E2 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE_ORDER = "NONE",
  parameter CLOCK_DOMAINS = "INDEPENDENT",
  parameter EN_ECC_PIPE = "FALSE",
  parameter EN_ECC_READ = "FALSE",
  parameter EN_ECC_WRITE = "FALSE",
  parameter FIRST_WORD_FALL_THROUGH = "FALSE",
  parameter [71:0] INIT = 72'h000000000000000000,
  parameter [0:0] IS_RDCLK_INVERTED = 1'b0,
  parameter [0:0] IS_RDEN_INVERTED = 1'b0,
  parameter [0:0] IS_RSTREG_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter [0:0] IS_WRCLK_INVERTED = 1'b0,
  parameter [0:0] IS_WREN_INVERTED = 1'b0,
  parameter integer PROG_EMPTY_THRESH = 256,
  parameter integer PROG_FULL_THRESH = 256,
  parameter RDCOUNT_TYPE = "RAW_PNTR",
  parameter integer READ_WIDTH = 4,
  parameter REGISTER_MODE = "UNREGISTERED",
  parameter RSTREG_PRIORITY = "RSTREG",
  parameter SLEEP_ASYNC = "FALSE",
  parameter [71:0] SRVAL = 72'h000000000000000000,
  parameter WRCOUNT_TYPE = "RAW_PNTR",
  parameter integer WRITE_WIDTH = 4
)(
  output [63:0] CASDOUT,
  output [7:0] CASDOUTP,
  output CASNXTEMPTY,
  output CASPRVRDEN,
  output DBITERR,
  output [63:0] DOUT,
  output [7:0] DOUTP,
  output [7:0] ECCPARITY,
  output EMPTY,
  output FULL,
  output PROGEMPTY,
  output PROGFULL,
  output [13:0] RDCOUNT,
  output RDERR,
  output RDRSTBUSY,
  output SBITERR,
  output [13:0] WRCOUNT,
  output WRERR,
  output WRRSTBUSY,

  input [63:0] CASDIN,
  input [7:0] CASDINP,
  input CASDOMUX,
  input CASDOMUXEN,
  input CASNXTRDEN,
  input CASOREGIMUX,
  input CASOREGIMUXEN,
  input CASPRVEMPTY,
  input [63:0] DIN,
  input [7:0] DINP,
  input INJECTDBITERR,
  input INJECTSBITERR,
  input RDCLK,
  input RDEN,
  input REGCE,
  input RST,
  input RSTREG,
  input SLEEP,
  input WRCLK,
  input WREN
);

// define constants
  localparam MODULE_NAME = "FIFO36E2";
  localparam in_delay     = 0;
  localparam out_delay    = 0;
  localparam inclk_delay  = 0;
  localparam outclk_delay = 0;

  localparam integer ADDR_WIDTH = 15;
  localparam integer INIT_WIDTH  = 72;
  localparam integer D_WIDTH  = 64;
  localparam integer DP_WIDTH = 8;

  localparam mem_width = 1;
  localparam memp_width = 1;
  localparam mem_depth = 32768;
  localparam memp_depth = 4096;
  localparam encode = 1'b1;
  localparam decode = 1'b0;

// Parameter encodings and registers
  localparam CASCADE_ORDER_FIRST  = 1;
  localparam CASCADE_ORDER_LAST   = 2;
  localparam CASCADE_ORDER_MIDDLE = 3;
  localparam CASCADE_ORDER_NONE   = 0;
  localparam CASCADE_ORDER_PARALLEL = 4;
  localparam CLOCK_DOMAINS_COMMON      = 1;
  localparam CLOCK_DOMAINS_INDEPENDENT = 0;
  localparam EN_ECC_PIPE_FALSE = 0;
  localparam EN_ECC_PIPE_TRUE  = 1;
  localparam EN_ECC_READ_FALSE = 0;
  localparam EN_ECC_READ_TRUE  = 1;
  localparam EN_ECC_WRITE_FALSE = 0;
  localparam EN_ECC_WRITE_TRUE  = 1;
  localparam FIRST_WORD_FALL_THROUGH_FALSE = 0;
  localparam FIRST_WORD_FALL_THROUGH_TRUE  = 1;
  localparam RDCOUNT_TYPE_EXTENDED_DATACOUNT  = 1;
  localparam RDCOUNT_TYPE_RAW_PNTR            = 0;
  localparam RDCOUNT_TYPE_SIMPLE_DATACOUNT    = 2;
  localparam RDCOUNT_TYPE_SYNC_PNTR           = 3;
  localparam READ_WIDTH_A_18 = 16;
  localparam READ_WIDTH_A_36 = 32;
  localparam READ_WIDTH_A_4  = 4;
  localparam READ_WIDTH_A_72 = 64;
  localparam READ_WIDTH_A_9  = 8;
  localparam REGISTER_MODE_DO_PIPELINED = 1;
  localparam REGISTER_MODE_REGISTERED   = 2;
  localparam REGISTER_MODE_UNREGISTERED = 0;
  localparam RSTREG_PRIORITY_REGCE  = 1;
  localparam RSTREG_PRIORITY_RSTREG = 0;
  localparam SLEEP_ASYNC_FALSE = 0;
  localparam SLEEP_ASYNC_TRUE  = 1;
  localparam WRCOUNT_TYPE_EXTENDED_DATACOUNT  = 1;
  localparam WRCOUNT_TYPE_RAW_PNTR            = 0;
  localparam WRCOUNT_TYPE_SIMPLE_DATACOUNT    = 2;
  localparam WRCOUNT_TYPE_SYNC_PNTR           = 3;
  localparam WRITE_WIDTH_18 = 16;
  localparam WRITE_WIDTH_36 = 32;
  localparam WRITE_WIDTH_4  = 4;
  localparam WRITE_WIDTH_72 = 64;
  localparam WRITE_WIDTH_9  = 8;

  `ifndef XIL_DR
  localparam [64:1] CASCADE_ORDER_REG = CASCADE_ORDER;
  localparam [88:1] CLOCK_DOMAINS_REG = CLOCK_DOMAINS;
  localparam [40:1] EN_ECC_PIPE_REG = EN_ECC_PIPE;
  localparam [40:1] EN_ECC_READ_REG = EN_ECC_READ;
  localparam [40:1] EN_ECC_WRITE_REG = EN_ECC_WRITE;
  localparam [40:1] FIRST_WORD_FALL_THROUGH_REG = FIRST_WORD_FALL_THROUGH;
  localparam [71:0] INIT_REG = INIT;
  localparam [0:0] IS_RDCLK_INVERTED_REG = IS_RDCLK_INVERTED;
  localparam [0:0] IS_RDEN_INVERTED_REG = IS_RDEN_INVERTED;
  localparam [0:0] IS_RSTREG_INVERTED_REG = IS_RSTREG_INVERTED;
  localparam [0:0] IS_RST_INVERTED_REG = IS_RST_INVERTED;
  localparam [0:0] IS_WRCLK_INVERTED_REG = IS_WRCLK_INVERTED;
  localparam [0:0] IS_WREN_INVERTED_REG = IS_WREN_INVERTED;
  localparam [12:0] PROG_EMPTY_THRESH_REG = PROG_EMPTY_THRESH;
  localparam [12:0] PROG_FULL_THRESH_REG = PROG_FULL_THRESH;
  localparam [144:1] RDCOUNT_TYPE_REG = RDCOUNT_TYPE;
  localparam [6:0] READ_WIDTH_REG = READ_WIDTH;
  localparam [96:1] REGISTER_MODE_REG = REGISTER_MODE;
  localparam [48:1] RSTREG_PRIORITY_REG = RSTREG_PRIORITY;
  localparam [40:1] SLEEP_ASYNC_REG = SLEEP_ASYNC;
  localparam [71:0] SRVAL_REG = SRVAL;
  localparam [144:1] WRCOUNT_TYPE_REG = WRCOUNT_TYPE;
  localparam [6:0] WRITE_WIDTH_REG = WRITE_WIDTH;
  `endif

  wire [2:0] CASCADE_ORDER_A_BIN;
  wire CLOCK_DOMAINS_BIN;
  wire EN_ECC_PIPE_BIN;
  wire EN_ECC_READ_BIN;
  wire EN_ECC_WRITE_BIN;
  wire FIRST_WORD_FALL_THROUGH_BIN;
  wire [INIT_WIDTH-1:0] INIT_BIN;
  wire IS_RDCLK_INVERTED_BIN;
  wire IS_RDEN_INVERTED_BIN;
  wire IS_RSTREG_INVERTED_BIN;
  wire IS_RST_INVERTED_BIN;
  wire IS_WRCLK_INVERTED_BIN;
  wire IS_WREN_INVERTED_BIN;
  wire [12:0] PROG_EMPTY_THRESH_BIN;
  wire [12:0] PROG_FULL_THRESH_BIN;
  wire [1:0] RDCOUNT_TYPE_BIN;
  wire [6:0] READ_WIDTH_A_BIN;
  wire [1:0] REGISTER_MODE_BIN;
  wire RSTREG_PRIORITY_BIN;
  wire SLEEP_ASYNC_BIN;
  wire [INIT_WIDTH-1:0] SRVAL_BIN;
  wire [1:0] WRCOUNT_TYPE_BIN;
  wire [6:0] WRITE_WIDTH_B_BIN;

  reg trig_gsr = 1'b0;
  tri0 glblGSR = glbl.GSR || trig_gsr;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;


// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "FIFO36E2_dr.v"
  `endif

  wire CASNXTEMPTY_out;
  wire CASPRVRDEN_out;
  wire DBITERR_out;
  wire EMPTY_out;
  wire FULL_out;
  reg  PROGEMPTY_out = 1;
  reg  PROGFULL_out = 0;
  reg  RDERR_out;
  wire RDRSTBUSY_out;
  wire SBITERR_out;
  reg  WRERR_out;
  wire WRRSTBUSY_out;
  wire [ADDR_WIDTH:0] RDCOUNT_out;
  wire [ADDR_WIDTH:0] WRCOUNT_out;
  wire [DP_WIDTH-1:0] CASDOUTP_out;
  wire [D_WIDTH-1:0] CASDOUT_out;
  wire [D_WIDTH-1:0] DOUT_out;
  wire [DP_WIDTH-1:0] DOUTP_out;
  wire [DP_WIDTH-1:0] ECCPARITY_out;

  wire CASNXTEMPTY_delay;
  wire CASPRVRDEN_delay;
  wire DBITERR_delay;
  wire EMPTY_delay;
  wire FULL_delay;
  wire PROGEMPTY_delay;
  wire PROGFULL_delay;
  wire RDERR_delay;
  wire RDRSTBUSY_delay;
  wire SBITERR_delay;
  wire WRERR_delay;
  wire WRRSTBUSY_delay;
  wire [ADDR_WIDTH:0] RDCOUNT_delay;
  wire [ADDR_WIDTH:0] WRCOUNT_delay;
  wire [D_WIDTH-1:0] CASDOUT_delay;
  wire [D_WIDTH-1:0] DOUT_delay;
  wire [DP_WIDTH-1:0] CASDOUTP_delay;
  wire [DP_WIDTH-1:0] DOUTP_delay;
  wire [DP_WIDTH-1:0] ECCPARITY_delay;

  wire CASDOMUXEN_A_in;
  wire CASDOMUXA_in;
//  wire CASNXTRDEN_in;
  wire CASOREGIMUXEN_A_in;
  wire CASOREGIMUXA_in;
  wire CASPRVEMPTY_in;
  wire INJECTDBITERR_in;
  wire INJECTSBITERR_in;
  wire RDCLK_in;
  wire RDEN_in;
  wire REGCE_in;
  wire RSTREG_in;
  wire RST_in;
  wire SLEEP_in;
  wire WRCLK_in;
  wire WREN_in;
  wire [D_WIDTH-1:0] CASDINA_in;
  wire [D_WIDTH-1:0] DIN_in;
  wire [DP_WIDTH-1:0] CASDINPA_in;
  wire [DP_WIDTH-1:0] DINP_in;

  wire CASDOMUXEN_delay;
  wire CASDOMUX_delay;
  wire CASNXTRDEN_delay;
  wire CASOREGIMUXEN_delay;
  wire CASOREGIMUX_delay;
  wire CASPRVEMPTY_delay;
  wire INJECTDBITERR_delay;
  wire INJECTSBITERR_delay;
  wire RDCLK_delay;
  wire RDEN_delay;
  wire REGCE_delay;
  wire RSTREG_delay;
  wire RST_delay;
  wire SLEEP_delay;
  wire WRCLK_delay;
  wire WREN_delay;
  wire [D_WIDTH-1:0] CASDIN_delay;
  wire [D_WIDTH-1:0] DIN_delay;
  wire [DP_WIDTH-1:0] CASDINP_delay;
  wire [DP_WIDTH-1:0] DINP_delay;

// internal variables, signals, busses
  integer i=0;
  integer j=0;
  integer k=0;
  integer ra=0;
  integer raa=0;
  integer wb=0;
  integer rd_loops_a = 1;
  integer wr_loops_b = 1;
  localparam max_rd_loops = D_WIDTH;
  localparam max_wr_loops = D_WIDTH;
  reg INIT_MEM = 0;
  integer rdcount_adj = 0;
  integer wrcount_adj = 0;
  integer wr_adj = 0;
  wire RDEN_lat;
  wire RDEN_reg;
  reg  fill_lat=0;
  reg  fill_reg=0;
  wire RDEN_ecc;
  reg  fill_ecc=0;
  wire SLEEP_int;
  reg  SLEEP_reg = 1'b0;
  reg  SLEEP_reg1 = 1'b0;
  wire RSTREG_A_int;
  wire REGCE_A_int;
  reg CASDOMUXA_reg = 1'b0;
  reg CASOREGIMUXA_reg = 1'b0;
  wire prog_empty;
  reg  ram_full_c = 0;
  wire ram_empty;
  reg  ram_empty_i = 1;
  reg  ram_empty_c = 1;
  reg  o_lat_empty = 1;
  reg  o_reg_empty = 1;
  reg  o_ecc_empty = 1;
  wire [1:0] output_stages;
  reg [6:0] error_bit = 7'b0;
  reg [DP_WIDTH-1:0] eccparity_reg = 8'h00;
  wire o_stages_full;
  wire o_stages_empty;
  reg  o_stages_full_sync=0;
  reg  o_stages_full_sync1=0;
  reg  o_stages_full_sync2=0;
  reg  o_stages_full_sync3=0;
  wire prog_full;
  wire [INIT_WIDTH-1:0] INIT_A_int;
  wire [INIT_WIDTH-1:0] SRVAL_A_int;

  wire mem_wr_clk_b;
  wire mem_wr_en_b;
  reg mem_wr_en_b_wf = 1'b0;
  wire [D_WIDTH-1:0] mem_we_b;
  wire [DP_WIDTH-1:0] memp_we_b;
  wire [D_WIDTH-1:0] mem_rm_douta;
  wire [DP_WIDTH-1:0] memp_rm_douta;
  wire mem_rd_clk_a;
  wire mem_rd_en_a;
  wire mem_rst_a;

  reg                     mem      [0 : mem_depth-1];
  reg  [D_WIDTH-1 : 0]  mem_rd_a;
  wire [D_WIDTH-1 : 0]  mem_wr_b;
  reg  wr_b_event = 1'b0;
  reg  [D_WIDTH-1 : 0]  mem_rd_b_rf;
  reg  [D_WIDTH-1 : 0]  mem_rd_b_wf;
  reg  [D_WIDTH-1 : 0]  mem_a_reg;
  wire [D_WIDTH-1 : 0]  mem_a_reg_mux;
  wire [D_WIDTH-1 : 0]  mem_a_mux;
  reg  [D_WIDTH-1 : 0]  mem_a_lat;
  wire [D_WIDTH-1 : 0]  mem_a_out;
  reg  [D_WIDTH-1 : 0]  mem_a_pipe;
  reg                     memp     [0 : memp_depth - 1];
  reg  [DP_WIDTH-1 : 0] memp_rd_a;
  wire [DP_WIDTH-1 : 0] memp_wr_b;
  reg  [DP_WIDTH-1 : 0] memp_rd_b_rf;
  reg  [DP_WIDTH-1 : 0] memp_rd_b_wf;
  reg  [DP_WIDTH-1 : 0]  memp_a_reg;
  wire [DP_WIDTH-1 : 0]  memp_a_reg_mux;
  wire [DP_WIDTH-1 : 0]  memp_a_mux;
  reg  [DP_WIDTH-1 : 0]  memp_a_lat;
  wire [DP_WIDTH-1 : 0]  memp_a_out;
  reg  [DP_WIDTH-1 : 0]  memp_a_pipe;
  wire dbit_int;
  wire sbit_int;
  reg dbit_lat = 0;
  reg sbit_lat = 0;
  reg dbit_pipe = 0;
  reg sbit_pipe = 0;
  reg dbit_reg = 0;
  reg sbit_reg = 0;
  wire [D_WIDTH-1 : 0]  mem_a_ecc;
  wire [D_WIDTH-1 : 0]  mem_a_ecc_cor;
  wire [DP_WIDTH-1 : 0]  memp_a_ecc;
  wire [DP_WIDTH-1 : 0]  memp_a_ecc_cor;
  wire dbit_ecc;
  wire sbit_ecc;
  wire [ADDR_WIDTH-1:0] wr_addr_b_mask;
  reg [ADDR_WIDTH-1:0] rd_addr_a = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_b = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_a_wr = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_b_rd = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_sync_wr = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_sync_wr3 = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_sync_wr2 = 0;
  reg [ADDR_WIDTH-1:0] rd_addr_sync_wr1 = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_sync_rd = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_sync_rd3 = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_sync_rd2 = 0;
  reg [ADDR_WIDTH-1:0] wr_addr_sync_rd1 = 0;
  wire [ADDR_WIDTH-1:0] rd_addr_wr;
  wire [ADDR_WIDTH-1:0] wr_addr_rd;
  wire [ADDR_WIDTH:0] wr_simple_raw;
  wire [ADDR_WIDTH:0] rd_simple_raw;
  wire [ADDR_WIDTH-1:0] wr_simple;
  wire [ADDR_WIDTH-1:0] rd_simple;
  reg  [ADDR_WIDTH-1:0] wr_simple_sync;
  reg  [ADDR_WIDTH-1:0] rd_simple_sync;
  
//reset logic variables
  reg WRRST_int = 1'b0;
  reg RST_sync = 1'b0;
  reg WRRST_done = 1'b0;
  reg WRRST_done1 = 1'b0;
  reg WRRST_done2 = 1'b0;
  wire RDRST_int;
  reg RDRST_done = 1'b0;
  reg RDRST_done1 = 1'b0;
  reg RDRST_done2 = 1'b0;
  wire WRRST_done_wr;
  reg WRRST_in_sync_rd = 1'b0;
  reg WRRST_in_sync_rd1 = 1'b0;
  reg WRRSTBUSY_dly = 1'b0;
  reg WRRSTBUSY_dly1 = 1'b0;
  reg RDRSTBUSY_dly = 1'b0;
  reg RDRSTBUSY_dly1 = 1'b0;
  reg RDRSTBUSY_dly2 = 1'b0;

  wire [7:0] synd_wr;
  wire [7:0] synd_rd;
  wire [7:0] synd_ecc;
  wire wrclk_ecc_out;

  reg sdp_mode = 1'b1;
  reg sdp_mode_wr = 1'b1;
  reg sdp_mode_rd = 1'b1;

// full/empty variables
  wire [ADDR_WIDTH-1:0] full_count;
  wire [ADDR_WIDTH-1:0] full_count_masked;
  wire [8:0] m_full;
  wire [8:0] m_full_raw;
  wire [5:0] n_empty;
  wire [5:0] unr_ratio;
  wire [ADDR_WIDTH+1:0] prog_full_val;
  wire [ADDR_WIDTH+1:0] prog_empty_val;

  reg ram_full_i;
  wire ram_one_from_full;
  wire ram_two_from_full;
  wire ram_one_read_from_not_full;

  wire [ADDR_WIDTH-1:0] empty_count;
  wire ram_one_read_from_empty;
  wire ram_one_write_from_not_empty;

reg en_clk_sync = 1'b0;

// define tasks, functions

function [7:0] fn_ecc (
   input encode,
   input [63:0] d_i,
   input [7:0] dp_i
   );
   reg ecc_7;
begin
   fn_ecc[0] = d_i[0]   ^  d_i[1]   ^  d_i[3]   ^  d_i[4]   ^  d_i[6]   ^
               d_i[8]   ^  d_i[10]  ^  d_i[11]  ^  d_i[13]  ^  d_i[15]  ^
               d_i[17]  ^  d_i[19]  ^  d_i[21]  ^  d_i[23]  ^  d_i[25]  ^
               d_i[26]  ^  d_i[28]  ^  d_i[30]  ^  d_i[32]  ^  d_i[34]  ^
               d_i[36]  ^  d_i[38]  ^  d_i[40]  ^  d_i[42]  ^  d_i[44]  ^
               d_i[46]  ^  d_i[48]  ^  d_i[50]  ^  d_i[52]  ^  d_i[54]  ^
               d_i[56]  ^  d_i[57]  ^  d_i[59]  ^  d_i[61]  ^  d_i[63];

   fn_ecc[1] = d_i[0]   ^  d_i[2]   ^  d_i[3]   ^  d_i[5]   ^  d_i[6]   ^
               d_i[9]   ^  d_i[10]  ^  d_i[12]  ^  d_i[13]  ^  d_i[16]  ^
               d_i[17]  ^  d_i[20]  ^  d_i[21]  ^  d_i[24]  ^  d_i[25]  ^
               d_i[27]  ^  d_i[28]  ^  d_i[31]  ^  d_i[32]  ^  d_i[35]  ^
               d_i[36]  ^  d_i[39]  ^  d_i[40]  ^  d_i[43]  ^  d_i[44]  ^
               d_i[47]  ^  d_i[48]  ^  d_i[51]  ^  d_i[52]  ^  d_i[55]  ^
               d_i[56]  ^  d_i[58]  ^  d_i[59]  ^  d_i[62]  ^  d_i[63];

   fn_ecc[2] = d_i[1]   ^  d_i[2]   ^  d_i[3]   ^  d_i[7]   ^  d_i[8]   ^
               d_i[9]   ^  d_i[10]  ^  d_i[14]  ^  d_i[15]  ^  d_i[16]  ^
               d_i[17]  ^  d_i[22]  ^  d_i[23]  ^  d_i[24]  ^  d_i[25]  ^
               d_i[29]  ^  d_i[30]  ^  d_i[31]  ^  d_i[32]  ^  d_i[37]  ^
               d_i[38]  ^  d_i[39]  ^  d_i[40]  ^  d_i[45]  ^  d_i[46]  ^
               d_i[47]  ^  d_i[48]  ^  d_i[53]  ^  d_i[54]  ^  d_i[55]  ^
               d_i[56]  ^  d_i[60]  ^  d_i[61]  ^  d_i[62]  ^  d_i[63];
   
   fn_ecc[3] = d_i[4]   ^  d_i[5]   ^  d_i[6]   ^  d_i[7]   ^  d_i[8]   ^
               d_i[9]   ^  d_i[10]  ^  d_i[18]  ^  d_i[19]  ^  d_i[20]  ^
               d_i[21]  ^  d_i[22]  ^  d_i[23]  ^  d_i[24]  ^  d_i[25]  ^
               d_i[33]  ^  d_i[34]  ^  d_i[35]  ^  d_i[36]  ^  d_i[37]  ^
               d_i[38]  ^  d_i[39]  ^  d_i[40]  ^  d_i[49]  ^  d_i[50]  ^
               d_i[51]  ^  d_i[52]  ^  d_i[53]  ^  d_i[54]  ^  d_i[55]  ^
               d_i[56];

   fn_ecc[4] = d_i[11]  ^  d_i[12]  ^  d_i[13]  ^  d_i[14]  ^  d_i[15]  ^
               d_i[16]  ^  d_i[17]  ^  d_i[18]  ^  d_i[19]  ^  d_i[20]  ^
               d_i[21]  ^  d_i[22]  ^  d_i[23]  ^  d_i[24]  ^  d_i[25]  ^
               d_i[41]  ^  d_i[42]  ^  d_i[43]  ^  d_i[44]  ^  d_i[45]  ^
               d_i[46]  ^  d_i[47]  ^  d_i[48]  ^  d_i[49]  ^  d_i[50]  ^
               d_i[51]  ^  d_i[52]  ^  d_i[53]  ^  d_i[54]  ^  d_i[55]  ^
               d_i[56];

   fn_ecc[5] = d_i[26]  ^  d_i[27]  ^  d_i[28]  ^  d_i[29]  ^  d_i[30]  ^
               d_i[31]  ^  d_i[32]  ^  d_i[33]  ^  d_i[34]  ^  d_i[35]  ^
               d_i[36]  ^  d_i[37]  ^  d_i[38]  ^  d_i[39]  ^  d_i[40]  ^
               d_i[41]  ^  d_i[42]  ^  d_i[43]  ^  d_i[44]  ^  d_i[45]  ^
               d_i[46]  ^  d_i[47]  ^  d_i[48]  ^  d_i[49]  ^  d_i[50]  ^
               d_i[51]  ^  d_i[52]  ^  d_i[53]  ^  d_i[54]  ^  d_i[55]  ^
               d_i[56];

   fn_ecc[6] = d_i[57]  ^  d_i[58]  ^  d_i[59]  ^  d_i[60]  ^  d_i[61]  ^
               d_i[62]  ^  d_i[63];

   ecc_7 = d_i[0]   ^  d_i[1]   ^  d_i[2]   ^  d_i[3]   ^ d_i[4]   ^
           d_i[5]   ^  d_i[6]   ^  d_i[7]   ^  d_i[8]   ^ d_i[9]   ^
           d_i[10]  ^  d_i[11]  ^  d_i[12]  ^  d_i[13]  ^ d_i[14]  ^
           d_i[15]  ^  d_i[16]  ^  d_i[17]  ^  d_i[18]  ^ d_i[19]  ^
           d_i[20]  ^  d_i[21]  ^  d_i[22]  ^  d_i[23]  ^ d_i[24]  ^
           d_i[25]  ^  d_i[26]  ^  d_i[27]  ^  d_i[28]  ^ d_i[29]  ^
           d_i[30]  ^  d_i[31]  ^  d_i[32]  ^  d_i[33]  ^ d_i[34]  ^
           d_i[35]  ^  d_i[36]  ^  d_i[37]  ^  d_i[38]  ^ d_i[39]  ^
           d_i[40]  ^  d_i[41]  ^  d_i[42]  ^  d_i[43]  ^ d_i[44]  ^
           d_i[45]  ^  d_i[46]  ^  d_i[47]  ^  d_i[48]  ^ d_i[49]  ^
           d_i[50]  ^  d_i[51]  ^  d_i[52]  ^  d_i[53]  ^ d_i[54]  ^
           d_i[55]  ^  d_i[56]  ^  d_i[57]  ^  d_i[58]  ^ d_i[59]  ^
           d_i[60]  ^  d_i[61]  ^  d_i[62]  ^  d_i[63];

   if (encode) begin
      fn_ecc[7] = ecc_7 ^
                  fn_ecc[0] ^ fn_ecc[1] ^ fn_ecc[2] ^ fn_ecc[3] ^
                  fn_ecc[4] ^ fn_ecc[5] ^ fn_ecc[6];
      end
   else begin
      fn_ecc[7] = ecc_7 ^
                  dp_i[0] ^ dp_i[1] ^ dp_i[2] ^ dp_i[3] ^
                  dp_i[4] ^ dp_i[5] ^ dp_i[6];
      end
end
endfunction // fn_ecc
                      
function [71:0] fn_cor_bit (
   input [6:0] error_bit,
   input [63:0] d_i,
   input [7:0] dp_i
   );
   reg [71:0] cor_int; 
begin
   cor_int = {d_i[63:57], dp_i[6], d_i[56:26], dp_i[5], d_i[25:11], dp_i[4],
              d_i[10:4], dp_i[3], d_i[3:1], dp_i[2], d_i[0], dp_i[1:0],
              dp_i[7]};
   cor_int[error_bit] = ~cor_int[error_bit];
   fn_cor_bit = {cor_int[0], cor_int[64], cor_int[32], cor_int[16],
                 cor_int[8], cor_int[4], cor_int[2:1], cor_int[71:65],
                 cor_int[63:33], cor_int[31:17], cor_int[15:9],
                 cor_int[7:5], cor_int[3]};
end
endfunction // fn_cor_bit


// input output assignments
  assign #(out_delay) CASDOUT = CASDOUT_delay;
  assign #(out_delay) CASDOUTP = CASDOUTP_delay;
  assign #(out_delay) CASNXTEMPTY = CASNXTEMPTY_delay;
  assign #(out_delay) CASPRVRDEN = CASPRVRDEN_delay;
  assign #(out_delay) DBITERR = DBITERR_delay;
  assign #(out_delay) DOUT = DOUT_delay;
  assign #(out_delay) DOUTP = DOUTP_delay;
  assign #(out_delay) ECCPARITY = ECCPARITY_delay;
  assign #(out_delay) EMPTY = EMPTY_delay;
  assign #(out_delay) FULL = FULL_delay;
  assign #(out_delay) PROGEMPTY = PROGEMPTY_delay;
  assign #(out_delay) PROGFULL = PROGFULL_delay;
  assign #(out_delay) RDCOUNT = RDCOUNT_delay;
  assign #(out_delay) RDERR = RDERR_delay;
  assign #(out_delay) RDRSTBUSY = RDRSTBUSY_delay;
  assign #(out_delay) SBITERR = SBITERR_delay;
  assign #(out_delay) WRCOUNT = WRCOUNT_delay;
  assign #(out_delay) WRERR = WRERR_delay;
  assign #(out_delay) WRRSTBUSY = WRRSTBUSY_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) RDCLK_delay = RDCLK;
  assign #(inclk_delay) WRCLK_delay = WRCLK;

  assign #(in_delay) CASDINP_delay = CASDINP;
  assign #(in_delay) CASDIN_delay = CASDIN;
  assign #(in_delay) CASDOMUXEN_delay = CASDOMUXEN;
  assign #(in_delay) CASDOMUX_delay = CASDOMUX;
  assign #(in_delay) CASNXTRDEN_delay = CASNXTRDEN;
  assign #(in_delay) CASOREGIMUXEN_delay = CASOREGIMUXEN;
  assign #(in_delay) CASOREGIMUX_delay = CASOREGIMUX;
  assign #(in_delay) CASPRVEMPTY_delay = CASPRVEMPTY;
  assign #(in_delay) DINP_delay = DINP;
  assign #(in_delay) DIN_delay = DIN;
  assign #(in_delay) INJECTDBITERR_delay = INJECTDBITERR;
  assign #(in_delay) INJECTSBITERR_delay = INJECTSBITERR;
  assign #(in_delay) RDEN_delay = RDEN;
  assign #(in_delay) REGCE_delay = REGCE;
  assign #(in_delay) RSTREG_delay = RSTREG;
  assign #(in_delay) RST_delay = RST;
  assign #(in_delay) SLEEP_delay = SLEEP;
  assign #(in_delay) WREN_delay = WREN;
`endif //  `ifndef XIL_TIMING

  assign CASDOUTP_delay = CASDOUTP_out;
  assign CASDOUT_delay = CASDOUT_out;
  assign CASNXTEMPTY_delay = CASNXTEMPTY_out;
  assign CASPRVRDEN_delay = CASPRVRDEN_out;
  assign DBITERR_delay = DBITERR_out;
  assign DOUTP_delay = DOUTP_out;
  assign DOUT_delay = DOUT_out;
  assign ECCPARITY_delay = ECCPARITY_out;
  assign EMPTY_delay = EMPTY_out;
  assign FULL_delay = FULL_out;
  assign PROGEMPTY_delay = PROGEMPTY_out;
  assign PROGFULL_delay = PROGFULL_out;
  assign RDCOUNT_delay = RDCOUNT_out;
  assign RDERR_delay = RDERR_out;
  assign RDRSTBUSY_delay = RDRSTBUSY_out;
  assign SBITERR_delay = SBITERR_out;
  assign WRCOUNT_delay = WRCOUNT_out;
  assign WRERR_delay = WRERR_out;
  assign WRRSTBUSY_delay = WRRSTBUSY_out;

  assign CASDINPA_in = CASDINP_delay;
  assign CASDINA_in = CASDIN_delay;
  assign CASDOMUXEN_A_in = CASDOMUXEN_delay;
  assign CASDOMUXA_in = CASDOMUX_delay;
//  assign CASNXTRDEN_in = CASNXTRDEN_delay;
  assign CASOREGIMUXEN_A_in = CASOREGIMUXEN_delay;
  assign CASOREGIMUXA_in = CASOREGIMUX_delay;
  assign CASPRVEMPTY_in = CASPRVEMPTY_delay;
  assign DINP_in = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                    (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?  CASDINP_delay : DINP_delay;
  assign DIN_in =  ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                    (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?  CASDIN_delay : DIN_delay;
  assign INJECTDBITERR_in = (EN_ECC_WRITE_BIN == EN_ECC_WRITE_FALSE) ? 1'b0 :
                            INJECTDBITERR_delay;
  assign INJECTSBITERR_in = (EN_ECC_WRITE_BIN == EN_ECC_WRITE_FALSE) ? 1'b0 :
                            INJECTSBITERR_delay || INJECTDBITERR_delay;
  assign RDCLK_in = ((CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) && (en_clk_sync == 1'b1)) ?
                    WRCLK_delay ^ IS_WRCLK_INVERTED_BIN :
                    RDCLK_delay ^ IS_RDCLK_INVERTED_BIN;
  assign RDEN_in = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                    (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                     CASNXTRDEN_delay : RDEN_delay ^ IS_RDEN_INVERTED_BIN;
  assign REGCE_in = REGCE_delay;
  assign RSTREG_in = RSTREG_delay ^ IS_RSTREG_INVERTED_BIN;
  assign RST_in = RST_delay ^ IS_RST_INVERTED_BIN;
  assign SLEEP_in = SLEEP_delay;
  assign WRCLK_in = WRCLK_delay ^ IS_WRCLK_INVERTED_BIN;
  assign WREN_in = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                    (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                    ~(CASPRVEMPTY_delay || FULL_out) : WREN_delay ^ IS_WREN_INVERTED_BIN;

  assign mem_rd_clk_a = RDCLK_in;
  assign mem_wr_clk_b = WRCLK_in;
  assign mem_wr_en_b  = WREN_in && ~FULL_out && ~WRRSTBUSY_out;
  assign mem_rd_en_a  = RDEN_lat && ~ram_empty && ~RDRST_int;

  wire [35:0] bit_err_pat;
  assign bit_err_pat = INJECTDBITERR_in ? 36'h400000004 : INJECTSBITERR_in ? 36'h000000004 : 36'h0;
  assign mem_wr_b = DIN_in ^ {bit_err_pat, 28'h0};
  assign memp_wr_b = (EN_ECC_WRITE_BIN == EN_ECC_WRITE_TRUE) ? synd_wr : DINP_in;

  initial begin
    trig_attr <= #1 ~trig_attr;
    INIT_MEM  <= #100 1'b1;
    INIT_MEM  <= #200 1'b0;
  end

  assign CASCADE_ORDER_A_BIN = 
    (CASCADE_ORDER_REG == "NONE") ? CASCADE_ORDER_NONE :
    (CASCADE_ORDER_REG == "FIRST") ? CASCADE_ORDER_FIRST :
    (CASCADE_ORDER_REG == "LAST") ? CASCADE_ORDER_LAST :
    (CASCADE_ORDER_REG == "MIDDLE") ? CASCADE_ORDER_MIDDLE :
    (CASCADE_ORDER_REG == "PARALLEL") ? CASCADE_ORDER_PARALLEL :
    CASCADE_ORDER_NONE;

  assign CLOCK_DOMAINS_BIN = 
    (CLOCK_DOMAINS_REG == "INDEPENDENT") ? CLOCK_DOMAINS_INDEPENDENT :
    (CLOCK_DOMAINS_REG == "COMMON") ? CLOCK_DOMAINS_COMMON :
    CLOCK_DOMAINS_INDEPENDENT;

  assign EN_ECC_PIPE_BIN = 
    (EN_ECC_PIPE_REG == "FALSE") ? EN_ECC_PIPE_FALSE :
    (EN_ECC_PIPE_REG == "TRUE") ? EN_ECC_PIPE_TRUE :
    EN_ECC_PIPE_FALSE;

  assign EN_ECC_READ_BIN = 
    (EN_ECC_READ_REG == "FALSE") ? EN_ECC_READ_FALSE :
    (EN_ECC_READ_REG == "TRUE") ? EN_ECC_READ_TRUE :
    EN_ECC_READ_FALSE;

  assign EN_ECC_WRITE_BIN = 
    (EN_ECC_WRITE_REG == "FALSE") ? EN_ECC_WRITE_FALSE :
    (EN_ECC_WRITE_REG == "TRUE") ? EN_ECC_WRITE_TRUE :
    EN_ECC_WRITE_FALSE;

  assign FIRST_WORD_FALL_THROUGH_BIN = 
    (FIRST_WORD_FALL_THROUGH_REG == "FALSE") ? FIRST_WORD_FALL_THROUGH_FALSE :
    (FIRST_WORD_FALL_THROUGH_REG == "TRUE") ? FIRST_WORD_FALL_THROUGH_TRUE :
    FIRST_WORD_FALL_THROUGH_FALSE;

  assign INIT_BIN = INIT_REG;

  assign IS_RDCLK_INVERTED_BIN = IS_RDCLK_INVERTED_REG;

  assign IS_RDEN_INVERTED_BIN = IS_RDEN_INVERTED_REG;

  assign IS_RSTREG_INVERTED_BIN = IS_RSTREG_INVERTED_REG;

  assign IS_RST_INVERTED_BIN = IS_RST_INVERTED_REG;

  assign IS_WRCLK_INVERTED_BIN = IS_WRCLK_INVERTED_REG;

  assign IS_WREN_INVERTED_BIN = IS_WREN_INVERTED_REG;

  assign PROG_EMPTY_THRESH_BIN = PROG_EMPTY_THRESH_REG;

  assign PROG_FULL_THRESH_BIN = PROG_FULL_THRESH_REG;

  assign RDCOUNT_TYPE_BIN = 
    (RDCOUNT_TYPE_REG == "RAW_PNTR") ? RDCOUNT_TYPE_RAW_PNTR :
    (RDCOUNT_TYPE_REG == "EXTENDED_DATACOUNT") ? RDCOUNT_TYPE_EXTENDED_DATACOUNT :
    (RDCOUNT_TYPE_REG == "SIMPLE_DATACOUNT") ? RDCOUNT_TYPE_SIMPLE_DATACOUNT :
    (RDCOUNT_TYPE_REG == "SYNC_PNTR") ? RDCOUNT_TYPE_SYNC_PNTR :
    RDCOUNT_TYPE_RAW_PNTR;

  assign READ_WIDTH_A_BIN = 
    (READ_WIDTH_REG == 4) ? READ_WIDTH_A_4 :
    (READ_WIDTH_REG == 9) ? READ_WIDTH_A_9 :
    (READ_WIDTH_REG == 18) ? READ_WIDTH_A_18 :
    (READ_WIDTH_REG == 36) ? READ_WIDTH_A_36 :
    (READ_WIDTH_REG == 72) ? READ_WIDTH_A_72 :
    READ_WIDTH_A_4;

  assign REGISTER_MODE_BIN = 
    (REGISTER_MODE_REG == "UNREGISTERED") ? REGISTER_MODE_UNREGISTERED :
    (REGISTER_MODE_REG == "DO_PIPELINED") ? REGISTER_MODE_DO_PIPELINED :
    (REGISTER_MODE_REG == "REGISTERED") ? REGISTER_MODE_REGISTERED :
    REGISTER_MODE_UNREGISTERED;

  assign RSTREG_PRIORITY_BIN = 
    (RSTREG_PRIORITY_REG == "RSTREG") ? RSTREG_PRIORITY_RSTREG :
    (RSTREG_PRIORITY_REG == "REGCE") ? RSTREG_PRIORITY_REGCE :
    RSTREG_PRIORITY_RSTREG;

  assign SLEEP_ASYNC_BIN = 
    (SLEEP_ASYNC_REG == "FALSE") ? SLEEP_ASYNC_FALSE :
    (SLEEP_ASYNC_REG == "TRUE") ? SLEEP_ASYNC_TRUE :
    SLEEP_ASYNC_FALSE;

  assign SRVAL_BIN = SRVAL_REG;
  assign WRCOUNT_TYPE_BIN = 
    (WRCOUNT_TYPE_REG == "RAW_PNTR") ? WRCOUNT_TYPE_RAW_PNTR :
    (WRCOUNT_TYPE_REG == "EXTENDED_DATACOUNT") ? WRCOUNT_TYPE_EXTENDED_DATACOUNT :
    (WRCOUNT_TYPE_REG == "SIMPLE_DATACOUNT") ? WRCOUNT_TYPE_SIMPLE_DATACOUNT :
    (WRCOUNT_TYPE_REG == "SYNC_PNTR") ? WRCOUNT_TYPE_SYNC_PNTR :
    WRCOUNT_TYPE_RAW_PNTR;

  assign WRITE_WIDTH_B_BIN = 
    (WRITE_WIDTH_REG == 4) ? WRITE_WIDTH_4 :
    (WRITE_WIDTH_REG == 9) ? WRITE_WIDTH_9 :
    (WRITE_WIDTH_REG == 18) ? WRITE_WIDTH_18 :
    (WRITE_WIDTH_REG == 36) ? WRITE_WIDTH_36 :
    (WRITE_WIDTH_REG == 72) ? WRITE_WIDTH_72 :
    WRITE_WIDTH_4;

  always @ (trig_attr) begin
    #1;
    if ((CASCADE_ORDER_REG != "NONE") &&
        (CASCADE_ORDER_REG != "FIRST") &&
        (CASCADE_ORDER_REG != "LAST") &&
        (CASCADE_ORDER_REG != "MIDDLE") &&
        (CASCADE_ORDER_REG != "PARALLEL")) begin
        $display("Attribute Syntax Error : The attribute CASCADE_ORDER on %s instance %m is set to %s.  Legal values for this attribute are NONE, FIRST, LAST, MIDDLE or PARALLEL.", MODULE_NAME, CASCADE_ORDER_REG);
        attr_err = 1'b1;
      end

    if ((CLOCK_DOMAINS_REG != "INDEPENDENT") &&
        (CLOCK_DOMAINS_REG != "COMMON")) begin
        $display("Attribute Syntax Error : The attribute CLOCK_DOMAINS on %s instance %m is set to %s.  Legal values for this attribute are INDEPENDENT or COMMON.", MODULE_NAME, CLOCK_DOMAINS_REG);
        attr_err = 1'b1;
      end

    if ((EN_ECC_PIPE_REG != "FALSE") &&
        (EN_ECC_PIPE_REG != "TRUE")) begin
        $display("Attribute Syntax Error : The attribute EN_ECC_PIPE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_ECC_PIPE_REG);
        attr_err = 1'b1;
      end

    if ((EN_ECC_READ_REG != "FALSE") &&
        (EN_ECC_READ_REG != "TRUE")) begin
        $display("Attribute Syntax Error : The attribute EN_ECC_READ on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_ECC_READ_REG);
        attr_err = 1'b1;
      end

    if ((EN_ECC_WRITE_REG != "FALSE") &&
        (EN_ECC_WRITE_REG != "TRUE")) begin
        $display("Attribute Syntax Error : The attribute EN_ECC_WRITE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, EN_ECC_WRITE_REG);
        attr_err = 1'b1;
      end

    if ((FIRST_WORD_FALL_THROUGH_REG != "FALSE") &&
        (FIRST_WORD_FALL_THROUGH_REG != "TRUE")) begin
        $display("Attribute Syntax Error : The attribute FIRST_WORD_FALL_THROUGH on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, FIRST_WORD_FALL_THROUGH_REG);
        attr_err = 1'b1;
      end

    if ((IS_RDCLK_INVERTED_REG < 1'b0) || (IS_RDCLK_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RDCLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RDCLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RDEN_INVERTED_REG < 1'b0) || (IS_RDEN_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RDEN_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RDEN_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RSTREG_INVERTED_REG < 1'b0) || (IS_RSTREG_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RSTREG_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RSTREG_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RST_INVERTED_REG < 1'b0) || (IS_RST_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_RST_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RST_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_WRCLK_INVERTED_REG < 1'b0) || (IS_WRCLK_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_WRCLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_WRCLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_WREN_INVERTED_REG < 1'b0) || (IS_WREN_INVERTED_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute IS_WREN_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_WREN_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > 8191)) begin
       $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to 8191.", MODULE_NAME, PROG_EMPTY_THRESH_REG);
       attr_err = 1'b1;
    end

    if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > 8191)) begin
      $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to 8191.", MODULE_NAME, PROG_FULL_THRESH_REG);
      attr_err = 1'b1;
    end

    if ((RDCOUNT_TYPE_REG != "RAW_PNTR") &&
        (RDCOUNT_TYPE_REG != "EXTENDED_DATACOUNT") &&
        (RDCOUNT_TYPE_REG != "SIMPLE_DATACOUNT") &&
        (RDCOUNT_TYPE_REG != "SYNC_PNTR")) begin
        $display("Attribute Syntax Error : The attribute RDCOUNT_TYPE on %s instance %m is set to %s.  Legal values for this attribute are RAW_PNTR, EXTENDED_DATACOUNT, SIMPLE_DATACOUNT or SYNC_PNTR.", MODULE_NAME, RDCOUNT_TYPE_REG);
        attr_err = 1'b1;
      end

    if ((READ_WIDTH_REG != 4) &&
        (READ_WIDTH_REG != 9) &&
        (READ_WIDTH_REG != 18) &&
        (READ_WIDTH_REG != 36) &&
        (READ_WIDTH_REG != 72)) begin
      $display("Attribute Syntax Error : The attribute READ_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 4, 9 18, 36 or 72.", MODULE_NAME, READ_WIDTH_REG);
      attr_err = 1'b1;
    end

    if ((REGISTER_MODE_REG != "UNREGISTERED") &&
        (REGISTER_MODE_REG != "DO_PIPELINED") &&
        (REGISTER_MODE_REG != "REGISTERED")) begin
      $display("Attribute Syntax Error : The attribute REGISTER_MODE on %s instance %m is set to %s.  Legal values for this attribute are UNREGISTERED, DO_PIPELINED or REGISTERED.", MODULE_NAME, REGISTER_MODE_REG);
      attr_err = 1'b1;
    end

    if ((RSTREG_PRIORITY_REG != "RSTREG") &&
        (RSTREG_PRIORITY_REG != "REGCE")) begin
      $display("Attribute Syntax Error : The attribute RSTREG_PRIORITY on %s instance %m is set to %s.  Legal values for this attribute are RSTREG or REGCE.", MODULE_NAME, RSTREG_PRIORITY_REG);
      attr_err = 1'b1;
    end

    if ((SLEEP_ASYNC_REG != "FALSE") &&
        (SLEEP_ASYNC_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute SLEEP_ASYNC on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, SLEEP_ASYNC_REG);
      attr_err = 1'b1;
    end

    if ((WRCOUNT_TYPE_REG != "RAW_PNTR") &&
        (WRCOUNT_TYPE_REG != "EXTENDED_DATACOUNT") &&
        (WRCOUNT_TYPE_REG != "SIMPLE_DATACOUNT") &&
        (WRCOUNT_TYPE_REG != "SYNC_PNTR")) begin
      $display("Attribute Syntax Error : The attribute WRCOUNT_TYPE on %s instance %m is set to %s.  Legal values for this attribute are RAW_PNTR, EXTENDED_DATACOUNT, SIMPLE_DATACOUNT or SYNC_PNTR.", MODULE_NAME, WRCOUNT_TYPE_REG);
      attr_err = 1'b1;
    end

    if ((WRITE_WIDTH_REG != 4) &&
        (WRITE_WIDTH_REG != 9) &&
        (WRITE_WIDTH_REG != 18) &&
        (WRITE_WIDTH_REG != 36) &&
        (WRITE_WIDTH_REG != 72)) begin
      $display("Attribute Syntax Error : The attribute WRITE_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 4, 9, 18, 36 or 72.", MODULE_NAME, WRITE_WIDTH_REG);
      attr_err = 1'b1;
    end

    case (READ_WIDTH_REG)
       4  : begin
            if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > mem_depth/4)) begin
               $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_EMPTY_THRESH_REG, mem_depth/4);
               attr_err = 1'b1;
            end
         end
       9  : begin
            if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > mem_depth/8)) begin
               $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_EMPTY_THRESH_REG, mem_depth/8);
               attr_err = 1'b1;
            end
         end
       18 : begin
            if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > mem_depth/16)) begin
               $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_EMPTY_THRESH_REG, mem_depth/16);
               attr_err = 1'b1;
            end
         end
       36 : begin
            if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > mem_depth/32)) begin
               $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_EMPTY_THRESH_REG, mem_depth/32);
               attr_err = 1'b1;
            end
         end
       72 : begin
            if ((PROG_EMPTY_THRESH_REG < 1) || (PROG_EMPTY_THRESH_REG > mem_depth/64)) begin
               $display("Attribute Syntax Error : The attribute PROG_EMPTY_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_EMPTY_THRESH_REG, mem_depth/64);
               attr_err = 1'b1;
            end
         end
       default : begin
            $display("Attribute Syntax Error : The attribute READ_WIDTH on %s instance %m is out of range on PROG_EMPTY_THRESH check.", MODULE_NAME);
            attr_err = 1'b1;
            end
    endcase

    case (WRITE_WIDTH_REG)
       4  : begin
            if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > mem_depth/4)) begin
               $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_FULL_THRESH_REG, mem_depth/4);
               attr_err = 1'b1;
            end
         end
       9  : begin
            if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > mem_depth/8)) begin
               $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_FULL_THRESH_REG, mem_depth/8);
               attr_err = 1'b1;
            end
         end
       18 : begin
            if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > mem_depth/16)) begin
               $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_FULL_THRESH_REG, mem_depth/16);
               attr_err = 1'b1;
            end
         end
       36 : begin
            if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > mem_depth/32)) begin
               $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_FULL_THRESH_REG, mem_depth/32);
               attr_err = 1'b1;
            end
         end
       72 : begin
            if ((PROG_FULL_THRESH_REG < 1) || (PROG_FULL_THRESH_REG > mem_depth/64)) begin
               $display("Attribute Syntax Error : The attribute PROG_FULL_THRESH on %s instance %m is set to %d.  Legal values for this attribute are  1 to %d.", MODULE_NAME, PROG_FULL_THRESH_REG, mem_depth/64);
               attr_err = 1'b1;
            end
         end
       default : begin
            $display("Attribute Syntax Error : The attribute WRITE_WIDTH on %s instance %m is out of range on PROG_FULL_THRESH check.", MODULE_NAME);
            attr_err = 1'b1;
            end
    endcase

    if (attr_err == 1'b1) $finish;
  end

  assign output_stages = 
         ((EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) &&
          (REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) &&
          (FIRST_WORD_FALL_THROUGH_BIN == FIRST_WORD_FALL_THROUGH_TRUE)) ? 2'b11 :
         ((EN_ECC_PIPE_BIN != EN_ECC_PIPE_TRUE) &&
          (REGISTER_MODE_BIN != REGISTER_MODE_REGISTERED) &&
          (FIRST_WORD_FALL_THROUGH_BIN != FIRST_WORD_FALL_THROUGH_TRUE)) ? 2'b00 :
         ((EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) ^
          (REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) ^
          (FIRST_WORD_FALL_THROUGH_BIN == FIRST_WORD_FALL_THROUGH_TRUE)) ? 2'b01 : 2'b10;

  assign wr_addr_b_mask = 
    (WRITE_WIDTH_REG == 4) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h3c} :
    (WRITE_WIDTH_REG == 9) ?  {{ADDR_WIDTH-6{1'b1}}, 6'h38} :
    (WRITE_WIDTH_REG == 18) ? {{ADDR_WIDTH-6{1'b1}}, 6'h30} :
    (WRITE_WIDTH_REG == 36) ? {{ADDR_WIDTH-6{1'b1}}, 6'h20} :
    (WRITE_WIDTH_REG == 72) ? {{ADDR_WIDTH-6{1'b1}}, 6'h00} :
    {{ADDR_WIDTH-6{1'b1}}, 6'h3f};

  always @(READ_WIDTH_A_BIN) rd_loops_a <= READ_WIDTH_A_BIN;
  always @(WRITE_WIDTH_B_BIN) wr_loops_b <= WRITE_WIDTH_B_BIN;

    always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) begin
          SLEEP_reg <= 1'b0;
          SLEEP_reg1 <= 1'b0;
      end
      else begin
          SLEEP_reg <= SLEEP_in;
          SLEEP_reg1 <= SLEEP_reg;
      end
    end

    assign SLEEP_int = (SLEEP_ASYNC_BIN == SLEEP_ASYNC_FALSE) ? SLEEP_reg : SLEEP_in;

   assign REGCE_A_int  = (REGISTER_MODE_BIN != REGISTER_MODE_DO_PIPELINED) ? RDEN_reg : 
                         REGCE_in;
   assign RSTREG_A_int = (REGISTER_MODE_BIN != REGISTER_MODE_DO_PIPELINED) ? RDRST_int :
                         (RSTREG_PRIORITY_BIN == RSTREG_PRIORITY_RSTREG) ? RSTREG_in :
                         (RSTREG_in && REGCE_A_int);
   assign RDEN_lat   = RDEN_in || fill_reg || fill_ecc || fill_lat;
   assign RDEN_ecc   = (RDEN_in || fill_reg || fill_ecc) && (EN_ECC_READ_BIN == EN_ECC_READ_TRUE);
   assign RDEN_reg   = RDEN_in || fill_reg ;
   assign DOUT_out  = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                        (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                        (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXA_reg) ?
                      CASDINA_in  : mem_a_mux ^ mem_rm_douta;
   assign DOUTP_out = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                        (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                        (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) && CASDOMUXA_reg) ?
                      CASDINPA_in : memp_a_mux ^ memp_rm_douta;
   assign mem_a_mux  = ((REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) ||
                        (REGISTER_MODE_BIN == REGISTER_MODE_DO_PIPELINED)) ?
                       mem_a_reg : mem_a_lat;
   assign memp_a_mux = ((REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) ||
                        (REGISTER_MODE_BIN == REGISTER_MODE_DO_PIPELINED)) ?
                       memp_a_reg : memp_a_lat;
   assign ECCPARITY_out = eccparity_reg;
   assign mem_a_ecc = (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) ? mem_a_pipe : mem_a_ecc_cor;
   assign memp_a_ecc = (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) ? memp_a_pipe : memp_a_ecc_cor;
   assign dbit_ecc = (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) ? dbit_pipe : dbit_int;
   assign sbit_ecc = (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE) ? sbit_pipe : sbit_int;
   assign DBITERR_out = ((REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) ||
             (REGISTER_MODE_BIN == REGISTER_MODE_DO_PIPELINED)) ? dbit_reg : dbit_lat;
   assign SBITERR_out = ((REGISTER_MODE_BIN == REGISTER_MODE_REGISTERED) ||
             (REGISTER_MODE_BIN == REGISTER_MODE_DO_PIPELINED)) ? sbit_reg : sbit_lat;
   assign INIT_A_int =
    (READ_WIDTH_A_BIN == READ_WIDTH_A_9)  ? {{8{INIT_BIN[8]}}, {8{INIT_BIN[7:0]}}} :
    (READ_WIDTH_A_BIN == READ_WIDTH_A_18) ? {{4{INIT_BIN[17:16]}}, {4{INIT_BIN[15:0]}}} :
    (READ_WIDTH_A_BIN == READ_WIDTH_A_36) ? {{2{INIT_BIN[35:32]}}, {2{INIT_BIN[31:0]}}} :
     INIT_BIN;

   assign SRVAL_A_int =
    (READ_WIDTH_A_BIN == READ_WIDTH_A_9)  ? {{8{SRVAL_BIN[8]}}, {8{SRVAL_BIN[7:0]}}} :
    (READ_WIDTH_A_BIN == READ_WIDTH_A_18) ? {{4{SRVAL_BIN[17:16]}}, {4{SRVAL_BIN[15:0]}}}:
    (READ_WIDTH_A_BIN == READ_WIDTH_A_36) ? {{2{SRVAL_BIN[35:32]}}, {2{SRVAL_BIN[31:0]}}}:
     SRVAL_BIN;


   assign rd_addr_wr = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? rd_addr_a : rd_addr_sync_wr;
   assign wr_addr_rd = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? wr_addr_b : wr_addr_sync_rd;
   assign o_stages_empty =
         (output_stages==2'b00) ? ram_empty :
         (output_stages==2'b01) ? o_lat_empty :
         (output_stages==2'b11) ? o_reg_empty : // FWFT + ECC + REG        // FWFT + REG
        ((output_stages==2'b10) && (EN_ECC_PIPE_BIN == EN_ECC_PIPE_FALSE)) ? o_reg_empty :
          o_ecc_empty; // 2 FWFT + ECC or REG + ECC
   assign o_stages_full = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? ~o_stages_empty : o_stages_full_sync;

// cascade out
   assign CASDOUT_out     = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                             DOUT_out : {D_WIDTH-1{1'b0}};
   assign CASDOUTP_out    = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                             DOUTP_out : {DP_WIDTH-1{1'b0}};
   assign CASNXTEMPTY_out = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_FIRST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                             EMPTY_out : 1'b0;
   assign CASPRVRDEN_out  = ((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) ?
                             ~(CASPRVEMPTY_in || FULL_out) : 1'b0;

// start model internals

// integers / constants
  always begin
     if (rd_loops_a>=wr_loops_b) wr_adj = rd_loops_a/wr_loops_b;
     else wr_adj = 1;
     @(wr_loops_b or rd_loops_a);
  end

  always begin
     if (((wr_loops_b>=rd_loops_a) && (output_stages==0)) ||
         ((wr_loops_b>=output_stages*rd_loops_a) && (output_stages>0)))
          wrcount_adj = 1;
     else if ((output_stages>1) ||
              (FIRST_WORD_FALL_THROUGH_BIN == FIRST_WORD_FALL_THROUGH_TRUE))
          wrcount_adj = output_stages*wr_adj;
     else
          wrcount_adj = 0;
     rdcount_adj = output_stages;
     @(wr_adj or output_stages or wr_loops_b or rd_loops_a);
  end

// reset logic
   assign RDRSTBUSY_out = RDRST_int;
   assign WRRSTBUSY_out = WRRST_int || WRRSTBUSY_dly;
   assign mem_rst_a = RDRST_int;


// RST_in sampled by WRCLK cleared by WR done
   always @ (posedge mem_wr_clk_b) begin
      if (RST_in && ~RST_sync) begin
         RST_sync <= 1'b1;
         end
      else if (WRRST_done) begin
         RST_sync <= 1'b0;
         end
      end

   assign WRRST_done_wr = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? WRRST_int : WRRST_done;
   always @ (posedge mem_wr_clk_b) begin
      if (RST_in && ~WRRSTBUSY_out) begin
         WRRST_int <= #1 1'b1;
         end
      else if (WRRST_done_wr) begin
         WRRST_int <= #1 1'b0;
         end
      end

// WRRST_int sampled by RDCLK twice => RDRST_int in CDI
   assign RDRST_int = (CLOCK_DOMAINS_BIN==CLOCK_DOMAINS_COMMON) ? WRRST_int: WRRST_in_sync_rd;
   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) begin
         WRRST_in_sync_rd1 <= 1'b0;
         WRRST_in_sync_rd  <= 1'b0;
         end
      else begin
         WRRST_in_sync_rd1 <= #1 WRRST_int;
         WRRST_in_sync_rd  <= #1 WRRST_in_sync_rd1;
         end
      end

// 3 rdclks to be done RD side
   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR || ~RDRST_int || (CLOCK_DOMAINS_BIN==CLOCK_DOMAINS_COMMON)) begin
         RDRST_done2 <= 1'b0;
         RDRST_done1 <= 1'b0;
         RDRST_done  <= 1'b0;
         end
      else begin
         RDRST_done2 <= RDRST_int;
         RDRST_done1 <= RDRST_done2;
         RDRST_done  <= RDRST_done1;
         end
      end

// 3 wrclks to be done WR side after RDRST_done
   always @ (posedge mem_wr_clk_b) begin
      if (glblGSR || WRRST_done || (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON)) begin
         WRRST_done2 <= 1'b0;
         WRRST_done1 <= 1'b0;
         WRRST_done  <= 1'b0;
      end
      else if (WRRST_int) begin
         WRRST_done2 <= RDRST_done;
         WRRST_done1 <= WRRST_done2;
         WRRST_done  <= WRRST_done1;
      end
   end

// bug fix
   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR || (CLOCK_DOMAINS_BIN==CLOCK_DOMAINS_COMMON)) begin
         RDRSTBUSY_dly2 <= 1'b0;
         RDRSTBUSY_dly1 <= 1'b0;
         RDRSTBUSY_dly  <= 1'b0;
         end
      else begin
         RDRSTBUSY_dly2 <= RDRST_int;
         RDRSTBUSY_dly1 <= RDRSTBUSY_dly2;
         RDRSTBUSY_dly  <= RDRSTBUSY_dly1;
         end
      end

   always @ (posedge mem_wr_clk_b) begin
      if (glblGSR || (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON)) begin
         WRRSTBUSY_dly1 <= 1'b0;
         WRRSTBUSY_dly  <= 1'b0;
      end
      else begin
         WRRSTBUSY_dly1 <= RDRSTBUSY_dly;
         WRRSTBUSY_dly  <= WRRSTBUSY_dly1;
      end
   end

// cascade control
   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) CASDOMUXA_reg <= 1'b0;
      else if (CASDOMUXEN_A_in == 1'b1) CASDOMUXA_reg <= CASDOMUXA_in;
      end

   always @ (posedge mem_rd_clk_a) begin
      if (glblGSR) CASOREGIMUXA_reg <= 1'b0;
      else if (CASOREGIMUXEN_A_in == 1'b1) CASOREGIMUXA_reg <= CASOREGIMUXA_in;
      end

// output register
   assign mem_a_reg_mux  = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXA_reg) ? CASDINA_in  : mem_a_lat;
   assign memp_a_reg_mux = (((CASCADE_ORDER_A_BIN == CASCADE_ORDER_LAST) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_PARALLEL) ||
                             (CASCADE_ORDER_A_BIN == CASCADE_ORDER_MIDDLE)) &&
                            CASOREGIMUXA_reg) ? CASDINPA_in : memp_a_lat;

   always @ (posedge mem_rd_clk_a or posedge INIT_MEM or glblGSR) begin
      if (glblGSR || INIT_MEM) begin
         {memp_a_reg, mem_a_reg} <= INIT_A_int;
         end
      else if (RSTREG_A_int) begin
         {memp_a_reg, mem_a_reg} <= SRVAL_A_int;
         end
      else if (REGCE_A_int) begin
         mem_a_reg <= mem_a_reg_mux;
         memp_a_reg <= memp_a_reg_mux;
         end
      end

// bit err reg
   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RSTREG_A_int) begin
         dbit_reg <= 1'b0;
         sbit_reg <= 1'b0;
         end
      else if (REGCE_A_int) begin
         dbit_reg <= dbit_lat;
         sbit_reg <= sbit_lat;
         end
      end

// ecc pipe register
   always @ (posedge mem_rd_clk_a or posedge INIT_MEM or glblGSR) begin
      if (glblGSR || INIT_MEM) begin
         {memp_a_pipe, mem_a_pipe} <= INIT_A_int;
         dbit_pipe <= 1'b0;
         sbit_pipe <= 1'b0;
         end
      else if (RSTREG_A_int) begin
         {memp_a_pipe, mem_a_pipe} <= SRVAL_A_int;
         dbit_pipe <= 1'b0;
         sbit_pipe <= 1'b0;
         end
      else if (RDEN_ecc) begin
         mem_a_pipe <= mem_a_ecc_cor;
         memp_a_pipe <= memp_a_ecc_cor;
         dbit_pipe <= dbit_int;
         sbit_pipe <= sbit_int;
         end
      end

// RDCOUNT sync to RDCLK
   assign rd_simple_raw = {1'b1, wr_addr_rd}-{1'b0, rd_addr_a};
   assign rd_simple = rd_simple_raw[ADDR_WIDTH-1:0];
   assign RDCOUNT_out = RDRST_int ? 1'b0 :
     (RDCOUNT_TYPE_BIN == RDCOUNT_TYPE_RAW_PNTR) ? (rd_addr_a/(rd_loops_a)) :
     (RDCOUNT_TYPE_BIN == RDCOUNT_TYPE_SYNC_PNTR) ? (rd_addr_wr/(rd_loops_a)) :
     (RDCOUNT_TYPE_BIN == RDCOUNT_TYPE_SIMPLE_DATACOUNT) ? rd_simple_sync/(rd_loops_a) :
     (RDCOUNT_TYPE_BIN == RDCOUNT_TYPE_EXTENDED_DATACOUNT) ? rd_simple_sync/(rd_loops_a) + rdcount_adj :
     (rd_addr_a/rd_loops_a);

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
         rd_simple_sync <= 0;
         end
      else begin
         if (rd_simple == {ADDR_WIDTH-1{1'b0}}) begin
            rd_simple_sync <= {FULL_out, rd_simple[ADDR_WIDTH-2:0]};
            end
         else begin
            rd_simple_sync <= rd_simple;
            end
         end
      end

// WRCOUNT sync to WRCLK
   assign wr_simple_raw = {1'b1, wr_addr_b}-{1'b0,rd_addr_wr};
   assign wr_simple = wr_simple_raw[ADDR_WIDTH-1:0];
   assign WRCOUNT_out = WRRSTBUSY_out ? 1'b0 :
     (WRCOUNT_TYPE_BIN == WRCOUNT_TYPE_RAW_PNTR) ? (wr_addr_b/(wr_loops_b)) :
     (WRCOUNT_TYPE_BIN == WRCOUNT_TYPE_SYNC_PNTR) ? (wr_addr_rd/(wr_loops_b)) :
     (WRCOUNT_TYPE_BIN == WRCOUNT_TYPE_SIMPLE_DATACOUNT) ? wr_simple_sync/(wr_loops_b) :
     (WRCOUNT_TYPE_BIN == WRCOUNT_TYPE_EXTENDED_DATACOUNT) ? wr_simple_sync/(wr_loops_b) + wrcount_adj :
     (wr_addr_b/wr_loops_b);

   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR || WRRSTBUSY_out) begin
         wr_simple_sync <= 0;
         end
      else begin
         wr_simple_sync <= wr_simple;
         end
      end

// with any output stage or FWFT fill the ouptut latch
// when ram not empty and o_latch empty
   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          o_lat_empty <= 1;
         end
      else if (fill_lat == 1) begin
          o_lat_empty <= 0;
         end
      else if ((ram_empty == 1) && RDEN_lat) begin
          o_lat_empty <= 1;
         end
      end

   always @ (negedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          fill_lat  <= 0;
          end
      else if ((ram_empty == 0) && (o_lat_empty == 1) && (output_stages>0)) begin
          fill_lat  <= 1;
          end
      else begin
          fill_lat  <= 0;
          end
      end

// FWFT and 
// REGISTERED not ECC_PIPE fill the ouptut register when o_latch not empty.
// REGISTERED and ECC_PIPE fill the ouptut register when o_ecc not empty.
// Empty on external read and prev stage also empty
   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          o_reg_empty <= 1;
         end
      else if ((o_lat_empty == 0) && RDEN_reg &&
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_FALSE)) begin
          o_reg_empty <= 0;
         end
      else if ((o_ecc_empty == 0) && RDEN_reg &&
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE)) begin
          o_reg_empty <= 0;
         end
      else if ((o_lat_empty == 1) && RDEN_reg &&
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_FALSE)) begin
          o_reg_empty <= 1;
         end
      else if ((o_ecc_empty == 1) && RDEN_reg &&
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE)) begin
          o_reg_empty <= 1;
         end
      end

   always @ (negedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          fill_reg <= 0;
          end
      else if ((o_lat_empty == 0) && (o_reg_empty == 1) && 
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_FALSE) &&
               (output_stages==2)) begin
          fill_reg <= 1;
          end
      else if ((o_ecc_empty == 0) && (o_reg_empty == 1) && 
               (output_stages==3)) begin
          fill_reg <= 1;
          end
      else begin
          fill_reg <= 0;
          end
      end

// FWFT and 
// ECC_PIPE fill the ecc register when o_latch not empty.
// Empty on external read and o_lat also empty
   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          o_ecc_empty <= 1;
         end
      else if ((o_lat_empty == 0) && RDEN_ecc) begin
          o_ecc_empty <= 0;
         end
      else if ((o_lat_empty == 1) && RDEN_ecc) begin
          o_ecc_empty <= 1;
         end
      end

   always @ (negedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
          fill_ecc <= 0;
      end
      else if ((o_lat_empty == 0) && (o_ecc_empty == 1) && 
               (output_stages>1) &&
               (EN_ECC_PIPE_BIN == EN_ECC_PIPE_TRUE)) begin
          fill_ecc <= 1;
      end
      else begin
          fill_ecc <= 0;
      end
   end

// read engine
   always @ (rd_addr_a or mem_rd_en_a or mem_rst_a or wr_b_event or INIT_MEM) begin
      if ((mem_rd_en_a || INIT_MEM) && ~mem_rst_a) begin
         for (raa=0;raa<rd_loops_a;raa=raa+1) begin
            mem_rd_a[raa] <= mem [rd_addr_a+raa];
            if (raa<rd_loops_a/8) begin
              memp_rd_a[raa] <= memp [(rd_addr_a/8)+raa];
            end
         end
      end
   end

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR) 
         RDERR_out <= 1'b0;
      else if (RDEN_in && (EMPTY_out || RDRST_int))
         RDERR_out <= 1'b1;
      else
         RDERR_out <= 1'b0;
   end

   always @(posedge mem_rd_clk_a or posedge INIT_MEM or posedge glblGSR) begin
      if (glblGSR || INIT_MEM) begin
         for (ra=0;ra<rd_loops_a;ra=ra+1) begin
            mem_a_lat[ra] <= INIT_A_int >> ra;
            if (ra<rd_loops_a/8) begin
               memp_a_lat[ra] <= INIT_A_int >> (D_WIDTH+ra);
            end
         end
      end
      else if ((SLEEP_in || SLEEP_int) && mem_rd_en_a) begin
         $display("DRC Error : READ on port A attempted while in SLEEP mode on %s instance %m.", MODULE_NAME);
         for (ra=0;ra<rd_loops_a;ra=ra+1) begin
            mem_a_lat[ra] <= 1'bx;
            if (ra<rd_loops_a/8) begin
               memp_a_lat[ra] <= 1'bx;
            end
         end
      end
      else if (mem_rst_a) begin
         for (ra=0;ra<rd_loops_a;ra=ra+1) begin
            mem_a_lat[ra] <= SRVAL_A_int >> ra;
            if (ra<rd_loops_a/8) begin
               memp_a_lat[ra]  <= SRVAL_A_int >> (D_WIDTH+ra);
            end
         end
      end
      else if (mem_rd_en_a) begin
         if (EN_ECC_READ_BIN == EN_ECC_READ_TRUE) begin
           mem_a_lat   <= mem_a_ecc;
           memp_a_lat  <= memp_a_ecc;
         end
         else begin
           mem_a_lat   <= mem_rd_a;
           memp_a_lat  <= memp_rd_a;
         end
      end
   end

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int) begin
         rd_addr_a <= {ADDR_WIDTH-1{1'b0}};
         rd_addr_a_wr <= {ADDR_WIDTH-1{1'b0}};
         wr_addr_sync_rd2 <= {ADDR_WIDTH-1{1'b0}};
         wr_addr_sync_rd1 <= {ADDR_WIDTH-1{1'b0}};
         wr_addr_sync_rd  <= {ADDR_WIDTH-1{1'b0}};
         end
      else begin 
         if (mem_rd_en_a) begin
            rd_addr_a <= rd_addr_a + rd_loops_a;
            end
         rd_addr_a_wr <= rd_addr_a;
         wr_addr_sync_rd2 <= wr_addr_b_rd;
         wr_addr_sync_rd1 <= wr_addr_sync_rd2;
         wr_addr_sync_rd  <= wr_addr_sync_rd1;
         end
      end

// write engine
   always @ (posedge mem_wr_clk_b) begin
     if (mem_wr_en_b) begin
       if (SLEEP_in || SLEEP_int) begin
         $display("DRC Error : WRITE on port A attempted while in SLEEP mode on %s instance %m.", MODULE_NAME);
       end
       else begin
         for (wb=0;wb<wr_loops_b;wb=wb+1) begin
           if (mem_we_b[wb]) begin
             mem [wr_addr_b+wb] <= mem_wr_b[wb];
           end
           if (wb<wr_loops_b/8) begin
             if (memp_we_b[wb]) begin
               memp [(wr_addr_b/8)+wb] <= memp_wr_b[wb];
             end
           end
         end
         wr_b_event <= ~wr_b_event;
       end
     end
   end

  assign mem_rm_douta = sdp_mode_rd ? {D_WIDTH{1'b0}} : {D_WIDTH{1'bx}}<<rd_loops_a;
  assign memp_rm_douta = sdp_mode_rd ? {DP_WIDTH{1'b0}} : {DP_WIDTH{1'bx}}<<rd_loops_a/8;
  assign mem_we_b = {{D_WIDTH{1'b1}}};
  assign memp_we_b = (WRITE_WIDTH_B_BIN > WRITE_WIDTH_4) ? {{DP_WIDTH{1'b1}}} : {{DP_WIDTH{1'b0}}};
   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR) 
         WRERR_out <= 1'b0;
      else if (WREN_in && (FULL_out || WRRSTBUSY_out))
         WRERR_out <= 1'b1;
      else
         WRERR_out <= 1'b0;
      end

   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR || WRRSTBUSY_out) begin
         wr_addr_b    <= {ADDR_WIDTH-1{1'b0}};
         wr_addr_b_rd <= {ADDR_WIDTH-1{1'b0}};
         o_stages_full_sync2 <= 1'b0;
         o_stages_full_sync1 <= 1'b0;
         o_stages_full_sync  <= 1'b0;
         rd_addr_sync_wr2 <= {ADDR_WIDTH-1{1'b0}};
         rd_addr_sync_wr1 <= {ADDR_WIDTH-1{1'b0}};
         rd_addr_sync_wr  <= {ADDR_WIDTH-1{1'b0}};
         end
      else begin
         if (mem_wr_en_b) begin
            wr_addr_b <= wr_addr_b + wr_loops_b;
            end
         wr_addr_b_rd <= wr_addr_b;
         o_stages_full_sync2 <= ~o_stages_empty;
         o_stages_full_sync1 <= o_stages_full_sync2;
         o_stages_full_sync  <= o_stages_full_sync1;
         rd_addr_sync_wr2 <= rd_addr_a_wr;
         rd_addr_sync_wr1 <= rd_addr_sync_wr2;
         rd_addr_sync_wr  <= rd_addr_sync_wr1;
         end
      end

// full flag
   assign prog_full = ((full_count_masked <= prog_full_val) && ((full_count > 0) || FULL_out));
   assign prog_full_val = mem_depth - (PROG_FULL_THRESH_BIN * wr_loops_b) + m_full;
   assign unr_ratio = (wr_loops_b>=rd_loops_a) ? wr_loops_b/rd_loops_a - 1 : 0;
   assign m_full = ((((m_full_raw-1)/wr_loops_b)+1)*wr_loops_b);
   assign m_full_raw  = ((output_stages>1) && o_stages_full) ? output_stages*rd_loops_a :
                    (output_stages==1 && o_stages_full) ? rd_loops_a : 0;
   assign n_empty = output_stages;
   assign prog_empty_val = (PROG_EMPTY_THRESH_BIN - n_empty + 1)*rd_loops_a;

   assign full_count_masked = full_count & wr_addr_b_mask;
   assign full_count = {1'b1, rd_addr_wr} - {1'b0, wr_addr_b};
   assign FULL_out  = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? ram_full_c : ram_full_i;
// ram_full independent clocks is one_from_full common clocks
   assign ram_one_from_full  = ((full_count < 2*wr_loops_b) && (full_count > 0));
   assign ram_two_from_full  = ((full_count < 3*wr_loops_b) && (full_count > 0));
// when full common clocks, next read makes it not full
   assign ram_one_read_from_not_full = ((full_count + rd_loops_a >= wr_loops_b) && ram_full_c);

   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR || WRRSTBUSY_out) begin
         ram_full_c <= 1'b0;
         end
      else if (mem_wr_en_b &&
               (mem_rd_en_a && (rd_loops_a < wr_loops_b)) && 
               ram_one_from_full) begin
         ram_full_c <= 1'b1;
         end
      else if (mem_wr_en_b && ~mem_rd_en_a && ram_one_from_full) begin
         ram_full_c <= 1'b1;
         end
      else if (mem_rd_en_a && ram_one_read_from_not_full) begin
         ram_full_c <= 1'b0;
         end
      else begin
         ram_full_c <= ram_full_c;
         end
      end

   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR || WRRSTBUSY_out) begin
         ram_full_i <= 1'b0;
         end
      else if (mem_wr_en_b && ram_two_from_full && ~ram_full_i) begin
         ram_full_i <= 1'b1;
         end
      else if (~ram_one_from_full) begin
         ram_full_i <= 1'b0;
         end
      else begin
         ram_full_i <= ram_full_i;
         end
      end

   always @ (posedge mem_wr_clk_b or glblGSR) begin
      if (glblGSR || WRRSTBUSY_out) begin
         PROGFULL_out <= 1'b0;
         end
      else begin
         PROGFULL_out <= prog_full;
         end
      end

// empty flag
   assign EMPTY_out = o_stages_empty;
   assign ram_empty = (CLOCK_DOMAINS_BIN == CLOCK_DOMAINS_COMMON) ? ram_empty_c : ram_empty_i;
   assign ram_one_read_from_empty = (empty_count < 2*rd_loops_a) && (empty_count >= rd_loops_a) && ~ram_empty;
   assign ram_one_write_from_not_empty = (rd_loops_a < wr_loops_b) ? EMPTY_out : ((empty_count + wr_loops_b) >= rd_loops_a);
   assign prog_empty = ((empty_count < prog_empty_val) || ram_empty) && ~FULL_out;

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int)
         ram_empty_c <= 1'b1;
// RD only makes empty
      else if (~mem_wr_en_b &&
               mem_rd_en_a  && 
               (ram_one_read_from_empty || ram_empty_c))
         ram_empty_c <= 1'b1;
// RD and WR when one read from empty and RD more than WR makes empty
      else if (mem_wr_en_b &&
              (mem_rd_en_a && (rd_loops_a > wr_loops_b)) && 
              (ram_one_read_from_empty || ram_empty_c))
         ram_empty_c <= 1'b1;
// CR701309 CC WR when empty always makes not empty. simultaneous RD gets ERR
      else if ( mem_wr_en_b && (ram_one_write_from_not_empty && ram_empty_c))
         ram_empty_c <= 1'b0;
      else
         ram_empty_c <= ram_empty_c;
      end

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int)
         ram_empty_i <= 1'b1;
      else if (mem_rd_en_a && ram_one_read_from_empty) // RDEN_in ?
         ram_empty_i <= 1'b1;
      else if (empty_count < rd_loops_a)
         ram_empty_i <= 1'b1;
      else
         ram_empty_i <= 1'b0;
      end

   assign empty_count = {1'b1, wr_addr_rd} - {1'b0, rd_addr_a};

   always @ (posedge mem_rd_clk_a or glblGSR) begin
      if (glblGSR || RDRST_int)
         PROGEMPTY_out <= 1'b1;
      else
         PROGEMPTY_out <= prog_empty;
      end
// eccparity is flopped
    assign synd_wr = (EN_ECC_WRITE_BIN == EN_ECC_WRITE_TRUE) ?
                     fn_ecc(encode, DIN_in, DINP_in)   : 8'b0;
    assign synd_rd = (EN_ECC_READ_BIN == EN_ECC_READ_TRUE) ?
                     fn_ecc(decode, mem_rd_a, memp_rd_a) : 8'b0;
    assign synd_ecc = (EN_ECC_READ_BIN == EN_ECC_READ_TRUE) ? 
                     synd_rd ^ memp_rd_a : 8'b0;                  
    assign sbit_int = (|synd_ecc &&  synd_ecc[7]);
    assign dbit_int = (|synd_ecc && ~synd_ecc[7]);
// make sure new read has happend before checking for error.
// INIT/SRVAL values shouldn't cause error.
    always @(posedge mem_rd_clk_a) begin
       if (mem_rst_a) begin
         sbit_lat  <= 1'b0;
         dbit_lat  <= 1'b0;
         error_bit   <= 7'b0;
         end
       else if (mem_rd_en_a && (EN_ECC_READ_BIN == EN_ECC_READ_TRUE)) begin
         sbit_lat    <= sbit_ecc;
         dbit_lat    <= dbit_ecc;
         error_bit   <= synd_ecc[6:0];
         end
       end

    assign {memp_a_ecc_cor, mem_a_ecc_cor} = sbit_int ?
            fn_cor_bit(synd_ecc[6:0], mem_rd_a, memp_rd_a) :
            {memp_rd_a, mem_rd_a};

    assign wrclk_ecc_out = mem_wr_clk_b && (EN_ECC_WRITE_BIN == EN_ECC_WRITE_TRUE);

    always @ (posedge wrclk_ecc_out or glblGSR) begin
      if(glblGSR)
        eccparity_reg <= 8'h00;
      else if (mem_wr_en_b)
        eccparity_reg <= synd_wr;
    end

  specify
    ( CASDIN *> CASDOUT) = (0:0:0, 0:0:0);
    ( CASDIN *> DOUT) = (0:0:0, 0:0:0);
    ( CASDINP *> CASDOUTP) = (0:0:0, 0:0:0);
    ( CASDINP *> DOUTP) = (0:0:0, 0:0:0);
    ( CASPRVEMPTY *> CASPRVRDEN) = (0:0:0, 0:0:0);
    ( RDCLK *> CASDOUT) = (0:0:0, 0:0:0);
    ( RDCLK *> CASDOUTP) = (0:0:0, 0:0:0);
    ( RDCLK *> CASNXTEMPTY) = (0:0:0, 0:0:0);
    ( RDCLK *> DBITERR) = (0:0:0, 0:0:0);
    ( RDCLK *> DOUT) = (0:0:0, 0:0:0);
    ( RDCLK *> DOUTP) = (0:0:0, 0:0:0);
    ( RDCLK *> EMPTY) = (0:0:0, 0:0:0);
    ( RDCLK *> PROGEMPTY) = (0:0:0, 0:0:0);
    ( RDCLK *> RDCOUNT) = (0:0:0, 0:0:0);
    ( RDCLK *> RDERR) = (0:0:0, 0:0:0);
    ( RDCLK *> RDRSTBUSY) = (0:0:0, 0:0:0);
    ( RDCLK *> SBITERR) = (0:0:0, 0:0:0);
    ( RDCLK *> WRCOUNT) = (0:0:0, 0:0:0);
    ( WRCLK *> CASDOUT) = (0:0:0, 0:0:0);
    ( WRCLK *> CASDOUTP) = (0:0:0, 0:0:0);
    ( WRCLK *> CASPRVRDEN) = (0:0:0, 0:0:0);
    ( WRCLK *> DOUT) = (0:0:0, 0:0:0);
    ( WRCLK *> DOUTP) = (0:0:0, 0:0:0);
    ( WRCLK *> ECCPARITY) = (0:0:0, 0:0:0);
    ( WRCLK *> FULL) = (0:0:0, 0:0:0);
    ( WRCLK *> PROGFULL) = (0:0:0, 0:0:0);
    ( WRCLK *> RDCOUNT) = (0:0:0, 0:0:0);
    ( WRCLK *> RDRSTBUSY) = (0:0:0, 0:0:0);
    ( WRCLK *> WRCOUNT) = (0:0:0, 0:0:0);
    ( WRCLK *> WRERR) = (0:0:0, 0:0:0);
    ( WRCLK *> WRRSTBUSY) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge RDCLK, 0:0:0, notifier);
    $period (negedge WRCLK, 0:0:0, notifier);
    $period (posedge RDCLK, 0:0:0, notifier);
    $period (posedge WRCLK, 0:0:0, notifier);
    $setuphold (negedge RDCLK, negedge CASDIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDIN_delay);
    $setuphold (negedge RDCLK, negedge CASDINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDINP_delay);
    $setuphold (negedge RDCLK, negedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUX_delay);
    $setuphold (negedge RDCLK, negedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUXEN_delay);
    $setuphold (negedge RDCLK, negedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASNXTRDEN_delay);
    $setuphold (negedge RDCLK, negedge CASOREGIMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUX_delay);
    $setuphold (negedge RDCLK, negedge CASOREGIMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUXEN_delay);
    $setuphold (negedge RDCLK, negedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASPRVEMPTY_delay);
    $setuphold (negedge RDCLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DIN_delay);
    $setuphold (negedge RDCLK, negedge DINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DINP_delay);
    $setuphold (negedge RDCLK, negedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTDBITERR_delay);
    $setuphold (negedge RDCLK, negedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTSBITERR_delay);
    $setuphold (negedge RDCLK, negedge RDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RDEN_delay);
    $setuphold (negedge RDCLK, negedge REGCE, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, REGCE_delay);
    $setuphold (negedge RDCLK, negedge RSTREG, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RSTREG_delay);
    $setuphold (negedge RDCLK, negedge SLEEP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, SLEEP_delay);
    $setuphold (negedge RDCLK, negedge WREN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, WREN_delay);
    $setuphold (negedge RDCLK, posedge CASDIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDIN_delay);
    $setuphold (negedge RDCLK, posedge CASDINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDINP_delay);
    $setuphold (negedge RDCLK, posedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUX_delay);
    $setuphold (negedge RDCLK, posedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUXEN_delay);
    $setuphold (negedge RDCLK, posedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASNXTRDEN_delay);
    $setuphold (negedge RDCLK, posedge CASOREGIMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUX_delay);
    $setuphold (negedge RDCLK, posedge CASOREGIMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUXEN_delay);
    $setuphold (negedge RDCLK, posedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASPRVEMPTY_delay);
    $setuphold (negedge RDCLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DIN_delay);
    $setuphold (negedge RDCLK, posedge DINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DINP_delay);
    $setuphold (negedge RDCLK, posedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTDBITERR_delay);
    $setuphold (negedge RDCLK, posedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTSBITERR_delay);
    $setuphold (negedge RDCLK, posedge RDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RDEN_delay);
    $setuphold (negedge RDCLK, posedge REGCE, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, REGCE_delay);
    $setuphold (negedge RDCLK, posedge RSTREG, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RSTREG_delay);
    $setuphold (negedge RDCLK, posedge SLEEP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, SLEEP_delay);
    $setuphold (negedge RDCLK, posedge WREN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, WREN_delay);
    $setuphold (negedge WRCLK, negedge CASDIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDIN_delay);
    $setuphold (negedge WRCLK, negedge CASDINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDINP_delay);
    $setuphold (negedge WRCLK, negedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUX_delay);
    $setuphold (negedge WRCLK, negedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUXEN_delay);
    $setuphold (negedge WRCLK, negedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASNXTRDEN_delay);
    $setuphold (negedge WRCLK, negedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASPRVEMPTY_delay);
    $setuphold (negedge WRCLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DIN_delay);
    $setuphold (negedge WRCLK, negedge DINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DINP_delay);
    $setuphold (negedge WRCLK, negedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTDBITERR_delay);
    $setuphold (negedge WRCLK, negedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTSBITERR_delay);
    $setuphold (negedge WRCLK, negedge RDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RDEN_delay);
    $setuphold (negedge WRCLK, negedge RST, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RST_delay);
    $setuphold (negedge WRCLK, negedge WREN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, WREN_delay);
    $setuphold (negedge WRCLK, posedge CASDIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDIN_delay);
    $setuphold (negedge WRCLK, posedge CASDINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDINP_delay);
    $setuphold (negedge WRCLK, posedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUX_delay);
    $setuphold (negedge WRCLK, posedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUXEN_delay);
    $setuphold (negedge WRCLK, posedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASNXTRDEN_delay);
    $setuphold (negedge WRCLK, posedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASPRVEMPTY_delay);
    $setuphold (negedge WRCLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DIN_delay);
    $setuphold (negedge WRCLK, posedge DINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DINP_delay);
    $setuphold (negedge WRCLK, posedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTDBITERR_delay);
    $setuphold (negedge WRCLK, posedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTSBITERR_delay);
    $setuphold (negedge WRCLK, posedge RDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RDEN_delay);
    $setuphold (negedge WRCLK, posedge RST, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RST_delay);
    $setuphold (negedge WRCLK, posedge WREN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, WREN_delay);
    $setuphold (posedge RDCLK, negedge CASDIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDIN_delay);
    $setuphold (posedge RDCLK, negedge CASDINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDINP_delay);
    $setuphold (posedge RDCLK, negedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUX_delay);
    $setuphold (posedge RDCLK, negedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUXEN_delay);
    $setuphold (posedge RDCLK, negedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASNXTRDEN_delay);
    $setuphold (posedge RDCLK, negedge CASOREGIMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUX_delay);
    $setuphold (posedge RDCLK, negedge CASOREGIMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUXEN_delay);
    $setuphold (posedge RDCLK, negedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASPRVEMPTY_delay);
    $setuphold (posedge RDCLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DIN_delay);
    $setuphold (posedge RDCLK, negedge DINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DINP_delay);
    $setuphold (posedge RDCLK, negedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTDBITERR_delay);
    $setuphold (posedge RDCLK, negedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTSBITERR_delay);
    $setuphold (posedge RDCLK, negedge RDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RDEN_delay);
    $setuphold (posedge RDCLK, negedge REGCE, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, REGCE_delay);
    $setuphold (posedge RDCLK, negedge RSTREG, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RSTREG_delay);
    $setuphold (posedge RDCLK, negedge SLEEP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, SLEEP_delay);
    $setuphold (posedge RDCLK, negedge WREN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, WREN_delay);
    $setuphold (posedge RDCLK, posedge CASDIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDIN_delay);
    $setuphold (posedge RDCLK, posedge CASDINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDINP_delay);
    $setuphold (posedge RDCLK, posedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUX_delay);
    $setuphold (posedge RDCLK, posedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASDOMUXEN_delay);
    $setuphold (posedge RDCLK, posedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASNXTRDEN_delay);
    $setuphold (posedge RDCLK, posedge CASOREGIMUX, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUX_delay);
    $setuphold (posedge RDCLK, posedge CASOREGIMUXEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASOREGIMUXEN_delay);
    $setuphold (posedge RDCLK, posedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, CASPRVEMPTY_delay);
    $setuphold (posedge RDCLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DIN_delay);
    $setuphold (posedge RDCLK, posedge DINP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, DINP_delay);
    $setuphold (posedge RDCLK, posedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTDBITERR_delay);
    $setuphold (posedge RDCLK, posedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, INJECTSBITERR_delay);
    $setuphold (posedge RDCLK, posedge RDEN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RDEN_delay);
    $setuphold (posedge RDCLK, posedge REGCE, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, REGCE_delay);
    $setuphold (posedge RDCLK, posedge RSTREG, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, RSTREG_delay);
    $setuphold (posedge RDCLK, posedge SLEEP, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, SLEEP_delay);
    $setuphold (posedge RDCLK, posedge WREN, 0:0:0, 0:0:0, notifier,,, RDCLK_delay, WREN_delay);
    $setuphold (posedge WRCLK, negedge CASDIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDIN_delay);
    $setuphold (posedge WRCLK, negedge CASDINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDINP_delay);
    $setuphold (posedge WRCLK, negedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUX_delay);
    $setuphold (posedge WRCLK, negedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUXEN_delay);
    $setuphold (posedge WRCLK, negedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASNXTRDEN_delay);
    $setuphold (posedge WRCLK, negedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASPRVEMPTY_delay);
    $setuphold (posedge WRCLK, negedge DIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DIN_delay);
    $setuphold (posedge WRCLK, negedge DINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DINP_delay);
    $setuphold (posedge WRCLK, negedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTDBITERR_delay);
    $setuphold (posedge WRCLK, negedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTSBITERR_delay);
    $setuphold (posedge WRCLK, negedge RDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RDEN_delay);
    $setuphold (posedge WRCLK, negedge RST, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RST_delay);
    $setuphold (posedge WRCLK, negedge WREN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, WREN_delay);
    $setuphold (posedge WRCLK, posedge CASDIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDIN_delay);
    $setuphold (posedge WRCLK, posedge CASDINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDINP_delay);
    $setuphold (posedge WRCLK, posedge CASDOMUX, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUX_delay);
    $setuphold (posedge WRCLK, posedge CASDOMUXEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASDOMUXEN_delay);
    $setuphold (posedge WRCLK, posedge CASNXTRDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASNXTRDEN_delay);
    $setuphold (posedge WRCLK, posedge CASPRVEMPTY, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, CASPRVEMPTY_delay);
    $setuphold (posedge WRCLK, posedge DIN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DIN_delay);
    $setuphold (posedge WRCLK, posedge DINP, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, DINP_delay);
    $setuphold (posedge WRCLK, posedge INJECTDBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTDBITERR_delay);
    $setuphold (posedge WRCLK, posedge INJECTSBITERR, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, INJECTSBITERR_delay);
    $setuphold (posedge WRCLK, posedge RDEN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RDEN_delay);
    $setuphold (posedge WRCLK, posedge RST, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, RST_delay);
    $setuphold (posedge WRCLK, posedge WREN, 0:0:0, 0:0:0, notifier,,, WRCLK_delay, WREN_delay);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
