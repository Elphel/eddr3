///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 2011 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2012.2
//  \   \          Description : Xilinx Unified Simulation Library Component
//  /   /                        
// /___/   /\      Filename    : ILKN.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module ILKN #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter BYPASS = "FALSE",
  parameter [1:0] CTL_RX_BURSTMAX = 2'h3,
  parameter [1:0] CTL_RX_CHAN_EXT = 2'h0,
  parameter [3:0] CTL_RX_LAST_LANE = 4'hB,
  parameter [15:0] CTL_RX_MFRAMELEN_MINUS1 = 16'h07FF,
  parameter CTL_RX_PACKET_MODE = "TRUE",
  parameter [2:0] CTL_RX_RETRANS_MULT = 3'h0,
  parameter [3:0] CTL_RX_RETRANS_RETRY = 4'h2,
  parameter [15:0] CTL_RX_RETRANS_TIMER1 = 16'h0000,
  parameter [15:0] CTL_RX_RETRANS_TIMER2 = 16'h0008,
  parameter [11:0] CTL_RX_RETRANS_WDOG = 12'h000,
  parameter [7:0] CTL_RX_RETRANS_WRAP_TIMER = 8'h00,
  parameter CTL_TEST_MODE_PIN_CHAR = "FALSE",
  parameter [1:0] CTL_TX_BURSTMAX = 2'h3,
  parameter [2:0] CTL_TX_BURSTSHORT = 3'h1,
  parameter [1:0] CTL_TX_CHAN_EXT = 2'h0,
  parameter CTL_TX_DISABLE_SKIPWORD = "TRUE",
  parameter [6:0] CTL_TX_FC_CALLEN = 7'h00,
  parameter [3:0] CTL_TX_LAST_LANE = 4'hB,
  parameter [15:0] CTL_TX_MFRAMELEN_MINUS1 = 16'h07FF,
  parameter [13:0] CTL_TX_RETRANS_DEPTH = 14'h0800,
  parameter [2:0] CTL_TX_RETRANS_MULT = 3'h0,
  parameter [1:0] CTL_TX_RETRANS_RAM_BANKS = 2'h3,
  parameter MODE = "TRUE",
  parameter TEST_MODE_PIN_CHAR = "FALSE"
)(
  output [15:0] DRP_DO,
  output DRP_RDY,
  output [65:0] RX_BYPASS_DATAOUT00,
  output [65:0] RX_BYPASS_DATAOUT01,
  output [65:0] RX_BYPASS_DATAOUT02,
  output [65:0] RX_BYPASS_DATAOUT03,
  output [65:0] RX_BYPASS_DATAOUT04,
  output [65:0] RX_BYPASS_DATAOUT05,
  output [65:0] RX_BYPASS_DATAOUT06,
  output [65:0] RX_BYPASS_DATAOUT07,
  output [65:0] RX_BYPASS_DATAOUT08,
  output [65:0] RX_BYPASS_DATAOUT09,
  output [65:0] RX_BYPASS_DATAOUT10,
  output [65:0] RX_BYPASS_DATAOUT11,
  output [11:0] RX_BYPASS_ENAOUT,
  output [11:0] RX_BYPASS_IS_AVAILOUT,
  output [11:0] RX_BYPASS_IS_BADLYFRAMEDOUT,
  output [11:0] RX_BYPASS_IS_OVERFLOWOUT,
  output [11:0] RX_BYPASS_IS_SYNCEDOUT,
  output [11:0] RX_BYPASS_IS_SYNCWORDOUT,
  output [10:0] RX_CHANOUT0,
  output [10:0] RX_CHANOUT1,
  output [10:0] RX_CHANOUT2,
  output [10:0] RX_CHANOUT3,
  output [127:0] RX_DATAOUT0,
  output [127:0] RX_DATAOUT1,
  output [127:0] RX_DATAOUT2,
  output [127:0] RX_DATAOUT3,
  output RX_ENAOUT0,
  output RX_ENAOUT1,
  output RX_ENAOUT2,
  output RX_ENAOUT3,
  output RX_EOPOUT0,
  output RX_EOPOUT1,
  output RX_EOPOUT2,
  output RX_EOPOUT3,
  output RX_ERROUT0,
  output RX_ERROUT1,
  output RX_ERROUT2,
  output RX_ERROUT3,
  output [3:0] RX_MTYOUT0,
  output [3:0] RX_MTYOUT1,
  output [3:0] RX_MTYOUT2,
  output [3:0] RX_MTYOUT3,
  output RX_OVFOUT,
  output RX_SOPOUT0,
  output RX_SOPOUT1,
  output RX_SOPOUT2,
  output RX_SOPOUT3,
  output STAT_RX_ALIGNED,
  output STAT_RX_ALIGNED_ERR,
  output [11:0] STAT_RX_BAD_TYPE_ERR,
  output STAT_RX_BURSTMAX_ERR,
  output STAT_RX_BURST_ERR,
  output STAT_RX_CRC24_ERR,
  output [11:0] STAT_RX_CRC32_ERR,
  output [11:0] STAT_RX_CRC32_VALID,
  output [11:0] STAT_RX_DESCRAM_ERR,
  output [11:0] STAT_RX_DIAGWORD_INTFSTAT,
  output [11:0] STAT_RX_DIAGWORD_LANESTAT,
  output [255:0] STAT_RX_FC_STAT,
  output [11:0] STAT_RX_FRAMING_ERR,
  output STAT_RX_MEOP_ERR,
  output [11:0] STAT_RX_MF_ERR,
  output [11:0] STAT_RX_MF_LEN_ERR,
  output [11:0] STAT_RX_MF_REPEAT_ERR,
  output STAT_RX_MISALIGNED,
  output STAT_RX_MSOP_ERR,
  output [7:0] STAT_RX_MUBITS,
  output STAT_RX_MUBITS_UPDATED,
  output STAT_RX_OVERFLOW_ERR,
  output STAT_RX_RETRANS_CRC24_ERR,
  output STAT_RX_RETRANS_DISC,
  output [15:0] STAT_RX_RETRANS_LATENCY,
  output STAT_RX_RETRANS_REQ,
  output STAT_RX_RETRANS_RETRY_ERR,
  output [7:0] STAT_RX_RETRANS_SEQ,
  output STAT_RX_RETRANS_SEQ_UPDATED,
  output [2:0] STAT_RX_RETRANS_STATE,
  output [4:0] STAT_RX_RETRANS_SUBSEQ,
  output STAT_RX_RETRANS_WDOG_ERR,
  output STAT_RX_RETRANS_WRAP_ERR,
  output [11:0] STAT_RX_SYNCED,
  output [11:0] STAT_RX_SYNCED_ERR,
  output [11:0] STAT_RX_WORD_SYNC,
  output STAT_TX_BURST_ERR,
  output STAT_TX_ERRINJ_BITERR_DONE,
  output STAT_TX_OVERFLOW_ERR,
  output STAT_TX_RETRANS_BURST_ERR,
  output STAT_TX_RETRANS_BUSY,
  output STAT_TX_RETRANS_RAM_PERROUT,
  output [8:0] STAT_TX_RETRANS_RAM_RADDR,
  output STAT_TX_RETRANS_RAM_RD_B0,
  output STAT_TX_RETRANS_RAM_RD_B1,
  output STAT_TX_RETRANS_RAM_RD_B2,
  output STAT_TX_RETRANS_RAM_RD_B3,
  output [1:0] STAT_TX_RETRANS_RAM_RSEL,
  output [8:0] STAT_TX_RETRANS_RAM_WADDR,
  output [643:0] STAT_TX_RETRANS_RAM_WDATA,
  output STAT_TX_RETRANS_RAM_WE_B0,
  output STAT_TX_RETRANS_RAM_WE_B1,
  output STAT_TX_RETRANS_RAM_WE_B2,
  output STAT_TX_RETRANS_RAM_WE_B3,
  output STAT_TX_UNDERFLOW_ERR,
  output TX_OVFOUT,
  output TX_RDYOUT,
  output [63:0] TX_SERDES_DATA00,
  output [63:0] TX_SERDES_DATA01,
  output [63:0] TX_SERDES_DATA02,
  output [63:0] TX_SERDES_DATA03,
  output [63:0] TX_SERDES_DATA04,
  output [63:0] TX_SERDES_DATA05,
  output [63:0] TX_SERDES_DATA06,
  output [63:0] TX_SERDES_DATA07,
  output [63:0] TX_SERDES_DATA08,
  output [63:0] TX_SERDES_DATA09,
  output [63:0] TX_SERDES_DATA10,
  output [63:0] TX_SERDES_DATA11,

  input CORE_CLK,
  input CTL_RX_FORCE_RESYNC,
  input CTL_RX_RETRANS_ACK,
  input CTL_RX_RETRANS_ENABLE,
  input CTL_RX_RETRANS_ERRIN,
  input CTL_RX_RETRANS_FORCE_REQ,
  input CTL_RX_RETRANS_RESET,
  input CTL_RX_RETRANS_RESET_MODE,
  input CTL_TX_DIAGWORD_INTFSTAT,
  input [11:0] CTL_TX_DIAGWORD_LANESTAT,
  input CTL_TX_ENABLE,
  input CTL_TX_ERRINJ_BITERR_GO,
  input [3:0] CTL_TX_ERRINJ_BITERR_LANE,
  input [255:0] CTL_TX_FC_STAT,
  input [7:0] CTL_TX_MUBITS,
  input CTL_TX_RETRANS_ENABLE,
  input CTL_TX_RETRANS_RAM_PERRIN,
  input [643:0] CTL_TX_RETRANS_RAM_RDATA,
  input CTL_TX_RETRANS_REQ,
  input CTL_TX_RETRANS_REQ_VALID,
  input [11:0] CTL_TX_RLIM_DELTA,
  input CTL_TX_RLIM_ENABLE,
  input [7:0] CTL_TX_RLIM_INTV,
  input [11:0] CTL_TX_RLIM_MAX,
  input [9:0] DRP_ADDR,
  input DRP_CLK,
  input [15:0] DRP_DI,
  input DRP_EN,
  input DRP_WE,
  input LBUS_CLK,
  input RX_BYPASS_FORCE_REALIGNIN,
  input RX_BYPASS_RDIN,
  input RX_RESET,
  input [11:0] RX_SERDES_CLK,
  input [63:0] RX_SERDES_DATA00,
  input [63:0] RX_SERDES_DATA01,
  input [63:0] RX_SERDES_DATA02,
  input [63:0] RX_SERDES_DATA03,
  input [63:0] RX_SERDES_DATA04,
  input [63:0] RX_SERDES_DATA05,
  input [63:0] RX_SERDES_DATA06,
  input [63:0] RX_SERDES_DATA07,
  input [63:0] RX_SERDES_DATA08,
  input [63:0] RX_SERDES_DATA09,
  input [63:0] RX_SERDES_DATA10,
  input [63:0] RX_SERDES_DATA11,
  input [11:0] RX_SERDES_RESET,
  input TX_BCTLIN0,
  input TX_BCTLIN1,
  input TX_BCTLIN2,
  input TX_BCTLIN3,
  input [11:0] TX_BYPASS_CTRLIN,
  input [63:0] TX_BYPASS_DATAIN00,
  input [63:0] TX_BYPASS_DATAIN01,
  input [63:0] TX_BYPASS_DATAIN02,
  input [63:0] TX_BYPASS_DATAIN03,
  input [63:0] TX_BYPASS_DATAIN04,
  input [63:0] TX_BYPASS_DATAIN05,
  input [63:0] TX_BYPASS_DATAIN06,
  input [63:0] TX_BYPASS_DATAIN07,
  input [63:0] TX_BYPASS_DATAIN08,
  input [63:0] TX_BYPASS_DATAIN09,
  input [63:0] TX_BYPASS_DATAIN10,
  input [63:0] TX_BYPASS_DATAIN11,
  input TX_BYPASS_ENAIN,
  input [7:0] TX_BYPASS_GEARBOX_SEQIN,
  input [3:0] TX_BYPASS_MFRAMER_STATEIN,
  input [10:0] TX_CHANIN0,
  input [10:0] TX_CHANIN1,
  input [10:0] TX_CHANIN2,
  input [10:0] TX_CHANIN3,
  input [127:0] TX_DATAIN0,
  input [127:0] TX_DATAIN1,
  input [127:0] TX_DATAIN2,
  input [127:0] TX_DATAIN3,
  input TX_ENAIN0,
  input TX_ENAIN1,
  input TX_ENAIN2,
  input TX_ENAIN3,
  input TX_EOPIN0,
  input TX_EOPIN1,
  input TX_EOPIN2,
  input TX_EOPIN3,
  input TX_ERRIN0,
  input TX_ERRIN1,
  input TX_ERRIN2,
  input TX_ERRIN3,
  input [3:0] TX_MTYIN0,
  input [3:0] TX_MTYIN1,
  input [3:0] TX_MTYIN2,
  input [3:0] TX_MTYIN3,
  input TX_RESET,
  input TX_SERDES_REFCLK,
  input TX_SERDES_REFCLK_RESET,
  input TX_SOPIN0,
  input TX_SOPIN1,
  input TX_SOPIN2,
  input TX_SOPIN3
);
  
// define constants
  localparam MODULE_NAME = "ILKN";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [40:1] BYPASS_REG = BYPASS;
  localparam [1:0] CTL_RX_BURSTMAX_REG = CTL_RX_BURSTMAX;
  localparam [1:0] CTL_RX_CHAN_EXT_REG = CTL_RX_CHAN_EXT;
  localparam [3:0] CTL_RX_LAST_LANE_REG = CTL_RX_LAST_LANE;
  localparam [15:0] CTL_RX_MFRAMELEN_MINUS1_REG = CTL_RX_MFRAMELEN_MINUS1;
  localparam [40:1] CTL_RX_PACKET_MODE_REG = CTL_RX_PACKET_MODE;
  localparam [2:0] CTL_RX_RETRANS_MULT_REG = CTL_RX_RETRANS_MULT;
  localparam [3:0] CTL_RX_RETRANS_RETRY_REG = CTL_RX_RETRANS_RETRY;
  localparam [15:0] CTL_RX_RETRANS_TIMER1_REG = CTL_RX_RETRANS_TIMER1;
  localparam [15:0] CTL_RX_RETRANS_TIMER2_REG = CTL_RX_RETRANS_TIMER2;
  localparam [11:0] CTL_RX_RETRANS_WDOG_REG = CTL_RX_RETRANS_WDOG;
  localparam [7:0] CTL_RX_RETRANS_WRAP_TIMER_REG = CTL_RX_RETRANS_WRAP_TIMER;
  localparam [40:1] CTL_TEST_MODE_PIN_CHAR_REG = CTL_TEST_MODE_PIN_CHAR;
  localparam [1:0] CTL_TX_BURSTMAX_REG = CTL_TX_BURSTMAX;
  localparam [2:0] CTL_TX_BURSTSHORT_REG = CTL_TX_BURSTSHORT;
  localparam [1:0] CTL_TX_CHAN_EXT_REG = CTL_TX_CHAN_EXT;
  localparam [40:1] CTL_TX_DISABLE_SKIPWORD_REG = CTL_TX_DISABLE_SKIPWORD;
  localparam [6:0] CTL_TX_FC_CALLEN_REG = CTL_TX_FC_CALLEN;
  localparam [3:0] CTL_TX_LAST_LANE_REG = CTL_TX_LAST_LANE;
  localparam [15:0] CTL_TX_MFRAMELEN_MINUS1_REG = CTL_TX_MFRAMELEN_MINUS1;
  localparam [13:0] CTL_TX_RETRANS_DEPTH_REG = CTL_TX_RETRANS_DEPTH;
  localparam [2:0] CTL_TX_RETRANS_MULT_REG = CTL_TX_RETRANS_MULT;
  localparam [1:0] CTL_TX_RETRANS_RAM_BANKS_REG = CTL_TX_RETRANS_RAM_BANKS;
  localparam [40:1] MODE_REG = MODE;
  localparam [40:1] TEST_MODE_PIN_CHAR_REG = TEST_MODE_PIN_CHAR;
  `endif

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "ILKN_dr.v"
  `endif

  wire DRP_RDY_out;
  wire RX_ENAOUT0_out;
  wire RX_ENAOUT1_out;
  wire RX_ENAOUT2_out;
  wire RX_ENAOUT3_out;
  wire RX_EOPOUT0_out;
  wire RX_EOPOUT1_out;
  wire RX_EOPOUT2_out;
  wire RX_EOPOUT3_out;
  wire RX_ERROUT0_out;
  wire RX_ERROUT1_out;
  wire RX_ERROUT2_out;
  wire RX_ERROUT3_out;
  wire RX_OVFOUT_out;
  wire RX_SOPOUT0_out;
  wire RX_SOPOUT1_out;
  wire RX_SOPOUT2_out;
  wire RX_SOPOUT3_out;
  wire STAT_RX_ALIGNED_ERR_out;
  wire STAT_RX_ALIGNED_out;
  wire STAT_RX_BURSTMAX_ERR_out;
  wire STAT_RX_BURST_ERR_out;
  wire STAT_RX_CRC24_ERR_out;
  wire STAT_RX_MEOP_ERR_out;
  wire STAT_RX_MISALIGNED_out;
  wire STAT_RX_MSOP_ERR_out;
  wire STAT_RX_MUBITS_UPDATED_out;
  wire STAT_RX_OVERFLOW_ERR_out;
  wire STAT_RX_RETRANS_CRC24_ERR_out;
  wire STAT_RX_RETRANS_DISC_out;
  wire STAT_RX_RETRANS_REQ_out;
  wire STAT_RX_RETRANS_RETRY_ERR_out;
  wire STAT_RX_RETRANS_SEQ_UPDATED_out;
  wire STAT_RX_RETRANS_WDOG_ERR_out;
  wire STAT_RX_RETRANS_WRAP_ERR_out;
  wire STAT_TX_BURST_ERR_out;
  wire STAT_TX_ERRINJ_BITERR_DONE_out;
  wire STAT_TX_OVERFLOW_ERR_out;
  wire STAT_TX_RETRANS_BURST_ERR_out;
  wire STAT_TX_RETRANS_BUSY_out;
  wire STAT_TX_RETRANS_RAM_PERROUT_out;
  wire STAT_TX_RETRANS_RAM_RD_B0_out;
  wire STAT_TX_RETRANS_RAM_RD_B1_out;
  wire STAT_TX_RETRANS_RAM_RD_B2_out;
  wire STAT_TX_RETRANS_RAM_RD_B3_out;
  wire STAT_TX_RETRANS_RAM_WE_B0_out;
  wire STAT_TX_RETRANS_RAM_WE_B1_out;
  wire STAT_TX_RETRANS_RAM_WE_B2_out;
  wire STAT_TX_RETRANS_RAM_WE_B3_out;
  wire STAT_TX_UNDERFLOW_ERR_out;
  wire TX_OVFOUT_out;
  wire TX_RDYOUT_out;
  wire [10:0] RX_CHANOUT0_out;
  wire [10:0] RX_CHANOUT1_out;
  wire [10:0] RX_CHANOUT2_out;
  wire [10:0] RX_CHANOUT3_out;
  wire [11:0] RX_BYPASS_ENAOUT_out;
  wire [11:0] RX_BYPASS_IS_AVAILOUT_out;
  wire [11:0] RX_BYPASS_IS_BADLYFRAMEDOUT_out;
  wire [11:0] RX_BYPASS_IS_OVERFLOWOUT_out;
  wire [11:0] RX_BYPASS_IS_SYNCEDOUT_out;
  wire [11:0] RX_BYPASS_IS_SYNCWORDOUT_out;
  wire [11:0] STAT_RX_BAD_TYPE_ERR_out;
  wire [11:0] STAT_RX_CRC32_ERR_out;
  wire [11:0] STAT_RX_CRC32_VALID_out;
  wire [11:0] STAT_RX_DESCRAM_ERR_out;
  wire [11:0] STAT_RX_DIAGWORD_INTFSTAT_out;
  wire [11:0] STAT_RX_DIAGWORD_LANESTAT_out;
  wire [11:0] STAT_RX_FRAMING_ERR_out;
  wire [11:0] STAT_RX_MF_ERR_out;
  wire [11:0] STAT_RX_MF_LEN_ERR_out;
  wire [11:0] STAT_RX_MF_REPEAT_ERR_out;
  wire [11:0] STAT_RX_SYNCED_ERR_out;
  wire [11:0] STAT_RX_SYNCED_out;
  wire [11:0] STAT_RX_WORD_SYNC_out;
  wire [127:0] RX_DATAOUT0_out;
  wire [127:0] RX_DATAOUT1_out;
  wire [127:0] RX_DATAOUT2_out;
  wire [127:0] RX_DATAOUT3_out;
  wire [15:0] DRP_DO_out;
  wire [15:0] STAT_RX_RETRANS_LATENCY_out;
  wire [1:0] STAT_TX_RETRANS_RAM_RSEL_out;
  wire [255:0] STAT_RX_FC_STAT_out;
  wire [264:0] SCAN_OUT_out;
  wire [2:0] STAT_RX_RETRANS_STATE_out;
  wire [3:0] RX_MTYOUT0_out;
  wire [3:0] RX_MTYOUT1_out;
  wire [3:0] RX_MTYOUT2_out;
  wire [3:0] RX_MTYOUT3_out;
  wire [4:0] STAT_RX_RETRANS_SUBSEQ_out;
  wire [63:0] TX_SERDES_DATA00_out;
  wire [63:0] TX_SERDES_DATA01_out;
  wire [63:0] TX_SERDES_DATA02_out;
  wire [63:0] TX_SERDES_DATA03_out;
  wire [63:0] TX_SERDES_DATA04_out;
  wire [63:0] TX_SERDES_DATA05_out;
  wire [63:0] TX_SERDES_DATA06_out;
  wire [63:0] TX_SERDES_DATA07_out;
  wire [63:0] TX_SERDES_DATA08_out;
  wire [63:0] TX_SERDES_DATA09_out;
  wire [63:0] TX_SERDES_DATA10_out;
  wire [63:0] TX_SERDES_DATA11_out;
  wire [643:0] STAT_TX_RETRANS_RAM_WDATA_out;
  wire [65:0] RX_BYPASS_DATAOUT00_out;
  wire [65:0] RX_BYPASS_DATAOUT01_out;
  wire [65:0] RX_BYPASS_DATAOUT02_out;
  wire [65:0] RX_BYPASS_DATAOUT03_out;
  wire [65:0] RX_BYPASS_DATAOUT04_out;
  wire [65:0] RX_BYPASS_DATAOUT05_out;
  wire [65:0] RX_BYPASS_DATAOUT06_out;
  wire [65:0] RX_BYPASS_DATAOUT07_out;
  wire [65:0] RX_BYPASS_DATAOUT08_out;
  wire [65:0] RX_BYPASS_DATAOUT09_out;
  wire [65:0] RX_BYPASS_DATAOUT10_out;
  wire [65:0] RX_BYPASS_DATAOUT11_out;
  wire [7:0] STAT_RX_MUBITS_out;
  wire [7:0] STAT_RX_RETRANS_SEQ_out;
  wire [8:0] STAT_TX_RETRANS_RAM_RADDR_out;
  wire [8:0] STAT_TX_RETRANS_RAM_WADDR_out;

  wire DRP_RDY_delay;
  wire RX_ENAOUT0_delay;
  wire RX_ENAOUT1_delay;
  wire RX_ENAOUT2_delay;
  wire RX_ENAOUT3_delay;
  wire RX_EOPOUT0_delay;
  wire RX_EOPOUT1_delay;
  wire RX_EOPOUT2_delay;
  wire RX_EOPOUT3_delay;
  wire RX_ERROUT0_delay;
  wire RX_ERROUT1_delay;
  wire RX_ERROUT2_delay;
  wire RX_ERROUT3_delay;
  wire RX_OVFOUT_delay;
  wire RX_SOPOUT0_delay;
  wire RX_SOPOUT1_delay;
  wire RX_SOPOUT2_delay;
  wire RX_SOPOUT3_delay;
  wire STAT_RX_ALIGNED_ERR_delay;
  wire STAT_RX_ALIGNED_delay;
  wire STAT_RX_BURSTMAX_ERR_delay;
  wire STAT_RX_BURST_ERR_delay;
  wire STAT_RX_CRC24_ERR_delay;
  wire STAT_RX_MEOP_ERR_delay;
  wire STAT_RX_MISALIGNED_delay;
  wire STAT_RX_MSOP_ERR_delay;
  wire STAT_RX_MUBITS_UPDATED_delay;
  wire STAT_RX_OVERFLOW_ERR_delay;
  wire STAT_RX_RETRANS_CRC24_ERR_delay;
  wire STAT_RX_RETRANS_DISC_delay;
  wire STAT_RX_RETRANS_REQ_delay;
  wire STAT_RX_RETRANS_RETRY_ERR_delay;
  wire STAT_RX_RETRANS_SEQ_UPDATED_delay;
  wire STAT_RX_RETRANS_WDOG_ERR_delay;
  wire STAT_RX_RETRANS_WRAP_ERR_delay;
  wire STAT_TX_BURST_ERR_delay;
  wire STAT_TX_ERRINJ_BITERR_DONE_delay;
  wire STAT_TX_OVERFLOW_ERR_delay;
  wire STAT_TX_RETRANS_BURST_ERR_delay;
  wire STAT_TX_RETRANS_BUSY_delay;
  wire STAT_TX_RETRANS_RAM_PERROUT_delay;
  wire STAT_TX_RETRANS_RAM_RD_B0_delay;
  wire STAT_TX_RETRANS_RAM_RD_B1_delay;
  wire STAT_TX_RETRANS_RAM_RD_B2_delay;
  wire STAT_TX_RETRANS_RAM_RD_B3_delay;
  wire STAT_TX_RETRANS_RAM_WE_B0_delay;
  wire STAT_TX_RETRANS_RAM_WE_B1_delay;
  wire STAT_TX_RETRANS_RAM_WE_B2_delay;
  wire STAT_TX_RETRANS_RAM_WE_B3_delay;
  wire STAT_TX_UNDERFLOW_ERR_delay;
  wire TX_OVFOUT_delay;
  wire TX_RDYOUT_delay;
  wire [10:0] RX_CHANOUT0_delay;
  wire [10:0] RX_CHANOUT1_delay;
  wire [10:0] RX_CHANOUT2_delay;
  wire [10:0] RX_CHANOUT3_delay;
  wire [11:0] RX_BYPASS_ENAOUT_delay;
  wire [11:0] RX_BYPASS_IS_AVAILOUT_delay;
  wire [11:0] RX_BYPASS_IS_BADLYFRAMEDOUT_delay;
  wire [11:0] RX_BYPASS_IS_OVERFLOWOUT_delay;
  wire [11:0] RX_BYPASS_IS_SYNCEDOUT_delay;
  wire [11:0] RX_BYPASS_IS_SYNCWORDOUT_delay;
  wire [11:0] STAT_RX_BAD_TYPE_ERR_delay;
  wire [11:0] STAT_RX_CRC32_ERR_delay;
  wire [11:0] STAT_RX_CRC32_VALID_delay;
  wire [11:0] STAT_RX_DESCRAM_ERR_delay;
  wire [11:0] STAT_RX_DIAGWORD_INTFSTAT_delay;
  wire [11:0] STAT_RX_DIAGWORD_LANESTAT_delay;
  wire [11:0] STAT_RX_FRAMING_ERR_delay;
  wire [11:0] STAT_RX_MF_ERR_delay;
  wire [11:0] STAT_RX_MF_LEN_ERR_delay;
  wire [11:0] STAT_RX_MF_REPEAT_ERR_delay;
  wire [11:0] STAT_RX_SYNCED_ERR_delay;
  wire [11:0] STAT_RX_SYNCED_delay;
  wire [11:0] STAT_RX_WORD_SYNC_delay;
  wire [127:0] RX_DATAOUT0_delay;
  wire [127:0] RX_DATAOUT1_delay;
  wire [127:0] RX_DATAOUT2_delay;
  wire [127:0] RX_DATAOUT3_delay;
  wire [15:0] DRP_DO_delay;
  wire [15:0] STAT_RX_RETRANS_LATENCY_delay;
  wire [1:0] STAT_TX_RETRANS_RAM_RSEL_delay;
  wire [255:0] STAT_RX_FC_STAT_delay;
  wire [2:0] STAT_RX_RETRANS_STATE_delay;
  wire [3:0] RX_MTYOUT0_delay;
  wire [3:0] RX_MTYOUT1_delay;
  wire [3:0] RX_MTYOUT2_delay;
  wire [3:0] RX_MTYOUT3_delay;
  wire [4:0] STAT_RX_RETRANS_SUBSEQ_delay;
  wire [63:0] TX_SERDES_DATA00_delay;
  wire [63:0] TX_SERDES_DATA01_delay;
  wire [63:0] TX_SERDES_DATA02_delay;
  wire [63:0] TX_SERDES_DATA03_delay;
  wire [63:0] TX_SERDES_DATA04_delay;
  wire [63:0] TX_SERDES_DATA05_delay;
  wire [63:0] TX_SERDES_DATA06_delay;
  wire [63:0] TX_SERDES_DATA07_delay;
  wire [63:0] TX_SERDES_DATA08_delay;
  wire [63:0] TX_SERDES_DATA09_delay;
  wire [63:0] TX_SERDES_DATA10_delay;
  wire [63:0] TX_SERDES_DATA11_delay;
  wire [643:0] STAT_TX_RETRANS_RAM_WDATA_delay;
  wire [65:0] RX_BYPASS_DATAOUT00_delay;
  wire [65:0] RX_BYPASS_DATAOUT01_delay;
  wire [65:0] RX_BYPASS_DATAOUT02_delay;
  wire [65:0] RX_BYPASS_DATAOUT03_delay;
  wire [65:0] RX_BYPASS_DATAOUT04_delay;
  wire [65:0] RX_BYPASS_DATAOUT05_delay;
  wire [65:0] RX_BYPASS_DATAOUT06_delay;
  wire [65:0] RX_BYPASS_DATAOUT07_delay;
  wire [65:0] RX_BYPASS_DATAOUT08_delay;
  wire [65:0] RX_BYPASS_DATAOUT09_delay;
  wire [65:0] RX_BYPASS_DATAOUT10_delay;
  wire [65:0] RX_BYPASS_DATAOUT11_delay;
  wire [7:0] STAT_RX_MUBITS_delay;
  wire [7:0] STAT_RX_RETRANS_SEQ_delay;
  wire [8:0] STAT_TX_RETRANS_RAM_RADDR_delay;
  wire [8:0] STAT_TX_RETRANS_RAM_WADDR_delay;

  wire CORE_CLK_in;
  wire CTL_RX_FORCE_RESYNC_in;
  wire CTL_RX_RETRANS_ACK_in;
  wire CTL_RX_RETRANS_ENABLE_in;
  wire CTL_RX_RETRANS_ERRIN_in;
  wire CTL_RX_RETRANS_FORCE_REQ_in;
  wire CTL_RX_RETRANS_RESET_MODE_in;
  wire CTL_RX_RETRANS_RESET_in;
  wire CTL_TX_DIAGWORD_INTFSTAT_in;
  wire CTL_TX_ENABLE_in;
  wire CTL_TX_ERRINJ_BITERR_GO_in;
  wire CTL_TX_RETRANS_ENABLE_in;
  wire CTL_TX_RETRANS_RAM_PERRIN_in;
  wire CTL_TX_RETRANS_REQ_VALID_in;
  wire CTL_TX_RETRANS_REQ_in;
  wire CTL_TX_RLIM_ENABLE_in;
  wire DRP_CLK_in;
  wire DRP_EN_in;
  wire DRP_WE_in;
  wire LBUS_CLK_in;
  wire RX_BYPASS_FORCE_REALIGNIN_in;
  wire RX_BYPASS_RDIN_in;
  wire RX_RESET_in;
  wire SCAN_EN_N_in;
  wire TEST_MODE_N_in;
  wire TEST_RESET_in;
  wire TX_BCTLIN0_in;
  wire TX_BCTLIN1_in;
  wire TX_BCTLIN2_in;
  wire TX_BCTLIN3_in;
  wire TX_BYPASS_ENAIN_in;
  wire TX_ENAIN0_in;
  wire TX_ENAIN1_in;
  wire TX_ENAIN2_in;
  wire TX_ENAIN3_in;
  wire TX_EOPIN0_in;
  wire TX_EOPIN1_in;
  wire TX_EOPIN2_in;
  wire TX_EOPIN3_in;
  wire TX_ERRIN0_in;
  wire TX_ERRIN1_in;
  wire TX_ERRIN2_in;
  wire TX_ERRIN3_in;
  wire TX_RESET_in;
  wire TX_SERDES_REFCLK_RESET_in;
  wire TX_SERDES_REFCLK_in;
  wire TX_SOPIN0_in;
  wire TX_SOPIN1_in;
  wire TX_SOPIN2_in;
  wire TX_SOPIN3_in;
  wire [10:0] TX_CHANIN0_in;
  wire [10:0] TX_CHANIN1_in;
  wire [10:0] TX_CHANIN2_in;
  wire [10:0] TX_CHANIN3_in;
  wire [11:0] CTL_TX_DIAGWORD_LANESTAT_in;
  wire [11:0] CTL_TX_RLIM_DELTA_in;
  wire [11:0] CTL_TX_RLIM_MAX_in;
  wire [11:0] RX_SERDES_CLK_in;
  wire [11:0] RX_SERDES_RESET_in;
  wire [11:0] TX_BYPASS_CTRLIN_in;
  wire [127:0] TX_DATAIN0_in;
  wire [127:0] TX_DATAIN1_in;
  wire [127:0] TX_DATAIN2_in;
  wire [127:0] TX_DATAIN3_in;
  wire [15:0] DRP_DI_in;
  wire [255:0] CTL_TX_FC_STAT_in;
  wire [264:0] SCAN_IN_in;
  wire [3:0] CTL_TX_ERRINJ_BITERR_LANE_in;
  wire [3:0] TX_BYPASS_MFRAMER_STATEIN_in;
  wire [3:0] TX_MTYIN0_in;
  wire [3:0] TX_MTYIN1_in;
  wire [3:0] TX_MTYIN2_in;
  wire [3:0] TX_MTYIN3_in;
  wire [63:0] RX_SERDES_DATA00_in;
  wire [63:0] RX_SERDES_DATA01_in;
  wire [63:0] RX_SERDES_DATA02_in;
  wire [63:0] RX_SERDES_DATA03_in;
  wire [63:0] RX_SERDES_DATA04_in;
  wire [63:0] RX_SERDES_DATA05_in;
  wire [63:0] RX_SERDES_DATA06_in;
  wire [63:0] RX_SERDES_DATA07_in;
  wire [63:0] RX_SERDES_DATA08_in;
  wire [63:0] RX_SERDES_DATA09_in;
  wire [63:0] RX_SERDES_DATA10_in;
  wire [63:0] RX_SERDES_DATA11_in;
  wire [63:0] TX_BYPASS_DATAIN00_in;
  wire [63:0] TX_BYPASS_DATAIN01_in;
  wire [63:0] TX_BYPASS_DATAIN02_in;
  wire [63:0] TX_BYPASS_DATAIN03_in;
  wire [63:0] TX_BYPASS_DATAIN04_in;
  wire [63:0] TX_BYPASS_DATAIN05_in;
  wire [63:0] TX_BYPASS_DATAIN06_in;
  wire [63:0] TX_BYPASS_DATAIN07_in;
  wire [63:0] TX_BYPASS_DATAIN08_in;
  wire [63:0] TX_BYPASS_DATAIN09_in;
  wire [63:0] TX_BYPASS_DATAIN10_in;
  wire [63:0] TX_BYPASS_DATAIN11_in;
  wire [643:0] CTL_TX_RETRANS_RAM_RDATA_in;
  wire [7:0] CTL_TX_MUBITS_in;
  wire [7:0] CTL_TX_RLIM_INTV_in;
  wire [7:0] TX_BYPASS_GEARBOX_SEQIN_in;
  wire [9:0] DRP_ADDR_in;

  wire CORE_CLK_delay;
  wire CTL_RX_FORCE_RESYNC_delay;
  wire CTL_RX_RETRANS_ACK_delay;
  wire CTL_RX_RETRANS_ENABLE_delay;
  wire CTL_RX_RETRANS_ERRIN_delay;
  wire CTL_RX_RETRANS_FORCE_REQ_delay;
  wire CTL_RX_RETRANS_RESET_MODE_delay;
  wire CTL_RX_RETRANS_RESET_delay;
  wire CTL_TX_DIAGWORD_INTFSTAT_delay;
  wire CTL_TX_ENABLE_delay;
  wire CTL_TX_ERRINJ_BITERR_GO_delay;
  wire CTL_TX_RETRANS_ENABLE_delay;
  wire CTL_TX_RETRANS_RAM_PERRIN_delay;
  wire CTL_TX_RETRANS_REQ_VALID_delay;
  wire CTL_TX_RETRANS_REQ_delay;
  wire CTL_TX_RLIM_ENABLE_delay;
  wire DRP_CLK_delay;
  wire DRP_EN_delay;
  wire DRP_WE_delay;
  wire LBUS_CLK_delay;
  wire RX_BYPASS_FORCE_REALIGNIN_delay;
  wire RX_BYPASS_RDIN_delay;
  wire RX_RESET_delay;
  wire TX_BCTLIN0_delay;
  wire TX_BCTLIN1_delay;
  wire TX_BCTLIN2_delay;
  wire TX_BCTLIN3_delay;
  wire TX_BYPASS_ENAIN_delay;
  wire TX_ENAIN0_delay;
  wire TX_ENAIN1_delay;
  wire TX_ENAIN2_delay;
  wire TX_ENAIN3_delay;
  wire TX_EOPIN0_delay;
  wire TX_EOPIN1_delay;
  wire TX_EOPIN2_delay;
  wire TX_EOPIN3_delay;
  wire TX_ERRIN0_delay;
  wire TX_ERRIN1_delay;
  wire TX_ERRIN2_delay;
  wire TX_ERRIN3_delay;
  wire TX_RESET_delay;
  wire TX_SERDES_REFCLK_RESET_delay;
  wire TX_SERDES_REFCLK_delay;
  wire TX_SOPIN0_delay;
  wire TX_SOPIN1_delay;
  wire TX_SOPIN2_delay;
  wire TX_SOPIN3_delay;
  wire [10:0] TX_CHANIN0_delay;
  wire [10:0] TX_CHANIN1_delay;
  wire [10:0] TX_CHANIN2_delay;
  wire [10:0] TX_CHANIN3_delay;
  wire [11:0] CTL_TX_DIAGWORD_LANESTAT_delay;
  wire [11:0] CTL_TX_RLIM_DELTA_delay;
  wire [11:0] CTL_TX_RLIM_MAX_delay;
  wire [11:0] RX_SERDES_CLK_delay;
  wire [11:0] RX_SERDES_RESET_delay;
  wire [11:0] TX_BYPASS_CTRLIN_delay;
  wire [127:0] TX_DATAIN0_delay;
  wire [127:0] TX_DATAIN1_delay;
  wire [127:0] TX_DATAIN2_delay;
  wire [127:0] TX_DATAIN3_delay;
  wire [15:0] DRP_DI_delay;
  wire [255:0] CTL_TX_FC_STAT_delay;
  wire [3:0] CTL_TX_ERRINJ_BITERR_LANE_delay;
  wire [3:0] TX_BYPASS_MFRAMER_STATEIN_delay;
  wire [3:0] TX_MTYIN0_delay;
  wire [3:0] TX_MTYIN1_delay;
  wire [3:0] TX_MTYIN2_delay;
  wire [3:0] TX_MTYIN3_delay;
  wire [63:0] RX_SERDES_DATA00_delay;
  wire [63:0] RX_SERDES_DATA01_delay;
  wire [63:0] RX_SERDES_DATA02_delay;
  wire [63:0] RX_SERDES_DATA03_delay;
  wire [63:0] RX_SERDES_DATA04_delay;
  wire [63:0] RX_SERDES_DATA05_delay;
  wire [63:0] RX_SERDES_DATA06_delay;
  wire [63:0] RX_SERDES_DATA07_delay;
  wire [63:0] RX_SERDES_DATA08_delay;
  wire [63:0] RX_SERDES_DATA09_delay;
  wire [63:0] RX_SERDES_DATA10_delay;
  wire [63:0] RX_SERDES_DATA11_delay;
  wire [63:0] TX_BYPASS_DATAIN00_delay;
  wire [63:0] TX_BYPASS_DATAIN01_delay;
  wire [63:0] TX_BYPASS_DATAIN02_delay;
  wire [63:0] TX_BYPASS_DATAIN03_delay;
  wire [63:0] TX_BYPASS_DATAIN04_delay;
  wire [63:0] TX_BYPASS_DATAIN05_delay;
  wire [63:0] TX_BYPASS_DATAIN06_delay;
  wire [63:0] TX_BYPASS_DATAIN07_delay;
  wire [63:0] TX_BYPASS_DATAIN08_delay;
  wire [63:0] TX_BYPASS_DATAIN09_delay;
  wire [63:0] TX_BYPASS_DATAIN10_delay;
  wire [63:0] TX_BYPASS_DATAIN11_delay;
  wire [643:0] CTL_TX_RETRANS_RAM_RDATA_delay;
  wire [7:0] CTL_TX_MUBITS_delay;
  wire [7:0] CTL_TX_RLIM_INTV_delay;
  wire [7:0] TX_BYPASS_GEARBOX_SEQIN_delay;
  wire [9:0] DRP_ADDR_delay;

  
  assign #(out_delay) DRP_DO = DRP_DO_delay;
  assign #(out_delay) DRP_RDY = DRP_RDY_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT00 = RX_BYPASS_DATAOUT00_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT01 = RX_BYPASS_DATAOUT01_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT02 = RX_BYPASS_DATAOUT02_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT03 = RX_BYPASS_DATAOUT03_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT04 = RX_BYPASS_DATAOUT04_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT05 = RX_BYPASS_DATAOUT05_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT06 = RX_BYPASS_DATAOUT06_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT07 = RX_BYPASS_DATAOUT07_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT08 = RX_BYPASS_DATAOUT08_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT09 = RX_BYPASS_DATAOUT09_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT10 = RX_BYPASS_DATAOUT10_delay;
  assign #(out_delay) RX_BYPASS_DATAOUT11 = RX_BYPASS_DATAOUT11_delay;
  assign #(out_delay) RX_BYPASS_ENAOUT = RX_BYPASS_ENAOUT_delay;
  assign #(out_delay) RX_BYPASS_IS_AVAILOUT = RX_BYPASS_IS_AVAILOUT_delay;
  assign #(out_delay) RX_BYPASS_IS_BADLYFRAMEDOUT = RX_BYPASS_IS_BADLYFRAMEDOUT_delay;
  assign #(out_delay) RX_BYPASS_IS_OVERFLOWOUT = RX_BYPASS_IS_OVERFLOWOUT_delay;
  assign #(out_delay) RX_BYPASS_IS_SYNCEDOUT = RX_BYPASS_IS_SYNCEDOUT_delay;
  assign #(out_delay) RX_BYPASS_IS_SYNCWORDOUT = RX_BYPASS_IS_SYNCWORDOUT_delay;
  assign #(out_delay) RX_CHANOUT0 = RX_CHANOUT0_delay;
  assign #(out_delay) RX_CHANOUT1 = RX_CHANOUT1_delay;
  assign #(out_delay) RX_CHANOUT2 = RX_CHANOUT2_delay;
  assign #(out_delay) RX_CHANOUT3 = RX_CHANOUT3_delay;
  assign #(out_delay) RX_DATAOUT0 = RX_DATAOUT0_delay;
  assign #(out_delay) RX_DATAOUT1 = RX_DATAOUT1_delay;
  assign #(out_delay) RX_DATAOUT2 = RX_DATAOUT2_delay;
  assign #(out_delay) RX_DATAOUT3 = RX_DATAOUT3_delay;
  assign #(out_delay) RX_ENAOUT0 = RX_ENAOUT0_delay;
  assign #(out_delay) RX_ENAOUT1 = RX_ENAOUT1_delay;
  assign #(out_delay) RX_ENAOUT2 = RX_ENAOUT2_delay;
  assign #(out_delay) RX_ENAOUT3 = RX_ENAOUT3_delay;
  assign #(out_delay) RX_EOPOUT0 = RX_EOPOUT0_delay;
  assign #(out_delay) RX_EOPOUT1 = RX_EOPOUT1_delay;
  assign #(out_delay) RX_EOPOUT2 = RX_EOPOUT2_delay;
  assign #(out_delay) RX_EOPOUT3 = RX_EOPOUT3_delay;
  assign #(out_delay) RX_ERROUT0 = RX_ERROUT0_delay;
  assign #(out_delay) RX_ERROUT1 = RX_ERROUT1_delay;
  assign #(out_delay) RX_ERROUT2 = RX_ERROUT2_delay;
  assign #(out_delay) RX_ERROUT3 = RX_ERROUT3_delay;
  assign #(out_delay) RX_MTYOUT0 = RX_MTYOUT0_delay;
  assign #(out_delay) RX_MTYOUT1 = RX_MTYOUT1_delay;
  assign #(out_delay) RX_MTYOUT2 = RX_MTYOUT2_delay;
  assign #(out_delay) RX_MTYOUT3 = RX_MTYOUT3_delay;
  assign #(out_delay) RX_OVFOUT = RX_OVFOUT_delay;
  assign #(out_delay) RX_SOPOUT0 = RX_SOPOUT0_delay;
  assign #(out_delay) RX_SOPOUT1 = RX_SOPOUT1_delay;
  assign #(out_delay) RX_SOPOUT2 = RX_SOPOUT2_delay;
  assign #(out_delay) RX_SOPOUT3 = RX_SOPOUT3_delay;
  assign #(out_delay) STAT_RX_ALIGNED = STAT_RX_ALIGNED_delay;
  assign #(out_delay) STAT_RX_ALIGNED_ERR = STAT_RX_ALIGNED_ERR_delay;
  assign #(out_delay) STAT_RX_BAD_TYPE_ERR = STAT_RX_BAD_TYPE_ERR_delay;
  assign #(out_delay) STAT_RX_BURSTMAX_ERR = STAT_RX_BURSTMAX_ERR_delay;
  assign #(out_delay) STAT_RX_BURST_ERR = STAT_RX_BURST_ERR_delay;
  assign #(out_delay) STAT_RX_CRC24_ERR = STAT_RX_CRC24_ERR_delay;
  assign #(out_delay) STAT_RX_CRC32_ERR = STAT_RX_CRC32_ERR_delay;
  assign #(out_delay) STAT_RX_CRC32_VALID = STAT_RX_CRC32_VALID_delay;
  assign #(out_delay) STAT_RX_DESCRAM_ERR = STAT_RX_DESCRAM_ERR_delay;
  assign #(out_delay) STAT_RX_DIAGWORD_INTFSTAT = STAT_RX_DIAGWORD_INTFSTAT_delay;
  assign #(out_delay) STAT_RX_DIAGWORD_LANESTAT = STAT_RX_DIAGWORD_LANESTAT_delay;
  assign #(out_delay) STAT_RX_FC_STAT = STAT_RX_FC_STAT_delay;
  assign #(out_delay) STAT_RX_FRAMING_ERR = STAT_RX_FRAMING_ERR_delay;
  assign #(out_delay) STAT_RX_MEOP_ERR = STAT_RX_MEOP_ERR_delay;
  assign #(out_delay) STAT_RX_MF_ERR = STAT_RX_MF_ERR_delay;
  assign #(out_delay) STAT_RX_MF_LEN_ERR = STAT_RX_MF_LEN_ERR_delay;
  assign #(out_delay) STAT_RX_MF_REPEAT_ERR = STAT_RX_MF_REPEAT_ERR_delay;
  assign #(out_delay) STAT_RX_MISALIGNED = STAT_RX_MISALIGNED_delay;
  assign #(out_delay) STAT_RX_MSOP_ERR = STAT_RX_MSOP_ERR_delay;
  assign #(out_delay) STAT_RX_MUBITS = STAT_RX_MUBITS_delay;
  assign #(out_delay) STAT_RX_MUBITS_UPDATED = STAT_RX_MUBITS_UPDATED_delay;
  assign #(out_delay) STAT_RX_OVERFLOW_ERR = STAT_RX_OVERFLOW_ERR_delay;
  assign #(out_delay) STAT_RX_RETRANS_CRC24_ERR = STAT_RX_RETRANS_CRC24_ERR_delay;
  assign #(out_delay) STAT_RX_RETRANS_DISC = STAT_RX_RETRANS_DISC_delay;
  assign #(out_delay) STAT_RX_RETRANS_LATENCY = STAT_RX_RETRANS_LATENCY_delay;
  assign #(out_delay) STAT_RX_RETRANS_REQ = STAT_RX_RETRANS_REQ_delay;
  assign #(out_delay) STAT_RX_RETRANS_RETRY_ERR = STAT_RX_RETRANS_RETRY_ERR_delay;
  assign #(out_delay) STAT_RX_RETRANS_SEQ = STAT_RX_RETRANS_SEQ_delay;
  assign #(out_delay) STAT_RX_RETRANS_SEQ_UPDATED = STAT_RX_RETRANS_SEQ_UPDATED_delay;
  assign #(out_delay) STAT_RX_RETRANS_STATE = STAT_RX_RETRANS_STATE_delay;
  assign #(out_delay) STAT_RX_RETRANS_SUBSEQ = STAT_RX_RETRANS_SUBSEQ_delay;
  assign #(out_delay) STAT_RX_RETRANS_WDOG_ERR = STAT_RX_RETRANS_WDOG_ERR_delay;
  assign #(out_delay) STAT_RX_RETRANS_WRAP_ERR = STAT_RX_RETRANS_WRAP_ERR_delay;
  assign #(out_delay) STAT_RX_SYNCED = STAT_RX_SYNCED_delay;
  assign #(out_delay) STAT_RX_SYNCED_ERR = STAT_RX_SYNCED_ERR_delay;
  assign #(out_delay) STAT_RX_WORD_SYNC = STAT_RX_WORD_SYNC_delay;
  assign #(out_delay) STAT_TX_BURST_ERR = STAT_TX_BURST_ERR_delay;
  assign #(out_delay) STAT_TX_ERRINJ_BITERR_DONE = STAT_TX_ERRINJ_BITERR_DONE_delay;
  assign #(out_delay) STAT_TX_OVERFLOW_ERR = STAT_TX_OVERFLOW_ERR_delay;
  assign #(out_delay) STAT_TX_RETRANS_BURST_ERR = STAT_TX_RETRANS_BURST_ERR_delay;
  assign #(out_delay) STAT_TX_RETRANS_BUSY = STAT_TX_RETRANS_BUSY_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_PERROUT = STAT_TX_RETRANS_RAM_PERROUT_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RADDR = STAT_TX_RETRANS_RAM_RADDR_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RD_B0 = STAT_TX_RETRANS_RAM_RD_B0_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RD_B1 = STAT_TX_RETRANS_RAM_RD_B1_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RD_B2 = STAT_TX_RETRANS_RAM_RD_B2_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RD_B3 = STAT_TX_RETRANS_RAM_RD_B3_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_RSEL = STAT_TX_RETRANS_RAM_RSEL_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WADDR = STAT_TX_RETRANS_RAM_WADDR_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WDATA = STAT_TX_RETRANS_RAM_WDATA_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WE_B0 = STAT_TX_RETRANS_RAM_WE_B0_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WE_B1 = STAT_TX_RETRANS_RAM_WE_B1_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WE_B2 = STAT_TX_RETRANS_RAM_WE_B2_delay;
  assign #(out_delay) STAT_TX_RETRANS_RAM_WE_B3 = STAT_TX_RETRANS_RAM_WE_B3_delay;
  assign #(out_delay) STAT_TX_UNDERFLOW_ERR = STAT_TX_UNDERFLOW_ERR_delay;
  assign #(out_delay) TX_OVFOUT = TX_OVFOUT_delay;
  assign #(out_delay) TX_RDYOUT = TX_RDYOUT_delay;
  assign #(out_delay) TX_SERDES_DATA00 = TX_SERDES_DATA00_delay;
  assign #(out_delay) TX_SERDES_DATA01 = TX_SERDES_DATA01_delay;
  assign #(out_delay) TX_SERDES_DATA02 = TX_SERDES_DATA02_delay;
  assign #(out_delay) TX_SERDES_DATA03 = TX_SERDES_DATA03_delay;
  assign #(out_delay) TX_SERDES_DATA04 = TX_SERDES_DATA04_delay;
  assign #(out_delay) TX_SERDES_DATA05 = TX_SERDES_DATA05_delay;
  assign #(out_delay) TX_SERDES_DATA06 = TX_SERDES_DATA06_delay;
  assign #(out_delay) TX_SERDES_DATA07 = TX_SERDES_DATA07_delay;
  assign #(out_delay) TX_SERDES_DATA08 = TX_SERDES_DATA08_delay;
  assign #(out_delay) TX_SERDES_DATA09 = TX_SERDES_DATA09_delay;
  assign #(out_delay) TX_SERDES_DATA10 = TX_SERDES_DATA10_delay;
  assign #(out_delay) TX_SERDES_DATA11 = TX_SERDES_DATA11_delay;
  

// inputs with no timing checks
  assign #(inclk_delay) CORE_CLK_delay = CORE_CLK;
  assign #(inclk_delay) DRP_CLK_delay = DRP_CLK;
  assign #(inclk_delay) LBUS_CLK_delay = LBUS_CLK;
  assign #(inclk_delay) RX_SERDES_CLK_delay = RX_SERDES_CLK;
  assign #(inclk_delay) TX_SERDES_REFCLK_delay = TX_SERDES_REFCLK;

  assign #(in_delay) CTL_RX_FORCE_RESYNC_delay = CTL_RX_FORCE_RESYNC;
  assign #(in_delay) CTL_RX_RETRANS_ACK_delay = CTL_RX_RETRANS_ACK;
  assign #(in_delay) CTL_RX_RETRANS_ENABLE_delay = CTL_RX_RETRANS_ENABLE;
  assign #(in_delay) CTL_RX_RETRANS_ERRIN_delay = CTL_RX_RETRANS_ERRIN;
  assign #(in_delay) CTL_RX_RETRANS_FORCE_REQ_delay = CTL_RX_RETRANS_FORCE_REQ;
  assign #(in_delay) CTL_RX_RETRANS_RESET_MODE_delay = CTL_RX_RETRANS_RESET_MODE;
  assign #(in_delay) CTL_RX_RETRANS_RESET_delay = CTL_RX_RETRANS_RESET;
  assign #(in_delay) CTL_TX_DIAGWORD_INTFSTAT_delay = CTL_TX_DIAGWORD_INTFSTAT;
  assign #(in_delay) CTL_TX_DIAGWORD_LANESTAT_delay = CTL_TX_DIAGWORD_LANESTAT;
  assign #(in_delay) CTL_TX_ENABLE_delay = CTL_TX_ENABLE;
  assign #(in_delay) CTL_TX_ERRINJ_BITERR_GO_delay = CTL_TX_ERRINJ_BITERR_GO;
  assign #(in_delay) CTL_TX_ERRINJ_BITERR_LANE_delay = CTL_TX_ERRINJ_BITERR_LANE;
  assign #(in_delay) CTL_TX_FC_STAT_delay = CTL_TX_FC_STAT;
  assign #(in_delay) CTL_TX_MUBITS_delay = CTL_TX_MUBITS;
  assign #(in_delay) CTL_TX_RETRANS_ENABLE_delay = CTL_TX_RETRANS_ENABLE;
  assign #(in_delay) CTL_TX_RETRANS_RAM_PERRIN_delay = CTL_TX_RETRANS_RAM_PERRIN;
  assign #(in_delay) CTL_TX_RETRANS_RAM_RDATA_delay = CTL_TX_RETRANS_RAM_RDATA;
  assign #(in_delay) CTL_TX_RETRANS_REQ_VALID_delay = CTL_TX_RETRANS_REQ_VALID;
  assign #(in_delay) CTL_TX_RETRANS_REQ_delay = CTL_TX_RETRANS_REQ;
  assign #(in_delay) CTL_TX_RLIM_DELTA_delay = CTL_TX_RLIM_DELTA;
  assign #(in_delay) CTL_TX_RLIM_ENABLE_delay = CTL_TX_RLIM_ENABLE;
  assign #(in_delay) CTL_TX_RLIM_INTV_delay = CTL_TX_RLIM_INTV;
  assign #(in_delay) CTL_TX_RLIM_MAX_delay = CTL_TX_RLIM_MAX;
  assign #(in_delay) DRP_ADDR_delay = DRP_ADDR;
  assign #(in_delay) DRP_DI_delay = DRP_DI;
  assign #(in_delay) DRP_EN_delay = DRP_EN;
  assign #(in_delay) DRP_WE_delay = DRP_WE;
  assign #(in_delay) RX_BYPASS_FORCE_REALIGNIN_delay = RX_BYPASS_FORCE_REALIGNIN;
  assign #(in_delay) RX_BYPASS_RDIN_delay = RX_BYPASS_RDIN;
  assign #(in_delay) RX_RESET_delay = RX_RESET;
  assign #(in_delay) RX_SERDES_DATA00_delay = RX_SERDES_DATA00;
  assign #(in_delay) RX_SERDES_DATA01_delay = RX_SERDES_DATA01;
  assign #(in_delay) RX_SERDES_DATA02_delay = RX_SERDES_DATA02;
  assign #(in_delay) RX_SERDES_DATA03_delay = RX_SERDES_DATA03;
  assign #(in_delay) RX_SERDES_DATA04_delay = RX_SERDES_DATA04;
  assign #(in_delay) RX_SERDES_DATA05_delay = RX_SERDES_DATA05;
  assign #(in_delay) RX_SERDES_DATA06_delay = RX_SERDES_DATA06;
  assign #(in_delay) RX_SERDES_DATA07_delay = RX_SERDES_DATA07;
  assign #(in_delay) RX_SERDES_DATA08_delay = RX_SERDES_DATA08;
  assign #(in_delay) RX_SERDES_DATA09_delay = RX_SERDES_DATA09;
  assign #(in_delay) RX_SERDES_DATA10_delay = RX_SERDES_DATA10;
  assign #(in_delay) RX_SERDES_DATA11_delay = RX_SERDES_DATA11;
  assign #(in_delay) RX_SERDES_RESET_delay = RX_SERDES_RESET;
  assign #(in_delay) TX_BCTLIN0_delay = TX_BCTLIN0;
  assign #(in_delay) TX_BCTLIN1_delay = TX_BCTLIN1;
  assign #(in_delay) TX_BCTLIN2_delay = TX_BCTLIN2;
  assign #(in_delay) TX_BCTLIN3_delay = TX_BCTLIN3;
  assign #(in_delay) TX_BYPASS_CTRLIN_delay = TX_BYPASS_CTRLIN;
  assign #(in_delay) TX_BYPASS_DATAIN00_delay = TX_BYPASS_DATAIN00;
  assign #(in_delay) TX_BYPASS_DATAIN01_delay = TX_BYPASS_DATAIN01;
  assign #(in_delay) TX_BYPASS_DATAIN02_delay = TX_BYPASS_DATAIN02;
  assign #(in_delay) TX_BYPASS_DATAIN03_delay = TX_BYPASS_DATAIN03;
  assign #(in_delay) TX_BYPASS_DATAIN04_delay = TX_BYPASS_DATAIN04;
  assign #(in_delay) TX_BYPASS_DATAIN05_delay = TX_BYPASS_DATAIN05;
  assign #(in_delay) TX_BYPASS_DATAIN06_delay = TX_BYPASS_DATAIN06;
  assign #(in_delay) TX_BYPASS_DATAIN07_delay = TX_BYPASS_DATAIN07;
  assign #(in_delay) TX_BYPASS_DATAIN08_delay = TX_BYPASS_DATAIN08;
  assign #(in_delay) TX_BYPASS_DATAIN09_delay = TX_BYPASS_DATAIN09;
  assign #(in_delay) TX_BYPASS_DATAIN10_delay = TX_BYPASS_DATAIN10;
  assign #(in_delay) TX_BYPASS_DATAIN11_delay = TX_BYPASS_DATAIN11;
  assign #(in_delay) TX_BYPASS_ENAIN_delay = TX_BYPASS_ENAIN;
  assign #(in_delay) TX_BYPASS_GEARBOX_SEQIN_delay = TX_BYPASS_GEARBOX_SEQIN;
  assign #(in_delay) TX_BYPASS_MFRAMER_STATEIN_delay = TX_BYPASS_MFRAMER_STATEIN;
  assign #(in_delay) TX_CHANIN0_delay = TX_CHANIN0;
  assign #(in_delay) TX_CHANIN1_delay = TX_CHANIN1;
  assign #(in_delay) TX_CHANIN2_delay = TX_CHANIN2;
  assign #(in_delay) TX_CHANIN3_delay = TX_CHANIN3;
  assign #(in_delay) TX_DATAIN0_delay = TX_DATAIN0;
  assign #(in_delay) TX_DATAIN1_delay = TX_DATAIN1;
  assign #(in_delay) TX_DATAIN2_delay = TX_DATAIN2;
  assign #(in_delay) TX_DATAIN3_delay = TX_DATAIN3;
  assign #(in_delay) TX_ENAIN0_delay = TX_ENAIN0;
  assign #(in_delay) TX_ENAIN1_delay = TX_ENAIN1;
  assign #(in_delay) TX_ENAIN2_delay = TX_ENAIN2;
  assign #(in_delay) TX_ENAIN3_delay = TX_ENAIN3;
  assign #(in_delay) TX_EOPIN0_delay = TX_EOPIN0;
  assign #(in_delay) TX_EOPIN1_delay = TX_EOPIN1;
  assign #(in_delay) TX_EOPIN2_delay = TX_EOPIN2;
  assign #(in_delay) TX_EOPIN3_delay = TX_EOPIN3;
  assign #(in_delay) TX_ERRIN0_delay = TX_ERRIN0;
  assign #(in_delay) TX_ERRIN1_delay = TX_ERRIN1;
  assign #(in_delay) TX_ERRIN2_delay = TX_ERRIN2;
  assign #(in_delay) TX_ERRIN3_delay = TX_ERRIN3;
  assign #(in_delay) TX_MTYIN0_delay = TX_MTYIN0;
  assign #(in_delay) TX_MTYIN1_delay = TX_MTYIN1;
  assign #(in_delay) TX_MTYIN2_delay = TX_MTYIN2;
  assign #(in_delay) TX_MTYIN3_delay = TX_MTYIN3;
  assign #(in_delay) TX_RESET_delay = TX_RESET;
  assign #(in_delay) TX_SERDES_REFCLK_RESET_delay = TX_SERDES_REFCLK_RESET;
  assign #(in_delay) TX_SOPIN0_delay = TX_SOPIN0;
  assign #(in_delay) TX_SOPIN1_delay = TX_SOPIN1;
  assign #(in_delay) TX_SOPIN2_delay = TX_SOPIN2;
  assign #(in_delay) TX_SOPIN3_delay = TX_SOPIN3;

  assign DRP_DO_delay = DRP_DO_out;
  assign DRP_RDY_delay = DRP_RDY_out;
  assign RX_BYPASS_DATAOUT00_delay = RX_BYPASS_DATAOUT00_out;
  assign RX_BYPASS_DATAOUT01_delay = RX_BYPASS_DATAOUT01_out;
  assign RX_BYPASS_DATAOUT02_delay = RX_BYPASS_DATAOUT02_out;
  assign RX_BYPASS_DATAOUT03_delay = RX_BYPASS_DATAOUT03_out;
  assign RX_BYPASS_DATAOUT04_delay = RX_BYPASS_DATAOUT04_out;
  assign RX_BYPASS_DATAOUT05_delay = RX_BYPASS_DATAOUT05_out;
  assign RX_BYPASS_DATAOUT06_delay = RX_BYPASS_DATAOUT06_out;
  assign RX_BYPASS_DATAOUT07_delay = RX_BYPASS_DATAOUT07_out;
  assign RX_BYPASS_DATAOUT08_delay = RX_BYPASS_DATAOUT08_out;
  assign RX_BYPASS_DATAOUT09_delay = RX_BYPASS_DATAOUT09_out;
  assign RX_BYPASS_DATAOUT10_delay = RX_BYPASS_DATAOUT10_out;
  assign RX_BYPASS_DATAOUT11_delay = RX_BYPASS_DATAOUT11_out;
  assign RX_BYPASS_ENAOUT_delay = RX_BYPASS_ENAOUT_out;
  assign RX_BYPASS_IS_AVAILOUT_delay = RX_BYPASS_IS_AVAILOUT_out;
  assign RX_BYPASS_IS_BADLYFRAMEDOUT_delay = RX_BYPASS_IS_BADLYFRAMEDOUT_out;
  assign RX_BYPASS_IS_OVERFLOWOUT_delay = RX_BYPASS_IS_OVERFLOWOUT_out;
  assign RX_BYPASS_IS_SYNCEDOUT_delay = RX_BYPASS_IS_SYNCEDOUT_out;
  assign RX_BYPASS_IS_SYNCWORDOUT_delay = RX_BYPASS_IS_SYNCWORDOUT_out;
  assign RX_CHANOUT0_delay = RX_CHANOUT0_out;
  assign RX_CHANOUT1_delay = RX_CHANOUT1_out;
  assign RX_CHANOUT2_delay = RX_CHANOUT2_out;
  assign RX_CHANOUT3_delay = RX_CHANOUT3_out;
  assign RX_DATAOUT0_delay = RX_DATAOUT0_out;
  assign RX_DATAOUT1_delay = RX_DATAOUT1_out;
  assign RX_DATAOUT2_delay = RX_DATAOUT2_out;
  assign RX_DATAOUT3_delay = RX_DATAOUT3_out;
  assign RX_ENAOUT0_delay = RX_ENAOUT0_out;
  assign RX_ENAOUT1_delay = RX_ENAOUT1_out;
  assign RX_ENAOUT2_delay = RX_ENAOUT2_out;
  assign RX_ENAOUT3_delay = RX_ENAOUT3_out;
  assign RX_EOPOUT0_delay = RX_EOPOUT0_out;
  assign RX_EOPOUT1_delay = RX_EOPOUT1_out;
  assign RX_EOPOUT2_delay = RX_EOPOUT2_out;
  assign RX_EOPOUT3_delay = RX_EOPOUT3_out;
  assign RX_ERROUT0_delay = RX_ERROUT0_out;
  assign RX_ERROUT1_delay = RX_ERROUT1_out;
  assign RX_ERROUT2_delay = RX_ERROUT2_out;
  assign RX_ERROUT3_delay = RX_ERROUT3_out;
  assign RX_MTYOUT0_delay = RX_MTYOUT0_out;
  assign RX_MTYOUT1_delay = RX_MTYOUT1_out;
  assign RX_MTYOUT2_delay = RX_MTYOUT2_out;
  assign RX_MTYOUT3_delay = RX_MTYOUT3_out;
  assign RX_OVFOUT_delay = RX_OVFOUT_out;
  assign RX_SOPOUT0_delay = RX_SOPOUT0_out;
  assign RX_SOPOUT1_delay = RX_SOPOUT1_out;
  assign RX_SOPOUT2_delay = RX_SOPOUT2_out;
  assign RX_SOPOUT3_delay = RX_SOPOUT3_out;
  assign STAT_RX_ALIGNED_ERR_delay = STAT_RX_ALIGNED_ERR_out;
  assign STAT_RX_ALIGNED_delay = STAT_RX_ALIGNED_out;
  assign STAT_RX_BAD_TYPE_ERR_delay = STAT_RX_BAD_TYPE_ERR_out;
  assign STAT_RX_BURSTMAX_ERR_delay = STAT_RX_BURSTMAX_ERR_out;
  assign STAT_RX_BURST_ERR_delay = STAT_RX_BURST_ERR_out;
  assign STAT_RX_CRC24_ERR_delay = STAT_RX_CRC24_ERR_out;
  assign STAT_RX_CRC32_ERR_delay = STAT_RX_CRC32_ERR_out;
  assign STAT_RX_CRC32_VALID_delay = STAT_RX_CRC32_VALID_out;
  assign STAT_RX_DESCRAM_ERR_delay = STAT_RX_DESCRAM_ERR_out;
  assign STAT_RX_DIAGWORD_INTFSTAT_delay = STAT_RX_DIAGWORD_INTFSTAT_out;
  assign STAT_RX_DIAGWORD_LANESTAT_delay = STAT_RX_DIAGWORD_LANESTAT_out;
  assign STAT_RX_FC_STAT_delay = STAT_RX_FC_STAT_out;
  assign STAT_RX_FRAMING_ERR_delay = STAT_RX_FRAMING_ERR_out;
  assign STAT_RX_MEOP_ERR_delay = STAT_RX_MEOP_ERR_out;
  assign STAT_RX_MF_ERR_delay = STAT_RX_MF_ERR_out;
  assign STAT_RX_MF_LEN_ERR_delay = STAT_RX_MF_LEN_ERR_out;
  assign STAT_RX_MF_REPEAT_ERR_delay = STAT_RX_MF_REPEAT_ERR_out;
  assign STAT_RX_MISALIGNED_delay = STAT_RX_MISALIGNED_out;
  assign STAT_RX_MSOP_ERR_delay = STAT_RX_MSOP_ERR_out;
  assign STAT_RX_MUBITS_UPDATED_delay = STAT_RX_MUBITS_UPDATED_out;
  assign STAT_RX_MUBITS_delay = STAT_RX_MUBITS_out;
  assign STAT_RX_OVERFLOW_ERR_delay = STAT_RX_OVERFLOW_ERR_out;
  assign STAT_RX_RETRANS_CRC24_ERR_delay = STAT_RX_RETRANS_CRC24_ERR_out;
  assign STAT_RX_RETRANS_DISC_delay = STAT_RX_RETRANS_DISC_out;
  assign STAT_RX_RETRANS_LATENCY_delay = STAT_RX_RETRANS_LATENCY_out;
  assign STAT_RX_RETRANS_REQ_delay = STAT_RX_RETRANS_REQ_out;
  assign STAT_RX_RETRANS_RETRY_ERR_delay = STAT_RX_RETRANS_RETRY_ERR_out;
  assign STAT_RX_RETRANS_SEQ_UPDATED_delay = STAT_RX_RETRANS_SEQ_UPDATED_out;
  assign STAT_RX_RETRANS_SEQ_delay = STAT_RX_RETRANS_SEQ_out;
  assign STAT_RX_RETRANS_STATE_delay = STAT_RX_RETRANS_STATE_out;
  assign STAT_RX_RETRANS_SUBSEQ_delay = STAT_RX_RETRANS_SUBSEQ_out;
  assign STAT_RX_RETRANS_WDOG_ERR_delay = STAT_RX_RETRANS_WDOG_ERR_out;
  assign STAT_RX_RETRANS_WRAP_ERR_delay = STAT_RX_RETRANS_WRAP_ERR_out;
  assign STAT_RX_SYNCED_ERR_delay = STAT_RX_SYNCED_ERR_out;
  assign STAT_RX_SYNCED_delay = STAT_RX_SYNCED_out;
  assign STAT_RX_WORD_SYNC_delay = STAT_RX_WORD_SYNC_out;
  assign STAT_TX_BURST_ERR_delay = STAT_TX_BURST_ERR_out;
  assign STAT_TX_ERRINJ_BITERR_DONE_delay = STAT_TX_ERRINJ_BITERR_DONE_out;
  assign STAT_TX_OVERFLOW_ERR_delay = STAT_TX_OVERFLOW_ERR_out;
  assign STAT_TX_RETRANS_BURST_ERR_delay = STAT_TX_RETRANS_BURST_ERR_out;
  assign STAT_TX_RETRANS_BUSY_delay = STAT_TX_RETRANS_BUSY_out;
  assign STAT_TX_RETRANS_RAM_PERROUT_delay = STAT_TX_RETRANS_RAM_PERROUT_out;
  assign STAT_TX_RETRANS_RAM_RADDR_delay = STAT_TX_RETRANS_RAM_RADDR_out;
  assign STAT_TX_RETRANS_RAM_RD_B0_delay = STAT_TX_RETRANS_RAM_RD_B0_out;
  assign STAT_TX_RETRANS_RAM_RD_B1_delay = STAT_TX_RETRANS_RAM_RD_B1_out;
  assign STAT_TX_RETRANS_RAM_RD_B2_delay = STAT_TX_RETRANS_RAM_RD_B2_out;
  assign STAT_TX_RETRANS_RAM_RD_B3_delay = STAT_TX_RETRANS_RAM_RD_B3_out;
  assign STAT_TX_RETRANS_RAM_RSEL_delay = STAT_TX_RETRANS_RAM_RSEL_out;
  assign STAT_TX_RETRANS_RAM_WADDR_delay = STAT_TX_RETRANS_RAM_WADDR_out;
  assign STAT_TX_RETRANS_RAM_WDATA_delay = STAT_TX_RETRANS_RAM_WDATA_out;
  assign STAT_TX_RETRANS_RAM_WE_B0_delay = STAT_TX_RETRANS_RAM_WE_B0_out;
  assign STAT_TX_RETRANS_RAM_WE_B1_delay = STAT_TX_RETRANS_RAM_WE_B1_out;
  assign STAT_TX_RETRANS_RAM_WE_B2_delay = STAT_TX_RETRANS_RAM_WE_B2_out;
  assign STAT_TX_RETRANS_RAM_WE_B3_delay = STAT_TX_RETRANS_RAM_WE_B3_out;
  assign STAT_TX_UNDERFLOW_ERR_delay = STAT_TX_UNDERFLOW_ERR_out;
  assign TX_OVFOUT_delay = TX_OVFOUT_out;
  assign TX_RDYOUT_delay = TX_RDYOUT_out;
  assign TX_SERDES_DATA00_delay = TX_SERDES_DATA00_out;
  assign TX_SERDES_DATA01_delay = TX_SERDES_DATA01_out;
  assign TX_SERDES_DATA02_delay = TX_SERDES_DATA02_out;
  assign TX_SERDES_DATA03_delay = TX_SERDES_DATA03_out;
  assign TX_SERDES_DATA04_delay = TX_SERDES_DATA04_out;
  assign TX_SERDES_DATA05_delay = TX_SERDES_DATA05_out;
  assign TX_SERDES_DATA06_delay = TX_SERDES_DATA06_out;
  assign TX_SERDES_DATA07_delay = TX_SERDES_DATA07_out;
  assign TX_SERDES_DATA08_delay = TX_SERDES_DATA08_out;
  assign TX_SERDES_DATA09_delay = TX_SERDES_DATA09_out;
  assign TX_SERDES_DATA10_delay = TX_SERDES_DATA10_out;
  assign TX_SERDES_DATA11_delay = TX_SERDES_DATA11_out;

  assign CORE_CLK_in = CORE_CLK_delay;
  assign CTL_RX_FORCE_RESYNC_in = CTL_RX_FORCE_RESYNC_delay;
  assign CTL_RX_RETRANS_ACK_in = CTL_RX_RETRANS_ACK_delay;
  assign CTL_RX_RETRANS_ENABLE_in = CTL_RX_RETRANS_ENABLE_delay;
  assign CTL_RX_RETRANS_ERRIN_in = CTL_RX_RETRANS_ERRIN_delay;
  assign CTL_RX_RETRANS_FORCE_REQ_in = CTL_RX_RETRANS_FORCE_REQ_delay;
  assign CTL_RX_RETRANS_RESET_MODE_in = CTL_RX_RETRANS_RESET_MODE_delay;
  assign CTL_RX_RETRANS_RESET_in = CTL_RX_RETRANS_RESET_delay;
  assign CTL_TX_DIAGWORD_INTFSTAT_in = CTL_TX_DIAGWORD_INTFSTAT_delay;
  assign CTL_TX_DIAGWORD_LANESTAT_in = CTL_TX_DIAGWORD_LANESTAT_delay;
  assign CTL_TX_ENABLE_in = CTL_TX_ENABLE_delay;
  assign CTL_TX_ERRINJ_BITERR_GO_in = CTL_TX_ERRINJ_BITERR_GO_delay;
  assign CTL_TX_ERRINJ_BITERR_LANE_in = CTL_TX_ERRINJ_BITERR_LANE_delay;
  assign CTL_TX_FC_STAT_in = CTL_TX_FC_STAT_delay;
  assign CTL_TX_MUBITS_in = CTL_TX_MUBITS_delay;
  assign CTL_TX_RETRANS_ENABLE_in = CTL_TX_RETRANS_ENABLE_delay;
  assign CTL_TX_RETRANS_RAM_PERRIN_in = CTL_TX_RETRANS_RAM_PERRIN_delay;
  assign CTL_TX_RETRANS_RAM_RDATA_in = CTL_TX_RETRANS_RAM_RDATA_delay;
  assign CTL_TX_RETRANS_REQ_VALID_in = CTL_TX_RETRANS_REQ_VALID_delay;
  assign CTL_TX_RETRANS_REQ_in = CTL_TX_RETRANS_REQ_delay;
  assign CTL_TX_RLIM_DELTA_in = CTL_TX_RLIM_DELTA_delay;
  assign CTL_TX_RLIM_ENABLE_in = CTL_TX_RLIM_ENABLE_delay;
  assign CTL_TX_RLIM_INTV_in = CTL_TX_RLIM_INTV_delay;
  assign CTL_TX_RLIM_MAX_in = CTL_TX_RLIM_MAX_delay;
  assign DRP_ADDR_in = DRP_ADDR_delay;
  assign DRP_CLK_in = DRP_CLK_delay;
  assign DRP_DI_in = DRP_DI_delay;
  assign DRP_EN_in = DRP_EN_delay;
  assign DRP_WE_in = DRP_WE_delay;
  assign LBUS_CLK_in = LBUS_CLK_delay;
  assign RX_BYPASS_FORCE_REALIGNIN_in = RX_BYPASS_FORCE_REALIGNIN_delay;
  assign RX_BYPASS_RDIN_in = RX_BYPASS_RDIN_delay;
  assign RX_RESET_in = RX_RESET_delay;
  assign RX_SERDES_CLK_in = RX_SERDES_CLK_delay;
  assign RX_SERDES_DATA00_in = RX_SERDES_DATA00_delay;
  assign RX_SERDES_DATA01_in = RX_SERDES_DATA01_delay;
  assign RX_SERDES_DATA02_in = RX_SERDES_DATA02_delay;
  assign RX_SERDES_DATA03_in = RX_SERDES_DATA03_delay;
  assign RX_SERDES_DATA04_in = RX_SERDES_DATA04_delay;
  assign RX_SERDES_DATA05_in = RX_SERDES_DATA05_delay;
  assign RX_SERDES_DATA06_in = RX_SERDES_DATA06_delay;
  assign RX_SERDES_DATA07_in = RX_SERDES_DATA07_delay;
  assign RX_SERDES_DATA08_in = RX_SERDES_DATA08_delay;
  assign RX_SERDES_DATA09_in = RX_SERDES_DATA09_delay;
  assign RX_SERDES_DATA10_in = RX_SERDES_DATA10_delay;
  assign RX_SERDES_DATA11_in = RX_SERDES_DATA11_delay;
  assign RX_SERDES_RESET_in = RX_SERDES_RESET_delay;
  assign TX_BCTLIN0_in = TX_BCTLIN0_delay;
  assign TX_BCTLIN1_in = TX_BCTLIN1_delay;
  assign TX_BCTLIN2_in = TX_BCTLIN2_delay;
  assign TX_BCTLIN3_in = TX_BCTLIN3_delay;
  assign TX_BYPASS_CTRLIN_in = TX_BYPASS_CTRLIN_delay;
  assign TX_BYPASS_DATAIN00_in = TX_BYPASS_DATAIN00_delay;
  assign TX_BYPASS_DATAIN01_in = TX_BYPASS_DATAIN01_delay;
  assign TX_BYPASS_DATAIN02_in = TX_BYPASS_DATAIN02_delay;
  assign TX_BYPASS_DATAIN03_in = TX_BYPASS_DATAIN03_delay;
  assign TX_BYPASS_DATAIN04_in = TX_BYPASS_DATAIN04_delay;
  assign TX_BYPASS_DATAIN05_in = TX_BYPASS_DATAIN05_delay;
  assign TX_BYPASS_DATAIN06_in = TX_BYPASS_DATAIN06_delay;
  assign TX_BYPASS_DATAIN07_in = TX_BYPASS_DATAIN07_delay;
  assign TX_BYPASS_DATAIN08_in = TX_BYPASS_DATAIN08_delay;
  assign TX_BYPASS_DATAIN09_in = TX_BYPASS_DATAIN09_delay;
  assign TX_BYPASS_DATAIN10_in = TX_BYPASS_DATAIN10_delay;
  assign TX_BYPASS_DATAIN11_in = TX_BYPASS_DATAIN11_delay;
  assign TX_BYPASS_ENAIN_in = TX_BYPASS_ENAIN_delay;
  assign TX_BYPASS_GEARBOX_SEQIN_in = TX_BYPASS_GEARBOX_SEQIN_delay;
  assign TX_BYPASS_MFRAMER_STATEIN_in = TX_BYPASS_MFRAMER_STATEIN_delay;
  assign TX_CHANIN0_in = TX_CHANIN0_delay;
  assign TX_CHANIN1_in = TX_CHANIN1_delay;
  assign TX_CHANIN2_in = TX_CHANIN2_delay;
  assign TX_CHANIN3_in = TX_CHANIN3_delay;
  assign TX_DATAIN0_in = TX_DATAIN0_delay;
  assign TX_DATAIN1_in = TX_DATAIN1_delay;
  assign TX_DATAIN2_in = TX_DATAIN2_delay;
  assign TX_DATAIN3_in = TX_DATAIN3_delay;
  assign TX_ENAIN0_in = TX_ENAIN0_delay;
  assign TX_ENAIN1_in = TX_ENAIN1_delay;
  assign TX_ENAIN2_in = TX_ENAIN2_delay;
  assign TX_ENAIN3_in = TX_ENAIN3_delay;
  assign TX_EOPIN0_in = TX_EOPIN0_delay;
  assign TX_EOPIN1_in = TX_EOPIN1_delay;
  assign TX_EOPIN2_in = TX_EOPIN2_delay;
  assign TX_EOPIN3_in = TX_EOPIN3_delay;
  assign TX_ERRIN0_in = TX_ERRIN0_delay;
  assign TX_ERRIN1_in = TX_ERRIN1_delay;
  assign TX_ERRIN2_in = TX_ERRIN2_delay;
  assign TX_ERRIN3_in = TX_ERRIN3_delay;
  assign TX_MTYIN0_in = TX_MTYIN0_delay;
  assign TX_MTYIN1_in = TX_MTYIN1_delay;
  assign TX_MTYIN2_in = TX_MTYIN2_delay;
  assign TX_MTYIN3_in = TX_MTYIN3_delay;
  assign TX_RESET_in = TX_RESET_delay;
  assign TX_SERDES_REFCLK_RESET_in = TX_SERDES_REFCLK_RESET_delay;
  assign TX_SERDES_REFCLK_in = TX_SERDES_REFCLK_delay;
  assign TX_SOPIN0_in = TX_SOPIN0_delay;
  assign TX_SOPIN1_in = TX_SOPIN1_delay;
  assign TX_SOPIN2_in = TX_SOPIN2_delay;
  assign TX_SOPIN3_in = TX_SOPIN3_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
    #1;
    if ((BYPASS_REG != "FALSE") &&
        (BYPASS_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute BYPASS on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, BYPASS_REG);
      attr_err = 1'b1;
    end

    if ((CTL_RX_PACKET_MODE_REG != "TRUE") &&
        (CTL_RX_PACKET_MODE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute CTL_RX_PACKET_MODE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, CTL_RX_PACKET_MODE_REG);
      attr_err = 1'b1;
    end

    if ((CTL_TEST_MODE_PIN_CHAR_REG != "FALSE") &&
        (CTL_TEST_MODE_PIN_CHAR_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute CTL_TEST_MODE_PIN_CHAR on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, CTL_TEST_MODE_PIN_CHAR_REG);
      attr_err = 1'b1;
    end

    if ((CTL_TX_DISABLE_SKIPWORD_REG != "TRUE") &&
        (CTL_TX_DISABLE_SKIPWORD_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute CTL_TX_DISABLE_SKIPWORD on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, CTL_TX_DISABLE_SKIPWORD_REG);
      attr_err = 1'b1;
    end

    if ((MODE_REG != "TRUE") &&
        (MODE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute MODE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, MODE_REG);
      attr_err = 1'b1;
    end

    if ((TEST_MODE_PIN_CHAR_REG != "FALSE") &&
        (TEST_MODE_PIN_CHAR_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute TEST_MODE_PIN_CHAR on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, TEST_MODE_PIN_CHAR_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;
  end


  assign SCAN_EN_N_in = 1'b1; // tie off
  assign SCAN_IN_in = 265'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111; // tie off
  assign TEST_MODE_N_in = 1'b1; // tie off
  assign TEST_RESET_in = 1'b1; // tie off

  SIP_ILKN SIP_ILKN_INST (
    .BYPASS (BYPASS_REG),
    .CTL_RX_BURSTMAX (CTL_RX_BURSTMAX_REG),
    .CTL_RX_CHAN_EXT (CTL_RX_CHAN_EXT_REG),
    .CTL_RX_LAST_LANE (CTL_RX_LAST_LANE_REG),
    .CTL_RX_MFRAMELEN_MINUS1 (CTL_RX_MFRAMELEN_MINUS1_REG),
    .CTL_RX_PACKET_MODE (CTL_RX_PACKET_MODE_REG),
    .CTL_RX_RETRANS_MULT (CTL_RX_RETRANS_MULT_REG),
    .CTL_RX_RETRANS_RETRY (CTL_RX_RETRANS_RETRY_REG),
    .CTL_RX_RETRANS_TIMER1 (CTL_RX_RETRANS_TIMER1_REG),
    .CTL_RX_RETRANS_TIMER2 (CTL_RX_RETRANS_TIMER2_REG),
    .CTL_RX_RETRANS_WDOG (CTL_RX_RETRANS_WDOG_REG),
    .CTL_RX_RETRANS_WRAP_TIMER (CTL_RX_RETRANS_WRAP_TIMER_REG),
    .CTL_TEST_MODE_PIN_CHAR (CTL_TEST_MODE_PIN_CHAR_REG),
    .CTL_TX_BURSTMAX (CTL_TX_BURSTMAX_REG),
    .CTL_TX_BURSTSHORT (CTL_TX_BURSTSHORT_REG),
    .CTL_TX_CHAN_EXT (CTL_TX_CHAN_EXT_REG),
    .CTL_TX_DISABLE_SKIPWORD (CTL_TX_DISABLE_SKIPWORD_REG),
    .CTL_TX_FC_CALLEN (CTL_TX_FC_CALLEN_REG),
    .CTL_TX_LAST_LANE (CTL_TX_LAST_LANE_REG),
    .CTL_TX_MFRAMELEN_MINUS1 (CTL_TX_MFRAMELEN_MINUS1_REG),
    .CTL_TX_RETRANS_DEPTH (CTL_TX_RETRANS_DEPTH_REG),
    .CTL_TX_RETRANS_MULT (CTL_TX_RETRANS_MULT_REG),
    .CTL_TX_RETRANS_RAM_BANKS (CTL_TX_RETRANS_RAM_BANKS_REG),
    .MODE (MODE_REG),
    .TEST_MODE_PIN_CHAR (TEST_MODE_PIN_CHAR_REG),
    .DRP_DO (DRP_DO_out),
    .DRP_RDY (DRP_RDY_out),
    .RX_BYPASS_DATAOUT00 (RX_BYPASS_DATAOUT00_out),
    .RX_BYPASS_DATAOUT01 (RX_BYPASS_DATAOUT01_out),
    .RX_BYPASS_DATAOUT02 (RX_BYPASS_DATAOUT02_out),
    .RX_BYPASS_DATAOUT03 (RX_BYPASS_DATAOUT03_out),
    .RX_BYPASS_DATAOUT04 (RX_BYPASS_DATAOUT04_out),
    .RX_BYPASS_DATAOUT05 (RX_BYPASS_DATAOUT05_out),
    .RX_BYPASS_DATAOUT06 (RX_BYPASS_DATAOUT06_out),
    .RX_BYPASS_DATAOUT07 (RX_BYPASS_DATAOUT07_out),
    .RX_BYPASS_DATAOUT08 (RX_BYPASS_DATAOUT08_out),
    .RX_BYPASS_DATAOUT09 (RX_BYPASS_DATAOUT09_out),
    .RX_BYPASS_DATAOUT10 (RX_BYPASS_DATAOUT10_out),
    .RX_BYPASS_DATAOUT11 (RX_BYPASS_DATAOUT11_out),
    .RX_BYPASS_ENAOUT (RX_BYPASS_ENAOUT_out),
    .RX_BYPASS_IS_AVAILOUT (RX_BYPASS_IS_AVAILOUT_out),
    .RX_BYPASS_IS_BADLYFRAMEDOUT (RX_BYPASS_IS_BADLYFRAMEDOUT_out),
    .RX_BYPASS_IS_OVERFLOWOUT (RX_BYPASS_IS_OVERFLOWOUT_out),
    .RX_BYPASS_IS_SYNCEDOUT (RX_BYPASS_IS_SYNCEDOUT_out),
    .RX_BYPASS_IS_SYNCWORDOUT (RX_BYPASS_IS_SYNCWORDOUT_out),
    .RX_CHANOUT0 (RX_CHANOUT0_out),
    .RX_CHANOUT1 (RX_CHANOUT1_out),
    .RX_CHANOUT2 (RX_CHANOUT2_out),
    .RX_CHANOUT3 (RX_CHANOUT3_out),
    .RX_DATAOUT0 (RX_DATAOUT0_out),
    .RX_DATAOUT1 (RX_DATAOUT1_out),
    .RX_DATAOUT2 (RX_DATAOUT2_out),
    .RX_DATAOUT3 (RX_DATAOUT3_out),
    .RX_ENAOUT0 (RX_ENAOUT0_out),
    .RX_ENAOUT1 (RX_ENAOUT1_out),
    .RX_ENAOUT2 (RX_ENAOUT2_out),
    .RX_ENAOUT3 (RX_ENAOUT3_out),
    .RX_EOPOUT0 (RX_EOPOUT0_out),
    .RX_EOPOUT1 (RX_EOPOUT1_out),
    .RX_EOPOUT2 (RX_EOPOUT2_out),
    .RX_EOPOUT3 (RX_EOPOUT3_out),
    .RX_ERROUT0 (RX_ERROUT0_out),
    .RX_ERROUT1 (RX_ERROUT1_out),
    .RX_ERROUT2 (RX_ERROUT2_out),
    .RX_ERROUT3 (RX_ERROUT3_out),
    .RX_MTYOUT0 (RX_MTYOUT0_out),
    .RX_MTYOUT1 (RX_MTYOUT1_out),
    .RX_MTYOUT2 (RX_MTYOUT2_out),
    .RX_MTYOUT3 (RX_MTYOUT3_out),
    .RX_OVFOUT (RX_OVFOUT_out),
    .RX_SOPOUT0 (RX_SOPOUT0_out),
    .RX_SOPOUT1 (RX_SOPOUT1_out),
    .RX_SOPOUT2 (RX_SOPOUT2_out),
    .RX_SOPOUT3 (RX_SOPOUT3_out),
    .SCAN_OUT (SCAN_OUT_out),
    .STAT_RX_ALIGNED (STAT_RX_ALIGNED_out),
    .STAT_RX_ALIGNED_ERR (STAT_RX_ALIGNED_ERR_out),
    .STAT_RX_BAD_TYPE_ERR (STAT_RX_BAD_TYPE_ERR_out),
    .STAT_RX_BURSTMAX_ERR (STAT_RX_BURSTMAX_ERR_out),
    .STAT_RX_BURST_ERR (STAT_RX_BURST_ERR_out),
    .STAT_RX_CRC24_ERR (STAT_RX_CRC24_ERR_out),
    .STAT_RX_CRC32_ERR (STAT_RX_CRC32_ERR_out),
    .STAT_RX_CRC32_VALID (STAT_RX_CRC32_VALID_out),
    .STAT_RX_DESCRAM_ERR (STAT_RX_DESCRAM_ERR_out),
    .STAT_RX_DIAGWORD_INTFSTAT (STAT_RX_DIAGWORD_INTFSTAT_out),
    .STAT_RX_DIAGWORD_LANESTAT (STAT_RX_DIAGWORD_LANESTAT_out),
    .STAT_RX_FC_STAT (STAT_RX_FC_STAT_out),
    .STAT_RX_FRAMING_ERR (STAT_RX_FRAMING_ERR_out),
    .STAT_RX_MEOP_ERR (STAT_RX_MEOP_ERR_out),
    .STAT_RX_MF_ERR (STAT_RX_MF_ERR_out),
    .STAT_RX_MF_LEN_ERR (STAT_RX_MF_LEN_ERR_out),
    .STAT_RX_MF_REPEAT_ERR (STAT_RX_MF_REPEAT_ERR_out),
    .STAT_RX_MISALIGNED (STAT_RX_MISALIGNED_out),
    .STAT_RX_MSOP_ERR (STAT_RX_MSOP_ERR_out),
    .STAT_RX_MUBITS (STAT_RX_MUBITS_out),
    .STAT_RX_MUBITS_UPDATED (STAT_RX_MUBITS_UPDATED_out),
    .STAT_RX_OVERFLOW_ERR (STAT_RX_OVERFLOW_ERR_out),
    .STAT_RX_RETRANS_CRC24_ERR (STAT_RX_RETRANS_CRC24_ERR_out),
    .STAT_RX_RETRANS_DISC (STAT_RX_RETRANS_DISC_out),
    .STAT_RX_RETRANS_LATENCY (STAT_RX_RETRANS_LATENCY_out),
    .STAT_RX_RETRANS_REQ (STAT_RX_RETRANS_REQ_out),
    .STAT_RX_RETRANS_RETRY_ERR (STAT_RX_RETRANS_RETRY_ERR_out),
    .STAT_RX_RETRANS_SEQ (STAT_RX_RETRANS_SEQ_out),
    .STAT_RX_RETRANS_SEQ_UPDATED (STAT_RX_RETRANS_SEQ_UPDATED_out),
    .STAT_RX_RETRANS_STATE (STAT_RX_RETRANS_STATE_out),
    .STAT_RX_RETRANS_SUBSEQ (STAT_RX_RETRANS_SUBSEQ_out),
    .STAT_RX_RETRANS_WDOG_ERR (STAT_RX_RETRANS_WDOG_ERR_out),
    .STAT_RX_RETRANS_WRAP_ERR (STAT_RX_RETRANS_WRAP_ERR_out),
    .STAT_RX_SYNCED (STAT_RX_SYNCED_out),
    .STAT_RX_SYNCED_ERR (STAT_RX_SYNCED_ERR_out),
    .STAT_RX_WORD_SYNC (STAT_RX_WORD_SYNC_out),
    .STAT_TX_BURST_ERR (STAT_TX_BURST_ERR_out),
    .STAT_TX_ERRINJ_BITERR_DONE (STAT_TX_ERRINJ_BITERR_DONE_out),
    .STAT_TX_OVERFLOW_ERR (STAT_TX_OVERFLOW_ERR_out),
    .STAT_TX_RETRANS_BURST_ERR (STAT_TX_RETRANS_BURST_ERR_out),
    .STAT_TX_RETRANS_BUSY (STAT_TX_RETRANS_BUSY_out),
    .STAT_TX_RETRANS_RAM_PERROUT (STAT_TX_RETRANS_RAM_PERROUT_out),
    .STAT_TX_RETRANS_RAM_RADDR (STAT_TX_RETRANS_RAM_RADDR_out),
    .STAT_TX_RETRANS_RAM_RD_B0 (STAT_TX_RETRANS_RAM_RD_B0_out),
    .STAT_TX_RETRANS_RAM_RD_B1 (STAT_TX_RETRANS_RAM_RD_B1_out),
    .STAT_TX_RETRANS_RAM_RD_B2 (STAT_TX_RETRANS_RAM_RD_B2_out),
    .STAT_TX_RETRANS_RAM_RD_B3 (STAT_TX_RETRANS_RAM_RD_B3_out),
    .STAT_TX_RETRANS_RAM_RSEL (STAT_TX_RETRANS_RAM_RSEL_out),
    .STAT_TX_RETRANS_RAM_WADDR (STAT_TX_RETRANS_RAM_WADDR_out),
    .STAT_TX_RETRANS_RAM_WDATA (STAT_TX_RETRANS_RAM_WDATA_out),
    .STAT_TX_RETRANS_RAM_WE_B0 (STAT_TX_RETRANS_RAM_WE_B0_out),
    .STAT_TX_RETRANS_RAM_WE_B1 (STAT_TX_RETRANS_RAM_WE_B1_out),
    .STAT_TX_RETRANS_RAM_WE_B2 (STAT_TX_RETRANS_RAM_WE_B2_out),
    .STAT_TX_RETRANS_RAM_WE_B3 (STAT_TX_RETRANS_RAM_WE_B3_out),
    .STAT_TX_UNDERFLOW_ERR (STAT_TX_UNDERFLOW_ERR_out),
    .TX_OVFOUT (TX_OVFOUT_out),
    .TX_RDYOUT (TX_RDYOUT_out),
    .TX_SERDES_DATA00 (TX_SERDES_DATA00_out),
    .TX_SERDES_DATA01 (TX_SERDES_DATA01_out),
    .TX_SERDES_DATA02 (TX_SERDES_DATA02_out),
    .TX_SERDES_DATA03 (TX_SERDES_DATA03_out),
    .TX_SERDES_DATA04 (TX_SERDES_DATA04_out),
    .TX_SERDES_DATA05 (TX_SERDES_DATA05_out),
    .TX_SERDES_DATA06 (TX_SERDES_DATA06_out),
    .TX_SERDES_DATA07 (TX_SERDES_DATA07_out),
    .TX_SERDES_DATA08 (TX_SERDES_DATA08_out),
    .TX_SERDES_DATA09 (TX_SERDES_DATA09_out),
    .TX_SERDES_DATA10 (TX_SERDES_DATA10_out),
    .TX_SERDES_DATA11 (TX_SERDES_DATA11_out),
    .CORE_CLK (CORE_CLK_in),
    .CTL_RX_FORCE_RESYNC (CTL_RX_FORCE_RESYNC_in),
    .CTL_RX_RETRANS_ACK (CTL_RX_RETRANS_ACK_in),
    .CTL_RX_RETRANS_ENABLE (CTL_RX_RETRANS_ENABLE_in),
    .CTL_RX_RETRANS_ERRIN (CTL_RX_RETRANS_ERRIN_in),
    .CTL_RX_RETRANS_FORCE_REQ (CTL_RX_RETRANS_FORCE_REQ_in),
    .CTL_RX_RETRANS_RESET (CTL_RX_RETRANS_RESET_in),
    .CTL_RX_RETRANS_RESET_MODE (CTL_RX_RETRANS_RESET_MODE_in),
    .CTL_TX_DIAGWORD_INTFSTAT (CTL_TX_DIAGWORD_INTFSTAT_in),
    .CTL_TX_DIAGWORD_LANESTAT (CTL_TX_DIAGWORD_LANESTAT_in),
    .CTL_TX_ENABLE (CTL_TX_ENABLE_in),
    .CTL_TX_ERRINJ_BITERR_GO (CTL_TX_ERRINJ_BITERR_GO_in),
    .CTL_TX_ERRINJ_BITERR_LANE (CTL_TX_ERRINJ_BITERR_LANE_in),
    .CTL_TX_FC_STAT (CTL_TX_FC_STAT_in),
    .CTL_TX_MUBITS (CTL_TX_MUBITS_in),
    .CTL_TX_RETRANS_ENABLE (CTL_TX_RETRANS_ENABLE_in),
    .CTL_TX_RETRANS_RAM_PERRIN (CTL_TX_RETRANS_RAM_PERRIN_in),
    .CTL_TX_RETRANS_RAM_RDATA (CTL_TX_RETRANS_RAM_RDATA_in),
    .CTL_TX_RETRANS_REQ (CTL_TX_RETRANS_REQ_in),
    .CTL_TX_RETRANS_REQ_VALID (CTL_TX_RETRANS_REQ_VALID_in),
    .CTL_TX_RLIM_DELTA (CTL_TX_RLIM_DELTA_in),
    .CTL_TX_RLIM_ENABLE (CTL_TX_RLIM_ENABLE_in),
    .CTL_TX_RLIM_INTV (CTL_TX_RLIM_INTV_in),
    .CTL_TX_RLIM_MAX (CTL_TX_RLIM_MAX_in),
    .DRP_ADDR (DRP_ADDR_in),
    .DRP_CLK (DRP_CLK_in),
    .DRP_DI (DRP_DI_in),
    .DRP_EN (DRP_EN_in),
    .DRP_WE (DRP_WE_in),
    .LBUS_CLK (LBUS_CLK_in),
    .RX_BYPASS_FORCE_REALIGNIN (RX_BYPASS_FORCE_REALIGNIN_in),
    .RX_BYPASS_RDIN (RX_BYPASS_RDIN_in),
    .RX_RESET (RX_RESET_in),
    .RX_SERDES_CLK (RX_SERDES_CLK_in),
    .RX_SERDES_DATA00 (RX_SERDES_DATA00_in),
    .RX_SERDES_DATA01 (RX_SERDES_DATA01_in),
    .RX_SERDES_DATA02 (RX_SERDES_DATA02_in),
    .RX_SERDES_DATA03 (RX_SERDES_DATA03_in),
    .RX_SERDES_DATA04 (RX_SERDES_DATA04_in),
    .RX_SERDES_DATA05 (RX_SERDES_DATA05_in),
    .RX_SERDES_DATA06 (RX_SERDES_DATA06_in),
    .RX_SERDES_DATA07 (RX_SERDES_DATA07_in),
    .RX_SERDES_DATA08 (RX_SERDES_DATA08_in),
    .RX_SERDES_DATA09 (RX_SERDES_DATA09_in),
    .RX_SERDES_DATA10 (RX_SERDES_DATA10_in),
    .RX_SERDES_DATA11 (RX_SERDES_DATA11_in),
    .RX_SERDES_RESET (RX_SERDES_RESET_in),
    .SCAN_EN_N (SCAN_EN_N_in),
    .SCAN_IN (SCAN_IN_in),
    .TEST_MODE_N (TEST_MODE_N_in),
    .TEST_RESET (TEST_RESET_in),
    .TX_BCTLIN0 (TX_BCTLIN0_in),
    .TX_BCTLIN1 (TX_BCTLIN1_in),
    .TX_BCTLIN2 (TX_BCTLIN2_in),
    .TX_BCTLIN3 (TX_BCTLIN3_in),
    .TX_BYPASS_CTRLIN (TX_BYPASS_CTRLIN_in),
    .TX_BYPASS_DATAIN00 (TX_BYPASS_DATAIN00_in),
    .TX_BYPASS_DATAIN01 (TX_BYPASS_DATAIN01_in),
    .TX_BYPASS_DATAIN02 (TX_BYPASS_DATAIN02_in),
    .TX_BYPASS_DATAIN03 (TX_BYPASS_DATAIN03_in),
    .TX_BYPASS_DATAIN04 (TX_BYPASS_DATAIN04_in),
    .TX_BYPASS_DATAIN05 (TX_BYPASS_DATAIN05_in),
    .TX_BYPASS_DATAIN06 (TX_BYPASS_DATAIN06_in),
    .TX_BYPASS_DATAIN07 (TX_BYPASS_DATAIN07_in),
    .TX_BYPASS_DATAIN08 (TX_BYPASS_DATAIN08_in),
    .TX_BYPASS_DATAIN09 (TX_BYPASS_DATAIN09_in),
    .TX_BYPASS_DATAIN10 (TX_BYPASS_DATAIN10_in),
    .TX_BYPASS_DATAIN11 (TX_BYPASS_DATAIN11_in),
    .TX_BYPASS_ENAIN (TX_BYPASS_ENAIN_in),
    .TX_BYPASS_GEARBOX_SEQIN (TX_BYPASS_GEARBOX_SEQIN_in),
    .TX_BYPASS_MFRAMER_STATEIN (TX_BYPASS_MFRAMER_STATEIN_in),
    .TX_CHANIN0 (TX_CHANIN0_in),
    .TX_CHANIN1 (TX_CHANIN1_in),
    .TX_CHANIN2 (TX_CHANIN2_in),
    .TX_CHANIN3 (TX_CHANIN3_in),
    .TX_DATAIN0 (TX_DATAIN0_in),
    .TX_DATAIN1 (TX_DATAIN1_in),
    .TX_DATAIN2 (TX_DATAIN2_in),
    .TX_DATAIN3 (TX_DATAIN3_in),
    .TX_ENAIN0 (TX_ENAIN0_in),
    .TX_ENAIN1 (TX_ENAIN1_in),
    .TX_ENAIN2 (TX_ENAIN2_in),
    .TX_ENAIN3 (TX_ENAIN3_in),
    .TX_EOPIN0 (TX_EOPIN0_in),
    .TX_EOPIN1 (TX_EOPIN1_in),
    .TX_EOPIN2 (TX_EOPIN2_in),
    .TX_EOPIN3 (TX_EOPIN3_in),
    .TX_ERRIN0 (TX_ERRIN0_in),
    .TX_ERRIN1 (TX_ERRIN1_in),
    .TX_ERRIN2 (TX_ERRIN2_in),
    .TX_ERRIN3 (TX_ERRIN3_in),
    .TX_MTYIN0 (TX_MTYIN0_in),
    .TX_MTYIN1 (TX_MTYIN1_in),
    .TX_MTYIN2 (TX_MTYIN2_in),
    .TX_MTYIN3 (TX_MTYIN3_in),
    .TX_RESET (TX_RESET_in),
    .TX_SERDES_REFCLK (TX_SERDES_REFCLK_in),
    .TX_SERDES_REFCLK_RESET (TX_SERDES_REFCLK_RESET_in),
    .TX_SOPIN0 (TX_SOPIN0_in),
    .TX_SOPIN1 (TX_SOPIN1_in),
    .TX_SOPIN2 (TX_SOPIN2_in),
    .TX_SOPIN3 (TX_SOPIN3_in),
    .GSR (glblGSR)
  );

  
  endmodule

`endcelldefine
