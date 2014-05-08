/*******************************************************************************
 * Module: mmcm_adv
 * Date:2014-05-01  
 * Author: Andrey Filippov
 * Description: MMCME2_ADV wrapper
 *
 * Copyright (c) 2014 Elphel, Inc.
 * mmcm_adv.v is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *  mmcm_adv.v is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/> .
 *******************************************************************************/
`timescale 1ns/1ps

module  mmcm_adv(
);
    /* Instance template for module MMCME2_ADV */
    MMCME2_ADV #(
        .BANDWIDTH("OPTIMIZED"),
        .CLKFBOUT_MULT_F(5.000),
        .CLKFBOUT_PHASE(0.000),
        .CLKFBOUT_USE_FINE_PS("FALSE"),
        .CLKIN1_PERIOD(0.000),
        .CLKIN2_PERIOD(0.000),
        .CLKOUT0_DIVIDE_F(1.000),
        .CLKOUT0_DUTY_CYCLE(0.500),
        .CLKOUT0_PHASE(0.000),
        .CLKOUT0_USE_FINE_PS("FALSE"),
        .CLKOUT1_DIVIDE(1),
        .CLKOUT1_DUTY_CYCLE(0.500),
        .CLKOUT1_PHASE(0.000),
        .CLKOUT1_USE_FINE_PS("FALSE"),
        .CLKOUT2_DIVIDE(1),
        .CLKOUT2_DUTY_CYCLE(0.500),
        .CLKOUT2_PHASE(0.000),
        .CLKOUT2_USE_FINE_PS("FALSE"),
        .CLKOUT3_DIVIDE(1),
        .CLKOUT3_DUTY_CYCLE(0.500),
        .CLKOUT3_PHASE(0.000),
        .CLKOUT3_USE_FINE_PS("FALSE"),
        .CLKOUT4_CASCADE("FALSE"),
        .CLKOUT4_DIVIDE(1),
        .CLKOUT4_DUTY_CYCLE(0.500),
        .CLKOUT4_PHASE(0.000),
        .CLKOUT4_USE_FINE_PS("FALSE"),
        .CLKOUT5_DIVIDE(1),
        .CLKOUT5_DUTY_CYCLE(0.500),
        .CLKOUT5_PHASE(0.000),
        .CLKOUT5_USE_FINE_PS("FALSE"),
        .CLKOUT6_DIVIDE(1),
        .CLKOUT6_DUTY_CYCLE(0.500),
        .CLKOUT6_PHASE(0.000),
        .CLKOUT6_USE_FINE_PS("FALSE"),
        .COMPENSATION("ZHOLD"),
        .DIVCLK_DIVIDE(1),
        .IS_CLKINSEL_INVERTED(1'b0),
        .IS_PSEN_INVERTED(1'b0),
        .IS_PSINCDEC_INVERTED(1'b0),
        .IS_PWRDWN_INVERTED(1'b0),
        .IS_RST_INVERTED(1'b0),
        .REF_JITTER1(0.010),
        .REF_JITTER2(0.010),
        .SS_EN("FALSE"),
        .SS_MODE("CENTER_HIGH"),
        .SS_MOD_PERIOD(10000),
        .STARTUP_WAIT("FALSE")
    ) MMCME2_ADV_i (
        .CLKFBOUT(), // output
        .CLKFBOUTB(), // output
        .CLKFBSTOPPED(), // output
        .CLKINSTOPPED(), // output
        .CLKOUT0(), // output
        .CLKOUT0B(), // output
        .CLKOUT1(), // output
        .CLKOUT1B(), // output
        .CLKOUT2(), // output
        .CLKOUT2B(), // output
        .CLKOUT3(), // output
        .CLKOUT3B(), // output
        .CLKOUT4(), // output
        .CLKOUT5(), // output
        .CLKOUT6(), // output
        .DO(), // output[15:0]
        .DRDY(), // output
        .LOCKED(), // output
        .PSDONE(), // output
        .CLKFBIN(), // input
        .CLKIN1(), // input
        .CLKIN2(), // input
        .CLKINSEL(), // input
        .DADDR(), // input[6:0]
        .DCLK(), // input
        .DEN(), // input
        .DI(), // input[15:0]
        .DWE(), // input
        .PSCLK(), // input
        .PSEN(), // input
        .PSINCDEC(), // input
        .PWRDWN(), // input
        .RST() // input
    );


endmodule

