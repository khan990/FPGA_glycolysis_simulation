project new F:/Thesis/TryNew22/pcores/my_newip_22_v1_00_a/devl/projnav/my_newip_22.xise;
project set family virtex4;
project set device xc4vfx12;
project set package ff668;
project set speed -10;
project set top_level_module_type HDL;
project set synthesis_tool "XST (VHDL/Verilog)";
lib_vhdl new my_newip_22_v1_00_a;
xfile add F:/Thesis/TryNew22/pcores/my_newip_22_v1_00_a/hdl/vhdl/my_newip_22.vhd -lib_vhdl my_newip_22_v1_00_a;
xfile add F:/Thesis/TryNew22/pcores/my_newip_22_v1_00_a/hdl/vhdl/user_logic.vhd -lib_vhdl my_newip_22_v1_00_a;
lib_vhdl new proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/proc_common_pkg.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/ipif_pkg.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/or_muxcy.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/or_gate128.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/family_support.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/pselect_f.vhd -lib_vhdl proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/counter_f.vhd -lib_vhdl proc_common_v3_00_a;
lib_vhdl new plbv46_slave_single_v1_01_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/plbv46_slave_single_v1_01_a/hdl/vhdl/plb_address_decoder.vhd -lib_vhdl plbv46_slave_single_v1_01_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/plbv46_slave_single_v1_01_a/hdl/vhdl/plb_slave_attachment.vhd -lib_vhdl plbv46_slave_single_v1_01_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/plbv46_slave_single_v1_01_a/hdl/vhdl/plbv46_slave_single.vhd -lib_vhdl plbv46_slave_single_v1_01_a;
lib_vhdl new proc_common_v3_00_a;
xfile add C:/Xilinx/14.7/ISE_DS/EDK/hw/XilinxProcessorIPLib/pcores/proc_common_v3_00_a/hdl/vhdl/soft_reset.vhd -lib_vhdl proc_common_v3_00_a;
project close;
