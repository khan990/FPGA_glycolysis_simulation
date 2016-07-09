##############################################################################
## Filename:          F:\Thesis\TryNew22/drivers/my_newip_22_v1_00_a/data/my_newip_22_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Wed May 28 14:35:25 2014 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "my_newip_22" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
