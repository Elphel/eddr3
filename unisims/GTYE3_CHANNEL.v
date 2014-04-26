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
// /___/   /\      Filename    : GTYE3_CHANNEL.v
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
module GTYE3_CHANNEL #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] ACJTAG_DEBUG_MODE = 1'b0,
  parameter [0:0] ACJTAG_MODE = 1'b0,
  parameter [0:0] ACJTAG_RESET = 1'b0,
  parameter [15:0] ADAPT_CFG0 = 16'hF800,
  parameter [15:0] ADAPT_CFG1 = 16'h0000,
  parameter [15:0] ADAPT_CFG2 = 16'b0000000000000000,
  parameter ALIGN_COMMA_DOUBLE = "FALSE",
  parameter [9:0] ALIGN_COMMA_ENABLE = 10'b0001111111,
  parameter integer ALIGN_COMMA_WORD = 1,
  parameter ALIGN_MCOMMA_DET = "TRUE",
  parameter [9:0] ALIGN_MCOMMA_VALUE = 10'b1010000011,
  parameter ALIGN_PCOMMA_DET = "TRUE",
  parameter [9:0] ALIGN_PCOMMA_VALUE = 10'b0101111100,
  parameter [0:0] AUTO_BW_SEL_BYPASS = 1'b0,
  parameter [0:0] A_RXOSCALRESET = 1'b0,
  parameter [0:0] A_RXPROGDIVRESET = 1'b0,
  parameter [4:0] A_TXDIFFCTRL = 5'b01100,
  parameter [0:0] A_TXPROGDIVRESET = 1'b0,
  parameter [0:0] CAPBYPASS_FORCE = 1'b0,
  parameter CBCC_DATA_SOURCE_SEL = "DECODED",
  parameter [0:0] CDR_SWAP_MODE_EN = 1'b0,
  parameter CHAN_BOND_KEEP_ALIGN = "FALSE",
  parameter integer CHAN_BOND_MAX_SKEW = 7,
  parameter [9:0] CHAN_BOND_SEQ_1_1 = 10'b0101111100,
  parameter [9:0] CHAN_BOND_SEQ_1_2 = 10'b0000000000,
  parameter [9:0] CHAN_BOND_SEQ_1_3 = 10'b0000000000,
  parameter [9:0] CHAN_BOND_SEQ_1_4 = 10'b0000000000,
  parameter [3:0] CHAN_BOND_SEQ_1_ENABLE = 4'b1111,
  parameter [9:0] CHAN_BOND_SEQ_2_1 = 10'b0100000000,
  parameter [9:0] CHAN_BOND_SEQ_2_2 = 10'b0100000000,
  parameter [9:0] CHAN_BOND_SEQ_2_3 = 10'b0100000000,
  parameter [9:0] CHAN_BOND_SEQ_2_4 = 10'b0100000000,
  parameter [3:0] CHAN_BOND_SEQ_2_ENABLE = 4'b1111,
  parameter CHAN_BOND_SEQ_2_USE = "FALSE",
  parameter integer CHAN_BOND_SEQ_LEN = 2,
  parameter [15:0] CH_HSPMUX = 16'b0000000000000000,
  parameter [15:0] CKCAL1_CFG_0 = 16'b0000000000000000,
  parameter [15:0] CKCAL1_CFG_1 = 16'b0000000000000000,
  parameter [15:0] CKCAL1_CFG_2 = 16'b0000000000000000,
  parameter [15:0] CKCAL1_CFG_3 = 16'b0000000000000000,
  parameter [15:0] CKCAL2_CFG_0 = 16'b0000000000000000,
  parameter [15:0] CKCAL2_CFG_1 = 16'b0000000000000000,
  parameter [15:0] CKCAL2_CFG_2 = 16'b0000000000000000,
  parameter [15:0] CKCAL2_CFG_3 = 16'b0000000000000000,
  parameter [15:0] CKCAL2_CFG_4 = 16'b0000000000000000,
  parameter [15:0] CKCAL_RSVD0 = 16'b0000000000000000,
  parameter [15:0] CKCAL_RSVD1 = 16'b0000000000000000,
  parameter CLK_CORRECT_USE = "TRUE",
  parameter CLK_COR_KEEP_IDLE = "FALSE",
  parameter integer CLK_COR_MAX_LAT = 20,
  parameter integer CLK_COR_MIN_LAT = 18,
  parameter CLK_COR_PRECEDENCE = "TRUE",
  parameter integer CLK_COR_REPEAT_WAIT = 0,
  parameter [9:0] CLK_COR_SEQ_1_1 = 10'b0100011100,
  parameter [9:0] CLK_COR_SEQ_1_2 = 10'b0000000000,
  parameter [9:0] CLK_COR_SEQ_1_3 = 10'b0000000000,
  parameter [9:0] CLK_COR_SEQ_1_4 = 10'b0000000000,
  parameter [3:0] CLK_COR_SEQ_1_ENABLE = 4'b1111,
  parameter [9:0] CLK_COR_SEQ_2_1 = 10'b0100000000,
  parameter [9:0] CLK_COR_SEQ_2_2 = 10'b0100000000,
  parameter [9:0] CLK_COR_SEQ_2_3 = 10'b0100000000,
  parameter [9:0] CLK_COR_SEQ_2_4 = 10'b0100000000,
  parameter [3:0] CLK_COR_SEQ_2_ENABLE = 4'b1111,
  parameter CLK_COR_SEQ_2_USE = "FALSE",
  parameter integer CLK_COR_SEQ_LEN = 2,
  parameter [15:0] CPLL_CFG0 = 16'h20F8,
  parameter [15:0] CPLL_CFG1 = 16'hA494,
  parameter [15:0] CPLL_CFG2 = 16'hF001,
  parameter [5:0] CPLL_CFG3 = 6'h00,
  parameter integer CPLL_FBDIV = 4,
  parameter integer CPLL_FBDIV_45 = 4,
  parameter [15:0] CPLL_INIT_CFG0 = 16'h001E,
  parameter [7:0] CPLL_INIT_CFG1 = 8'h00,
  parameter [15:0] CPLL_LOCK_CFG = 16'h01E8,
  parameter integer CPLL_REFCLK_DIV = 1,
  parameter [2:0] CTLE3_OCAP_EXT_CTRL = 3'b000,
  parameter [0:0] CTLE3_OCAP_EXT_EN = 1'b0,
  parameter [1:0] DDI_CTRL = 2'b00,
  parameter integer DDI_REALIGN_WAIT = 15,
  parameter DEC_MCOMMA_DETECT = "TRUE",
  parameter DEC_PCOMMA_DETECT = "TRUE",
  parameter DEC_VALID_COMMA_ONLY = "TRUE",
  parameter [0:0] DFE_D_X_REL_POS = 1'b0,
  parameter [0:0] DFE_VCM_COMP_EN = 1'b0,
  parameter [9:0] DMONITOR_CFG0 = 10'h000,
  parameter [7:0] DMONITOR_CFG1 = 8'h00,
  parameter [0:0] ES_CLK_PHASE_SEL = 1'b0,
  parameter [5:0] ES_CONTROL = 6'b000000,
  parameter ES_ERRDET_EN = "FALSE",
  parameter ES_EYE_SCAN_EN = "FALSE",
  parameter [11:0] ES_HORZ_OFFSET = 12'h000,
  parameter [9:0] ES_PMA_CFG = 10'b0000000000,
  parameter [4:0] ES_PRESCALE = 5'b00000,
  parameter [15:0] ES_QUALIFIER0 = 16'h0000,
  parameter [15:0] ES_QUALIFIER1 = 16'h0000,
  parameter [15:0] ES_QUALIFIER2 = 16'h0000,
  parameter [15:0] ES_QUALIFIER3 = 16'h0000,
  parameter [15:0] ES_QUALIFIER4 = 16'h0000,
  parameter [15:0] ES_QUALIFIER5 = 16'h0000,
  parameter [15:0] ES_QUALIFIER6 = 16'h0000,
  parameter [15:0] ES_QUALIFIER7 = 16'h0000,
  parameter [15:0] ES_QUALIFIER8 = 16'h0000,
  parameter [15:0] ES_QUALIFIER9 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK0 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK1 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK2 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK3 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK4 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK5 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK6 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK7 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK8 = 16'h0000,
  parameter [15:0] ES_QUAL_MASK9 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK0 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK1 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK2 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK3 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK4 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK5 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK6 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK7 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK8 = 16'h0000,
  parameter [15:0] ES_SDATA_MASK9 = 16'h0000,
  parameter [10:0] EVODD_PHI_CFG = 11'b00000000000,
  parameter [0:0] EYE_SCAN_SWAP_EN = 1'b0,
  parameter [3:0] FTS_DESKEW_SEQ_ENABLE = 4'b1111,
  parameter [3:0] FTS_LANE_DESKEW_CFG = 4'b1111,
  parameter FTS_LANE_DESKEW_EN = "FALSE",
  parameter [4:0] GEARBOX_MODE = 5'b00000,
  parameter [0:0] GM_BIAS_SELECT = 1'b0,
  parameter [0:0] ISCAN_CK_PH_SEL2 = 1'b0,
  parameter [0:0] LOCAL_MASTER = 1'b0,
  parameter [15:0] LOOP0_CFG = 16'h0000,
  parameter [15:0] LOOP10_CFG = 16'h0000,
  parameter [15:0] LOOP11_CFG = 16'h0000,
  parameter [15:0] LOOP12_CFG = 16'h0000,
  parameter [15:0] LOOP13_CFG = 16'h0000,
  parameter [15:0] LOOP1_CFG = 16'h0000,
  parameter [15:0] LOOP2_CFG = 16'h0000,
  parameter [15:0] LOOP3_CFG = 16'h0000,
  parameter [15:0] LOOP4_CFG = 16'h0000,
  parameter [15:0] LOOP5_CFG = 16'h0000,
  parameter [15:0] LOOP6_CFG = 16'h0000,
  parameter [15:0] LOOP7_CFG = 16'h0000,
  parameter [15:0] LOOP8_CFG = 16'h0000,
  parameter [15:0] LOOP9_CFG = 16'h0000,
  parameter [2:0] LPBK_BIAS_CTRL = 3'b000,
  parameter [0:0] LPBK_EN_RCAL_B = 1'b0,
  parameter [3:0] LPBK_EXT_RCAL = 4'b0000,
  parameter [3:0] LPBK_RG_CTRL = 4'b0000,
  parameter [1:0] OOBDIVCTL = 2'b00,
  parameter [0:0] OOB_PWRUP = 1'b0,
  parameter PCI3_AUTO_REALIGN = "FRST_SMPL",
  parameter [0:0] PCI3_PIPE_RX_ELECIDLE = 1'b1,
  parameter [1:0] PCI3_RX_ASYNC_EBUF_BYPASS = 2'b00,
  parameter [0:0] PCI3_RX_ELECIDLE_EI2_ENABLE = 1'b0,
  parameter [5:0] PCI3_RX_ELECIDLE_H2L_COUNT = 6'b000000,
  parameter [2:0] PCI3_RX_ELECIDLE_H2L_DISABLE = 3'b000,
  parameter [5:0] PCI3_RX_ELECIDLE_HI_COUNT = 6'b000000,
  parameter [0:0] PCI3_RX_ELECIDLE_LP4_DISABLE = 1'b0,
  parameter [0:0] PCI3_RX_FIFO_DISABLE = 1'b0,
  parameter [15:0] PCIE_BUFG_DIV_CTRL = 16'h0000,
  parameter [15:0] PCIE_RXPCS_CFG_GEN3 = 16'h0000,
  parameter [15:0] PCIE_RXPMA_CFG = 16'h0000,
  parameter [15:0] PCIE_TXPCS_CFG_GEN3 = 16'h0000,
  parameter [15:0] PCIE_TXPMA_CFG = 16'h0000,
  parameter PCS_PCIE_EN = "FALSE",
  parameter [15:0] PCS_RSVD0 = 16'b0000000000000000,
  parameter [2:0] PCS_RSVD1 = 3'b000,
  parameter [11:0] PD_TRANS_TIME_FROM_P2 = 12'h03C,
  parameter [7:0] PD_TRANS_TIME_NONE_P2 = 8'h19,
  parameter [7:0] PD_TRANS_TIME_TO_P2 = 8'h64,
  parameter [1:0] PLL_SEL_MODE_GEN12 = 2'h0,
  parameter [1:0] PLL_SEL_MODE_GEN3 = 2'h0,
  parameter [15:0] PMA_RSV0 = 16'h0000,
  parameter [15:0] PMA_RSV1 = 16'h0000,
  parameter [1:0] PREIQ_FREQ_BST = 2'b00,
  parameter [2:0] PROCESS_PAR = 3'b010,
  parameter [0:0] RATE_SW_USE_DRP = 1'b0,
  parameter [0:0] RESET_POWERSAVE_DISABLE = 1'b0,
  parameter [4:0] RXBUFRESET_TIME = 5'b00001,
  parameter RXBUF_ADDR_MODE = "FULL",
  parameter [3:0] RXBUF_EIDLE_HI_CNT = 4'b1000,
  parameter [3:0] RXBUF_EIDLE_LO_CNT = 4'b0000,
  parameter RXBUF_EN = "TRUE",
  parameter RXBUF_RESET_ON_CB_CHANGE = "TRUE",
  parameter RXBUF_RESET_ON_COMMAALIGN = "FALSE",
  parameter RXBUF_RESET_ON_EIDLE = "FALSE",
  parameter RXBUF_RESET_ON_RATE_CHANGE = "TRUE",
  parameter integer RXBUF_THRESH_OVFLW = 0,
  parameter RXBUF_THRESH_OVRD = "FALSE",
  parameter integer RXBUF_THRESH_UNDFLW = 4,
  parameter [4:0] RXCDRFREQRESET_TIME = 5'b00001,
  parameter [4:0] RXCDRPHRESET_TIME = 5'b00001,
  parameter [15:0] RXCDR_CFG0 = 16'h0000,
  parameter [15:0] RXCDR_CFG0_GEN3 = 16'h0000,
  parameter [15:0] RXCDR_CFG1 = 16'h0080,
  parameter [15:0] RXCDR_CFG1_GEN3 = 16'h0000,
  parameter [15:0] RXCDR_CFG2 = 16'h07E6,
  parameter [15:0] RXCDR_CFG2_GEN3 = 16'h0000,
  parameter [15:0] RXCDR_CFG3 = 16'h0000,
  parameter [15:0] RXCDR_CFG3_GEN3 = 16'h0000,
  parameter [15:0] RXCDR_CFG4 = 16'h0000,
  parameter [15:0] RXCDR_CFG4_GEN3 = 16'h0000,
  parameter [15:0] RXCDR_CFG5 = 16'h0000,
  parameter [15:0] RXCDR_CFG5_GEN3 = 16'h0000,
  parameter [0:0] RXCDR_FR_RESET_ON_EIDLE = 1'b0,
  parameter [0:0] RXCDR_HOLD_DURING_EIDLE = 1'b0,
  parameter [15:0] RXCDR_LOCK_CFG0 = 16'h5080,
  parameter [15:0] RXCDR_LOCK_CFG1 = 16'h07E0,
  parameter [15:0] RXCDR_LOCK_CFG2 = 16'h7C42,
  parameter [15:0] RXCDR_LOCK_CFG3 = 16'b0000000000000000,
  parameter [0:0] RXCDR_PH_RESET_ON_EIDLE = 1'b0,
  parameter [1:0] RXCFOKDONE_SRC = 2'b00,
  parameter [15:0] RXCFOK_CFG0 = 16'h4000,
  parameter [15:0] RXCFOK_CFG1 = 16'h0060,
  parameter [15:0] RXCFOK_CFG2 = 16'h000E,
  parameter [6:0] RXDFELPMRESET_TIME = 7'b0001111,
  parameter [15:0] RXDFELPM_KL_CFG0 = 16'h0000,
  parameter [15:0] RXDFELPM_KL_CFG1 = 16'h0032,
  parameter [15:0] RXDFELPM_KL_CFG2 = 16'h0000,
  parameter [15:0] RXDFE_CFG0 = 16'h0A00,
  parameter [15:0] RXDFE_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_GC_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_GC_CFG1 = 16'h7840,
  parameter [15:0] RXDFE_GC_CFG2 = 16'h0000,
  parameter [15:0] RXDFE_H2_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_H2_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_H3_CFG0 = 16'h4000,
  parameter [15:0] RXDFE_H3_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_H4_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H4_CFG1 = 16'h0003,
  parameter [15:0] RXDFE_H5_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H5_CFG1 = 16'h0003,
  parameter [15:0] RXDFE_H6_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H6_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_H7_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H7_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_H8_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H8_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_H9_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_H9_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HA_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_HA_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HB_CFG0 = 16'h2000,
  parameter [15:0] RXDFE_HB_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HC_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_HC_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HD_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_HD_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HE_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_HE_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_HF_CFG0 = 16'h0000,
  parameter [15:0] RXDFE_HF_CFG1 = 16'h0000,
  parameter [15:0] RXDFE_OS_CFG0 = 16'h8000,
  parameter [15:0] RXDFE_OS_CFG1 = 16'h0000,
  parameter [0:0] RXDFE_PWR_SAVING = 1'b0,
  parameter [15:0] RXDFE_UT_CFG0 = 16'h8000,
  parameter [15:0] RXDFE_UT_CFG1 = 16'h0003,
  parameter [15:0] RXDFE_VP_CFG0 = 16'hAA00,
  parameter [15:0] RXDFE_VP_CFG1 = 16'h0033,
  parameter [15:0] RXDLY_CFG = 16'h001F,
  parameter [15:0] RXDLY_LCFG = 16'h0030,
  parameter RXELECIDLE_CFG = "Sigcfg_4",
  parameter integer RXGBOX_FIFO_INIT_RD_ADDR = 4,
  parameter RXGEARBOX_EN = "FALSE",
  parameter [4:0] RXISCANRESET_TIME = 5'b00001,
  parameter [15:0] RXLPM_CFG = 16'h0000,
  parameter [15:0] RXLPM_GC_CFG = 16'h0000,
  parameter [15:0] RXLPM_KH_CFG0 = 16'h0000,
  parameter [15:0] RXLPM_KH_CFG1 = 16'h0002,
  parameter [15:0] RXLPM_OS_CFG0 = 16'h8000,
  parameter [15:0] RXLPM_OS_CFG1 = 16'h0002,
  parameter [8:0] RXOOB_CFG = 9'b000000110,
  parameter RXOOB_CLK_CFG = "PMA",
  parameter [4:0] RXOSCALRESET_TIME = 5'b00011,
  parameter integer RXOUT_DIV = 4,
  parameter [4:0] RXPCSRESET_TIME = 5'b00001,
  parameter [15:0] RXPHBEACON_CFG = 16'h0000,
  parameter [15:0] RXPHDLY_CFG = 16'h2020,
  parameter [15:0] RXPHSAMP_CFG = 16'h2100,
  parameter [15:0] RXPHSLIP_CFG = 16'h9933,
  parameter [4:0] RXPH_MONITOR_SEL = 5'b00000,
  parameter [0:0] RXPI_AUTO_BW_SEL_BYPASS = 1'b0,
  parameter [15:0] RXPI_CFG = 16'h0100,
  parameter [0:0] RXPI_LPM = 1'b0,
  parameter [15:0] RXPI_RSV0 = 16'h0000,
  parameter [1:0] RXPI_SEL_LC = 2'b00,
  parameter [1:0] RXPI_STARTCODE = 2'b00,
  parameter [0:0] RXPI_VREFSEL = 1'b0,
  parameter RXPMACLK_SEL = "DATA",
  parameter [4:0] RXPMARESET_TIME = 5'b00001,
  parameter [0:0] RXPRBS_ERR_LOOPBACK = 1'b0,
  parameter integer RXPRBS_LINKACQ_CNT = 15,
  parameter integer RXSLIDE_AUTO_WAIT = 7,
  parameter RXSLIDE_MODE = "OFF",
  parameter [0:0] RXSYNC_MULTILANE = 1'b0,
  parameter [0:0] RXSYNC_OVRD = 1'b0,
  parameter [0:0] RXSYNC_SKIP_DA = 1'b0,
  parameter [0:0] RX_AFE_CM_EN = 1'b0,
  parameter [15:0] RX_BIAS_CFG0 = 16'h0AD4,
  parameter [5:0] RX_BUFFER_CFG = 6'b000000,
  parameter [0:0] RX_CAPFF_SARC_ENB = 1'b0,
  parameter integer RX_CLK25_DIV = 8,
  parameter [0:0] RX_CLKMUX_EN = 1'b1,
  parameter [4:0] RX_CLK_SLIP_OVRD = 5'b00000,
  parameter [3:0] RX_CM_BUF_CFG = 4'b0000,
  parameter [0:0] RX_CM_BUF_PD = 1'b0,
  parameter [1:0] RX_CM_SEL = 2'b11,
  parameter [3:0] RX_CM_TRIM = 4'b0100,
  parameter [0:0] RX_CTLE1_KHKL = 1'b0,
  parameter [0:0] RX_CTLE2_KHKL = 1'b0,
  parameter [0:0] RX_CTLE3_AGC = 1'b0,
  parameter integer RX_DATA_WIDTH = 20,
  parameter [5:0] RX_DDI_SEL = 6'b000000,
  parameter RX_DEFER_RESET_BUF_EN = "TRUE",
  parameter [2:0] RX_DEGEN_CTRL = 3'b000,
  parameter [3:0] RX_DFELPM_CFG0 = 4'b0110,
  parameter [0:0] RX_DFELPM_CFG1 = 1'b0,
  parameter [0:0] RX_DFELPM_KLKH_AGC_STUP_EN = 1'b1,
  parameter [1:0] RX_DFE_AGC_CFG0 = 2'b00,
  parameter [2:0] RX_DFE_AGC_CFG1 = 3'b100,
  parameter [1:0] RX_DFE_KL_LPM_KH_CFG0 = 2'b01,
  parameter [2:0] RX_DFE_KL_LPM_KH_CFG1 = 3'b010,
  parameter [1:0] RX_DFE_KL_LPM_KL_CFG0 = 2'b01,
  parameter [2:0] RX_DFE_KL_LPM_KL_CFG1 = 3'b010,
  parameter [0:0] RX_DFE_LPM_HOLD_DURING_EIDLE = 1'b0,
  parameter RX_DISPERR_SEQ_MATCH = "TRUE",
  parameter [0:0] RX_DIV2_MODE_B = 1'b0,
  parameter [4:0] RX_DIVRESET_TIME = 5'b00001,
  parameter [0:0] RX_EN_CTLE_RCAL_B = 1'b0,
  parameter [0:0] RX_EN_HI_LR = 1'b0,
  parameter [8:0] RX_EXT_RL_CTRL = 9'b000000000,
  parameter [6:0] RX_EYESCAN_VS_CODE = 7'b0000000,
  parameter [0:0] RX_EYESCAN_VS_NEG_DIR = 1'b0,
  parameter [1:0] RX_EYESCAN_VS_RANGE = 2'b00,
  parameter [0:0] RX_EYESCAN_VS_UT_SIGN = 1'b0,
  parameter [0:0] RX_FABINT_USRCLK_FLOP = 1'b0,
  parameter integer RX_INT_DATAWIDTH = 1,
  parameter [0:0] RX_PMA_POWER_SAVE = 1'b0,
  parameter real RX_PROGDIV_CFG = 0.0,
  parameter [15:0] RX_PROGDIV_RATE = 16'h0001,
  parameter [3:0] RX_RESLOAD_CTRL = 4'b0000,
  parameter [0:0] RX_RESLOAD_OVRD = 1'b0,
  parameter [2:0] RX_SAMPLE_PERIOD = 3'b101,
  parameter integer RX_SIG_VALID_DLY = 11,
  parameter [0:0] RX_SUM_DFETAPREP_EN = 1'b0,
  parameter [3:0] RX_SUM_IREF_TUNE = 4'b0000,
  parameter [3:0] RX_SUM_VCMTUNE = 4'b0000,
  parameter [0:0] RX_SUM_VCM_OVWR = 1'b0,
  parameter [2:0] RX_SUM_VREF_TUNE = 3'b000,
  parameter [1:0] RX_TUNE_AFE_OS = 2'b00,
  parameter [2:0] RX_VREG_CTRL = 3'b000,
  parameter [0:0] RX_VREG_PDB = 1'b0,
  parameter [1:0] RX_WIDEMODE_CDR = 2'b00,
  parameter RX_XCLK_SEL = "RXDES",
  parameter [0:0] RX_XMODE_SEL = 1'b0,
  parameter integer SAS_MAX_COM = 64,
  parameter integer SAS_MIN_COM = 36,
  parameter [3:0] SATA_BURST_SEQ_LEN = 4'b1111,
  parameter [2:0] SATA_BURST_VAL = 3'b100,
  parameter SATA_CPLL_CFG = "VCO_3000MHZ",
  parameter [2:0] SATA_EIDLE_VAL = 3'b100,
  parameter integer SATA_MAX_BURST = 8,
  parameter integer SATA_MAX_INIT = 21,
  parameter integer SATA_MAX_WAKE = 7,
  parameter integer SATA_MIN_BURST = 4,
  parameter integer SATA_MIN_INIT = 12,
  parameter integer SATA_MIN_WAKE = 4,
  parameter SHOW_REALIGN_COMMA = "TRUE",
  parameter [2:0] SIM_CPLLREFCLK_SEL = 3'b001,
  parameter SIM_RECEIVER_DETECT_PASS = "TRUE",
  parameter SIM_RESET_SPEEDUP = "TRUE",
  parameter [0:0] SIM_TX_EIDLE_DRIVE_LEVEL = 1'b0,
  parameter SIM_VERSION = "Ver_1",
  parameter [1:0] TAPDLY_SET_TX = 2'h0,
  parameter [3:0] TEMPERATURE_PAR = 4'b0010,
  parameter [14:0] TERM_RCAL_CFG = 15'b100001000010000,
  parameter [2:0] TERM_RCAL_OVRD = 3'b000,
  parameter [7:0] TRANS_TIME_RATE = 8'h0E,
  parameter [7:0] TST_RSV0 = 8'h00,
  parameter [7:0] TST_RSV1 = 8'h00,
  parameter TXBUF_EN = "TRUE",
  parameter TXBUF_RESET_ON_RATE_CHANGE = "FALSE",
  parameter [15:0] TXDLY_CFG = 16'h001F,
  parameter [15:0] TXDLY_LCFG = 16'h0030,
  parameter TXFIFO_ADDR_CFG = "LOW",
  parameter integer TXGBOX_FIFO_INIT_RD_ADDR = 4,
  parameter TXGEARBOX_EN = "FALSE",
  parameter integer TXOUT_DIV = 4,
  parameter [4:0] TXPCSRESET_TIME = 5'b00001,
  parameter [15:0] TXPHDLY_CFG0 = 16'h2020,
  parameter [15:0] TXPHDLY_CFG1 = 16'h0001,
  parameter [15:0] TXPH_CFG = 16'h0123,
  parameter [15:0] TXPH_CFG2 = 16'h0000,
  parameter [4:0] TXPH_MONITOR_SEL = 5'b00000,
  parameter [1:0] TXPI_CFG0 = 2'b00,
  parameter [1:0] TXPI_CFG1 = 2'b00,
  parameter [1:0] TXPI_CFG2 = 2'b00,
  parameter [0:0] TXPI_CFG3 = 1'b0,
  parameter [0:0] TXPI_CFG4 = 1'b1,
  parameter [2:0] TXPI_CFG5 = 3'b000,
  parameter [0:0] TXPI_GRAY_SEL = 1'b0,
  parameter [0:0] TXPI_INVSTROBE_SEL = 1'b0,
  parameter [0:0] TXPI_LPM = 1'b0,
  parameter TXPI_PPMCLK_SEL = "TXUSRCLK2",
  parameter [7:0] TXPI_PPM_CFG = 8'b00000000,
  parameter [15:0] TXPI_RSV0 = 16'h0000,
  parameter [2:0] TXPI_SYNFREQ_PPM = 3'b000,
  parameter [0:0] TXPI_VREFSEL = 1'b0,
  parameter [4:0] TXPMARESET_TIME = 5'b00001,
  parameter [0:0] TXSYNC_MULTILANE = 1'b0,
  parameter [0:0] TXSYNC_OVRD = 1'b0,
  parameter [0:0] TXSYNC_SKIP_DA = 1'b0,
  parameter integer TX_CLK25_DIV = 8,
  parameter [0:0] TX_CLKMUX_EN = 1'b1,
  parameter [0:0] TX_CLKREG_PDB = 1'b0,
  parameter [2:0] TX_CLKREG_SET = 3'b000,
  parameter integer TX_DATA_WIDTH = 20,
  parameter [5:0] TX_DCD_CFG = 6'b000010,
  parameter [0:0] TX_DCD_EN = 1'b0,
  parameter [5:0] TX_DEEMPH0 = 6'b000000,
  parameter [5:0] TX_DEEMPH1 = 6'b000000,
  parameter [4:0] TX_DIVRESET_TIME = 5'b00001,
  parameter TX_DRIVE_MODE = "DIRECT",
  parameter [1:0] TX_DRVMUX_CTRL = 2'b00,
  parameter [2:0] TX_EIDLE_ASSERT_DELAY = 3'b110,
  parameter [2:0] TX_EIDLE_DEASSERT_DELAY = 3'b100,
  parameter [0:0] TX_EML_PHI_TUNE = 1'b0,
  parameter [0:0] TX_FABINT_USRCLK_FLOP = 1'b0,
  parameter [0:0] TX_FIFO_BYP_EN = 1'b0,
  parameter [0:0] TX_IDLE_DATA_ZERO = 1'b0,
  parameter integer TX_INT_DATAWIDTH = 1,
  parameter TX_LOOPBACK_DRIVE_HIZ = "FALSE",
  parameter [0:0] TX_MAINCURSOR_SEL = 1'b0,
  parameter [6:0] TX_MARGIN_FULL_0 = 7'b1001110,
  parameter [6:0] TX_MARGIN_FULL_1 = 7'b1001001,
  parameter [6:0] TX_MARGIN_FULL_2 = 7'b1000101,
  parameter [6:0] TX_MARGIN_FULL_3 = 7'b1000010,
  parameter [6:0] TX_MARGIN_FULL_4 = 7'b1000000,
  parameter [6:0] TX_MARGIN_LOW_0 = 7'b1000110,
  parameter [6:0] TX_MARGIN_LOW_1 = 7'b1000100,
  parameter [6:0] TX_MARGIN_LOW_2 = 7'b1000010,
  parameter [6:0] TX_MARGIN_LOW_3 = 7'b1000000,
  parameter [6:0] TX_MARGIN_LOW_4 = 7'b1000000,
  parameter [2:0] TX_MODE_SEL = 3'b000,
  parameter [15:0] TX_PHICAL_CFG0 = 16'h0000,
  parameter [15:0] TX_PHICAL_CFG1 = 16'h0000,
  parameter [15:0] TX_PHICAL_CFG2 = 16'h0000,
  parameter [1:0] TX_PI_BIASSET = 2'b00,
  parameter [15:0] TX_PI_CFG0 = 16'h0000,
  parameter [15:0] TX_PI_CFG1 = 16'h0000,
  parameter [0:0] TX_PI_DIV2_MODE_B = 1'b0,
  parameter [0:0] TX_PI_SEL_QPLL0 = 1'b0,
  parameter [0:0] TX_PI_SEL_QPLL1 = 1'b0,
  parameter [0:0] TX_PMADATA_OPT = 1'b0,
  parameter [0:0] TX_PMA_POWER_SAVE = 1'b0,
  parameter [1:0] TX_PREDRV_CTRL = 2'b00,
  parameter TX_PROGCLK_SEL = "POSTPI",
  parameter real TX_PROGDIV_CFG = 0.0,
  parameter [15:0] TX_PROGDIV_RATE = 16'h0001,
  parameter [13:0] TX_RXDETECT_CFG = 14'h0032,
  parameter [2:0] TX_RXDETECT_REF = 3'b100,
  parameter [2:0] TX_SAMPLE_PERIOD = 3'b101,
  parameter [0:0] TX_SARC_LPBK_ENB = 1'b0,
  parameter TX_XCLK_SEL = "TXOUT",
  parameter [0:0] USE_PCS_CLK_PHASE_SEL = 1'b0
)(
  output [2:0] BUFGTCE,
  output [2:0] BUFGTCEMASK,
  output [8:0] BUFGTDIV,
  output [2:0] BUFGTRESET,
  output [2:0] BUFGTRSTMASK,
  output CPLLFBCLKLOST,
  output CPLLLOCK,
  output CPLLREFCLKLOST,
  output [16:0] DMONITOROUT,
  output [15:0] DRPDO,
  output DRPRDY,
  output EYESCANDATAERROR,
  output GTPOWERGOOD,
  output GTREFCLKMONITOR,
  output GTYTXN,
  output GTYTXP,
  output PCIERATEGEN3,
  output PCIERATEIDLE,
  output [1:0] PCIERATEQPLLPD,
  output [1:0] PCIERATEQPLLRESET,
  output PCIESYNCTXSYNCDONE,
  output PCIEUSERGEN3RDY,
  output PCIEUSERPHYSTATUSRST,
  output PCIEUSERRATESTART,
  output [15:0] PCSRSVDOUT,
  output PHYSTATUS,
  output [7:0] PINRSRVDAS,
  output RESETEXCEPTION,
  output [2:0] RXBUFSTATUS,
  output RXBYTEISALIGNED,
  output RXBYTEREALIGN,
  output RXCDRLOCK,
  output RXCDRPHDONE,
  output RXCHANBONDSEQ,
  output RXCHANISALIGNED,
  output RXCHANREALIGN,
  output [4:0] RXCHBONDO,
  output RXCKOKDONE,
  output [1:0] RXCLKCORCNT,
  output RXCOMINITDET,
  output RXCOMMADET,
  output RXCOMSASDET,
  output RXCOMWAKEDET,
  output [15:0] RXCTRL0,
  output [15:0] RXCTRL1,
  output [7:0] RXCTRL2,
  output [7:0] RXCTRL3,
  output [127:0] RXDATA,
  output [7:0] RXDATAEXTENDRSVD,
  output [1:0] RXDATAVALID,
  output RXDLYSRESETDONE,
  output RXELECIDLE,
  output [5:0] RXHEADER,
  output [1:0] RXHEADERVALID,
  output [6:0] RXMONITOROUT,
  output RXOSINTDONE,
  output RXOSINTSTARTED,
  output RXOSINTSTROBEDONE,
  output RXOSINTSTROBESTARTED,
  output RXOUTCLK,
  output RXOUTCLKFABRIC,
  output RXOUTCLKPCS,
  output RXPHALIGNDONE,
  output RXPHALIGNERR,
  output RXPMARESETDONE,
  output RXPRBSERR,
  output RXPRBSLOCKED,
  output RXPRGDIVRESETDONE,
  output RXRATEDONE,
  output RXRECCLKOUT,
  output RXRESETDONE,
  output RXSLIDERDY,
  output RXSLIPDONE,
  output RXSLIPOUTCLKRDY,
  output RXSLIPPMARDY,
  output [1:0] RXSTARTOFSEQ,
  output [2:0] RXSTATUS,
  output RXSYNCDONE,
  output RXSYNCOUT,
  output RXVALID,
  output [1:0] TXBUFSTATUS,
  output TXCOMFINISH,
  output TXDCCDONE,
  output TXDLYSRESETDONE,
  output TXOUTCLK,
  output TXOUTCLKFABRIC,
  output TXOUTCLKPCS,
  output TXPHALIGNDONE,
  output TXPHINITDONE,
  output TXPMARESETDONE,
  output TXPRGDIVRESETDONE,
  output TXRATEDONE,
  output TXRESETDONE,
  output TXSYNCDONE,
  output TXSYNCOUT,

  input CDRSTEPDIR,
  input CDRSTEPSQ,
  input CDRSTEPSX,
  input CFGRESET,
  input CLKRSVD0,
  input CLKRSVD1,
  input CPLLLOCKDETCLK,
  input CPLLLOCKEN,
  input CPLLPD,
  input [2:0] CPLLREFCLKSEL,
  input CPLLRESET,
  input DMONFIFORESET,
  input DMONITORCLK,
  input [9:0] DRPADDR,
  input DRPCLK,
  input [15:0] DRPDI,
  input DRPEN,
  input DRPWE,
  input ELPCALDVORWREN,
  input ELPCALPAORWREN,
  input EVODDPHICALDONE,
  input EVODDPHICALSTART,
  input EVODDPHIDRDEN,
  input EVODDPHIDWREN,
  input EVODDPHIXRDEN,
  input EVODDPHIXWREN,
  input EYESCANMODE,
  input EYESCANRESET,
  input EYESCANTRIGGER,
  input GTGREFCLK,
  input GTNORTHREFCLK0,
  input GTNORTHREFCLK1,
  input GTREFCLK0,
  input GTREFCLK1,
  input GTRESETSEL,
  input [15:0] GTRSVD,
  input GTRXRESET,
  input GTSOUTHREFCLK0,
  input GTSOUTHREFCLK1,
  input GTTXRESET,
  input GTYRXN,
  input GTYRXP,
  input [2:0] LOOPBACK,
  input [15:0] LOOPRSVD,
  input LPBKRXTXSEREN,
  input LPBKTXRXSEREN,
  input PCIEEQRXEQADAPTDONE,
  input PCIERSTIDLE,
  input PCIERSTTXSYNCSTART,
  input PCIEUSERRATEDONE,
  input [15:0] PCSRSVDIN,
  input [4:0] PCSRSVDIN2,
  input [4:0] PMARSVDIN,
  input QPLL0CLK,
  input QPLL0REFCLK,
  input QPLL1CLK,
  input QPLL1REFCLK,
  input RESETOVRD,
  input RSTCLKENTX,
  input RX8B10BEN,
  input RXBUFRESET,
  input RXCDRFREQRESET,
  input RXCDRHOLD,
  input RXCDROVRDEN,
  input RXCDRRESET,
  input RXCDRRESETRSV,
  input RXCHBONDEN,
  input [4:0] RXCHBONDI,
  input [2:0] RXCHBONDLEVEL,
  input RXCHBONDMASTER,
  input RXCHBONDSLAVE,
  input RXCKOKRESET,
  input RXCOMMADETEN,
  input RXDCCFORCESTART,
  input RXDFEAGCHOLD,
  input RXDFEAGCOVRDEN,
  input RXDFELFHOLD,
  input RXDFELFOVRDEN,
  input RXDFELPMRESET,
  input RXDFETAP10HOLD,
  input RXDFETAP10OVRDEN,
  input RXDFETAP11HOLD,
  input RXDFETAP11OVRDEN,
  input RXDFETAP12HOLD,
  input RXDFETAP12OVRDEN,
  input RXDFETAP13HOLD,
  input RXDFETAP13OVRDEN,
  input RXDFETAP14HOLD,
  input RXDFETAP14OVRDEN,
  input RXDFETAP15HOLD,
  input RXDFETAP15OVRDEN,
  input RXDFETAP2HOLD,
  input RXDFETAP2OVRDEN,
  input RXDFETAP3HOLD,
  input RXDFETAP3OVRDEN,
  input RXDFETAP4HOLD,
  input RXDFETAP4OVRDEN,
  input RXDFETAP5HOLD,
  input RXDFETAP5OVRDEN,
  input RXDFETAP6HOLD,
  input RXDFETAP6OVRDEN,
  input RXDFETAP7HOLD,
  input RXDFETAP7OVRDEN,
  input RXDFETAP8HOLD,
  input RXDFETAP8OVRDEN,
  input RXDFETAP9HOLD,
  input RXDFETAP9OVRDEN,
  input RXDFEUTHOLD,
  input RXDFEUTOVRDEN,
  input RXDFEVPHOLD,
  input RXDFEVPOVRDEN,
  input RXDFEVSEN,
  input RXDFEXYDEN,
  input RXDLYBYPASS,
  input RXDLYEN,
  input RXDLYOVRDEN,
  input RXDLYSRESET,
  input [1:0] RXELECIDLEMODE,
  input RXGEARBOXSLIP,
  input RXLATCLK,
  input RXLPMEN,
  input RXLPMGCHOLD,
  input RXLPMGCOVRDEN,
  input RXLPMHFHOLD,
  input RXLPMHFOVRDEN,
  input RXLPMLFHOLD,
  input RXLPMLFKLOVRDEN,
  input RXLPMOSHOLD,
  input RXLPMOSOVRDEN,
  input RXMCOMMAALIGNEN,
  input [1:0] RXMONITORSEL,
  input RXOOBRESET,
  input RXOSCALRESET,
  input RXOSHOLD,
  input [3:0] RXOSINTCFG,
  input RXOSINTEN,
  input RXOSINTHOLD,
  input RXOSINTOVRDEN,
  input RXOSINTSTROBE,
  input RXOSINTTESTOVRDEN,
  input RXOSOVRDEN,
  input [2:0] RXOUTCLKSEL,
  input RXPCOMMAALIGNEN,
  input RXPCSRESET,
  input [1:0] RXPD,
  input RXPHALIGN,
  input RXPHALIGNEN,
  input RXPHDLYPD,
  input RXPHDLYRESET,
  input RXPHOVRDEN,
  input [1:0] RXPLLCLKSEL,
  input RXPMARESET,
  input RXPOLARITY,
  input RXPRBSCNTRESET,
  input [3:0] RXPRBSSEL,
  input RXPROGDIVRESET,
  input [2:0] RXRATE,
  input RXRATEMODE,
  input RXSLIDE,
  input RXSLIPOUTCLK,
  input RXSLIPPMA,
  input RXSYNCALLIN,
  input RXSYNCIN,
  input RXSYNCMODE,
  input [1:0] RXSYSCLKSEL,
  input RXUSERRDY,
  input RXUSRCLK,
  input RXUSRCLK2,
  input SIGVALIDCLK,
  input [19:0] TSTIN,
  input [7:0] TX8B10BBYPASS,
  input TX8B10BEN,
  input [2:0] TXBUFDIFFCTRL,
  input TXCOMINIT,
  input TXCOMSAS,
  input TXCOMWAKE,
  input [15:0] TXCTRL0,
  input [15:0] TXCTRL1,
  input [7:0] TXCTRL2,
  input [127:0] TXDATA,
  input [7:0] TXDATAEXTENDRSVD,
  input TXDCCFORCESTART,
  input TXDCCRESET,
  input TXDEEMPH,
  input TXDETECTRX,
  input [4:0] TXDIFFCTRL,
  input TXDIFFPD,
  input TXDLYBYPASS,
  input TXDLYEN,
  input TXDLYHOLD,
  input TXDLYOVRDEN,
  input TXDLYSRESET,
  input TXDLYUPDOWN,
  input TXELECIDLE,
  input TXELFORCESTART,
  input [5:0] TXHEADER,
  input TXINHIBIT,
  input TXLATCLK,
  input [6:0] TXMAINCURSOR,
  input [2:0] TXMARGIN,
  input [2:0] TXOUTCLKSEL,
  input TXPCSRESET,
  input [1:0] TXPD,
  input TXPDELECIDLEMODE,
  input TXPHALIGN,
  input TXPHALIGNEN,
  input TXPHDLYPD,
  input TXPHDLYRESET,
  input TXPHDLYTSTCLK,
  input TXPHINIT,
  input TXPHOVRDEN,
  input TXPIPPMEN,
  input TXPIPPMOVRDEN,
  input TXPIPPMPD,
  input TXPIPPMSEL,
  input [4:0] TXPIPPMSTEPSIZE,
  input TXPISOPD,
  input [1:0] TXPLLCLKSEL,
  input TXPMARESET,
  input TXPOLARITY,
  input [4:0] TXPOSTCURSOR,
  input TXPRBSFORCEERR,
  input [3:0] TXPRBSSEL,
  input [4:0] TXPRECURSOR,
  input TXPROGDIVRESET,
  input [2:0] TXRATE,
  input TXRATEMODE,
  input [6:0] TXSEQUENCE,
  input TXSWING,
  input TXSYNCALLIN,
  input TXSYNCIN,
  input TXSYNCMODE,
  input [1:0] TXSYSCLKSEL,
  input TXUSERRDY,
  input TXUSRCLK,
  input TXUSRCLK2
);
  
// define constants
  localparam MODULE_NAME = "GTYE3_CHANNEL";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers

  `ifndef XIL_DR
  localparam [0:0] ACJTAG_DEBUG_MODE_REG = ACJTAG_DEBUG_MODE;
  localparam [0:0] ACJTAG_MODE_REG = ACJTAG_MODE;
  localparam [0:0] ACJTAG_RESET_REG = ACJTAG_RESET;
  localparam [15:0] ADAPT_CFG0_REG = ADAPT_CFG0;
  localparam [15:0] ADAPT_CFG1_REG = ADAPT_CFG1;
  localparam [15:0] ADAPT_CFG2_REG = ADAPT_CFG2;
  localparam [40:1] ALIGN_COMMA_DOUBLE_REG = ALIGN_COMMA_DOUBLE;
  localparam [9:0] ALIGN_COMMA_ENABLE_REG = ALIGN_COMMA_ENABLE;
  localparam [2:0] ALIGN_COMMA_WORD_REG = ALIGN_COMMA_WORD;
  localparam [40:1] ALIGN_MCOMMA_DET_REG = ALIGN_MCOMMA_DET;
  localparam [9:0] ALIGN_MCOMMA_VALUE_REG = ALIGN_MCOMMA_VALUE;
  localparam [40:1] ALIGN_PCOMMA_DET_REG = ALIGN_PCOMMA_DET;
  localparam [9:0] ALIGN_PCOMMA_VALUE_REG = ALIGN_PCOMMA_VALUE;
  localparam [0:0] AUTO_BW_SEL_BYPASS_REG = AUTO_BW_SEL_BYPASS;
  localparam [0:0] A_RXOSCALRESET_REG = A_RXOSCALRESET;
  localparam [0:0] A_RXPROGDIVRESET_REG = A_RXPROGDIVRESET;
  localparam [4:0] A_TXDIFFCTRL_REG = A_TXDIFFCTRL;
  localparam [0:0] A_TXPROGDIVRESET_REG = A_TXPROGDIVRESET;
  localparam [0:0] CAPBYPASS_FORCE_REG = CAPBYPASS_FORCE;
  localparam [56:1] CBCC_DATA_SOURCE_SEL_REG = CBCC_DATA_SOURCE_SEL;
  localparam [0:0] CDR_SWAP_MODE_EN_REG = CDR_SWAP_MODE_EN;
  localparam [40:1] CHAN_BOND_KEEP_ALIGN_REG = CHAN_BOND_KEEP_ALIGN;
  localparam [3:0] CHAN_BOND_MAX_SKEW_REG = CHAN_BOND_MAX_SKEW;
  localparam [9:0] CHAN_BOND_SEQ_1_1_REG = CHAN_BOND_SEQ_1_1;
  localparam [9:0] CHAN_BOND_SEQ_1_2_REG = CHAN_BOND_SEQ_1_2;
  localparam [9:0] CHAN_BOND_SEQ_1_3_REG = CHAN_BOND_SEQ_1_3;
  localparam [9:0] CHAN_BOND_SEQ_1_4_REG = CHAN_BOND_SEQ_1_4;
  localparam [3:0] CHAN_BOND_SEQ_1_ENABLE_REG = CHAN_BOND_SEQ_1_ENABLE;
  localparam [9:0] CHAN_BOND_SEQ_2_1_REG = CHAN_BOND_SEQ_2_1;
  localparam [9:0] CHAN_BOND_SEQ_2_2_REG = CHAN_BOND_SEQ_2_2;
  localparam [9:0] CHAN_BOND_SEQ_2_3_REG = CHAN_BOND_SEQ_2_3;
  localparam [9:0] CHAN_BOND_SEQ_2_4_REG = CHAN_BOND_SEQ_2_4;
  localparam [3:0] CHAN_BOND_SEQ_2_ENABLE_REG = CHAN_BOND_SEQ_2_ENABLE;
  localparam [40:1] CHAN_BOND_SEQ_2_USE_REG = CHAN_BOND_SEQ_2_USE;
  localparam [2:0] CHAN_BOND_SEQ_LEN_REG = CHAN_BOND_SEQ_LEN;
  localparam [15:0] CH_HSPMUX_REG = CH_HSPMUX;
  localparam [15:0] CKCAL1_CFG_0_REG = CKCAL1_CFG_0;
  localparam [15:0] CKCAL1_CFG_1_REG = CKCAL1_CFG_1;
  localparam [15:0] CKCAL1_CFG_2_REG = CKCAL1_CFG_2;
  localparam [15:0] CKCAL1_CFG_3_REG = CKCAL1_CFG_3;
  localparam [15:0] CKCAL2_CFG_0_REG = CKCAL2_CFG_0;
  localparam [15:0] CKCAL2_CFG_1_REG = CKCAL2_CFG_1;
  localparam [15:0] CKCAL2_CFG_2_REG = CKCAL2_CFG_2;
  localparam [15:0] CKCAL2_CFG_3_REG = CKCAL2_CFG_3;
  localparam [15:0] CKCAL2_CFG_4_REG = CKCAL2_CFG_4;
  localparam [15:0] CKCAL_RSVD0_REG = CKCAL_RSVD0;
  localparam [15:0] CKCAL_RSVD1_REG = CKCAL_RSVD1;
  localparam [40:1] CLK_CORRECT_USE_REG = CLK_CORRECT_USE;
  localparam [40:1] CLK_COR_KEEP_IDLE_REG = CLK_COR_KEEP_IDLE;
  localparam [5:0] CLK_COR_MAX_LAT_REG = CLK_COR_MAX_LAT;
  localparam [5:0] CLK_COR_MIN_LAT_REG = CLK_COR_MIN_LAT;
  localparam [40:1] CLK_COR_PRECEDENCE_REG = CLK_COR_PRECEDENCE;
  localparam [4:0] CLK_COR_REPEAT_WAIT_REG = CLK_COR_REPEAT_WAIT;
  localparam [9:0] CLK_COR_SEQ_1_1_REG = CLK_COR_SEQ_1_1;
  localparam [9:0] CLK_COR_SEQ_1_2_REG = CLK_COR_SEQ_1_2;
  localparam [9:0] CLK_COR_SEQ_1_3_REG = CLK_COR_SEQ_1_3;
  localparam [9:0] CLK_COR_SEQ_1_4_REG = CLK_COR_SEQ_1_4;
  localparam [3:0] CLK_COR_SEQ_1_ENABLE_REG = CLK_COR_SEQ_1_ENABLE;
  localparam [9:0] CLK_COR_SEQ_2_1_REG = CLK_COR_SEQ_2_1;
  localparam [9:0] CLK_COR_SEQ_2_2_REG = CLK_COR_SEQ_2_2;
  localparam [9:0] CLK_COR_SEQ_2_3_REG = CLK_COR_SEQ_2_3;
  localparam [9:0] CLK_COR_SEQ_2_4_REG = CLK_COR_SEQ_2_4;
  localparam [3:0] CLK_COR_SEQ_2_ENABLE_REG = CLK_COR_SEQ_2_ENABLE;
  localparam [40:1] CLK_COR_SEQ_2_USE_REG = CLK_COR_SEQ_2_USE;
  localparam [2:0] CLK_COR_SEQ_LEN_REG = CLK_COR_SEQ_LEN;
  localparam [15:0] CPLL_CFG0_REG = CPLL_CFG0;
  localparam [15:0] CPLL_CFG1_REG = CPLL_CFG1;
  localparam [15:0] CPLL_CFG2_REG = CPLL_CFG2;
  localparam [5:0] CPLL_CFG3_REG = CPLL_CFG3;
  localparam [4:0] CPLL_FBDIV_REG = CPLL_FBDIV;
  localparam [2:0] CPLL_FBDIV_45_REG = CPLL_FBDIV_45;
  localparam [15:0] CPLL_INIT_CFG0_REG = CPLL_INIT_CFG0;
  localparam [7:0] CPLL_INIT_CFG1_REG = CPLL_INIT_CFG1;
  localparam [15:0] CPLL_LOCK_CFG_REG = CPLL_LOCK_CFG;
  localparam [4:0] CPLL_REFCLK_DIV_REG = CPLL_REFCLK_DIV;
  localparam [2:0] CTLE3_OCAP_EXT_CTRL_REG = CTLE3_OCAP_EXT_CTRL;
  localparam [0:0] CTLE3_OCAP_EXT_EN_REG = CTLE3_OCAP_EXT_EN;
  localparam [1:0] DDI_CTRL_REG = DDI_CTRL;
  localparam [4:0] DDI_REALIGN_WAIT_REG = DDI_REALIGN_WAIT;
  localparam [40:1] DEC_MCOMMA_DETECT_REG = DEC_MCOMMA_DETECT;
  localparam [40:1] DEC_PCOMMA_DETECT_REG = DEC_PCOMMA_DETECT;
  localparam [40:1] DEC_VALID_COMMA_ONLY_REG = DEC_VALID_COMMA_ONLY;
  localparam [0:0] DFE_D_X_REL_POS_REG = DFE_D_X_REL_POS;
  localparam [0:0] DFE_VCM_COMP_EN_REG = DFE_VCM_COMP_EN;
  localparam [9:0] DMONITOR_CFG0_REG = DMONITOR_CFG0;
  localparam [7:0] DMONITOR_CFG1_REG = DMONITOR_CFG1;
  localparam [0:0] ES_CLK_PHASE_SEL_REG = ES_CLK_PHASE_SEL;
  localparam [5:0] ES_CONTROL_REG = ES_CONTROL;
  localparam [40:1] ES_ERRDET_EN_REG = ES_ERRDET_EN;
  localparam [40:1] ES_EYE_SCAN_EN_REG = ES_EYE_SCAN_EN;
  localparam [11:0] ES_HORZ_OFFSET_REG = ES_HORZ_OFFSET;
  localparam [9:0] ES_PMA_CFG_REG = ES_PMA_CFG;
  localparam [4:0] ES_PRESCALE_REG = ES_PRESCALE;
  localparam [15:0] ES_QUALIFIER0_REG = ES_QUALIFIER0;
  localparam [15:0] ES_QUALIFIER1_REG = ES_QUALIFIER1;
  localparam [15:0] ES_QUALIFIER2_REG = ES_QUALIFIER2;
  localparam [15:0] ES_QUALIFIER3_REG = ES_QUALIFIER3;
  localparam [15:0] ES_QUALIFIER4_REG = ES_QUALIFIER4;
  localparam [15:0] ES_QUALIFIER5_REG = ES_QUALIFIER5;
  localparam [15:0] ES_QUALIFIER6_REG = ES_QUALIFIER6;
  localparam [15:0] ES_QUALIFIER7_REG = ES_QUALIFIER7;
  localparam [15:0] ES_QUALIFIER8_REG = ES_QUALIFIER8;
  localparam [15:0] ES_QUALIFIER9_REG = ES_QUALIFIER9;
  localparam [15:0] ES_QUAL_MASK0_REG = ES_QUAL_MASK0;
  localparam [15:0] ES_QUAL_MASK1_REG = ES_QUAL_MASK1;
  localparam [15:0] ES_QUAL_MASK2_REG = ES_QUAL_MASK2;
  localparam [15:0] ES_QUAL_MASK3_REG = ES_QUAL_MASK3;
  localparam [15:0] ES_QUAL_MASK4_REG = ES_QUAL_MASK4;
  localparam [15:0] ES_QUAL_MASK5_REG = ES_QUAL_MASK5;
  localparam [15:0] ES_QUAL_MASK6_REG = ES_QUAL_MASK6;
  localparam [15:0] ES_QUAL_MASK7_REG = ES_QUAL_MASK7;
  localparam [15:0] ES_QUAL_MASK8_REG = ES_QUAL_MASK8;
  localparam [15:0] ES_QUAL_MASK9_REG = ES_QUAL_MASK9;
  localparam [15:0] ES_SDATA_MASK0_REG = ES_SDATA_MASK0;
  localparam [15:0] ES_SDATA_MASK1_REG = ES_SDATA_MASK1;
  localparam [15:0] ES_SDATA_MASK2_REG = ES_SDATA_MASK2;
  localparam [15:0] ES_SDATA_MASK3_REG = ES_SDATA_MASK3;
  localparam [15:0] ES_SDATA_MASK4_REG = ES_SDATA_MASK4;
  localparam [15:0] ES_SDATA_MASK5_REG = ES_SDATA_MASK5;
  localparam [15:0] ES_SDATA_MASK6_REG = ES_SDATA_MASK6;
  localparam [15:0] ES_SDATA_MASK7_REG = ES_SDATA_MASK7;
  localparam [15:0] ES_SDATA_MASK8_REG = ES_SDATA_MASK8;
  localparam [15:0] ES_SDATA_MASK9_REG = ES_SDATA_MASK9;
  localparam [10:0] EVODD_PHI_CFG_REG = EVODD_PHI_CFG;
  localparam [0:0] EYE_SCAN_SWAP_EN_REG = EYE_SCAN_SWAP_EN;
  localparam [3:0] FTS_DESKEW_SEQ_ENABLE_REG = FTS_DESKEW_SEQ_ENABLE;
  localparam [3:0] FTS_LANE_DESKEW_CFG_REG = FTS_LANE_DESKEW_CFG;
  localparam [40:1] FTS_LANE_DESKEW_EN_REG = FTS_LANE_DESKEW_EN;
  localparam [4:0] GEARBOX_MODE_REG = GEARBOX_MODE;
  localparam [0:0] GM_BIAS_SELECT_REG = GM_BIAS_SELECT;
  localparam [0:0] ISCAN_CK_PH_SEL2_REG = ISCAN_CK_PH_SEL2;
  localparam [0:0] LOCAL_MASTER_REG = LOCAL_MASTER;
  localparam [15:0] LOOP0_CFG_REG = LOOP0_CFG;
  localparam [15:0] LOOP10_CFG_REG = LOOP10_CFG;
  localparam [15:0] LOOP11_CFG_REG = LOOP11_CFG;
  localparam [15:0] LOOP12_CFG_REG = LOOP12_CFG;
  localparam [15:0] LOOP13_CFG_REG = LOOP13_CFG;
  localparam [15:0] LOOP1_CFG_REG = LOOP1_CFG;
  localparam [15:0] LOOP2_CFG_REG = LOOP2_CFG;
  localparam [15:0] LOOP3_CFG_REG = LOOP3_CFG;
  localparam [15:0] LOOP4_CFG_REG = LOOP4_CFG;
  localparam [15:0] LOOP5_CFG_REG = LOOP5_CFG;
  localparam [15:0] LOOP6_CFG_REG = LOOP6_CFG;
  localparam [15:0] LOOP7_CFG_REG = LOOP7_CFG;
  localparam [15:0] LOOP8_CFG_REG = LOOP8_CFG;
  localparam [15:0] LOOP9_CFG_REG = LOOP9_CFG;
  localparam [2:0] LPBK_BIAS_CTRL_REG = LPBK_BIAS_CTRL;
  localparam [0:0] LPBK_EN_RCAL_B_REG = LPBK_EN_RCAL_B;
  localparam [3:0] LPBK_EXT_RCAL_REG = LPBK_EXT_RCAL;
  localparam [3:0] LPBK_RG_CTRL_REG = LPBK_RG_CTRL;
  localparam [1:0] OOBDIVCTL_REG = OOBDIVCTL;
  localparam [0:0] OOB_PWRUP_REG = OOB_PWRUP;
  localparam [80:1] PCI3_AUTO_REALIGN_REG = PCI3_AUTO_REALIGN;
  localparam [0:0] PCI3_PIPE_RX_ELECIDLE_REG = PCI3_PIPE_RX_ELECIDLE;
  localparam [1:0] PCI3_RX_ASYNC_EBUF_BYPASS_REG = PCI3_RX_ASYNC_EBUF_BYPASS;
  localparam [0:0] PCI3_RX_ELECIDLE_EI2_ENABLE_REG = PCI3_RX_ELECIDLE_EI2_ENABLE;
  localparam [5:0] PCI3_RX_ELECIDLE_H2L_COUNT_REG = PCI3_RX_ELECIDLE_H2L_COUNT;
  localparam [2:0] PCI3_RX_ELECIDLE_H2L_DISABLE_REG = PCI3_RX_ELECIDLE_H2L_DISABLE;
  localparam [5:0] PCI3_RX_ELECIDLE_HI_COUNT_REG = PCI3_RX_ELECIDLE_HI_COUNT;
  localparam [0:0] PCI3_RX_ELECIDLE_LP4_DISABLE_REG = PCI3_RX_ELECIDLE_LP4_DISABLE;
  localparam [0:0] PCI3_RX_FIFO_DISABLE_REG = PCI3_RX_FIFO_DISABLE;
  localparam [15:0] PCIE_BUFG_DIV_CTRL_REG = PCIE_BUFG_DIV_CTRL;
  localparam [15:0] PCIE_RXPCS_CFG_GEN3_REG = PCIE_RXPCS_CFG_GEN3;
  localparam [15:0] PCIE_RXPMA_CFG_REG = PCIE_RXPMA_CFG;
  localparam [15:0] PCIE_TXPCS_CFG_GEN3_REG = PCIE_TXPCS_CFG_GEN3;
  localparam [15:0] PCIE_TXPMA_CFG_REG = PCIE_TXPMA_CFG;
  localparam [40:1] PCS_PCIE_EN_REG = PCS_PCIE_EN;
  localparam [15:0] PCS_RSVD0_REG = PCS_RSVD0;
  localparam [2:0] PCS_RSVD1_REG = PCS_RSVD1;
  localparam [11:0] PD_TRANS_TIME_FROM_P2_REG = PD_TRANS_TIME_FROM_P2;
  localparam [7:0] PD_TRANS_TIME_NONE_P2_REG = PD_TRANS_TIME_NONE_P2;
  localparam [7:0] PD_TRANS_TIME_TO_P2_REG = PD_TRANS_TIME_TO_P2;
  localparam [1:0] PLL_SEL_MODE_GEN12_REG = PLL_SEL_MODE_GEN12;
  localparam [1:0] PLL_SEL_MODE_GEN3_REG = PLL_SEL_MODE_GEN3;
  localparam [15:0] PMA_RSV0_REG = PMA_RSV0;
  localparam [15:0] PMA_RSV1_REG = PMA_RSV1;
  localparam [1:0] PREIQ_FREQ_BST_REG = PREIQ_FREQ_BST;
  localparam [2:0] PROCESS_PAR_REG = PROCESS_PAR;
  localparam [0:0] RATE_SW_USE_DRP_REG = RATE_SW_USE_DRP;
  localparam [0:0] RESET_POWERSAVE_DISABLE_REG = RESET_POWERSAVE_DISABLE;
  localparam [4:0] RXBUFRESET_TIME_REG = RXBUFRESET_TIME;
  localparam [32:1] RXBUF_ADDR_MODE_REG = RXBUF_ADDR_MODE;
  localparam [3:0] RXBUF_EIDLE_HI_CNT_REG = RXBUF_EIDLE_HI_CNT;
  localparam [3:0] RXBUF_EIDLE_LO_CNT_REG = RXBUF_EIDLE_LO_CNT;
  localparam [40:1] RXBUF_EN_REG = RXBUF_EN;
  localparam [40:1] RXBUF_RESET_ON_CB_CHANGE_REG = RXBUF_RESET_ON_CB_CHANGE;
  localparam [40:1] RXBUF_RESET_ON_COMMAALIGN_REG = RXBUF_RESET_ON_COMMAALIGN;
  localparam [40:1] RXBUF_RESET_ON_EIDLE_REG = RXBUF_RESET_ON_EIDLE;
  localparam [40:1] RXBUF_RESET_ON_RATE_CHANGE_REG = RXBUF_RESET_ON_RATE_CHANGE;
  localparam [5:0] RXBUF_THRESH_OVFLW_REG = RXBUF_THRESH_OVFLW;
  localparam [40:1] RXBUF_THRESH_OVRD_REG = RXBUF_THRESH_OVRD;
  localparam [5:0] RXBUF_THRESH_UNDFLW_REG = RXBUF_THRESH_UNDFLW;
  localparam [4:0] RXCDRFREQRESET_TIME_REG = RXCDRFREQRESET_TIME;
  localparam [4:0] RXCDRPHRESET_TIME_REG = RXCDRPHRESET_TIME;
  localparam [15:0] RXCDR_CFG0_REG = RXCDR_CFG0;
  localparam [15:0] RXCDR_CFG0_GEN3_REG = RXCDR_CFG0_GEN3;
  localparam [15:0] RXCDR_CFG1_REG = RXCDR_CFG1;
  localparam [15:0] RXCDR_CFG1_GEN3_REG = RXCDR_CFG1_GEN3;
  localparam [15:0] RXCDR_CFG2_REG = RXCDR_CFG2;
  localparam [15:0] RXCDR_CFG2_GEN3_REG = RXCDR_CFG2_GEN3;
  localparam [15:0] RXCDR_CFG3_REG = RXCDR_CFG3;
  localparam [15:0] RXCDR_CFG3_GEN3_REG = RXCDR_CFG3_GEN3;
  localparam [15:0] RXCDR_CFG4_REG = RXCDR_CFG4;
  localparam [15:0] RXCDR_CFG4_GEN3_REG = RXCDR_CFG4_GEN3;
  localparam [15:0] RXCDR_CFG5_REG = RXCDR_CFG5;
  localparam [15:0] RXCDR_CFG5_GEN3_REG = RXCDR_CFG5_GEN3;
  localparam [0:0] RXCDR_FR_RESET_ON_EIDLE_REG = RXCDR_FR_RESET_ON_EIDLE;
  localparam [0:0] RXCDR_HOLD_DURING_EIDLE_REG = RXCDR_HOLD_DURING_EIDLE;
  localparam [15:0] RXCDR_LOCK_CFG0_REG = RXCDR_LOCK_CFG0;
  localparam [15:0] RXCDR_LOCK_CFG1_REG = RXCDR_LOCK_CFG1;
  localparam [15:0] RXCDR_LOCK_CFG2_REG = RXCDR_LOCK_CFG2;
  localparam [15:0] RXCDR_LOCK_CFG3_REG = RXCDR_LOCK_CFG3;
  localparam [0:0] RXCDR_PH_RESET_ON_EIDLE_REG = RXCDR_PH_RESET_ON_EIDLE;
  localparam [1:0] RXCFOKDONE_SRC_REG = RXCFOKDONE_SRC;
  localparam [15:0] RXCFOK_CFG0_REG = RXCFOK_CFG0;
  localparam [15:0] RXCFOK_CFG1_REG = RXCFOK_CFG1;
  localparam [15:0] RXCFOK_CFG2_REG = RXCFOK_CFG2;
  localparam [6:0] RXDFELPMRESET_TIME_REG = RXDFELPMRESET_TIME;
  localparam [15:0] RXDFELPM_KL_CFG0_REG = RXDFELPM_KL_CFG0;
  localparam [15:0] RXDFELPM_KL_CFG1_REG = RXDFELPM_KL_CFG1;
  localparam [15:0] RXDFELPM_KL_CFG2_REG = RXDFELPM_KL_CFG2;
  localparam [15:0] RXDFE_CFG0_REG = RXDFE_CFG0;
  localparam [15:0] RXDFE_CFG1_REG = RXDFE_CFG1;
  localparam [15:0] RXDFE_GC_CFG0_REG = RXDFE_GC_CFG0;
  localparam [15:0] RXDFE_GC_CFG1_REG = RXDFE_GC_CFG1;
  localparam [15:0] RXDFE_GC_CFG2_REG = RXDFE_GC_CFG2;
  localparam [15:0] RXDFE_H2_CFG0_REG = RXDFE_H2_CFG0;
  localparam [15:0] RXDFE_H2_CFG1_REG = RXDFE_H2_CFG1;
  localparam [15:0] RXDFE_H3_CFG0_REG = RXDFE_H3_CFG0;
  localparam [15:0] RXDFE_H3_CFG1_REG = RXDFE_H3_CFG1;
  localparam [15:0] RXDFE_H4_CFG0_REG = RXDFE_H4_CFG0;
  localparam [15:0] RXDFE_H4_CFG1_REG = RXDFE_H4_CFG1;
  localparam [15:0] RXDFE_H5_CFG0_REG = RXDFE_H5_CFG0;
  localparam [15:0] RXDFE_H5_CFG1_REG = RXDFE_H5_CFG1;
  localparam [15:0] RXDFE_H6_CFG0_REG = RXDFE_H6_CFG0;
  localparam [15:0] RXDFE_H6_CFG1_REG = RXDFE_H6_CFG1;
  localparam [15:0] RXDFE_H7_CFG0_REG = RXDFE_H7_CFG0;
  localparam [15:0] RXDFE_H7_CFG1_REG = RXDFE_H7_CFG1;
  localparam [15:0] RXDFE_H8_CFG0_REG = RXDFE_H8_CFG0;
  localparam [15:0] RXDFE_H8_CFG1_REG = RXDFE_H8_CFG1;
  localparam [15:0] RXDFE_H9_CFG0_REG = RXDFE_H9_CFG0;
  localparam [15:0] RXDFE_H9_CFG1_REG = RXDFE_H9_CFG1;
  localparam [15:0] RXDFE_HA_CFG0_REG = RXDFE_HA_CFG0;
  localparam [15:0] RXDFE_HA_CFG1_REG = RXDFE_HA_CFG1;
  localparam [15:0] RXDFE_HB_CFG0_REG = RXDFE_HB_CFG0;
  localparam [15:0] RXDFE_HB_CFG1_REG = RXDFE_HB_CFG1;
  localparam [15:0] RXDFE_HC_CFG0_REG = RXDFE_HC_CFG0;
  localparam [15:0] RXDFE_HC_CFG1_REG = RXDFE_HC_CFG1;
  localparam [15:0] RXDFE_HD_CFG0_REG = RXDFE_HD_CFG0;
  localparam [15:0] RXDFE_HD_CFG1_REG = RXDFE_HD_CFG1;
  localparam [15:0] RXDFE_HE_CFG0_REG = RXDFE_HE_CFG0;
  localparam [15:0] RXDFE_HE_CFG1_REG = RXDFE_HE_CFG1;
  localparam [15:0] RXDFE_HF_CFG0_REG = RXDFE_HF_CFG0;
  localparam [15:0] RXDFE_HF_CFG1_REG = RXDFE_HF_CFG1;
  localparam [15:0] RXDFE_OS_CFG0_REG = RXDFE_OS_CFG0;
  localparam [15:0] RXDFE_OS_CFG1_REG = RXDFE_OS_CFG1;
  localparam [0:0] RXDFE_PWR_SAVING_REG = RXDFE_PWR_SAVING;
  localparam [15:0] RXDFE_UT_CFG0_REG = RXDFE_UT_CFG0;
  localparam [15:0] RXDFE_UT_CFG1_REG = RXDFE_UT_CFG1;
  localparam [15:0] RXDFE_VP_CFG0_REG = RXDFE_VP_CFG0;
  localparam [15:0] RXDFE_VP_CFG1_REG = RXDFE_VP_CFG1;
  localparam [15:0] RXDLY_CFG_REG = RXDLY_CFG;
  localparam [15:0] RXDLY_LCFG_REG = RXDLY_LCFG;
  localparam [72:1] RXELECIDLE_CFG_REG = RXELECIDLE_CFG;
  localparam [2:0] RXGBOX_FIFO_INIT_RD_ADDR_REG = RXGBOX_FIFO_INIT_RD_ADDR;
  localparam [40:1] RXGEARBOX_EN_REG = RXGEARBOX_EN;
  localparam [4:0] RXISCANRESET_TIME_REG = RXISCANRESET_TIME;
  localparam [15:0] RXLPM_CFG_REG = RXLPM_CFG;
  localparam [15:0] RXLPM_GC_CFG_REG = RXLPM_GC_CFG;
  localparam [15:0] RXLPM_KH_CFG0_REG = RXLPM_KH_CFG0;
  localparam [15:0] RXLPM_KH_CFG1_REG = RXLPM_KH_CFG1;
  localparam [15:0] RXLPM_OS_CFG0_REG = RXLPM_OS_CFG0;
  localparam [15:0] RXLPM_OS_CFG1_REG = RXLPM_OS_CFG1;
  localparam [8:0] RXOOB_CFG_REG = RXOOB_CFG;
  localparam [48:1] RXOOB_CLK_CFG_REG = RXOOB_CLK_CFG;
  localparam [4:0] RXOSCALRESET_TIME_REG = RXOSCALRESET_TIME;
  localparam [5:0] RXOUT_DIV_REG = RXOUT_DIV;
  localparam [4:0] RXPCSRESET_TIME_REG = RXPCSRESET_TIME;
  localparam [15:0] RXPHBEACON_CFG_REG = RXPHBEACON_CFG;
  localparam [15:0] RXPHDLY_CFG_REG = RXPHDLY_CFG;
  localparam [15:0] RXPHSAMP_CFG_REG = RXPHSAMP_CFG;
  localparam [15:0] RXPHSLIP_CFG_REG = RXPHSLIP_CFG;
  localparam [4:0] RXPH_MONITOR_SEL_REG = RXPH_MONITOR_SEL;
  localparam [0:0] RXPI_AUTO_BW_SEL_BYPASS_REG = RXPI_AUTO_BW_SEL_BYPASS;
  localparam [15:0] RXPI_CFG_REG = RXPI_CFG;
  localparam [0:0] RXPI_LPM_REG = RXPI_LPM;
  localparam [15:0] RXPI_RSV0_REG = RXPI_RSV0;
  localparam [1:0] RXPI_SEL_LC_REG = RXPI_SEL_LC;
  localparam [1:0] RXPI_STARTCODE_REG = RXPI_STARTCODE;
  localparam [0:0] RXPI_VREFSEL_REG = RXPI_VREFSEL;
  localparam [64:1] RXPMACLK_SEL_REG = RXPMACLK_SEL;
  localparam [4:0] RXPMARESET_TIME_REG = RXPMARESET_TIME;
  localparam [0:0] RXPRBS_ERR_LOOPBACK_REG = RXPRBS_ERR_LOOPBACK;
  localparam [7:0] RXPRBS_LINKACQ_CNT_REG = RXPRBS_LINKACQ_CNT;
  localparam [3:0] RXSLIDE_AUTO_WAIT_REG = RXSLIDE_AUTO_WAIT;
  localparam [32:1] RXSLIDE_MODE_REG = RXSLIDE_MODE;
  localparam [0:0] RXSYNC_MULTILANE_REG = RXSYNC_MULTILANE;
  localparam [0:0] RXSYNC_OVRD_REG = RXSYNC_OVRD;
  localparam [0:0] RXSYNC_SKIP_DA_REG = RXSYNC_SKIP_DA;
  localparam [0:0] RX_AFE_CM_EN_REG = RX_AFE_CM_EN;
  localparam [15:0] RX_BIAS_CFG0_REG = RX_BIAS_CFG0;
  localparam [5:0] RX_BUFFER_CFG_REG = RX_BUFFER_CFG;
  localparam [0:0] RX_CAPFF_SARC_ENB_REG = RX_CAPFF_SARC_ENB;
  localparam [5:0] RX_CLK25_DIV_REG = RX_CLK25_DIV;
  localparam [0:0] RX_CLKMUX_EN_REG = RX_CLKMUX_EN;
  localparam [4:0] RX_CLK_SLIP_OVRD_REG = RX_CLK_SLIP_OVRD;
  localparam [3:0] RX_CM_BUF_CFG_REG = RX_CM_BUF_CFG;
  localparam [0:0] RX_CM_BUF_PD_REG = RX_CM_BUF_PD;
  localparam [1:0] RX_CM_SEL_REG = RX_CM_SEL;
  localparam [3:0] RX_CM_TRIM_REG = RX_CM_TRIM;
  localparam [0:0] RX_CTLE1_KHKL_REG = RX_CTLE1_KHKL;
  localparam [0:0] RX_CTLE2_KHKL_REG = RX_CTLE2_KHKL;
  localparam [0:0] RX_CTLE3_AGC_REG = RX_CTLE3_AGC;
  localparam [7:0] RX_DATA_WIDTH_REG = RX_DATA_WIDTH;
  localparam [5:0] RX_DDI_SEL_REG = RX_DDI_SEL;
  localparam [40:1] RX_DEFER_RESET_BUF_EN_REG = RX_DEFER_RESET_BUF_EN;
  localparam [2:0] RX_DEGEN_CTRL_REG = RX_DEGEN_CTRL;
  localparam [3:0] RX_DFELPM_CFG0_REG = RX_DFELPM_CFG0;
  localparam [0:0] RX_DFELPM_CFG1_REG = RX_DFELPM_CFG1;
  localparam [0:0] RX_DFELPM_KLKH_AGC_STUP_EN_REG = RX_DFELPM_KLKH_AGC_STUP_EN;
  localparam [1:0] RX_DFE_AGC_CFG0_REG = RX_DFE_AGC_CFG0;
  localparam [2:0] RX_DFE_AGC_CFG1_REG = RX_DFE_AGC_CFG1;
  localparam [1:0] RX_DFE_KL_LPM_KH_CFG0_REG = RX_DFE_KL_LPM_KH_CFG0;
  localparam [2:0] RX_DFE_KL_LPM_KH_CFG1_REG = RX_DFE_KL_LPM_KH_CFG1;
  localparam [1:0] RX_DFE_KL_LPM_KL_CFG0_REG = RX_DFE_KL_LPM_KL_CFG0;
  localparam [2:0] RX_DFE_KL_LPM_KL_CFG1_REG = RX_DFE_KL_LPM_KL_CFG1;
  localparam [0:0] RX_DFE_LPM_HOLD_DURING_EIDLE_REG = RX_DFE_LPM_HOLD_DURING_EIDLE;
  localparam [40:1] RX_DISPERR_SEQ_MATCH_REG = RX_DISPERR_SEQ_MATCH;
  localparam [0:0] RX_DIV2_MODE_B_REG = RX_DIV2_MODE_B;
  localparam [4:0] RX_DIVRESET_TIME_REG = RX_DIVRESET_TIME;
  localparam [0:0] RX_EN_CTLE_RCAL_B_REG = RX_EN_CTLE_RCAL_B;
  localparam [0:0] RX_EN_HI_LR_REG = RX_EN_HI_LR;
  localparam [8:0] RX_EXT_RL_CTRL_REG = RX_EXT_RL_CTRL;
  localparam [6:0] RX_EYESCAN_VS_CODE_REG = RX_EYESCAN_VS_CODE;
  localparam [0:0] RX_EYESCAN_VS_NEG_DIR_REG = RX_EYESCAN_VS_NEG_DIR;
  localparam [1:0] RX_EYESCAN_VS_RANGE_REG = RX_EYESCAN_VS_RANGE;
  localparam [0:0] RX_EYESCAN_VS_UT_SIGN_REG = RX_EYESCAN_VS_UT_SIGN;
  localparam [0:0] RX_FABINT_USRCLK_FLOP_REG = RX_FABINT_USRCLK_FLOP;
  localparam [1:0] RX_INT_DATAWIDTH_REG = RX_INT_DATAWIDTH;
  localparam [0:0] RX_PMA_POWER_SAVE_REG = RX_PMA_POWER_SAVE;
  localparam [63:0] RX_PROGDIV_CFG_REG = RX_PROGDIV_CFG * 1000;
  localparam [15:0] RX_PROGDIV_RATE_REG = RX_PROGDIV_RATE;
  localparam [3:0] RX_RESLOAD_CTRL_REG = RX_RESLOAD_CTRL;
  localparam [0:0] RX_RESLOAD_OVRD_REG = RX_RESLOAD_OVRD;
  localparam [2:0] RX_SAMPLE_PERIOD_REG = RX_SAMPLE_PERIOD;
  localparam [5:0] RX_SIG_VALID_DLY_REG = RX_SIG_VALID_DLY;
  localparam [0:0] RX_SUM_DFETAPREP_EN_REG = RX_SUM_DFETAPREP_EN;
  localparam [3:0] RX_SUM_IREF_TUNE_REG = RX_SUM_IREF_TUNE;
  localparam [3:0] RX_SUM_VCMTUNE_REG = RX_SUM_VCMTUNE;
  localparam [0:0] RX_SUM_VCM_OVWR_REG = RX_SUM_VCM_OVWR;
  localparam [2:0] RX_SUM_VREF_TUNE_REG = RX_SUM_VREF_TUNE;
  localparam [1:0] RX_TUNE_AFE_OS_REG = RX_TUNE_AFE_OS;
  localparam [2:0] RX_VREG_CTRL_REG = RX_VREG_CTRL;
  localparam [0:0] RX_VREG_PDB_REG = RX_VREG_PDB;
  localparam [1:0] RX_WIDEMODE_CDR_REG = RX_WIDEMODE_CDR;
  localparam [40:1] RX_XCLK_SEL_REG = RX_XCLK_SEL;
  localparam [0:0] RX_XMODE_SEL_REG = RX_XMODE_SEL;
  localparam [6:0] SAS_MAX_COM_REG = SAS_MAX_COM;
  localparam [5:0] SAS_MIN_COM_REG = SAS_MIN_COM;
  localparam [3:0] SATA_BURST_SEQ_LEN_REG = SATA_BURST_SEQ_LEN;
  localparam [2:0] SATA_BURST_VAL_REG = SATA_BURST_VAL;
  localparam [88:1] SATA_CPLL_CFG_REG = SATA_CPLL_CFG;
  localparam [2:0] SATA_EIDLE_VAL_REG = SATA_EIDLE_VAL;
  localparam [5:0] SATA_MAX_BURST_REG = SATA_MAX_BURST;
  localparam [5:0] SATA_MAX_INIT_REG = SATA_MAX_INIT;
  localparam [5:0] SATA_MAX_WAKE_REG = SATA_MAX_WAKE;
  localparam [5:0] SATA_MIN_BURST_REG = SATA_MIN_BURST;
  localparam [5:0] SATA_MIN_INIT_REG = SATA_MIN_INIT;
  localparam [5:0] SATA_MIN_WAKE_REG = SATA_MIN_WAKE;
  localparam [40:1] SHOW_REALIGN_COMMA_REG = SHOW_REALIGN_COMMA;
  localparam [2:0] SIM_CPLLREFCLK_SEL_REG = SIM_CPLLREFCLK_SEL;
  localparam [40:1] SIM_RECEIVER_DETECT_PASS_REG = SIM_RECEIVER_DETECT_PASS;
  localparam [40:1] SIM_RESET_SPEEDUP_REG = SIM_RESET_SPEEDUP;
  localparam [0:0] SIM_TX_EIDLE_DRIVE_LEVEL_REG = SIM_TX_EIDLE_DRIVE_LEVEL;
  localparam [56:1] SIM_VERSION_REG = SIM_VERSION;
  localparam [1:0] TAPDLY_SET_TX_REG = TAPDLY_SET_TX;
  localparam [3:0] TEMPERATURE_PAR_REG = TEMPERATURE_PAR;
  localparam [14:0] TERM_RCAL_CFG_REG = TERM_RCAL_CFG;
  localparam [2:0] TERM_RCAL_OVRD_REG = TERM_RCAL_OVRD;
  localparam [7:0] TRANS_TIME_RATE_REG = TRANS_TIME_RATE;
  localparam [7:0] TST_RSV0_REG = TST_RSV0;
  localparam [7:0] TST_RSV1_REG = TST_RSV1;
  localparam [40:1] TXBUF_EN_REG = TXBUF_EN;
  localparam [40:1] TXBUF_RESET_ON_RATE_CHANGE_REG = TXBUF_RESET_ON_RATE_CHANGE;
  localparam [15:0] TXDLY_CFG_REG = TXDLY_CFG;
  localparam [15:0] TXDLY_LCFG_REG = TXDLY_LCFG;
  localparam [32:1] TXFIFO_ADDR_CFG_REG = TXFIFO_ADDR_CFG;
  localparam [2:0] TXGBOX_FIFO_INIT_RD_ADDR_REG = TXGBOX_FIFO_INIT_RD_ADDR;
  localparam [40:1] TXGEARBOX_EN_REG = TXGEARBOX_EN;
  localparam [4:0] TXOUT_DIV_REG = TXOUT_DIV;
  localparam [4:0] TXPCSRESET_TIME_REG = TXPCSRESET_TIME;
  localparam [15:0] TXPHDLY_CFG0_REG = TXPHDLY_CFG0;
  localparam [15:0] TXPHDLY_CFG1_REG = TXPHDLY_CFG1;
  localparam [15:0] TXPH_CFG_REG = TXPH_CFG;
  localparam [15:0] TXPH_CFG2_REG = TXPH_CFG2;
  localparam [4:0] TXPH_MONITOR_SEL_REG = TXPH_MONITOR_SEL;
  localparam [1:0] TXPI_CFG0_REG = TXPI_CFG0;
  localparam [1:0] TXPI_CFG1_REG = TXPI_CFG1;
  localparam [1:0] TXPI_CFG2_REG = TXPI_CFG2;
  localparam [0:0] TXPI_CFG3_REG = TXPI_CFG3;
  localparam [0:0] TXPI_CFG4_REG = TXPI_CFG4;
  localparam [2:0] TXPI_CFG5_REG = TXPI_CFG5;
  localparam [0:0] TXPI_GRAY_SEL_REG = TXPI_GRAY_SEL;
  localparam [0:0] TXPI_INVSTROBE_SEL_REG = TXPI_INVSTROBE_SEL;
  localparam [0:0] TXPI_LPM_REG = TXPI_LPM;
  localparam [72:1] TXPI_PPMCLK_SEL_REG = TXPI_PPMCLK_SEL;
  localparam [7:0] TXPI_PPM_CFG_REG = TXPI_PPM_CFG;
  localparam [15:0] TXPI_RSV0_REG = TXPI_RSV0;
  localparam [2:0] TXPI_SYNFREQ_PPM_REG = TXPI_SYNFREQ_PPM;
  localparam [0:0] TXPI_VREFSEL_REG = TXPI_VREFSEL;
  localparam [4:0] TXPMARESET_TIME_REG = TXPMARESET_TIME;
  localparam [0:0] TXSYNC_MULTILANE_REG = TXSYNC_MULTILANE;
  localparam [0:0] TXSYNC_OVRD_REG = TXSYNC_OVRD;
  localparam [0:0] TXSYNC_SKIP_DA_REG = TXSYNC_SKIP_DA;
  localparam [5:0] TX_CLK25_DIV_REG = TX_CLK25_DIV;
  localparam [0:0] TX_CLKMUX_EN_REG = TX_CLKMUX_EN;
  localparam [0:0] TX_CLKREG_PDB_REG = TX_CLKREG_PDB;
  localparam [2:0] TX_CLKREG_SET_REG = TX_CLKREG_SET;
  localparam [7:0] TX_DATA_WIDTH_REG = TX_DATA_WIDTH;
  localparam [5:0] TX_DCD_CFG_REG = TX_DCD_CFG;
  localparam [0:0] TX_DCD_EN_REG = TX_DCD_EN;
  localparam [5:0] TX_DEEMPH0_REG = TX_DEEMPH0;
  localparam [5:0] TX_DEEMPH1_REG = TX_DEEMPH1;
  localparam [4:0] TX_DIVRESET_TIME_REG = TX_DIVRESET_TIME;
  localparam [64:1] TX_DRIVE_MODE_REG = TX_DRIVE_MODE;
  localparam [1:0] TX_DRVMUX_CTRL_REG = TX_DRVMUX_CTRL;
  localparam [2:0] TX_EIDLE_ASSERT_DELAY_REG = TX_EIDLE_ASSERT_DELAY;
  localparam [2:0] TX_EIDLE_DEASSERT_DELAY_REG = TX_EIDLE_DEASSERT_DELAY;
  localparam [0:0] TX_EML_PHI_TUNE_REG = TX_EML_PHI_TUNE;
  localparam [0:0] TX_FABINT_USRCLK_FLOP_REG = TX_FABINT_USRCLK_FLOP;
  localparam [0:0] TX_FIFO_BYP_EN_REG = TX_FIFO_BYP_EN;
  localparam [0:0] TX_IDLE_DATA_ZERO_REG = TX_IDLE_DATA_ZERO;
  localparam [1:0] TX_INT_DATAWIDTH_REG = TX_INT_DATAWIDTH;
  localparam [40:1] TX_LOOPBACK_DRIVE_HIZ_REG = TX_LOOPBACK_DRIVE_HIZ;
  localparam [0:0] TX_MAINCURSOR_SEL_REG = TX_MAINCURSOR_SEL;
  localparam [6:0] TX_MARGIN_FULL_0_REG = TX_MARGIN_FULL_0;
  localparam [6:0] TX_MARGIN_FULL_1_REG = TX_MARGIN_FULL_1;
  localparam [6:0] TX_MARGIN_FULL_2_REG = TX_MARGIN_FULL_2;
  localparam [6:0] TX_MARGIN_FULL_3_REG = TX_MARGIN_FULL_3;
  localparam [6:0] TX_MARGIN_FULL_4_REG = TX_MARGIN_FULL_4;
  localparam [6:0] TX_MARGIN_LOW_0_REG = TX_MARGIN_LOW_0;
  localparam [6:0] TX_MARGIN_LOW_1_REG = TX_MARGIN_LOW_1;
  localparam [6:0] TX_MARGIN_LOW_2_REG = TX_MARGIN_LOW_2;
  localparam [6:0] TX_MARGIN_LOW_3_REG = TX_MARGIN_LOW_3;
  localparam [6:0] TX_MARGIN_LOW_4_REG = TX_MARGIN_LOW_4;
  localparam [2:0] TX_MODE_SEL_REG = TX_MODE_SEL;
  localparam [15:0] TX_PHICAL_CFG0_REG = TX_PHICAL_CFG0;
  localparam [15:0] TX_PHICAL_CFG1_REG = TX_PHICAL_CFG1;
  localparam [15:0] TX_PHICAL_CFG2_REG = TX_PHICAL_CFG2;
  localparam [1:0] TX_PI_BIASSET_REG = TX_PI_BIASSET;
  localparam [15:0] TX_PI_CFG0_REG = TX_PI_CFG0;
  localparam [15:0] TX_PI_CFG1_REG = TX_PI_CFG1;
  localparam [0:0] TX_PI_DIV2_MODE_B_REG = TX_PI_DIV2_MODE_B;
  localparam [0:0] TX_PI_SEL_QPLL0_REG = TX_PI_SEL_QPLL0;
  localparam [0:0] TX_PI_SEL_QPLL1_REG = TX_PI_SEL_QPLL1;
  localparam [0:0] TX_PMADATA_OPT_REG = TX_PMADATA_OPT;
  localparam [0:0] TX_PMA_POWER_SAVE_REG = TX_PMA_POWER_SAVE;
  localparam [1:0] TX_PREDRV_CTRL_REG = TX_PREDRV_CTRL;
  localparam [48:1] TX_PROGCLK_SEL_REG = TX_PROGCLK_SEL;
  localparam [63:0] TX_PROGDIV_CFG_REG = TX_PROGDIV_CFG * 1000;
  localparam [15:0] TX_PROGDIV_RATE_REG = TX_PROGDIV_RATE;
  localparam [13:0] TX_RXDETECT_CFG_REG = TX_RXDETECT_CFG;
  localparam [2:0] TX_RXDETECT_REF_REG = TX_RXDETECT_REF;
  localparam [2:0] TX_SAMPLE_PERIOD_REG = TX_SAMPLE_PERIOD;
  localparam [0:0] TX_SARC_LPBK_ENB_REG = TX_SARC_LPBK_ENB;
  localparam [40:1] TX_XCLK_SEL_REG = TX_XCLK_SEL;
  localparam [0:0] USE_PCS_CLK_PHASE_SEL_REG = USE_PCS_CLK_PHASE_SEL;
  `endif

  localparam [0:0] AEN_CDRSTEPSEL_REG = 1'b0;
  localparam [0:0] AEN_CPLL_REG = 1'b0;
  localparam [0:0] AEN_ELPCAL_REG = 1'b0;
  localparam [0:0] AEN_EYESCAN_REG = 1'b1;
  localparam [0:0] AEN_LOOPBACK_REG = 1'b0;
  localparam [0:0] AEN_MASTER_REG = 1'b0;
  localparam [0:0] AEN_MUXDCD_REG = 1'b0;
  localparam [0:0] AEN_PD_AND_EIDLE_REG = 1'b0;
  localparam [0:0] AEN_POLARITY_REG = 1'b0;
  localparam [0:0] AEN_PRBS_REG = 1'b0;
  localparam [0:0] AEN_RESET_REG = 1'b0;
  localparam [0:0] AEN_RXCDR_REG = 1'b0;
  localparam [0:0] AEN_RXDFE_REG = 1'b0;
  localparam [0:0] AEN_RXDFELPM_REG = 1'b0;
  localparam [0:0] AEN_RXOUTCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_RXPHDLY_REG = 1'b0;
  localparam [0:0] AEN_RXPLLCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_RXSYSCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_TXOUTCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_TXPHDLY_REG = 1'b0;
  localparam [0:0] AEN_TXPI_PPM_REG = 1'b0;
  localparam [0:0] AEN_TXPLLCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_TXSYSCLK_SEL_REG = 1'b0;
  localparam [0:0] AEN_TX_DRIVE_MODE_REG = 1'b0;
  localparam [15:0] AMONITOR_CFG_REG = 16'h0000;
  localparam [0:0] A_AFECFOKEN_REG = 1'b0;
  localparam [0:0] A_CPLLLOCKEN_REG = 1'b0;
  localparam [0:0] A_CPLLPD_REG = 1'b0;
  localparam [0:0] A_CPLLRESET_REG = 1'b0;
  localparam [5:0] A_DFECFOKFCDAC_REG = 6'b000000;
  localparam [3:0] A_DFECFOKFCNUM_REG = 4'b0000;
  localparam [0:0] A_DFECFOKFPULSE_REG = 1'b0;
  localparam [0:0] A_DFECFOKHOLD_REG = 1'b0;
  localparam [0:0] A_DFECFOKOVREN_REG = 1'b0;
  localparam [0:0] A_ELPCALDVORWREN_REG = 1'b0;
  localparam [0:0] A_ELPCALPAORWREN_REG = 1'b0;
  localparam [0:0] A_EYESCANMODE_REG = 1'b0;
  localparam [0:0] A_EYESCANRESET_REG = 1'b0;
  localparam [0:0] A_GTRESETSEL_REG = 1'b0;
  localparam [0:0] A_GTRXRESET_REG = 1'b0;
  localparam [0:0] A_GTTXRESET_REG = 1'b0;
  localparam [80:1] A_LOOPBACK_REG = "NoLoopBack";
  localparam [0:0] A_LPMGCHOLD_REG = 1'b0;
  localparam [0:0] A_LPMGCOVREN_REG = 1'b0;
  localparam [0:0] A_LPMOSHOLD_REG = 1'b0;
  localparam [0:0] A_LPMOSOVREN_REG = 1'b0;
  localparam [0:0] A_MUXDCDEXHOLD_REG = 1'b0;
  localparam [0:0] A_MUXDCDORWREN_REG = 1'b0;
  localparam [0:0] A_RXBUFRESET_REG = 1'b0;
  localparam [0:0] A_RXCDRFREQRESET_REG = 1'b0;
  localparam [0:0] A_RXCDRHOLD_REG = 1'b0;
  localparam [0:0] A_RXCDROVRDEN_REG = 1'b0;
  localparam [0:0] A_RXCDRRESET_REG = 1'b0;
  localparam [0:0] A_RXDFEAGCHOLD_REG = 1'b0;
  localparam [0:0] A_RXDFEAGCOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFECFOKFEN_REG = 1'b0;
  localparam [0:0] A_RXDFELFHOLD_REG = 1'b0;
  localparam [0:0] A_RXDFELFOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFELPMRESET_REG = 1'b0;
  localparam [0:0] A_RXDFETAP10HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP10OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP11HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP11OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP12HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP12OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP13HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP13OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP14HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP14OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP15HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP15OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP2HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP2OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP3HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP3OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP4HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP4OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP5HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP5OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP6HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP6OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP7HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP7OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP8HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP8OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFETAP9HOLD_REG = 1'b0;
  localparam [0:0] A_RXDFETAP9OVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFEUTHOLD_REG = 1'b0;
  localparam [0:0] A_RXDFEUTOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFEVPHOLD_REG = 1'b0;
  localparam [0:0] A_RXDFEVPOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDFEVSEN_REG = 1'b0;
  localparam [0:0] A_RXDFEXYDEN_REG = 1'b0;
  localparam [0:0] A_RXDLYBYPASS_REG = 1'b0;
  localparam [0:0] A_RXDLYEN_REG = 1'b0;
  localparam [0:0] A_RXDLYOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXDLYSRESET_REG = 1'b0;
  localparam [0:0] A_RXLPMEN_REG = 1'b0;
  localparam [0:0] A_RXLPMHFHOLD_REG = 1'b0;
  localparam [0:0] A_RXLPMHFOVRDEN_REG = 1'b0;
  localparam [0:0] A_RXLPMLFHOLD_REG = 1'b0;
  localparam [0:0] A_RXLPMLFKLOVRDEN_REG = 1'b0;
  localparam [1:0] A_RXMONITORSEL_REG = 2'b00;
  localparam [0:0] A_RXOOBRESET_REG = 1'b0;
  localparam [0:0] A_RXOSHOLD_REG = 1'b0;
  localparam [0:0] A_RXOSOVRDEN_REG = 1'b0;
  localparam [128:1] A_RXOUTCLKSEL_REG = "Disabled";
  localparam [0:0] A_RXPCSRESET_REG = 1'b0;
  localparam [24:1] A_RXPD_REG = "P0";
  localparam [0:0] A_RXPHALIGN_REG = 1'b0;
  localparam [0:0] A_RXPHALIGNEN_REG = 1'b0;
  localparam [0:0] A_RXPHDLYPD_REG = 1'b0;
  localparam [0:0] A_RXPHDLYRESET_REG = 1'b0;
  localparam [0:0] A_RXPHOVRDEN_REG = 1'b0;
  localparam [64:1] A_RXPLLCLKSEL_REG = "CPLLCLK";
  localparam [0:0] A_RXPMARESET_REG = 1'b0;
  localparam [0:0] A_RXPOLARITY_REG = 1'b0;
  localparam [0:0] A_RXPRBSCNTRESET_REG = 1'b0;
  localparam [48:1] A_RXPRBSSEL_REG = "PRBS7";
  localparam [88:1] A_RXSYSCLKSEL_REG = "CPLLREFCLK";
  localparam [2:0] A_TXBUFDIFFCTRL_REG = 3'b100;
  localparam [0:0] A_TXDEEMPH_REG = 1'b0;
  localparam [0:0] A_TXDLYBYPASS_REG = 1'b0;
  localparam [0:0] A_TXDLYEN_REG = 1'b0;
  localparam [0:0] A_TXDLYOVRDEN_REG = 1'b0;
  localparam [0:0] A_TXDLYSRESET_REG = 1'b0;
  localparam [0:0] A_TXELECIDLE_REG = 1'b0;
  localparam [0:0] A_TXINHIBIT_REG = 1'b0;
  localparam [6:0] A_TXMAINCURSOR_REG = 7'b0000000;
  localparam [2:0] A_TXMARGIN_REG = 3'b000;
  localparam [128:1] A_TXOUTCLKSEL_REG = "Disabled";
  localparam [0:0] A_TXPCSRESET_REG = 1'b0;
  localparam [24:1] A_TXPD_REG = "P0";
  localparam [0:0] A_TXPHALIGN_REG = 1'b0;
  localparam [0:0] A_TXPHALIGNEN_REG = 1'b0;
  localparam [0:0] A_TXPHDLYPD_REG = 1'b0;
  localparam [0:0] A_TXPHDLYRESET_REG = 1'b0;
  localparam [0:0] A_TXPHINIT_REG = 1'b0;
  localparam [0:0] A_TXPHOVRDEN_REG = 1'b0;
  localparam [0:0] A_TXPIPPMOVRDEN_REG = 1'b0;
  localparam [0:0] A_TXPIPPMPD_REG = 1'b0;
  localparam [0:0] A_TXPIPPMSEL_REG = 1'b0;
  localparam [64:1] A_TXPLLCLKSEL_REG = "CPLLCLK";
  localparam [0:0] A_TXPMARESET_REG = 1'b0;
  localparam [0:0] A_TXPOLARITY_REG = 1'b0;
  localparam [4:0] A_TXPOSTCURSOR_REG = 5'b00000;
  localparam [0:0] A_TXPRBSFORCEERR_REG = 1'b0;
  localparam [96:1] A_TXPRBSSEL_REG = "PRBS7";
  localparam [4:0] A_TXPRECURSOR_REG = 5'b00000;
  localparam [0:0] A_TXSWING_REG = 1'b0;
  localparam [88:1] A_TXSYSCLKSEL_REG = "CPLLREFCLK";
  localparam [0:0] CPLL_IPS_EN_REG = 1'b1;
  localparam [2:0] CPLL_IPS_REFCLK_SEL_REG = 3'b000;
  localparam [40:1] GEN_RXUSRCLK_REG = "TRUE";
  localparam [40:1] GEN_TXUSRCLK_REG = "TRUE";
  localparam [0:0] GT_INSTANTIATED_REG = 1'b1;
  localparam [40:1] RXPLL_SEL_REG = "CPLL";
  localparam [0:0] TXOUTCLKPCS_SEL_REG = 1'b0;
  localparam [9:0] TX_USERPATTERN_DATA0_REG = 10'b0101111100;
  localparam [9:0] TX_USERPATTERN_DATA1_REG = 10'b0101010101;
  localparam [9:0] TX_USERPATTERN_DATA2_REG = 10'b1010000011;
  localparam [9:0] TX_USERPATTERN_DATA3_REG = 10'b1010101010;
  localparam [9:0] TX_USERPATTERN_DATA4_REG = 10'b0101111100;
  localparam [9:0] TX_USERPATTERN_DATA5_REG = 10'b0101010101;
  localparam [9:0] TX_USERPATTERN_DATA6_REG = 10'b1010000011;
  localparam [9:0] TX_USERPATTERN_DATA7_REG = 10'b1010101010;

  tri0 glblGSR = glbl.GSR;

  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "GTYE3_CHANNEL_dr.v"
  `endif

  wire CPLLFBCLKLOST_out;
  wire CPLLLOCK_out;
  wire CPLLREFCLKLOST_out;
  wire DRPRDY_out;
  wire EYESCANDATAERROR_out;
  wire GTPOWERGOOD_out;
  wire GTREFCLKMONITOR_out;
  wire GTYTXN_out;
  wire GTYTXP_out;
  wire PCIERATEGEN3_out;
  wire PCIERATEIDLE_out;
  wire PCIESYNCTXSYNCDONE_out;
  wire PCIEUSERGEN3RDY_out;
  wire PCIEUSERPHYSTATUSRST_out;
  wire PCIEUSERRATESTART_out;
  wire PHYSTATUS_out;
  wire RESETEXCEPTION_out;
  wire RXBYTEISALIGNED_out;
  wire RXBYTEREALIGN_out;
  wire RXCDRLOCK_out;
  wire RXCDRPHDONE_out;
  wire RXCHANBONDSEQ_out;
  wire RXCHANISALIGNED_out;
  wire RXCHANREALIGN_out;
  wire RXCKOKDONE_out;
  wire RXCOMINITDET_out;
  wire RXCOMMADET_out;
  wire RXCOMSASDET_out;
  wire RXCOMWAKEDET_out;
  wire RXDLYSRESETDONE_out;
  wire RXELECIDLE_out;
  wire RXOSINTDONE_out;
  wire RXOSINTSTARTED_out;
  wire RXOSINTSTROBEDONE_out;
  wire RXOSINTSTROBESTARTED_out;
  wire RXOUTCLKFABRIC_out;
  wire RXOUTCLKPCS_out;
  wire RXOUTCLK_out;
  wire RXPHALIGNDONE_out;
  wire RXPHALIGNERR_out;
  wire RXPMARESETDONE_out;
  wire RXPRBSERR_out;
  wire RXPRBSLOCKED_out;
  wire RXPRGDIVRESETDONE_out;
  wire RXRATEDONE_out;
  wire RXRECCLKOUT_out;
  wire RXRESETDONE_out;
  wire RXSLIDERDY_out;
  wire RXSLIPDONE_out;
  wire RXSLIPOUTCLKRDY_out;
  wire RXSLIPPMARDY_out;
  wire RXSYNCDONE_out;
  wire RXSYNCOUT_out;
  wire RXVALID_out;
  wire TXCOMFINISH_out;
  wire TXDCCDONE_out;
  wire TXDLYSRESETDONE_out;
  wire TXOUTCLKFABRIC_out;
  wire TXOUTCLKPCS_out;
  wire TXOUTCLK_out;
  wire TXPHALIGNDONE_out;
  wire TXPHINITDONE_out;
  wire TXPMARESETDONE_out;
  wire TXPRGDIVRESETDONE_out;
  wire TXRATEDONE_out;
  wire TXRESETDONE_out;
  wire TXSYNCDONE_out;
  wire TXSYNCOUT_out;
  wire [11:0] PMASCANOUT_out;
  wire [127:0] RXDATA_out;
  wire [15:0] DRPDO_out;
  wire [15:0] PCSRSVDOUT_out;
  wire [15:0] RXCTRL0_out;
  wire [15:0] RXCTRL1_out;
  wire [16:0] DMONITOROUT_out;
  wire [18:0] SCANOUT_out;
  wire [1:0] PCIERATEQPLLPD_out;
  wire [1:0] PCIERATEQPLLRESET_out;
  wire [1:0] RXCLKCORCNT_out;
  wire [1:0] RXDATAVALID_out;
  wire [1:0] RXHEADERVALID_out;
  wire [1:0] RXSTARTOFSEQ_out;
  wire [1:0] TXBUFSTATUS_out;
  wire [2:0] BUFGTCEMASK_out;
  wire [2:0] BUFGTCE_out;
  wire [2:0] BUFGTRESET_out;
  wire [2:0] BUFGTRSTMASK_out;
  wire [2:0] RXBUFSTATUS_out;
  wire [2:0] RXSTATUS_out;
  wire [4:0] RXCHBONDO_out;
  wire [5:0] RXHEADER_out;
  wire [6:0] RXMONITOROUT_out;
  wire [7:0] PINRSRVDAS_out;
  wire [7:0] RXCTRL2_out;
  wire [7:0] RXCTRL3_out;
  wire [7:0] RXDATAEXTENDRSVD_out;
  wire [8:0] BUFGTDIV_out;

  wire CPLLFBCLKLOST_delay;
  wire CPLLLOCK_delay;
  wire CPLLREFCLKLOST_delay;
  wire DRPRDY_delay;
  wire EYESCANDATAERROR_delay;
  wire GTPOWERGOOD_delay;
  wire GTREFCLKMONITOR_delay;
  wire GTYTXN_delay;
  wire GTYTXP_delay;
  wire PCIERATEGEN3_delay;
  wire PCIERATEIDLE_delay;
  wire PCIESYNCTXSYNCDONE_delay;
  wire PCIEUSERGEN3RDY_delay;
  wire PCIEUSERPHYSTATUSRST_delay;
  wire PCIEUSERRATESTART_delay;
  wire PHYSTATUS_delay;
  wire RESETEXCEPTION_delay;
  wire RXBYTEISALIGNED_delay;
  wire RXBYTEREALIGN_delay;
  wire RXCDRLOCK_delay;
  wire RXCDRPHDONE_delay;
  wire RXCHANBONDSEQ_delay;
  wire RXCHANISALIGNED_delay;
  wire RXCHANREALIGN_delay;
  wire RXCKOKDONE_delay;
  wire RXCOMINITDET_delay;
  wire RXCOMMADET_delay;
  wire RXCOMSASDET_delay;
  wire RXCOMWAKEDET_delay;
  wire RXDLYSRESETDONE_delay;
  wire RXELECIDLE_delay;
  wire RXOSINTDONE_delay;
  wire RXOSINTSTARTED_delay;
  wire RXOSINTSTROBEDONE_delay;
  wire RXOSINTSTROBESTARTED_delay;
  wire RXOUTCLKFABRIC_delay;
  wire RXOUTCLKPCS_delay;
  wire RXOUTCLK_delay;
  wire RXPHALIGNDONE_delay;
  wire RXPHALIGNERR_delay;
  wire RXPMARESETDONE_delay;
  wire RXPRBSERR_delay;
  wire RXPRBSLOCKED_delay;
  wire RXPRGDIVRESETDONE_delay;
  wire RXRATEDONE_delay;
  wire RXRECCLKOUT_delay;
  wire RXRESETDONE_delay;
  wire RXSLIDERDY_delay;
  wire RXSLIPDONE_delay;
  wire RXSLIPOUTCLKRDY_delay;
  wire RXSLIPPMARDY_delay;
  wire RXSYNCDONE_delay;
  wire RXSYNCOUT_delay;
  wire RXVALID_delay;
  wire TXCOMFINISH_delay;
  wire TXDCCDONE_delay;
  wire TXDLYSRESETDONE_delay;
  wire TXOUTCLKFABRIC_delay;
  wire TXOUTCLKPCS_delay;
  wire TXOUTCLK_delay;
  wire TXPHALIGNDONE_delay;
  wire TXPHINITDONE_delay;
  wire TXPMARESETDONE_delay;
  wire TXPRGDIVRESETDONE_delay;
  wire TXRATEDONE_delay;
  wire TXRESETDONE_delay;
  wire TXSYNCDONE_delay;
  wire TXSYNCOUT_delay;
  wire [127:0] RXDATA_delay;
  wire [15:0] DRPDO_delay;
  wire [15:0] PCSRSVDOUT_delay;
  wire [15:0] RXCTRL0_delay;
  wire [15:0] RXCTRL1_delay;
  wire [16:0] DMONITOROUT_delay;
  wire [1:0] PCIERATEQPLLPD_delay;
  wire [1:0] PCIERATEQPLLRESET_delay;
  wire [1:0] RXCLKCORCNT_delay;
  wire [1:0] RXDATAVALID_delay;
  wire [1:0] RXHEADERVALID_delay;
  wire [1:0] RXSTARTOFSEQ_delay;
  wire [1:0] TXBUFSTATUS_delay;
  wire [2:0] BUFGTCEMASK_delay;
  wire [2:0] BUFGTCE_delay;
  wire [2:0] BUFGTRESET_delay;
  wire [2:0] BUFGTRSTMASK_delay;
  wire [2:0] RXBUFSTATUS_delay;
  wire [2:0] RXSTATUS_delay;
  wire [4:0] RXCHBONDO_delay;
  wire [5:0] RXHEADER_delay;
  wire [6:0] RXMONITOROUT_delay;
  wire [7:0] PINRSRVDAS_delay;
  wire [7:0] RXCTRL2_delay;
  wire [7:0] RXCTRL3_delay;
  wire [7:0] RXDATAEXTENDRSVD_delay;
  wire [8:0] BUFGTDIV_delay;

  wire CDRSTEPDIR_in;
  wire CDRSTEPSQ_in;
  wire CDRSTEPSX_in;
  wire CFGRESET_in;
  wire CLKRSVD0_in;
  wire CLKRSVD1_in;
  wire CPLLLOCKDETCLK_in;
  wire CPLLLOCKEN_in;
  wire CPLLPD_in;
  wire CPLLRESET_in;
  wire DMONFIFORESET_in;
  wire DMONITORCLK_in;
  wire DRPCLK_in;
  wire DRPEN_in;
  wire DRPWE_in;
  wire ELPCALDVORWREN_in;
  wire ELPCALPAORWREN_in;
  wire EVODDPHICALDONE_in;
  wire EVODDPHICALSTART_in;
  wire EVODDPHIDRDEN_in;
  wire EVODDPHIDWREN_in;
  wire EVODDPHIXRDEN_in;
  wire EVODDPHIXWREN_in;
  wire EYESCANMODE_in;
  wire EYESCANRESET_in;
  wire EYESCANTRIGGER_in;
  wire GTGREFCLK_in;
  wire GTNORTHREFCLK0_in;
  wire GTNORTHREFCLK1_in;
  wire GTREFCLK0_in;
  wire GTREFCLK1_in;
  wire GTRESETSEL_in;
  wire GTRXRESET_in;
  wire GTSOUTHREFCLK0_in;
  wire GTSOUTHREFCLK1_in;
  wire GTTXRESET_in;
  wire GTYRXN_in;
  wire GTYRXP_in;
  wire LPBKRXTXSEREN_in;
  wire LPBKTXRXSEREN_in;
  wire PCIEEQRXEQADAPTDONE_in;
  wire PCIERSTIDLE_in;
  wire PCIERSTTXSYNCSTART_in;
  wire PCIEUSERRATEDONE_in;
  wire PMASCANCLK0_in;
  wire PMASCANCLK1_in;
  wire PMASCANCLK2_in;
  wire PMASCANCLK3_in;
  wire PMASCANCLK4_in;
  wire PMASCANCLK5_in;
  wire PMASCANENB_in;
  wire PMASCANMODEB_in;
  wire PMASCANRSTEN_in;
  wire QPLL0CLK_in;
  wire QPLL0REFCLK_in;
  wire QPLL1CLK_in;
  wire QPLL1REFCLK_in;
  wire RESETOVRD_in;
  wire RSTCLKENTX_in;
  wire RX8B10BEN_in;
  wire RXBUFRESET_in;
  wire RXCDRFREQRESET_in;
  wire RXCDRHOLD_in;
  wire RXCDROVRDEN_in;
  wire RXCDRRESETRSV_in;
  wire RXCDRRESET_in;
  wire RXCHBONDEN_in;
  wire RXCHBONDMASTER_in;
  wire RXCHBONDSLAVE_in;
  wire RXCKOKRESET_in;
  wire RXCOMMADETEN_in;
  wire RXDCCFORCESTART_in;
  wire RXDFEAGCHOLD_in;
  wire RXDFEAGCOVRDEN_in;
  wire RXDFELFHOLD_in;
  wire RXDFELFOVRDEN_in;
  wire RXDFELPMRESET_in;
  wire RXDFETAP10HOLD_in;
  wire RXDFETAP10OVRDEN_in;
  wire RXDFETAP11HOLD_in;
  wire RXDFETAP11OVRDEN_in;
  wire RXDFETAP12HOLD_in;
  wire RXDFETAP12OVRDEN_in;
  wire RXDFETAP13HOLD_in;
  wire RXDFETAP13OVRDEN_in;
  wire RXDFETAP14HOLD_in;
  wire RXDFETAP14OVRDEN_in;
  wire RXDFETAP15HOLD_in;
  wire RXDFETAP15OVRDEN_in;
  wire RXDFETAP2HOLD_in;
  wire RXDFETAP2OVRDEN_in;
  wire RXDFETAP3HOLD_in;
  wire RXDFETAP3OVRDEN_in;
  wire RXDFETAP4HOLD_in;
  wire RXDFETAP4OVRDEN_in;
  wire RXDFETAP5HOLD_in;
  wire RXDFETAP5OVRDEN_in;
  wire RXDFETAP6HOLD_in;
  wire RXDFETAP6OVRDEN_in;
  wire RXDFETAP7HOLD_in;
  wire RXDFETAP7OVRDEN_in;
  wire RXDFETAP8HOLD_in;
  wire RXDFETAP8OVRDEN_in;
  wire RXDFETAP9HOLD_in;
  wire RXDFETAP9OVRDEN_in;
  wire RXDFEUTHOLD_in;
  wire RXDFEUTOVRDEN_in;
  wire RXDFEVPHOLD_in;
  wire RXDFEVPOVRDEN_in;
  wire RXDFEVSEN_in;
  wire RXDFEXYDEN_in;
  wire RXDLYBYPASS_in;
  wire RXDLYEN_in;
  wire RXDLYOVRDEN_in;
  wire RXDLYSRESET_in;
  wire RXGEARBOXSLIP_in;
  wire RXLATCLK_in;
  wire RXLPMEN_in;
  wire RXLPMGCHOLD_in;
  wire RXLPMGCOVRDEN_in;
  wire RXLPMHFHOLD_in;
  wire RXLPMHFOVRDEN_in;
  wire RXLPMLFHOLD_in;
  wire RXLPMLFKLOVRDEN_in;
  wire RXLPMOSHOLD_in;
  wire RXLPMOSOVRDEN_in;
  wire RXMCOMMAALIGNEN_in;
  wire RXOOBRESET_in;
  wire RXOSCALRESET_in;
  wire RXOSHOLD_in;
  wire RXOSINTEN_in;
  wire RXOSINTHOLD_in;
  wire RXOSINTOVRDEN_in;
  wire RXOSINTSTROBE_in;
  wire RXOSINTTESTOVRDEN_in;
  wire RXOSOVRDEN_in;
  wire RXPCOMMAALIGNEN_in;
  wire RXPCSRESET_in;
  wire RXPHALIGNEN_in;
  wire RXPHALIGN_in;
  wire RXPHDLYPD_in;
  wire RXPHDLYRESET_in;
  wire RXPHOVRDEN_in;
  wire RXPMARESET_in;
  wire RXPOLARITY_in;
  wire RXPRBSCNTRESET_in;
  wire RXPROGDIVRESET_in;
  wire RXRATEMODE_in;
  wire RXSLIDE_in;
  wire RXSLIPOUTCLK_in;
  wire RXSLIPPMA_in;
  wire RXSYNCALLIN_in;
  wire RXSYNCIN_in;
  wire RXSYNCMODE_in;
  wire RXUSERRDY_in;
  wire RXUSRCLK2_in;
  wire RXUSRCLK_in;
  wire SARCCLK_in;
  wire SCANCLK_in;
  wire SCANENB_in;
  wire SCANMODEB_in;
  wire SIGVALIDCLK_in;
  wire TSTCLK0_in;
  wire TSTCLK1_in;
  wire TSTPDOVRDB_in;
  wire TX8B10BEN_in;
  wire TXCOMINIT_in;
  wire TXCOMSAS_in;
  wire TXCOMWAKE_in;
  wire TXDCCFORCESTART_in;
  wire TXDCCRESET_in;
  wire TXDEEMPH_in;
  wire TXDETECTRX_in;
  wire TXDIFFPD_in;
  wire TXDLYBYPASS_in;
  wire TXDLYEN_in;
  wire TXDLYHOLD_in;
  wire TXDLYOVRDEN_in;
  wire TXDLYSRESET_in;
  wire TXDLYUPDOWN_in;
  wire TXELECIDLE_in;
  wire TXELFORCESTART_in;
  wire TXINHIBIT_in;
  wire TXLATCLK_in;
  wire TXPCSRESET_in;
  wire TXPDELECIDLEMODE_in;
  wire TXPHALIGNEN_in;
  wire TXPHALIGN_in;
  wire TXPHDLYPD_in;
  wire TXPHDLYRESET_in;
  wire TXPHDLYTSTCLK_in;
  wire TXPHINIT_in;
  wire TXPHOVRDEN_in;
  wire TXPIPPMEN_in;
  wire TXPIPPMOVRDEN_in;
  wire TXPIPPMPD_in;
  wire TXPIPPMSEL_in;
  wire TXPISOPD_in;
  wire TXPMARESET_in;
  wire TXPOLARITY_in;
  wire TXPRBSFORCEERR_in;
  wire TXPROGDIVRESET_in;
  wire TXRATEMODE_in;
  wire TXSWING_in;
  wire TXSYNCALLIN_in;
  wire TXSYNCIN_in;
  wire TXSYNCMODE_in;
  wire TXUSERRDY_in;
  wire TXUSRCLK2_in;
  wire TXUSRCLK_in;
  wire [11:0] PMASCANIN_in;
  wire [127:0] TXDATA_in;
  wire [15:0] DRPDI_in;
  wire [15:0] GTRSVD_in;
  wire [15:0] LOOPRSVD_in;
  wire [15:0] PCSRSVDIN_in;
  wire [15:0] TXCTRL0_in;
  wire [15:0] TXCTRL1_in;
  wire [18:0] SCANIN_in;
  wire [19:0] TSTIN_in;
  wire [1:0] RXELECIDLEMODE_in;
  wire [1:0] RXMONITORSEL_in;
  wire [1:0] RXPD_in;
  wire [1:0] RXPLLCLKSEL_in;
  wire [1:0] RXSYSCLKSEL_in;
  wire [1:0] TXPD_in;
  wire [1:0] TXPLLCLKSEL_in;
  wire [1:0] TXSYSCLKSEL_in;
  wire [2:0] CPLLREFCLKSEL_in;
  wire [2:0] LOOPBACK_in;
  wire [2:0] RXCHBONDLEVEL_in;
  wire [2:0] RXOUTCLKSEL_in;
  wire [2:0] RXRATE_in;
  wire [2:0] TXBUFDIFFCTRL_in;
  wire [2:0] TXMARGIN_in;
  wire [2:0] TXOUTCLKSEL_in;
  wire [2:0] TXRATE_in;
  wire [3:0] RXOSINTCFG_in;
  wire [3:0] RXPRBSSEL_in;
  wire [3:0] TXPRBSSEL_in;
  wire [4:0] PCSRSVDIN2_in;
  wire [4:0] PMARSVDIN_in;
  wire [4:0] RXCHBONDI_in;
  wire [4:0] TSTPD_in;
  wire [4:0] TXDIFFCTRL_in;
  wire [4:0] TXPIPPMSTEPSIZE_in;
  wire [4:0] TXPOSTCURSOR_in;
  wire [4:0] TXPRECURSOR_in;
  wire [5:0] TXHEADER_in;
  wire [6:0] TXMAINCURSOR_in;
  wire [6:0] TXSEQUENCE_in;
  wire [7:0] TX8B10BBYPASS_in;
  wire [7:0] TXCTRL2_in;
  wire [7:0] TXDATAEXTENDRSVD_in;
  wire [9:0] DRPADDR_in;

  wire CDRSTEPDIR_delay;
  wire CDRSTEPSQ_delay;
  wire CDRSTEPSX_delay;
  wire CFGRESET_delay;
  wire CLKRSVD0_delay;
  wire CLKRSVD1_delay;
  wire CPLLLOCKDETCLK_delay;
  wire CPLLLOCKEN_delay;
  wire CPLLPD_delay;
  wire CPLLRESET_delay;
  wire DMONFIFORESET_delay;
  wire DMONITORCLK_delay;
  wire DRPCLK_delay;
  wire DRPEN_delay;
  wire DRPWE_delay;
  wire ELPCALDVORWREN_delay;
  wire ELPCALPAORWREN_delay;
  wire EVODDPHICALDONE_delay;
  wire EVODDPHICALSTART_delay;
  wire EVODDPHIDRDEN_delay;
  wire EVODDPHIDWREN_delay;
  wire EVODDPHIXRDEN_delay;
  wire EVODDPHIXWREN_delay;
  wire EYESCANMODE_delay;
  wire EYESCANRESET_delay;
  wire EYESCANTRIGGER_delay;
  wire GTGREFCLK_delay;
  wire GTNORTHREFCLK0_delay;
  wire GTNORTHREFCLK1_delay;
  wire GTREFCLK0_delay;
  wire GTREFCLK1_delay;
  wire GTRESETSEL_delay;
  wire GTRXRESET_delay;
  wire GTSOUTHREFCLK0_delay;
  wire GTSOUTHREFCLK1_delay;
  wire GTTXRESET_delay;
  wire GTYRXN_delay;
  wire GTYRXP_delay;
  wire LPBKRXTXSEREN_delay;
  wire LPBKTXRXSEREN_delay;
  wire PCIEEQRXEQADAPTDONE_delay;
  wire PCIERSTIDLE_delay;
  wire PCIERSTTXSYNCSTART_delay;
  wire PCIEUSERRATEDONE_delay;
  wire QPLL0CLK_delay;
  wire QPLL0REFCLK_delay;
  wire QPLL1CLK_delay;
  wire QPLL1REFCLK_delay;
  wire RESETOVRD_delay;
  wire RSTCLKENTX_delay;
  wire RX8B10BEN_delay;
  wire RXBUFRESET_delay;
  wire RXCDRFREQRESET_delay;
  wire RXCDRHOLD_delay;
  wire RXCDROVRDEN_delay;
  wire RXCDRRESETRSV_delay;
  wire RXCDRRESET_delay;
  wire RXCHBONDEN_delay;
  wire RXCHBONDMASTER_delay;
  wire RXCHBONDSLAVE_delay;
  wire RXCKOKRESET_delay;
  wire RXCOMMADETEN_delay;
  wire RXDCCFORCESTART_delay;
  wire RXDFEAGCHOLD_delay;
  wire RXDFEAGCOVRDEN_delay;
  wire RXDFELFHOLD_delay;
  wire RXDFELFOVRDEN_delay;
  wire RXDFELPMRESET_delay;
  wire RXDFETAP10HOLD_delay;
  wire RXDFETAP10OVRDEN_delay;
  wire RXDFETAP11HOLD_delay;
  wire RXDFETAP11OVRDEN_delay;
  wire RXDFETAP12HOLD_delay;
  wire RXDFETAP12OVRDEN_delay;
  wire RXDFETAP13HOLD_delay;
  wire RXDFETAP13OVRDEN_delay;
  wire RXDFETAP14HOLD_delay;
  wire RXDFETAP14OVRDEN_delay;
  wire RXDFETAP15HOLD_delay;
  wire RXDFETAP15OVRDEN_delay;
  wire RXDFETAP2HOLD_delay;
  wire RXDFETAP2OVRDEN_delay;
  wire RXDFETAP3HOLD_delay;
  wire RXDFETAP3OVRDEN_delay;
  wire RXDFETAP4HOLD_delay;
  wire RXDFETAP4OVRDEN_delay;
  wire RXDFETAP5HOLD_delay;
  wire RXDFETAP5OVRDEN_delay;
  wire RXDFETAP6HOLD_delay;
  wire RXDFETAP6OVRDEN_delay;
  wire RXDFETAP7HOLD_delay;
  wire RXDFETAP7OVRDEN_delay;
  wire RXDFETAP8HOLD_delay;
  wire RXDFETAP8OVRDEN_delay;
  wire RXDFETAP9HOLD_delay;
  wire RXDFETAP9OVRDEN_delay;
  wire RXDFEUTHOLD_delay;
  wire RXDFEUTOVRDEN_delay;
  wire RXDFEVPHOLD_delay;
  wire RXDFEVPOVRDEN_delay;
  wire RXDFEVSEN_delay;
  wire RXDFEXYDEN_delay;
  wire RXDLYBYPASS_delay;
  wire RXDLYEN_delay;
  wire RXDLYOVRDEN_delay;
  wire RXDLYSRESET_delay;
  wire RXGEARBOXSLIP_delay;
  wire RXLATCLK_delay;
  wire RXLPMEN_delay;
  wire RXLPMGCHOLD_delay;
  wire RXLPMGCOVRDEN_delay;
  wire RXLPMHFHOLD_delay;
  wire RXLPMHFOVRDEN_delay;
  wire RXLPMLFHOLD_delay;
  wire RXLPMLFKLOVRDEN_delay;
  wire RXLPMOSHOLD_delay;
  wire RXLPMOSOVRDEN_delay;
  wire RXMCOMMAALIGNEN_delay;
  wire RXOOBRESET_delay;
  wire RXOSCALRESET_delay;
  wire RXOSHOLD_delay;
  wire RXOSINTEN_delay;
  wire RXOSINTHOLD_delay;
  wire RXOSINTOVRDEN_delay;
  wire RXOSINTSTROBE_delay;
  wire RXOSINTTESTOVRDEN_delay;
  wire RXOSOVRDEN_delay;
  wire RXPCOMMAALIGNEN_delay;
  wire RXPCSRESET_delay;
  wire RXPHALIGNEN_delay;
  wire RXPHALIGN_delay;
  wire RXPHDLYPD_delay;
  wire RXPHDLYRESET_delay;
  wire RXPHOVRDEN_delay;
  wire RXPMARESET_delay;
  wire RXPOLARITY_delay;
  wire RXPRBSCNTRESET_delay;
  wire RXPROGDIVRESET_delay;
  wire RXRATEMODE_delay;
  wire RXSLIDE_delay;
  wire RXSLIPOUTCLK_delay;
  wire RXSLIPPMA_delay;
  wire RXSYNCALLIN_delay;
  wire RXSYNCIN_delay;
  wire RXSYNCMODE_delay;
  wire RXUSERRDY_delay;
  wire RXUSRCLK2_delay;
  wire RXUSRCLK_delay;
  wire SIGVALIDCLK_delay;
  wire TX8B10BEN_delay;
  wire TXCOMINIT_delay;
  wire TXCOMSAS_delay;
  wire TXCOMWAKE_delay;
  wire TXDCCFORCESTART_delay;
  wire TXDCCRESET_delay;
  wire TXDEEMPH_delay;
  wire TXDETECTRX_delay;
  wire TXDIFFPD_delay;
  wire TXDLYBYPASS_delay;
  wire TXDLYEN_delay;
  wire TXDLYHOLD_delay;
  wire TXDLYOVRDEN_delay;
  wire TXDLYSRESET_delay;
  wire TXDLYUPDOWN_delay;
  wire TXELECIDLE_delay;
  wire TXELFORCESTART_delay;
  wire TXINHIBIT_delay;
  wire TXLATCLK_delay;
  wire TXPCSRESET_delay;
  wire TXPDELECIDLEMODE_delay;
  wire TXPHALIGNEN_delay;
  wire TXPHALIGN_delay;
  wire TXPHDLYPD_delay;
  wire TXPHDLYRESET_delay;
  wire TXPHDLYTSTCLK_delay;
  wire TXPHINIT_delay;
  wire TXPHOVRDEN_delay;
  wire TXPIPPMEN_delay;
  wire TXPIPPMOVRDEN_delay;
  wire TXPIPPMPD_delay;
  wire TXPIPPMSEL_delay;
  wire TXPISOPD_delay;
  wire TXPMARESET_delay;
  wire TXPOLARITY_delay;
  wire TXPRBSFORCEERR_delay;
  wire TXPROGDIVRESET_delay;
  wire TXRATEMODE_delay;
  wire TXSWING_delay;
  wire TXSYNCALLIN_delay;
  wire TXSYNCIN_delay;
  wire TXSYNCMODE_delay;
  wire TXUSERRDY_delay;
  wire TXUSRCLK2_delay;
  wire TXUSRCLK_delay;
  wire [127:0] TXDATA_delay;
  wire [15:0] DRPDI_delay;
  wire [15:0] GTRSVD_delay;
  wire [15:0] LOOPRSVD_delay;
  wire [15:0] PCSRSVDIN_delay;
  wire [15:0] TXCTRL0_delay;
  wire [15:0] TXCTRL1_delay;
  wire [19:0] TSTIN_delay;
  wire [1:0] RXELECIDLEMODE_delay;
  wire [1:0] RXMONITORSEL_delay;
  wire [1:0] RXPD_delay;
  wire [1:0] RXPLLCLKSEL_delay;
  wire [1:0] RXSYSCLKSEL_delay;
  wire [1:0] TXPD_delay;
  wire [1:0] TXPLLCLKSEL_delay;
  wire [1:0] TXSYSCLKSEL_delay;
  wire [2:0] CPLLREFCLKSEL_delay;
  wire [2:0] LOOPBACK_delay;
  wire [2:0] RXCHBONDLEVEL_delay;
  wire [2:0] RXOUTCLKSEL_delay;
  wire [2:0] RXRATE_delay;
  wire [2:0] TXBUFDIFFCTRL_delay;
  wire [2:0] TXMARGIN_delay;
  wire [2:0] TXOUTCLKSEL_delay;
  wire [2:0] TXRATE_delay;
  wire [3:0] RXOSINTCFG_delay;
  wire [3:0] RXPRBSSEL_delay;
  wire [3:0] TXPRBSSEL_delay;
  wire [4:0] PCSRSVDIN2_delay;
  wire [4:0] PMARSVDIN_delay;
  wire [4:0] RXCHBONDI_delay;
  wire [4:0] TXDIFFCTRL_delay;
  wire [4:0] TXPIPPMSTEPSIZE_delay;
  wire [4:0] TXPOSTCURSOR_delay;
  wire [4:0] TXPRECURSOR_delay;
  wire [5:0] TXHEADER_delay;
  wire [6:0] TXMAINCURSOR_delay;
  wire [6:0] TXSEQUENCE_delay;
  wire [7:0] TX8B10BBYPASS_delay;
  wire [7:0] TXCTRL2_delay;
  wire [7:0] TXDATAEXTENDRSVD_delay;
  wire [9:0] DRPADDR_delay;

  
  assign #(out_delay) BUFGTCE = BUFGTCE_delay;
  assign #(out_delay) BUFGTCEMASK = BUFGTCEMASK_delay;
  assign #(out_delay) BUFGTDIV = BUFGTDIV_delay;
  assign #(out_delay) BUFGTRESET = BUFGTRESET_delay;
  assign #(out_delay) BUFGTRSTMASK = BUFGTRSTMASK_delay;
  assign #(out_delay) CPLLFBCLKLOST = CPLLFBCLKLOST_delay;
  assign #(out_delay) CPLLLOCK = CPLLLOCK_delay;
  assign #(out_delay) CPLLREFCLKLOST = CPLLREFCLKLOST_delay;
  assign #(out_delay) DMONITOROUT = DMONITOROUT_delay;
  assign #(out_delay) DRPDO = DRPDO_delay;
  assign #(out_delay) DRPRDY = DRPRDY_delay;
  assign #(out_delay) EYESCANDATAERROR = EYESCANDATAERROR_delay;
  assign #(out_delay) GTPOWERGOOD = GTPOWERGOOD_delay;
  assign #(out_delay) GTREFCLKMONITOR = GTREFCLKMONITOR_delay;
  assign #(out_delay) GTYTXN = GTYTXN_delay;
  assign #(out_delay) GTYTXP = GTYTXP_delay;
  assign #(out_delay) PCIERATEGEN3 = PCIERATEGEN3_delay;
  assign #(out_delay) PCIERATEIDLE = PCIERATEIDLE_delay;
  assign #(out_delay) PCIERATEQPLLPD = PCIERATEQPLLPD_delay;
  assign #(out_delay) PCIERATEQPLLRESET = PCIERATEQPLLRESET_delay;
  assign #(out_delay) PCIESYNCTXSYNCDONE = PCIESYNCTXSYNCDONE_delay;
  assign #(out_delay) PCIEUSERGEN3RDY = PCIEUSERGEN3RDY_delay;
  assign #(out_delay) PCIEUSERPHYSTATUSRST = PCIEUSERPHYSTATUSRST_delay;
  assign #(out_delay) PCIEUSERRATESTART = PCIEUSERRATESTART_delay;
  assign #(out_delay) PCSRSVDOUT = PCSRSVDOUT_delay;
  assign #(out_delay) PHYSTATUS = PHYSTATUS_delay;
  assign #(out_delay) PINRSRVDAS = PINRSRVDAS_delay;
  assign #(out_delay) RESETEXCEPTION = RESETEXCEPTION_delay;
  assign #(out_delay) RXBUFSTATUS = RXBUFSTATUS_delay;
  assign #(out_delay) RXBYTEISALIGNED = RXBYTEISALIGNED_delay;
  assign #(out_delay) RXBYTEREALIGN = RXBYTEREALIGN_delay;
  assign #(out_delay) RXCDRLOCK = RXCDRLOCK_delay;
  assign #(out_delay) RXCDRPHDONE = RXCDRPHDONE_delay;
  assign #(out_delay) RXCHANBONDSEQ = RXCHANBONDSEQ_delay;
  assign #(out_delay) RXCHANISALIGNED = RXCHANISALIGNED_delay;
  assign #(out_delay) RXCHANREALIGN = RXCHANREALIGN_delay;
  assign #(out_delay) RXCHBONDO = RXCHBONDO_delay;
  assign #(out_delay) RXCKOKDONE = RXCKOKDONE_delay;
  assign #(out_delay) RXCLKCORCNT = RXCLKCORCNT_delay;
  assign #(out_delay) RXCOMINITDET = RXCOMINITDET_delay;
  assign #(out_delay) RXCOMMADET = RXCOMMADET_delay;
  assign #(out_delay) RXCOMSASDET = RXCOMSASDET_delay;
  assign #(out_delay) RXCOMWAKEDET = RXCOMWAKEDET_delay;
  assign #(out_delay) RXCTRL0 = RXCTRL0_delay;
  assign #(out_delay) RXCTRL1 = RXCTRL1_delay;
  assign #(out_delay) RXCTRL2 = RXCTRL2_delay;
  assign #(out_delay) RXCTRL3 = RXCTRL3_delay;
  assign #(out_delay) RXDATA = RXDATA_delay;
  assign #(out_delay) RXDATAEXTENDRSVD = RXDATAEXTENDRSVD_delay;
  assign #(out_delay) RXDATAVALID = RXDATAVALID_delay;
  assign #(out_delay) RXDLYSRESETDONE = RXDLYSRESETDONE_delay;
  assign #(out_delay) RXELECIDLE = RXELECIDLE_delay;
  assign #(out_delay) RXHEADER = RXHEADER_delay;
  assign #(out_delay) RXHEADERVALID = RXHEADERVALID_delay;
  assign #(out_delay) RXMONITOROUT = RXMONITOROUT_delay;
  assign #(out_delay) RXOSINTDONE = RXOSINTDONE_delay;
  assign #(out_delay) RXOSINTSTARTED = RXOSINTSTARTED_delay;
  assign #(out_delay) RXOSINTSTROBEDONE = RXOSINTSTROBEDONE_delay;
  assign #(out_delay) RXOSINTSTROBESTARTED = RXOSINTSTROBESTARTED_delay;
  assign #(out_delay) RXOUTCLK = RXOUTCLK_delay;
  assign #(out_delay) RXOUTCLKFABRIC = RXOUTCLKFABRIC_delay;
  assign #(out_delay) RXOUTCLKPCS = RXOUTCLKPCS_delay;
  assign #(out_delay) RXPHALIGNDONE = RXPHALIGNDONE_delay;
  assign #(out_delay) RXPHALIGNERR = RXPHALIGNERR_delay;
  assign #(out_delay) RXPMARESETDONE = RXPMARESETDONE_delay;
  assign #(out_delay) RXPRBSERR = RXPRBSERR_delay;
  assign #(out_delay) RXPRBSLOCKED = RXPRBSLOCKED_delay;
  assign #(out_delay) RXPRGDIVRESETDONE = RXPRGDIVRESETDONE_delay;
  assign #(out_delay) RXRATEDONE = RXRATEDONE_delay;
  assign #(out_delay) RXRECCLKOUT = RXRECCLKOUT_delay;
  assign #(out_delay) RXRESETDONE = RXRESETDONE_delay;
  assign #(out_delay) RXSLIDERDY = RXSLIDERDY_delay;
  assign #(out_delay) RXSLIPDONE = RXSLIPDONE_delay;
  assign #(out_delay) RXSLIPOUTCLKRDY = RXSLIPOUTCLKRDY_delay;
  assign #(out_delay) RXSLIPPMARDY = RXSLIPPMARDY_delay;
  assign #(out_delay) RXSTARTOFSEQ = RXSTARTOFSEQ_delay;
  assign #(out_delay) RXSTATUS = RXSTATUS_delay;
  assign #(out_delay) RXSYNCDONE = RXSYNCDONE_delay;
  assign #(out_delay) RXSYNCOUT = RXSYNCOUT_delay;
  assign #(out_delay) RXVALID = RXVALID_delay;
  assign #(out_delay) TXBUFSTATUS = TXBUFSTATUS_delay;
  assign #(out_delay) TXCOMFINISH = TXCOMFINISH_delay;
  assign #(out_delay) TXDCCDONE = TXDCCDONE_delay;
  assign #(out_delay) TXDLYSRESETDONE = TXDLYSRESETDONE_delay;
  assign #(out_delay) TXOUTCLK = TXOUTCLK_delay;
  assign #(out_delay) TXOUTCLKFABRIC = TXOUTCLKFABRIC_delay;
  assign #(out_delay) TXOUTCLKPCS = TXOUTCLKPCS_delay;
  assign #(out_delay) TXPHALIGNDONE = TXPHALIGNDONE_delay;
  assign #(out_delay) TXPHINITDONE = TXPHINITDONE_delay;
  assign #(out_delay) TXPMARESETDONE = TXPMARESETDONE_delay;
  assign #(out_delay) TXPRGDIVRESETDONE = TXPRGDIVRESETDONE_delay;
  assign #(out_delay) TXRATEDONE = TXRATEDONE_delay;
  assign #(out_delay) TXRESETDONE = TXRESETDONE_delay;
  assign #(out_delay) TXSYNCDONE = TXSYNCDONE_delay;
  assign #(out_delay) TXSYNCOUT = TXSYNCOUT_delay;
  

// inputs with no timing checks
  assign #(inclk_delay) CLKRSVD0_delay = CLKRSVD0;
  assign #(inclk_delay) CLKRSVD1_delay = CLKRSVD1;
  assign #(inclk_delay) CPLLLOCKDETCLK_delay = CPLLLOCKDETCLK;
  assign #(inclk_delay) DMONITORCLK_delay = DMONITORCLK;
  assign #(inclk_delay) DRPCLK_delay = DRPCLK;
  assign #(inclk_delay) GTGREFCLK_delay = GTGREFCLK;
  assign #(inclk_delay) RXLATCLK_delay = RXLATCLK;
  assign #(inclk_delay) RXUSRCLK2_delay = RXUSRCLK2;
  assign #(inclk_delay) RXUSRCLK_delay = RXUSRCLK;
  assign #(inclk_delay) SIGVALIDCLK_delay = SIGVALIDCLK;
  assign #(inclk_delay) TXLATCLK_delay = TXLATCLK;
  assign #(inclk_delay) TXPHDLYTSTCLK_delay = TXPHDLYTSTCLK;
  assign #(inclk_delay) TXUSRCLK2_delay = TXUSRCLK2;
  assign #(inclk_delay) TXUSRCLK_delay = TXUSRCLK;

  assign #(in_delay) CDRSTEPDIR_delay = CDRSTEPDIR;
  assign #(in_delay) CDRSTEPSQ_delay = CDRSTEPSQ;
  assign #(in_delay) CDRSTEPSX_delay = CDRSTEPSX;
  assign #(in_delay) CFGRESET_delay = CFGRESET;
  assign #(in_delay) CPLLLOCKEN_delay = CPLLLOCKEN;
  assign #(in_delay) CPLLPD_delay = CPLLPD;
  assign #(in_delay) CPLLREFCLKSEL_delay = CPLLREFCLKSEL;
  assign #(in_delay) CPLLRESET_delay = CPLLRESET;
  assign #(in_delay) DMONFIFORESET_delay = DMONFIFORESET;
  assign #(in_delay) DRPADDR_delay = DRPADDR;
  assign #(in_delay) DRPDI_delay = DRPDI;
  assign #(in_delay) DRPEN_delay = DRPEN;
  assign #(in_delay) DRPWE_delay = DRPWE;
  assign #(in_delay) ELPCALDVORWREN_delay = ELPCALDVORWREN;
  assign #(in_delay) ELPCALPAORWREN_delay = ELPCALPAORWREN;
  assign #(in_delay) EVODDPHICALDONE_delay = EVODDPHICALDONE;
  assign #(in_delay) EVODDPHICALSTART_delay = EVODDPHICALSTART;
  assign #(in_delay) EVODDPHIDRDEN_delay = EVODDPHIDRDEN;
  assign #(in_delay) EVODDPHIDWREN_delay = EVODDPHIDWREN;
  assign #(in_delay) EVODDPHIXRDEN_delay = EVODDPHIXRDEN;
  assign #(in_delay) EVODDPHIXWREN_delay = EVODDPHIXWREN;
  assign #(in_delay) EYESCANMODE_delay = EYESCANMODE;
  assign #(in_delay) EYESCANRESET_delay = EYESCANRESET;
  assign #(in_delay) EYESCANTRIGGER_delay = EYESCANTRIGGER;
  assign #(in_delay) GTNORTHREFCLK0_delay = GTNORTHREFCLK0;
  assign #(in_delay) GTNORTHREFCLK1_delay = GTNORTHREFCLK1;
  assign #(in_delay) GTREFCLK0_delay = GTREFCLK0;
  assign #(in_delay) GTREFCLK1_delay = GTREFCLK1;
  assign #(in_delay) GTRESETSEL_delay = GTRESETSEL;
  assign #(in_delay) GTRSVD_delay = GTRSVD;
  assign #(in_delay) GTRXRESET_delay = GTRXRESET;
  assign #(in_delay) GTSOUTHREFCLK0_delay = GTSOUTHREFCLK0;
  assign #(in_delay) GTSOUTHREFCLK1_delay = GTSOUTHREFCLK1;
  assign #(in_delay) GTTXRESET_delay = GTTXRESET;
  assign #(in_delay) GTYRXN_delay = GTYRXN;
  assign #(in_delay) GTYRXP_delay = GTYRXP;
  assign #(in_delay) LOOPBACK_delay = LOOPBACK;
  assign #(in_delay) LOOPRSVD_delay = LOOPRSVD;
  assign #(in_delay) LPBKRXTXSEREN_delay = LPBKRXTXSEREN;
  assign #(in_delay) LPBKTXRXSEREN_delay = LPBKTXRXSEREN;
  assign #(in_delay) PCIEEQRXEQADAPTDONE_delay = PCIEEQRXEQADAPTDONE;
  assign #(in_delay) PCIERSTIDLE_delay = PCIERSTIDLE;
  assign #(in_delay) PCIERSTTXSYNCSTART_delay = PCIERSTTXSYNCSTART;
  assign #(in_delay) PCIEUSERRATEDONE_delay = PCIEUSERRATEDONE;
  assign #(in_delay) PCSRSVDIN2_delay = PCSRSVDIN2;
  assign #(in_delay) PCSRSVDIN_delay = PCSRSVDIN;
  assign #(in_delay) PMARSVDIN_delay = PMARSVDIN;
  assign #(in_delay) QPLL0CLK_delay = QPLL0CLK;
  assign #(in_delay) QPLL0REFCLK_delay = QPLL0REFCLK;
  assign #(in_delay) QPLL1CLK_delay = QPLL1CLK;
  assign #(in_delay) QPLL1REFCLK_delay = QPLL1REFCLK;
  assign #(in_delay) RESETOVRD_delay = RESETOVRD;
  assign #(in_delay) RSTCLKENTX_delay = RSTCLKENTX;
  assign #(in_delay) RX8B10BEN_delay = RX8B10BEN;
  assign #(in_delay) RXBUFRESET_delay = RXBUFRESET;
  assign #(in_delay) RXCDRFREQRESET_delay = RXCDRFREQRESET;
  assign #(in_delay) RXCDRHOLD_delay = RXCDRHOLD;
  assign #(in_delay) RXCDROVRDEN_delay = RXCDROVRDEN;
  assign #(in_delay) RXCDRRESETRSV_delay = RXCDRRESETRSV;
  assign #(in_delay) RXCDRRESET_delay = RXCDRRESET;
  assign #(in_delay) RXCHBONDEN_delay = RXCHBONDEN;
  assign #(in_delay) RXCHBONDI_delay = RXCHBONDI;
  assign #(in_delay) RXCHBONDLEVEL_delay = RXCHBONDLEVEL;
  assign #(in_delay) RXCHBONDMASTER_delay = RXCHBONDMASTER;
  assign #(in_delay) RXCHBONDSLAVE_delay = RXCHBONDSLAVE;
  assign #(in_delay) RXCKOKRESET_delay = RXCKOKRESET;
  assign #(in_delay) RXCOMMADETEN_delay = RXCOMMADETEN;
  assign #(in_delay) RXDCCFORCESTART_delay = RXDCCFORCESTART;
  assign #(in_delay) RXDFEAGCHOLD_delay = RXDFEAGCHOLD;
  assign #(in_delay) RXDFEAGCOVRDEN_delay = RXDFEAGCOVRDEN;
  assign #(in_delay) RXDFELFHOLD_delay = RXDFELFHOLD;
  assign #(in_delay) RXDFELFOVRDEN_delay = RXDFELFOVRDEN;
  assign #(in_delay) RXDFELPMRESET_delay = RXDFELPMRESET;
  assign #(in_delay) RXDFETAP10HOLD_delay = RXDFETAP10HOLD;
  assign #(in_delay) RXDFETAP10OVRDEN_delay = RXDFETAP10OVRDEN;
  assign #(in_delay) RXDFETAP11HOLD_delay = RXDFETAP11HOLD;
  assign #(in_delay) RXDFETAP11OVRDEN_delay = RXDFETAP11OVRDEN;
  assign #(in_delay) RXDFETAP12HOLD_delay = RXDFETAP12HOLD;
  assign #(in_delay) RXDFETAP12OVRDEN_delay = RXDFETAP12OVRDEN;
  assign #(in_delay) RXDFETAP13HOLD_delay = RXDFETAP13HOLD;
  assign #(in_delay) RXDFETAP13OVRDEN_delay = RXDFETAP13OVRDEN;
  assign #(in_delay) RXDFETAP14HOLD_delay = RXDFETAP14HOLD;
  assign #(in_delay) RXDFETAP14OVRDEN_delay = RXDFETAP14OVRDEN;
  assign #(in_delay) RXDFETAP15HOLD_delay = RXDFETAP15HOLD;
  assign #(in_delay) RXDFETAP15OVRDEN_delay = RXDFETAP15OVRDEN;
  assign #(in_delay) RXDFETAP2HOLD_delay = RXDFETAP2HOLD;
  assign #(in_delay) RXDFETAP2OVRDEN_delay = RXDFETAP2OVRDEN;
  assign #(in_delay) RXDFETAP3HOLD_delay = RXDFETAP3HOLD;
  assign #(in_delay) RXDFETAP3OVRDEN_delay = RXDFETAP3OVRDEN;
  assign #(in_delay) RXDFETAP4HOLD_delay = RXDFETAP4HOLD;
  assign #(in_delay) RXDFETAP4OVRDEN_delay = RXDFETAP4OVRDEN;
  assign #(in_delay) RXDFETAP5HOLD_delay = RXDFETAP5HOLD;
  assign #(in_delay) RXDFETAP5OVRDEN_delay = RXDFETAP5OVRDEN;
  assign #(in_delay) RXDFETAP6HOLD_delay = RXDFETAP6HOLD;
  assign #(in_delay) RXDFETAP6OVRDEN_delay = RXDFETAP6OVRDEN;
  assign #(in_delay) RXDFETAP7HOLD_delay = RXDFETAP7HOLD;
  assign #(in_delay) RXDFETAP7OVRDEN_delay = RXDFETAP7OVRDEN;
  assign #(in_delay) RXDFETAP8HOLD_delay = RXDFETAP8HOLD;
  assign #(in_delay) RXDFETAP8OVRDEN_delay = RXDFETAP8OVRDEN;
  assign #(in_delay) RXDFETAP9HOLD_delay = RXDFETAP9HOLD;
  assign #(in_delay) RXDFETAP9OVRDEN_delay = RXDFETAP9OVRDEN;
  assign #(in_delay) RXDFEUTHOLD_delay = RXDFEUTHOLD;
  assign #(in_delay) RXDFEUTOVRDEN_delay = RXDFEUTOVRDEN;
  assign #(in_delay) RXDFEVPHOLD_delay = RXDFEVPHOLD;
  assign #(in_delay) RXDFEVPOVRDEN_delay = RXDFEVPOVRDEN;
  assign #(in_delay) RXDFEVSEN_delay = RXDFEVSEN;
  assign #(in_delay) RXDFEXYDEN_delay = RXDFEXYDEN;
  assign #(in_delay) RXDLYBYPASS_delay = RXDLYBYPASS;
  assign #(in_delay) RXDLYEN_delay = RXDLYEN;
  assign #(in_delay) RXDLYOVRDEN_delay = RXDLYOVRDEN;
  assign #(in_delay) RXDLYSRESET_delay = RXDLYSRESET;
  assign #(in_delay) RXELECIDLEMODE_delay = RXELECIDLEMODE;
  assign #(in_delay) RXGEARBOXSLIP_delay = RXGEARBOXSLIP;
  assign #(in_delay) RXLPMEN_delay = RXLPMEN;
  assign #(in_delay) RXLPMGCHOLD_delay = RXLPMGCHOLD;
  assign #(in_delay) RXLPMGCOVRDEN_delay = RXLPMGCOVRDEN;
  assign #(in_delay) RXLPMHFHOLD_delay = RXLPMHFHOLD;
  assign #(in_delay) RXLPMHFOVRDEN_delay = RXLPMHFOVRDEN;
  assign #(in_delay) RXLPMLFHOLD_delay = RXLPMLFHOLD;
  assign #(in_delay) RXLPMLFKLOVRDEN_delay = RXLPMLFKLOVRDEN;
  assign #(in_delay) RXLPMOSHOLD_delay = RXLPMOSHOLD;
  assign #(in_delay) RXLPMOSOVRDEN_delay = RXLPMOSOVRDEN;
  assign #(in_delay) RXMCOMMAALIGNEN_delay = RXMCOMMAALIGNEN;
  assign #(in_delay) RXMONITORSEL_delay = RXMONITORSEL;
  assign #(in_delay) RXOOBRESET_delay = RXOOBRESET;
  assign #(in_delay) RXOSCALRESET_delay = RXOSCALRESET;
  assign #(in_delay) RXOSHOLD_delay = RXOSHOLD;
  assign #(in_delay) RXOSINTCFG_delay = RXOSINTCFG;
  assign #(in_delay) RXOSINTEN_delay = RXOSINTEN;
  assign #(in_delay) RXOSINTHOLD_delay = RXOSINTHOLD;
  assign #(in_delay) RXOSINTOVRDEN_delay = RXOSINTOVRDEN;
  assign #(in_delay) RXOSINTSTROBE_delay = RXOSINTSTROBE;
  assign #(in_delay) RXOSINTTESTOVRDEN_delay = RXOSINTTESTOVRDEN;
  assign #(in_delay) RXOSOVRDEN_delay = RXOSOVRDEN;
  assign #(in_delay) RXOUTCLKSEL_delay = RXOUTCLKSEL;
  assign #(in_delay) RXPCOMMAALIGNEN_delay = RXPCOMMAALIGNEN;
  assign #(in_delay) RXPCSRESET_delay = RXPCSRESET;
  assign #(in_delay) RXPD_delay = RXPD;
  assign #(in_delay) RXPHALIGNEN_delay = RXPHALIGNEN;
  assign #(in_delay) RXPHALIGN_delay = RXPHALIGN;
  assign #(in_delay) RXPHDLYPD_delay = RXPHDLYPD;
  assign #(in_delay) RXPHDLYRESET_delay = RXPHDLYRESET;
  assign #(in_delay) RXPHOVRDEN_delay = RXPHOVRDEN;
  assign #(in_delay) RXPLLCLKSEL_delay = RXPLLCLKSEL;
  assign #(in_delay) RXPMARESET_delay = RXPMARESET;
  assign #(in_delay) RXPOLARITY_delay = RXPOLARITY;
  assign #(in_delay) RXPRBSCNTRESET_delay = RXPRBSCNTRESET;
  assign #(in_delay) RXPRBSSEL_delay = RXPRBSSEL;
  assign #(in_delay) RXPROGDIVRESET_delay = RXPROGDIVRESET;
  assign #(in_delay) RXRATEMODE_delay = RXRATEMODE;
  assign #(in_delay) RXRATE_delay = RXRATE;
  assign #(in_delay) RXSLIDE_delay = RXSLIDE;
  assign #(in_delay) RXSLIPOUTCLK_delay = RXSLIPOUTCLK;
  assign #(in_delay) RXSLIPPMA_delay = RXSLIPPMA;
  assign #(in_delay) RXSYNCALLIN_delay = RXSYNCALLIN;
  assign #(in_delay) RXSYNCIN_delay = RXSYNCIN;
  assign #(in_delay) RXSYNCMODE_delay = RXSYNCMODE;
  assign #(in_delay) RXSYSCLKSEL_delay = RXSYSCLKSEL;
  assign #(in_delay) RXUSERRDY_delay = RXUSERRDY;
  assign #(in_delay) TSTIN_delay = TSTIN;
  assign #(in_delay) TX8B10BBYPASS_delay = TX8B10BBYPASS;
  assign #(in_delay) TX8B10BEN_delay = TX8B10BEN;
  assign #(in_delay) TXBUFDIFFCTRL_delay = TXBUFDIFFCTRL;
  assign #(in_delay) TXCOMINIT_delay = TXCOMINIT;
  assign #(in_delay) TXCOMSAS_delay = TXCOMSAS;
  assign #(in_delay) TXCOMWAKE_delay = TXCOMWAKE;
  assign #(in_delay) TXCTRL0_delay = TXCTRL0;
  assign #(in_delay) TXCTRL1_delay = TXCTRL1;
  assign #(in_delay) TXCTRL2_delay = TXCTRL2;
  assign #(in_delay) TXDATAEXTENDRSVD_delay = TXDATAEXTENDRSVD;
  assign #(in_delay) TXDATA_delay = TXDATA;
  assign #(in_delay) TXDCCFORCESTART_delay = TXDCCFORCESTART;
  assign #(in_delay) TXDCCRESET_delay = TXDCCRESET;
  assign #(in_delay) TXDEEMPH_delay = TXDEEMPH;
  assign #(in_delay) TXDETECTRX_delay = TXDETECTRX;
  assign #(in_delay) TXDIFFCTRL_delay = TXDIFFCTRL;
  assign #(in_delay) TXDIFFPD_delay = TXDIFFPD;
  assign #(in_delay) TXDLYBYPASS_delay = TXDLYBYPASS;
  assign #(in_delay) TXDLYEN_delay = TXDLYEN;
  assign #(in_delay) TXDLYHOLD_delay = TXDLYHOLD;
  assign #(in_delay) TXDLYOVRDEN_delay = TXDLYOVRDEN;
  assign #(in_delay) TXDLYSRESET_delay = TXDLYSRESET;
  assign #(in_delay) TXDLYUPDOWN_delay = TXDLYUPDOWN;
  assign #(in_delay) TXELECIDLE_delay = TXELECIDLE;
  assign #(in_delay) TXELFORCESTART_delay = TXELFORCESTART;
  assign #(in_delay) TXHEADER_delay = TXHEADER;
  assign #(in_delay) TXINHIBIT_delay = TXINHIBIT;
  assign #(in_delay) TXMAINCURSOR_delay = TXMAINCURSOR;
  assign #(in_delay) TXMARGIN_delay = TXMARGIN;
  assign #(in_delay) TXOUTCLKSEL_delay = TXOUTCLKSEL;
  assign #(in_delay) TXPCSRESET_delay = TXPCSRESET;
  assign #(in_delay) TXPDELECIDLEMODE_delay = TXPDELECIDLEMODE;
  assign #(in_delay) TXPD_delay = TXPD;
  assign #(in_delay) TXPHALIGNEN_delay = TXPHALIGNEN;
  assign #(in_delay) TXPHALIGN_delay = TXPHALIGN;
  assign #(in_delay) TXPHDLYPD_delay = TXPHDLYPD;
  assign #(in_delay) TXPHDLYRESET_delay = TXPHDLYRESET;
  assign #(in_delay) TXPHINIT_delay = TXPHINIT;
  assign #(in_delay) TXPHOVRDEN_delay = TXPHOVRDEN;
  assign #(in_delay) TXPIPPMEN_delay = TXPIPPMEN;
  assign #(in_delay) TXPIPPMOVRDEN_delay = TXPIPPMOVRDEN;
  assign #(in_delay) TXPIPPMPD_delay = TXPIPPMPD;
  assign #(in_delay) TXPIPPMSEL_delay = TXPIPPMSEL;
  assign #(in_delay) TXPIPPMSTEPSIZE_delay = TXPIPPMSTEPSIZE;
  assign #(in_delay) TXPISOPD_delay = TXPISOPD;
  assign #(in_delay) TXPLLCLKSEL_delay = TXPLLCLKSEL;
  assign #(in_delay) TXPMARESET_delay = TXPMARESET;
  assign #(in_delay) TXPOLARITY_delay = TXPOLARITY;
  assign #(in_delay) TXPOSTCURSOR_delay = TXPOSTCURSOR;
  assign #(in_delay) TXPRBSFORCEERR_delay = TXPRBSFORCEERR;
  assign #(in_delay) TXPRBSSEL_delay = TXPRBSSEL;
  assign #(in_delay) TXPRECURSOR_delay = TXPRECURSOR;
  assign #(in_delay) TXPROGDIVRESET_delay = TXPROGDIVRESET;
  assign #(in_delay) TXRATEMODE_delay = TXRATEMODE;
  assign #(in_delay) TXRATE_delay = TXRATE;
  assign #(in_delay) TXSEQUENCE_delay = TXSEQUENCE;
  assign #(in_delay) TXSWING_delay = TXSWING;
  assign #(in_delay) TXSYNCALLIN_delay = TXSYNCALLIN;
  assign #(in_delay) TXSYNCIN_delay = TXSYNCIN;
  assign #(in_delay) TXSYNCMODE_delay = TXSYNCMODE;
  assign #(in_delay) TXSYSCLKSEL_delay = TXSYSCLKSEL;
  assign #(in_delay) TXUSERRDY_delay = TXUSERRDY;

  assign BUFGTCEMASK_delay = BUFGTCEMASK_out;
  assign BUFGTCE_delay = BUFGTCE_out;
  assign BUFGTDIV_delay = BUFGTDIV_out;
  assign BUFGTRESET_delay = BUFGTRESET_out;
  assign BUFGTRSTMASK_delay = BUFGTRSTMASK_out;
  assign CPLLFBCLKLOST_delay = CPLLFBCLKLOST_out;
  assign CPLLLOCK_delay = CPLLLOCK_out;
  assign CPLLREFCLKLOST_delay = CPLLREFCLKLOST_out;
  assign DMONITOROUT_delay = DMONITOROUT_out;
  assign DRPDO_delay = DRPDO_out;
  assign DRPRDY_delay = DRPRDY_out;
  assign EYESCANDATAERROR_delay = EYESCANDATAERROR_out;
  assign GTPOWERGOOD_delay = GTPOWERGOOD_out;
  assign GTREFCLKMONITOR_delay = GTREFCLKMONITOR_out;
  assign GTYTXN_delay = GTYTXN_out;
  assign GTYTXP_delay = GTYTXP_out;
  assign PCIERATEGEN3_delay = PCIERATEGEN3_out;
  assign PCIERATEIDLE_delay = PCIERATEIDLE_out;
  assign PCIERATEQPLLPD_delay = PCIERATEQPLLPD_out;
  assign PCIERATEQPLLRESET_delay = PCIERATEQPLLRESET_out;
  assign PCIESYNCTXSYNCDONE_delay = PCIESYNCTXSYNCDONE_out;
  assign PCIEUSERGEN3RDY_delay = PCIEUSERGEN3RDY_out;
  assign PCIEUSERPHYSTATUSRST_delay = PCIEUSERPHYSTATUSRST_out;
  assign PCIEUSERRATESTART_delay = PCIEUSERRATESTART_out;
  assign PCSRSVDOUT_delay = PCSRSVDOUT_out;
  assign PHYSTATUS_delay = PHYSTATUS_out;
  assign PINRSRVDAS_delay = PINRSRVDAS_out;
  assign RESETEXCEPTION_delay = RESETEXCEPTION_out;
  assign RXBUFSTATUS_delay = RXBUFSTATUS_out;
  assign RXBYTEISALIGNED_delay = RXBYTEISALIGNED_out;
  assign RXBYTEREALIGN_delay = RXBYTEREALIGN_out;
  assign RXCDRLOCK_delay = RXCDRLOCK_out;
  assign RXCDRPHDONE_delay = RXCDRPHDONE_out;
  assign RXCHANBONDSEQ_delay = RXCHANBONDSEQ_out;
  assign RXCHANISALIGNED_delay = RXCHANISALIGNED_out;
  assign RXCHANREALIGN_delay = RXCHANREALIGN_out;
  assign RXCHBONDO_delay = RXCHBONDO_out;
  assign RXCKOKDONE_delay = RXCKOKDONE_out;
  assign RXCLKCORCNT_delay = RXCLKCORCNT_out;
  assign RXCOMINITDET_delay = RXCOMINITDET_out;
  assign RXCOMMADET_delay = RXCOMMADET_out;
  assign RXCOMSASDET_delay = RXCOMSASDET_out;
  assign RXCOMWAKEDET_delay = RXCOMWAKEDET_out;
  assign RXCTRL0_delay = RXCTRL0_out;
  assign RXCTRL1_delay = RXCTRL1_out;
  assign RXCTRL2_delay = RXCTRL2_out;
  assign RXCTRL3_delay = RXCTRL3_out;
  assign RXDATAEXTENDRSVD_delay = RXDATAEXTENDRSVD_out;
  assign RXDATAVALID_delay = RXDATAVALID_out;
  assign RXDATA_delay = RXDATA_out;
  assign RXDLYSRESETDONE_delay = RXDLYSRESETDONE_out;
  assign RXELECIDLE_delay = RXELECIDLE_out;
  assign RXHEADERVALID_delay = RXHEADERVALID_out;
  assign RXHEADER_delay = RXHEADER_out;
  assign RXMONITOROUT_delay = RXMONITOROUT_out;
  assign RXOSINTDONE_delay = RXOSINTDONE_out;
  assign RXOSINTSTARTED_delay = RXOSINTSTARTED_out;
  assign RXOSINTSTROBEDONE_delay = RXOSINTSTROBEDONE_out;
  assign RXOSINTSTROBESTARTED_delay = RXOSINTSTROBESTARTED_out;
  assign RXOUTCLKFABRIC_delay = RXOUTCLKFABRIC_out;
  assign RXOUTCLKPCS_delay = RXOUTCLKPCS_out;
  assign RXOUTCLK_delay = RXOUTCLK_out;
  assign RXPHALIGNDONE_delay = RXPHALIGNDONE_out;
  assign RXPHALIGNERR_delay = RXPHALIGNERR_out;
  assign RXPMARESETDONE_delay = RXPMARESETDONE_out;
  assign RXPRBSERR_delay = RXPRBSERR_out;
  assign RXPRBSLOCKED_delay = RXPRBSLOCKED_out;
  assign RXPRGDIVRESETDONE_delay = RXPRGDIVRESETDONE_out;
  assign RXRATEDONE_delay = RXRATEDONE_out;
  assign RXRECCLKOUT_delay = RXRECCLKOUT_out;
  assign RXRESETDONE_delay = RXRESETDONE_out;
  assign RXSLIDERDY_delay = RXSLIDERDY_out;
  assign RXSLIPDONE_delay = RXSLIPDONE_out;
  assign RXSLIPOUTCLKRDY_delay = RXSLIPOUTCLKRDY_out;
  assign RXSLIPPMARDY_delay = RXSLIPPMARDY_out;
  assign RXSTARTOFSEQ_delay = RXSTARTOFSEQ_out;
  assign RXSTATUS_delay = RXSTATUS_out;
  assign RXSYNCDONE_delay = RXSYNCDONE_out;
  assign RXSYNCOUT_delay = RXSYNCOUT_out;
  assign RXVALID_delay = RXVALID_out;
  assign TXBUFSTATUS_delay = TXBUFSTATUS_out;
  assign TXCOMFINISH_delay = TXCOMFINISH_out;
  assign TXDCCDONE_delay = TXDCCDONE_out;
  assign TXDLYSRESETDONE_delay = TXDLYSRESETDONE_out;
  assign TXOUTCLKFABRIC_delay = TXOUTCLKFABRIC_out;
  assign TXOUTCLKPCS_delay = TXOUTCLKPCS_out;
  assign TXOUTCLK_delay = TXOUTCLK_out;
  assign TXPHALIGNDONE_delay = TXPHALIGNDONE_out;
  assign TXPHINITDONE_delay = TXPHINITDONE_out;
  assign TXPMARESETDONE_delay = TXPMARESETDONE_out;
  assign TXPRGDIVRESETDONE_delay = TXPRGDIVRESETDONE_out;
  assign TXRATEDONE_delay = TXRATEDONE_out;
  assign TXRESETDONE_delay = TXRESETDONE_out;
  assign TXSYNCDONE_delay = TXSYNCDONE_out;
  assign TXSYNCOUT_delay = TXSYNCOUT_out;

  assign CDRSTEPDIR_in = CDRSTEPDIR_delay;
  assign CDRSTEPSQ_in = CDRSTEPSQ_delay;
  assign CDRSTEPSX_in = CDRSTEPSX_delay;
  assign CFGRESET_in = CFGRESET_delay;
  assign CLKRSVD0_in = CLKRSVD0_delay;
  assign CLKRSVD1_in = CLKRSVD1_delay;
  assign CPLLLOCKDETCLK_in = CPLLLOCKDETCLK_delay;
  assign CPLLLOCKEN_in = CPLLLOCKEN_delay;
  assign CPLLPD_in = CPLLPD_delay;
  assign CPLLREFCLKSEL_in = CPLLREFCLKSEL_delay;
  assign CPLLRESET_in = CPLLRESET_delay;
  assign DMONFIFORESET_in = DMONFIFORESET_delay;
  assign DMONITORCLK_in = DMONITORCLK_delay;
  assign DRPADDR_in = DRPADDR_delay;
  assign DRPCLK_in = DRPCLK_delay;
  assign DRPDI_in = DRPDI_delay;
  assign DRPEN_in = DRPEN_delay;
  assign DRPWE_in = DRPWE_delay;
  assign ELPCALDVORWREN_in = ELPCALDVORWREN_delay;
  assign ELPCALPAORWREN_in = ELPCALPAORWREN_delay;
  assign EVODDPHICALDONE_in = EVODDPHICALDONE_delay;
  assign EVODDPHICALSTART_in = EVODDPHICALSTART_delay;
  assign EVODDPHIDRDEN_in = EVODDPHIDRDEN_delay;
  assign EVODDPHIDWREN_in = EVODDPHIDWREN_delay;
  assign EVODDPHIXRDEN_in = EVODDPHIXRDEN_delay;
  assign EVODDPHIXWREN_in = EVODDPHIXWREN_delay;
  assign EYESCANMODE_in = EYESCANMODE_delay;
  assign EYESCANRESET_in = EYESCANRESET_delay;
  assign EYESCANTRIGGER_in = EYESCANTRIGGER_delay;
  assign GTGREFCLK_in = GTGREFCLK_delay;
  assign GTNORTHREFCLK0_in = GTNORTHREFCLK0_delay;
  assign GTNORTHREFCLK1_in = GTNORTHREFCLK1_delay;
  assign GTREFCLK0_in = GTREFCLK0_delay;
  assign GTREFCLK1_in = GTREFCLK1_delay;
  assign GTRESETSEL_in = GTRESETSEL_delay;
  assign GTRSVD_in = GTRSVD_delay;
  assign GTRXRESET_in = GTRXRESET_delay;
  assign GTSOUTHREFCLK0_in = GTSOUTHREFCLK0_delay;
  assign GTSOUTHREFCLK1_in = GTSOUTHREFCLK1_delay;
  assign GTTXRESET_in = GTTXRESET_delay;
  assign GTYRXN_in = GTYRXN_delay;
  assign GTYRXP_in = GTYRXP_delay;
  assign LOOPBACK_in = LOOPBACK_delay;
  assign LOOPRSVD_in = LOOPRSVD_delay;
  assign LPBKRXTXSEREN_in = LPBKRXTXSEREN_delay;
  assign LPBKTXRXSEREN_in = LPBKTXRXSEREN_delay;
  assign PCIEEQRXEQADAPTDONE_in = PCIEEQRXEQADAPTDONE_delay;
  assign PCIERSTIDLE_in = PCIERSTIDLE_delay;
  assign PCIERSTTXSYNCSTART_in = PCIERSTTXSYNCSTART_delay;
  assign PCIEUSERRATEDONE_in = PCIEUSERRATEDONE_delay;
  assign PCSRSVDIN2_in = PCSRSVDIN2_delay;
  assign PCSRSVDIN_in = PCSRSVDIN_delay;
  assign PMARSVDIN_in = PMARSVDIN_delay;
  assign QPLL0CLK_in = QPLL0CLK_delay;
  assign QPLL0REFCLK_in = QPLL0REFCLK_delay;
  assign QPLL1CLK_in = QPLL1CLK_delay;
  assign QPLL1REFCLK_in = QPLL1REFCLK_delay;
  assign RESETOVRD_in = RESETOVRD_delay;
  assign RSTCLKENTX_in = RSTCLKENTX_delay;
  assign RX8B10BEN_in = RX8B10BEN_delay;
  assign RXBUFRESET_in = RXBUFRESET_delay;
  assign RXCDRFREQRESET_in = RXCDRFREQRESET_delay;
  assign RXCDRHOLD_in = RXCDRHOLD_delay;
  assign RXCDROVRDEN_in = RXCDROVRDEN_delay;
  assign RXCDRRESETRSV_in = RXCDRRESETRSV_delay;
  assign RXCDRRESET_in = RXCDRRESET_delay;
  assign RXCHBONDEN_in = RXCHBONDEN_delay;
  assign RXCHBONDI_in = RXCHBONDI_delay;
  assign RXCHBONDLEVEL_in = RXCHBONDLEVEL_delay;
  assign RXCHBONDMASTER_in = RXCHBONDMASTER_delay;
  assign RXCHBONDSLAVE_in = RXCHBONDSLAVE_delay;
  assign RXCKOKRESET_in = RXCKOKRESET_delay;
  assign RXCOMMADETEN_in = RXCOMMADETEN_delay;
  assign RXDCCFORCESTART_in = RXDCCFORCESTART_delay;
  assign RXDFEAGCHOLD_in = RXDFEAGCHOLD_delay;
  assign RXDFEAGCOVRDEN_in = RXDFEAGCOVRDEN_delay;
  assign RXDFELFHOLD_in = RXDFELFHOLD_delay;
  assign RXDFELFOVRDEN_in = RXDFELFOVRDEN_delay;
  assign RXDFELPMRESET_in = RXDFELPMRESET_delay;
  assign RXDFETAP10HOLD_in = RXDFETAP10HOLD_delay;
  assign RXDFETAP10OVRDEN_in = RXDFETAP10OVRDEN_delay;
  assign RXDFETAP11HOLD_in = RXDFETAP11HOLD_delay;
  assign RXDFETAP11OVRDEN_in = RXDFETAP11OVRDEN_delay;
  assign RXDFETAP12HOLD_in = RXDFETAP12HOLD_delay;
  assign RXDFETAP12OVRDEN_in = RXDFETAP12OVRDEN_delay;
  assign RXDFETAP13HOLD_in = RXDFETAP13HOLD_delay;
  assign RXDFETAP13OVRDEN_in = RXDFETAP13OVRDEN_delay;
  assign RXDFETAP14HOLD_in = RXDFETAP14HOLD_delay;
  assign RXDFETAP14OVRDEN_in = RXDFETAP14OVRDEN_delay;
  assign RXDFETAP15HOLD_in = RXDFETAP15HOLD_delay;
  assign RXDFETAP15OVRDEN_in = RXDFETAP15OVRDEN_delay;
  assign RXDFETAP2HOLD_in = RXDFETAP2HOLD_delay;
  assign RXDFETAP2OVRDEN_in = RXDFETAP2OVRDEN_delay;
  assign RXDFETAP3HOLD_in = RXDFETAP3HOLD_delay;
  assign RXDFETAP3OVRDEN_in = RXDFETAP3OVRDEN_delay;
  assign RXDFETAP4HOLD_in = RXDFETAP4HOLD_delay;
  assign RXDFETAP4OVRDEN_in = RXDFETAP4OVRDEN_delay;
  assign RXDFETAP5HOLD_in = RXDFETAP5HOLD_delay;
  assign RXDFETAP5OVRDEN_in = RXDFETAP5OVRDEN_delay;
  assign RXDFETAP6HOLD_in = RXDFETAP6HOLD_delay;
  assign RXDFETAP6OVRDEN_in = RXDFETAP6OVRDEN_delay;
  assign RXDFETAP7HOLD_in = RXDFETAP7HOLD_delay;
  assign RXDFETAP7OVRDEN_in = RXDFETAP7OVRDEN_delay;
  assign RXDFETAP8HOLD_in = RXDFETAP8HOLD_delay;
  assign RXDFETAP8OVRDEN_in = RXDFETAP8OVRDEN_delay;
  assign RXDFETAP9HOLD_in = RXDFETAP9HOLD_delay;
  assign RXDFETAP9OVRDEN_in = RXDFETAP9OVRDEN_delay;
  assign RXDFEUTHOLD_in = RXDFEUTHOLD_delay;
  assign RXDFEUTOVRDEN_in = RXDFEUTOVRDEN_delay;
  assign RXDFEVPHOLD_in = RXDFEVPHOLD_delay;
  assign RXDFEVPOVRDEN_in = RXDFEVPOVRDEN_delay;
  assign RXDFEVSEN_in = RXDFEVSEN_delay;
  assign RXDFEXYDEN_in = RXDFEXYDEN_delay;
  assign RXDLYBYPASS_in = RXDLYBYPASS_delay;
  assign RXDLYEN_in = RXDLYEN_delay;
  assign RXDLYOVRDEN_in = RXDLYOVRDEN_delay;
  assign RXDLYSRESET_in = RXDLYSRESET_delay;
  assign RXELECIDLEMODE_in = RXELECIDLEMODE_delay;
  assign RXGEARBOXSLIP_in = RXGEARBOXSLIP_delay;
  assign RXLATCLK_in = RXLATCLK_delay;
  assign RXLPMEN_in = RXLPMEN_delay;
  assign RXLPMGCHOLD_in = RXLPMGCHOLD_delay;
  assign RXLPMGCOVRDEN_in = RXLPMGCOVRDEN_delay;
  assign RXLPMHFHOLD_in = RXLPMHFHOLD_delay;
  assign RXLPMHFOVRDEN_in = RXLPMHFOVRDEN_delay;
  assign RXLPMLFHOLD_in = RXLPMLFHOLD_delay;
  assign RXLPMLFKLOVRDEN_in = RXLPMLFKLOVRDEN_delay;
  assign RXLPMOSHOLD_in = RXLPMOSHOLD_delay;
  assign RXLPMOSOVRDEN_in = RXLPMOSOVRDEN_delay;
  assign RXMCOMMAALIGNEN_in = RXMCOMMAALIGNEN_delay;
  assign RXMONITORSEL_in = RXMONITORSEL_delay;
  assign RXOOBRESET_in = RXOOBRESET_delay;
  assign RXOSCALRESET_in = RXOSCALRESET_delay;
  assign RXOSHOLD_in = RXOSHOLD_delay;
  assign RXOSINTCFG_in = RXOSINTCFG_delay;
  assign RXOSINTEN_in = RXOSINTEN_delay;
  assign RXOSINTHOLD_in = RXOSINTHOLD_delay;
  assign RXOSINTOVRDEN_in = RXOSINTOVRDEN_delay;
  assign RXOSINTSTROBE_in = RXOSINTSTROBE_delay;
  assign RXOSINTTESTOVRDEN_in = RXOSINTTESTOVRDEN_delay;
  assign RXOSOVRDEN_in = RXOSOVRDEN_delay;
  assign RXOUTCLKSEL_in = RXOUTCLKSEL_delay;
  assign RXPCOMMAALIGNEN_in = RXPCOMMAALIGNEN_delay;
  assign RXPCSRESET_in = RXPCSRESET_delay;
  assign RXPD_in = RXPD_delay;
  assign RXPHALIGNEN_in = RXPHALIGNEN_delay;
  assign RXPHALIGN_in = RXPHALIGN_delay;
  assign RXPHDLYPD_in = RXPHDLYPD_delay;
  assign RXPHDLYRESET_in = RXPHDLYRESET_delay;
  assign RXPHOVRDEN_in = RXPHOVRDEN_delay;
  assign RXPLLCLKSEL_in = RXPLLCLKSEL_delay;
  assign RXPMARESET_in = RXPMARESET_delay;
  assign RXPOLARITY_in = RXPOLARITY_delay;
  assign RXPRBSCNTRESET_in = RXPRBSCNTRESET_delay;
  assign RXPRBSSEL_in = RXPRBSSEL_delay;
  assign RXPROGDIVRESET_in = RXPROGDIVRESET_delay;
  assign RXRATEMODE_in = RXRATEMODE_delay;
  assign RXRATE_in = RXRATE_delay;
  assign RXSLIDE_in = RXSLIDE_delay;
  assign RXSLIPOUTCLK_in = RXSLIPOUTCLK_delay;
  assign RXSLIPPMA_in = RXSLIPPMA_delay;
  assign RXSYNCALLIN_in = RXSYNCALLIN_delay;
  assign RXSYNCIN_in = RXSYNCIN_delay;
  assign RXSYNCMODE_in = RXSYNCMODE_delay;
  assign RXSYSCLKSEL_in = RXSYSCLKSEL_delay;
  assign RXUSERRDY_in = RXUSERRDY_delay;
  assign RXUSRCLK2_in = RXUSRCLK2_delay;
  assign RXUSRCLK_in = RXUSRCLK_delay;
  assign SIGVALIDCLK_in = SIGVALIDCLK_delay;
  assign TSTIN_in = TSTIN_delay;
  assign TX8B10BBYPASS_in = TX8B10BBYPASS_delay;
  assign TX8B10BEN_in = TX8B10BEN_delay;
  assign TXBUFDIFFCTRL_in = TXBUFDIFFCTRL_delay;
  assign TXCOMINIT_in = TXCOMINIT_delay;
  assign TXCOMSAS_in = TXCOMSAS_delay;
  assign TXCOMWAKE_in = TXCOMWAKE_delay;
  assign TXCTRL0_in = TXCTRL0_delay;
  assign TXCTRL1_in = TXCTRL1_delay;
  assign TXCTRL2_in = TXCTRL2_delay;
  assign TXDATAEXTENDRSVD_in = TXDATAEXTENDRSVD_delay;
  assign TXDATA_in = TXDATA_delay;
  assign TXDCCFORCESTART_in = TXDCCFORCESTART_delay;
  assign TXDCCRESET_in = TXDCCRESET_delay;
  assign TXDEEMPH_in = TXDEEMPH_delay;
  assign TXDETECTRX_in = TXDETECTRX_delay;
  assign TXDIFFCTRL_in = TXDIFFCTRL_delay;
  assign TXDIFFPD_in = TXDIFFPD_delay;
  assign TXDLYBYPASS_in = TXDLYBYPASS_delay;
  assign TXDLYEN_in = TXDLYEN_delay;
  assign TXDLYHOLD_in = TXDLYHOLD_delay;
  assign TXDLYOVRDEN_in = TXDLYOVRDEN_delay;
  assign TXDLYSRESET_in = TXDLYSRESET_delay;
  assign TXDLYUPDOWN_in = TXDLYUPDOWN_delay;
  assign TXELECIDLE_in = TXELECIDLE_delay;
  assign TXELFORCESTART_in = TXELFORCESTART_delay;
  assign TXHEADER_in = TXHEADER_delay;
  assign TXINHIBIT_in = TXINHIBIT_delay;
  assign TXLATCLK_in = TXLATCLK_delay;
  assign TXMAINCURSOR_in = TXMAINCURSOR_delay;
  assign TXMARGIN_in = TXMARGIN_delay;
  assign TXOUTCLKSEL_in = TXOUTCLKSEL_delay;
  assign TXPCSRESET_in = TXPCSRESET_delay;
  assign TXPDELECIDLEMODE_in = TXPDELECIDLEMODE_delay;
  assign TXPD_in = TXPD_delay;
  assign TXPHALIGNEN_in = TXPHALIGNEN_delay;
  assign TXPHALIGN_in = TXPHALIGN_delay;
  assign TXPHDLYPD_in = TXPHDLYPD_delay;
  assign TXPHDLYRESET_in = TXPHDLYRESET_delay;
  assign TXPHDLYTSTCLK_in = TXPHDLYTSTCLK_delay;
  assign TXPHINIT_in = TXPHINIT_delay;
  assign TXPHOVRDEN_in = TXPHOVRDEN_delay;
  assign TXPIPPMEN_in = TXPIPPMEN_delay;
  assign TXPIPPMOVRDEN_in = TXPIPPMOVRDEN_delay;
  assign TXPIPPMPD_in = TXPIPPMPD_delay;
  assign TXPIPPMSEL_in = TXPIPPMSEL_delay;
  assign TXPIPPMSTEPSIZE_in = TXPIPPMSTEPSIZE_delay;
  assign TXPISOPD_in = TXPISOPD_delay;
  assign TXPLLCLKSEL_in = TXPLLCLKSEL_delay;
  assign TXPMARESET_in = TXPMARESET_delay;
  assign TXPOLARITY_in = TXPOLARITY_delay;
  assign TXPOSTCURSOR_in = TXPOSTCURSOR_delay;
  assign TXPRBSFORCEERR_in = TXPRBSFORCEERR_delay;
  assign TXPRBSSEL_in = TXPRBSSEL_delay;
  assign TXPRECURSOR_in = TXPRECURSOR_delay;
  assign TXPROGDIVRESET_in = TXPROGDIVRESET_delay;
  assign TXRATEMODE_in = TXRATEMODE_delay;
  assign TXRATE_in = TXRATE_delay;
  assign TXSEQUENCE_in = TXSEQUENCE_delay;
  assign TXSWING_in = TXSWING_delay;
  assign TXSYNCALLIN_in = TXSYNCALLIN_delay;
  assign TXSYNCIN_in = TXSYNCIN_delay;
  assign TXSYNCMODE_in = TXSYNCMODE_delay;
  assign TXSYSCLKSEL_in = TXSYSCLKSEL_delay;
  assign TXUSERRDY_in = TXUSERRDY_delay;
  assign TXUSRCLK2_in = TXUSRCLK2_delay;
  assign TXUSRCLK_in = TXUSRCLK_delay;


  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
    #1;
  if ((ACJTAG_DEBUG_MODE_REG < 1'b0) || (ACJTAG_DEBUG_MODE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute ACJTAG_DEBUG_MODE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, ACJTAG_DEBUG_MODE_REG);
      attr_err = 1'b1;
    end

  if ((ACJTAG_MODE_REG < 1'b0) || (ACJTAG_MODE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute ACJTAG_MODE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, ACJTAG_MODE_REG);
      attr_err = 1'b1;
    end

  if ((ACJTAG_RESET_REG < 1'b0) || (ACJTAG_RESET_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute ACJTAG_RESET on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, ACJTAG_RESET_REG);
      attr_err = 1'b1;
    end

  if ((ADAPT_CFG2_REG < 16'b0000000000000000) || (ADAPT_CFG2_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute ADAPT_CFG2 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, ADAPT_CFG2_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_COMMA_DOUBLE_REG != "FALSE") &&
        (ALIGN_COMMA_DOUBLE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute ALIGN_COMMA_DOUBLE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, ALIGN_COMMA_DOUBLE_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_COMMA_ENABLE_REG < 10'b0000000000) || (ALIGN_COMMA_ENABLE_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute ALIGN_COMMA_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, ALIGN_COMMA_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_COMMA_WORD_REG != 1) &&
        (ALIGN_COMMA_WORD_REG != 2) &&
        (ALIGN_COMMA_WORD_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute ALIGN_COMMA_WORD on %s instance %m is set to %d.  Legal values for this attribute are 1 to 4.", MODULE_NAME, ALIGN_COMMA_WORD_REG, 1);
      attr_err = 1'b1;
    end

  if ((ALIGN_MCOMMA_DET_REG != "TRUE") &&
        (ALIGN_MCOMMA_DET_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute ALIGN_MCOMMA_DET on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, ALIGN_MCOMMA_DET_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_MCOMMA_VALUE_REG < 10'b0000000000) || (ALIGN_MCOMMA_VALUE_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute ALIGN_MCOMMA_VALUE on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, ALIGN_MCOMMA_VALUE_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_PCOMMA_DET_REG != "TRUE") &&
        (ALIGN_PCOMMA_DET_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute ALIGN_PCOMMA_DET on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, ALIGN_PCOMMA_DET_REG);
      attr_err = 1'b1;
    end

  if ((ALIGN_PCOMMA_VALUE_REG < 10'b0000000000) || (ALIGN_PCOMMA_VALUE_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute ALIGN_PCOMMA_VALUE on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, ALIGN_PCOMMA_VALUE_REG);
      attr_err = 1'b1;
    end

  if ((AUTO_BW_SEL_BYPASS_REG < 1'b0) || (AUTO_BW_SEL_BYPASS_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute AUTO_BW_SEL_BYPASS on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, AUTO_BW_SEL_BYPASS_REG);
      attr_err = 1'b1;
    end

  if ((A_RXOSCALRESET_REG < 1'b0) || (A_RXOSCALRESET_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute A_RXOSCALRESET on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, A_RXOSCALRESET_REG);
      attr_err = 1'b1;
    end

  if ((A_RXPROGDIVRESET_REG < 1'b0) || (A_RXPROGDIVRESET_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute A_RXPROGDIVRESET on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, A_RXPROGDIVRESET_REG);
      attr_err = 1'b1;
    end

  if ((A_TXDIFFCTRL_REG < 5'b00000) || (A_TXDIFFCTRL_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute A_TXDIFFCTRL on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, A_TXDIFFCTRL_REG);
      attr_err = 1'b1;
    end

  if ((A_TXPROGDIVRESET_REG < 1'b0) || (A_TXPROGDIVRESET_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute A_TXPROGDIVRESET on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, A_TXPROGDIVRESET_REG);
      attr_err = 1'b1;
    end

  if ((CAPBYPASS_FORCE_REG < 1'b0) || (CAPBYPASS_FORCE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute CAPBYPASS_FORCE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, CAPBYPASS_FORCE_REG);
      attr_err = 1'b1;
    end

  if ((CBCC_DATA_SOURCE_SEL_REG != "DECODED") &&
        (CBCC_DATA_SOURCE_SEL_REG != "ENCODED")) begin
      $display("Attribute Syntax Error : The attribute CBCC_DATA_SOURCE_SEL on %s instance %m is set to %s.  Legal values for this attribute are DECODED or ENCODED.", MODULE_NAME, CBCC_DATA_SOURCE_SEL_REG);
      attr_err = 1'b1;
    end

  if ((CDR_SWAP_MODE_EN_REG < 1'b0) || (CDR_SWAP_MODE_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute CDR_SWAP_MODE_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, CDR_SWAP_MODE_EN_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_KEEP_ALIGN_REG != "FALSE") &&
        (CHAN_BOND_KEEP_ALIGN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_KEEP_ALIGN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, CHAN_BOND_KEEP_ALIGN_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_MAX_SKEW_REG != 7) &&
        (CHAN_BOND_MAX_SKEW_REG != 1) &&
        (CHAN_BOND_MAX_SKEW_REG != 2) &&
        (CHAN_BOND_MAX_SKEW_REG != 3) &&
        (CHAN_BOND_MAX_SKEW_REG != 4) &&
        (CHAN_BOND_MAX_SKEW_REG != 5) &&
        (CHAN_BOND_MAX_SKEW_REG != 6) &&
        (CHAN_BOND_MAX_SKEW_REG != 8) &&
        (CHAN_BOND_MAX_SKEW_REG != 9) &&
        (CHAN_BOND_MAX_SKEW_REG != 10) &&
        (CHAN_BOND_MAX_SKEW_REG != 11) &&
        (CHAN_BOND_MAX_SKEW_REG != 12) &&
        (CHAN_BOND_MAX_SKEW_REG != 13) &&
        (CHAN_BOND_MAX_SKEW_REG != 14)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_MAX_SKEW on %s instance %m is set to %d.  Legal values for this attribute are 1 to 14.", MODULE_NAME, CHAN_BOND_MAX_SKEW_REG, 7);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_1_1_REG < 10'b0000000000) || (CHAN_BOND_SEQ_1_1_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_1_1 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_1_1_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_1_2_REG < 10'b0000000000) || (CHAN_BOND_SEQ_1_2_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_1_2 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_1_2_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_1_3_REG < 10'b0000000000) || (CHAN_BOND_SEQ_1_3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_1_3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_1_3_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_1_4_REG < 10'b0000000000) || (CHAN_BOND_SEQ_1_4_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_1_4 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_1_4_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_1_ENABLE_REG < 4'b0000) || (CHAN_BOND_SEQ_1_ENABLE_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_1_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, CHAN_BOND_SEQ_1_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_1_REG < 10'b0000000000) || (CHAN_BOND_SEQ_2_1_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_1 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_2_1_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_2_REG < 10'b0000000000) || (CHAN_BOND_SEQ_2_2_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_2 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_2_2_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_3_REG < 10'b0000000000) || (CHAN_BOND_SEQ_2_3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_2_3_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_4_REG < 10'b0000000000) || (CHAN_BOND_SEQ_2_4_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_4 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CHAN_BOND_SEQ_2_4_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_ENABLE_REG < 4'b0000) || (CHAN_BOND_SEQ_2_ENABLE_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, CHAN_BOND_SEQ_2_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_2_USE_REG != "FALSE") &&
        (CHAN_BOND_SEQ_2_USE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_2_USE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, CHAN_BOND_SEQ_2_USE_REG);
      attr_err = 1'b1;
    end

  if ((CHAN_BOND_SEQ_LEN_REG != 2) &&
        (CHAN_BOND_SEQ_LEN_REG != 1) &&
        (CHAN_BOND_SEQ_LEN_REG != 3) &&
        (CHAN_BOND_SEQ_LEN_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute CHAN_BOND_SEQ_LEN on %s instance %m is set to %d.  Legal values for this attribute are 1 to 4.", MODULE_NAME, CHAN_BOND_SEQ_LEN_REG, 2);
      attr_err = 1'b1;
    end

  if ((CH_HSPMUX_REG < 16'b0000000000000000) || (CH_HSPMUX_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CH_HSPMUX on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CH_HSPMUX_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL1_CFG_0_REG < 16'b0000000000000000) || (CKCAL1_CFG_0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL1_CFG_0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL1_CFG_0_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL1_CFG_1_REG < 16'b0000000000000000) || (CKCAL1_CFG_1_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL1_CFG_1 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL1_CFG_1_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL1_CFG_2_REG < 16'b0000000000000000) || (CKCAL1_CFG_2_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL1_CFG_2 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL1_CFG_2_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL1_CFG_3_REG < 16'b0000000000000000) || (CKCAL1_CFG_3_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL1_CFG_3 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL1_CFG_3_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL2_CFG_0_REG < 16'b0000000000000000) || (CKCAL2_CFG_0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL2_CFG_0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL2_CFG_0_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL2_CFG_1_REG < 16'b0000000000000000) || (CKCAL2_CFG_1_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL2_CFG_1 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL2_CFG_1_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL2_CFG_2_REG < 16'b0000000000000000) || (CKCAL2_CFG_2_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL2_CFG_2 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL2_CFG_2_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL2_CFG_3_REG < 16'b0000000000000000) || (CKCAL2_CFG_3_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL2_CFG_3 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL2_CFG_3_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL2_CFG_4_REG < 16'b0000000000000000) || (CKCAL2_CFG_4_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL2_CFG_4 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL2_CFG_4_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL_RSVD0_REG < 16'b0000000000000000) || (CKCAL_RSVD0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL_RSVD0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL_RSVD0_REG);
      attr_err = 1'b1;
    end

  if ((CKCAL_RSVD1_REG < 16'b0000000000000000) || (CKCAL_RSVD1_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute CKCAL_RSVD1 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, CKCAL_RSVD1_REG);
      attr_err = 1'b1;
    end

  if ((CLK_CORRECT_USE_REG != "TRUE") &&
        (CLK_CORRECT_USE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute CLK_CORRECT_USE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, CLK_CORRECT_USE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_KEEP_IDLE_REG != "FALSE") &&
        (CLK_COR_KEEP_IDLE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_KEEP_IDLE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, CLK_COR_KEEP_IDLE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_MAX_LAT_REG < 3) || (CLK_COR_MAX_LAT_REG > 60)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_MAX_LAT on %s instance %m is set to %d.  Legal values for this attribute are  3 to 60.", MODULE_NAME, CLK_COR_MAX_LAT_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_MIN_LAT_REG < 3) || (CLK_COR_MIN_LAT_REG > 63)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_MIN_LAT on %s instance %m is set to %d.  Legal values for this attribute are  3 to 63.", MODULE_NAME, CLK_COR_MIN_LAT_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_PRECEDENCE_REG != "TRUE") &&
        (CLK_COR_PRECEDENCE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_PRECEDENCE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, CLK_COR_PRECEDENCE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_REPEAT_WAIT_REG < 0) || (CLK_COR_REPEAT_WAIT_REG > 31)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_REPEAT_WAIT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 31.", MODULE_NAME, CLK_COR_REPEAT_WAIT_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_1_1_REG < 10'b0000000000) || (CLK_COR_SEQ_1_1_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_1_1 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_1_1_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_1_2_REG < 10'b0000000000) || (CLK_COR_SEQ_1_2_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_1_2 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_1_2_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_1_3_REG < 10'b0000000000) || (CLK_COR_SEQ_1_3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_1_3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_1_3_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_1_4_REG < 10'b0000000000) || (CLK_COR_SEQ_1_4_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_1_4 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_1_4_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_1_ENABLE_REG < 4'b0000) || (CLK_COR_SEQ_1_ENABLE_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_1_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, CLK_COR_SEQ_1_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_1_REG < 10'b0000000000) || (CLK_COR_SEQ_2_1_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_1 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_2_1_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_2_REG < 10'b0000000000) || (CLK_COR_SEQ_2_2_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_2 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_2_2_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_3_REG < 10'b0000000000) || (CLK_COR_SEQ_2_3_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_3 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_2_3_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_4_REG < 10'b0000000000) || (CLK_COR_SEQ_2_4_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_4 on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, CLK_COR_SEQ_2_4_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_ENABLE_REG < 4'b0000) || (CLK_COR_SEQ_2_ENABLE_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, CLK_COR_SEQ_2_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_2_USE_REG != "FALSE") &&
        (CLK_COR_SEQ_2_USE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_2_USE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, CLK_COR_SEQ_2_USE_REG);
      attr_err = 1'b1;
    end

  if ((CLK_COR_SEQ_LEN_REG != 2) &&
        (CLK_COR_SEQ_LEN_REG != 1) &&
        (CLK_COR_SEQ_LEN_REG != 3) &&
        (CLK_COR_SEQ_LEN_REG != 4)) begin
      $display("Attribute Syntax Error : The attribute CLK_COR_SEQ_LEN on %s instance %m is set to %d.  Legal values for this attribute are 1 to 4.", MODULE_NAME, CLK_COR_SEQ_LEN_REG, 2);
      attr_err = 1'b1;
    end

  if ((CPLL_FBDIV_45_REG != 4) &&
        (CPLL_FBDIV_45_REG != 5)) begin
      $display("Attribute Syntax Error : The attribute CPLL_FBDIV_45 on %s instance %m is set to %d.  Legal values for this attribute are 4 to 5.", MODULE_NAME, CPLL_FBDIV_45_REG, 4);
      attr_err = 1'b1;
    end

  if ((CPLL_FBDIV_REG != 4) &&
        (CPLL_FBDIV_REG != 1) &&
        (CPLL_FBDIV_REG != 2) &&
        (CPLL_FBDIV_REG != 3) &&
        (CPLL_FBDIV_REG != 5) &&
        (CPLL_FBDIV_REG != 6) &&
        (CPLL_FBDIV_REG != 8) &&
        (CPLL_FBDIV_REG != 10) &&
        (CPLL_FBDIV_REG != 12) &&
        (CPLL_FBDIV_REG != 16) &&
        (CPLL_FBDIV_REG != 20)) begin
      $display("Attribute Syntax Error : The attribute CPLL_FBDIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 20.", MODULE_NAME, CPLL_FBDIV_REG, 4);
      attr_err = 1'b1;
    end

  if ((CPLL_REFCLK_DIV_REG != 1) &&
        (CPLL_REFCLK_DIV_REG != 2) &&
        (CPLL_REFCLK_DIV_REG != 3) &&
        (CPLL_REFCLK_DIV_REG != 4) &&
        (CPLL_REFCLK_DIV_REG != 5) &&
        (CPLL_REFCLK_DIV_REG != 6) &&
        (CPLL_REFCLK_DIV_REG != 8) &&
        (CPLL_REFCLK_DIV_REG != 10) &&
        (CPLL_REFCLK_DIV_REG != 12) &&
        (CPLL_REFCLK_DIV_REG != 16) &&
        (CPLL_REFCLK_DIV_REG != 20)) begin
      $display("Attribute Syntax Error : The attribute CPLL_REFCLK_DIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 20.", MODULE_NAME, CPLL_REFCLK_DIV_REG, 1);
      attr_err = 1'b1;
    end

  if ((CTLE3_OCAP_EXT_CTRL_REG < 3'b000) || (CTLE3_OCAP_EXT_CTRL_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute CTLE3_OCAP_EXT_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, CTLE3_OCAP_EXT_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((CTLE3_OCAP_EXT_EN_REG < 1'b0) || (CTLE3_OCAP_EXT_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute CTLE3_OCAP_EXT_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, CTLE3_OCAP_EXT_EN_REG);
      attr_err = 1'b1;
    end

  if ((DDI_CTRL_REG < 2'b00) || (DDI_CTRL_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute DDI_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, DDI_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((DDI_REALIGN_WAIT_REG < 0) || (DDI_REALIGN_WAIT_REG > 31)) begin
      $display("Attribute Syntax Error : The attribute DDI_REALIGN_WAIT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 31.", MODULE_NAME, DDI_REALIGN_WAIT_REG);
      attr_err = 1'b1;
    end

  if ((DEC_MCOMMA_DETECT_REG != "TRUE") &&
        (DEC_MCOMMA_DETECT_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute DEC_MCOMMA_DETECT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DEC_MCOMMA_DETECT_REG);
      attr_err = 1'b1;
    end

  if ((DEC_PCOMMA_DETECT_REG != "TRUE") &&
        (DEC_PCOMMA_DETECT_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute DEC_PCOMMA_DETECT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DEC_PCOMMA_DETECT_REG);
      attr_err = 1'b1;
    end

  if ((DEC_VALID_COMMA_ONLY_REG != "TRUE") &&
        (DEC_VALID_COMMA_ONLY_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute DEC_VALID_COMMA_ONLY on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DEC_VALID_COMMA_ONLY_REG);
      attr_err = 1'b1;
    end

  if ((DFE_D_X_REL_POS_REG < 1'b0) || (DFE_D_X_REL_POS_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute DFE_D_X_REL_POS on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, DFE_D_X_REL_POS_REG);
      attr_err = 1'b1;
    end

  if ((DFE_VCM_COMP_EN_REG < 1'b0) || (DFE_VCM_COMP_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute DFE_VCM_COMP_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, DFE_VCM_COMP_EN_REG);
      attr_err = 1'b1;
    end

  if ((ES_CLK_PHASE_SEL_REG < 1'b0) || (ES_CLK_PHASE_SEL_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute ES_CLK_PHASE_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, ES_CLK_PHASE_SEL_REG);
      attr_err = 1'b1;
    end

  if ((ES_CONTROL_REG < 6'b000000) || (ES_CONTROL_REG > 6'b111111)) begin
      $display("Attribute Syntax Error : The attribute ES_CONTROL on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, ES_CONTROL_REG);
      attr_err = 1'b1;
    end

  if ((ES_ERRDET_EN_REG != "FALSE") &&
        (ES_ERRDET_EN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute ES_ERRDET_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, ES_ERRDET_EN_REG);
      attr_err = 1'b1;
    end

  if ((ES_EYE_SCAN_EN_REG != "FALSE") &&
        (ES_EYE_SCAN_EN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute ES_EYE_SCAN_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, ES_EYE_SCAN_EN_REG);
      attr_err = 1'b1;
    end

  if ((ES_PMA_CFG_REG < 10'b0000000000) || (ES_PMA_CFG_REG > 10'b1111111111)) begin
      $display("Attribute Syntax Error : The attribute ES_PMA_CFG on %s instance %m is set to %b.  Legal values for this attribute are 10'b0000000000 to 10'b1111111111.", MODULE_NAME, ES_PMA_CFG_REG);
      attr_err = 1'b1;
    end

  if ((ES_PRESCALE_REG < 5'b00000) || (ES_PRESCALE_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute ES_PRESCALE on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, ES_PRESCALE_REG);
      attr_err = 1'b1;
    end

  if ((EVODD_PHI_CFG_REG < 11'b00000000000) || (EVODD_PHI_CFG_REG > 11'b11111111111)) begin
      $display("Attribute Syntax Error : The attribute EVODD_PHI_CFG on %s instance %m is set to %b.  Legal values for this attribute are 11'b00000000000 to 11'b11111111111.", MODULE_NAME, EVODD_PHI_CFG_REG);
      attr_err = 1'b1;
    end

  if ((EYE_SCAN_SWAP_EN_REG < 1'b0) || (EYE_SCAN_SWAP_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute EYE_SCAN_SWAP_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, EYE_SCAN_SWAP_EN_REG);
      attr_err = 1'b1;
    end

  if ((FTS_DESKEW_SEQ_ENABLE_REG < 4'b0000) || (FTS_DESKEW_SEQ_ENABLE_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute FTS_DESKEW_SEQ_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, FTS_DESKEW_SEQ_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((FTS_LANE_DESKEW_CFG_REG < 4'b0000) || (FTS_LANE_DESKEW_CFG_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute FTS_LANE_DESKEW_CFG on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, FTS_LANE_DESKEW_CFG_REG);
      attr_err = 1'b1;
    end

  if ((FTS_LANE_DESKEW_EN_REG != "FALSE") &&
        (FTS_LANE_DESKEW_EN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute FTS_LANE_DESKEW_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, FTS_LANE_DESKEW_EN_REG);
      attr_err = 1'b1;
    end

  if ((GEARBOX_MODE_REG < 5'b00000) || (GEARBOX_MODE_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute GEARBOX_MODE on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, GEARBOX_MODE_REG);
      attr_err = 1'b1;
    end

  if ((GM_BIAS_SELECT_REG < 1'b0) || (GM_BIAS_SELECT_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute GM_BIAS_SELECT on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, GM_BIAS_SELECT_REG);
      attr_err = 1'b1;
    end

  if ((ISCAN_CK_PH_SEL2_REG < 1'b0) || (ISCAN_CK_PH_SEL2_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute ISCAN_CK_PH_SEL2 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, ISCAN_CK_PH_SEL2_REG);
      attr_err = 1'b1;
    end

  if ((LOCAL_MASTER_REG < 1'b0) || (LOCAL_MASTER_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute LOCAL_MASTER on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, LOCAL_MASTER_REG);
      attr_err = 1'b1;
    end

  if ((LPBK_BIAS_CTRL_REG < 3'b000) || (LPBK_BIAS_CTRL_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute LPBK_BIAS_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, LPBK_BIAS_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((LPBK_EN_RCAL_B_REG < 1'b0) || (LPBK_EN_RCAL_B_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute LPBK_EN_RCAL_B on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, LPBK_EN_RCAL_B_REG);
      attr_err = 1'b1;
    end

  if ((LPBK_EXT_RCAL_REG < 4'b0000) || (LPBK_EXT_RCAL_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute LPBK_EXT_RCAL on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, LPBK_EXT_RCAL_REG);
      attr_err = 1'b1;
    end

  if ((LPBK_RG_CTRL_REG < 4'b0000) || (LPBK_RG_CTRL_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute LPBK_RG_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, LPBK_RG_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((OOBDIVCTL_REG < 2'b00) || (OOBDIVCTL_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute OOBDIVCTL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, OOBDIVCTL_REG);
      attr_err = 1'b1;
    end

  if ((OOB_PWRUP_REG < 1'b0) || (OOB_PWRUP_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute OOB_PWRUP on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, OOB_PWRUP_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_AUTO_REALIGN_REG != "FRST_SMPL") &&
        (PCI3_AUTO_REALIGN_REG != "OVR_1K_BLK") &&
        (PCI3_AUTO_REALIGN_REG != "OVR_8_BLK") &&
        (PCI3_AUTO_REALIGN_REG != "OVR_64_BLK")) begin
      $display("Attribute Syntax Error : The attribute PCI3_AUTO_REALIGN on %s instance %m is set to %s.  Legal values for this attribute are FRST_SMPL, OVR_1K_BLK, OVR_8_BLK or OVR_64_BLK.", MODULE_NAME, PCI3_AUTO_REALIGN_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_PIPE_RX_ELECIDLE_REG < 1'b0) || (PCI3_PIPE_RX_ELECIDLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute PCI3_PIPE_RX_ELECIDLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, PCI3_PIPE_RX_ELECIDLE_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ASYNC_EBUF_BYPASS_REG < 2'b00) || (PCI3_RX_ASYNC_EBUF_BYPASS_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ASYNC_EBUF_BYPASS on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, PCI3_RX_ASYNC_EBUF_BYPASS_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ELECIDLE_EI2_ENABLE_REG < 1'b0) || (PCI3_RX_ELECIDLE_EI2_ENABLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ELECIDLE_EI2_ENABLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, PCI3_RX_ELECIDLE_EI2_ENABLE_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ELECIDLE_H2L_COUNT_REG < 6'b000000) || (PCI3_RX_ELECIDLE_H2L_COUNT_REG > 6'b111111)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ELECIDLE_H2L_COUNT on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, PCI3_RX_ELECIDLE_H2L_COUNT_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ELECIDLE_H2L_DISABLE_REG < 3'b000) || (PCI3_RX_ELECIDLE_H2L_DISABLE_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ELECIDLE_H2L_DISABLE on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, PCI3_RX_ELECIDLE_H2L_DISABLE_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ELECIDLE_HI_COUNT_REG < 6'b000000) || (PCI3_RX_ELECIDLE_HI_COUNT_REG > 6'b111111)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ELECIDLE_HI_COUNT on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, PCI3_RX_ELECIDLE_HI_COUNT_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_ELECIDLE_LP4_DISABLE_REG < 1'b0) || (PCI3_RX_ELECIDLE_LP4_DISABLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_ELECIDLE_LP4_DISABLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, PCI3_RX_ELECIDLE_LP4_DISABLE_REG);
      attr_err = 1'b1;
    end

  if ((PCI3_RX_FIFO_DISABLE_REG < 1'b0) || (PCI3_RX_FIFO_DISABLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute PCI3_RX_FIFO_DISABLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, PCI3_RX_FIFO_DISABLE_REG);
      attr_err = 1'b1;
    end

  if ((PCS_PCIE_EN_REG != "FALSE") &&
        (PCS_PCIE_EN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute PCS_PCIE_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, PCS_PCIE_EN_REG);
      attr_err = 1'b1;
    end

  if ((PCS_RSVD0_REG < 16'b0000000000000000) || (PCS_RSVD0_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute PCS_RSVD0 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, PCS_RSVD0_REG);
      attr_err = 1'b1;
    end

  if ((PCS_RSVD1_REG < 3'b000) || (PCS_RSVD1_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute PCS_RSVD1 on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, PCS_RSVD1_REG);
      attr_err = 1'b1;
    end

  if ((PREIQ_FREQ_BST_REG < 2'b00) || (PREIQ_FREQ_BST_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute PREIQ_FREQ_BST on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, PREIQ_FREQ_BST_REG);
      attr_err = 1'b1;
    end

  if ((PROCESS_PAR_REG < 3'b000) || (PROCESS_PAR_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute PROCESS_PAR on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, PROCESS_PAR_REG);
      attr_err = 1'b1;
    end

  if ((RATE_SW_USE_DRP_REG < 1'b0) || (RATE_SW_USE_DRP_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RATE_SW_USE_DRP on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RATE_SW_USE_DRP_REG);
      attr_err = 1'b1;
    end

  if ((RESET_POWERSAVE_DISABLE_REG < 1'b0) || (RESET_POWERSAVE_DISABLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RESET_POWERSAVE_DISABLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RESET_POWERSAVE_DISABLE_REG);
      attr_err = 1'b1;
    end

  if ((RXBUFRESET_TIME_REG < 5'b00000) || (RXBUFRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXBUFRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXBUFRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_ADDR_MODE_REG != "FULL") &&
        (RXBUF_ADDR_MODE_REG != "FAST")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_ADDR_MODE on %s instance %m is set to %s.  Legal values for this attribute are FULL or FAST.", MODULE_NAME, RXBUF_ADDR_MODE_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_EIDLE_HI_CNT_REG < 4'b0000) || (RXBUF_EIDLE_HI_CNT_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute RXBUF_EIDLE_HI_CNT on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RXBUF_EIDLE_HI_CNT_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_EIDLE_LO_CNT_REG < 4'b0000) || (RXBUF_EIDLE_LO_CNT_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute RXBUF_EIDLE_LO_CNT on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RXBUF_EIDLE_LO_CNT_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_EN_REG != "TRUE") &&
        (RXBUF_EN_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_EN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, RXBUF_EN_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_RESET_ON_CB_CHANGE_REG != "TRUE") &&
        (RXBUF_RESET_ON_CB_CHANGE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_RESET_ON_CB_CHANGE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, RXBUF_RESET_ON_CB_CHANGE_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_RESET_ON_COMMAALIGN_REG != "FALSE") &&
        (RXBUF_RESET_ON_COMMAALIGN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_RESET_ON_COMMAALIGN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, RXBUF_RESET_ON_COMMAALIGN_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_RESET_ON_EIDLE_REG != "FALSE") &&
        (RXBUF_RESET_ON_EIDLE_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_RESET_ON_EIDLE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, RXBUF_RESET_ON_EIDLE_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_RESET_ON_RATE_CHANGE_REG != "TRUE") &&
        (RXBUF_RESET_ON_RATE_CHANGE_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_RESET_ON_RATE_CHANGE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, RXBUF_RESET_ON_RATE_CHANGE_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_THRESH_OVFLW_REG < 0) || (RXBUF_THRESH_OVFLW_REG > 63)) begin
      $display("Attribute Syntax Error : The attribute RXBUF_THRESH_OVFLW on %s instance %m is set to %d.  Legal values for this attribute are  0 to 63.", MODULE_NAME, RXBUF_THRESH_OVFLW_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_THRESH_OVRD_REG != "FALSE") &&
        (RXBUF_THRESH_OVRD_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute RXBUF_THRESH_OVRD on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, RXBUF_THRESH_OVRD_REG);
      attr_err = 1'b1;
    end

  if ((RXBUF_THRESH_UNDFLW_REG < 0) || (RXBUF_THRESH_UNDFLW_REG > 63)) begin
      $display("Attribute Syntax Error : The attribute RXBUF_THRESH_UNDFLW on %s instance %m is set to %d.  Legal values for this attribute are  0 to 63.", MODULE_NAME, RXBUF_THRESH_UNDFLW_REG);
      attr_err = 1'b1;
    end

  if ((RXCDRFREQRESET_TIME_REG < 5'b00000) || (RXCDRFREQRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXCDRFREQRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXCDRFREQRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXCDRPHRESET_TIME_REG < 5'b00000) || (RXCDRPHRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXCDRPHRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXCDRPHRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXCDR_FR_RESET_ON_EIDLE_REG < 1'b0) || (RXCDR_FR_RESET_ON_EIDLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXCDR_FR_RESET_ON_EIDLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXCDR_FR_RESET_ON_EIDLE_REG);
      attr_err = 1'b1;
    end

  if ((RXCDR_HOLD_DURING_EIDLE_REG < 1'b0) || (RXCDR_HOLD_DURING_EIDLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXCDR_HOLD_DURING_EIDLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXCDR_HOLD_DURING_EIDLE_REG);
      attr_err = 1'b1;
    end

  if ((RXCDR_LOCK_CFG3_REG < 16'b0000000000000000) || (RXCDR_LOCK_CFG3_REG > 16'b1111111111111111)) begin
      $display("Attribute Syntax Error : The attribute RXCDR_LOCK_CFG3 on %s instance %m is set to %b.  Legal values for this attribute are 16'b0000000000000000 to 16'b1111111111111111.", MODULE_NAME, RXCDR_LOCK_CFG3_REG);
      attr_err = 1'b1;
    end

  if ((RXCDR_PH_RESET_ON_EIDLE_REG < 1'b0) || (RXCDR_PH_RESET_ON_EIDLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXCDR_PH_RESET_ON_EIDLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXCDR_PH_RESET_ON_EIDLE_REG);
      attr_err = 1'b1;
    end

  if ((RXCFOKDONE_SRC_REG < 2'b00) || (RXCFOKDONE_SRC_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RXCFOKDONE_SRC on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RXCFOKDONE_SRC_REG);
      attr_err = 1'b1;
    end

  if ((RXDFELPMRESET_TIME_REG < 7'b0000000) || (RXDFELPMRESET_TIME_REG > 7'b1111111)) begin
      $display("Attribute Syntax Error : The attribute RXDFELPMRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, RXDFELPMRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXDFE_PWR_SAVING_REG < 1'b0) || (RXDFE_PWR_SAVING_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXDFE_PWR_SAVING on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXDFE_PWR_SAVING_REG);
      attr_err = 1'b1;
    end

  if ((RXELECIDLE_CFG_REG != "Sigcfg_4") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_1") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_2") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_3") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_6") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_8") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_12") &&
        (RXELECIDLE_CFG_REG != "Sigcfg_16")) begin
      $display("Attribute Syntax Error : The attribute RXELECIDLE_CFG on %s instance %m is set to %s.  Legal values for this attribute are Sigcfg_4, Sigcfg_1, Sigcfg_2, Sigcfg_3, Sigcfg_6, Sigcfg_8, Sigcfg_12 or Sigcfg_16.", MODULE_NAME, RXELECIDLE_CFG_REG);
      attr_err = 1'b1;
    end

  if ((RXGBOX_FIFO_INIT_RD_ADDR_REG != 4) &&
        (RXGBOX_FIFO_INIT_RD_ADDR_REG != 2) &&
        (RXGBOX_FIFO_INIT_RD_ADDR_REG != 3) &&
        (RXGBOX_FIFO_INIT_RD_ADDR_REG != 5)) begin
      $display("Attribute Syntax Error : The attribute RXGBOX_FIFO_INIT_RD_ADDR on %s instance %m is set to %d.  Legal values for this attribute are 2 to 5.", MODULE_NAME, RXGBOX_FIFO_INIT_RD_ADDR_REG, 4);
      attr_err = 1'b1;
    end

  if ((RXGEARBOX_EN_REG != "FALSE") &&
        (RXGEARBOX_EN_REG != "TRUE")) begin
      $display("Attribute Syntax Error : The attribute RXGEARBOX_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, RXGEARBOX_EN_REG);
      attr_err = 1'b1;
    end

  if ((RXISCANRESET_TIME_REG < 5'b00000) || (RXISCANRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXISCANRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXISCANRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXOOB_CFG_REG < 9'b000000000) || (RXOOB_CFG_REG > 9'b111111111)) begin
      $display("Attribute Syntax Error : The attribute RXOOB_CFG on %s instance %m is set to %b.  Legal values for this attribute are 9'b000000000 to 9'b111111111.", MODULE_NAME, RXOOB_CFG_REG);
      attr_err = 1'b1;
    end

  if ((RXOOB_CLK_CFG_REG != "PMA") &&
        (RXOOB_CLK_CFG_REG != "FABRIC")) begin
      $display("Attribute Syntax Error : The attribute RXOOB_CLK_CFG on %s instance %m is set to %s.  Legal values for this attribute are PMA or FABRIC.", MODULE_NAME, RXOOB_CLK_CFG_REG);
      attr_err = 1'b1;
    end

  if ((RXOSCALRESET_TIME_REG < 5'b00000) || (RXOSCALRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXOSCALRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXOSCALRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXOUT_DIV_REG != 4) &&
        (RXOUT_DIV_REG != 1) &&
        (RXOUT_DIV_REG != 2) &&
        (RXOUT_DIV_REG != 8) &&
        (RXOUT_DIV_REG != 16) &&
        (RXOUT_DIV_REG != 32)) begin
      $display("Attribute Syntax Error : The attribute RXOUT_DIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 32.", MODULE_NAME, RXOUT_DIV_REG, 4);
      attr_err = 1'b1;
    end

  if ((RXPCSRESET_TIME_REG < 5'b00000) || (RXPCSRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXPCSRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXPCSRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXPH_MONITOR_SEL_REG < 5'b00000) || (RXPH_MONITOR_SEL_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXPH_MONITOR_SEL on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXPH_MONITOR_SEL_REG);
      attr_err = 1'b1;
    end

  if ((RXPI_AUTO_BW_SEL_BYPASS_REG < 1'b0) || (RXPI_AUTO_BW_SEL_BYPASS_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXPI_AUTO_BW_SEL_BYPASS on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXPI_AUTO_BW_SEL_BYPASS_REG);
      attr_err = 1'b1;
    end

  if ((RXPI_LPM_REG < 1'b0) || (RXPI_LPM_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXPI_LPM on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXPI_LPM_REG);
      attr_err = 1'b1;
    end

  if ((RXPI_SEL_LC_REG < 2'b00) || (RXPI_SEL_LC_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RXPI_SEL_LC on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RXPI_SEL_LC_REG);
      attr_err = 1'b1;
    end

  if ((RXPI_STARTCODE_REG < 2'b00) || (RXPI_STARTCODE_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RXPI_STARTCODE on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RXPI_STARTCODE_REG);
      attr_err = 1'b1;
    end

  if ((RXPI_VREFSEL_REG < 1'b0) || (RXPI_VREFSEL_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXPI_VREFSEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXPI_VREFSEL_REG);
      attr_err = 1'b1;
    end

  if ((RXPMACLK_SEL_REG != "DATA") &&
        (RXPMACLK_SEL_REG != "CROSSING") &&
        (RXPMACLK_SEL_REG != "EYESCAN")) begin
      $display("Attribute Syntax Error : The attribute RXPMACLK_SEL on %s instance %m is set to %s.  Legal values for this attribute are DATA, CROSSING or EYESCAN.", MODULE_NAME, RXPMACLK_SEL_REG);
      attr_err = 1'b1;
    end

  if ((RXPMARESET_TIME_REG < 5'b00000) || (RXPMARESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RXPMARESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RXPMARESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RXPRBS_ERR_LOOPBACK_REG < 1'b0) || (RXPRBS_ERR_LOOPBACK_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXPRBS_ERR_LOOPBACK on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXPRBS_ERR_LOOPBACK_REG);
      attr_err = 1'b1;
    end

  if ((RXPRBS_LINKACQ_CNT_REG < 15) || (RXPRBS_LINKACQ_CNT_REG > 255)) begin
      $display("Attribute Syntax Error : The attribute RXPRBS_LINKACQ_CNT on %s instance %m is set to %d.  Legal values for this attribute are  15 to 255.", MODULE_NAME, RXPRBS_LINKACQ_CNT_REG);
      attr_err = 1'b1;
    end

  if ((RXSLIDE_AUTO_WAIT_REG != 7) &&
        (RXSLIDE_AUTO_WAIT_REG != 1) &&
        (RXSLIDE_AUTO_WAIT_REG != 2) &&
        (RXSLIDE_AUTO_WAIT_REG != 3) &&
        (RXSLIDE_AUTO_WAIT_REG != 4) &&
        (RXSLIDE_AUTO_WAIT_REG != 5) &&
        (RXSLIDE_AUTO_WAIT_REG != 6) &&
        (RXSLIDE_AUTO_WAIT_REG != 8) &&
        (RXSLIDE_AUTO_WAIT_REG != 9) &&
        (RXSLIDE_AUTO_WAIT_REG != 10) &&
        (RXSLIDE_AUTO_WAIT_REG != 11) &&
        (RXSLIDE_AUTO_WAIT_REG != 12) &&
        (RXSLIDE_AUTO_WAIT_REG != 13) &&
        (RXSLIDE_AUTO_WAIT_REG != 14) &&
        (RXSLIDE_AUTO_WAIT_REG != 15)) begin
      $display("Attribute Syntax Error : The attribute RXSLIDE_AUTO_WAIT on %s instance %m is set to %d.  Legal values for this attribute are 1 to 15.", MODULE_NAME, RXSLIDE_AUTO_WAIT_REG, 7);
      attr_err = 1'b1;
    end

  if ((RXSLIDE_MODE_REG != "OFF") &&
        (RXSLIDE_MODE_REG != "AUTO") &&
        (RXSLIDE_MODE_REG != "PCS") &&
        (RXSLIDE_MODE_REG != "PMA")) begin
      $display("Attribute Syntax Error : The attribute RXSLIDE_MODE on %s instance %m is set to %s.  Legal values for this attribute are OFF, AUTO, PCS or PMA.", MODULE_NAME, RXSLIDE_MODE_REG);
      attr_err = 1'b1;
    end

  if ((RXSYNC_MULTILANE_REG < 1'b0) || (RXSYNC_MULTILANE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXSYNC_MULTILANE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXSYNC_MULTILANE_REG);
      attr_err = 1'b1;
    end

  if ((RXSYNC_OVRD_REG < 1'b0) || (RXSYNC_OVRD_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXSYNC_OVRD on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXSYNC_OVRD_REG);
      attr_err = 1'b1;
    end

  if ((RXSYNC_SKIP_DA_REG < 1'b0) || (RXSYNC_SKIP_DA_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RXSYNC_SKIP_DA on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RXSYNC_SKIP_DA_REG);
      attr_err = 1'b1;
    end

  if ((RX_AFE_CM_EN_REG < 1'b0) || (RX_AFE_CM_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_AFE_CM_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_AFE_CM_EN_REG);
      attr_err = 1'b1;
    end

  if ((RX_BUFFER_CFG_REG < 6'b000000) || (RX_BUFFER_CFG_REG > 6'b111111)) begin
      $display("Attribute Syntax Error : The attribute RX_BUFFER_CFG on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, RX_BUFFER_CFG_REG);
      attr_err = 1'b1;
    end

  if ((RX_CAPFF_SARC_ENB_REG < 1'b0) || (RX_CAPFF_SARC_ENB_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CAPFF_SARC_ENB on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CAPFF_SARC_ENB_REG);
      attr_err = 1'b1;
    end

  if ((RX_CLK25_DIV_REG < 1) || (RX_CLK25_DIV_REG > 32)) begin
      $display("Attribute Syntax Error : The attribute RX_CLK25_DIV on %s instance %m is set to %d.  Legal values for this attribute are  1 to 32.", MODULE_NAME, RX_CLK25_DIV_REG);
      attr_err = 1'b1;
    end

  if ((RX_CLKMUX_EN_REG < 1'b0) || (RX_CLKMUX_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CLKMUX_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CLKMUX_EN_REG);
      attr_err = 1'b1;
    end

  if ((RX_CLK_SLIP_OVRD_REG < 5'b00000) || (RX_CLK_SLIP_OVRD_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RX_CLK_SLIP_OVRD on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RX_CLK_SLIP_OVRD_REG);
      attr_err = 1'b1;
    end

  if ((RX_CM_BUF_CFG_REG < 4'b0000) || (RX_CM_BUF_CFG_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute RX_CM_BUF_CFG on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_CM_BUF_CFG_REG);
      attr_err = 1'b1;
    end

  if ((RX_CM_BUF_PD_REG < 1'b0) || (RX_CM_BUF_PD_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CM_BUF_PD on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CM_BUF_PD_REG);
      attr_err = 1'b1;
    end

  if ((RX_CM_SEL_REG < 2'b00) || (RX_CM_SEL_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RX_CM_SEL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_CM_SEL_REG);
      attr_err = 1'b1;
    end

  if ((RX_CM_TRIM_REG < 4'b0000) || (RX_CM_TRIM_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute RX_CM_TRIM on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_CM_TRIM_REG);
      attr_err = 1'b1;
    end

  if ((RX_CTLE1_KHKL_REG < 1'b0) || (RX_CTLE1_KHKL_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CTLE1_KHKL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CTLE1_KHKL_REG);
      attr_err = 1'b1;
    end

  if ((RX_CTLE2_KHKL_REG < 1'b0) || (RX_CTLE2_KHKL_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CTLE2_KHKL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CTLE2_KHKL_REG);
      attr_err = 1'b1;
    end

  if ((RX_CTLE3_AGC_REG < 1'b0) || (RX_CTLE3_AGC_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_CTLE3_AGC on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_CTLE3_AGC_REG);
      attr_err = 1'b1;
    end

  if ((RX_DATA_WIDTH_REG != 20) &&
        (RX_DATA_WIDTH_REG != 16) &&
        (RX_DATA_WIDTH_REG != 32) &&
        (RX_DATA_WIDTH_REG != 40) &&
        (RX_DATA_WIDTH_REG != 64) &&
        (RX_DATA_WIDTH_REG != 80) &&
        (RX_DATA_WIDTH_REG != 128) &&
        (RX_DATA_WIDTH_REG != 160)) begin
      $display("Attribute Syntax Error : The attribute RX_DATA_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 16 to 160.", MODULE_NAME, RX_DATA_WIDTH_REG, 20);
      attr_err = 1'b1;
    end

  if ((RX_DDI_SEL_REG < 6'b000000) || (RX_DDI_SEL_REG > 6'b111111)) begin
      $display("Attribute Syntax Error : The attribute RX_DDI_SEL on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, RX_DDI_SEL_REG);
      attr_err = 1'b1;
    end

  if ((RX_DEFER_RESET_BUF_EN_REG != "TRUE") &&
        (RX_DEFER_RESET_BUF_EN_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute RX_DEFER_RESET_BUF_EN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, RX_DEFER_RESET_BUF_EN_REG);
      attr_err = 1'b1;
    end

  if ((RX_DEGEN_CTRL_REG < 3'b000) || (RX_DEGEN_CTRL_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute RX_DEGEN_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_DEGEN_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFELPM_CFG0_REG < 4'b0000) || (RX_DFELPM_CFG0_REG > 4'b1111)) begin
      $display("Attribute Syntax Error : The attribute RX_DFELPM_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_DFELPM_CFG0_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFELPM_CFG1_REG < 1'b0) || (RX_DFELPM_CFG1_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_DFELPM_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_DFELPM_CFG1_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFELPM_KLKH_AGC_STUP_EN_REG < 1'b0) || (RX_DFELPM_KLKH_AGC_STUP_EN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_DFELPM_KLKH_AGC_STUP_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_DFELPM_KLKH_AGC_STUP_EN_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_AGC_CFG0_REG < 2'b00) || (RX_DFE_AGC_CFG0_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_AGC_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_DFE_AGC_CFG0_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_AGC_CFG1_REG < 3'b000) || (RX_DFE_AGC_CFG1_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_AGC_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_DFE_AGC_CFG1_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_KL_LPM_KH_CFG0_REG < 2'b00) || (RX_DFE_KL_LPM_KH_CFG0_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_KL_LPM_KH_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_DFE_KL_LPM_KH_CFG0_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_KL_LPM_KH_CFG1_REG < 3'b000) || (RX_DFE_KL_LPM_KH_CFG1_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_KL_LPM_KH_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_DFE_KL_LPM_KH_CFG1_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_KL_LPM_KL_CFG0_REG < 2'b00) || (RX_DFE_KL_LPM_KL_CFG0_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_KL_LPM_KL_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_DFE_KL_LPM_KL_CFG0_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_KL_LPM_KL_CFG1_REG < 3'b000) || (RX_DFE_KL_LPM_KL_CFG1_REG > 3'b111)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_KL_LPM_KL_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_DFE_KL_LPM_KL_CFG1_REG);
      attr_err = 1'b1;
    end

  if ((RX_DFE_LPM_HOLD_DURING_EIDLE_REG < 1'b0) || (RX_DFE_LPM_HOLD_DURING_EIDLE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_DFE_LPM_HOLD_DURING_EIDLE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_DFE_LPM_HOLD_DURING_EIDLE_REG);
      attr_err = 1'b1;
    end

  if ((RX_DISPERR_SEQ_MATCH_REG != "TRUE") &&
        (RX_DISPERR_SEQ_MATCH_REG != "FALSE")) begin
      $display("Attribute Syntax Error : The attribute RX_DISPERR_SEQ_MATCH on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, RX_DISPERR_SEQ_MATCH_REG);
      attr_err = 1'b1;
    end

  if ((RX_DIV2_MODE_B_REG < 1'b0) || (RX_DIV2_MODE_B_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_DIV2_MODE_B on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_DIV2_MODE_B_REG);
      attr_err = 1'b1;
    end

  if ((RX_DIVRESET_TIME_REG < 5'b00000) || (RX_DIVRESET_TIME_REG > 5'b11111)) begin
      $display("Attribute Syntax Error : The attribute RX_DIVRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, RX_DIVRESET_TIME_REG);
      attr_err = 1'b1;
    end

  if ((RX_EN_CTLE_RCAL_B_REG < 1'b0) || (RX_EN_CTLE_RCAL_B_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_EN_CTLE_RCAL_B on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_EN_CTLE_RCAL_B_REG);
      attr_err = 1'b1;
    end

  if ((RX_EN_HI_LR_REG < 1'b0) || (RX_EN_HI_LR_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_EN_HI_LR on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_EN_HI_LR_REG);
      attr_err = 1'b1;
    end

  if ((RX_EXT_RL_CTRL_REG < 9'b000000000) || (RX_EXT_RL_CTRL_REG > 9'b111111111)) begin
      $display("Attribute Syntax Error : The attribute RX_EXT_RL_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 9'b000000000 to 9'b111111111.", MODULE_NAME, RX_EXT_RL_CTRL_REG);
      attr_err = 1'b1;
    end

  if ((RX_EYESCAN_VS_CODE_REG < 7'b0000000) || (RX_EYESCAN_VS_CODE_REG > 7'b1111111)) begin
      $display("Attribute Syntax Error : The attribute RX_EYESCAN_VS_CODE on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, RX_EYESCAN_VS_CODE_REG);
      attr_err = 1'b1;
    end

  if ((RX_EYESCAN_VS_NEG_DIR_REG < 1'b0) || (RX_EYESCAN_VS_NEG_DIR_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_EYESCAN_VS_NEG_DIR on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_EYESCAN_VS_NEG_DIR_REG);
      attr_err = 1'b1;
    end

  if ((RX_EYESCAN_VS_RANGE_REG < 2'b00) || (RX_EYESCAN_VS_RANGE_REG > 2'b11)) begin
      $display("Attribute Syntax Error : The attribute RX_EYESCAN_VS_RANGE on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_EYESCAN_VS_RANGE_REG);
      attr_err = 1'b1;
    end

  if ((RX_EYESCAN_VS_UT_SIGN_REG < 1'b0) || (RX_EYESCAN_VS_UT_SIGN_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_EYESCAN_VS_UT_SIGN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_EYESCAN_VS_UT_SIGN_REG);
      attr_err = 1'b1;
    end

  if ((RX_FABINT_USRCLK_FLOP_REG < 1'b0) || (RX_FABINT_USRCLK_FLOP_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_FABINT_USRCLK_FLOP on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_FABINT_USRCLK_FLOP_REG);
      attr_err = 1'b1;
    end

  if ((RX_INT_DATAWIDTH_REG != 1) &&
        (RX_INT_DATAWIDTH_REG != 0) &&
        (RX_INT_DATAWIDTH_REG != 2)) begin
      $display("Attribute Syntax Error : The attribute RX_INT_DATAWIDTH on %s instance %m is set to %d.  Legal values for this attribute are 0 to 2.", MODULE_NAME, RX_INT_DATAWIDTH_REG, 1);
      attr_err = 1'b1;
    end

  if ((RX_PMA_POWER_SAVE_REG < 1'b0) || (RX_PMA_POWER_SAVE_REG > 1'b1)) begin
      $display("Attribute Syntax Error : The attribute RX_PMA_POWER_SAVE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_PMA_POWER_SAVE_REG);
      attr_err = 1'b1;
    end

  if ((RX_PROGDIV_CFG_REG/1000.0 != 0.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 4.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 5.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 8.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 10.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 16.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 16.5) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 20.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 32.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 33.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 40.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 64.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 66.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 80.0) &&
      (RX_PROGDIV_CFG_REG/1000.0 != 100.0)) begin
    $display("Attribute Syntax Error : The attribute RX_PROGDIV_CFG on %s instance %m is set to %f.  Legal values for this attribute are 0.0, 4.0, 5.0, 8.0, 10.0, 16.0, 16.5, 20.0, 32.0, 33.0, 40.0, 64.0, 66.0, 80.0 or 100.0.", MODULE_NAME, RX_PROGDIV_CFG_REG/1000.0);
    attr_err = 1'b1;
  end

  if ((RX_RESLOAD_CTRL_REG < 4'b0000) || (RX_RESLOAD_CTRL_REG > 4'b1111)) begin
    $display("Attribute Syntax Error : The attribute RX_RESLOAD_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_RESLOAD_CTRL_REG);
    attr_err = 1'b1;
  end

  if ((RX_RESLOAD_OVRD_REG < 1'b0) || (RX_RESLOAD_OVRD_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute RX_RESLOAD_OVRD on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_RESLOAD_OVRD_REG);
    attr_err = 1'b1;
  end

  if ((RX_SAMPLE_PERIOD_REG < 3'b000) || (RX_SAMPLE_PERIOD_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute RX_SAMPLE_PERIOD on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_SAMPLE_PERIOD_REG);
    attr_err = 1'b1;
  end

  if ((RX_SIG_VALID_DLY_REG < 1) || (RX_SIG_VALID_DLY_REG > 32)) begin
    $display("Attribute Syntax Error : The attribute RX_SIG_VALID_DLY on %s instance %m is set to %d.  Legal values for this attribute are  1 to 32.", MODULE_NAME, RX_SIG_VALID_DLY_REG);
    attr_err = 1'b1;
  end

  if ((RX_SUM_DFETAPREP_EN_REG < 1'b0) || (RX_SUM_DFETAPREP_EN_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute RX_SUM_DFETAPREP_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_SUM_DFETAPREP_EN_REG);
    attr_err = 1'b1;
  end

  if ((RX_SUM_IREF_TUNE_REG < 4'b0000) || (RX_SUM_IREF_TUNE_REG > 4'b1111)) begin
    $display("Attribute Syntax Error : The attribute RX_SUM_IREF_TUNE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_SUM_IREF_TUNE_REG);
    attr_err = 1'b1;
  end

  if ((RX_SUM_VCMTUNE_REG < 4'b0000) || (RX_SUM_VCMTUNE_REG > 4'b1111)) begin
    $display("Attribute Syntax Error : The attribute RX_SUM_VCMTUNE on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, RX_SUM_VCMTUNE_REG);
    attr_err = 1'b1;
  end

  if ((RX_SUM_VCM_OVWR_REG < 1'b0) || (RX_SUM_VCM_OVWR_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute RX_SUM_VCM_OVWR on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_SUM_VCM_OVWR_REG);
    attr_err = 1'b1;
  end

  if ((RX_SUM_VREF_TUNE_REG < 3'b000) || (RX_SUM_VREF_TUNE_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute RX_SUM_VREF_TUNE on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_SUM_VREF_TUNE_REG);
    attr_err = 1'b1;
  end

  if ((RX_TUNE_AFE_OS_REG < 2'b00) || (RX_TUNE_AFE_OS_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute RX_TUNE_AFE_OS on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_TUNE_AFE_OS_REG);
    attr_err = 1'b1;
  end

  if ((RX_VREG_CTRL_REG < 3'b000) || (RX_VREG_CTRL_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute RX_VREG_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, RX_VREG_CTRL_REG);
    attr_err = 1'b1;
  end

  if ((RX_VREG_PDB_REG < 1'b0) || (RX_VREG_PDB_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute RX_VREG_PDB on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_VREG_PDB_REG);
    attr_err = 1'b1;
  end

  if ((RX_WIDEMODE_CDR_REG < 2'b00) || (RX_WIDEMODE_CDR_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute RX_WIDEMODE_CDR on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, RX_WIDEMODE_CDR_REG);
    attr_err = 1'b1;
  end

  if ((RX_XCLK_SEL_REG != "RXDES") &&
        (RX_XCLK_SEL_REG != "RXPMA") &&
        (RX_XCLK_SEL_REG != "RXUSR")) begin
    $display("Attribute Syntax Error : The attribute RX_XCLK_SEL on %s instance %m is set to %s.  Legal values for this attribute are RXDES, RXPMA or RXUSR.", MODULE_NAME, RX_XCLK_SEL_REG);
    attr_err = 1'b1;
  end

  if ((RX_XMODE_SEL_REG < 1'b0) || (RX_XMODE_SEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute RX_XMODE_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, RX_XMODE_SEL_REG);
    attr_err = 1'b1;
  end

  if ((SAS_MAX_COM_REG < 1) || (SAS_MAX_COM_REG > 127)) begin
    $display("Attribute Syntax Error : The attribute SAS_MAX_COM on %s instance %m is set to %d.  Legal values for this attribute are  1 to 127.", MODULE_NAME, SAS_MAX_COM_REG);
    attr_err = 1'b1;
  end

  if ((SAS_MIN_COM_REG < 1) || (SAS_MIN_COM_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SAS_MIN_COM on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SAS_MIN_COM_REG);
    attr_err = 1'b1;
  end

  if ((SATA_BURST_SEQ_LEN_REG < 4'b0000) || (SATA_BURST_SEQ_LEN_REG > 4'b1111)) begin
    $display("Attribute Syntax Error : The attribute SATA_BURST_SEQ_LEN on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, SATA_BURST_SEQ_LEN_REG);
    attr_err = 1'b1;
  end

  if ((SATA_BURST_VAL_REG < 3'b000) || (SATA_BURST_VAL_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute SATA_BURST_VAL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, SATA_BURST_VAL_REG);
    attr_err = 1'b1;
  end

  if ((SATA_CPLL_CFG_REG != "VCO_3000MHZ") &&
        (SATA_CPLL_CFG_REG != "VCO_750MHZ") &&
        (SATA_CPLL_CFG_REG != "VCO_1500MHZ")) begin
    $display("Attribute Syntax Error : The attribute SATA_CPLL_CFG on %s instance %m is set to %s.  Legal values for this attribute are VCO_3000MHZ, VCO_750MHZ or VCO_1500MHZ.", MODULE_NAME, SATA_CPLL_CFG_REG);
    attr_err = 1'b1;
  end

  if ((SATA_EIDLE_VAL_REG < 3'b000) || (SATA_EIDLE_VAL_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute SATA_EIDLE_VAL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, SATA_EIDLE_VAL_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MAX_BURST_REG < 1) || (SATA_MAX_BURST_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SATA_MAX_BURST on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SATA_MAX_BURST_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MAX_INIT_REG < 1) || (SATA_MAX_INIT_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SATA_MAX_INIT on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SATA_MAX_INIT_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MAX_WAKE_REG < 1) || (SATA_MAX_WAKE_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SATA_MAX_WAKE on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SATA_MAX_WAKE_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MIN_BURST_REG < 1) || (SATA_MIN_BURST_REG > 61)) begin
    $display("Attribute Syntax Error : The attribute SATA_MIN_BURST on %s instance %m is set to %d.  Legal values for this attribute are  1 to 61.", MODULE_NAME, SATA_MIN_BURST_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MIN_INIT_REG < 1) || (SATA_MIN_INIT_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SATA_MIN_INIT on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SATA_MIN_INIT_REG);
    attr_err = 1'b1;
  end

  if ((SATA_MIN_WAKE_REG < 1) || (SATA_MIN_WAKE_REG > 63)) begin
    $display("Attribute Syntax Error : The attribute SATA_MIN_WAKE on %s instance %m is set to %d.  Legal values for this attribute are  1 to 63.", MODULE_NAME, SATA_MIN_WAKE_REG);
    attr_err = 1'b1;
  end

  if ((SHOW_REALIGN_COMMA_REG != "TRUE") &&
        (SHOW_REALIGN_COMMA_REG != "FALSE")) begin
    $display("Attribute Syntax Error : The attribute SHOW_REALIGN_COMMA on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SHOW_REALIGN_COMMA_REG);
    attr_err = 1'b1;
  end

  if ((SIM_CPLLREFCLK_SEL_REG < 3'b000) || (SIM_CPLLREFCLK_SEL_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute SIM_CPLLREFCLK_SEL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, SIM_CPLLREFCLK_SEL_REG);
    attr_err = 1'b1;
  end

  if ((SIM_RECEIVER_DETECT_PASS_REG != "TRUE") &&
        (SIM_RECEIVER_DETECT_PASS_REG != "FALSE")) begin
    $display("Attribute Syntax Error : The attribute SIM_RECEIVER_DETECT_PASS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SIM_RECEIVER_DETECT_PASS_REG);
    attr_err = 1'b1;
  end

  if ((SIM_RESET_SPEEDUP_REG != "TRUE") &&
        (SIM_RESET_SPEEDUP_REG != "FALSE")) begin
    $display("Attribute Syntax Error : The attribute SIM_RESET_SPEEDUP on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SIM_RESET_SPEEDUP_REG);
    attr_err = 1'b1;
  end

  if ((SIM_TX_EIDLE_DRIVE_LEVEL_REG < 1'b0) || (SIM_TX_EIDLE_DRIVE_LEVEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute SIM_TX_EIDLE_DRIVE_LEVEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, SIM_TX_EIDLE_DRIVE_LEVEL_REG);
    attr_err = 1'b1;
  end

  if ((SIM_VERSION_REG != "Ver_1") &&
        (SIM_VERSION_REG != "Ver_1_1") &&
        (SIM_VERSION_REG != "Ver_2")) begin
    $display("Attribute Syntax Error : The attribute SIM_VERSION on %s instance %m is set to %s.  Legal values for this attribute are Ver_1, Ver_1_1 or Ver_2.", MODULE_NAME, SIM_VERSION_REG);
    attr_err = 1'b1;
  end

  if ((TEMPERATURE_PAR_REG < 4'b0000) || (TEMPERATURE_PAR_REG > 4'b1111)) begin
    $display("Attribute Syntax Error : The attribute TEMPERATURE_PAR on %s instance %m is set to %b.  Legal values for this attribute are 4'b0000 to 4'b1111.", MODULE_NAME, TEMPERATURE_PAR_REG);
    attr_err = 1'b1;
  end

  if ((TERM_RCAL_CFG_REG < 15'b000000000000000) || (TERM_RCAL_CFG_REG > 15'b111111111111111)) begin
    $display("Attribute Syntax Error : The attribute TERM_RCAL_CFG on %s instance %m is set to %b.  Legal values for this attribute are 15'b000000000000000 to 15'b111111111111111.", MODULE_NAME, TERM_RCAL_CFG_REG);
    attr_err = 1'b1;
  end

  if ((TERM_RCAL_OVRD_REG < 3'b000) || (TERM_RCAL_OVRD_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TERM_RCAL_OVRD on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TERM_RCAL_OVRD_REG);
    attr_err = 1'b1;
  end

  if ((TXBUF_EN_REG != "TRUE") &&
        (TXBUF_EN_REG != "FALSE")) begin
    $display("Attribute Syntax Error : The attribute TXBUF_EN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, TXBUF_EN_REG);
    attr_err = 1'b1;
  end

  if ((TXBUF_RESET_ON_RATE_CHANGE_REG != "FALSE") &&
        (TXBUF_RESET_ON_RATE_CHANGE_REG != "TRUE")) begin
    $display("Attribute Syntax Error : The attribute TXBUF_RESET_ON_RATE_CHANGE on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, TXBUF_RESET_ON_RATE_CHANGE_REG);
    attr_err = 1'b1;
  end

  if ((TXFIFO_ADDR_CFG_REG != "LOW") &&
        (TXFIFO_ADDR_CFG_REG != "HIGH")) begin
    $display("Attribute Syntax Error : The attribute TXFIFO_ADDR_CFG on %s instance %m is set to %s.  Legal values for this attribute are LOW or HIGH.", MODULE_NAME, TXFIFO_ADDR_CFG_REG);
    attr_err = 1'b1;
  end

  if ((TXGBOX_FIFO_INIT_RD_ADDR_REG != 4) &&
        (TXGBOX_FIFO_INIT_RD_ADDR_REG != 2) &&
        (TXGBOX_FIFO_INIT_RD_ADDR_REG != 3) &&
        (TXGBOX_FIFO_INIT_RD_ADDR_REG != 5) &&
        (TXGBOX_FIFO_INIT_RD_ADDR_REG != 6)) begin
    $display("Attribute Syntax Error : The attribute TXGBOX_FIFO_INIT_RD_ADDR on %s instance %m is set to %d.  Legal values for this attribute are 2 to 6.", MODULE_NAME, TXGBOX_FIFO_INIT_RD_ADDR_REG, 4);
    attr_err = 1'b1;
  end

  if ((TXGEARBOX_EN_REG != "FALSE") &&
        (TXGEARBOX_EN_REG != "TRUE")) begin
    $display("Attribute Syntax Error : The attribute TXGEARBOX_EN on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, TXGEARBOX_EN_REG);
    attr_err = 1'b1;
  end

  if ((TXOUT_DIV_REG != 4) &&
        (TXOUT_DIV_REG != 1) &&
        (TXOUT_DIV_REG != 2) &&
        (TXOUT_DIV_REG != 8) &&
        (TXOUT_DIV_REG != 16)) begin
    $display("Attribute Syntax Error : The attribute TXOUT_DIV on %s instance %m is set to %d.  Legal values for this attribute are 1 to 16.", MODULE_NAME, TXOUT_DIV_REG, 4);
    attr_err = 1'b1;
  end

  if ((TXPCSRESET_TIME_REG < 5'b00000) || (TXPCSRESET_TIME_REG > 5'b11111)) begin
    $display("Attribute Syntax Error : The attribute TXPCSRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, TXPCSRESET_TIME_REG);
    attr_err = 1'b1;
  end

  if ((TXPH_MONITOR_SEL_REG < 5'b00000) || (TXPH_MONITOR_SEL_REG > 5'b11111)) begin
    $display("Attribute Syntax Error : The attribute TXPH_MONITOR_SEL on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, TXPH_MONITOR_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG0_REG < 2'b00) || (TXPI_CFG0_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG0 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TXPI_CFG0_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG1_REG < 2'b00) || (TXPI_CFG1_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG1 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TXPI_CFG1_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG2_REG < 2'b00) || (TXPI_CFG2_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG2 on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TXPI_CFG2_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG3_REG < 1'b0) || (TXPI_CFG3_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG3 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_CFG3_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG4_REG < 1'b0) || (TXPI_CFG4_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG4 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_CFG4_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_CFG5_REG < 3'b000) || (TXPI_CFG5_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TXPI_CFG5 on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TXPI_CFG5_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_GRAY_SEL_REG < 1'b0) || (TXPI_GRAY_SEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_GRAY_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_GRAY_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_INVSTROBE_SEL_REG < 1'b0) || (TXPI_INVSTROBE_SEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_INVSTROBE_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_INVSTROBE_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_LPM_REG < 1'b0) || (TXPI_LPM_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_LPM on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_LPM_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_PPMCLK_SEL_REG != "TXUSRCLK2") &&
        (TXPI_PPMCLK_SEL_REG != "TXUSRCLK")) begin
    $display("Attribute Syntax Error : The attribute TXPI_PPMCLK_SEL on %s instance %m is set to %s.  Legal values for this attribute are TXUSRCLK2 or TXUSRCLK.", MODULE_NAME, TXPI_PPMCLK_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_PPM_CFG_REG < 8'b00000000) || (TXPI_PPM_CFG_REG > 8'b11111111)) begin
    $display("Attribute Syntax Error : The attribute TXPI_PPM_CFG on %s instance %m is set to %b.  Legal values for this attribute are 8'b00000000 to 8'b11111111.", MODULE_NAME, TXPI_PPM_CFG_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_SYNFREQ_PPM_REG < 3'b000) || (TXPI_SYNFREQ_PPM_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TXPI_SYNFREQ_PPM on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TXPI_SYNFREQ_PPM_REG);
    attr_err = 1'b1;
  end

  if ((TXPI_VREFSEL_REG < 1'b0) || (TXPI_VREFSEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXPI_VREFSEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXPI_VREFSEL_REG);
    attr_err = 1'b1;
  end

  if ((TXPMARESET_TIME_REG < 5'b00000) || (TXPMARESET_TIME_REG > 5'b11111)) begin
    $display("Attribute Syntax Error : The attribute TXPMARESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, TXPMARESET_TIME_REG);
    attr_err = 1'b1;
  end

  if ((TXSYNC_MULTILANE_REG < 1'b0) || (TXSYNC_MULTILANE_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXSYNC_MULTILANE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXSYNC_MULTILANE_REG);
    attr_err = 1'b1;
  end

  if ((TXSYNC_OVRD_REG < 1'b0) || (TXSYNC_OVRD_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXSYNC_OVRD on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXSYNC_OVRD_REG);
    attr_err = 1'b1;
  end

  if ((TXSYNC_SKIP_DA_REG < 1'b0) || (TXSYNC_SKIP_DA_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TXSYNC_SKIP_DA on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TXSYNC_SKIP_DA_REG);
    attr_err = 1'b1;
  end

  if ((TX_CLK25_DIV_REG < 1) || (TX_CLK25_DIV_REG > 32)) begin
    $display("Attribute Syntax Error : The attribute TX_CLK25_DIV on %s instance %m is set to %d.  Legal values for this attribute are  1 to 32.", MODULE_NAME, TX_CLK25_DIV_REG);
    attr_err = 1'b1;
  end

  if ((TX_CLKMUX_EN_REG < 1'b0) || (TX_CLKMUX_EN_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_CLKMUX_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_CLKMUX_EN_REG);
    attr_err = 1'b1;
  end

  if ((TX_CLKREG_PDB_REG < 1'b0) || (TX_CLKREG_PDB_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_CLKREG_PDB on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_CLKREG_PDB_REG);
    attr_err = 1'b1;
  end

  if ((TX_CLKREG_SET_REG < 3'b000) || (TX_CLKREG_SET_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_CLKREG_SET on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_CLKREG_SET_REG);
    attr_err = 1'b1;
  end

  if ((TX_DATA_WIDTH_REG != 20) &&
        (TX_DATA_WIDTH_REG != 16) &&
        (TX_DATA_WIDTH_REG != 32) &&
        (TX_DATA_WIDTH_REG != 40) &&
        (TX_DATA_WIDTH_REG != 64) &&
        (TX_DATA_WIDTH_REG != 80) &&
        (TX_DATA_WIDTH_REG != 128) &&
        (TX_DATA_WIDTH_REG != 160)) begin
    $display("Attribute Syntax Error : The attribute TX_DATA_WIDTH on %s instance %m is set to %d.  Legal values for this attribute are 16 to 160.", MODULE_NAME, TX_DATA_WIDTH_REG, 20);
    attr_err = 1'b1;
  end

  if ((TX_DCD_CFG_REG < 6'b000000) || (TX_DCD_CFG_REG > 6'b111111)) begin
    $display("Attribute Syntax Error : The attribute TX_DCD_CFG on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, TX_DCD_CFG_REG);
    attr_err = 1'b1;
  end

  if ((TX_DCD_EN_REG < 1'b0) || (TX_DCD_EN_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_DCD_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_DCD_EN_REG);
    attr_err = 1'b1;
  end

  if ((TX_DEEMPH0_REG < 6'b000000) || (TX_DEEMPH0_REG > 6'b111111)) begin
    $display("Attribute Syntax Error : The attribute TX_DEEMPH0 on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, TX_DEEMPH0_REG);
    attr_err = 1'b1;
  end

  if ((TX_DEEMPH1_REG < 6'b000000) || (TX_DEEMPH1_REG > 6'b111111)) begin
    $display("Attribute Syntax Error : The attribute TX_DEEMPH1 on %s instance %m is set to %b.  Legal values for this attribute are 6'b000000 to 6'b111111.", MODULE_NAME, TX_DEEMPH1_REG);
    attr_err = 1'b1;
  end

  if ((TX_DIVRESET_TIME_REG < 5'b00000) || (TX_DIVRESET_TIME_REG > 5'b11111)) begin
    $display("Attribute Syntax Error : The attribute TX_DIVRESET_TIME on %s instance %m is set to %b.  Legal values for this attribute are 5'b00000 to 5'b11111.", MODULE_NAME, TX_DIVRESET_TIME_REG);
    attr_err = 1'b1;
  end

  if ((TX_DRIVE_MODE_REG != "DIRECT") &&
        (TX_DRIVE_MODE_REG != "PIPE") &&
        (TX_DRIVE_MODE_REG != "PIPEGEN3")) begin
    $display("Attribute Syntax Error : The attribute TX_DRIVE_MODE on %s instance %m is set to %s.  Legal values for this attribute are DIRECT, PIPE or PIPEGEN3.", MODULE_NAME, TX_DRIVE_MODE_REG);
    attr_err = 1'b1;
  end

  if ((TX_DRVMUX_CTRL_REG < 2'b00) || (TX_DRVMUX_CTRL_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TX_DRVMUX_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TX_DRVMUX_CTRL_REG);
    attr_err = 1'b1;
  end

  if ((TX_EIDLE_ASSERT_DELAY_REG < 3'b000) || (TX_EIDLE_ASSERT_DELAY_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_EIDLE_ASSERT_DELAY on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_EIDLE_ASSERT_DELAY_REG);
    attr_err = 1'b1;
  end

  if ((TX_EIDLE_DEASSERT_DELAY_REG < 3'b000) || (TX_EIDLE_DEASSERT_DELAY_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_EIDLE_DEASSERT_DELAY on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_EIDLE_DEASSERT_DELAY_REG);
    attr_err = 1'b1;
  end

  if ((TX_EML_PHI_TUNE_REG < 1'b0) || (TX_EML_PHI_TUNE_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_EML_PHI_TUNE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_EML_PHI_TUNE_REG);
    attr_err = 1'b1;
  end

  if ((TX_FABINT_USRCLK_FLOP_REG < 1'b0) || (TX_FABINT_USRCLK_FLOP_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_FABINT_USRCLK_FLOP on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_FABINT_USRCLK_FLOP_REG);
    attr_err = 1'b1;
  end

  if ((TX_FIFO_BYP_EN_REG < 1'b0) || (TX_FIFO_BYP_EN_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_FIFO_BYP_EN on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_FIFO_BYP_EN_REG);
    attr_err = 1'b1;
  end

  if ((TX_IDLE_DATA_ZERO_REG < 1'b0) || (TX_IDLE_DATA_ZERO_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_IDLE_DATA_ZERO on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_IDLE_DATA_ZERO_REG);
    attr_err = 1'b1;
  end

  if ((TX_INT_DATAWIDTH_REG != 1) &&
        (TX_INT_DATAWIDTH_REG != 0) &&
        (TX_INT_DATAWIDTH_REG != 2)) begin
    $display("Attribute Syntax Error : The attribute TX_INT_DATAWIDTH on %s instance %m is set to %d.  Legal values for this attribute are 0 to 2.", MODULE_NAME, TX_INT_DATAWIDTH_REG, 1);
    attr_err = 1'b1;
  end

  if ((TX_LOOPBACK_DRIVE_HIZ_REG != "FALSE") &&
        (TX_LOOPBACK_DRIVE_HIZ_REG != "TRUE")) begin
    $display("Attribute Syntax Error : The attribute TX_LOOPBACK_DRIVE_HIZ on %s instance %m is set to %s.  Legal values for this attribute are FALSE or TRUE.", MODULE_NAME, TX_LOOPBACK_DRIVE_HIZ_REG);
    attr_err = 1'b1;
  end

  if ((TX_MAINCURSOR_SEL_REG < 1'b0) || (TX_MAINCURSOR_SEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_MAINCURSOR_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_MAINCURSOR_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_FULL_0_REG < 7'b0000000) || (TX_MARGIN_FULL_0_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_FULL_0 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_FULL_0_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_FULL_1_REG < 7'b0000000) || (TX_MARGIN_FULL_1_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_FULL_1 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_FULL_1_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_FULL_2_REG < 7'b0000000) || (TX_MARGIN_FULL_2_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_FULL_2 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_FULL_2_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_FULL_3_REG < 7'b0000000) || (TX_MARGIN_FULL_3_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_FULL_3 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_FULL_3_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_FULL_4_REG < 7'b0000000) || (TX_MARGIN_FULL_4_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_FULL_4 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_FULL_4_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_LOW_0_REG < 7'b0000000) || (TX_MARGIN_LOW_0_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_LOW_0 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_LOW_0_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_LOW_1_REG < 7'b0000000) || (TX_MARGIN_LOW_1_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_LOW_1 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_LOW_1_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_LOW_2_REG < 7'b0000000) || (TX_MARGIN_LOW_2_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_LOW_2 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_LOW_2_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_LOW_3_REG < 7'b0000000) || (TX_MARGIN_LOW_3_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_LOW_3 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_LOW_3_REG);
    attr_err = 1'b1;
  end

  if ((TX_MARGIN_LOW_4_REG < 7'b0000000) || (TX_MARGIN_LOW_4_REG > 7'b1111111)) begin
    $display("Attribute Syntax Error : The attribute TX_MARGIN_LOW_4 on %s instance %m is set to %b.  Legal values for this attribute are 7'b0000000 to 7'b1111111.", MODULE_NAME, TX_MARGIN_LOW_4_REG);
    attr_err = 1'b1;
  end

  if ((TX_MODE_SEL_REG < 3'b000) || (TX_MODE_SEL_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_MODE_SEL on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_MODE_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TX_PI_BIASSET_REG < 2'b00) || (TX_PI_BIASSET_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TX_PI_BIASSET on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TX_PI_BIASSET_REG);
    attr_err = 1'b1;
  end

  if ((TX_PI_DIV2_MODE_B_REG < 1'b0) || (TX_PI_DIV2_MODE_B_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_PI_DIV2_MODE_B on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_PI_DIV2_MODE_B_REG);
    attr_err = 1'b1;
  end

  if ((TX_PI_SEL_QPLL0_REG < 1'b0) || (TX_PI_SEL_QPLL0_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_PI_SEL_QPLL0 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_PI_SEL_QPLL0_REG);
    attr_err = 1'b1;
  end

  if ((TX_PI_SEL_QPLL1_REG < 1'b0) || (TX_PI_SEL_QPLL1_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_PI_SEL_QPLL1 on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_PI_SEL_QPLL1_REG);
    attr_err = 1'b1;
  end

  if ((TX_PMADATA_OPT_REG < 1'b0) || (TX_PMADATA_OPT_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_PMADATA_OPT on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_PMADATA_OPT_REG);
    attr_err = 1'b1;
  end

  if ((TX_PMA_POWER_SAVE_REG < 1'b0) || (TX_PMA_POWER_SAVE_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_PMA_POWER_SAVE on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_PMA_POWER_SAVE_REG);
    attr_err = 1'b1;
  end

  if ((TX_PREDRV_CTRL_REG < 2'b00) || (TX_PREDRV_CTRL_REG > 2'b11)) begin
    $display("Attribute Syntax Error : The attribute TX_PREDRV_CTRL on %s instance %m is set to %b.  Legal values for this attribute are 2'b00 to 2'b11.", MODULE_NAME, TX_PREDRV_CTRL_REG);
    attr_err = 1'b1;
  end

  if ((TX_PROGCLK_SEL_REG != "POSTPI") &&
        (TX_PROGCLK_SEL_REG != "CPLL") &&
        (TX_PROGCLK_SEL_REG != "PREPI")) begin
    $display("Attribute Syntax Error : The attribute TX_PROGCLK_SEL on %s instance %m is set to %s.  Legal values for this attribute are POSTPI, CPLL or PREPI.", MODULE_NAME, TX_PROGCLK_SEL_REG);
    attr_err = 1'b1;
  end

  if ((TX_PROGDIV_CFG_REG/1000.0 != 0.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 4.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 5.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 8.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 10.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 16.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 16.5) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 20.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 32.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 33.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 40.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 64.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 66.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 80.0) &&
      (TX_PROGDIV_CFG_REG/1000.0 != 100.0)) begin
    $display("Attribute Syntax Error : The attribute TX_PROGDIV_CFG on %s instance %m is set to %f.  Legal values for this attribute are 0.0, 4.0, 5.0, 8.0, 10.0, 16.0, 16.5, 20.0, 32.0, 33.0, 40.0, 64.0, 66.0, 80.0 or 100.0.", MODULE_NAME, TX_PROGDIV_CFG_REG/1000.0);
    attr_err = 1'b1;
  end

  if ((TX_RXDETECT_REF_REG < 3'b000) || (TX_RXDETECT_REF_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_RXDETECT_REF on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_RXDETECT_REF_REG);
    attr_err = 1'b1;
  end

  if ((TX_SAMPLE_PERIOD_REG < 3'b000) || (TX_SAMPLE_PERIOD_REG > 3'b111)) begin
    $display("Attribute Syntax Error : The attribute TX_SAMPLE_PERIOD on %s instance %m is set to %b.  Legal values for this attribute are 3'b000 to 3'b111.", MODULE_NAME, TX_SAMPLE_PERIOD_REG);
    attr_err = 1'b1;
  end

  if ((TX_SARC_LPBK_ENB_REG < 1'b0) || (TX_SARC_LPBK_ENB_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute TX_SARC_LPBK_ENB on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, TX_SARC_LPBK_ENB_REG);
    attr_err = 1'b1;
  end

  if ((TX_XCLK_SEL_REG != "TXOUT") &&
        (TX_XCLK_SEL_REG != "TXUSR")) begin
    $display("Attribute Syntax Error : The attribute TX_XCLK_SEL on %s instance %m is set to %s.  Legal values for this attribute are TXOUT or TXUSR.", MODULE_NAME, TX_XCLK_SEL_REG);
    attr_err = 1'b1;
  end

  if ((USE_PCS_CLK_PHASE_SEL_REG < 1'b0) || (USE_PCS_CLK_PHASE_SEL_REG > 1'b1)) begin
    $display("Attribute Syntax Error : The attribute USE_PCS_CLK_PHASE_SEL on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, USE_PCS_CLK_PHASE_SEL_REG);
    attr_err = 1'b1;
  end

if (attr_err == 1'b1) $finish;
end

assign PMASCANCLK0_in = 1'b1; // tie off
assign PMASCANCLK1_in = 1'b1; // tie off
assign PMASCANCLK2_in = 1'b1; // tie off
assign PMASCANCLK3_in = 1'b1; // tie off
assign PMASCANCLK4_in = 1'b1; // tie off
assign PMASCANCLK5_in = 1'b1; // tie off
assign SCANCLK_in = 1'b1; // tie off
assign TSTCLK0_in = 1'b1; // tie off
assign TSTCLK1_in = 1'b1; // tie off

assign PMASCANENB_in = 1'b1; // tie off
assign PMASCANIN_in = 12'b111111111111; // tie off
assign PMASCANMODEB_in = 1'b1; // tie off
assign PMASCANRSTEN_in = 1'b1; // tie off
assign SARCCLK_in = 1'b1; // tie off
assign SCANENB_in = 1'b1; // tie off
assign SCANIN_in = 19'b1111111111111111111; // tie off
assign SCANMODEB_in = 1'b1; // tie off
assign TSTPDOVRDB_in = 1'b1; // tie off
assign TSTPD_in = 5'b11111; // tie off

SIP_GTYE3_CHANNEL SIP_GTYE3_CHANNEL_INST (
  .ACJTAG_DEBUG_MODE (ACJTAG_DEBUG_MODE_REG),
  .ACJTAG_MODE (ACJTAG_MODE_REG),
  .ACJTAG_RESET (ACJTAG_RESET_REG),
  .ADAPT_CFG0 (ADAPT_CFG0_REG),
  .ADAPT_CFG1 (ADAPT_CFG1_REG),
  .ADAPT_CFG2 (ADAPT_CFG2_REG),
  .AEN_CDRSTEPSEL (AEN_CDRSTEPSEL_REG),
  .AEN_CPLL (AEN_CPLL_REG),
  .AEN_ELPCAL (AEN_ELPCAL_REG),
  .AEN_EYESCAN (AEN_EYESCAN_REG),
  .AEN_LOOPBACK (AEN_LOOPBACK_REG),
  .AEN_MASTER (AEN_MASTER_REG),
  .AEN_MUXDCD (AEN_MUXDCD_REG),
  .AEN_PD_AND_EIDLE (AEN_PD_AND_EIDLE_REG),
  .AEN_POLARITY (AEN_POLARITY_REG),
  .AEN_PRBS (AEN_PRBS_REG),
  .AEN_RESET (AEN_RESET_REG),
  .AEN_RXCDR (AEN_RXCDR_REG),
  .AEN_RXDFE (AEN_RXDFE_REG),
  .AEN_RXDFELPM (AEN_RXDFELPM_REG),
  .AEN_RXOUTCLK_SEL (AEN_RXOUTCLK_SEL_REG),
  .AEN_RXPHDLY (AEN_RXPHDLY_REG),
  .AEN_RXPLLCLK_SEL (AEN_RXPLLCLK_SEL_REG),
  .AEN_RXSYSCLK_SEL (AEN_RXSYSCLK_SEL_REG),
  .AEN_TXOUTCLK_SEL (AEN_TXOUTCLK_SEL_REG),
  .AEN_TXPHDLY (AEN_TXPHDLY_REG),
  .AEN_TXPI_PPM (AEN_TXPI_PPM_REG),
  .AEN_TXPLLCLK_SEL (AEN_TXPLLCLK_SEL_REG),
  .AEN_TXSYSCLK_SEL (AEN_TXSYSCLK_SEL_REG),
  .AEN_TX_DRIVE_MODE (AEN_TX_DRIVE_MODE_REG),
  .ALIGN_COMMA_DOUBLE (ALIGN_COMMA_DOUBLE_REG),
  .ALIGN_COMMA_ENABLE (ALIGN_COMMA_ENABLE_REG),
  .ALIGN_COMMA_WORD (ALIGN_COMMA_WORD_REG),
  .ALIGN_MCOMMA_DET (ALIGN_MCOMMA_DET_REG),
  .ALIGN_MCOMMA_VALUE (ALIGN_MCOMMA_VALUE_REG),
  .ALIGN_PCOMMA_DET (ALIGN_PCOMMA_DET_REG),
  .ALIGN_PCOMMA_VALUE (ALIGN_PCOMMA_VALUE_REG),
  .AMONITOR_CFG (AMONITOR_CFG_REG),
  .AUTO_BW_SEL_BYPASS (AUTO_BW_SEL_BYPASS_REG),
  .A_AFECFOKEN (A_AFECFOKEN_REG),
  .A_CPLLLOCKEN (A_CPLLLOCKEN_REG),
  .A_CPLLPD (A_CPLLPD_REG),
  .A_CPLLRESET (A_CPLLRESET_REG),
  .A_DFECFOKFCDAC (A_DFECFOKFCDAC_REG),
  .A_DFECFOKFCNUM (A_DFECFOKFCNUM_REG),
  .A_DFECFOKFPULSE (A_DFECFOKFPULSE_REG),
  .A_DFECFOKHOLD (A_DFECFOKHOLD_REG),
  .A_DFECFOKOVREN (A_DFECFOKOVREN_REG),
  .A_ELPCALDVORWREN (A_ELPCALDVORWREN_REG),
  .A_ELPCALPAORWREN (A_ELPCALPAORWREN_REG),
  .A_EYESCANMODE (A_EYESCANMODE_REG),
  .A_EYESCANRESET (A_EYESCANRESET_REG),
  .A_GTRESETSEL (A_GTRESETSEL_REG),
  .A_GTRXRESET (A_GTRXRESET_REG),
  .A_GTTXRESET (A_GTTXRESET_REG),
  .A_LOOPBACK (A_LOOPBACK_REG),
  .A_LPMGCHOLD (A_LPMGCHOLD_REG),
  .A_LPMGCOVREN (A_LPMGCOVREN_REG),
  .A_LPMOSHOLD (A_LPMOSHOLD_REG),
  .A_LPMOSOVREN (A_LPMOSOVREN_REG),
  .A_MUXDCDEXHOLD (A_MUXDCDEXHOLD_REG),
  .A_MUXDCDORWREN (A_MUXDCDORWREN_REG),
  .A_RXBUFRESET (A_RXBUFRESET_REG),
  .A_RXCDRFREQRESET (A_RXCDRFREQRESET_REG),
  .A_RXCDRHOLD (A_RXCDRHOLD_REG),
  .A_RXCDROVRDEN (A_RXCDROVRDEN_REG),
  .A_RXCDRRESET (A_RXCDRRESET_REG),
  .A_RXDFEAGCHOLD (A_RXDFEAGCHOLD_REG),
  .A_RXDFEAGCOVRDEN (A_RXDFEAGCOVRDEN_REG),
  .A_RXDFECFOKFEN (A_RXDFECFOKFEN_REG),
  .A_RXDFELFHOLD (A_RXDFELFHOLD_REG),
  .A_RXDFELFOVRDEN (A_RXDFELFOVRDEN_REG),
  .A_RXDFELPMRESET (A_RXDFELPMRESET_REG),
  .A_RXDFETAP10HOLD (A_RXDFETAP10HOLD_REG),
  .A_RXDFETAP10OVRDEN (A_RXDFETAP10OVRDEN_REG),
  .A_RXDFETAP11HOLD (A_RXDFETAP11HOLD_REG),
  .A_RXDFETAP11OVRDEN (A_RXDFETAP11OVRDEN_REG),
  .A_RXDFETAP12HOLD (A_RXDFETAP12HOLD_REG),
  .A_RXDFETAP12OVRDEN (A_RXDFETAP12OVRDEN_REG),
  .A_RXDFETAP13HOLD (A_RXDFETAP13HOLD_REG),
  .A_RXDFETAP13OVRDEN (A_RXDFETAP13OVRDEN_REG),
  .A_RXDFETAP14HOLD (A_RXDFETAP14HOLD_REG),
  .A_RXDFETAP14OVRDEN (A_RXDFETAP14OVRDEN_REG),
  .A_RXDFETAP15HOLD (A_RXDFETAP15HOLD_REG),
  .A_RXDFETAP15OVRDEN (A_RXDFETAP15OVRDEN_REG),
  .A_RXDFETAP2HOLD (A_RXDFETAP2HOLD_REG),
  .A_RXDFETAP2OVRDEN (A_RXDFETAP2OVRDEN_REG),
  .A_RXDFETAP3HOLD (A_RXDFETAP3HOLD_REG),
  .A_RXDFETAP3OVRDEN (A_RXDFETAP3OVRDEN_REG),
  .A_RXDFETAP4HOLD (A_RXDFETAP4HOLD_REG),
  .A_RXDFETAP4OVRDEN (A_RXDFETAP4OVRDEN_REG),
  .A_RXDFETAP5HOLD (A_RXDFETAP5HOLD_REG),
  .A_RXDFETAP5OVRDEN (A_RXDFETAP5OVRDEN_REG),
  .A_RXDFETAP6HOLD (A_RXDFETAP6HOLD_REG),
  .A_RXDFETAP6OVRDEN (A_RXDFETAP6OVRDEN_REG),
  .A_RXDFETAP7HOLD (A_RXDFETAP7HOLD_REG),
  .A_RXDFETAP7OVRDEN (A_RXDFETAP7OVRDEN_REG),
  .A_RXDFETAP8HOLD (A_RXDFETAP8HOLD_REG),
  .A_RXDFETAP8OVRDEN (A_RXDFETAP8OVRDEN_REG),
  .A_RXDFETAP9HOLD (A_RXDFETAP9HOLD_REG),
  .A_RXDFETAP9OVRDEN (A_RXDFETAP9OVRDEN_REG),
  .A_RXDFEUTHOLD (A_RXDFEUTHOLD_REG),
  .A_RXDFEUTOVRDEN (A_RXDFEUTOVRDEN_REG),
  .A_RXDFEVPHOLD (A_RXDFEVPHOLD_REG),
  .A_RXDFEVPOVRDEN (A_RXDFEVPOVRDEN_REG),
  .A_RXDFEVSEN (A_RXDFEVSEN_REG),
  .A_RXDFEXYDEN (A_RXDFEXYDEN_REG),
  .A_RXDLYBYPASS (A_RXDLYBYPASS_REG),
  .A_RXDLYEN (A_RXDLYEN_REG),
  .A_RXDLYOVRDEN (A_RXDLYOVRDEN_REG),
  .A_RXDLYSRESET (A_RXDLYSRESET_REG),
  .A_RXLPMEN (A_RXLPMEN_REG),
  .A_RXLPMHFHOLD (A_RXLPMHFHOLD_REG),
  .A_RXLPMHFOVRDEN (A_RXLPMHFOVRDEN_REG),
  .A_RXLPMLFHOLD (A_RXLPMLFHOLD_REG),
  .A_RXLPMLFKLOVRDEN (A_RXLPMLFKLOVRDEN_REG),
  .A_RXMONITORSEL (A_RXMONITORSEL_REG),
  .A_RXOOBRESET (A_RXOOBRESET_REG),
  .A_RXOSCALRESET (A_RXOSCALRESET_REG),
  .A_RXOSHOLD (A_RXOSHOLD_REG),
  .A_RXOSOVRDEN (A_RXOSOVRDEN_REG),
  .A_RXOUTCLKSEL (A_RXOUTCLKSEL_REG),
  .A_RXPCSRESET (A_RXPCSRESET_REG),
  .A_RXPD (A_RXPD_REG),
  .A_RXPHALIGN (A_RXPHALIGN_REG),
  .A_RXPHALIGNEN (A_RXPHALIGNEN_REG),
  .A_RXPHDLYPD (A_RXPHDLYPD_REG),
  .A_RXPHDLYRESET (A_RXPHDLYRESET_REG),
  .A_RXPHOVRDEN (A_RXPHOVRDEN_REG),
  .A_RXPLLCLKSEL (A_RXPLLCLKSEL_REG),
  .A_RXPMARESET (A_RXPMARESET_REG),
  .A_RXPOLARITY (A_RXPOLARITY_REG),
  .A_RXPRBSCNTRESET (A_RXPRBSCNTRESET_REG),
  .A_RXPRBSSEL (A_RXPRBSSEL_REG),
  .A_RXPROGDIVRESET (A_RXPROGDIVRESET_REG),
  .A_RXSYSCLKSEL (A_RXSYSCLKSEL_REG),
  .A_TXBUFDIFFCTRL (A_TXBUFDIFFCTRL_REG),
  .A_TXDEEMPH (A_TXDEEMPH_REG),
  .A_TXDIFFCTRL (A_TXDIFFCTRL_REG),
  .A_TXDLYBYPASS (A_TXDLYBYPASS_REG),
  .A_TXDLYEN (A_TXDLYEN_REG),
  .A_TXDLYOVRDEN (A_TXDLYOVRDEN_REG),
  .A_TXDLYSRESET (A_TXDLYSRESET_REG),
  .A_TXELECIDLE (A_TXELECIDLE_REG),
  .A_TXINHIBIT (A_TXINHIBIT_REG),
  .A_TXMAINCURSOR (A_TXMAINCURSOR_REG),
  .A_TXMARGIN (A_TXMARGIN_REG),
  .A_TXOUTCLKSEL (A_TXOUTCLKSEL_REG),
  .A_TXPCSRESET (A_TXPCSRESET_REG),
  .A_TXPD (A_TXPD_REG),
  .A_TXPHALIGN (A_TXPHALIGN_REG),
  .A_TXPHALIGNEN (A_TXPHALIGNEN_REG),
  .A_TXPHDLYPD (A_TXPHDLYPD_REG),
  .A_TXPHDLYRESET (A_TXPHDLYRESET_REG),
  .A_TXPHINIT (A_TXPHINIT_REG),
  .A_TXPHOVRDEN (A_TXPHOVRDEN_REG),
  .A_TXPIPPMOVRDEN (A_TXPIPPMOVRDEN_REG),
  .A_TXPIPPMPD (A_TXPIPPMPD_REG),
  .A_TXPIPPMSEL (A_TXPIPPMSEL_REG),
  .A_TXPLLCLKSEL (A_TXPLLCLKSEL_REG),
  .A_TXPMARESET (A_TXPMARESET_REG),
  .A_TXPOLARITY (A_TXPOLARITY_REG),
  .A_TXPOSTCURSOR (A_TXPOSTCURSOR_REG),
  .A_TXPRBSFORCEERR (A_TXPRBSFORCEERR_REG),
  .A_TXPRBSSEL (A_TXPRBSSEL_REG),
  .A_TXPRECURSOR (A_TXPRECURSOR_REG),
  .A_TXPROGDIVRESET (A_TXPROGDIVRESET_REG),
  .A_TXSWING (A_TXSWING_REG),
  .A_TXSYSCLKSEL (A_TXSYSCLKSEL_REG),
  .CAPBYPASS_FORCE (CAPBYPASS_FORCE_REG),
  .CBCC_DATA_SOURCE_SEL (CBCC_DATA_SOURCE_SEL_REG),
  .CDR_SWAP_MODE_EN (CDR_SWAP_MODE_EN_REG),
  .CHAN_BOND_KEEP_ALIGN (CHAN_BOND_KEEP_ALIGN_REG),
  .CHAN_BOND_MAX_SKEW (CHAN_BOND_MAX_SKEW_REG),
  .CHAN_BOND_SEQ_1_1 (CHAN_BOND_SEQ_1_1_REG),
  .CHAN_BOND_SEQ_1_2 (CHAN_BOND_SEQ_1_2_REG),
  .CHAN_BOND_SEQ_1_3 (CHAN_BOND_SEQ_1_3_REG),
  .CHAN_BOND_SEQ_1_4 (CHAN_BOND_SEQ_1_4_REG),
  .CHAN_BOND_SEQ_1_ENABLE (CHAN_BOND_SEQ_1_ENABLE_REG),
  .CHAN_BOND_SEQ_2_1 (CHAN_BOND_SEQ_2_1_REG),
  .CHAN_BOND_SEQ_2_2 (CHAN_BOND_SEQ_2_2_REG),
  .CHAN_BOND_SEQ_2_3 (CHAN_BOND_SEQ_2_3_REG),
  .CHAN_BOND_SEQ_2_4 (CHAN_BOND_SEQ_2_4_REG),
  .CHAN_BOND_SEQ_2_ENABLE (CHAN_BOND_SEQ_2_ENABLE_REG),
  .CHAN_BOND_SEQ_2_USE (CHAN_BOND_SEQ_2_USE_REG),
  .CHAN_BOND_SEQ_LEN (CHAN_BOND_SEQ_LEN_REG),
  .CH_HSPMUX (CH_HSPMUX_REG),
  .CKCAL1_CFG_0 (CKCAL1_CFG_0_REG),
  .CKCAL1_CFG_1 (CKCAL1_CFG_1_REG),
  .CKCAL1_CFG_2 (CKCAL1_CFG_2_REG),
  .CKCAL1_CFG_3 (CKCAL1_CFG_3_REG),
  .CKCAL2_CFG_0 (CKCAL2_CFG_0_REG),
  .CKCAL2_CFG_1 (CKCAL2_CFG_1_REG),
  .CKCAL2_CFG_2 (CKCAL2_CFG_2_REG),
  .CKCAL2_CFG_3 (CKCAL2_CFG_3_REG),
  .CKCAL2_CFG_4 (CKCAL2_CFG_4_REG),
  .CKCAL_RSVD0 (CKCAL_RSVD0_REG),
  .CKCAL_RSVD1 (CKCAL_RSVD1_REG),
  .CLK_CORRECT_USE (CLK_CORRECT_USE_REG),
  .CLK_COR_KEEP_IDLE (CLK_COR_KEEP_IDLE_REG),
  .CLK_COR_MAX_LAT (CLK_COR_MAX_LAT_REG),
  .CLK_COR_MIN_LAT (CLK_COR_MIN_LAT_REG),
  .CLK_COR_PRECEDENCE (CLK_COR_PRECEDENCE_REG),
  .CLK_COR_REPEAT_WAIT (CLK_COR_REPEAT_WAIT_REG),
  .CLK_COR_SEQ_1_1 (CLK_COR_SEQ_1_1_REG),
  .CLK_COR_SEQ_1_2 (CLK_COR_SEQ_1_2_REG),
  .CLK_COR_SEQ_1_3 (CLK_COR_SEQ_1_3_REG),
  .CLK_COR_SEQ_1_4 (CLK_COR_SEQ_1_4_REG),
  .CLK_COR_SEQ_1_ENABLE (CLK_COR_SEQ_1_ENABLE_REG),
  .CLK_COR_SEQ_2_1 (CLK_COR_SEQ_2_1_REG),
  .CLK_COR_SEQ_2_2 (CLK_COR_SEQ_2_2_REG),
  .CLK_COR_SEQ_2_3 (CLK_COR_SEQ_2_3_REG),
  .CLK_COR_SEQ_2_4 (CLK_COR_SEQ_2_4_REG),
  .CLK_COR_SEQ_2_ENABLE (CLK_COR_SEQ_2_ENABLE_REG),
  .CLK_COR_SEQ_2_USE (CLK_COR_SEQ_2_USE_REG),
  .CLK_COR_SEQ_LEN (CLK_COR_SEQ_LEN_REG),
  .CPLL_CFG0 (CPLL_CFG0_REG),
  .CPLL_CFG1 (CPLL_CFG1_REG),
  .CPLL_CFG2 (CPLL_CFG2_REG),
  .CPLL_CFG3 (CPLL_CFG3_REG),
  .CPLL_FBDIV (CPLL_FBDIV_REG),
  .CPLL_FBDIV_45 (CPLL_FBDIV_45_REG),
  .CPLL_INIT_CFG0 (CPLL_INIT_CFG0_REG),
  .CPLL_INIT_CFG1 (CPLL_INIT_CFG1_REG),
  .CPLL_IPS_EN (CPLL_IPS_EN_REG),
  .CPLL_IPS_REFCLK_SEL (CPLL_IPS_REFCLK_SEL_REG),
  .CPLL_LOCK_CFG (CPLL_LOCK_CFG_REG),
  .CPLL_REFCLK_DIV (CPLL_REFCLK_DIV_REG),
  .CTLE3_OCAP_EXT_CTRL (CTLE3_OCAP_EXT_CTRL_REG),
  .CTLE3_OCAP_EXT_EN (CTLE3_OCAP_EXT_EN_REG),
  .DDI_CTRL (DDI_CTRL_REG),
  .DDI_REALIGN_WAIT (DDI_REALIGN_WAIT_REG),
  .DEC_MCOMMA_DETECT (DEC_MCOMMA_DETECT_REG),
  .DEC_PCOMMA_DETECT (DEC_PCOMMA_DETECT_REG),
  .DEC_VALID_COMMA_ONLY (DEC_VALID_COMMA_ONLY_REG),
  .DFE_D_X_REL_POS (DFE_D_X_REL_POS_REG),
  .DFE_VCM_COMP_EN (DFE_VCM_COMP_EN_REG),
  .DMONITOR_CFG0 (DMONITOR_CFG0_REG),
  .DMONITOR_CFG1 (DMONITOR_CFG1_REG),
  .ES_CLK_PHASE_SEL (ES_CLK_PHASE_SEL_REG),
  .ES_CONTROL (ES_CONTROL_REG),
  .ES_ERRDET_EN (ES_ERRDET_EN_REG),
  .ES_EYE_SCAN_EN (ES_EYE_SCAN_EN_REG),
  .ES_HORZ_OFFSET (ES_HORZ_OFFSET_REG),
  .ES_PMA_CFG (ES_PMA_CFG_REG),
  .ES_PRESCALE (ES_PRESCALE_REG),
  .ES_QUALIFIER0 (ES_QUALIFIER0_REG),
  .ES_QUALIFIER1 (ES_QUALIFIER1_REG),
  .ES_QUALIFIER2 (ES_QUALIFIER2_REG),
  .ES_QUALIFIER3 (ES_QUALIFIER3_REG),
  .ES_QUALIFIER4 (ES_QUALIFIER4_REG),
  .ES_QUALIFIER5 (ES_QUALIFIER5_REG),
  .ES_QUALIFIER6 (ES_QUALIFIER6_REG),
  .ES_QUALIFIER7 (ES_QUALIFIER7_REG),
  .ES_QUALIFIER8 (ES_QUALIFIER8_REG),
  .ES_QUALIFIER9 (ES_QUALIFIER9_REG),
  .ES_QUAL_MASK0 (ES_QUAL_MASK0_REG),
  .ES_QUAL_MASK1 (ES_QUAL_MASK1_REG),
  .ES_QUAL_MASK2 (ES_QUAL_MASK2_REG),
  .ES_QUAL_MASK3 (ES_QUAL_MASK3_REG),
  .ES_QUAL_MASK4 (ES_QUAL_MASK4_REG),
  .ES_QUAL_MASK5 (ES_QUAL_MASK5_REG),
  .ES_QUAL_MASK6 (ES_QUAL_MASK6_REG),
  .ES_QUAL_MASK7 (ES_QUAL_MASK7_REG),
  .ES_QUAL_MASK8 (ES_QUAL_MASK8_REG),
  .ES_QUAL_MASK9 (ES_QUAL_MASK9_REG),
  .ES_SDATA_MASK0 (ES_SDATA_MASK0_REG),
  .ES_SDATA_MASK1 (ES_SDATA_MASK1_REG),
  .ES_SDATA_MASK2 (ES_SDATA_MASK2_REG),
  .ES_SDATA_MASK3 (ES_SDATA_MASK3_REG),
  .ES_SDATA_MASK4 (ES_SDATA_MASK4_REG),
  .ES_SDATA_MASK5 (ES_SDATA_MASK5_REG),
  .ES_SDATA_MASK6 (ES_SDATA_MASK6_REG),
  .ES_SDATA_MASK7 (ES_SDATA_MASK7_REG),
  .ES_SDATA_MASK8 (ES_SDATA_MASK8_REG),
  .ES_SDATA_MASK9 (ES_SDATA_MASK9_REG),
  .EVODD_PHI_CFG (EVODD_PHI_CFG_REG),
  .EYE_SCAN_SWAP_EN (EYE_SCAN_SWAP_EN_REG),
  .FTS_DESKEW_SEQ_ENABLE (FTS_DESKEW_SEQ_ENABLE_REG),
  .FTS_LANE_DESKEW_CFG (FTS_LANE_DESKEW_CFG_REG),
  .FTS_LANE_DESKEW_EN (FTS_LANE_DESKEW_EN_REG),
  .GEARBOX_MODE (GEARBOX_MODE_REG),
  .GEN_RXUSRCLK (GEN_RXUSRCLK_REG),
  .GEN_TXUSRCLK (GEN_TXUSRCLK_REG),
  .GM_BIAS_SELECT (GM_BIAS_SELECT_REG),
  .GT_INSTANTIATED (GT_INSTANTIATED_REG),
  .ISCAN_CK_PH_SEL2 (ISCAN_CK_PH_SEL2_REG),
  .LOCAL_MASTER (LOCAL_MASTER_REG),
  .LOOP0_CFG (LOOP0_CFG_REG),
  .LOOP10_CFG (LOOP10_CFG_REG),
  .LOOP11_CFG (LOOP11_CFG_REG),
  .LOOP12_CFG (LOOP12_CFG_REG),
  .LOOP13_CFG (LOOP13_CFG_REG),
  .LOOP1_CFG (LOOP1_CFG_REG),
  .LOOP2_CFG (LOOP2_CFG_REG),
  .LOOP3_CFG (LOOP3_CFG_REG),
  .LOOP4_CFG (LOOP4_CFG_REG),
  .LOOP5_CFG (LOOP5_CFG_REG),
  .LOOP6_CFG (LOOP6_CFG_REG),
  .LOOP7_CFG (LOOP7_CFG_REG),
  .LOOP8_CFG (LOOP8_CFG_REG),
  .LOOP9_CFG (LOOP9_CFG_REG),
  .LPBK_BIAS_CTRL (LPBK_BIAS_CTRL_REG),
  .LPBK_EN_RCAL_B (LPBK_EN_RCAL_B_REG),
  .LPBK_EXT_RCAL (LPBK_EXT_RCAL_REG),
  .LPBK_RG_CTRL (LPBK_RG_CTRL_REG),
  .OOBDIVCTL (OOBDIVCTL_REG),
  .OOB_PWRUP (OOB_PWRUP_REG),
  .PCI3_AUTO_REALIGN (PCI3_AUTO_REALIGN_REG),
  .PCI3_PIPE_RX_ELECIDLE (PCI3_PIPE_RX_ELECIDLE_REG),
  .PCI3_RX_ASYNC_EBUF_BYPASS (PCI3_RX_ASYNC_EBUF_BYPASS_REG),
  .PCI3_RX_ELECIDLE_EI2_ENABLE (PCI3_RX_ELECIDLE_EI2_ENABLE_REG),
  .PCI3_RX_ELECIDLE_H2L_COUNT (PCI3_RX_ELECIDLE_H2L_COUNT_REG),
  .PCI3_RX_ELECIDLE_H2L_DISABLE (PCI3_RX_ELECIDLE_H2L_DISABLE_REG),
  .PCI3_RX_ELECIDLE_HI_COUNT (PCI3_RX_ELECIDLE_HI_COUNT_REG),
  .PCI3_RX_ELECIDLE_LP4_DISABLE (PCI3_RX_ELECIDLE_LP4_DISABLE_REG),
  .PCI3_RX_FIFO_DISABLE (PCI3_RX_FIFO_DISABLE_REG),
  .PCIE_BUFG_DIV_CTRL (PCIE_BUFG_DIV_CTRL_REG),
  .PCIE_RXPCS_CFG_GEN3 (PCIE_RXPCS_CFG_GEN3_REG),
  .PCIE_RXPMA_CFG (PCIE_RXPMA_CFG_REG),
  .PCIE_TXPCS_CFG_GEN3 (PCIE_TXPCS_CFG_GEN3_REG),
  .PCIE_TXPMA_CFG (PCIE_TXPMA_CFG_REG),
  .PCS_PCIE_EN (PCS_PCIE_EN_REG),
  .PCS_RSVD0 (PCS_RSVD0_REG),
  .PCS_RSVD1 (PCS_RSVD1_REG),
  .PD_TRANS_TIME_FROM_P2 (PD_TRANS_TIME_FROM_P2_REG),
  .PD_TRANS_TIME_NONE_P2 (PD_TRANS_TIME_NONE_P2_REG),
  .PD_TRANS_TIME_TO_P2 (PD_TRANS_TIME_TO_P2_REG),
  .PLL_SEL_MODE_GEN12 (PLL_SEL_MODE_GEN12_REG),
  .PLL_SEL_MODE_GEN3 (PLL_SEL_MODE_GEN3_REG),
  .PMA_RSV0 (PMA_RSV0_REG),
  .PMA_RSV1 (PMA_RSV1_REG),
  .PREIQ_FREQ_BST (PREIQ_FREQ_BST_REG),
  .PROCESS_PAR (PROCESS_PAR_REG),
  .RATE_SW_USE_DRP (RATE_SW_USE_DRP_REG),
  .RESET_POWERSAVE_DISABLE (RESET_POWERSAVE_DISABLE_REG),
  .RXBUFRESET_TIME (RXBUFRESET_TIME_REG),
  .RXBUF_ADDR_MODE (RXBUF_ADDR_MODE_REG),
  .RXBUF_EIDLE_HI_CNT (RXBUF_EIDLE_HI_CNT_REG),
  .RXBUF_EIDLE_LO_CNT (RXBUF_EIDLE_LO_CNT_REG),
  .RXBUF_EN (RXBUF_EN_REG),
  .RXBUF_RESET_ON_CB_CHANGE (RXBUF_RESET_ON_CB_CHANGE_REG),
  .RXBUF_RESET_ON_COMMAALIGN (RXBUF_RESET_ON_COMMAALIGN_REG),
  .RXBUF_RESET_ON_EIDLE (RXBUF_RESET_ON_EIDLE_REG),
  .RXBUF_RESET_ON_RATE_CHANGE (RXBUF_RESET_ON_RATE_CHANGE_REG),
  .RXBUF_THRESH_OVFLW (RXBUF_THRESH_OVFLW_REG),
  .RXBUF_THRESH_OVRD (RXBUF_THRESH_OVRD_REG),
  .RXBUF_THRESH_UNDFLW (RXBUF_THRESH_UNDFLW_REG),
  .RXCDRFREQRESET_TIME (RXCDRFREQRESET_TIME_REG),
  .RXCDRPHRESET_TIME (RXCDRPHRESET_TIME_REG),
  .RXCDR_CFG0 (RXCDR_CFG0_REG),
  .RXCDR_CFG0_GEN3 (RXCDR_CFG0_GEN3_REG),
  .RXCDR_CFG1 (RXCDR_CFG1_REG),
  .RXCDR_CFG1_GEN3 (RXCDR_CFG1_GEN3_REG),
  .RXCDR_CFG2 (RXCDR_CFG2_REG),
  .RXCDR_CFG2_GEN3 (RXCDR_CFG2_GEN3_REG),
  .RXCDR_CFG3 (RXCDR_CFG3_REG),
  .RXCDR_CFG3_GEN3 (RXCDR_CFG3_GEN3_REG),
  .RXCDR_CFG4 (RXCDR_CFG4_REG),
  .RXCDR_CFG4_GEN3 (RXCDR_CFG4_GEN3_REG),
  .RXCDR_CFG5 (RXCDR_CFG5_REG),
  .RXCDR_CFG5_GEN3 (RXCDR_CFG5_GEN3_REG),
  .RXCDR_FR_RESET_ON_EIDLE (RXCDR_FR_RESET_ON_EIDLE_REG),
  .RXCDR_HOLD_DURING_EIDLE (RXCDR_HOLD_DURING_EIDLE_REG),
  .RXCDR_LOCK_CFG0 (RXCDR_LOCK_CFG0_REG),
  .RXCDR_LOCK_CFG1 (RXCDR_LOCK_CFG1_REG),
  .RXCDR_LOCK_CFG2 (RXCDR_LOCK_CFG2_REG),
  .RXCDR_LOCK_CFG3 (RXCDR_LOCK_CFG3_REG),
  .RXCDR_PH_RESET_ON_EIDLE (RXCDR_PH_RESET_ON_EIDLE_REG),
  .RXCFOKDONE_SRC (RXCFOKDONE_SRC_REG),
  .RXCFOK_CFG0 (RXCFOK_CFG0_REG),
  .RXCFOK_CFG1 (RXCFOK_CFG1_REG),
  .RXCFOK_CFG2 (RXCFOK_CFG2_REG),
  .RXDFELPMRESET_TIME (RXDFELPMRESET_TIME_REG),
  .RXDFELPM_KL_CFG0 (RXDFELPM_KL_CFG0_REG),
  .RXDFELPM_KL_CFG1 (RXDFELPM_KL_CFG1_REG),
  .RXDFELPM_KL_CFG2 (RXDFELPM_KL_CFG2_REG),
  .RXDFE_CFG0 (RXDFE_CFG0_REG),
  .RXDFE_CFG1 (RXDFE_CFG1_REG),
  .RXDFE_GC_CFG0 (RXDFE_GC_CFG0_REG),
  .RXDFE_GC_CFG1 (RXDFE_GC_CFG1_REG),
  .RXDFE_GC_CFG2 (RXDFE_GC_CFG2_REG),
  .RXDFE_H2_CFG0 (RXDFE_H2_CFG0_REG),
  .RXDFE_H2_CFG1 (RXDFE_H2_CFG1_REG),
  .RXDFE_H3_CFG0 (RXDFE_H3_CFG0_REG),
  .RXDFE_H3_CFG1 (RXDFE_H3_CFG1_REG),
  .RXDFE_H4_CFG0 (RXDFE_H4_CFG0_REG),
  .RXDFE_H4_CFG1 (RXDFE_H4_CFG1_REG),
  .RXDFE_H5_CFG0 (RXDFE_H5_CFG0_REG),
  .RXDFE_H5_CFG1 (RXDFE_H5_CFG1_REG),
  .RXDFE_H6_CFG0 (RXDFE_H6_CFG0_REG),
  .RXDFE_H6_CFG1 (RXDFE_H6_CFG1_REG),
  .RXDFE_H7_CFG0 (RXDFE_H7_CFG0_REG),
  .RXDFE_H7_CFG1 (RXDFE_H7_CFG1_REG),
  .RXDFE_H8_CFG0 (RXDFE_H8_CFG0_REG),
  .RXDFE_H8_CFG1 (RXDFE_H8_CFG1_REG),
  .RXDFE_H9_CFG0 (RXDFE_H9_CFG0_REG),
  .RXDFE_H9_CFG1 (RXDFE_H9_CFG1_REG),
  .RXDFE_HA_CFG0 (RXDFE_HA_CFG0_REG),
  .RXDFE_HA_CFG1 (RXDFE_HA_CFG1_REG),
  .RXDFE_HB_CFG0 (RXDFE_HB_CFG0_REG),
  .RXDFE_HB_CFG1 (RXDFE_HB_CFG1_REG),
  .RXDFE_HC_CFG0 (RXDFE_HC_CFG0_REG),
  .RXDFE_HC_CFG1 (RXDFE_HC_CFG1_REG),
  .RXDFE_HD_CFG0 (RXDFE_HD_CFG0_REG),
  .RXDFE_HD_CFG1 (RXDFE_HD_CFG1_REG),
  .RXDFE_HE_CFG0 (RXDFE_HE_CFG0_REG),
  .RXDFE_HE_CFG1 (RXDFE_HE_CFG1_REG),
  .RXDFE_HF_CFG0 (RXDFE_HF_CFG0_REG),
  .RXDFE_HF_CFG1 (RXDFE_HF_CFG1_REG),
  .RXDFE_OS_CFG0 (RXDFE_OS_CFG0_REG),
  .RXDFE_OS_CFG1 (RXDFE_OS_CFG1_REG),
  .RXDFE_PWR_SAVING (RXDFE_PWR_SAVING_REG),
  .RXDFE_UT_CFG0 (RXDFE_UT_CFG0_REG),
  .RXDFE_UT_CFG1 (RXDFE_UT_CFG1_REG),
  .RXDFE_VP_CFG0 (RXDFE_VP_CFG0_REG),
  .RXDFE_VP_CFG1 (RXDFE_VP_CFG1_REG),
  .RXDLY_CFG (RXDLY_CFG_REG),
  .RXDLY_LCFG (RXDLY_LCFG_REG),
  .RXELECIDLE_CFG (RXELECIDLE_CFG_REG),
  .RXGBOX_FIFO_INIT_RD_ADDR (RXGBOX_FIFO_INIT_RD_ADDR_REG),
  .RXGEARBOX_EN (RXGEARBOX_EN_REG),
  .RXISCANRESET_TIME (RXISCANRESET_TIME_REG),
  .RXLPM_CFG (RXLPM_CFG_REG),
  .RXLPM_GC_CFG (RXLPM_GC_CFG_REG),
  .RXLPM_KH_CFG0 (RXLPM_KH_CFG0_REG),
  .RXLPM_KH_CFG1 (RXLPM_KH_CFG1_REG),
  .RXLPM_OS_CFG0 (RXLPM_OS_CFG0_REG),
  .RXLPM_OS_CFG1 (RXLPM_OS_CFG1_REG),
  .RXOOB_CFG (RXOOB_CFG_REG),
  .RXOOB_CLK_CFG (RXOOB_CLK_CFG_REG),
  .RXOSCALRESET_TIME (RXOSCALRESET_TIME_REG),
  .RXOUT_DIV (RXOUT_DIV_REG),
  .RXPCSRESET_TIME (RXPCSRESET_TIME_REG),
  .RXPHBEACON_CFG (RXPHBEACON_CFG_REG),
  .RXPHDLY_CFG (RXPHDLY_CFG_REG),
  .RXPHSAMP_CFG (RXPHSAMP_CFG_REG),
  .RXPHSLIP_CFG (RXPHSLIP_CFG_REG),
  .RXPH_MONITOR_SEL (RXPH_MONITOR_SEL_REG),
  .RXPI_AUTO_BW_SEL_BYPASS (RXPI_AUTO_BW_SEL_BYPASS_REG),
  .RXPI_CFG (RXPI_CFG_REG),
  .RXPI_LPM (RXPI_LPM_REG),
  .RXPI_RSV0 (RXPI_RSV0_REG),
  .RXPI_SEL_LC (RXPI_SEL_LC_REG),
  .RXPI_STARTCODE (RXPI_STARTCODE_REG),
  .RXPI_VREFSEL (RXPI_VREFSEL_REG),
  .RXPLL_SEL (RXPLL_SEL_REG),
  .RXPMACLK_SEL (RXPMACLK_SEL_REG),
  .RXPMARESET_TIME (RXPMARESET_TIME_REG),
  .RXPRBS_ERR_LOOPBACK (RXPRBS_ERR_LOOPBACK_REG),
  .RXPRBS_LINKACQ_CNT (RXPRBS_LINKACQ_CNT_REG),
  .RXSLIDE_AUTO_WAIT (RXSLIDE_AUTO_WAIT_REG),
  .RXSLIDE_MODE (RXSLIDE_MODE_REG),
  .RXSYNC_MULTILANE (RXSYNC_MULTILANE_REG),
  .RXSYNC_OVRD (RXSYNC_OVRD_REG),
  .RXSYNC_SKIP_DA (RXSYNC_SKIP_DA_REG),
  .RX_AFE_CM_EN (RX_AFE_CM_EN_REG),
  .RX_BIAS_CFG0 (RX_BIAS_CFG0_REG),
  .RX_BUFFER_CFG (RX_BUFFER_CFG_REG),
  .RX_CAPFF_SARC_ENB (RX_CAPFF_SARC_ENB_REG),
  .RX_CLK25_DIV (RX_CLK25_DIV_REG),
  .RX_CLKMUX_EN (RX_CLKMUX_EN_REG),
  .RX_CLK_SLIP_OVRD (RX_CLK_SLIP_OVRD_REG),
  .RX_CM_BUF_CFG (RX_CM_BUF_CFG_REG),
  .RX_CM_BUF_PD (RX_CM_BUF_PD_REG),
  .RX_CM_SEL (RX_CM_SEL_REG),
  .RX_CM_TRIM (RX_CM_TRIM_REG),
  .RX_CTLE1_KHKL (RX_CTLE1_KHKL_REG),
  .RX_CTLE2_KHKL (RX_CTLE2_KHKL_REG),
  .RX_CTLE3_AGC (RX_CTLE3_AGC_REG),
  .RX_DATA_WIDTH (RX_DATA_WIDTH_REG),
  .RX_DDI_SEL (RX_DDI_SEL_REG),
  .RX_DEFER_RESET_BUF_EN (RX_DEFER_RESET_BUF_EN_REG),
  .RX_DEGEN_CTRL (RX_DEGEN_CTRL_REG),
  .RX_DFELPM_CFG0 (RX_DFELPM_CFG0_REG),
  .RX_DFELPM_CFG1 (RX_DFELPM_CFG1_REG),
  .RX_DFELPM_KLKH_AGC_STUP_EN (RX_DFELPM_KLKH_AGC_STUP_EN_REG),
  .RX_DFE_AGC_CFG0 (RX_DFE_AGC_CFG0_REG),
  .RX_DFE_AGC_CFG1 (RX_DFE_AGC_CFG1_REG),
  .RX_DFE_KL_LPM_KH_CFG0 (RX_DFE_KL_LPM_KH_CFG0_REG),
  .RX_DFE_KL_LPM_KH_CFG1 (RX_DFE_KL_LPM_KH_CFG1_REG),
  .RX_DFE_KL_LPM_KL_CFG0 (RX_DFE_KL_LPM_KL_CFG0_REG),
  .RX_DFE_KL_LPM_KL_CFG1 (RX_DFE_KL_LPM_KL_CFG1_REG),
  .RX_DFE_LPM_HOLD_DURING_EIDLE (RX_DFE_LPM_HOLD_DURING_EIDLE_REG),
  .RX_DISPERR_SEQ_MATCH (RX_DISPERR_SEQ_MATCH_REG),
  .RX_DIV2_MODE_B (RX_DIV2_MODE_B_REG),
  .RX_DIVRESET_TIME (RX_DIVRESET_TIME_REG),
  .RX_EN_CTLE_RCAL_B (RX_EN_CTLE_RCAL_B_REG),
  .RX_EN_HI_LR (RX_EN_HI_LR_REG),
  .RX_EXT_RL_CTRL (RX_EXT_RL_CTRL_REG),
  .RX_EYESCAN_VS_CODE (RX_EYESCAN_VS_CODE_REG),
  .RX_EYESCAN_VS_NEG_DIR (RX_EYESCAN_VS_NEG_DIR_REG),
  .RX_EYESCAN_VS_RANGE (RX_EYESCAN_VS_RANGE_REG),
  .RX_EYESCAN_VS_UT_SIGN (RX_EYESCAN_VS_UT_SIGN_REG),
  .RX_FABINT_USRCLK_FLOP (RX_FABINT_USRCLK_FLOP_REG),
  .RX_INT_DATAWIDTH (RX_INT_DATAWIDTH_REG),
  .RX_PMA_POWER_SAVE (RX_PMA_POWER_SAVE_REG),
  .RX_PROGDIV_CFG (RX_PROGDIV_CFG_REG),
  .RX_PROGDIV_RATE (RX_PROGDIV_RATE_REG),
  .RX_RESLOAD_CTRL (RX_RESLOAD_CTRL_REG),
  .RX_RESLOAD_OVRD (RX_RESLOAD_OVRD_REG),
  .RX_SAMPLE_PERIOD (RX_SAMPLE_PERIOD_REG),
  .RX_SIG_VALID_DLY (RX_SIG_VALID_DLY_REG),
  .RX_SUM_DFETAPREP_EN (RX_SUM_DFETAPREP_EN_REG),
  .RX_SUM_IREF_TUNE (RX_SUM_IREF_TUNE_REG),
  .RX_SUM_VCMTUNE (RX_SUM_VCMTUNE_REG),
  .RX_SUM_VCM_OVWR (RX_SUM_VCM_OVWR_REG),
  .RX_SUM_VREF_TUNE (RX_SUM_VREF_TUNE_REG),
  .RX_TUNE_AFE_OS (RX_TUNE_AFE_OS_REG),
  .RX_VREG_CTRL (RX_VREG_CTRL_REG),
  .RX_VREG_PDB (RX_VREG_PDB_REG),
  .RX_WIDEMODE_CDR (RX_WIDEMODE_CDR_REG),
  .RX_XCLK_SEL (RX_XCLK_SEL_REG),
  .RX_XMODE_SEL (RX_XMODE_SEL_REG),
  .SAS_MAX_COM (SAS_MAX_COM_REG),
  .SAS_MIN_COM (SAS_MIN_COM_REG),
  .SATA_BURST_SEQ_LEN (SATA_BURST_SEQ_LEN_REG),
  .SATA_BURST_VAL (SATA_BURST_VAL_REG),
  .SATA_CPLL_CFG (SATA_CPLL_CFG_REG),
  .SATA_EIDLE_VAL (SATA_EIDLE_VAL_REG),
  .SATA_MAX_BURST (SATA_MAX_BURST_REG),
  .SATA_MAX_INIT (SATA_MAX_INIT_REG),
  .SATA_MAX_WAKE (SATA_MAX_WAKE_REG),
  .SATA_MIN_BURST (SATA_MIN_BURST_REG),
  .SATA_MIN_INIT (SATA_MIN_INIT_REG),
  .SATA_MIN_WAKE (SATA_MIN_WAKE_REG),
  .SHOW_REALIGN_COMMA (SHOW_REALIGN_COMMA_REG),
  .TAPDLY_SET_TX (TAPDLY_SET_TX_REG),
  .TEMPERATURE_PAR (TEMPERATURE_PAR_REG),
  .TERM_RCAL_CFG (TERM_RCAL_CFG_REG),
  .TERM_RCAL_OVRD (TERM_RCAL_OVRD_REG),
  .TRANS_TIME_RATE (TRANS_TIME_RATE_REG),
  .TST_RSV0 (TST_RSV0_REG),
  .TST_RSV1 (TST_RSV1_REG),
  .TXBUF_EN (TXBUF_EN_REG),
  .TXBUF_RESET_ON_RATE_CHANGE (TXBUF_RESET_ON_RATE_CHANGE_REG),
  .TXDLY_CFG (TXDLY_CFG_REG),
  .TXDLY_LCFG (TXDLY_LCFG_REG),
  .TXFIFO_ADDR_CFG (TXFIFO_ADDR_CFG_REG),
  .TXGBOX_FIFO_INIT_RD_ADDR (TXGBOX_FIFO_INIT_RD_ADDR_REG),
  .TXGEARBOX_EN (TXGEARBOX_EN_REG),
  .TXOUTCLKPCS_SEL (TXOUTCLKPCS_SEL_REG),
  .TXOUT_DIV (TXOUT_DIV_REG),
  .TXPCSRESET_TIME (TXPCSRESET_TIME_REG),
  .TXPHDLY_CFG0 (TXPHDLY_CFG0_REG),
  .TXPHDLY_CFG1 (TXPHDLY_CFG1_REG),
  .TXPH_CFG (TXPH_CFG_REG),
  .TXPH_CFG2 (TXPH_CFG2_REG),
  .TXPH_MONITOR_SEL (TXPH_MONITOR_SEL_REG),
  .TXPI_CFG0 (TXPI_CFG0_REG),
  .TXPI_CFG1 (TXPI_CFG1_REG),
  .TXPI_CFG2 (TXPI_CFG2_REG),
  .TXPI_CFG3 (TXPI_CFG3_REG),
  .TXPI_CFG4 (TXPI_CFG4_REG),
  .TXPI_CFG5 (TXPI_CFG5_REG),
  .TXPI_GRAY_SEL (TXPI_GRAY_SEL_REG),
  .TXPI_INVSTROBE_SEL (TXPI_INVSTROBE_SEL_REG),
  .TXPI_LPM (TXPI_LPM_REG),
  .TXPI_PPMCLK_SEL (TXPI_PPMCLK_SEL_REG),
  .TXPI_PPM_CFG (TXPI_PPM_CFG_REG),
  .TXPI_RSV0 (TXPI_RSV0_REG),
  .TXPI_SYNFREQ_PPM (TXPI_SYNFREQ_PPM_REG),
  .TXPI_VREFSEL (TXPI_VREFSEL_REG),
  .TXPMARESET_TIME (TXPMARESET_TIME_REG),
  .TXSYNC_MULTILANE (TXSYNC_MULTILANE_REG),
  .TXSYNC_OVRD (TXSYNC_OVRD_REG),
  .TXSYNC_SKIP_DA (TXSYNC_SKIP_DA_REG),
  .TX_CLK25_DIV (TX_CLK25_DIV_REG),
  .TX_CLKMUX_EN (TX_CLKMUX_EN_REG),
  .TX_CLKREG_PDB (TX_CLKREG_PDB_REG),
  .TX_CLKREG_SET (TX_CLKREG_SET_REG),
  .TX_DATA_WIDTH (TX_DATA_WIDTH_REG),
  .TX_DCD_CFG (TX_DCD_CFG_REG),
  .TX_DCD_EN (TX_DCD_EN_REG),
  .TX_DEEMPH0 (TX_DEEMPH0_REG),
  .TX_DEEMPH1 (TX_DEEMPH1_REG),
  .TX_DIVRESET_TIME (TX_DIVRESET_TIME_REG),
  .TX_DRIVE_MODE (TX_DRIVE_MODE_REG),
  .TX_DRVMUX_CTRL (TX_DRVMUX_CTRL_REG),
  .TX_EIDLE_ASSERT_DELAY (TX_EIDLE_ASSERT_DELAY_REG),
  .TX_EIDLE_DEASSERT_DELAY (TX_EIDLE_DEASSERT_DELAY_REG),
  .TX_EML_PHI_TUNE (TX_EML_PHI_TUNE_REG),
  .TX_FABINT_USRCLK_FLOP (TX_FABINT_USRCLK_FLOP_REG),
  .TX_FIFO_BYP_EN (TX_FIFO_BYP_EN_REG),
  .TX_IDLE_DATA_ZERO (TX_IDLE_DATA_ZERO_REG),
  .TX_INT_DATAWIDTH (TX_INT_DATAWIDTH_REG),
  .TX_LOOPBACK_DRIVE_HIZ (TX_LOOPBACK_DRIVE_HIZ_REG),
  .TX_MAINCURSOR_SEL (TX_MAINCURSOR_SEL_REG),
  .TX_MARGIN_FULL_0 (TX_MARGIN_FULL_0_REG),
  .TX_MARGIN_FULL_1 (TX_MARGIN_FULL_1_REG),
  .TX_MARGIN_FULL_2 (TX_MARGIN_FULL_2_REG),
  .TX_MARGIN_FULL_3 (TX_MARGIN_FULL_3_REG),
  .TX_MARGIN_FULL_4 (TX_MARGIN_FULL_4_REG),
  .TX_MARGIN_LOW_0 (TX_MARGIN_LOW_0_REG),
  .TX_MARGIN_LOW_1 (TX_MARGIN_LOW_1_REG),
  .TX_MARGIN_LOW_2 (TX_MARGIN_LOW_2_REG),
  .TX_MARGIN_LOW_3 (TX_MARGIN_LOW_3_REG),
  .TX_MARGIN_LOW_4 (TX_MARGIN_LOW_4_REG),
  .TX_MODE_SEL (TX_MODE_SEL_REG),
  .TX_PHICAL_CFG0 (TX_PHICAL_CFG0_REG),
  .TX_PHICAL_CFG1 (TX_PHICAL_CFG1_REG),
  .TX_PHICAL_CFG2 (TX_PHICAL_CFG2_REG),
  .TX_PI_BIASSET (TX_PI_BIASSET_REG),
  .TX_PI_CFG0 (TX_PI_CFG0_REG),
  .TX_PI_CFG1 (TX_PI_CFG1_REG),
  .TX_PI_DIV2_MODE_B (TX_PI_DIV2_MODE_B_REG),
  .TX_PI_SEL_QPLL0 (TX_PI_SEL_QPLL0_REG),
  .TX_PI_SEL_QPLL1 (TX_PI_SEL_QPLL1_REG),
  .TX_PMADATA_OPT (TX_PMADATA_OPT_REG),
  .TX_PMA_POWER_SAVE (TX_PMA_POWER_SAVE_REG),
  .TX_PREDRV_CTRL (TX_PREDRV_CTRL_REG),
  .TX_PROGCLK_SEL (TX_PROGCLK_SEL_REG),
  .TX_PROGDIV_CFG (TX_PROGDIV_CFG_REG),
  .TX_PROGDIV_RATE (TX_PROGDIV_RATE_REG),
  .TX_RXDETECT_CFG (TX_RXDETECT_CFG_REG),
  .TX_RXDETECT_REF (TX_RXDETECT_REF_REG),
  .TX_SAMPLE_PERIOD (TX_SAMPLE_PERIOD_REG),
  .TX_SARC_LPBK_ENB (TX_SARC_LPBK_ENB_REG),
  .TX_USERPATTERN_DATA0 (TX_USERPATTERN_DATA0_REG),
  .TX_USERPATTERN_DATA1 (TX_USERPATTERN_DATA1_REG),
  .TX_USERPATTERN_DATA2 (TX_USERPATTERN_DATA2_REG),
  .TX_USERPATTERN_DATA3 (TX_USERPATTERN_DATA3_REG),
  .TX_USERPATTERN_DATA4 (TX_USERPATTERN_DATA4_REG),
  .TX_USERPATTERN_DATA5 (TX_USERPATTERN_DATA5_REG),
  .TX_USERPATTERN_DATA6 (TX_USERPATTERN_DATA6_REG),
  .TX_USERPATTERN_DATA7 (TX_USERPATTERN_DATA7_REG),
  .TX_XCLK_SEL (TX_XCLK_SEL_REG),
  .USE_PCS_CLK_PHASE_SEL (USE_PCS_CLK_PHASE_SEL_REG),
  .BUFGTCE (BUFGTCE_out),
  .BUFGTCEMASK (BUFGTCEMASK_out),
  .BUFGTDIV (BUFGTDIV_out),
  .BUFGTRESET (BUFGTRESET_out),
  .BUFGTRSTMASK (BUFGTRSTMASK_out),
  .CPLLFBCLKLOST (CPLLFBCLKLOST_out),
  .CPLLLOCK (CPLLLOCK_out),
  .CPLLREFCLKLOST (CPLLREFCLKLOST_out),
  .DMONITOROUT (DMONITOROUT_out),
  .DRPDO (DRPDO_out),
  .DRPRDY (DRPRDY_out),
  .EYESCANDATAERROR (EYESCANDATAERROR_out),
  .GTPOWERGOOD (GTPOWERGOOD_out),
  .GTREFCLKMONITOR (GTREFCLKMONITOR_out),
  .GTYTXN (GTYTXN_out),
  .GTYTXP (GTYTXP_out),
  .PCIERATEGEN3 (PCIERATEGEN3_out),
  .PCIERATEIDLE (PCIERATEIDLE_out),
  .PCIERATEQPLLPD (PCIERATEQPLLPD_out),
  .PCIERATEQPLLRESET (PCIERATEQPLLRESET_out),
  .PCIESYNCTXSYNCDONE (PCIESYNCTXSYNCDONE_out),
  .PCIEUSERGEN3RDY (PCIEUSERGEN3RDY_out),
  .PCIEUSERPHYSTATUSRST (PCIEUSERPHYSTATUSRST_out),
  .PCIEUSERRATESTART (PCIEUSERRATESTART_out),
  .PCSRSVDOUT (PCSRSVDOUT_out),
  .PHYSTATUS (PHYSTATUS_out),
  .PINRSRVDAS (PINRSRVDAS_out),
  .PMASCANOUT (PMASCANOUT_out),
  .RESETEXCEPTION (RESETEXCEPTION_out),
  .RXBUFSTATUS (RXBUFSTATUS_out),
  .RXBYTEISALIGNED (RXBYTEISALIGNED_out),
  .RXBYTEREALIGN (RXBYTEREALIGN_out),
  .RXCDRLOCK (RXCDRLOCK_out),
  .RXCDRPHDONE (RXCDRPHDONE_out),
  .RXCHANBONDSEQ (RXCHANBONDSEQ_out),
  .RXCHANISALIGNED (RXCHANISALIGNED_out),
  .RXCHANREALIGN (RXCHANREALIGN_out),
  .RXCHBONDO (RXCHBONDO_out),
  .RXCKOKDONE (RXCKOKDONE_out),
  .RXCLKCORCNT (RXCLKCORCNT_out),
  .RXCOMINITDET (RXCOMINITDET_out),
  .RXCOMMADET (RXCOMMADET_out),
  .RXCOMSASDET (RXCOMSASDET_out),
  .RXCOMWAKEDET (RXCOMWAKEDET_out),
  .RXCTRL0 (RXCTRL0_out),
  .RXCTRL1 (RXCTRL1_out),
  .RXCTRL2 (RXCTRL2_out),
  .RXCTRL3 (RXCTRL3_out),
  .RXDATA (RXDATA_out),
  .RXDATAEXTENDRSVD (RXDATAEXTENDRSVD_out),
  .RXDATAVALID (RXDATAVALID_out),
  .RXDLYSRESETDONE (RXDLYSRESETDONE_out),
  .RXELECIDLE (RXELECIDLE_out),
  .RXHEADER (RXHEADER_out),
  .RXHEADERVALID (RXHEADERVALID_out),
  .RXMONITOROUT (RXMONITOROUT_out),
  .RXOSINTDONE (RXOSINTDONE_out),
  .RXOSINTSTARTED (RXOSINTSTARTED_out),
  .RXOSINTSTROBEDONE (RXOSINTSTROBEDONE_out),
  .RXOSINTSTROBESTARTED (RXOSINTSTROBESTARTED_out),
  .RXOUTCLK (RXOUTCLK_out),
  .RXOUTCLKFABRIC (RXOUTCLKFABRIC_out),
  .RXOUTCLKPCS (RXOUTCLKPCS_out),
  .RXPHALIGNDONE (RXPHALIGNDONE_out),
  .RXPHALIGNERR (RXPHALIGNERR_out),
  .RXPMARESETDONE (RXPMARESETDONE_out),
  .RXPRBSERR (RXPRBSERR_out),
  .RXPRBSLOCKED (RXPRBSLOCKED_out),
  .RXPRGDIVRESETDONE (RXPRGDIVRESETDONE_out),
  .RXRATEDONE (RXRATEDONE_out),
  .RXRECCLKOUT (RXRECCLKOUT_out),
  .RXRESETDONE (RXRESETDONE_out),
  .RXSLIDERDY (RXSLIDERDY_out),
  .RXSLIPDONE (RXSLIPDONE_out),
  .RXSLIPOUTCLKRDY (RXSLIPOUTCLKRDY_out),
  .RXSLIPPMARDY (RXSLIPPMARDY_out),
  .RXSTARTOFSEQ (RXSTARTOFSEQ_out),
  .RXSTATUS (RXSTATUS_out),
  .RXSYNCDONE (RXSYNCDONE_out),
  .RXSYNCOUT (RXSYNCOUT_out),
  .RXVALID (RXVALID_out),
  .SCANOUT (SCANOUT_out),
  .TXBUFSTATUS (TXBUFSTATUS_out),
  .TXCOMFINISH (TXCOMFINISH_out),
  .TXDCCDONE (TXDCCDONE_out),
  .TXDLYSRESETDONE (TXDLYSRESETDONE_out),
  .TXOUTCLK (TXOUTCLK_out),
  .TXOUTCLKFABRIC (TXOUTCLKFABRIC_out),
  .TXOUTCLKPCS (TXOUTCLKPCS_out),
  .TXPHALIGNDONE (TXPHALIGNDONE_out),
  .TXPHINITDONE (TXPHINITDONE_out),
  .TXPMARESETDONE (TXPMARESETDONE_out),
  .TXPRGDIVRESETDONE (TXPRGDIVRESETDONE_out),
  .TXRATEDONE (TXRATEDONE_out),
  .TXRESETDONE (TXRESETDONE_out),
  .TXSYNCDONE (TXSYNCDONE_out),
  .TXSYNCOUT (TXSYNCOUT_out),
  .CDRSTEPDIR (CDRSTEPDIR_in),
  .CDRSTEPSQ (CDRSTEPSQ_in),
  .CDRSTEPSX (CDRSTEPSX_in),
  .CFGRESET (CFGRESET_in),
  .CLKRSVD0 (CLKRSVD0_in),
  .CLKRSVD1 (CLKRSVD1_in),
  .CPLLLOCKDETCLK (CPLLLOCKDETCLK_in),
  .CPLLLOCKEN (CPLLLOCKEN_in),
  .CPLLPD (CPLLPD_in),
  .CPLLREFCLKSEL (CPLLREFCLKSEL_in),
  .CPLLRESET (CPLLRESET_in),
  .DMONFIFORESET (DMONFIFORESET_in),
  .DMONITORCLK (DMONITORCLK_in),
  .DRPADDR (DRPADDR_in),
  .DRPCLK (DRPCLK_in),
  .DRPDI (DRPDI_in),
  .DRPEN (DRPEN_in),
  .DRPWE (DRPWE_in),
  .ELPCALDVORWREN (ELPCALDVORWREN_in),
  .ELPCALPAORWREN (ELPCALPAORWREN_in),
  .EVODDPHICALDONE (EVODDPHICALDONE_in),
  .EVODDPHICALSTART (EVODDPHICALSTART_in),
  .EVODDPHIDRDEN (EVODDPHIDRDEN_in),
  .EVODDPHIDWREN (EVODDPHIDWREN_in),
  .EVODDPHIXRDEN (EVODDPHIXRDEN_in),
  .EVODDPHIXWREN (EVODDPHIXWREN_in),
  .EYESCANMODE (EYESCANMODE_in),
  .EYESCANRESET (EYESCANRESET_in),
  .EYESCANTRIGGER (EYESCANTRIGGER_in),
  .GTGREFCLK (GTGREFCLK_in),
  .GTNORTHREFCLK0 (GTNORTHREFCLK0_in),
  .GTNORTHREFCLK1 (GTNORTHREFCLK1_in),
  .GTREFCLK0 (GTREFCLK0_in),
  .GTREFCLK1 (GTREFCLK1_in),
  .GTRESETSEL (GTRESETSEL_in),
  .GTRSVD (GTRSVD_in),
  .GTRXRESET (GTRXRESET_in),
  .GTSOUTHREFCLK0 (GTSOUTHREFCLK0_in),
  .GTSOUTHREFCLK1 (GTSOUTHREFCLK1_in),
  .GTTXRESET (GTTXRESET_in),
  .GTYRXN (GTYRXN_in),
  .GTYRXP (GTYRXP_in),
  .LOOPBACK (LOOPBACK_in),
  .LOOPRSVD (LOOPRSVD_in),
  .LPBKRXTXSEREN (LPBKRXTXSEREN_in),
  .LPBKTXRXSEREN (LPBKTXRXSEREN_in),
  .PCIEEQRXEQADAPTDONE (PCIEEQRXEQADAPTDONE_in),
  .PCIERSTIDLE (PCIERSTIDLE_in),
  .PCIERSTTXSYNCSTART (PCIERSTTXSYNCSTART_in),
  .PCIEUSERRATEDONE (PCIEUSERRATEDONE_in),
  .PCSRSVDIN (PCSRSVDIN_in),
  .PCSRSVDIN2 (PCSRSVDIN2_in),
  .PMARSVDIN (PMARSVDIN_in),
  .PMASCANCLK0 (PMASCANCLK0_in),
  .PMASCANCLK1 (PMASCANCLK1_in),
  .PMASCANCLK2 (PMASCANCLK2_in),
  .PMASCANCLK3 (PMASCANCLK3_in),
  .PMASCANCLK4 (PMASCANCLK4_in),
  .PMASCANCLK5 (PMASCANCLK5_in),
  .PMASCANENB (PMASCANENB_in),
  .PMASCANIN (PMASCANIN_in),
  .PMASCANMODEB (PMASCANMODEB_in),
  .PMASCANRSTEN (PMASCANRSTEN_in),
  .QPLL0CLK (QPLL0CLK_in),
  .QPLL0REFCLK (QPLL0REFCLK_in),
  .QPLL1CLK (QPLL1CLK_in),
  .QPLL1REFCLK (QPLL1REFCLK_in),
  .RESETOVRD (RESETOVRD_in),
  .RSTCLKENTX (RSTCLKENTX_in),
  .RX8B10BEN (RX8B10BEN_in),
  .RXBUFRESET (RXBUFRESET_in),
  .RXCDRFREQRESET (RXCDRFREQRESET_in),
  .RXCDRHOLD (RXCDRHOLD_in),
  .RXCDROVRDEN (RXCDROVRDEN_in),
  .RXCDRRESET (RXCDRRESET_in),
  .RXCDRRESETRSV (RXCDRRESETRSV_in),
  .RXCHBONDEN (RXCHBONDEN_in),
  .RXCHBONDI (RXCHBONDI_in),
  .RXCHBONDLEVEL (RXCHBONDLEVEL_in),
  .RXCHBONDMASTER (RXCHBONDMASTER_in),
  .RXCHBONDSLAVE (RXCHBONDSLAVE_in),
  .RXCKOKRESET (RXCKOKRESET_in),
  .RXCOMMADETEN (RXCOMMADETEN_in),
  .RXDCCFORCESTART (RXDCCFORCESTART_in),
  .RXDFEAGCHOLD (RXDFEAGCHOLD_in),
  .RXDFEAGCOVRDEN (RXDFEAGCOVRDEN_in),
  .RXDFELFHOLD (RXDFELFHOLD_in),
  .RXDFELFOVRDEN (RXDFELFOVRDEN_in),
  .RXDFELPMRESET (RXDFELPMRESET_in),
  .RXDFETAP10HOLD (RXDFETAP10HOLD_in),
  .RXDFETAP10OVRDEN (RXDFETAP10OVRDEN_in),
  .RXDFETAP11HOLD (RXDFETAP11HOLD_in),
  .RXDFETAP11OVRDEN (RXDFETAP11OVRDEN_in),
  .RXDFETAP12HOLD (RXDFETAP12HOLD_in),
  .RXDFETAP12OVRDEN (RXDFETAP12OVRDEN_in),
  .RXDFETAP13HOLD (RXDFETAP13HOLD_in),
  .RXDFETAP13OVRDEN (RXDFETAP13OVRDEN_in),
  .RXDFETAP14HOLD (RXDFETAP14HOLD_in),
  .RXDFETAP14OVRDEN (RXDFETAP14OVRDEN_in),
  .RXDFETAP15HOLD (RXDFETAP15HOLD_in),
  .RXDFETAP15OVRDEN (RXDFETAP15OVRDEN_in),
  .RXDFETAP2HOLD (RXDFETAP2HOLD_in),
  .RXDFETAP2OVRDEN (RXDFETAP2OVRDEN_in),
  .RXDFETAP3HOLD (RXDFETAP3HOLD_in),
  .RXDFETAP3OVRDEN (RXDFETAP3OVRDEN_in),
  .RXDFETAP4HOLD (RXDFETAP4HOLD_in),
  .RXDFETAP4OVRDEN (RXDFETAP4OVRDEN_in),
  .RXDFETAP5HOLD (RXDFETAP5HOLD_in),
  .RXDFETAP5OVRDEN (RXDFETAP5OVRDEN_in),
  .RXDFETAP6HOLD (RXDFETAP6HOLD_in),
  .RXDFETAP6OVRDEN (RXDFETAP6OVRDEN_in),
  .RXDFETAP7HOLD (RXDFETAP7HOLD_in),
  .RXDFETAP7OVRDEN (RXDFETAP7OVRDEN_in),
  .RXDFETAP8HOLD (RXDFETAP8HOLD_in),
  .RXDFETAP8OVRDEN (RXDFETAP8OVRDEN_in),
  .RXDFETAP9HOLD (RXDFETAP9HOLD_in),
  .RXDFETAP9OVRDEN (RXDFETAP9OVRDEN_in),
  .RXDFEUTHOLD (RXDFEUTHOLD_in),
  .RXDFEUTOVRDEN (RXDFEUTOVRDEN_in),
  .RXDFEVPHOLD (RXDFEVPHOLD_in),
  .RXDFEVPOVRDEN (RXDFEVPOVRDEN_in),
  .RXDFEVSEN (RXDFEVSEN_in),
  .RXDFEXYDEN (RXDFEXYDEN_in),
  .RXDLYBYPASS (RXDLYBYPASS_in),
  .RXDLYEN (RXDLYEN_in),
  .RXDLYOVRDEN (RXDLYOVRDEN_in),
  .RXDLYSRESET (RXDLYSRESET_in),
  .RXELECIDLEMODE (RXELECIDLEMODE_in),
  .RXGEARBOXSLIP (RXGEARBOXSLIP_in),
  .RXLATCLK (RXLATCLK_in),
  .RXLPMEN (RXLPMEN_in),
  .RXLPMGCHOLD (RXLPMGCHOLD_in),
  .RXLPMGCOVRDEN (RXLPMGCOVRDEN_in),
  .RXLPMHFHOLD (RXLPMHFHOLD_in),
  .RXLPMHFOVRDEN (RXLPMHFOVRDEN_in),
  .RXLPMLFHOLD (RXLPMLFHOLD_in),
  .RXLPMLFKLOVRDEN (RXLPMLFKLOVRDEN_in),
  .RXLPMOSHOLD (RXLPMOSHOLD_in),
  .RXLPMOSOVRDEN (RXLPMOSOVRDEN_in),
  .RXMCOMMAALIGNEN (RXMCOMMAALIGNEN_in),
  .RXMONITORSEL (RXMONITORSEL_in),
  .RXOOBRESET (RXOOBRESET_in),
  .RXOSCALRESET (RXOSCALRESET_in),
  .RXOSHOLD (RXOSHOLD_in),
  .RXOSINTCFG (RXOSINTCFG_in),
  .RXOSINTEN (RXOSINTEN_in),
  .RXOSINTHOLD (RXOSINTHOLD_in),
  .RXOSINTOVRDEN (RXOSINTOVRDEN_in),
  .RXOSINTSTROBE (RXOSINTSTROBE_in),
  .RXOSINTTESTOVRDEN (RXOSINTTESTOVRDEN_in),
  .RXOSOVRDEN (RXOSOVRDEN_in),
  .RXOUTCLKSEL (RXOUTCLKSEL_in),
  .RXPCOMMAALIGNEN (RXPCOMMAALIGNEN_in),
  .RXPCSRESET (RXPCSRESET_in),
  .RXPD (RXPD_in),
  .RXPHALIGN (RXPHALIGN_in),
  .RXPHALIGNEN (RXPHALIGNEN_in),
  .RXPHDLYPD (RXPHDLYPD_in),
  .RXPHDLYRESET (RXPHDLYRESET_in),
  .RXPHOVRDEN (RXPHOVRDEN_in),
  .RXPLLCLKSEL (RXPLLCLKSEL_in),
  .RXPMARESET (RXPMARESET_in),
  .RXPOLARITY (RXPOLARITY_in),
  .RXPRBSCNTRESET (RXPRBSCNTRESET_in),
  .RXPRBSSEL (RXPRBSSEL_in),
  .RXPROGDIVRESET (RXPROGDIVRESET_in),
  .RXRATE (RXRATE_in),
  .RXRATEMODE (RXRATEMODE_in),
  .RXSLIDE (RXSLIDE_in),
  .RXSLIPOUTCLK (RXSLIPOUTCLK_in),
  .RXSLIPPMA (RXSLIPPMA_in),
  .RXSYNCALLIN (RXSYNCALLIN_in),
  .RXSYNCIN (RXSYNCIN_in),
  .RXSYNCMODE (RXSYNCMODE_in),
  .RXSYSCLKSEL (RXSYSCLKSEL_in),
  .RXUSERRDY (RXUSERRDY_in),
  .RXUSRCLK (RXUSRCLK_in),
  .RXUSRCLK2 (RXUSRCLK2_in),
  .SARCCLK (SARCCLK_in),
  .SCANCLK (SCANCLK_in),
  .SCANENB (SCANENB_in),
  .SCANIN (SCANIN_in),
  .SCANMODEB (SCANMODEB_in),
  .SIGVALIDCLK (SIGVALIDCLK_in),
  .TSTCLK0 (TSTCLK0_in),
  .TSTCLK1 (TSTCLK1_in),
  .TSTIN (TSTIN_in),
  .TSTPD (TSTPD_in),
  .TSTPDOVRDB (TSTPDOVRDB_in),
  .TX8B10BBYPASS (TX8B10BBYPASS_in),
  .TX8B10BEN (TX8B10BEN_in),
  .TXBUFDIFFCTRL (TXBUFDIFFCTRL_in),
  .TXCOMINIT (TXCOMINIT_in),
  .TXCOMSAS (TXCOMSAS_in),
  .TXCOMWAKE (TXCOMWAKE_in),
  .TXCTRL0 (TXCTRL0_in),
  .TXCTRL1 (TXCTRL1_in),
  .TXCTRL2 (TXCTRL2_in),
  .TXDATA (TXDATA_in),
  .TXDATAEXTENDRSVD (TXDATAEXTENDRSVD_in),
  .TXDCCFORCESTART (TXDCCFORCESTART_in),
  .TXDCCRESET (TXDCCRESET_in),
  .TXDEEMPH (TXDEEMPH_in),
  .TXDETECTRX (TXDETECTRX_in),
  .TXDIFFCTRL (TXDIFFCTRL_in),
  .TXDIFFPD (TXDIFFPD_in),
  .TXDLYBYPASS (TXDLYBYPASS_in),
  .TXDLYEN (TXDLYEN_in),
  .TXDLYHOLD (TXDLYHOLD_in),
  .TXDLYOVRDEN (TXDLYOVRDEN_in),
  .TXDLYSRESET (TXDLYSRESET_in),
  .TXDLYUPDOWN (TXDLYUPDOWN_in),
  .TXELECIDLE (TXELECIDLE_in),
  .TXELFORCESTART (TXELFORCESTART_in),
  .TXHEADER (TXHEADER_in),
  .TXINHIBIT (TXINHIBIT_in),
  .TXLATCLK (TXLATCLK_in),
  .TXMAINCURSOR (TXMAINCURSOR_in),
  .TXMARGIN (TXMARGIN_in),
  .TXOUTCLKSEL (TXOUTCLKSEL_in),
  .TXPCSRESET (TXPCSRESET_in),
  .TXPD (TXPD_in),
  .TXPDELECIDLEMODE (TXPDELECIDLEMODE_in),
  .TXPHALIGN (TXPHALIGN_in),
  .TXPHALIGNEN (TXPHALIGNEN_in),
  .TXPHDLYPD (TXPHDLYPD_in),
  .TXPHDLYRESET (TXPHDLYRESET_in),
  .TXPHDLYTSTCLK (TXPHDLYTSTCLK_in),
  .TXPHINIT (TXPHINIT_in),
  .TXPHOVRDEN (TXPHOVRDEN_in),
  .TXPIPPMEN (TXPIPPMEN_in),
  .TXPIPPMOVRDEN (TXPIPPMOVRDEN_in),
  .TXPIPPMPD (TXPIPPMPD_in),
  .TXPIPPMSEL (TXPIPPMSEL_in),
  .TXPIPPMSTEPSIZE (TXPIPPMSTEPSIZE_in),
  .TXPISOPD (TXPISOPD_in),
  .TXPLLCLKSEL (TXPLLCLKSEL_in),
  .TXPMARESET (TXPMARESET_in),
  .TXPOLARITY (TXPOLARITY_in),
  .TXPOSTCURSOR (TXPOSTCURSOR_in),
  .TXPRBSFORCEERR (TXPRBSFORCEERR_in),
  .TXPRBSSEL (TXPRBSSEL_in),
  .TXPRECURSOR (TXPRECURSOR_in),
  .TXPROGDIVRESET (TXPROGDIVRESET_in),
  .TXRATE (TXRATE_in),
  .TXRATEMODE (TXRATEMODE_in),
  .TXSEQUENCE (TXSEQUENCE_in),
  .TXSWING (TXSWING_in),
  .TXSYNCALLIN (TXSYNCALLIN_in),
  .TXSYNCIN (TXSYNCIN_in),
  .TXSYNCMODE (TXSYNCMODE_in),
  .TXSYSCLKSEL (TXSYSCLKSEL_in),
  .TXUSERRDY (TXUSERRDY_in),
  .TXUSRCLK (TXUSRCLK_in),
  .TXUSRCLK2 (TXUSRCLK2_in),
  .GSR (glblGSR)
);


endmodule

`endcelldefine
