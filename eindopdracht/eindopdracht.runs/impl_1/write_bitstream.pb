
l
Command: %s
53*	vivadotcl2;
'write_bitstream -force top.bit -verbose2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px? 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
?Missing CFGBVS and CONFIG_VOLTAGE Design Properties: Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.%s*DRC2(
 DRC|Pin Planning2default:default8ZCFGBVS-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2P
 ":
my_vga/flat_addr1	my_vga/flat_addr12default:default2default:default2Z
 "D
my_vga/flat_addr1/A[29:0]my_vga/flat_addr1/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2P
 ":
my_vga/noot_addr1	my_vga/noot_addr12default:default2default:default2Z
 "D
my_vga/noot_addr1/A[29:0]my_vga/noot_addr1/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
my_vga/notenbalk_addr_reg	my_vga/notenbalk_addr_reg2default:default2default:default2j
 "T
!my_vga/notenbalk_addr_reg/A[29:0]my_vga/notenbalk_addr_reg/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2`
 "J
my_vga/notenbalk_addr_reg	my_vga/notenbalk_addr_reg2default:default2default:default2j
 "T
!my_vga/notenbalk_addr_reg/C[47:0]my_vga/notenbalk_addr_reg/C2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2R
 "<
my_vga/sharp_addr1	my_vga/sharp_addr12default:default2default:default2\
 "F
my_vga/sharp_addr1/A[29:0]my_vga/sharp_addr1/A2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPIP-1h px? 
?
?MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2`
 "J
my_vga/notenbalk_addr_reg	my_vga/notenbalk_addr_reg2default:default2default:default2j
 "T
!my_vga/notenbalk_addr_reg/P[47:0]my_vga/notenbalk_addr_reg/P2default:default2default:default2=
 %DRC|Netlist|Instance|Pipeline|DSP48E12default:default8ZDPOP-2h px? 
f
DRC finished with %s
1905*	planAhead2(
0 Errors, 7 Warnings2default:defaultZ12-3199h px? 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px? 
i
)Running write_bitstream with %s threads.
1750*designutils2
22default:defaultZ20-2272h px? 
?
Loading data files...
1271*designutilsZ12-1165h px? 
>
Loading site data...
1273*designutilsZ12-1167h px? 
?
Loading route data...
1272*designutilsZ12-1166h px? 
?
Processing options...
1362*designutilsZ12-1514h px? 
9
$Summary of write_bitstream Options:
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| Option Name             | Current Setting         |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| GTS_CYCLE               | 5*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| SELECTMAPABORT          | ENABLE*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| ENCRYPT                 | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DEBUGBITSTREAM          | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| COMPRESS                | FALSE*                  |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| PERFRAMECRC             | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| CRC                     | ENABLE*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| XADCENHANCEDLINEARITY   | OFF*                    |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| XADCPOWERDOWN           | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| JTAG_XADC               | ENABLE*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DISABLE_JTAG            | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| BPI_SYNC_MODE           | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| MATCH_CYCLE             | NoWait                  |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| GWE_CYCLE               | 6*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| ENCRYPTKEYSELECT        | BBRAM*                  |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DONE_CYCLE              | 4*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| KEY0                    | (Not Enabled)*          |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| STARTCBC                | (Not Enabled)*          |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| HKEY                    | (Not Enabled)*          |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| USERID                  | 0XFFFFFFFF*             |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| KEYFILE                 | (Not Enabled)*          |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| SECURITY                | NONE*                   |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| ACTIVERECONFIG          | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DONEPIPE                | YES*                    |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| ICAP_SELECT             | AUTO*                   |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| XADCPARTIALRECONFIG     | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| STARTUPCLK              | CCLK*                   |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| LCK_CYCLE               | NOWAIT*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DCIUPDATEMODE           | ASREQUIRED*             |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| PERSIST                 | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| OVERTEMPPOWERDOWN       | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| M0PIN                   | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| M1PIN                   | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| M2PIN                   | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| PROGPIN                 | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| INITPIN                 | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TCKPIN                  | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TDIPIN                  | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TDOPIN                  | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TMSPIN                  | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| UNUSEDPIN               | PULLDOWN*               |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| CCLKPIN                 | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| DONEPIN                 | PULLUP*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| CONFIGRATE              | 3*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| CONFIGFALLBACK          | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| REVISIONSELECT          | 00*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| BPI_PAGE_SIZE           | 1*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| BPI_1ST_READ_CYCLE      | 1*                      |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| NEXT_CONFIG_ADDR        | 0X00000000*             |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| NEXT_CONFIG_REBOOT      | ENABLE*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| INITSIGNALSERROR        | ENABLE*                 |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| EXTMASTERCCLK_EN        | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| SPI_32BIT_ADDR          | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| SPI_BUSWIDTH            | NONE*                   |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| SPI_FALL_EDGE           | NO*                     |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| REVISIONSELECT_TRISTATE | DISABLE*                |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TIMER_CFG               | 0X00000000*             |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| TIMER_USR               | 0X00000000*             |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| USR_ACCESS              | (Not Enabled)*          |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
K
6| CCLK_TRISTATE           | FALSE*                  |
*commonh px? 
K
6+-------------------------+-------------------------+
*commonh px? 
*
 *  Default setting.
*commonh px? 
L
7 ** The specified setting matches the default setting.
*commonh px? 
<
Creating bitmap...
1249*designutilsZ12-1141h px? 
7
Creating bitstream...
7*	bitstreamZ40-7h px? 
Z
Writing bitstream %s...
11*	bitstream2
	./top.bit2default:defaultZ40-11h px? 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px? 
?
?WebTalk data collection is mandatory when using a WebPACK part without a full Vivado license. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.
120*projectZ1-120h px? 
?
?'%s' has been successfully sent to Xilinx on %s. For additional details about this file, please refer to the Webtalk help file at %s.
186*common2l
XC:/Development/PROGH2/eindopdracht/eindopdracht.runs/impl_1/usage_statistics_webtalk.xml2default:default2,
Tue Mar 22 14:28:44 20222default:default2I
5C:/Xilinx/Vivado/2019.1/doc/webtalk_introduction.html2default:defaultZ17-186h px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1442default:default2
432default:default2
12default:default2
02default:defaultZ4-41h px? 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
write_bitstream: 2default:default2
00:00:222default:default2
00:00:202default:default2
2160.1882default:default2
395.3482default:defaultZ17-268h px? 


End Record