-------------------------------------------------------------------------------
-- system.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system is
  port (
    fpga_0_LEDs_4Bit_GPIO_IO_pin : inout std_logic_vector(0 to 3);
    fpga_0_Push_Buttons_Position_GPIO_IO_pin : inout std_logic_vector(0 to 4);
    fpga_0_SysACE_CompactFlash_SysACE_MPA_pin : out std_logic_vector(6 downto 1);
    fpga_0_SysACE_CompactFlash_SysACE_CLK_pin : in std_logic;
    fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin : in std_logic;
    fpga_0_SysACE_CompactFlash_SysACE_CEN_pin : out std_logic;
    fpga_0_SysACE_CompactFlash_SysACE_OEN_pin : out std_logic;
    fpga_0_SysACE_CompactFlash_SysACE_WEN_pin : out std_logic;
    fpga_0_SysACE_CompactFlash_SysACE_MPD_pin : inout std_logic_vector(15 downto 0);
    fpga_0_SRAM_Mem_A_pin : out std_logic_vector(9 to 29);
    fpga_0_SRAM_Mem_CEN_pin : out std_logic;
    fpga_0_SRAM_Mem_OEN_pin : out std_logic;
    fpga_0_SRAM_Mem_WEN_pin : out std_logic;
    fpga_0_SRAM_Mem_BEN_pin : out std_logic_vector(0 to 3);
    fpga_0_SRAM_Mem_ADV_LDN_pin : out std_logic;
    fpga_0_SRAM_Mem_DQ_pin : inout std_logic_vector(0 to 31);
    fpga_0_SRAM_ZBT_CLK_OUT_pin : out std_logic;
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic;
    my_newip_22_0_LED_pin : out std_logic_vector(0 to 4)
  );
end system;

architecture STRUCTURE of system is

  component system_ppc405_0_wrapper is
    port (
      C405CPMCORESLEEPREQ : out std_logic;
      C405CPMMSRCE : out std_logic;
      C405CPMMSREE : out std_logic;
      C405CPMTIMERIRQ : out std_logic;
      C405CPMTIMERRESETREQ : out std_logic;
      C405XXXMACHINECHECK : out std_logic;
      CPMC405CLOCK : in std_logic;
      CPMC405CORECLKINACTIVE : in std_logic;
      CPMC405CPUCLKEN : in std_logic;
      CPMC405JTAGCLKEN : in std_logic;
      CPMC405TIMERCLKEN : in std_logic;
      CPMC405TIMERTICK : in std_logic;
      MCBCPUCLKEN : in std_logic;
      MCBTIMEREN : in std_logic;
      MCPPCRST : in std_logic;
      CPMDCRCLK : in std_logic;
      CPMFCMCLK : in std_logic;
      C405RSTCHIPRESETREQ : out std_logic;
      C405RSTCORERESETREQ : out std_logic;
      C405RSTSYSRESETREQ : out std_logic;
      RSTC405RESETCHIP : in std_logic;
      RSTC405RESETCORE : in std_logic;
      RSTC405RESETSYS : in std_logic;
      APUFCMDECODED : out std_logic;
      APUFCMDECUDI : out std_logic_vector(0 to 2);
      APUFCMDECUDIVALID : out std_logic;
      APUFCMENDIAN : out std_logic;
      APUFCMFLUSH : out std_logic;
      APUFCMINSTRUCTION : out std_logic_vector(0 to 31);
      APUFCMINSTRVALID : out std_logic;
      APUFCMLOADBYTEEN : out std_logic_vector(0 to 3);
      APUFCMLOADDATA : out std_logic_vector(0 to 31);
      APUFCMLOADDVALID : out std_logic;
      APUFCMOPERANDVALID : out std_logic;
      APUFCMRADATA : out std_logic_vector(0 to 31);
      APUFCMRBDATA : out std_logic_vector(0 to 31);
      APUFCMWRITEBACKOK : out std_logic;
      APUFCMXERCA : out std_logic;
      FCMAPUCR : in std_logic_vector(0 to 3);
      FCMAPUDCDCREN : in std_logic;
      FCMAPUDCDFORCEALIGN : in std_logic;
      FCMAPUDCDFORCEBESTEERING : in std_logic;
      FCMAPUDCDFPUOP : in std_logic;
      FCMAPUDCDGPRWRITE : in std_logic;
      FCMAPUDCDLDSTBYTE : in std_logic;
      FCMAPUDCDLDSTDW : in std_logic;
      FCMAPUDCDLDSTHW : in std_logic;
      FCMAPUDCDLDSTQW : in std_logic;
      FCMAPUDCDLDSTWD : in std_logic;
      FCMAPUDCDLOAD : in std_logic;
      FCMAPUDCDPRIVOP : in std_logic;
      FCMAPUDCDRAEN : in std_logic;
      FCMAPUDCDRBEN : in std_logic;
      FCMAPUDCDSTORE : in std_logic;
      FCMAPUDCDTRAPBE : in std_logic;
      FCMAPUDCDTRAPLE : in std_logic;
      FCMAPUDCDUPDATE : in std_logic;
      FCMAPUDCDXERCAEN : in std_logic;
      FCMAPUDCDXEROVEN : in std_logic;
      FCMAPUDECODEBUSY : in std_logic;
      FCMAPUDONE : in std_logic;
      FCMAPUEXCEPTION : in std_logic;
      FCMAPUEXEBLOCKINGMCO : in std_logic;
      FCMAPUEXECRFIELD : in std_logic_vector(0 to 2);
      FCMAPUEXENONBLOCKINGMCO : in std_logic;
      FCMAPUINSTRACK : in std_logic;
      FCMAPULOADWAIT : in std_logic;
      FCMAPURESULT : in std_logic_vector(0 to 31);
      FCMAPURESULTVALID : in std_logic;
      FCMAPUSLEEPNOTREADY : in std_logic;
      FCMAPUXERCA : in std_logic;
      FCMAPUXEROV : in std_logic;
      IPLB0_PLB_Clk : in std_logic;
      IPLB0_PLB_Rst : in std_logic;
      IPLB0_PLB_MBusy : in std_logic;
      IPLB0_PLB_MRdErr : in std_logic;
      IPLB0_PLB_MWrErr : in std_logic;
      IPLB0_PLB_MWrBTerm : in std_logic;
      IPLB0_PLB_MWrDAck : in std_logic;
      IPLB0_PLB_MAddrAck : in std_logic;
      IPLB0_PLB_MRdBTerm : in std_logic;
      IPLB0_PLB_MRdDAck : in std_logic;
      IPLB0_PLB_MRdDBus : in std_logic_vector(0 to 63);
      IPLB0_PLB_MRearbitrate : in std_logic;
      IPLB0_PLB_MSSize : in std_logic_vector(0 to 1);
      IPLB0_PLB_MTimeout : in std_logic;
      IPLB0_PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      IPLB0_M_ABus : out std_logic_vector(0 to 31);
      IPLB0_M_BE : out std_logic_vector(0 to 7);
      IPLB0_M_MSize : out std_logic_vector(0 to 1);
      IPLB0_M_rdBurst : out std_logic;
      IPLB0_M_request : out std_logic;
      IPLB0_M_RNW : out std_logic;
      IPLB0_M_size : out std_logic_vector(0 to 3);
      IPLB0_M_wrBurst : out std_logic;
      IPLB0_M_wrDBus : out std_logic_vector(0 to 63);
      IPLB0_M_abort : out std_logic;
      IPLB0_M_UABus : out std_logic_vector(0 to 31);
      IPLB0_M_busLock : out std_logic;
      IPLB0_M_lockErr : out std_logic;
      IPLB0_M_priority : out std_logic_vector(0 to 1);
      IPLB0_M_type : out std_logic_vector(0 to 2);
      IPLB0_M_TAttribute : out std_logic_vector(0 to 15);
      DPLB0_PLB_Clk : in std_logic;
      DPLB0_PLB_Rst : in std_logic;
      DPLB0_PLB_MBusy : in std_logic;
      DPLB0_PLB_MRdErr : in std_logic;
      DPLB0_PLB_MWrErr : in std_logic;
      DPLB0_PLB_MWrBTerm : in std_logic;
      DPLB0_PLB_MWrDAck : in std_logic;
      DPLB0_PLB_MAddrAck : in std_logic;
      DPLB0_PLB_MRdBTerm : in std_logic;
      DPLB0_PLB_MRdDAck : in std_logic;
      DPLB0_PLB_MRdDBus : in std_logic_vector(0 to 63);
      DPLB0_PLB_MRearbitrate : in std_logic;
      DPLB0_PLB_MSSize : in std_logic_vector(0 to 1);
      DPLB0_PLB_MTimeout : in std_logic;
      DPLB0_PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      DPLB0_M_ABus : out std_logic_vector(0 to 31);
      DPLB0_M_BE : out std_logic_vector(0 to 7);
      DPLB0_M_MSize : out std_logic_vector(0 to 1);
      DPLB0_M_rdBurst : out std_logic;
      DPLB0_M_request : out std_logic;
      DPLB0_M_RNW : out std_logic;
      DPLB0_M_size : out std_logic_vector(0 to 3);
      DPLB0_M_wrBurst : out std_logic;
      DPLB0_M_wrDBus : out std_logic_vector(0 to 63);
      DPLB0_M_abort : out std_logic;
      DPLB0_M_UABus : out std_logic_vector(0 to 31);
      DPLB0_M_busLock : out std_logic;
      DPLB0_M_lockErr : out std_logic;
      DPLB0_M_priority : out std_logic_vector(0 to 1);
      DPLB0_M_type : out std_logic_vector(0 to 2);
      DPLB0_M_TAttribute : out std_logic_vector(0 to 15);
      IPLB1_PLB_Clk : in std_logic;
      IPLB1_PLB_Rst : in std_logic;
      IPLB1_PLB_MBusy : in std_logic;
      IPLB1_PLB_MRdErr : in std_logic;
      IPLB1_PLB_MWrErr : in std_logic;
      IPLB1_PLB_MWrBTerm : in std_logic;
      IPLB1_PLB_MWrDAck : in std_logic;
      IPLB1_PLB_MAddrAck : in std_logic;
      IPLB1_PLB_MRdBTerm : in std_logic;
      IPLB1_PLB_MRdDAck : in std_logic;
      IPLB1_PLB_MRdDBus : in std_logic_vector(0 to 63);
      IPLB1_PLB_MRearbitrate : in std_logic;
      IPLB1_PLB_MSSize : in std_logic_vector(0 to 1);
      IPLB1_PLB_MTimeout : in std_logic;
      IPLB1_PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      IPLB1_M_ABus : out std_logic_vector(0 to 31);
      IPLB1_M_BE : out std_logic_vector(0 to 7);
      IPLB1_M_MSize : out std_logic_vector(0 to 1);
      IPLB1_M_rdBurst : out std_logic;
      IPLB1_M_request : out std_logic;
      IPLB1_M_RNW : out std_logic;
      IPLB1_M_size : out std_logic_vector(0 to 3);
      IPLB1_M_wrBurst : out std_logic;
      IPLB1_M_wrDBus : out std_logic_vector(0 to 63);
      IPLB1_M_abort : out std_logic;
      IPLB1_M_UABus : out std_logic_vector(0 to 31);
      IPLB1_M_busLock : out std_logic;
      IPLB1_M_lockErr : out std_logic;
      IPLB1_M_priority : out std_logic_vector(0 to 1);
      IPLB1_M_type : out std_logic_vector(0 to 2);
      IPLB1_M_TAttribute : out std_logic_vector(0 to 15);
      DPLB1_PLB_Clk : in std_logic;
      DPLB1_PLB_Rst : in std_logic;
      DPLB1_PLB_MBusy : in std_logic;
      DPLB1_PLB_MRdErr : in std_logic;
      DPLB1_PLB_MWrErr : in std_logic;
      DPLB1_PLB_MWrBTerm : in std_logic;
      DPLB1_PLB_MWrDAck : in std_logic;
      DPLB1_PLB_MAddrAck : in std_logic;
      DPLB1_PLB_MRdBTerm : in std_logic;
      DPLB1_PLB_MRdDAck : in std_logic;
      DPLB1_PLB_MRdDBus : in std_logic_vector(0 to 63);
      DPLB1_PLB_MRearbitrate : in std_logic;
      DPLB1_PLB_MSSize : in std_logic_vector(0 to 1);
      DPLB1_PLB_MTimeout : in std_logic;
      DPLB1_PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      DPLB1_M_ABus : out std_logic_vector(0 to 31);
      DPLB1_M_BE : out std_logic_vector(0 to 7);
      DPLB1_M_MSize : out std_logic_vector(0 to 1);
      DPLB1_M_rdBurst : out std_logic;
      DPLB1_M_request : out std_logic;
      DPLB1_M_RNW : out std_logic;
      DPLB1_M_size : out std_logic_vector(0 to 3);
      DPLB1_M_wrBurst : out std_logic;
      DPLB1_M_wrDBus : out std_logic_vector(0 to 63);
      DPLB1_M_abort : out std_logic;
      DPLB1_M_UABus : out std_logic_vector(0 to 31);
      DPLB1_M_busLock : out std_logic;
      DPLB1_M_lockErr : out std_logic;
      DPLB1_M_priority : out std_logic_vector(0 to 1);
      DPLB1_M_type : out std_logic_vector(0 to 2);
      DPLB1_M_TAttribute : out std_logic_vector(0 to 15);
      BRAMDSOCMCLK : in std_logic;
      BRAMDSOCMRDDBUS : in std_logic_vector(0 to 31);
      DSARCVALUE : in std_logic_vector(0 to 7);
      DSCNTLVALUE : in std_logic_vector(0 to 7);
      DSOCMBRAMABUS : out std_logic_vector(8 to 29);
      DSOCMBRAMBYTEWRITE : out std_logic_vector(0 to 3);
      DSOCMBRAMEN : out std_logic;
      DSOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
      DSOCMBUSY : out std_logic;
      DSOCMRDADDRVALID : out std_logic;
      DSOCMWRADDRVALID : out std_logic;
      DSOCMRWCOMPLETE : in std_logic;
      BRAMISOCMCLK : in std_logic;
      BRAMISOCMRDDBUS : in std_logic_vector(0 to 63);
      BRAMISOCMDCRRDDBUS : in std_logic_vector(0 to 31);
      ISARCVALUE : in std_logic_vector(0 to 7);
      ISCNTLVALUE : in std_logic_vector(0 to 7);
      ISOCMBRAMEN : out std_logic;
      ISOCMBRAMEVENWRITEEN : out std_logic;
      ISOCMBRAMODDWRITEEN : out std_logic;
      ISOCMBRAMRDABUS : out std_logic_vector(8 to 28);
      ISOCMBRAMWRABUS : out std_logic_vector(8 to 28);
      ISOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
      ISOCMDCRBRAMEVENEN : out std_logic;
      ISOCMDCRBRAMODDEN : out std_logic;
      ISOCMDCRBRAMRDSELECT : out std_logic;
      DCREMACABUS : out std_logic_vector(8 to 9);
      DCREMACCLK : out std_logic;
      DCREMACDBUS : out std_logic_vector(0 to 31);
      DCREMACENABLER : out std_logic;
      DCREMACREAD : out std_logic;
      DCREMACWRITE : out std_logic;
      EMACDCRACK : in std_logic;
      EMACDCRDBUS : in std_logic_vector(0 to 31);
      EXTDCRABUS : out std_logic_vector(0 to 9);
      EXTDCRDBUSOUT : out std_logic_vector(0 to 31);
      EXTDCRREAD : out std_logic;
      EXTDCRWRITE : out std_logic;
      EXTDCRACK : in std_logic;
      EXTDCRDBUSIN : in std_logic_vector(0 to 31);
      EICC405CRITINPUTIRQ : in std_logic;
      EICC405EXTINPUTIRQ : in std_logic;
      C405JTGCAPTUREDR : out std_logic;
      C405JTGEXTEST : out std_logic;
      C405JTGPGMOUT : out std_logic;
      C405JTGSHIFTDR : out std_logic;
      C405JTGTDO : out std_logic;
      C405JTGTDOEN : out std_logic;
      C405JTGUPDATEDR : out std_logic;
      MCBJTAGEN : in std_logic;
      JTGC405BNDSCANTDO : in std_logic;
      JTGC405TCK : in std_logic;
      JTGC405TDI : in std_logic;
      JTGC405TMS : in std_logic;
      JTGC405TRSTNEG : in std_logic;
      C405DBGMSRWE : out std_logic;
      C405DBGSTOPACK : out std_logic;
      C405DBGWBCOMPLETE : out std_logic;
      C405DBGWBFULL : out std_logic;
      C405DBGWBIAR : out std_logic_vector(0 to 29);
      DBGC405DEBUGHALT : in std_logic;
      DBGC405DEBUGHALTNEG : in std_logic;
      DBGC405EXTBUSHOLDACK : in std_logic;
      DBGC405UNCONDDEBUGEVENT : in std_logic;
      C405DBGLOADDATAONAPUDBUS : out std_logic;
      C405TRCCYCLE : out std_logic;
      C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1);
      C405TRCODDEXECUTIONSTATUS : out std_logic_vector(0 to 1);
      C405TRCTRACESTATUS : out std_logic_vector(0 to 3);
      C405TRCTRIGGEREVENTOUT : out std_logic;
      C405TRCTRIGGEREVENTTYPE : out std_logic_vector(0 to 10);
      TRCC405TRACEDISABLE : in std_logic;
      TRCC405TRIGGEREVENTIN : in std_logic
    );
  end component;

  component system_plb_wrapper is
    port (
      PLB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      PLB_Rst : out std_logic;
      SPLB_Rst : out std_logic_vector(0 to 9);
      MPLB_Rst : out std_logic_vector(0 to 1);
      PLB_dcrAck : out std_logic;
      PLB_dcrDBus : out std_logic_vector(0 to 31);
      DCR_ABus : in std_logic_vector(0 to 9);
      DCR_DBus : in std_logic_vector(0 to 31);
      DCR_Read : in std_logic;
      DCR_Write : in std_logic;
      M_ABus : in std_logic_vector(0 to 63);
      M_UABus : in std_logic_vector(0 to 63);
      M_BE : in std_logic_vector(0 to 15);
      M_RNW : in std_logic_vector(0 to 1);
      M_abort : in std_logic_vector(0 to 1);
      M_busLock : in std_logic_vector(0 to 1);
      M_TAttribute : in std_logic_vector(0 to 31);
      M_lockErr : in std_logic_vector(0 to 1);
      M_MSize : in std_logic_vector(0 to 3);
      M_priority : in std_logic_vector(0 to 3);
      M_rdBurst : in std_logic_vector(0 to 1);
      M_request : in std_logic_vector(0 to 1);
      M_size : in std_logic_vector(0 to 7);
      M_type : in std_logic_vector(0 to 5);
      M_wrBurst : in std_logic_vector(0 to 1);
      M_wrDBus : in std_logic_vector(0 to 127);
      Sl_addrAck : in std_logic_vector(0 to 9);
      Sl_MRdErr : in std_logic_vector(0 to 19);
      Sl_MWrErr : in std_logic_vector(0 to 19);
      Sl_MBusy : in std_logic_vector(0 to 19);
      Sl_rdBTerm : in std_logic_vector(0 to 9);
      Sl_rdComp : in std_logic_vector(0 to 9);
      Sl_rdDAck : in std_logic_vector(0 to 9);
      Sl_rdDBus : in std_logic_vector(0 to 639);
      Sl_rdWdAddr : in std_logic_vector(0 to 39);
      Sl_rearbitrate : in std_logic_vector(0 to 9);
      Sl_SSize : in std_logic_vector(0 to 19);
      Sl_wait : in std_logic_vector(0 to 9);
      Sl_wrBTerm : in std_logic_vector(0 to 9);
      Sl_wrComp : in std_logic_vector(0 to 9);
      Sl_wrDAck : in std_logic_vector(0 to 9);
      Sl_MIRQ : in std_logic_vector(0 to 19);
      PLB_MIRQ : out std_logic_vector(0 to 1);
      PLB_ABus : out std_logic_vector(0 to 31);
      PLB_UABus : out std_logic_vector(0 to 31);
      PLB_BE : out std_logic_vector(0 to 7);
      PLB_MAddrAck : out std_logic_vector(0 to 1);
      PLB_MTimeout : out std_logic_vector(0 to 1);
      PLB_MBusy : out std_logic_vector(0 to 1);
      PLB_MRdErr : out std_logic_vector(0 to 1);
      PLB_MWrErr : out std_logic_vector(0 to 1);
      PLB_MRdBTerm : out std_logic_vector(0 to 1);
      PLB_MRdDAck : out std_logic_vector(0 to 1);
      PLB_MRdDBus : out std_logic_vector(0 to 127);
      PLB_MRdWdAddr : out std_logic_vector(0 to 7);
      PLB_MRearbitrate : out std_logic_vector(0 to 1);
      PLB_MWrBTerm : out std_logic_vector(0 to 1);
      PLB_MWrDAck : out std_logic_vector(0 to 1);
      PLB_MSSize : out std_logic_vector(0 to 3);
      PLB_PAValid : out std_logic;
      PLB_RNW : out std_logic;
      PLB_SAValid : out std_logic;
      PLB_abort : out std_logic;
      PLB_busLock : out std_logic;
      PLB_TAttribute : out std_logic_vector(0 to 15);
      PLB_lockErr : out std_logic;
      PLB_masterID : out std_logic_vector(0 to 0);
      PLB_MSize : out std_logic_vector(0 to 1);
      PLB_rdPendPri : out std_logic_vector(0 to 1);
      PLB_wrPendPri : out std_logic_vector(0 to 1);
      PLB_rdPendReq : out std_logic;
      PLB_wrPendReq : out std_logic;
      PLB_rdBurst : out std_logic;
      PLB_rdPrim : out std_logic_vector(0 to 9);
      PLB_reqPri : out std_logic_vector(0 to 1);
      PLB_size : out std_logic_vector(0 to 3);
      PLB_type : out std_logic_vector(0 to 2);
      PLB_wrBurst : out std_logic;
      PLB_wrDBus : out std_logic_vector(0 to 63);
      PLB_wrPrim : out std_logic_vector(0 to 9);
      PLB_SaddrAck : out std_logic;
      PLB_SMRdErr : out std_logic_vector(0 to 1);
      PLB_SMWrErr : out std_logic_vector(0 to 1);
      PLB_SMBusy : out std_logic_vector(0 to 1);
      PLB_SrdBTerm : out std_logic;
      PLB_SrdComp : out std_logic;
      PLB_SrdDAck : out std_logic;
      PLB_SrdDBus : out std_logic_vector(0 to 63);
      PLB_SrdWdAddr : out std_logic_vector(0 to 3);
      PLB_Srearbitrate : out std_logic;
      PLB_Sssize : out std_logic_vector(0 to 1);
      PLB_Swait : out std_logic;
      PLB_SwrBTerm : out std_logic;
      PLB_SwrComp : out std_logic;
      PLB_SwrDAck : out std_logic;
      Bus_Error_Det : out std_logic
    );
  end component;

  component system_xps_bram_if_cntlr_1_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      BRAM_Rst : out std_logic;
      BRAM_Clk : out std_logic;
      BRAM_EN : out std_logic;
      BRAM_WEN : out std_logic_vector(0 to 7);
      BRAM_Addr : out std_logic_vector(0 to 31);
      BRAM_Din : in std_logic_vector(0 to 63);
      BRAM_Dout : out std_logic_vector(0 to 63)
    );
  end component;

  component system_plb_bram_if_cntlr_1_bram_wrapper is
    port (
      BRAM_Rst_A : in std_logic;
      BRAM_Clk_A : in std_logic;
      BRAM_EN_A : in std_logic;
      BRAM_WEN_A : in std_logic_vector(0 to 7);
      BRAM_Addr_A : in std_logic_vector(0 to 31);
      BRAM_Din_A : out std_logic_vector(0 to 63);
      BRAM_Dout_A : in std_logic_vector(0 to 63);
      BRAM_Rst_B : in std_logic;
      BRAM_Clk_B : in std_logic;
      BRAM_EN_B : in std_logic;
      BRAM_WEN_B : in std_logic_vector(0 to 7);
      BRAM_Addr_B : in std_logic_vector(0 to 31);
      BRAM_Din_B : out std_logic_vector(0 to 63);
      BRAM_Dout_B : in std_logic_vector(0 to 63)
    );
  end component;

  component system_leds_4bit_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector(0 to 3);
      GPIO_IO_O : out std_logic_vector(0 to 3);
      GPIO_IO_T : out std_logic_vector(0 to 3);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component system_leds_positions_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector(0 to 4);
      GPIO_IO_O : out std_logic_vector(0 to 4);
      GPIO_IO_T : out std_logic_vector(0 to 4);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component system_push_buttons_position_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      IP2INTC_Irpt : out std_logic;
      GPIO_IO_I : in std_logic_vector(0 to 4);
      GPIO_IO_O : out std_logic_vector(0 to 4);
      GPIO_IO_T : out std_logic_vector(0 to 4);
      GPIO2_IO_I : in std_logic_vector(0 to 31);
      GPIO2_IO_O : out std_logic_vector(0 to 31);
      GPIO2_IO_T : out std_logic_vector(0 to 31)
    );
  end component;

  component system_sysace_compactflash_wrapper is
    port (
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      SysACE_MPA : out std_logic_vector(6 downto 0);
      SysACE_CLK : in std_logic;
      SysACE_MPIRQ : in std_logic;
      SysACE_MPD_I : in std_logic_vector(15 downto 0);
      SysACE_MPD_O : out std_logic_vector(15 downto 0);
      SysACE_MPD_T : out std_logic_vector(15 downto 0);
      SysACE_CEN : out std_logic;
      SysACE_OEN : out std_logic;
      SysACE_WEN : out std_logic;
      SysACE_IRQ : out std_logic
    );
  end component;

  component system_sram_wrapper is
    port (
      MCH_SPLB_Clk : in std_logic;
      RdClk : in std_logic;
      MCH_SPLB_Rst : in std_logic;
      MCH0_Access_Control : in std_logic;
      MCH0_Access_Data : in std_logic_vector(0 to 31);
      MCH0_Access_Write : in std_logic;
      MCH0_Access_Full : out std_logic;
      MCH0_ReadData_Control : out std_logic;
      MCH0_ReadData_Data : out std_logic_vector(0 to 31);
      MCH0_ReadData_Read : in std_logic;
      MCH0_ReadData_Exists : out std_logic;
      MCH1_Access_Control : in std_logic;
      MCH1_Access_Data : in std_logic_vector(0 to 31);
      MCH1_Access_Write : in std_logic;
      MCH1_Access_Full : out std_logic;
      MCH1_ReadData_Control : out std_logic;
      MCH1_ReadData_Data : out std_logic_vector(0 to 31);
      MCH1_ReadData_Read : in std_logic;
      MCH1_ReadData_Exists : out std_logic;
      MCH2_Access_Control : in std_logic;
      MCH2_Access_Data : in std_logic_vector(0 to 31);
      MCH2_Access_Write : in std_logic;
      MCH2_Access_Full : out std_logic;
      MCH2_ReadData_Control : out std_logic;
      MCH2_ReadData_Data : out std_logic_vector(0 to 31);
      MCH2_ReadData_Read : in std_logic;
      MCH2_ReadData_Exists : out std_logic;
      MCH3_Access_Control : in std_logic;
      MCH3_Access_Data : in std_logic_vector(0 to 31);
      MCH3_Access_Write : in std_logic;
      MCH3_Access_Full : out std_logic;
      MCH3_ReadData_Control : out std_logic;
      MCH3_ReadData_Data : out std_logic_vector(0 to 31);
      MCH3_ReadData_Read : in std_logic;
      MCH3_ReadData_Exists : out std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Mem_DQ_I : in std_logic_vector(0 to 31);
      Mem_DQ_O : out std_logic_vector(0 to 31);
      Mem_DQ_T : out std_logic_vector(0 to 31);
      Mem_A : out std_logic_vector(0 to 31);
      Mem_RPN : out std_logic;
      Mem_CEN : out std_logic_vector(0 to 0);
      Mem_OEN : out std_logic_vector(0 to 0);
      Mem_WEN : out std_logic;
      Mem_QWEN : out std_logic_vector(0 to 3);
      Mem_BEN : out std_logic_vector(0 to 3);
      Mem_CE : out std_logic_vector(0 to 0);
      Mem_ADV_LDN : out std_logic;
      Mem_LBON : out std_logic;
      Mem_CKEN : out std_logic;
      Mem_RNW : out std_logic
    );
  end component;

  component system_xps_timer_0_wrapper is
    port (
      CaptureTrig0 : in std_logic;
      CaptureTrig1 : in std_logic;
      GenerateOut0 : out std_logic;
      GenerateOut1 : out std_logic;
      PWM0 : out std_logic;
      Interrupt : out std_logic;
      Freeze : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrDBus : in std_logic_vector(0 to 63);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_lockErr : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_wrBTerm : out std_logic;
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdBTerm : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component system_xps_timebase_wdt_0_wrapper is
    port (
      WDT_Reset : out std_logic;
      Timebase_Interrupt : out std_logic;
      WDT_Interrupt : out std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrDBus : in std_logic_vector(0 to 63);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_lockErr : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_wrBTerm : out std_logic;
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdBTerm : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component system_clock_generator_0_wrapper is
    port (
      CLKIN : in std_logic;
      CLKOUT0 : out std_logic;
      CLKOUT1 : out std_logic;
      CLKOUT2 : out std_logic;
      CLKOUT3 : out std_logic;
      CLKOUT4 : out std_logic;
      CLKOUT5 : out std_logic;
      CLKOUT6 : out std_logic;
      CLKOUT7 : out std_logic;
      CLKOUT8 : out std_logic;
      CLKOUT9 : out std_logic;
      CLKOUT10 : out std_logic;
      CLKOUT11 : out std_logic;
      CLKOUT12 : out std_logic;
      CLKOUT13 : out std_logic;
      CLKOUT14 : out std_logic;
      CLKOUT15 : out std_logic;
      CLKFBIN : in std_logic;
      CLKFBOUT : out std_logic;
      PSCLK : in std_logic;
      PSEN : in std_logic;
      PSINCDEC : in std_logic;
      PSDONE : out std_logic;
      RST : in std_logic;
      LOCKED : out std_logic
    );
  end component;

  component system_jtagppc_cntlr_inst_wrapper is
    port (
      TRSTNEG : in std_logic;
      HALTNEG0 : in std_logic;
      DBGC405DEBUGHALT0 : out std_logic;
      HALTNEG1 : in std_logic;
      DBGC405DEBUGHALT1 : out std_logic;
      C405JTGTDO0 : in std_logic;
      C405JTGTDOEN0 : in std_logic;
      JTGC405TCK0 : out std_logic;
      JTGC405TDI0 : out std_logic;
      JTGC405TMS0 : out std_logic;
      JTGC405TRSTNEG0 : out std_logic;
      C405JTGTDO1 : in std_logic;
      C405JTGTDOEN1 : in std_logic;
      JTGC405TCK1 : out std_logic;
      JTGC405TDI1 : out std_logic;
      JTGC405TMS1 : out std_logic;
      JTGC405TRSTNEG1 : out std_logic
    );
  end component;

  component system_proc_sys_reset_0_wrapper is
    port (
      Slowest_sync_clk : in std_logic;
      Ext_Reset_In : in std_logic;
      Aux_Reset_In : in std_logic;
      MB_Debug_Sys_Rst : in std_logic;
      Core_Reset_Req_0 : in std_logic;
      Chip_Reset_Req_0 : in std_logic;
      System_Reset_Req_0 : in std_logic;
      Core_Reset_Req_1 : in std_logic;
      Chip_Reset_Req_1 : in std_logic;
      System_Reset_Req_1 : in std_logic;
      Dcm_locked : in std_logic;
      RstcPPCresetcore_0 : out std_logic;
      RstcPPCresetchip_0 : out std_logic;
      RstcPPCresetsys_0 : out std_logic;
      RstcPPCresetcore_1 : out std_logic;
      RstcPPCresetchip_1 : out std_logic;
      RstcPPCresetsys_1 : out std_logic;
      MB_Reset : out std_logic;
      Bus_Struct_Reset : out std_logic_vector(0 to 0);
      Peripheral_Reset : out std_logic_vector(0 to 0);
      Interconnect_aresetn : out std_logic_vector(0 to 0);
      Peripheral_aresetn : out std_logic_vector(0 to 0)
    );
  end component;

  component system_mdm_0_wrapper is
    port (
      Interrupt : out std_logic;
      Debug_SYS_Rst : out std_logic;
      Ext_BRK : out std_logic;
      Ext_NM_BRK : out std_logic;
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1);
      Dbg_Clk_0 : out std_logic;
      Dbg_TDI_0 : out std_logic;
      Dbg_TDO_0 : in std_logic;
      Dbg_Reg_En_0 : out std_logic_vector(0 to 7);
      Dbg_Capture_0 : out std_logic;
      Dbg_Shift_0 : out std_logic;
      Dbg_Update_0 : out std_logic;
      Dbg_Rst_0 : out std_logic;
      Dbg_Clk_1 : out std_logic;
      Dbg_TDI_1 : out std_logic;
      Dbg_TDO_1 : in std_logic;
      Dbg_Reg_En_1 : out std_logic_vector(0 to 7);
      Dbg_Capture_1 : out std_logic;
      Dbg_Shift_1 : out std_logic;
      Dbg_Update_1 : out std_logic;
      Dbg_Rst_1 : out std_logic;
      Dbg_Clk_2 : out std_logic;
      Dbg_TDI_2 : out std_logic;
      Dbg_TDO_2 : in std_logic;
      Dbg_Reg_En_2 : out std_logic_vector(0 to 7);
      Dbg_Capture_2 : out std_logic;
      Dbg_Shift_2 : out std_logic;
      Dbg_Update_2 : out std_logic;
      Dbg_Rst_2 : out std_logic;
      Dbg_Clk_3 : out std_logic;
      Dbg_TDI_3 : out std_logic;
      Dbg_TDO_3 : in std_logic;
      Dbg_Reg_En_3 : out std_logic_vector(0 to 7);
      Dbg_Capture_3 : out std_logic;
      Dbg_Shift_3 : out std_logic;
      Dbg_Update_3 : out std_logic;
      Dbg_Rst_3 : out std_logic;
      Dbg_Clk_4 : out std_logic;
      Dbg_TDI_4 : out std_logic;
      Dbg_TDO_4 : in std_logic;
      Dbg_Reg_En_4 : out std_logic_vector(0 to 7);
      Dbg_Capture_4 : out std_logic;
      Dbg_Shift_4 : out std_logic;
      Dbg_Update_4 : out std_logic;
      Dbg_Rst_4 : out std_logic;
      Dbg_Clk_5 : out std_logic;
      Dbg_TDI_5 : out std_logic;
      Dbg_TDO_5 : in std_logic;
      Dbg_Reg_En_5 : out std_logic_vector(0 to 7);
      Dbg_Capture_5 : out std_logic;
      Dbg_Shift_5 : out std_logic;
      Dbg_Update_5 : out std_logic;
      Dbg_Rst_5 : out std_logic;
      Dbg_Clk_6 : out std_logic;
      Dbg_TDI_6 : out std_logic;
      Dbg_TDO_6 : in std_logic;
      Dbg_Reg_En_6 : out std_logic_vector(0 to 7);
      Dbg_Capture_6 : out std_logic;
      Dbg_Shift_6 : out std_logic;
      Dbg_Update_6 : out std_logic;
      Dbg_Rst_6 : out std_logic;
      Dbg_Clk_7 : out std_logic;
      Dbg_TDI_7 : out std_logic;
      Dbg_TDO_7 : in std_logic;
      Dbg_Reg_En_7 : out std_logic_vector(0 to 7);
      Dbg_Capture_7 : out std_logic;
      Dbg_Shift_7 : out std_logic;
      Dbg_Update_7 : out std_logic;
      Dbg_Rst_7 : out std_logic;
      Dbg_Clk_8 : out std_logic;
      Dbg_TDI_8 : out std_logic;
      Dbg_TDO_8 : in std_logic;
      Dbg_Reg_En_8 : out std_logic_vector(0 to 7);
      Dbg_Capture_8 : out std_logic;
      Dbg_Shift_8 : out std_logic;
      Dbg_Update_8 : out std_logic;
      Dbg_Rst_8 : out std_logic;
      Dbg_Clk_9 : out std_logic;
      Dbg_TDI_9 : out std_logic;
      Dbg_TDO_9 : in std_logic;
      Dbg_Reg_En_9 : out std_logic_vector(0 to 7);
      Dbg_Capture_9 : out std_logic;
      Dbg_Shift_9 : out std_logic;
      Dbg_Update_9 : out std_logic;
      Dbg_Rst_9 : out std_logic;
      Dbg_Clk_10 : out std_logic;
      Dbg_TDI_10 : out std_logic;
      Dbg_TDO_10 : in std_logic;
      Dbg_Reg_En_10 : out std_logic_vector(0 to 7);
      Dbg_Capture_10 : out std_logic;
      Dbg_Shift_10 : out std_logic;
      Dbg_Update_10 : out std_logic;
      Dbg_Rst_10 : out std_logic;
      Dbg_Clk_11 : out std_logic;
      Dbg_TDI_11 : out std_logic;
      Dbg_TDO_11 : in std_logic;
      Dbg_Reg_En_11 : out std_logic_vector(0 to 7);
      Dbg_Capture_11 : out std_logic;
      Dbg_Shift_11 : out std_logic;
      Dbg_Update_11 : out std_logic;
      Dbg_Rst_11 : out std_logic;
      Dbg_Clk_12 : out std_logic;
      Dbg_TDI_12 : out std_logic;
      Dbg_TDO_12 : in std_logic;
      Dbg_Reg_En_12 : out std_logic_vector(0 to 7);
      Dbg_Capture_12 : out std_logic;
      Dbg_Shift_12 : out std_logic;
      Dbg_Update_12 : out std_logic;
      Dbg_Rst_12 : out std_logic;
      Dbg_Clk_13 : out std_logic;
      Dbg_TDI_13 : out std_logic;
      Dbg_TDO_13 : in std_logic;
      Dbg_Reg_En_13 : out std_logic_vector(0 to 7);
      Dbg_Capture_13 : out std_logic;
      Dbg_Shift_13 : out std_logic;
      Dbg_Update_13 : out std_logic;
      Dbg_Rst_13 : out std_logic;
      Dbg_Clk_14 : out std_logic;
      Dbg_TDI_14 : out std_logic;
      Dbg_TDO_14 : in std_logic;
      Dbg_Reg_En_14 : out std_logic_vector(0 to 7);
      Dbg_Capture_14 : out std_logic;
      Dbg_Shift_14 : out std_logic;
      Dbg_Update_14 : out std_logic;
      Dbg_Rst_14 : out std_logic;
      Dbg_Clk_15 : out std_logic;
      Dbg_TDI_15 : out std_logic;
      Dbg_TDO_15 : in std_logic;
      Dbg_Reg_En_15 : out std_logic_vector(0 to 7);
      Dbg_Capture_15 : out std_logic;
      Dbg_Shift_15 : out std_logic;
      Dbg_Update_15 : out std_logic;
      Dbg_Rst_15 : out std_logic;
      Dbg_Clk_16 : out std_logic;
      Dbg_TDI_16 : out std_logic;
      Dbg_TDO_16 : in std_logic;
      Dbg_Reg_En_16 : out std_logic_vector(0 to 7);
      Dbg_Capture_16 : out std_logic;
      Dbg_Shift_16 : out std_logic;
      Dbg_Update_16 : out std_logic;
      Dbg_Rst_16 : out std_logic;
      Dbg_Clk_17 : out std_logic;
      Dbg_TDI_17 : out std_logic;
      Dbg_TDO_17 : in std_logic;
      Dbg_Reg_En_17 : out std_logic_vector(0 to 7);
      Dbg_Capture_17 : out std_logic;
      Dbg_Shift_17 : out std_logic;
      Dbg_Update_17 : out std_logic;
      Dbg_Rst_17 : out std_logic;
      Dbg_Clk_18 : out std_logic;
      Dbg_TDI_18 : out std_logic;
      Dbg_TDO_18 : in std_logic;
      Dbg_Reg_En_18 : out std_logic_vector(0 to 7);
      Dbg_Capture_18 : out std_logic;
      Dbg_Shift_18 : out std_logic;
      Dbg_Update_18 : out std_logic;
      Dbg_Rst_18 : out std_logic;
      Dbg_Clk_19 : out std_logic;
      Dbg_TDI_19 : out std_logic;
      Dbg_TDO_19 : in std_logic;
      Dbg_Reg_En_19 : out std_logic_vector(0 to 7);
      Dbg_Capture_19 : out std_logic;
      Dbg_Shift_19 : out std_logic;
      Dbg_Update_19 : out std_logic;
      Dbg_Rst_19 : out std_logic;
      Dbg_Clk_20 : out std_logic;
      Dbg_TDI_20 : out std_logic;
      Dbg_TDO_20 : in std_logic;
      Dbg_Reg_En_20 : out std_logic_vector(0 to 7);
      Dbg_Capture_20 : out std_logic;
      Dbg_Shift_20 : out std_logic;
      Dbg_Update_20 : out std_logic;
      Dbg_Rst_20 : out std_logic;
      Dbg_Clk_21 : out std_logic;
      Dbg_TDI_21 : out std_logic;
      Dbg_TDO_21 : in std_logic;
      Dbg_Reg_En_21 : out std_logic_vector(0 to 7);
      Dbg_Capture_21 : out std_logic;
      Dbg_Shift_21 : out std_logic;
      Dbg_Update_21 : out std_logic;
      Dbg_Rst_21 : out std_logic;
      Dbg_Clk_22 : out std_logic;
      Dbg_TDI_22 : out std_logic;
      Dbg_TDO_22 : in std_logic;
      Dbg_Reg_En_22 : out std_logic_vector(0 to 7);
      Dbg_Capture_22 : out std_logic;
      Dbg_Shift_22 : out std_logic;
      Dbg_Update_22 : out std_logic;
      Dbg_Rst_22 : out std_logic;
      Dbg_Clk_23 : out std_logic;
      Dbg_TDI_23 : out std_logic;
      Dbg_TDO_23 : in std_logic;
      Dbg_Reg_En_23 : out std_logic_vector(0 to 7);
      Dbg_Capture_23 : out std_logic;
      Dbg_Shift_23 : out std_logic;
      Dbg_Update_23 : out std_logic;
      Dbg_Rst_23 : out std_logic;
      Dbg_Clk_24 : out std_logic;
      Dbg_TDI_24 : out std_logic;
      Dbg_TDO_24 : in std_logic;
      Dbg_Reg_En_24 : out std_logic_vector(0 to 7);
      Dbg_Capture_24 : out std_logic;
      Dbg_Shift_24 : out std_logic;
      Dbg_Update_24 : out std_logic;
      Dbg_Rst_24 : out std_logic;
      Dbg_Clk_25 : out std_logic;
      Dbg_TDI_25 : out std_logic;
      Dbg_TDO_25 : in std_logic;
      Dbg_Reg_En_25 : out std_logic_vector(0 to 7);
      Dbg_Capture_25 : out std_logic;
      Dbg_Shift_25 : out std_logic;
      Dbg_Update_25 : out std_logic;
      Dbg_Rst_25 : out std_logic;
      Dbg_Clk_26 : out std_logic;
      Dbg_TDI_26 : out std_logic;
      Dbg_TDO_26 : in std_logic;
      Dbg_Reg_En_26 : out std_logic_vector(0 to 7);
      Dbg_Capture_26 : out std_logic;
      Dbg_Shift_26 : out std_logic;
      Dbg_Update_26 : out std_logic;
      Dbg_Rst_26 : out std_logic;
      Dbg_Clk_27 : out std_logic;
      Dbg_TDI_27 : out std_logic;
      Dbg_TDO_27 : in std_logic;
      Dbg_Reg_En_27 : out std_logic_vector(0 to 7);
      Dbg_Capture_27 : out std_logic;
      Dbg_Shift_27 : out std_logic;
      Dbg_Update_27 : out std_logic;
      Dbg_Rst_27 : out std_logic;
      Dbg_Clk_28 : out std_logic;
      Dbg_TDI_28 : out std_logic;
      Dbg_TDO_28 : in std_logic;
      Dbg_Reg_En_28 : out std_logic_vector(0 to 7);
      Dbg_Capture_28 : out std_logic;
      Dbg_Shift_28 : out std_logic;
      Dbg_Update_28 : out std_logic;
      Dbg_Rst_28 : out std_logic;
      Dbg_Clk_29 : out std_logic;
      Dbg_TDI_29 : out std_logic;
      Dbg_TDO_29 : in std_logic;
      Dbg_Reg_En_29 : out std_logic_vector(0 to 7);
      Dbg_Capture_29 : out std_logic;
      Dbg_Shift_29 : out std_logic;
      Dbg_Update_29 : out std_logic;
      Dbg_Rst_29 : out std_logic;
      Dbg_Clk_30 : out std_logic;
      Dbg_TDI_30 : out std_logic;
      Dbg_TDO_30 : in std_logic;
      Dbg_Reg_En_30 : out std_logic_vector(0 to 7);
      Dbg_Capture_30 : out std_logic;
      Dbg_Shift_30 : out std_logic;
      Dbg_Update_30 : out std_logic;
      Dbg_Rst_30 : out std_logic;
      Dbg_Clk_31 : out std_logic;
      Dbg_TDI_31 : out std_logic;
      Dbg_TDO_31 : in std_logic;
      Dbg_Reg_En_31 : out std_logic_vector(0 to 7);
      Dbg_Capture_31 : out std_logic;
      Dbg_Shift_31 : out std_logic;
      Dbg_Update_31 : out std_logic;
      Dbg_Rst_31 : out std_logic;
      bscan_tdi : out std_logic;
      bscan_reset : out std_logic;
      bscan_shift : out std_logic;
      bscan_update : out std_logic;
      bscan_capture : out std_logic;
      bscan_sel1 : out std_logic;
      bscan_drck1 : out std_logic;
      bscan_tdo1 : in std_logic;
      bscan_ext_tdi : in std_logic;
      bscan_ext_reset : in std_logic;
      bscan_ext_shift : in std_logic;
      bscan_ext_update : in std_logic;
      bscan_ext_capture : in std_logic;
      bscan_ext_sel : in std_logic;
      bscan_ext_drck : in std_logic;
      bscan_ext_tdo : out std_logic;
      Ext_JTAG_DRCK : out std_logic;
      Ext_JTAG_RESET : out std_logic;
      Ext_JTAG_SEL : out std_logic;
      Ext_JTAG_CAPTURE : out std_logic;
      Ext_JTAG_SHIFT : out std_logic;
      Ext_JTAG_UPDATE : out std_logic;
      Ext_JTAG_TDI : out std_logic;
      Ext_JTAG_TDO : in std_logic
    );
  end component;

  component system_my_newip_22_0_wrapper is
    port (
      LED : out std_logic_vector(0 to 4);
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 1);
      Sl_MWrErr : out std_logic_vector(0 to 1);
      Sl_MRdErr : out std_logic_vector(0 to 1);
      Sl_MIRQ : out std_logic_vector(0 to 1)
    );
  end component;

  component IOBUF is
    port (
      I : in std_logic;
      IO : inout std_logic;
      O : out std_logic;
      T : in std_logic
    );
  end component;

  -- Internal signals

  signal CLK_S : std_logic;
  signal Dcm_all_locked : std_logic;
  signal clk_100_0000MHzDCM0 : std_logic;
  signal fpga_0_LEDs_4Bit_GPIO_IO_pin_I : std_logic_vector(0 to 3);
  signal fpga_0_LEDs_4Bit_GPIO_IO_pin_O : std_logic_vector(0 to 3);
  signal fpga_0_LEDs_4Bit_GPIO_IO_pin_T : std_logic_vector(0 to 3);
  signal fpga_0_Push_Buttons_Position_GPIO_IO_pin_I : std_logic_vector(0 to 4);
  signal fpga_0_Push_Buttons_Position_GPIO_IO_pin_O : std_logic_vector(0 to 4);
  signal fpga_0_Push_Buttons_Position_GPIO_IO_pin_T : std_logic_vector(0 to 4);
  signal fpga_0_SRAM_Mem_A_pin_vslice_9_29_concat : std_logic_vector(9 to 29);
  signal fpga_0_SRAM_Mem_DQ_pin_I : std_logic_vector(0 to 31);
  signal fpga_0_SRAM_Mem_DQ_pin_O : std_logic_vector(0 to 31);
  signal fpga_0_SRAM_Mem_DQ_pin_T : std_logic_vector(0 to 31);
  signal fpga_0_SysACE_CompactFlash_SysACE_MPA_pin_vslice_6_1_concat : std_logic_vector(6 downto 1);
  signal fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I : std_logic_vector(15 downto 0);
  signal fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O : std_logic_vector(15 downto 0);
  signal fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T : std_logic_vector(15 downto 0);
  signal my_newip_22_0_LED : std_logic_vector(0 to 4);
  signal net_gnd0 : std_logic;
  signal net_gnd2 : std_logic_vector(0 to 1);
  signal net_gnd3 : std_logic_vector(0 to 2);
  signal net_gnd4 : std_logic_vector(0 to 3);
  signal net_gnd5 : std_logic_vector(0 to 4);
  signal net_gnd8 : std_logic_vector(0 to 7);
  signal net_gnd10 : std_logic_vector(0 to 9);
  signal net_gnd32 : std_logic_vector(0 to 31);
  signal net_gnd64 : std_logic_vector(0 to 63);
  signal net_vcc0 : std_logic;
  signal pgassign1 : std_logic_vector(0 to 0);
  signal pgassign2 : std_logic_vector(0 to 0);
  signal pgassign3 : std_logic_vector(0 to 0);
  signal pgassign4 : std_logic_vector(0 to 8);
  signal pgassign5 : std_logic_vector(0 to 1);
  signal pgassign6 : std_logic_vector(6 downto 0);
  signal pgassign7 : std_logic_vector(0 to 31);
  signal plb_MPLB_Rst : std_logic_vector(0 to 1);
  signal plb_M_ABus : std_logic_vector(0 to 63);
  signal plb_M_BE : std_logic_vector(0 to 15);
  signal plb_M_MSize : std_logic_vector(0 to 3);
  signal plb_M_RNW : std_logic_vector(0 to 1);
  signal plb_M_TAttribute : std_logic_vector(0 to 31);
  signal plb_M_UABus : std_logic_vector(0 to 63);
  signal plb_M_abort : std_logic_vector(0 to 1);
  signal plb_M_busLock : std_logic_vector(0 to 1);
  signal plb_M_lockErr : std_logic_vector(0 to 1);
  signal plb_M_priority : std_logic_vector(0 to 3);
  signal plb_M_rdBurst : std_logic_vector(0 to 1);
  signal plb_M_request : std_logic_vector(0 to 1);
  signal plb_M_size : std_logic_vector(0 to 7);
  signal plb_M_type : std_logic_vector(0 to 5);
  signal plb_M_wrBurst : std_logic_vector(0 to 1);
  signal plb_M_wrDBus : std_logic_vector(0 to 127);
  signal plb_PLB_ABus : std_logic_vector(0 to 31);
  signal plb_PLB_BE : std_logic_vector(0 to 7);
  signal plb_PLB_MAddrAck : std_logic_vector(0 to 1);
  signal plb_PLB_MBusy : std_logic_vector(0 to 1);
  signal plb_PLB_MRdBTerm : std_logic_vector(0 to 1);
  signal plb_PLB_MRdDAck : std_logic_vector(0 to 1);
  signal plb_PLB_MRdDBus : std_logic_vector(0 to 127);
  signal plb_PLB_MRdErr : std_logic_vector(0 to 1);
  signal plb_PLB_MRdWdAddr : std_logic_vector(0 to 7);
  signal plb_PLB_MRearbitrate : std_logic_vector(0 to 1);
  signal plb_PLB_MSSize : std_logic_vector(0 to 3);
  signal plb_PLB_MSize : std_logic_vector(0 to 1);
  signal plb_PLB_MTimeout : std_logic_vector(0 to 1);
  signal plb_PLB_MWrBTerm : std_logic_vector(0 to 1);
  signal plb_PLB_MWrDAck : std_logic_vector(0 to 1);
  signal plb_PLB_MWrErr : std_logic_vector(0 to 1);
  signal plb_PLB_PAValid : std_logic;
  signal plb_PLB_RNW : std_logic;
  signal plb_PLB_SAValid : std_logic;
  signal plb_PLB_TAttribute : std_logic_vector(0 to 15);
  signal plb_PLB_UABus : std_logic_vector(0 to 31);
  signal plb_PLB_abort : std_logic;
  signal plb_PLB_busLock : std_logic;
  signal plb_PLB_lockErr : std_logic;
  signal plb_PLB_masterID : std_logic_vector(0 to 0);
  signal plb_PLB_rdBurst : std_logic;
  signal plb_PLB_rdPendPri : std_logic_vector(0 to 1);
  signal plb_PLB_rdPendReq : std_logic;
  signal plb_PLB_rdPrim : std_logic_vector(0 to 9);
  signal plb_PLB_reqPri : std_logic_vector(0 to 1);
  signal plb_PLB_size : std_logic_vector(0 to 3);
  signal plb_PLB_type : std_logic_vector(0 to 2);
  signal plb_PLB_wrBurst : std_logic;
  signal plb_PLB_wrDBus : std_logic_vector(0 to 63);
  signal plb_PLB_wrPendPri : std_logic_vector(0 to 1);
  signal plb_PLB_wrPendReq : std_logic;
  signal plb_PLB_wrPrim : std_logic_vector(0 to 9);
  signal plb_SPLB_Rst : std_logic_vector(0 to 9);
  signal plb_Sl_MBusy : std_logic_vector(0 to 19);
  signal plb_Sl_MIRQ : std_logic_vector(0 to 19);
  signal plb_Sl_MRdErr : std_logic_vector(0 to 19);
  signal plb_Sl_MWrErr : std_logic_vector(0 to 19);
  signal plb_Sl_SSize : std_logic_vector(0 to 19);
  signal plb_Sl_addrAck : std_logic_vector(0 to 9);
  signal plb_Sl_rdBTerm : std_logic_vector(0 to 9);
  signal plb_Sl_rdComp : std_logic_vector(0 to 9);
  signal plb_Sl_rdDAck : std_logic_vector(0 to 9);
  signal plb_Sl_rdDBus : std_logic_vector(0 to 639);
  signal plb_Sl_rdWdAddr : std_logic_vector(0 to 39);
  signal plb_Sl_rearbitrate : std_logic_vector(0 to 9);
  signal plb_Sl_wait : std_logic_vector(0 to 9);
  signal plb_Sl_wrBTerm : std_logic_vector(0 to 9);
  signal plb_Sl_wrComp : std_logic_vector(0 to 9);
  signal plb_Sl_wrDAck : std_logic_vector(0 to 9);
  signal ppc405_0_jtagppc_bus_C405JTGTDO : std_logic;
  signal ppc405_0_jtagppc_bus_C405JTGTDOEN : std_logic;
  signal ppc405_0_jtagppc_bus_JTGC405TCK : std_logic;
  signal ppc405_0_jtagppc_bus_JTGC405TDI : std_logic;
  signal ppc405_0_jtagppc_bus_JTGC405TMS : std_logic;
  signal ppc405_0_jtagppc_bus_JTGC405TRSTNEG : std_logic;
  signal ppc_reset_bus_Chip_Reset_Req : std_logic;
  signal ppc_reset_bus_Core_Reset_Req : std_logic;
  signal ppc_reset_bus_RstcPPCresetcore : std_logic;
  signal ppc_reset_bus_RstcPPCresetsys : std_logic;
  signal ppc_reset_bus_RstsPPCresetchip : std_logic;
  signal ppc_reset_bus_System_Reset_Req : std_logic;
  signal sys_bus_reset : std_logic_vector(0 to 0);
  signal sys_rst_s : std_logic;
  signal xps_bram_if_cntlr_1_port_BRAM_Addr : std_logic_vector(0 to 31);
  signal xps_bram_if_cntlr_1_port_BRAM_Clk : std_logic;
  signal xps_bram_if_cntlr_1_port_BRAM_Din : std_logic_vector(0 to 63);
  signal xps_bram_if_cntlr_1_port_BRAM_Dout : std_logic_vector(0 to 63);
  signal xps_bram_if_cntlr_1_port_BRAM_EN : std_logic;
  signal xps_bram_if_cntlr_1_port_BRAM_Rst : std_logic;
  signal xps_bram_if_cntlr_1_port_BRAM_WEN : std_logic_vector(0 to 7);

  attribute BUFFER_TYPE : STRING;
  attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of fpga_0_SysACE_CompactFlash_SysACE_CLK_pin : signal is "BUFGP";
  attribute BOX_TYPE of system_ppc405_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_plb_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_xps_bram_if_cntlr_1_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_plb_bram_if_cntlr_1_bram_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_leds_4bit_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_leds_positions_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_push_buttons_position_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_sysace_compactflash_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_sram_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_xps_timer_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_xps_timebase_wdt_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_clock_generator_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_jtagppc_cntlr_inst_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_proc_sys_reset_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_mdm_0_wrapper : component is "user_black_box";
  attribute BOX_TYPE of system_my_newip_22_0_wrapper : component is "user_black_box";

begin

  -- Internal assignments

  fpga_0_SysACE_CompactFlash_SysACE_MPA_pin <= fpga_0_SysACE_CompactFlash_SysACE_MPA_pin_vslice_6_1_concat;
  fpga_0_SRAM_Mem_A_pin <= fpga_0_SRAM_Mem_A_pin_vslice_9_29_concat;
  fpga_0_SRAM_ZBT_CLK_OUT_pin <= clk_100_0000MHzDCM0;
  CLK_S <= fpga_0_clk_1_sys_clk_pin;
  sys_rst_s <= fpga_0_rst_1_sys_rst_pin;
  my_newip_22_0_LED_pin <= my_newip_22_0_LED;
  pgassign3(0 to 0) <= B"0";
  pgassign4(0 to 8) <= B"000000000";
  pgassign5(0 to 1) <= B"00";
  fpga_0_SRAM_Mem_CEN_pin <= pgassign1(0);
  fpga_0_SRAM_Mem_OEN_pin <= pgassign2(0);
  fpga_0_SysACE_CompactFlash_SysACE_MPA_pin_vslice_6_1_concat(6 downto 1) <= pgassign6(6 downto 1);
  fpga_0_SRAM_Mem_A_pin_vslice_9_29_concat(9 to 29) <= pgassign7(9 to 29);
  net_gnd0 <= '0';
  net_gnd10(0 to 9) <= B"0000000000";
  net_gnd2(0 to 1) <= B"00";
  net_gnd3(0 to 2) <= B"000";
  net_gnd32(0 to 31) <= B"00000000000000000000000000000000";
  net_gnd4(0 to 3) <= B"0000";
  net_gnd5(0 to 4) <= B"00000";
  net_gnd64(0 to 63) <= B"0000000000000000000000000000000000000000000000000000000000000000";
  net_gnd8(0 to 7) <= B"00000000";
  net_vcc0 <= '1';

  ppc405_0 : system_ppc405_0_wrapper
    port map (
      C405CPMCORESLEEPREQ => open,
      C405CPMMSRCE => open,
      C405CPMMSREE => open,
      C405CPMTIMERIRQ => open,
      C405CPMTIMERRESETREQ => open,
      C405XXXMACHINECHECK => open,
      CPMC405CLOCK => clk_100_0000MHzDCM0,
      CPMC405CORECLKINACTIVE => net_gnd0,
      CPMC405CPUCLKEN => net_vcc0,
      CPMC405JTAGCLKEN => net_vcc0,
      CPMC405TIMERCLKEN => net_vcc0,
      CPMC405TIMERTICK => net_vcc0,
      MCBCPUCLKEN => net_vcc0,
      MCBTIMEREN => net_vcc0,
      MCPPCRST => net_vcc0,
      CPMDCRCLK => net_vcc0,
      CPMFCMCLK => net_vcc0,
      C405RSTCHIPRESETREQ => ppc_reset_bus_Chip_Reset_Req,
      C405RSTCORERESETREQ => ppc_reset_bus_Core_Reset_Req,
      C405RSTSYSRESETREQ => ppc_reset_bus_System_Reset_Req,
      RSTC405RESETCHIP => ppc_reset_bus_RstsPPCresetchip,
      RSTC405RESETCORE => ppc_reset_bus_RstcPPCresetcore,
      RSTC405RESETSYS => ppc_reset_bus_RstcPPCresetsys,
      APUFCMDECODED => open,
      APUFCMDECUDI => open,
      APUFCMDECUDIVALID => open,
      APUFCMENDIAN => open,
      APUFCMFLUSH => open,
      APUFCMINSTRUCTION => open,
      APUFCMINSTRVALID => open,
      APUFCMLOADBYTEEN => open,
      APUFCMLOADDATA => open,
      APUFCMLOADDVALID => open,
      APUFCMOPERANDVALID => open,
      APUFCMRADATA => open,
      APUFCMRBDATA => open,
      APUFCMWRITEBACKOK => open,
      APUFCMXERCA => open,
      FCMAPUCR => net_gnd4,
      FCMAPUDCDCREN => net_gnd0,
      FCMAPUDCDFORCEALIGN => net_gnd0,
      FCMAPUDCDFORCEBESTEERING => net_gnd0,
      FCMAPUDCDFPUOP => net_gnd0,
      FCMAPUDCDGPRWRITE => net_gnd0,
      FCMAPUDCDLDSTBYTE => net_gnd0,
      FCMAPUDCDLDSTDW => net_gnd0,
      FCMAPUDCDLDSTHW => net_gnd0,
      FCMAPUDCDLDSTQW => net_gnd0,
      FCMAPUDCDLDSTWD => net_gnd0,
      FCMAPUDCDLOAD => net_gnd0,
      FCMAPUDCDPRIVOP => net_gnd0,
      FCMAPUDCDRAEN => net_gnd0,
      FCMAPUDCDRBEN => net_gnd0,
      FCMAPUDCDSTORE => net_gnd0,
      FCMAPUDCDTRAPBE => net_gnd0,
      FCMAPUDCDTRAPLE => net_gnd0,
      FCMAPUDCDUPDATE => net_gnd0,
      FCMAPUDCDXERCAEN => net_gnd0,
      FCMAPUDCDXEROVEN => net_gnd0,
      FCMAPUDECODEBUSY => net_gnd0,
      FCMAPUDONE => net_gnd0,
      FCMAPUEXCEPTION => net_gnd0,
      FCMAPUEXEBLOCKINGMCO => net_gnd0,
      FCMAPUEXECRFIELD => net_gnd3,
      FCMAPUEXENONBLOCKINGMCO => net_gnd0,
      FCMAPUINSTRACK => net_gnd0,
      FCMAPULOADWAIT => net_gnd0,
      FCMAPURESULT => net_gnd32,
      FCMAPURESULTVALID => net_gnd0,
      FCMAPUSLEEPNOTREADY => net_gnd0,
      FCMAPUXERCA => net_gnd0,
      FCMAPUXEROV => net_gnd0,
      IPLB0_PLB_Clk => clk_100_0000MHzDCM0,
      IPLB0_PLB_Rst => plb_MPLB_Rst(1),
      IPLB0_PLB_MBusy => plb_PLB_MBusy(1),
      IPLB0_PLB_MRdErr => plb_PLB_MRdErr(1),
      IPLB0_PLB_MWrErr => plb_PLB_MWrErr(1),
      IPLB0_PLB_MWrBTerm => plb_PLB_MWrBTerm(1),
      IPLB0_PLB_MWrDAck => plb_PLB_MWrDAck(1),
      IPLB0_PLB_MAddrAck => plb_PLB_MAddrAck(1),
      IPLB0_PLB_MRdBTerm => plb_PLB_MRdBTerm(1),
      IPLB0_PLB_MRdDAck => plb_PLB_MRdDAck(1),
      IPLB0_PLB_MRdDBus => plb_PLB_MRdDBus(64 to 127),
      IPLB0_PLB_MRearbitrate => plb_PLB_MRearbitrate(1),
      IPLB0_PLB_MSSize => plb_PLB_MSSize(2 to 3),
      IPLB0_PLB_MTimeout => plb_PLB_MTimeout(1),
      IPLB0_PLB_MRdWdAddr => plb_PLB_MRdWdAddr(4 to 7),
      IPLB0_M_ABus => plb_M_ABus(32 to 63),
      IPLB0_M_BE => plb_M_BE(8 to 15),
      IPLB0_M_MSize => plb_M_MSize(2 to 3),
      IPLB0_M_rdBurst => plb_M_rdBurst(1),
      IPLB0_M_request => plb_M_request(1),
      IPLB0_M_RNW => plb_M_RNW(1),
      IPLB0_M_size => plb_M_size(4 to 7),
      IPLB0_M_wrBurst => plb_M_wrBurst(1),
      IPLB0_M_wrDBus => plb_M_wrDBus(64 to 127),
      IPLB0_M_abort => plb_M_abort(1),
      IPLB0_M_UABus => plb_M_UABus(32 to 63),
      IPLB0_M_busLock => plb_M_busLock(1),
      IPLB0_M_lockErr => plb_M_lockErr(1),
      IPLB0_M_priority => plb_M_priority(2 to 3),
      IPLB0_M_type => plb_M_type(3 to 5),
      IPLB0_M_TAttribute => plb_M_TAttribute(16 to 31),
      DPLB0_PLB_Clk => clk_100_0000MHzDCM0,
      DPLB0_PLB_Rst => plb_MPLB_Rst(0),
      DPLB0_PLB_MBusy => plb_PLB_MBusy(0),
      DPLB0_PLB_MRdErr => plb_PLB_MRdErr(0),
      DPLB0_PLB_MWrErr => plb_PLB_MWrErr(0),
      DPLB0_PLB_MWrBTerm => plb_PLB_MWrBTerm(0),
      DPLB0_PLB_MWrDAck => plb_PLB_MWrDAck(0),
      DPLB0_PLB_MAddrAck => plb_PLB_MAddrAck(0),
      DPLB0_PLB_MRdBTerm => plb_PLB_MRdBTerm(0),
      DPLB0_PLB_MRdDAck => plb_PLB_MRdDAck(0),
      DPLB0_PLB_MRdDBus => plb_PLB_MRdDBus(0 to 63),
      DPLB0_PLB_MRearbitrate => plb_PLB_MRearbitrate(0),
      DPLB0_PLB_MSSize => plb_PLB_MSSize(0 to 1),
      DPLB0_PLB_MTimeout => plb_PLB_MTimeout(0),
      DPLB0_PLB_MRdWdAddr => plb_PLB_MRdWdAddr(0 to 3),
      DPLB0_M_ABus => plb_M_ABus(0 to 31),
      DPLB0_M_BE => plb_M_BE(0 to 7),
      DPLB0_M_MSize => plb_M_MSize(0 to 1),
      DPLB0_M_rdBurst => plb_M_rdBurst(0),
      DPLB0_M_request => plb_M_request(0),
      DPLB0_M_RNW => plb_M_RNW(0),
      DPLB0_M_size => plb_M_size(0 to 3),
      DPLB0_M_wrBurst => plb_M_wrBurst(0),
      DPLB0_M_wrDBus => plb_M_wrDBus(0 to 63),
      DPLB0_M_abort => plb_M_abort(0),
      DPLB0_M_UABus => plb_M_UABus(0 to 31),
      DPLB0_M_busLock => plb_M_busLock(0),
      DPLB0_M_lockErr => plb_M_lockErr(0),
      DPLB0_M_priority => plb_M_priority(0 to 1),
      DPLB0_M_type => plb_M_type(0 to 2),
      DPLB0_M_TAttribute => plb_M_TAttribute(0 to 15),
      IPLB1_PLB_Clk => net_gnd0,
      IPLB1_PLB_Rst => net_gnd0,
      IPLB1_PLB_MBusy => net_gnd0,
      IPLB1_PLB_MRdErr => net_gnd0,
      IPLB1_PLB_MWrErr => net_gnd0,
      IPLB1_PLB_MWrBTerm => net_gnd0,
      IPLB1_PLB_MWrDAck => net_gnd0,
      IPLB1_PLB_MAddrAck => net_gnd0,
      IPLB1_PLB_MRdBTerm => net_gnd0,
      IPLB1_PLB_MRdDAck => net_gnd0,
      IPLB1_PLB_MRdDBus => net_gnd64,
      IPLB1_PLB_MRearbitrate => net_gnd0,
      IPLB1_PLB_MSSize => net_gnd2,
      IPLB1_PLB_MTimeout => net_gnd0,
      IPLB1_PLB_MRdWdAddr => net_gnd4,
      IPLB1_M_ABus => open,
      IPLB1_M_BE => open,
      IPLB1_M_MSize => open,
      IPLB1_M_rdBurst => open,
      IPLB1_M_request => open,
      IPLB1_M_RNW => open,
      IPLB1_M_size => open,
      IPLB1_M_wrBurst => open,
      IPLB1_M_wrDBus => open,
      IPLB1_M_abort => open,
      IPLB1_M_UABus => open,
      IPLB1_M_busLock => open,
      IPLB1_M_lockErr => open,
      IPLB1_M_priority => open,
      IPLB1_M_type => open,
      IPLB1_M_TAttribute => open,
      DPLB1_PLB_Clk => net_gnd0,
      DPLB1_PLB_Rst => net_gnd0,
      DPLB1_PLB_MBusy => net_gnd0,
      DPLB1_PLB_MRdErr => net_gnd0,
      DPLB1_PLB_MWrErr => net_gnd0,
      DPLB1_PLB_MWrBTerm => net_gnd0,
      DPLB1_PLB_MWrDAck => net_gnd0,
      DPLB1_PLB_MAddrAck => net_gnd0,
      DPLB1_PLB_MRdBTerm => net_gnd0,
      DPLB1_PLB_MRdDAck => net_gnd0,
      DPLB1_PLB_MRdDBus => net_gnd64,
      DPLB1_PLB_MRearbitrate => net_gnd0,
      DPLB1_PLB_MSSize => net_gnd2,
      DPLB1_PLB_MTimeout => net_gnd0,
      DPLB1_PLB_MRdWdAddr => net_gnd4,
      DPLB1_M_ABus => open,
      DPLB1_M_BE => open,
      DPLB1_M_MSize => open,
      DPLB1_M_rdBurst => open,
      DPLB1_M_request => open,
      DPLB1_M_RNW => open,
      DPLB1_M_size => open,
      DPLB1_M_wrBurst => open,
      DPLB1_M_wrDBus => open,
      DPLB1_M_abort => open,
      DPLB1_M_UABus => open,
      DPLB1_M_busLock => open,
      DPLB1_M_lockErr => open,
      DPLB1_M_priority => open,
      DPLB1_M_type => open,
      DPLB1_M_TAttribute => open,
      BRAMDSOCMCLK => net_vcc0,
      BRAMDSOCMRDDBUS => net_gnd32,
      DSARCVALUE => net_gnd8,
      DSCNTLVALUE => net_gnd8,
      DSOCMBRAMABUS => open,
      DSOCMBRAMBYTEWRITE => open,
      DSOCMBRAMEN => open,
      DSOCMBRAMWRDBUS => open,
      DSOCMBUSY => open,
      DSOCMRDADDRVALID => open,
      DSOCMWRADDRVALID => open,
      DSOCMRWCOMPLETE => net_vcc0,
      BRAMISOCMCLK => net_vcc0,
      BRAMISOCMRDDBUS => net_gnd64,
      BRAMISOCMDCRRDDBUS => net_gnd32,
      ISARCVALUE => net_gnd8,
      ISCNTLVALUE => net_gnd8,
      ISOCMBRAMEN => open,
      ISOCMBRAMEVENWRITEEN => open,
      ISOCMBRAMODDWRITEEN => open,
      ISOCMBRAMRDABUS => open,
      ISOCMBRAMWRABUS => open,
      ISOCMBRAMWRDBUS => open,
      ISOCMDCRBRAMEVENEN => open,
      ISOCMDCRBRAMODDEN => open,
      ISOCMDCRBRAMRDSELECT => open,
      DCREMACABUS => open,
      DCREMACCLK => open,
      DCREMACDBUS => open,
      DCREMACENABLER => open,
      DCREMACREAD => open,
      DCREMACWRITE => open,
      EMACDCRACK => net_gnd0,
      EMACDCRDBUS => net_gnd32,
      EXTDCRABUS => open,
      EXTDCRDBUSOUT => open,
      EXTDCRREAD => open,
      EXTDCRWRITE => open,
      EXTDCRACK => net_gnd0,
      EXTDCRDBUSIN => net_gnd32,
      EICC405CRITINPUTIRQ => net_gnd0,
      EICC405EXTINPUTIRQ => net_gnd0,
      C405JTGCAPTUREDR => open,
      C405JTGEXTEST => open,
      C405JTGPGMOUT => open,
      C405JTGSHIFTDR => open,
      C405JTGTDO => ppc405_0_jtagppc_bus_C405JTGTDO,
      C405JTGTDOEN => ppc405_0_jtagppc_bus_C405JTGTDOEN,
      C405JTGUPDATEDR => open,
      MCBJTAGEN => net_vcc0,
      JTGC405BNDSCANTDO => net_gnd0,
      JTGC405TCK => ppc405_0_jtagppc_bus_JTGC405TCK,
      JTGC405TDI => ppc405_0_jtagppc_bus_JTGC405TDI,
      JTGC405TMS => ppc405_0_jtagppc_bus_JTGC405TMS,
      JTGC405TRSTNEG => ppc405_0_jtagppc_bus_JTGC405TRSTNEG,
      C405DBGMSRWE => open,
      C405DBGSTOPACK => open,
      C405DBGWBCOMPLETE => open,
      C405DBGWBFULL => open,
      C405DBGWBIAR => open,
      DBGC405DEBUGHALT => net_gnd0,
      DBGC405DEBUGHALTNEG => net_vcc0,
      DBGC405EXTBUSHOLDACK => net_gnd0,
      DBGC405UNCONDDEBUGEVENT => net_gnd0,
      C405DBGLOADDATAONAPUDBUS => open,
      C405TRCCYCLE => open,
      C405TRCEVENEXECUTIONSTATUS => open,
      C405TRCODDEXECUTIONSTATUS => open,
      C405TRCTRACESTATUS => open,
      C405TRCTRIGGEREVENTOUT => open,
      C405TRCTRIGGEREVENTTYPE => open,
      TRCC405TRACEDISABLE => net_gnd0,
      TRCC405TRIGGEREVENTIN => net_gnd0
    );

  plb : system_plb_wrapper
    port map (
      PLB_Clk => clk_100_0000MHzDCM0,
      SYS_Rst => sys_bus_reset(0),
      PLB_Rst => open,
      SPLB_Rst => plb_SPLB_Rst,
      MPLB_Rst => plb_MPLB_Rst,
      PLB_dcrAck => open,
      PLB_dcrDBus => open,
      DCR_ABus => net_gnd10,
      DCR_DBus => net_gnd32,
      DCR_Read => net_gnd0,
      DCR_Write => net_gnd0,
      M_ABus => plb_M_ABus,
      M_UABus => plb_M_UABus,
      M_BE => plb_M_BE,
      M_RNW => plb_M_RNW,
      M_abort => plb_M_abort,
      M_busLock => plb_M_busLock,
      M_TAttribute => plb_M_TAttribute,
      M_lockErr => plb_M_lockErr,
      M_MSize => plb_M_MSize,
      M_priority => plb_M_priority,
      M_rdBurst => plb_M_rdBurst,
      M_request => plb_M_request,
      M_size => plb_M_size,
      M_type => plb_M_type,
      M_wrBurst => plb_M_wrBurst,
      M_wrDBus => plb_M_wrDBus,
      Sl_addrAck => plb_Sl_addrAck,
      Sl_MRdErr => plb_Sl_MRdErr,
      Sl_MWrErr => plb_Sl_MWrErr,
      Sl_MBusy => plb_Sl_MBusy,
      Sl_rdBTerm => plb_Sl_rdBTerm,
      Sl_rdComp => plb_Sl_rdComp,
      Sl_rdDAck => plb_Sl_rdDAck,
      Sl_rdDBus => plb_Sl_rdDBus,
      Sl_rdWdAddr => plb_Sl_rdWdAddr,
      Sl_rearbitrate => plb_Sl_rearbitrate,
      Sl_SSize => plb_Sl_SSize,
      Sl_wait => plb_Sl_wait,
      Sl_wrBTerm => plb_Sl_wrBTerm,
      Sl_wrComp => plb_Sl_wrComp,
      Sl_wrDAck => plb_Sl_wrDAck,
      Sl_MIRQ => plb_Sl_MIRQ,
      PLB_MIRQ => open,
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_BE => plb_PLB_BE,
      PLB_MAddrAck => plb_PLB_MAddrAck,
      PLB_MTimeout => plb_PLB_MTimeout,
      PLB_MBusy => plb_PLB_MBusy,
      PLB_MRdErr => plb_PLB_MRdErr,
      PLB_MWrErr => plb_PLB_MWrErr,
      PLB_MRdBTerm => plb_PLB_MRdBTerm,
      PLB_MRdDAck => plb_PLB_MRdDAck,
      PLB_MRdDBus => plb_PLB_MRdDBus,
      PLB_MRdWdAddr => plb_PLB_MRdWdAddr,
      PLB_MRearbitrate => plb_PLB_MRearbitrate,
      PLB_MWrBTerm => plb_PLB_MWrBTerm,
      PLB_MWrDAck => plb_PLB_MWrDAck,
      PLB_MSSize => plb_PLB_MSSize,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_RNW => plb_PLB_RNW,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_TAttribute => plb_PLB_TAttribute,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_MSize => plb_PLB_MSize,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_rdPrim => plb_PLB_rdPrim,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrPrim => plb_PLB_wrPrim,
      PLB_SaddrAck => open,
      PLB_SMRdErr => open,
      PLB_SMWrErr => open,
      PLB_SMBusy => open,
      PLB_SrdBTerm => open,
      PLB_SrdComp => open,
      PLB_SrdDAck => open,
      PLB_SrdDBus => open,
      PLB_SrdWdAddr => open,
      PLB_Srearbitrate => open,
      PLB_Sssize => open,
      PLB_Swait => open,
      PLB_SwrBTerm => open,
      PLB_SwrComp => open,
      PLB_SwrDAck => open,
      Bus_Error_Det => open
    );

  xps_bram_if_cntlr_1 : system_xps_bram_if_cntlr_1_wrapper
    port map (
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(0),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(0),
      PLB_wrPrim => plb_PLB_wrPrim(0),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(0),
      Sl_SSize => plb_Sl_SSize(0 to 1),
      Sl_wait => plb_Sl_wait(0),
      Sl_rearbitrate => plb_Sl_rearbitrate(0),
      Sl_wrDAck => plb_Sl_wrDAck(0),
      Sl_wrComp => plb_Sl_wrComp(0),
      Sl_wrBTerm => plb_Sl_wrBTerm(0),
      Sl_rdDBus => plb_Sl_rdDBus(0 to 63),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(0 to 3),
      Sl_rdDAck => plb_Sl_rdDAck(0),
      Sl_rdComp => plb_Sl_rdComp(0),
      Sl_rdBTerm => plb_Sl_rdBTerm(0),
      Sl_MBusy => plb_Sl_MBusy(0 to 1),
      Sl_MWrErr => plb_Sl_MWrErr(0 to 1),
      Sl_MRdErr => plb_Sl_MRdErr(0 to 1),
      Sl_MIRQ => plb_Sl_MIRQ(0 to 1),
      BRAM_Rst => xps_bram_if_cntlr_1_port_BRAM_Rst,
      BRAM_Clk => xps_bram_if_cntlr_1_port_BRAM_Clk,
      BRAM_EN => xps_bram_if_cntlr_1_port_BRAM_EN,
      BRAM_WEN => xps_bram_if_cntlr_1_port_BRAM_WEN,
      BRAM_Addr => xps_bram_if_cntlr_1_port_BRAM_Addr,
      BRAM_Din => xps_bram_if_cntlr_1_port_BRAM_Din,
      BRAM_Dout => xps_bram_if_cntlr_1_port_BRAM_Dout
    );

  plb_bram_if_cntlr_1_bram : system_plb_bram_if_cntlr_1_bram_wrapper
    port map (
      BRAM_Rst_A => xps_bram_if_cntlr_1_port_BRAM_Rst,
      BRAM_Clk_A => xps_bram_if_cntlr_1_port_BRAM_Clk,
      BRAM_EN_A => xps_bram_if_cntlr_1_port_BRAM_EN,
      BRAM_WEN_A => xps_bram_if_cntlr_1_port_BRAM_WEN,
      BRAM_Addr_A => xps_bram_if_cntlr_1_port_BRAM_Addr,
      BRAM_Din_A => xps_bram_if_cntlr_1_port_BRAM_Din,
      BRAM_Dout_A => xps_bram_if_cntlr_1_port_BRAM_Dout,
      BRAM_Rst_B => net_gnd0,
      BRAM_Clk_B => net_gnd0,
      BRAM_EN_B => net_gnd0,
      BRAM_WEN_B => net_gnd8,
      BRAM_Addr_B => net_gnd32,
      BRAM_Din_B => open,
      BRAM_Dout_B => net_gnd64
    );

  LEDs_4Bit : system_leds_4bit_wrapper
    port map (
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(1),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(1),
      PLB_wrPrim => plb_PLB_wrPrim(1),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(1),
      Sl_SSize => plb_Sl_SSize(2 to 3),
      Sl_wait => plb_Sl_wait(1),
      Sl_rearbitrate => plb_Sl_rearbitrate(1),
      Sl_wrDAck => plb_Sl_wrDAck(1),
      Sl_wrComp => plb_Sl_wrComp(1),
      Sl_wrBTerm => plb_Sl_wrBTerm(1),
      Sl_rdDBus => plb_Sl_rdDBus(64 to 127),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(4 to 7),
      Sl_rdDAck => plb_Sl_rdDAck(1),
      Sl_rdComp => plb_Sl_rdComp(1),
      Sl_rdBTerm => plb_Sl_rdBTerm(1),
      Sl_MBusy => plb_Sl_MBusy(2 to 3),
      Sl_MWrErr => plb_Sl_MWrErr(2 to 3),
      Sl_MRdErr => plb_Sl_MRdErr(2 to 3),
      Sl_MIRQ => plb_Sl_MIRQ(2 to 3),
      IP2INTC_Irpt => open,
      GPIO_IO_I => fpga_0_LEDs_4Bit_GPIO_IO_pin_I,
      GPIO_IO_O => fpga_0_LEDs_4Bit_GPIO_IO_pin_O,
      GPIO_IO_T => fpga_0_LEDs_4Bit_GPIO_IO_pin_T,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  LEDs_Positions : system_leds_positions_wrapper
    port map (
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(2),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(2),
      PLB_wrPrim => plb_PLB_wrPrim(2),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(2),
      Sl_SSize => plb_Sl_SSize(4 to 5),
      Sl_wait => plb_Sl_wait(2),
      Sl_rearbitrate => plb_Sl_rearbitrate(2),
      Sl_wrDAck => plb_Sl_wrDAck(2),
      Sl_wrComp => plb_Sl_wrComp(2),
      Sl_wrBTerm => plb_Sl_wrBTerm(2),
      Sl_rdDBus => plb_Sl_rdDBus(128 to 191),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(8 to 11),
      Sl_rdDAck => plb_Sl_rdDAck(2),
      Sl_rdComp => plb_Sl_rdComp(2),
      Sl_rdBTerm => plb_Sl_rdBTerm(2),
      Sl_MBusy => plb_Sl_MBusy(4 to 5),
      Sl_MWrErr => plb_Sl_MWrErr(4 to 5),
      Sl_MRdErr => plb_Sl_MRdErr(4 to 5),
      Sl_MIRQ => plb_Sl_MIRQ(4 to 5),
      IP2INTC_Irpt => open,
      GPIO_IO_I => net_gnd5,
      GPIO_IO_O => open,
      GPIO_IO_T => open,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  Push_Buttons_Position : system_push_buttons_position_wrapper
    port map (
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(3),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(3),
      PLB_wrPrim => plb_PLB_wrPrim(3),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(3),
      Sl_SSize => plb_Sl_SSize(6 to 7),
      Sl_wait => plb_Sl_wait(3),
      Sl_rearbitrate => plb_Sl_rearbitrate(3),
      Sl_wrDAck => plb_Sl_wrDAck(3),
      Sl_wrComp => plb_Sl_wrComp(3),
      Sl_wrBTerm => plb_Sl_wrBTerm(3),
      Sl_rdDBus => plb_Sl_rdDBus(192 to 255),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(12 to 15),
      Sl_rdDAck => plb_Sl_rdDAck(3),
      Sl_rdComp => plb_Sl_rdComp(3),
      Sl_rdBTerm => plb_Sl_rdBTerm(3),
      Sl_MBusy => plb_Sl_MBusy(6 to 7),
      Sl_MWrErr => plb_Sl_MWrErr(6 to 7),
      Sl_MRdErr => plb_Sl_MRdErr(6 to 7),
      Sl_MIRQ => plb_Sl_MIRQ(6 to 7),
      IP2INTC_Irpt => open,
      GPIO_IO_I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I,
      GPIO_IO_O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O,
      GPIO_IO_T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T,
      GPIO2_IO_I => net_gnd32,
      GPIO2_IO_O => open,
      GPIO2_IO_T => open
    );

  SysACE_CompactFlash : system_sysace_compactflash_wrapper
    port map (
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(4),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(4),
      PLB_wrPrim => plb_PLB_wrPrim(4),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(4),
      Sl_SSize => plb_Sl_SSize(8 to 9),
      Sl_wait => plb_Sl_wait(4),
      Sl_rearbitrate => plb_Sl_rearbitrate(4),
      Sl_wrDAck => plb_Sl_wrDAck(4),
      Sl_wrComp => plb_Sl_wrComp(4),
      Sl_wrBTerm => plb_Sl_wrBTerm(4),
      Sl_rdDBus => plb_Sl_rdDBus(256 to 319),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(16 to 19),
      Sl_rdDAck => plb_Sl_rdDAck(4),
      Sl_rdComp => plb_Sl_rdComp(4),
      Sl_rdBTerm => plb_Sl_rdBTerm(4),
      Sl_MBusy => plb_Sl_MBusy(8 to 9),
      Sl_MWrErr => plb_Sl_MWrErr(8 to 9),
      Sl_MRdErr => plb_Sl_MRdErr(8 to 9),
      Sl_MIRQ => plb_Sl_MIRQ(8 to 9),
      SysACE_MPA => pgassign6,
      SysACE_CLK => fpga_0_SysACE_CompactFlash_SysACE_CLK_pin,
      SysACE_MPIRQ => fpga_0_SysACE_CompactFlash_SysACE_MPIRQ_pin,
      SysACE_MPD_I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I,
      SysACE_MPD_O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O,
      SysACE_MPD_T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T,
      SysACE_CEN => fpga_0_SysACE_CompactFlash_SysACE_CEN_pin,
      SysACE_OEN => fpga_0_SysACE_CompactFlash_SysACE_OEN_pin,
      SysACE_WEN => fpga_0_SysACE_CompactFlash_SysACE_WEN_pin,
      SysACE_IRQ => open
    );

  SRAM : system_sram_wrapper
    port map (
      MCH_SPLB_Clk => clk_100_0000MHzDCM0,
      RdClk => clk_100_0000MHzDCM0,
      MCH_SPLB_Rst => plb_SPLB_Rst(5),
      MCH0_Access_Control => net_gnd0,
      MCH0_Access_Data => net_gnd32,
      MCH0_Access_Write => net_gnd0,
      MCH0_Access_Full => open,
      MCH0_ReadData_Control => open,
      MCH0_ReadData_Data => open,
      MCH0_ReadData_Read => net_gnd0,
      MCH0_ReadData_Exists => open,
      MCH1_Access_Control => net_gnd0,
      MCH1_Access_Data => net_gnd32,
      MCH1_Access_Write => net_gnd0,
      MCH1_Access_Full => open,
      MCH1_ReadData_Control => open,
      MCH1_ReadData_Data => open,
      MCH1_ReadData_Read => net_gnd0,
      MCH1_ReadData_Exists => open,
      MCH2_Access_Control => net_gnd0,
      MCH2_Access_Data => net_gnd32,
      MCH2_Access_Write => net_gnd0,
      MCH2_Access_Full => open,
      MCH2_ReadData_Control => open,
      MCH2_ReadData_Data => open,
      MCH2_ReadData_Read => net_gnd0,
      MCH2_ReadData_Exists => open,
      MCH3_Access_Control => net_gnd0,
      MCH3_Access_Data => net_gnd32,
      MCH3_Access_Write => net_gnd0,
      MCH3_Access_Full => open,
      MCH3_ReadData_Control => open,
      MCH3_ReadData_Data => open,
      MCH3_ReadData_Read => net_gnd0,
      MCH3_ReadData_Exists => open,
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(5),
      PLB_wrPrim => plb_PLB_wrPrim(5),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(5),
      Sl_SSize => plb_Sl_SSize(10 to 11),
      Sl_wait => plb_Sl_wait(5),
      Sl_rearbitrate => plb_Sl_rearbitrate(5),
      Sl_wrDAck => plb_Sl_wrDAck(5),
      Sl_wrComp => plb_Sl_wrComp(5),
      Sl_wrBTerm => plb_Sl_wrBTerm(5),
      Sl_rdDBus => plb_Sl_rdDBus(320 to 383),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(20 to 23),
      Sl_rdDAck => plb_Sl_rdDAck(5),
      Sl_rdComp => plb_Sl_rdComp(5),
      Sl_rdBTerm => plb_Sl_rdBTerm(5),
      Sl_MBusy => plb_Sl_MBusy(10 to 11),
      Sl_MWrErr => plb_Sl_MWrErr(10 to 11),
      Sl_MRdErr => plb_Sl_MRdErr(10 to 11),
      Sl_MIRQ => plb_Sl_MIRQ(10 to 11),
      Mem_DQ_I => fpga_0_SRAM_Mem_DQ_pin_I,
      Mem_DQ_O => fpga_0_SRAM_Mem_DQ_pin_O,
      Mem_DQ_T => fpga_0_SRAM_Mem_DQ_pin_T,
      Mem_A => pgassign7,
      Mem_RPN => open,
      Mem_CEN => pgassign1(0 to 0),
      Mem_OEN => pgassign2(0 to 0),
      Mem_WEN => fpga_0_SRAM_Mem_WEN_pin,
      Mem_QWEN => open,
      Mem_BEN => fpga_0_SRAM_Mem_BEN_pin,
      Mem_CE => open,
      Mem_ADV_LDN => fpga_0_SRAM_Mem_ADV_LDN_pin,
      Mem_LBON => open,
      Mem_CKEN => open,
      Mem_RNW => open
    );

  xps_timer_0 : system_xps_timer_0_wrapper
    port map (
      CaptureTrig0 => net_gnd0,
      CaptureTrig1 => net_gnd0,
      GenerateOut0 => open,
      GenerateOut1 => open,
      PWM0 => open,
      Interrupt => open,
      Freeze => net_gnd0,
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(6),
      PLB_ABus => plb_PLB_ABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_wrDBus => plb_PLB_wrDBus,
      Sl_addrAck => plb_Sl_addrAck(6),
      Sl_SSize => plb_Sl_SSize(12 to 13),
      Sl_wait => plb_Sl_wait(6),
      Sl_rearbitrate => plb_Sl_rearbitrate(6),
      Sl_wrDAck => plb_Sl_wrDAck(6),
      Sl_wrComp => plb_Sl_wrComp(6),
      Sl_rdDBus => plb_Sl_rdDBus(384 to 447),
      Sl_rdDAck => plb_Sl_rdDAck(6),
      Sl_rdComp => plb_Sl_rdComp(6),
      Sl_MBusy => plb_Sl_MBusy(12 to 13),
      Sl_MWrErr => plb_Sl_MWrErr(12 to 13),
      Sl_MRdErr => plb_Sl_MRdErr(12 to 13),
      PLB_UABus => plb_PLB_UABus,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(6),
      PLB_wrPrim => plb_PLB_wrPrim(6),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_MSize => plb_PLB_MSize,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_wrBTerm => plb_Sl_wrBTerm(6),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(24 to 27),
      Sl_rdBTerm => plb_Sl_rdBTerm(6),
      Sl_MIRQ => plb_Sl_MIRQ(12 to 13)
    );

  xps_timebase_wdt_0 : system_xps_timebase_wdt_0_wrapper
    port map (
      WDT_Reset => open,
      Timebase_Interrupt => open,
      WDT_Interrupt => open,
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(7),
      PLB_ABus => plb_PLB_ABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_wrDBus => plb_PLB_wrDBus,
      Sl_addrAck => plb_Sl_addrAck(7),
      Sl_SSize => plb_Sl_SSize(14 to 15),
      Sl_wait => plb_Sl_wait(7),
      Sl_rearbitrate => plb_Sl_rearbitrate(7),
      Sl_wrDAck => plb_Sl_wrDAck(7),
      Sl_wrComp => plb_Sl_wrComp(7),
      Sl_rdDBus => plb_Sl_rdDBus(448 to 511),
      Sl_rdDAck => plb_Sl_rdDAck(7),
      Sl_rdComp => plb_Sl_rdComp(7),
      Sl_MBusy => plb_Sl_MBusy(14 to 15),
      Sl_MWrErr => plb_Sl_MWrErr(14 to 15),
      Sl_MRdErr => plb_Sl_MRdErr(14 to 15),
      PLB_UABus => plb_PLB_UABus,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(7),
      PLB_wrPrim => plb_PLB_wrPrim(7),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_MSize => plb_PLB_MSize,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_wrBTerm => plb_Sl_wrBTerm(7),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(28 to 31),
      Sl_rdBTerm => plb_Sl_rdBTerm(7),
      Sl_MIRQ => plb_Sl_MIRQ(14 to 15)
    );

  clock_generator_0 : system_clock_generator_0_wrapper
    port map (
      CLKIN => CLK_S,
      CLKOUT0 => clk_100_0000MHzDCM0,
      CLKOUT1 => open,
      CLKOUT2 => open,
      CLKOUT3 => open,
      CLKOUT4 => open,
      CLKOUT5 => open,
      CLKOUT6 => open,
      CLKOUT7 => open,
      CLKOUT8 => open,
      CLKOUT9 => open,
      CLKOUT10 => open,
      CLKOUT11 => open,
      CLKOUT12 => open,
      CLKOUT13 => open,
      CLKOUT14 => open,
      CLKOUT15 => open,
      CLKFBIN => net_gnd0,
      CLKFBOUT => open,
      PSCLK => net_gnd0,
      PSEN => net_gnd0,
      PSINCDEC => net_gnd0,
      PSDONE => open,
      RST => sys_rst_s,
      LOCKED => Dcm_all_locked
    );

  jtagppc_cntlr_inst : system_jtagppc_cntlr_inst_wrapper
    port map (
      TRSTNEG => net_vcc0,
      HALTNEG0 => net_vcc0,
      DBGC405DEBUGHALT0 => open,
      HALTNEG1 => net_vcc0,
      DBGC405DEBUGHALT1 => open,
      C405JTGTDO0 => ppc405_0_jtagppc_bus_C405JTGTDO,
      C405JTGTDOEN0 => ppc405_0_jtagppc_bus_C405JTGTDOEN,
      JTGC405TCK0 => ppc405_0_jtagppc_bus_JTGC405TCK,
      JTGC405TDI0 => ppc405_0_jtagppc_bus_JTGC405TDI,
      JTGC405TMS0 => ppc405_0_jtagppc_bus_JTGC405TMS,
      JTGC405TRSTNEG0 => ppc405_0_jtagppc_bus_JTGC405TRSTNEG,
      C405JTGTDO1 => net_gnd0,
      C405JTGTDOEN1 => net_gnd0,
      JTGC405TCK1 => open,
      JTGC405TDI1 => open,
      JTGC405TMS1 => open,
      JTGC405TRSTNEG1 => open
    );

  proc_sys_reset_0 : system_proc_sys_reset_0_wrapper
    port map (
      Slowest_sync_clk => clk_100_0000MHzDCM0,
      Ext_Reset_In => sys_rst_s,
      Aux_Reset_In => net_gnd0,
      MB_Debug_Sys_Rst => net_gnd0,
      Core_Reset_Req_0 => ppc_reset_bus_Core_Reset_Req,
      Chip_Reset_Req_0 => ppc_reset_bus_Chip_Reset_Req,
      System_Reset_Req_0 => ppc_reset_bus_System_Reset_Req,
      Core_Reset_Req_1 => net_gnd0,
      Chip_Reset_Req_1 => net_gnd0,
      System_Reset_Req_1 => net_gnd0,
      Dcm_locked => Dcm_all_locked,
      RstcPPCresetcore_0 => ppc_reset_bus_RstcPPCresetcore,
      RstcPPCresetchip_0 => ppc_reset_bus_RstsPPCresetchip,
      RstcPPCresetsys_0 => ppc_reset_bus_RstcPPCresetsys,
      RstcPPCresetcore_1 => open,
      RstcPPCresetchip_1 => open,
      RstcPPCresetsys_1 => open,
      MB_Reset => open,
      Bus_Struct_Reset => sys_bus_reset(0 to 0),
      Peripheral_Reset => open,
      Interconnect_aresetn => open,
      Peripheral_aresetn => open
    );

  mdm_0 : system_mdm_0_wrapper
    port map (
      Interrupt => open,
      Debug_SYS_Rst => open,
      Ext_BRK => open,
      Ext_NM_BRK => open,
      S_AXI_ACLK => net_gnd0,
      S_AXI_ARESETN => net_gnd0,
      S_AXI_AWADDR => net_gnd32(0 to 31),
      S_AXI_AWVALID => net_gnd0,
      S_AXI_AWREADY => open,
      S_AXI_WDATA => net_gnd32(0 to 31),
      S_AXI_WSTRB => net_gnd4(0 to 3),
      S_AXI_WVALID => net_gnd0,
      S_AXI_WREADY => open,
      S_AXI_BRESP => open,
      S_AXI_BVALID => open,
      S_AXI_BREADY => net_gnd0,
      S_AXI_ARADDR => net_gnd32(0 to 31),
      S_AXI_ARVALID => net_gnd0,
      S_AXI_ARREADY => open,
      S_AXI_RDATA => open,
      S_AXI_RRESP => open,
      S_AXI_RVALID => open,
      S_AXI_RREADY => net_gnd0,
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(8),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(8),
      PLB_wrPrim => plb_PLB_wrPrim(8),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(8),
      Sl_SSize => plb_Sl_SSize(16 to 17),
      Sl_wait => plb_Sl_wait(8),
      Sl_rearbitrate => plb_Sl_rearbitrate(8),
      Sl_wrDAck => plb_Sl_wrDAck(8),
      Sl_wrComp => plb_Sl_wrComp(8),
      Sl_wrBTerm => plb_Sl_wrBTerm(8),
      Sl_rdDBus => plb_Sl_rdDBus(512 to 575),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(32 to 35),
      Sl_rdDAck => plb_Sl_rdDAck(8),
      Sl_rdComp => plb_Sl_rdComp(8),
      Sl_rdBTerm => plb_Sl_rdBTerm(8),
      Sl_MBusy => plb_Sl_MBusy(16 to 17),
      Sl_MWrErr => plb_Sl_MWrErr(16 to 17),
      Sl_MRdErr => plb_Sl_MRdErr(16 to 17),
      Sl_MIRQ => plb_Sl_MIRQ(16 to 17),
      Dbg_Clk_0 => open,
      Dbg_TDI_0 => open,
      Dbg_TDO_0 => net_gnd0,
      Dbg_Reg_En_0 => open,
      Dbg_Capture_0 => open,
      Dbg_Shift_0 => open,
      Dbg_Update_0 => open,
      Dbg_Rst_0 => open,
      Dbg_Clk_1 => open,
      Dbg_TDI_1 => open,
      Dbg_TDO_1 => net_gnd0,
      Dbg_Reg_En_1 => open,
      Dbg_Capture_1 => open,
      Dbg_Shift_1 => open,
      Dbg_Update_1 => open,
      Dbg_Rst_1 => open,
      Dbg_Clk_2 => open,
      Dbg_TDI_2 => open,
      Dbg_TDO_2 => net_gnd0,
      Dbg_Reg_En_2 => open,
      Dbg_Capture_2 => open,
      Dbg_Shift_2 => open,
      Dbg_Update_2 => open,
      Dbg_Rst_2 => open,
      Dbg_Clk_3 => open,
      Dbg_TDI_3 => open,
      Dbg_TDO_3 => net_gnd0,
      Dbg_Reg_En_3 => open,
      Dbg_Capture_3 => open,
      Dbg_Shift_3 => open,
      Dbg_Update_3 => open,
      Dbg_Rst_3 => open,
      Dbg_Clk_4 => open,
      Dbg_TDI_4 => open,
      Dbg_TDO_4 => net_gnd0,
      Dbg_Reg_En_4 => open,
      Dbg_Capture_4 => open,
      Dbg_Shift_4 => open,
      Dbg_Update_4 => open,
      Dbg_Rst_4 => open,
      Dbg_Clk_5 => open,
      Dbg_TDI_5 => open,
      Dbg_TDO_5 => net_gnd0,
      Dbg_Reg_En_5 => open,
      Dbg_Capture_5 => open,
      Dbg_Shift_5 => open,
      Dbg_Update_5 => open,
      Dbg_Rst_5 => open,
      Dbg_Clk_6 => open,
      Dbg_TDI_6 => open,
      Dbg_TDO_6 => net_gnd0,
      Dbg_Reg_En_6 => open,
      Dbg_Capture_6 => open,
      Dbg_Shift_6 => open,
      Dbg_Update_6 => open,
      Dbg_Rst_6 => open,
      Dbg_Clk_7 => open,
      Dbg_TDI_7 => open,
      Dbg_TDO_7 => net_gnd0,
      Dbg_Reg_En_7 => open,
      Dbg_Capture_7 => open,
      Dbg_Shift_7 => open,
      Dbg_Update_7 => open,
      Dbg_Rst_7 => open,
      Dbg_Clk_8 => open,
      Dbg_TDI_8 => open,
      Dbg_TDO_8 => net_gnd0,
      Dbg_Reg_En_8 => open,
      Dbg_Capture_8 => open,
      Dbg_Shift_8 => open,
      Dbg_Update_8 => open,
      Dbg_Rst_8 => open,
      Dbg_Clk_9 => open,
      Dbg_TDI_9 => open,
      Dbg_TDO_9 => net_gnd0,
      Dbg_Reg_En_9 => open,
      Dbg_Capture_9 => open,
      Dbg_Shift_9 => open,
      Dbg_Update_9 => open,
      Dbg_Rst_9 => open,
      Dbg_Clk_10 => open,
      Dbg_TDI_10 => open,
      Dbg_TDO_10 => net_gnd0,
      Dbg_Reg_En_10 => open,
      Dbg_Capture_10 => open,
      Dbg_Shift_10 => open,
      Dbg_Update_10 => open,
      Dbg_Rst_10 => open,
      Dbg_Clk_11 => open,
      Dbg_TDI_11 => open,
      Dbg_TDO_11 => net_gnd0,
      Dbg_Reg_En_11 => open,
      Dbg_Capture_11 => open,
      Dbg_Shift_11 => open,
      Dbg_Update_11 => open,
      Dbg_Rst_11 => open,
      Dbg_Clk_12 => open,
      Dbg_TDI_12 => open,
      Dbg_TDO_12 => net_gnd0,
      Dbg_Reg_En_12 => open,
      Dbg_Capture_12 => open,
      Dbg_Shift_12 => open,
      Dbg_Update_12 => open,
      Dbg_Rst_12 => open,
      Dbg_Clk_13 => open,
      Dbg_TDI_13 => open,
      Dbg_TDO_13 => net_gnd0,
      Dbg_Reg_En_13 => open,
      Dbg_Capture_13 => open,
      Dbg_Shift_13 => open,
      Dbg_Update_13 => open,
      Dbg_Rst_13 => open,
      Dbg_Clk_14 => open,
      Dbg_TDI_14 => open,
      Dbg_TDO_14 => net_gnd0,
      Dbg_Reg_En_14 => open,
      Dbg_Capture_14 => open,
      Dbg_Shift_14 => open,
      Dbg_Update_14 => open,
      Dbg_Rst_14 => open,
      Dbg_Clk_15 => open,
      Dbg_TDI_15 => open,
      Dbg_TDO_15 => net_gnd0,
      Dbg_Reg_En_15 => open,
      Dbg_Capture_15 => open,
      Dbg_Shift_15 => open,
      Dbg_Update_15 => open,
      Dbg_Rst_15 => open,
      Dbg_Clk_16 => open,
      Dbg_TDI_16 => open,
      Dbg_TDO_16 => net_gnd0,
      Dbg_Reg_En_16 => open,
      Dbg_Capture_16 => open,
      Dbg_Shift_16 => open,
      Dbg_Update_16 => open,
      Dbg_Rst_16 => open,
      Dbg_Clk_17 => open,
      Dbg_TDI_17 => open,
      Dbg_TDO_17 => net_gnd0,
      Dbg_Reg_En_17 => open,
      Dbg_Capture_17 => open,
      Dbg_Shift_17 => open,
      Dbg_Update_17 => open,
      Dbg_Rst_17 => open,
      Dbg_Clk_18 => open,
      Dbg_TDI_18 => open,
      Dbg_TDO_18 => net_gnd0,
      Dbg_Reg_En_18 => open,
      Dbg_Capture_18 => open,
      Dbg_Shift_18 => open,
      Dbg_Update_18 => open,
      Dbg_Rst_18 => open,
      Dbg_Clk_19 => open,
      Dbg_TDI_19 => open,
      Dbg_TDO_19 => net_gnd0,
      Dbg_Reg_En_19 => open,
      Dbg_Capture_19 => open,
      Dbg_Shift_19 => open,
      Dbg_Update_19 => open,
      Dbg_Rst_19 => open,
      Dbg_Clk_20 => open,
      Dbg_TDI_20 => open,
      Dbg_TDO_20 => net_gnd0,
      Dbg_Reg_En_20 => open,
      Dbg_Capture_20 => open,
      Dbg_Shift_20 => open,
      Dbg_Update_20 => open,
      Dbg_Rst_20 => open,
      Dbg_Clk_21 => open,
      Dbg_TDI_21 => open,
      Dbg_TDO_21 => net_gnd0,
      Dbg_Reg_En_21 => open,
      Dbg_Capture_21 => open,
      Dbg_Shift_21 => open,
      Dbg_Update_21 => open,
      Dbg_Rst_21 => open,
      Dbg_Clk_22 => open,
      Dbg_TDI_22 => open,
      Dbg_TDO_22 => net_gnd0,
      Dbg_Reg_En_22 => open,
      Dbg_Capture_22 => open,
      Dbg_Shift_22 => open,
      Dbg_Update_22 => open,
      Dbg_Rst_22 => open,
      Dbg_Clk_23 => open,
      Dbg_TDI_23 => open,
      Dbg_TDO_23 => net_gnd0,
      Dbg_Reg_En_23 => open,
      Dbg_Capture_23 => open,
      Dbg_Shift_23 => open,
      Dbg_Update_23 => open,
      Dbg_Rst_23 => open,
      Dbg_Clk_24 => open,
      Dbg_TDI_24 => open,
      Dbg_TDO_24 => net_gnd0,
      Dbg_Reg_En_24 => open,
      Dbg_Capture_24 => open,
      Dbg_Shift_24 => open,
      Dbg_Update_24 => open,
      Dbg_Rst_24 => open,
      Dbg_Clk_25 => open,
      Dbg_TDI_25 => open,
      Dbg_TDO_25 => net_gnd0,
      Dbg_Reg_En_25 => open,
      Dbg_Capture_25 => open,
      Dbg_Shift_25 => open,
      Dbg_Update_25 => open,
      Dbg_Rst_25 => open,
      Dbg_Clk_26 => open,
      Dbg_TDI_26 => open,
      Dbg_TDO_26 => net_gnd0,
      Dbg_Reg_En_26 => open,
      Dbg_Capture_26 => open,
      Dbg_Shift_26 => open,
      Dbg_Update_26 => open,
      Dbg_Rst_26 => open,
      Dbg_Clk_27 => open,
      Dbg_TDI_27 => open,
      Dbg_TDO_27 => net_gnd0,
      Dbg_Reg_En_27 => open,
      Dbg_Capture_27 => open,
      Dbg_Shift_27 => open,
      Dbg_Update_27 => open,
      Dbg_Rst_27 => open,
      Dbg_Clk_28 => open,
      Dbg_TDI_28 => open,
      Dbg_TDO_28 => net_gnd0,
      Dbg_Reg_En_28 => open,
      Dbg_Capture_28 => open,
      Dbg_Shift_28 => open,
      Dbg_Update_28 => open,
      Dbg_Rst_28 => open,
      Dbg_Clk_29 => open,
      Dbg_TDI_29 => open,
      Dbg_TDO_29 => net_gnd0,
      Dbg_Reg_En_29 => open,
      Dbg_Capture_29 => open,
      Dbg_Shift_29 => open,
      Dbg_Update_29 => open,
      Dbg_Rst_29 => open,
      Dbg_Clk_30 => open,
      Dbg_TDI_30 => open,
      Dbg_TDO_30 => net_gnd0,
      Dbg_Reg_En_30 => open,
      Dbg_Capture_30 => open,
      Dbg_Shift_30 => open,
      Dbg_Update_30 => open,
      Dbg_Rst_30 => open,
      Dbg_Clk_31 => open,
      Dbg_TDI_31 => open,
      Dbg_TDO_31 => net_gnd0,
      Dbg_Reg_En_31 => open,
      Dbg_Capture_31 => open,
      Dbg_Shift_31 => open,
      Dbg_Update_31 => open,
      Dbg_Rst_31 => open,
      bscan_tdi => open,
      bscan_reset => open,
      bscan_shift => open,
      bscan_update => open,
      bscan_capture => open,
      bscan_sel1 => open,
      bscan_drck1 => open,
      bscan_tdo1 => net_gnd0,
      bscan_ext_tdi => net_gnd0,
      bscan_ext_reset => net_gnd0,
      bscan_ext_shift => net_gnd0,
      bscan_ext_update => net_gnd0,
      bscan_ext_capture => net_gnd0,
      bscan_ext_sel => net_gnd0,
      bscan_ext_drck => net_gnd0,
      bscan_ext_tdo => open,
      Ext_JTAG_DRCK => open,
      Ext_JTAG_RESET => open,
      Ext_JTAG_SEL => open,
      Ext_JTAG_CAPTURE => open,
      Ext_JTAG_SHIFT => open,
      Ext_JTAG_UPDATE => open,
      Ext_JTAG_TDI => open,
      Ext_JTAG_TDO => net_gnd0
    );

  my_newip_22_0 : system_my_newip_22_0_wrapper
    port map (
      LED => my_newip_22_0_LED,
      SPLB_Clk => clk_100_0000MHzDCM0,
      SPLB_Rst => plb_SPLB_Rst(9),
      PLB_ABus => plb_PLB_ABus,
      PLB_UABus => plb_PLB_UABus,
      PLB_PAValid => plb_PLB_PAValid,
      PLB_SAValid => plb_PLB_SAValid,
      PLB_rdPrim => plb_PLB_rdPrim(9),
      PLB_wrPrim => plb_PLB_wrPrim(9),
      PLB_masterID => plb_PLB_masterID(0 to 0),
      PLB_abort => plb_PLB_abort,
      PLB_busLock => plb_PLB_busLock,
      PLB_RNW => plb_PLB_RNW,
      PLB_BE => plb_PLB_BE,
      PLB_MSize => plb_PLB_MSize,
      PLB_size => plb_PLB_size,
      PLB_type => plb_PLB_type,
      PLB_lockErr => plb_PLB_lockErr,
      PLB_wrDBus => plb_PLB_wrDBus,
      PLB_wrBurst => plb_PLB_wrBurst,
      PLB_rdBurst => plb_PLB_rdBurst,
      PLB_wrPendReq => plb_PLB_wrPendReq,
      PLB_rdPendReq => plb_PLB_rdPendReq,
      PLB_wrPendPri => plb_PLB_wrPendPri,
      PLB_rdPendPri => plb_PLB_rdPendPri,
      PLB_reqPri => plb_PLB_reqPri,
      PLB_TAttribute => plb_PLB_TAttribute,
      Sl_addrAck => plb_Sl_addrAck(9),
      Sl_SSize => plb_Sl_SSize(18 to 19),
      Sl_wait => plb_Sl_wait(9),
      Sl_rearbitrate => plb_Sl_rearbitrate(9),
      Sl_wrDAck => plb_Sl_wrDAck(9),
      Sl_wrComp => plb_Sl_wrComp(9),
      Sl_wrBTerm => plb_Sl_wrBTerm(9),
      Sl_rdDBus => plb_Sl_rdDBus(576 to 639),
      Sl_rdWdAddr => plb_Sl_rdWdAddr(36 to 39),
      Sl_rdDAck => plb_Sl_rdDAck(9),
      Sl_rdComp => plb_Sl_rdComp(9),
      Sl_rdBTerm => plb_Sl_rdBTerm(9),
      Sl_MBusy => plb_Sl_MBusy(18 to 19),
      Sl_MWrErr => plb_Sl_MWrErr(18 to 19),
      Sl_MRdErr => plb_Sl_MRdErr(18 to 19),
      Sl_MIRQ => plb_Sl_MIRQ(18 to 19)
    );

  iobuf_0 : IOBUF
    port map (
      I => fpga_0_LEDs_4Bit_GPIO_IO_pin_O(0),
      IO => fpga_0_LEDs_4Bit_GPIO_IO_pin(0),
      O => fpga_0_LEDs_4Bit_GPIO_IO_pin_I(0),
      T => fpga_0_LEDs_4Bit_GPIO_IO_pin_T(0)
    );

  iobuf_1 : IOBUF
    port map (
      I => fpga_0_LEDs_4Bit_GPIO_IO_pin_O(1),
      IO => fpga_0_LEDs_4Bit_GPIO_IO_pin(1),
      O => fpga_0_LEDs_4Bit_GPIO_IO_pin_I(1),
      T => fpga_0_LEDs_4Bit_GPIO_IO_pin_T(1)
    );

  iobuf_2 : IOBUF
    port map (
      I => fpga_0_LEDs_4Bit_GPIO_IO_pin_O(2),
      IO => fpga_0_LEDs_4Bit_GPIO_IO_pin(2),
      O => fpga_0_LEDs_4Bit_GPIO_IO_pin_I(2),
      T => fpga_0_LEDs_4Bit_GPIO_IO_pin_T(2)
    );

  iobuf_3 : IOBUF
    port map (
      I => fpga_0_LEDs_4Bit_GPIO_IO_pin_O(3),
      IO => fpga_0_LEDs_4Bit_GPIO_IO_pin(3),
      O => fpga_0_LEDs_4Bit_GPIO_IO_pin_I(3),
      T => fpga_0_LEDs_4Bit_GPIO_IO_pin_T(3)
    );

  iobuf_4 : IOBUF
    port map (
      I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O(0),
      IO => fpga_0_Push_Buttons_Position_GPIO_IO_pin(0),
      O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I(0),
      T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T(0)
    );

  iobuf_5 : IOBUF
    port map (
      I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O(1),
      IO => fpga_0_Push_Buttons_Position_GPIO_IO_pin(1),
      O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I(1),
      T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T(1)
    );

  iobuf_6 : IOBUF
    port map (
      I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O(2),
      IO => fpga_0_Push_Buttons_Position_GPIO_IO_pin(2),
      O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I(2),
      T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T(2)
    );

  iobuf_7 : IOBUF
    port map (
      I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O(3),
      IO => fpga_0_Push_Buttons_Position_GPIO_IO_pin(3),
      O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I(3),
      T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T(3)
    );

  iobuf_8 : IOBUF
    port map (
      I => fpga_0_Push_Buttons_Position_GPIO_IO_pin_O(4),
      IO => fpga_0_Push_Buttons_Position_GPIO_IO_pin(4),
      O => fpga_0_Push_Buttons_Position_GPIO_IO_pin_I(4),
      T => fpga_0_Push_Buttons_Position_GPIO_IO_pin_T(4)
    );

  iobuf_9 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(15),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(15),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(15),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(15)
    );

  iobuf_10 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(14),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(14),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(14),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(14)
    );

  iobuf_11 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(13),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(13),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(13),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(13)
    );

  iobuf_12 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(12),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(12),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(12),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(12)
    );

  iobuf_13 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(11),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(11),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(11),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(11)
    );

  iobuf_14 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(10),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(10),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(10),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(10)
    );

  iobuf_15 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(9),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(9),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(9),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(9)
    );

  iobuf_16 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(8),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(8),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(8),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(8)
    );

  iobuf_17 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(7),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(7),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(7),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(7)
    );

  iobuf_18 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(6),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(6),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(6),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(6)
    );

  iobuf_19 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(5),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(5),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(5),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(5)
    );

  iobuf_20 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(4),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(4),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(4),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(4)
    );

  iobuf_21 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(3),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(3),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(3),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(3)
    );

  iobuf_22 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(2),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(2),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(2),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(2)
    );

  iobuf_23 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(1),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(1),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(1),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(1)
    );

  iobuf_24 : IOBUF
    port map (
      I => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_O(0),
      IO => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin(0),
      O => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_I(0),
      T => fpga_0_SysACE_CompactFlash_SysACE_MPD_pin_T(0)
    );

  iobuf_25 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(0),
      IO => fpga_0_SRAM_Mem_DQ_pin(0),
      O => fpga_0_SRAM_Mem_DQ_pin_I(0),
      T => fpga_0_SRAM_Mem_DQ_pin_T(0)
    );

  iobuf_26 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(1),
      IO => fpga_0_SRAM_Mem_DQ_pin(1),
      O => fpga_0_SRAM_Mem_DQ_pin_I(1),
      T => fpga_0_SRAM_Mem_DQ_pin_T(1)
    );

  iobuf_27 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(2),
      IO => fpga_0_SRAM_Mem_DQ_pin(2),
      O => fpga_0_SRAM_Mem_DQ_pin_I(2),
      T => fpga_0_SRAM_Mem_DQ_pin_T(2)
    );

  iobuf_28 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(3),
      IO => fpga_0_SRAM_Mem_DQ_pin(3),
      O => fpga_0_SRAM_Mem_DQ_pin_I(3),
      T => fpga_0_SRAM_Mem_DQ_pin_T(3)
    );

  iobuf_29 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(4),
      IO => fpga_0_SRAM_Mem_DQ_pin(4),
      O => fpga_0_SRAM_Mem_DQ_pin_I(4),
      T => fpga_0_SRAM_Mem_DQ_pin_T(4)
    );

  iobuf_30 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(5),
      IO => fpga_0_SRAM_Mem_DQ_pin(5),
      O => fpga_0_SRAM_Mem_DQ_pin_I(5),
      T => fpga_0_SRAM_Mem_DQ_pin_T(5)
    );

  iobuf_31 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(6),
      IO => fpga_0_SRAM_Mem_DQ_pin(6),
      O => fpga_0_SRAM_Mem_DQ_pin_I(6),
      T => fpga_0_SRAM_Mem_DQ_pin_T(6)
    );

  iobuf_32 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(7),
      IO => fpga_0_SRAM_Mem_DQ_pin(7),
      O => fpga_0_SRAM_Mem_DQ_pin_I(7),
      T => fpga_0_SRAM_Mem_DQ_pin_T(7)
    );

  iobuf_33 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(8),
      IO => fpga_0_SRAM_Mem_DQ_pin(8),
      O => fpga_0_SRAM_Mem_DQ_pin_I(8),
      T => fpga_0_SRAM_Mem_DQ_pin_T(8)
    );

  iobuf_34 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(9),
      IO => fpga_0_SRAM_Mem_DQ_pin(9),
      O => fpga_0_SRAM_Mem_DQ_pin_I(9),
      T => fpga_0_SRAM_Mem_DQ_pin_T(9)
    );

  iobuf_35 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(10),
      IO => fpga_0_SRAM_Mem_DQ_pin(10),
      O => fpga_0_SRAM_Mem_DQ_pin_I(10),
      T => fpga_0_SRAM_Mem_DQ_pin_T(10)
    );

  iobuf_36 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(11),
      IO => fpga_0_SRAM_Mem_DQ_pin(11),
      O => fpga_0_SRAM_Mem_DQ_pin_I(11),
      T => fpga_0_SRAM_Mem_DQ_pin_T(11)
    );

  iobuf_37 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(12),
      IO => fpga_0_SRAM_Mem_DQ_pin(12),
      O => fpga_0_SRAM_Mem_DQ_pin_I(12),
      T => fpga_0_SRAM_Mem_DQ_pin_T(12)
    );

  iobuf_38 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(13),
      IO => fpga_0_SRAM_Mem_DQ_pin(13),
      O => fpga_0_SRAM_Mem_DQ_pin_I(13),
      T => fpga_0_SRAM_Mem_DQ_pin_T(13)
    );

  iobuf_39 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(14),
      IO => fpga_0_SRAM_Mem_DQ_pin(14),
      O => fpga_0_SRAM_Mem_DQ_pin_I(14),
      T => fpga_0_SRAM_Mem_DQ_pin_T(14)
    );

  iobuf_40 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(15),
      IO => fpga_0_SRAM_Mem_DQ_pin(15),
      O => fpga_0_SRAM_Mem_DQ_pin_I(15),
      T => fpga_0_SRAM_Mem_DQ_pin_T(15)
    );

  iobuf_41 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(16),
      IO => fpga_0_SRAM_Mem_DQ_pin(16),
      O => fpga_0_SRAM_Mem_DQ_pin_I(16),
      T => fpga_0_SRAM_Mem_DQ_pin_T(16)
    );

  iobuf_42 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(17),
      IO => fpga_0_SRAM_Mem_DQ_pin(17),
      O => fpga_0_SRAM_Mem_DQ_pin_I(17),
      T => fpga_0_SRAM_Mem_DQ_pin_T(17)
    );

  iobuf_43 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(18),
      IO => fpga_0_SRAM_Mem_DQ_pin(18),
      O => fpga_0_SRAM_Mem_DQ_pin_I(18),
      T => fpga_0_SRAM_Mem_DQ_pin_T(18)
    );

  iobuf_44 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(19),
      IO => fpga_0_SRAM_Mem_DQ_pin(19),
      O => fpga_0_SRAM_Mem_DQ_pin_I(19),
      T => fpga_0_SRAM_Mem_DQ_pin_T(19)
    );

  iobuf_45 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(20),
      IO => fpga_0_SRAM_Mem_DQ_pin(20),
      O => fpga_0_SRAM_Mem_DQ_pin_I(20),
      T => fpga_0_SRAM_Mem_DQ_pin_T(20)
    );

  iobuf_46 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(21),
      IO => fpga_0_SRAM_Mem_DQ_pin(21),
      O => fpga_0_SRAM_Mem_DQ_pin_I(21),
      T => fpga_0_SRAM_Mem_DQ_pin_T(21)
    );

  iobuf_47 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(22),
      IO => fpga_0_SRAM_Mem_DQ_pin(22),
      O => fpga_0_SRAM_Mem_DQ_pin_I(22),
      T => fpga_0_SRAM_Mem_DQ_pin_T(22)
    );

  iobuf_48 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(23),
      IO => fpga_0_SRAM_Mem_DQ_pin(23),
      O => fpga_0_SRAM_Mem_DQ_pin_I(23),
      T => fpga_0_SRAM_Mem_DQ_pin_T(23)
    );

  iobuf_49 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(24),
      IO => fpga_0_SRAM_Mem_DQ_pin(24),
      O => fpga_0_SRAM_Mem_DQ_pin_I(24),
      T => fpga_0_SRAM_Mem_DQ_pin_T(24)
    );

  iobuf_50 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(25),
      IO => fpga_0_SRAM_Mem_DQ_pin(25),
      O => fpga_0_SRAM_Mem_DQ_pin_I(25),
      T => fpga_0_SRAM_Mem_DQ_pin_T(25)
    );

  iobuf_51 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(26),
      IO => fpga_0_SRAM_Mem_DQ_pin(26),
      O => fpga_0_SRAM_Mem_DQ_pin_I(26),
      T => fpga_0_SRAM_Mem_DQ_pin_T(26)
    );

  iobuf_52 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(27),
      IO => fpga_0_SRAM_Mem_DQ_pin(27),
      O => fpga_0_SRAM_Mem_DQ_pin_I(27),
      T => fpga_0_SRAM_Mem_DQ_pin_T(27)
    );

  iobuf_53 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(28),
      IO => fpga_0_SRAM_Mem_DQ_pin(28),
      O => fpga_0_SRAM_Mem_DQ_pin_I(28),
      T => fpga_0_SRAM_Mem_DQ_pin_T(28)
    );

  iobuf_54 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(29),
      IO => fpga_0_SRAM_Mem_DQ_pin(29),
      O => fpga_0_SRAM_Mem_DQ_pin_I(29),
      T => fpga_0_SRAM_Mem_DQ_pin_T(29)
    );

  iobuf_55 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(30),
      IO => fpga_0_SRAM_Mem_DQ_pin(30),
      O => fpga_0_SRAM_Mem_DQ_pin_I(30),
      T => fpga_0_SRAM_Mem_DQ_pin_T(30)
    );

  iobuf_56 : IOBUF
    port map (
      I => fpga_0_SRAM_Mem_DQ_pin_O(31),
      IO => fpga_0_SRAM_Mem_DQ_pin(31),
      O => fpga_0_SRAM_Mem_DQ_pin_I(31),
      T => fpga_0_SRAM_Mem_DQ_pin_T(31)
    );

end architecture STRUCTURE;

