-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx_Vivado_SDK_2018.2_0614_1954/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx_Vivado_SDK_2018.2_0614_1954/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../MODS.srcs/sources_1/ip/blk_mem_gen_img/sim/blk_mem_gen_img.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
