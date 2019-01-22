# General configuration
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# Gigabit Ethernet RGMII PHY
set_property -dict {LOC AG10 IOSTANDARD LVCMOS15} [get_ports phy_rx_clk]
set_property -dict {LOC AJ14 IOSTANDARD LVCMOS15} [get_ports {phy_rxd[0]}]
set_property -dict {LOC AH14 IOSTANDARD LVCMOS15} [get_ports {phy_rxd[1]}]
set_property -dict {LOC AK13 IOSTANDARD LVCMOS15} [get_ports {phy_rxd[2]}]
set_property -dict {LOC AJ13 IOSTANDARD LVCMOS15} [get_ports {phy_rxd[3]}]
set_property -dict {LOC AH11 IOSTANDARD LVCMOS15} [get_ports phy_rx_ctl]
set_property -dict {LOC AE10 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports phy_tx_clk]
set_property -dict {LOC AJ12 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports {phy_txd[0]}]
set_property -dict {LOC AK11 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports {phy_txd[1]}]
set_property -dict {LOC AJ11 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports {phy_txd[2]}]
set_property -dict {LOC AK10 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports {phy_txd[3]}]
set_property -dict {LOC AK14 IOSTANDARD LVCMOS15 SLEW FAST DRIVE 16} [get_ports phy_tx_ctl]
set_property -dict {LOC AH24 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports phy_reset_n]
set_property -dict {LOC AK16 IOSTANDARD LVCMOS18} [get_ports phy_int_n]
set_property -dict {LOC AK15 IOSTANDARD LVCMOS18} [get_ports phy_pme_n]
set_property -dict {LOC AG12 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports phy_mdio]
set_property -dict {LOC AF12 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports phy_mdc]
create_clock -period 8.000 -name phy_rx_clk [get_ports phy_rx_clk]
set_clock_groups -asynchronous -group [get_clocks phy_rx_clk -include_generated_clocks]
#set_property IDELAY_VALUE 0 [get_cells {phy_rx_ctl_idelay phy_rxd_idelay_*}]

# on board differential clock, 200MHz
set_property PACKAGE_PIN AD12 [get_ports clk_p]
set_property IOSTANDARD LVDS  [get_ports clk_p]
set_property PACKAGE_PIN AD11 [get_ports clk_n]
set_property IOSTANDARD LVDS  [get_ports clk_n]

# Reset button (active low)
set_property -dict {LOC R19 IOSTANDARD LVCMOS33} [get_ports rst_top]

# UART
set_property -dict {LOC Y23 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports txd]
set_property -dict {LOC Y20 IOSTANDARD LVCMOS33} [get_ports rxd]

## SD Card
set_property -dict { PACKAGE_PIN P28   IOSTANDARD LVCMOS33 } [get_ports { sd_detect }]; #IO_L8N_T1_D12_14 Sch=sd_cd
set_property -dict { PACKAGE_PIN R29   IOSTANDARD LVCMOS33 } [get_ports { sd_cmd }]; #IO_L7N_T1_D10_14 Sch=sd_cmd
set_property -dict { PACKAGE_PIN R26   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[0] }]; #IO_L10N_T1_D15_14 Sch=sd_dat[0]
set_property -dict { PACKAGE_PIN R30   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[1] }]; #IO_L9P_T1_DQS_14 Sch=sd_dat[1]
set_property -dict { PACKAGE_PIN P29   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[2] }]; #IO_L7P_T1_D09_14 Sch=sd_dat[2]
set_property -dict { PACKAGE_PIN T30   IOSTANDARD LVCMOS33 } [get_ports { sd_dat[3] }]; #IO_L9N_T1_DQS_D13_14 Sch=sd_dat[3]
set_property -dict { PACKAGE_PIN AE24  IOSTANDARD LVCMOS33 } [get_ports { sd_reset }]; #IO_L12N_T1_MRCC_12 Sch=sd_reset
set_property -dict { PACKAGE_PIN R28   IOSTANDARD LVCMOS33 } [get_ports { sd_sclk }]; #IO_L11P_T1_SRCC_14 Sch=sd_sclk

# Toggle switches
set_property -dict {LOC G19 IOSTANDARD LVCMOS12} [get_ports {i_dip[0]}]
set_property -dict {LOC G25 IOSTANDARD LVCMOS12} [get_ports {i_dip[1]}]
set_property -dict {LOC H24 IOSTANDARD LVCMOS12} [get_ports {i_dip[2]}]
set_property -dict {LOC K19 IOSTANDARD LVCMOS12} [get_ports {i_dip[3]}]
set_property -dict {LOC N19 IOSTANDARD LVCMOS12} [get_ports {i_dip[4]}]
set_property -dict {LOC P19 IOSTANDARD LVCMOS12} [get_ports {i_dip[5]}]
set_property -dict {LOC P26 IOSTANDARD LVCMOS33} [get_ports {i_dip[6]}]
set_property -dict {LOC P27 IOSTANDARD LVCMOS33} [get_ports {i_dip[7]}]

# LEDs 
set_property -dict {LOC T28 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[0]}]
set_property -dict {LOC V19 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[1]}]
set_property -dict {LOC U30 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[2]}]
set_property -dict {LOC U29 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[3]}]
set_property -dict {LOC V20 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[4]}]
set_property -dict {LOC V26 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[5]}]
set_property -dict {LOC W24 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[6]}]
set_property -dict {LOC W23 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {o_led[7]}]

# Push buttons
set_property -dict {LOC B19 IOSTANDARD LVCMOS12} [get_ports GPIO_SW_N]
set_property -dict {LOC M20 IOSTANDARD LVCMOS12} [get_ports GPIO_SW_W]
set_property -dict {LOC M19 IOSTANDARD LVCMOS12} [get_ports GPIO_SW_S]
set_property -dict {LOC C19 IOSTANDARD LVCMOS12} [get_ports GPIO_SW_E]
set_property -dict {LOC E18 IOSTANDARD LVCMOS12} [get_ports GPIO_SW_C]

## VGA Connector
set_property -dict { PACKAGE_PIN AG20  IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE_O[0] }]; #IO_L22P_T3_12 Sch=vga_b[4]
set_property -dict { PACKAGE_PIN AF21  IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE_O[1] }]; #IO_L19N_T3_VREF_12 Sch=vga_b[5]
set_property -dict { PACKAGE_PIN AK20  IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE_O[2] }]; #IO_L24P_T3_12 Sch=vga_b[6]
set_property -dict { PACKAGE_PIN AG22  IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE_O[3] }]; #IO_L20P_T3_12 Sch=vga_b[7]

set_property -dict { PACKAGE_PIN AH22  IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN_O[0] }]; #IO_L20N_T3_12 Sch=vga_g[4]
set_property -dict { PACKAGE_PIN AK21  IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN_O[1] }]; #IO_L24N_T3_12 Sch=vga_g[5]
set_property -dict { PACKAGE_PIN AJ21  IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN_O[2] }]; #IO_L23N_T3_12 Sch=vga_g[6]
set_property -dict { PACKAGE_PIN AK23  IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN_O[3] }]; #IO_L17P_T2_12 Sch=vga_g[7]

set_property -dict { PACKAGE_PIN AG25  IOSTANDARD LVCMOS33 } [get_ports { VGA_RED_O[0] }]; #IO_L18P_T2_12 Sch=vga_r[4]
set_property -dict { PACKAGE_PIN AH25  IOSTANDARD LVCMOS33 } [get_ports { VGA_RED_O[1] }]; #IO_L18N_T2_12 Sch=vga_r[5]
set_property -dict { PACKAGE_PIN AK24  IOSTANDARD LVCMOS33 } [get_ports { VGA_RED_O[2] }]; #IO_L17N_T2_12 Sch=vga_r[6]
set_property -dict { PACKAGE_PIN AJ24  IOSTANDARD LVCMOS33 } [get_ports { VGA_RED_O[3] }]; #IO_L15P_T2_DQS_12 Sch=vga_r[7]

set_property -dict { PACKAGE_PIN AF20  IOSTANDARD LVCMOS33 } [get_ports { VGA_HS_O }]; #IO_L19P_T3_12 Sch=vga_hs
set_property -dict { PACKAGE_PIN AG23  IOSTANDARD LVCMOS33 } [get_ports { VGA_VS_O }]; #IO_L13N_T2_MRCC_12 Sch=vga_vs

## USB HIDs For Both Mouse and Keyboard
set_property -dict { PACKAGE_PIN AD23  IOSTANDARD LVCMOS33  PULLUP true } [get_ports { PS2_CLK }]; #IO_L12P_T1_MRCC_12 Sch=ps2_clk[0]
set_property -dict { PACKAGE_PIN AE20  IOSTANDARD LVCMOS33  PULLUP true } [get_ports { PS2_DATA }]; #IO_25_12 Sch=ps2_data[0]

## PMOD Header JC
set_property -dict {PACKAGE_PIN AC26 IOSTANDARD LVCMOS33} [get_ports tck]
set_property -dict {PACKAGE_PIN AJ27 IOSTANDARD LVCMOS33} [get_ports tdi]
set_property -dict {PACKAGE_PIN AH30 IOSTANDARD LVCMOS33} [get_ports tdo]
set_property -dict {PACKAGE_PIN AK29 IOSTANDARD LVCMOS33} [get_ports tms]
set_property -dict {PACKAGE_PIN AD26 IOSTANDARD LVCMOS33} [get_ports trst_n]
# accept sub-optimal placement
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tck_IBUF]

