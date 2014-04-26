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
//  /   /                        Input Fixed or Variable Delay Element
// /___/   /\      Filename    : ODELAYE3.v
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
module ODELAYE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE = "NONE",
  parameter DELAY_FORMAT = "TIME",
  parameter DELAY_TYPE = "FIXED",
  parameter integer DELAY_VALUE = 0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter real REFCLK_FREQUENCY = 300.0,
  parameter UPDATE_MODE = "ASYNC"
)(
  output CASC_OUT,
  output [8:0] CNTVALUEOUT,
  output DATAOUT,

  input CASC_IN,
  input CASC_RETURN,
  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input EN_VTC,
  input ODATAIN,
  input INC,
  input LOAD,
  input RST
);
  
// define constants
  localparam MODULE_NAME = "ODELAYE3";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;
  localparam MAX_DELAY_COUNT = 511; 
  localparam MIN_DELAY_COUNT = 0;
  localparam PER_BIT_FINE_DELAY = 5;
  localparam PER_BIT_MEDIUM_DELAY = 40;
  localparam INTRINSIC_FINE_DELAY = 90;
  localparam INTRINSIC_MEDIUM_DELAY = 40;

  localparam ODATAIN_INTRINSIC_DELAY = 50;
  localparam CASC_IN_INTRINSIC_DELAY = 50;
  //localparam CASC_RET_INTRINSIC_DELAY = 50;
  localparam CASC_RET_INTRINSIC_DELAY = 0;

  localparam DATA_OUT_INTRINSIC_DELAY = 40;
  localparam CASC_OUT_INTRINSIC_DELAY = 40;


// Parameter encodings and registers
  localparam CASCADE_MASTER = 2'b11;
  localparam CASCADE_NONE = 2'b00;
  localparam CASCADE_SLAVE_END = 2'b01;
  localparam CASCADE_SLAVE_MIDDLE = 2'b10;
  localparam DELAY_FORMAT_COUNT = 1;
  localparam DELAY_FORMAT_TIME = 0;
  localparam DELAY_TYPE_FIXED = 2'b00;
  localparam DELAY_TYPE_VARIABLE = 2'b01;
  localparam DELAY_TYPE_VAR_LOAD = 2'b10;
  localparam DELAY_VALUE_0 = 0;
  localparam UPDATE_MODE_ASYNC = 2'b00;
  localparam UPDATE_MODE_MANUAL = 2'b01;
  localparam UPDATE_MODE_SYNC = 2'b10;

  `ifndef XIL_DR
  localparam CASCADE_REG = CASCADE;
  localparam DELAY_FORMAT_REG = DELAY_FORMAT;
  localparam DELAY_TYPE_REG = DELAY_TYPE;
  localparam DELAY_VALUE_REG = DELAY_VALUE;
  localparam IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam IS_RST_INVERTED_REG = IS_RST_INVERTED;
  localparam UPDATE_MODE_REG = UPDATE_MODE;
  localparam real REFCLK_FREQUENCY_REG = REFCLK_FREQUENCY;
  `endif
  wire [1:0] CASCADE_BIN;
  wire DELAY_FORMAT_BIN;
  wire [1:0] DELAY_TYPE_BIN;
  //wire DELAY_VALUE_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire IS_RST_INVERTED_BIN;
  wire [1:0] UPDATE_MODE_BIN;
  wire [63:0] REFCLK_FREQUENCY_BIN;


  tri0 glblGSR = glbl.GSR;
  
  `ifdef XIL_TIMING //Simprim 
  reg notifier;
  `endif
  reg trig_attr = 1'b0;
  reg attr_err = 1'b0;
  
// include dynamic registers - XILINX test only
  `ifdef XIL_DR
  `include "ODELAYE3_dr.v"
  `endif

  reg CASC_OUT_reg;
  reg DATAOUT_reg;
  reg [8:0] CNTVALUEOUT_reg;
  reg [8:0] qcntvalueout_reg = 9'b0;
  reg tap_out;
  reg clk_smux;
  reg tap_out_casc_out_none;
  reg tap_out_casc_out;
  reg tap_out_data_out;
  reg data_mux = 0;
  wire CASC_OUT_delay;
  wire DATAOUT_delay;
  wire [8:0] CNTVALUEOUT_delay;

  wire CASC_IN_in;
  wire CASC_RETURN_in;
  wire CE_in;
  wire CLK_in;
  wire EN_VTC_in;
  wire ODATAIN_in;
  wire INC_in;
  wire LOAD_in;
  wire RST_in;
  reg RST_sync1;
  reg RST_sync2;
  reg RST_sync3;
  wire [8:0] CNTVALUEIN_in;
  wire gsr_in;
  reg [8:0] idelay_count_async;
  reg [8:0] idelay_count_sync;
  reg [8:0] cntvalue_updated;
  reg [8:0] cntvalue_updated_sync;
  reg [8:0] cntvalue_updated_async;
  reg [8:0] cascade_mode_delay;
  reg [8:0] idelay_count_pre;
  reg [8:0] CNTVALUEIN_INTEGER;
  time delay_value;
  time delay_value_casc_out;
  time delay_value_data_out;

  wire CASC_IN_delay;
  wire CASC_RETURN_delay;
  wire CE_delay;
  wire CLK_delay;
  wire EN_VTC_delay;
  wire ODATAIN_delay;
  wire INC_delay;
  wire LOAD_delay;
  wire RST_delay;
  wire [8:0] CNTVALUEIN_delay;
  
// input output assignments
  assign #(out_delay) CASC_OUT = CASC_OUT_delay;
  assign #(out_delay) CNTVALUEOUT = CNTVALUEOUT_delay;
  assign #(out_delay) DATAOUT = DATAOUT_delay;

`ifndef XIL_TIMING // inputs with timing checks
  assign #(inclk_delay) CLK_delay = CLK;

  assign #(in_delay) CE_delay = CE;
  assign #(in_delay) CNTVALUEIN_delay = CNTVALUEIN;
  assign #(in_delay) INC_delay = INC;
  assign #(in_delay) LOAD_delay = LOAD;
  assign #(in_delay) RST_delay = RST;
`endif //  `ifndef XIL_TIMING
// inputs with no timing checks

  assign #(in_delay) CASC_IN_delay = CASC_IN;
  assign #(in_delay) CASC_RETURN_delay = CASC_RETURN;
  assign #(in_delay) EN_VTC_delay = EN_VTC;
  assign #(in_delay) ODATAIN_delay = ODATAIN;

  assign CASC_OUT_delay = CASC_OUT_reg;
  assign CNTVALUEOUT_delay = CNTVALUEOUT_reg;
  assign DATAOUT_delay = DATAOUT_reg;

  assign CASC_IN_in = CASC_IN_delay;
  assign CASC_RETURN_in = CASC_RETURN_delay;
  assign CE_in = CE_delay;
  assign CLK_in = IS_CLK_INVERTED_BIN ? ~CLK_delay : CLK_delay;
  assign CNTVALUEIN_in = CNTVALUEIN_delay;
  assign EN_VTC_in = EN_VTC_delay;
  assign ODATAIN_in = ODATAIN_delay;
  assign INC_in = INC_delay;
  assign LOAD_in = LOAD_delay;
  assign RST_in = IS_RST_INVERTED_BIN ? ~RST_delay : RST_delay;

  initial begin
  #1;
  trig_attr = ~trig_attr;
  end

  assign CASCADE_BIN = 
    (CASCADE_REG == "NONE") ? CASCADE_NONE :
    (CASCADE_REG == "MASTER") ? CASCADE_MASTER :
    (CASCADE_REG == "SLAVE_END") ? CASCADE_SLAVE_END :
    (CASCADE_REG == "SLAVE_MIDDLE") ? CASCADE_SLAVE_MIDDLE :
    CASCADE_NONE;

  assign DELAY_FORMAT_BIN = 
    (DELAY_FORMAT_REG == "TIME") ? DELAY_FORMAT_TIME :
    (DELAY_FORMAT_REG == "COUNT") ? DELAY_FORMAT_COUNT :
    DELAY_FORMAT_TIME;

  assign DELAY_TYPE_BIN = 
    (DELAY_TYPE_REG == "FIXED") ? DELAY_TYPE_FIXED :
    (DELAY_TYPE_REG == "VARIABLE") ? DELAY_TYPE_VARIABLE :
    (DELAY_TYPE_REG == "VAR_LOAD") ? DELAY_TYPE_VAR_LOAD :
    DELAY_TYPE_FIXED;

 // assign DELAY_VALUE_BIN = 
 //   (DELAY_VALUE_REG == 0) ? DELAY_VALUE_0 :
 //   DELAY_VALUE_0;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign IS_RST_INVERTED_BIN = IS_RST_INVERTED_REG;

  assign REFCLK_FREQUENCY_BIN = $realtobits(REFCLK_FREQUENCY_REG);

  assign UPDATE_MODE_BIN = 
    (UPDATE_MODE_REG == "ASYNC") ? UPDATE_MODE_ASYNC :
    (UPDATE_MODE_REG == "MANUAL") ? UPDATE_MODE_MANUAL :
    (UPDATE_MODE_REG == "SYNC") ? UPDATE_MODE_SYNC :
    UPDATE_MODE_ASYNC;

  always @ (trig_attr) begin
    #1;
    case (CASCADE_REG) // string
      "NONE" : /*    */;
      "MASTER" : /*    */;
      "SLAVE_END" : /*    */;
      "SLAVE_MIDDLE" : /*    */;
      default : begin
        $display("Attribute Syntax Error : The attribute CASCADE on %s instance %m is set to %s.  Legal values for this attribute are NONE, MASTER, SLAVE_END or SLAVE_MIDDLE.", MODULE_NAME, CASCADE_REG);
        attr_err = 1'b1;
      end
    endcase

    case (DELAY_FORMAT_REG) // string
      "TIME" : /*    */;
      "COUNT" : /*    */;
      default : begin
        $display("Attribute Syntax Error : The attribute DELAY_FORMAT on %s instance %m is set to %s.  Legal values for this attribute are TIME or COUNT.", MODULE_NAME, DELAY_FORMAT_REG);
        attr_err = 1'b1;
      end
    endcase

    case (DELAY_TYPE_REG) // string
      "FIXED" : /*    */;
      "VARIABLE" : /*    */;
      "VAR_LOAD" : /*    */;
      default : begin
        $display("Attribute Syntax Error : The attribute DELAY_TYPE on %s instance %m is set to %s.  Legal values for this attribute are FIXED, VARIABLE or VAR_LOAD.", MODULE_NAME, DELAY_TYPE_REG);
        attr_err = 1'b1;
      end
    endcase

    if ((DELAY_VALUE_REG >= 0) && (DELAY_VALUE_REG <= 1250)) // decimal
       /*    */;
    else begin
        $display("Attribute Syntax Error : The attribute DELAY_VALUE on %s instance %m is set to %d.  Legal values for this attribute are 0 to 1250.", MODULE_NAME, DELAY_VALUE_REG, 0);
        attr_err = 1'b1;
    end

    case (UPDATE_MODE_REG) // string
      "ASYNC" : /*    */;
      "MANUAL" : /*    */;
      "SYNC" : /*    */;
      default : begin
        $display("Attribute Syntax Error : The attribute UPDATE_MODE on %s instance %m is set to %s.  Legal values for this attribute are ASYNC, MANUAL or SYNC.", MODULE_NAME, UPDATE_MODE_REG);
        attr_err = 1'b1;
      end
    endcase

    if ((IS_CLK_INVERTED_REG == 1'b0) || (IS_CLK_INVERTED_REG == 1'b1)) // binary
      /*    */;
    else begin
      $display("Attribute Syntax Error : The attribute IS_CLK_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_CLK_INVERTED_REG);
      attr_err = 1'b1;
    end

    if ((IS_RST_INVERTED_REG == 1'b0) || (IS_RST_INVERTED_REG == 1'b1)) // binary
      /*    */;
    else begin
      $display("Attribute Syntax Error : The attribute IS_RST_INVERTED on %s instance %m is set to %b.  Legal values for this attribute are 1'b0 to 1'b1.", MODULE_NAME, IS_RST_INVERTED_REG);
      attr_err = 1'b1;
    end

    if (REFCLK_FREQUENCY_REG >= 300.0 && REFCLK_FREQUENCY_REG <= 1333.0) // float
      /*    */;
    else begin
      $display("Attribute Syntax Error : The attribute REFCLK_FREQUENCY on %s instance %m is set to %f.  Legal values for this attribute are  300.0 to 1333.0.", MODULE_NAME, REFCLK_FREQUENCY_REG);
      attr_err = 1'b1;
    end

  if (attr_err == 1'b1) $finish;

  if (DELAY_FORMAT_BIN == DELAY_FORMAT_TIME)
	  if ((DELAY_VALUE_REG == 0) || (REFCLK_FREQUENCY_REG == 0)) begin
		idelay_count_pre = 0;
                cntvalue_updated = idelay_count_pre;
	  end	
	else begin	
          idelay_count_pre = DELAY_VALUE_REG/2.446;
          cntvalue_updated = idelay_count_pre;
        end  
  else if (DELAY_FORMAT_BIN == DELAY_FORMAT_COUNT)  begin
	  idelay_count_pre = DELAY_VALUE_REG;
          cntvalue_updated = idelay_count_pre;
  end

  end

//----------------------------------------------------------------------
//-------------------------------  Output ------------------------------
//----------------------------------------------------------------------
  always @(tap_out or tap_out_data_out or tap_out_casc_out or tap_out_casc_out_none or CASCADE_REG) begin
      
	case (CASCADE_REG)
	       "MASTER","SLAVE_MIDDLE" : begin
   		  DATAOUT_reg <= #(DATA_OUT_INTRINSIC_DELAY) tap_out_data_out;
	          CASC_OUT_reg <=  #(CASC_OUT_INTRINSIC_DELAY) tap_out_casc_out;  
		  
	       end

               "NONE","SLAVE_END" : begin
		   DATAOUT_reg <= #(DATA_OUT_INTRINSIC_DELAY) tap_out;
	           CASC_OUT_reg <=  #(CASC_OUT_INTRINSIC_DELAY) tap_out_casc_out_none;  
	       end
               default : begin
                          $display("Attribute Syntax Error : The attribute CASCADE on ODELAYE3 instance %m is set to %s.  Legal values for this attribute are NONE or MASTER or SLAVE_END or SLAVE_MIDDLE", CASCADE_REG);
                          $finish;
                      end	       
      endcase // case(CASCADE_REG)

    end // always @(tap_out or CASC_RETURN_in)

//----------------------------------------------------------------------
//-------------------------------  Input -------------------------------
//----------------------------------------------------------------------

    assign gsr_in = glblGSR;

//*** GLOBAL hidden GSR pin
    always @(gsr_in or RST_in) begin
        if (gsr_in == 1'b1 || RST_in == 1'b1) begin
	    assign idelay_count_sync = idelay_count_pre;
	    assign idelay_count_async = idelay_count_pre;
	    assign cntvalue_updated_sync = idelay_count_pre;
	    assign cntvalue_updated_async = idelay_count_pre;
        end
        else if (gsr_in == 1'b0 || RST_in == 1'b0) begin
            deassign idelay_count_sync;
            deassign idelay_count_async;
            deassign cntvalue_updated_sync;
            deassign cntvalue_updated_async;
        end
    end   

//----------------------------------------------------------------------
//------------------------      CNTVALUEOUT        ---------------------
//----------------------------------------------------------------------
    always @(idelay_count_sync or idelay_count_async or cntvalue_updated_async or cntvalue_updated_sync or UPDATE_MODE_REG) begin
	   case (UPDATE_MODE_REG)
		   "SYNC" : begin
			   assign CNTVALUEOUT_reg = idelay_count_sync;
			   assign cntvalue_updated = cntvalue_updated_sync;
		   end
		   "ASYNC" , "MANUAL" : begin
			   assign CNTVALUEOUT_reg = idelay_count_async;
			   assign cntvalue_updated = cntvalue_updated_async;
		   end
		   default: $display("Attribute Syntax Error:UPDATE_MODE_REG=%s is not valid value\n",UPDATE_MODE_REG);
           endcase 
    end


//----------------------------------------------------------------------
//--------------------------  DELAY_COUNT  ----------------------------
//----------------------------------------------------------------------
    always @(CLK_in or RST_in or RST_sync3 or RST_sync2 or RST_sync1)  begin
 	if (RST_in == 1'b1 || RST_sync3 == 1'b1 || RST_sync2 == 1'b1 || RST_sync1 == 1'b1)
    	  clk_smux <= 1'b0;
 	else if (RST_sync3 == 1'b0)
    	  clk_smux <= CLK_in;
    end

    always @(posedge CLK_in) begin
          RST_sync1 <= RST_in;
          RST_sync2 <= RST_sync1;
          RST_sync3 <= RST_sync2;
    end

    always @(posedge clk_smux) begin
	if (RST_in == 1'b0 && RST_sync1 == 1'b0 && RST_sync2 == 1'b0 && RST_sync3 == 1'b0) begin
	case(DELAY_TYPE_REG)
			"FIXED": ; //Do nothing.
			"VAR_LOAD":
				casex({LOAD_in, CE_in, INC_in})
					3'b000: ; //Do nothing.
					3'b001: ; //Do nothing.
					3'b010: 
						begin //{
                                                        if (idelay_count_async >  MIN_DELAY_COUNT)
							  idelay_count_async = idelay_count_async-1;
                                                        else if (idelay_count_async == MIN_DELAY_COUNT)
                                                          idelay_count_async = MAX_DELAY_COUNT;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_async = idelay_count_async;
						end //}
					3'b011: 
						begin //{
                                                        if (idelay_count_async < MAX_DELAY_COUNT)
                                                          idelay_count_async = idelay_count_async + 1;
                                                        else if (idelay_count_async == MAX_DELAY_COUNT)
                                                          idelay_count_async = MIN_DELAY_COUNT;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_async = idelay_count_async;
						end //}
					3'b100, 3'b101: 
						begin //{
							idelay_count_async = CNTVALUEIN_INTEGER;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_async = idelay_count_async;
						end //}
					3'b110: 
						if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL) $display("FAILURE: Invalid scenario. LOAD = 1, CE = 1 INC = 0 is not valid for UPDATE_MODE=%s and DELAY_TYPE=%s\n",UPDATE_MODE_REG,DELAY_TYPE_REG);
						else cntvalue_updated_async = idelay_count_async;
					3'b111: 
						if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL) $display("FAILURE: Invalid scenario. LOAD = 1, CE = 1 INC = 0 is not valid for UPDATE_MODE=%s and DELAY_TYPE=%s\n",UPDATE_MODE_REG,DELAY_TYPE_REG);
						else idelay_count_async = idelay_count_async + CNTVALUEIN_INTEGER;
					default: $display("FAILURE: Invalid scenario. LOAD = %b, CE = %b INC = %b \n", LOAD_in,CE_in,INC_in);
				endcase
			"VARIABLE":
				casex({LOAD_in, CE_in, INC_in})
					3'b000: ; //Do nothing.
					3'b001: ; //Do nothing.
					3'b010: 
						begin //{
							  if (idelay_count_async >  MIN_DELAY_COUNT) 
							  idelay_count_async = idelay_count_async-1;
                                                        else if (idelay_count_async == MIN_DELAY_COUNT)
                                                          idelay_count_async = MAX_DELAY_COUNT;
							cntvalue_updated_async = idelay_count_async;
						end //}
					3'b011: 
						begin //{
						        if (idelay_count_async < MAX_DELAY_COUNT)
                                                          idelay_count_async = idelay_count_async + 1;
                                                        else if (idelay_count_async == MAX_DELAY_COUNT)
                                                          idelay_count_async = MIN_DELAY_COUNT;
							cntvalue_updated_async = idelay_count_async;
						end //}
					default: $display("FAILURE: Invalid scenario. LOAD = %b, CE = %b, INC = %b, DELAY_TYPE=%s \n",LOAD_in,CE_in,INC_in,DELAY_TYPE_REG);
				endcase
			default: $display("FAILURE: DELAY_TYPE=%s is not a valid value\n",DELAY_TYPE_REG);
		endcase
        end
    end // always @ (posedge CLK_in)

    always @(posedge data_mux) begin
	if (RST_in == 1'b0 && RST_sync1 == 1'b0 && RST_sync2 == 1'b0 && RST_sync3 == 1'b0) begin
	  if (UPDATE_MODE_BIN == UPDATE_MODE_SYNC) begin
          case (DELAY_TYPE_REG)
	    "VAR_LOAD" : begin
		 	casex({LOAD_in, CE_in, INC_in})
					3'b000: ; //Do nothing.
					3'b001: ; //Do nothing.
					3'b010: 
						begin //{
                                                        if (idelay_count_sync >  MIN_DELAY_COUNT)
							  idelay_count_sync = idelay_count_sync-1;
                                                        else if (idelay_count_sync == MIN_DELAY_COUNT)
                                                          idelay_count_sync = MAX_DELAY_COUNT;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_sync = idelay_count_sync;
						end //}
					3'b011: 
						begin //{
                                                        if (idelay_count_sync < MAX_DELAY_COUNT)
                                                          idelay_count_sync = idelay_count_sync + 1;
                                                        else if (idelay_count_sync == MAX_DELAY_COUNT)
                                                          idelay_count_sync = MIN_DELAY_COUNT;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_sync = idelay_count_sync;
						end //}
					3'b100, 3'b101: 
						begin //{
							idelay_count_sync = CNTVALUEIN_INTEGER;
							if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL)
								cntvalue_updated_sync = idelay_count_sync;
						end //}
					3'b110: 
						if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL) $display("FAILURE: Invalid scenario. LOAD = 1, CE = 1 INC = 0 is not valid for UPDATE_MODE=%s and DELAY_TYPE=%s\n",UPDATE_MODE_REG,DELAY_TYPE_REG);
						else cntvalue_updated_sync = idelay_count_sync;
					3'b111: 
						if(UPDATE_MODE_BIN != UPDATE_MODE_MANUAL) $display("FAILURE: Invalid scenario. LOAD = 1, CE = 1 INC = 0 is not valid for UPDATE_MODE=%s and DELAY_TYPE=%s\n",UPDATE_MODE_REG,DELAY_TYPE_REG);
						else idelay_count_sync = idelay_count_sync + CNTVALUEIN_INTEGER;
					default: $display("FAILURE: Invalid scenario. LOAD = %b, CE = %b INC = %b \n",LOAD_in,CE_in,INC_in);
			endcase
	    end	  
	    default : begin
                      $display("Attribute Syntax Error : The attribute UPDATE_MODE = %s on ODELAYE3 instance %m is not supported for DELAY_TYPE set to %s. ", UPDATE_MODE_REG,DELAY_TYPE_REG);
                      $finish;
	    end 
         endcase 
       end 
        end // UPDATE_MODE_REG
//      end //else if
    end //always
	    
    always @(CNTVALUEIN_in or gsr_in) begin
	    assign CNTVALUEIN_INTEGER = CNTVALUEIN_in;
    end   

//*********************************************************
//*** SELECT DATA signal
//*********************************************************

    always @(ODATAIN_in or CASC_IN_in or CASCADE_REG) begin

	case (CASCADE_REG)
		"NONE", "MASTER" : begin
                   data_mux <= ODATAIN_in;
                  end
                 "SLAVE_END", "SLAVE_MIDDLE" : begin
		   data_mux <= CASC_IN_in;
	          end
                 default : begin
                          $display("Attribute Syntax Error : The attribute CASCADE on ODELAYE3 instance %m is set to %s.  Legal values for this attribute are NONE or MASTER or SLAVE_END or SLAVE_MIDDLE", CASCADE_REG);
                          $finish;
                 end	       
      endcase // case(CASCADE_REG)

    end // always @(ODATAIN_in or CASC_IN_in)

    always @ (cntvalue_updated or data_mux or CASC_RETURN_in or DELAY_FORMAT_REG) begin
      
      if (DELAY_FORMAT_BIN == DELAY_FORMAT_TIME) begin	    
        delay_value = (cntvalue_updated*2.446) + INTRINSIC_FINE_DELAY + INTRINSIC_MEDIUM_DELAY ;
        cascade_mode_delay =  cntvalue_updated*2.446;
        delay_value_casc_out = cascade_mode_delay/2 + INTRINSIC_FINE_DELAY + INTRINSIC_MEDIUM_DELAY ;
	if (cascade_mode_delay % 2 == 1) 
      		delay_value_data_out = cascade_mode_delay/2 + 1;
        else 	
      		delay_value_data_out = cascade_mode_delay/2;
      end else begin
        delay_value = (cntvalue_updated[2:0] * PER_BIT_FINE_DELAY)+(cntvalue_updated[8:3] * PER_BIT_MEDIUM_DELAY) + INTRINSIC_FINE_DELAY + INTRINSIC_MEDIUM_DELAY ;
        cascade_mode_delay =  (cntvalue_updated[2:0] * PER_BIT_FINE_DELAY)+(cntvalue_updated[8:3] * PER_BIT_MEDIUM_DELAY);
        delay_value_casc_out = ((cntvalue_updated[2:0] * PER_BIT_FINE_DELAY)+(cntvalue_updated[8:3] * PER_BIT_MEDIUM_DELAY))/2 + INTRINSIC_FINE_DELAY + INTRINSIC_MEDIUM_DELAY ;
	if (cascade_mode_delay % 2 == 1) 
      		delay_value_data_out = ((cntvalue_updated[2:0] * PER_BIT_FINE_DELAY)+(cntvalue_updated[8:3] * PER_BIT_MEDIUM_DELAY))/2 + 1;
        else 	
      		delay_value_data_out = ((cntvalue_updated[2:0] * PER_BIT_FINE_DELAY)+(cntvalue_updated[8:3] * PER_BIT_MEDIUM_DELAY))/2;
      end
     
       case (CASCADE_REG)
                "NONE", "MASTER" : begin
                                           delay_value = delay_value + ODATAIN_INTRINSIC_DELAY;
                                           delay_value_casc_out = delay_value_casc_out + ODATAIN_INTRINSIC_DELAY;
                  end
                 "SLAVE_END", "SLAVE_MIDDLE" : begin
                                           delay_value = delay_value + CASC_IN_INTRINSIC_DELAY;
                                           delay_value_casc_out = delay_value_casc_out + CASC_IN_INTRINSIC_DELAY;
                  end
                 default : begin
                          $display("Attribute Syntax Error : The attribute CASCADE on IDELAYE3 instance %m is set to %s.  Legal values for this attribute are NONE or MASTER or SLAVE_END or SLAVE_MIDDLE", CASCADE_REG);
                          $finish;
                 end
      endcase // case(CASCADE_REG)

     
     
      tap_out <= #delay_value data_mux;
      if (cntvalue_updated[8:3] >= 6'b011111 ) begin
         tap_out_casc_out_none <= #delay_value_casc_out data_mux;
      end
      else begin
         tap_out_casc_out_none <= 1'b0;
      end
      if (cntvalue_updated[8:3] == 6'b111111 ) begin
        tap_out_data_out <= #(delay_value_data_out + CASC_RET_INTRINSIC_DELAY) ~CASC_RETURN_in;
        tap_out_casc_out <= #delay_value_casc_out ~data_mux;
      end	
      else begin
        tap_out_data_out <= #delay_value data_mux;
	tap_out_casc_out <= 1'b1;
      end
   end
  specify
    (CASC_IN => DATAOUT) = (0:0:0, 0:0:0);
    (CASC_RETURN => DATAOUT) = (0:0:0, 0:0:0);
    (CLK *> CNTVALUEOUT) = (0:0:0, 0:0:0);
    (ODATAIN => DATAOUT) = (0:0:0, 0:0:0);
`ifdef XIL_TIMING // Simprim
    $period (negedge CLK, 0:0:0, notifier);
    $period (posedge CLK, 0:0:0, notifier);
    $recrem ( negedge RST, negedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( negedge RST, posedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( posedge RST, negedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $recrem ( posedge RST, posedge CLK, 0:0:0, 0:0:0, notifier,,, RST_delay, CLK_delay);
    $setuphold (negedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CE_delay);
    $setuphold (negedge CLK, negedge CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, CNTVALUEIN_delay);
    $setuphold (negedge CLK, negedge INC, 0:0:0, 0:0:0, notifier,,, CLK_delay, INC_delay);
    $setuphold (negedge CLK, negedge LOAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, LOAD_delay);
    $setuphold (negedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CE_delay);
    $setuphold (negedge CLK, posedge CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, CNTVALUEIN_delay);
    $setuphold (negedge CLK, posedge INC, 0:0:0, 0:0:0, notifier,,, CLK_delay, INC_delay);
    $setuphold (negedge CLK, posedge LOAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, LOAD_delay);
    $setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CE_delay);
    $setuphold (posedge CLK, negedge CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, CNTVALUEIN_delay);
    $setuphold (posedge CLK, negedge INC, 0:0:0, 0:0:0, notifier,,, CLK_delay, INC_delay);
    $setuphold (posedge CLK, negedge LOAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, LOAD_delay);
    $setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,,, CLK_delay, CE_delay);
    $setuphold (posedge CLK, posedge CNTVALUEIN, 0:0:0, 0:0:0, notifier,,, CLK_delay, CNTVALUEIN_delay);
    $setuphold (posedge CLK, posedge INC, 0:0:0, 0:0:0, notifier,,, CLK_delay, INC_delay);
    $setuphold (posedge CLK, posedge LOAD, 0:0:0, 0:0:0, notifier,,, CLK_delay, LOAD_delay);
    $width (negedge CLK, 0:0:0, 0, notifier);
    $width (posedge CLK, 0:0:0, 0, notifier);
`endif
    specparam PATHPULSE$ = 0;
  endspecify

endmodule

`endcelldefine
