/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */


#include "xmk.h"
#include "sys/init.h"
#include "platform.h"

#include <stdio.h>
#include <stdio.h>
#include <string.h>
#include "platform.h"
#include "xparameters.h"
#include "xbasic_types.h"
#include "xstatus.h"
#include "xgpio.h"
#include <sysace_stdio.h>
#include "xsysace_l.h"
#include "my_newip_22.h"
#include "source.h"
#include <sys/timer.h>

#include "xtmrctr.h"


void LED_Flashing_NonStop4(XGpio LED_Device);
void LED_Flashing_NonStop3(XGpio LED_Device);
void LED_Flashing_NonStop2(XGpio LED_Device);
void LED_Flashing_NonStop1(XGpio LED_Device);
void LED_Flashing_NonStop1234(XGpio LED_Device);
//void *System_Ace_Check_Function(void *arg);
void System_Ace_Check_Function();
void Time_to_Bit_String(time_t x);
void Decimal_to_Bit_String(unsigned int x);
void Integer_to_Bit_String(unsigned int x);

Xuint32 *baseaddr_p = (Xuint32 *)XPAR_MY_NEWIP_22_0_BASEADDR;
unsigned char Bits[33];
unsigned char TimeBits[33];


void *PPC_Function(void *arg)
//void PPC_Function()
{
	unsigned char StartTime[] = "Start Time. \n";
	unsigned char ReactonPattern[] = "Reaction Pattern \n";
	unsigned char EndTime[] = "End Time \n";
	unsigned char EndChemicals[] = "Final Chemical Count \n";
	unsigned char OverFlow[] = "OverFlow \n";
	unsigned char EndSuccess[] = "Successfully Ended \n";
	unsigned char WrongCase[] = "Wrong Case \n";
	unsigned char TimeString[20];
	time_t Start, End;
	Xuint32 baseaddr = 0;				// IP Address
	Xuint32 FPGA_Command = 0;			// FPGA Output Value for switch
	Xuint32 DataPPC = 0;				// PPC Output to FPGA
	Xuint32 DataFPGA = 0;				// FPGA output to PPC
	Xuint32 ChemicalDataInput[18];		// Chemical Values from file in SysAce
	Xuint32 ADDRESS = 0;				// BRAM Address Variable
	Xuint32 Temp_ADDRESS = 0;			// BRAM Address Variable
	char	Final_Address_Flag = 0;		// Flag to save final address of the reaction data
	char Ended = 0;
	Xuint32 IP_State = 0;				// IP State of Operation

	int debug = 0;						// Debugging code

	XGpio gpLED;						// Init LED
	XGpio gpPB;							// Init Button

	Xuint32 Button_Input = 0;			// Button Variable


	//Loop of input from File
	char templine[200];

	SYSACE_FILE *fp_input;				// Input File
	SYSACE_FILE *fp_output;				// Output File

	//XASSERT_NONVOID(baseaddr_p != XNULL);								// Existence of IP
	baseaddr = (Xuint32)baseaddr_p;										// IP Address

	// Initialise the peripherals
	XGpio_Initialize(&gpLED, XPAR_LEDS_4BIT_DEVICE_ID);
	XGpio_Initialize(&gpPB, XPAR_PUSH_BUTTONS_POSITION_DEVICE_ID);

	// Set the LED peripheral to outputs
	XGpio_SetDataDirection(&gpLED, 1, 0x00000000);

	// Set the Push Button peripheral to inputs
	XGpio_SetDataDirection(&gpPB, 1, 0x0000001F);
/*
	//Wait for Button Press (Center Button)
	while(Button_Input != 16)
	{
		// Read the state of the push buttons
		Button_Input = XGpio_DiscreteRead(&gpPB, 1);
	}
	time(&Start);
	Time_to_Bit_String(Start);
*/
	while(Button_Input != 16)
	{
		// Read the state of the push buttons
		Button_Input = XGpio_DiscreteRead(&gpPB, 1);
	}
	//inputing checmicals
	fp_input = sysace_fopen("input1.txt", "r" );
	if(fp_input == NULL)
	{
		LED_Flashing_NonStop4(gpLED);		// In case of Error while reading input file
	}
	memset(templine, '\0', sizeof(templine));
	sysace_fread(templine, 1, 200,fp_input);
	sscanf(templine, "%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu ",
			(Xuint32 *)&ChemicalDataInput[0], (Xuint32 *)&ChemicalDataInput[1], (Xuint32 *)&ChemicalDataInput[2],
			(Xuint32 *)&ChemicalDataInput[3], (Xuint32 *)&ChemicalDataInput[4], (Xuint32 *)&ChemicalDataInput[5],
			(Xuint32 *)&ChemicalDataInput[6], (Xuint32 *)&ChemicalDataInput[7], (Xuint32 *)&ChemicalDataInput[8],
			(Xuint32 *)&ChemicalDataInput[9], (Xuint32 *)&ChemicalDataInput[10], (Xuint32 *)&ChemicalDataInput[11],
			(Xuint32 *)&ChemicalDataInput[12], (Xuint32 *)&ChemicalDataInput[13], (Xuint32 *)&ChemicalDataInput[14],
			(Xuint32 *)&ChemicalDataInput[15], (Xuint32 *)&ChemicalDataInput[16], (Xuint32 *)&ChemicalDataInput[17]);

	fclose(fp_input);

	XGpio_DiscreteWrite(&gpLED, 1, 0x5);	//LED 0101
	//output file
	fp_output = sysace_fopen("output10.txt", "w" );
	if(fp_output == NULL)
	{
		LED_Flashing_NonStop4(gpLED);		// In case of Error while reading output file
	}

	//XASSERT_NONVOID(baseaddr_p != XNULL);			// Existence of IP
	MY_NEWIP_22_mReset(baseaddr);					// Reset IP


	// Time Starting of process
	time(&Start);
	//Time_to_Bit_String(Start);
	sysace_fwrite(StartTime, 1, sizeof(StartTime), fp_output);
	//sysace_fwrite(TimeBits, 1, sizeof(TimeBits), fp_output);
	memset(TimeString, '0', sizeof(TimeString));
	sprintf(TimeString, "%d \n", Start);
	sysace_fwrite(TimeString, 1, sizeof(TimeString), fp_output);

	while(1)
	{
		DataFPGA = 0;
		FPGA_Command = 0;
		DataPPC = 0;
		DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);

		FPGA_Command = (DataFPGA & 0xF8000000); 		//AND	11111000000000000000000000000000
		if(IP_State == 0 && FPGA_Command != 0)
		{
			switch(FPGA_Command)
			{
				case glucose_FPGA:
						XGpio_DiscreteWrite(&gpLED, 1, 0x1);	//LED 1000
						DataPPC = 0;
						DataPPC = (glucose_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[0];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case ATP_FPGA:
						DataPPC = 0;
						DataPPC = (ATP_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[1];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case glucose_6_phosphate_FPGA:
						DataPPC = 0;
						DataPPC = (glucose_6_phosphate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[2];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case ADP_FPGA:
						DataPPC = 0;
						DataPPC = (ADP_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[3];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case fructose_6_phosphate_FPGA:
						DataPPC = 0;
						DataPPC = (fructose_6_phosphate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[4];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case fructose_1_6_bisphosphate_FPGA:
						DataPPC = 0;
						DataPPC = (fructose_1_6_bisphosphate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[5];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case dihydroxyacetone_phosphate_FPGA:
						DataPPC = 0;
						DataPPC = (dihydroxyacetone_phosphate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[6];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case glyceraldehyde_3_phosphate_FPGA:
						DataPPC = 0;
						DataPPC = (glyceraldehyde_3_phosphate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[7];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case bisphosphoglycerate_1_3_FPGA:
						DataPPC = 0;
						DataPPC = (bisphosphoglycerate_1_3_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[8];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case phosphoglycerate_3_FPGA:
						DataPPC = 0;
						DataPPC = (phosphoglycerate_3_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[9];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case phosphoglycerate_2_FPGA:
						DataPPC = 0;
						DataPPC = (phosphoglycerate_2_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[10];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case phosphoenolpyruvate_FPGA:
						DataPPC = 0;
						DataPPC = (phosphoenolpyruvate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[11];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case pyruvate_FPGA:
						DataPPC = 0;
						DataPPC = (pyruvate_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[12];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case Pi_FPGA:
						DataPPC = 0;
						DataPPC = (Pi_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[13];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case H2O_FPGA:
						DataPPC = 0;
						DataPPC = (H2O_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[14];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case NAD_FPGA:
						DataPPC = 0;
						DataPPC = (NAD_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[15];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case NADH_FPGA:
						DataPPC = 0;
						DataPPC = (NADH_PPC & Signal_Bits);
						DataPPC |= ChemicalDataInput[16];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case H_FPGA:
						DataPPC = 0;
						DataPPC = (H_PPC & Signal_Bits);
						XGpio_DiscreteWrite(&gpLED, 1, 0x2);	//LED 0100
						DataPPC |= ChemicalDataInput[17];
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						sysace_fwrite(ReactonPattern, 1, sizeof(ReactonPattern), fp_output);
						IP_State = 1;						// Move to next State
					break;

				default:
					sysace_fwrite(WrongCase, 1, sizeof(WrongCase), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop1(gpLED);
					break;

			}
		}
		else if(IP_State == 1 && FPGA_Command != 0)
		{
			switch(FPGA_Command)
			{
				case BRAM_FULL_FPGA:
						// PPC to IP
						XGpio_DiscreteWrite(&gpLED, 1, 0x3);	//LED 1100
						DataPPC = 0;
						DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
						ADDRESS = 0;
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					break;

				case BRAMvalue0_FPGA:
					if(ADDRESS == 0x3ff)
					{
						//XGpio_DiscreteWrite(&gpLED, 1, 0x7);	//LED
						// IP to PPC
						//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
						DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
						Decimal_to_Bit_String(DataFPGA);
						sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

						// PPC to IP
						DataPPC = 0;
						DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						ADDRESS = 0;
					}
					else
					{
						// IP to PPC
						//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
						DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
						Decimal_to_Bit_String(DataFPGA);
						sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

						//PPC to IP
						ADDRESS++;
						DataPPC = 0;
						DataPPC = (Read_BRAM1_PPC & Signal_Bits);	// 11111000000000000000000000000000
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					}
					break;

				case BRAMvalue1_FPGA:
					if(ADDRESS == 0x3ff)
					{
						//XGpio_DiscreteWrite(&gpLED, 1, 0x7);	//LED 
						// IP to PPC
						//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
						DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
						Decimal_to_Bit_String(DataFPGA);
						sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

						// PPC to IP
						DataPPC = 0;
						DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						ADDRESS = 0;
					}
					else
					{
						// IP to PPC
						//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
						DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
						Decimal_to_Bit_String(DataFPGA);
						sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

						//PPC to IP
						ADDRESS++;
						DataPPC = 0;
						DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
					}
					break;

				case BRAM_FULL_FPGA_1:
					IP_State = 2;
					break;

				case BRAM_FULL_FPGA_2:
					IP_State = 3;
					break;
					
				case OverFlowError_FPGA:
					sysace_fwrite(OverFlow, 1, sizeof(OverFlow), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop2(gpLED);
					break;

				default:
					sysace_fwrite(WrongCase, 1, sizeof(WrongCase), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop2(gpLED);
					break;
			}
		}
		else if(IP_State == 2 && FPGA_Command != 0)
		{
			switch(FPGA_Command)
			{
				case BRAM_FULL_FPGA_1:
						// PPC to IP
						XGpio_DiscreteWrite(&gpLED, 1, 0x7);	//LED 1110
						DataPPC = 0;
						DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
						ADDRESS = 0x3ff;
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						Final_Address_Flag = 0;
					break;

				case BRAMvalue0_FPGA:
					if(Final_Address_Flag == 0)
					{
						// IP to PPC
						//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
						DataFPGA = (DataFPGA & 0x3ff);				// remove signal	00000 000000000000000001111111111
						Temp_ADDRESS = DataFPGA;
						Decimal_to_Bit_String(DataFPGA);
						sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

						// PPC to IP
						DataPPC = 0;
						DataPPC = (Read_BRAM1_PPC & Signal_Bits);	// 11111000000000000000000000000000
						ADDRESS = 0;
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						Final_Address_Flag = 1;
					}
					else
					{
						if(ADDRESS == Temp_ADDRESS)
						{
							//XGpio_DiscreteWrite(&gpLED, 1, 0xf);	//LED 
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Decimal_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							// PPC to IP
							DataPPC = 0;
							DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
							ADDRESS = 0;
						}
						else
						{
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Decimal_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							//PPC to IP
							ADDRESS++;
							DataPPC = 0;
							DataPPC = (Read_BRAM1_PPC & Signal_Bits);	// 11111000000000000000000000000000
							DataPPC = (DataPPC | ADDRESS);
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						}
					}
					break;

				case BRAMvalue1_FPGA:
					if(ADDRESS == Temp_ADDRESS)
						{
							//XGpio_DiscreteWrite(&gpLED, 1, 0xf);	//LED 
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Decimal_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							// PPC to IP
							DataPPC = 0;
							DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
							ADDRESS = 0;
						}
						else
						{
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Decimal_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							//PPC to IP
							ADDRESS++;
							DataPPC = 0;
							DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
							DataPPC = (DataPPC | ADDRESS);
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						}
					break;

				case BRAM_FULL_FPGA_2:
					IP_State = 3;
					break;

				case OverFlowError_FPGA:
					sysace_fwrite(OverFlow, 1, sizeof(OverFlow), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop3(gpLED);
					break;
					
				default:
					sysace_fwrite(WrongCase, 1, sizeof(WrongCase), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop3(gpLED);
					break;
			}
		}
		else if(IP_State == 3 && FPGA_Command != 0)
		{
			switch(FPGA_Command)
			{
				case BRAM_FULL_FPGA_2:
						// PPC to IP
						XGpio_DiscreteWrite(&gpLED, 1, 0x01);	//LED 1000
						DataPPC = 0;
						DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
						ADDRESS = 0;
						DataPPC = (DataPPC | ADDRESS);
						MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						sysace_fwrite(EndChemicals, 1, sizeof(EndChemicals), fp_output);
					break;

				case BRAMvalue0_FPGA:
					if(ADDRESS == 0x12)
						{
							//XGpio_DiscreteWrite(&gpLED, 1, 0xf);	//LED 
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Integer_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							// PPC to IP
							DataPPC = 0;
							DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
							ADDRESS = 0;
						}
						else
						{
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Integer_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							//PPC to IP
							ADDRESS++;
							DataPPC = 0;
							DataPPC = (Read_BRAM1_PPC & Signal_Bits);	// 11111000000000000000000000000000
							DataPPC = (DataPPC | ADDRESS);
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						}
					break;

				case BRAMvalue1_FPGA:
					if(ADDRESS == 0x12)
						{
							//XGpio_DiscreteWrite(&gpLED, 1, 0xf);	//LED 
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Integer_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							// PPC to IP
							DataPPC = 0;
							DataPPC = (BRAM_FREE_PPC & Signal_Bits);	// 11111000000000000000000000000000
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
							ADDRESS = 0;
						}
						else
						{
							// IP to PPC
							//DataFPGA = MY_NEWIP_22_mReadSlaveReg0(baseaddr, 0);
							DataFPGA = (DataFPGA & 0x7FFFFFF);				// remove signal
							Integer_to_Bit_String(DataFPGA);
							sysace_fwrite(Bits, 1, sizeof(Bits), fp_output);

							//PPC to IP
							ADDRESS++;
							DataPPC = 0;
							DataPPC = (Read_BRAM0_PPC & Signal_Bits);	// 11111000000000000000000000000000
							DataPPC = (DataPPC | ADDRESS);
							MY_NEWIP_22_mWriteSlaveReg1(baseaddr, 0, DataPPC);
						}
					break;

				case END_PROCESS:
					XGpio_DiscreteWrite(&gpLED, 1, 0xf);	//LED 1111
					time(&End);
					sysace_fwrite(EndTime, 1, sizeof(EndTime), fp_output);
					//Time_to_Bit_String(End);
					//sysace_fwrite(TimeBits, 1, sizeof(TimeBits), fp_output);
					memset(TimeString, '0', sizeof(TimeString));
					sprintf(TimeString, "%d \n", End);
					sysace_fwrite(TimeString, 1, sizeof(TimeString), fp_output);
					sysace_fwrite(EndSuccess, 1, sizeof(EndSuccess), fp_output);
					sysace_fclose(fp_output);
					Ended = 1;
					break;

				case OverFlowError_FPGA:
					sysace_fwrite(OverFlow, 1, sizeof(OverFlow), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop4(gpLED);
					break;

				default:
					sysace_fwrite(WrongCase, 1, sizeof(WrongCase), fp_output);
					sysace_fclose(fp_output);
					LED_Flashing_NonStop4(gpLED);
					break;
			}
		}
		if(Ended == 1)
			break;
	}
	LED_Flashing_NonStop1234(gpLED);
	return ;
}

int main()
{

    init_platform();


    xilkernel_init();

    xmk_add_static_thread(PPC_Function, 0);
    //xmk_add_static_thread(System_Ace_Check_Function, 0);


    xilkernel_start();


    cleanup_platform();


	//System_Ace_Check_Function();
    /*
	XTmrCtr* Timer1;
	int something;
	if(XST_SUCCESS == XTmrCtr_Initialize(Timer1, XPAR_XPS_TIMER_0_DEVICE_ID))
	{
		XTmrCtr_Start(Timer1, 0);

		while(1)
		{
			something = XTmrCtr_GetValue(Timer1, 0);
		}
	}
	*/
	//PPC_Function();
    return 0;
}

void LED_Flashing_NonStop4(XGpio LED_Device)
{
	Xuint32 counter = 0;
	Xuint32 LED_Val = 0;

	while(1)		// All LEDs FLASH (Error Signal)
	{
		if(counter == (100000000/300)){
			// Set the LED state
			XGpio_DiscreteWrite(&LED_Device, 1, LED_Val);
			if(LED_Val == 0x0000000f)
			{
				LED_Val = 0;
			}else if(LED_Val == 0x00000000)
			{
				LED_Val = 0x0000000f;
			}
			else{
				LED_Val = 0;
			}
			counter = 0;
		}
		counter++;
	}
}

void LED_Flashing_NonStop1234(XGpio LED_Device)
{
	Xuint32 counter = 0;
	Xuint32 LED_Val = 0;

	while(1)		// All LEDs FLASH (Error Signal)
	{
		if(counter == (100000000/300)){
			// Set the LED state
			switch(LED_Val)
			{
				case 0x1:
					LED_Val = 0x3;
					break;

				case 0x3:
					LED_Val = 0x7;
					break;

				case 0x7:
					LED_Val = 0xf;
					break;

				case 0xf:
					LED_Val = 0;
					break;

				case 0x00:
					LED_Val = 0x1;
					break;
			}
			
			XGpio_DiscreteWrite(&LED_Device, 1, LED_Val);
			
			counter = 0;
		}
		counter++;
	}
}

void LED_Flashing_NonStop1(XGpio LED_Device)
{
	Xuint32 counter = 0;
	Xuint32 LED_Val = 0;

	while(1)		// 1000 LEDs FLASH (Error Signal)
	{
		if(counter == (100000000/300)){
			// Set the LED state
			XGpio_DiscreteWrite(&LED_Device, 1, LED_Val);
			if(LED_Val == 0x1)
			{
				LED_Val = 0;
			}else if(LED_Val == 0x00000000)
			{
				LED_Val = 0x1;
			}
			else{
				LED_Val = 0;
			}
			counter = 0;
		}
		counter++;
	}
}void LED_Flashing_NonStop2(XGpio LED_Device)
{
	Xuint32 counter = 0;
	Xuint32 LED_Val = 0;

	while(1)		// 1100 LEDs FLASH (Error Signal)
	{
		if(counter == (100000000/300)){
			// Set the LED state
			XGpio_DiscreteWrite(&LED_Device, 1, LED_Val);
			if(LED_Val == 0x3)
			{
				LED_Val = 0;
			}else if(LED_Val == 0x00000000)
			{
				LED_Val = 0x3;
			}
			else{
				LED_Val = 0;
			}
			counter = 0;
		}
		counter++;
	}
}void LED_Flashing_NonStop3(XGpio LED_Device)
{
	Xuint32 counter = 0;
	Xuint32 LED_Val = 0;

	while(1)		// 1110 LEDs FLASH (Error Signal)
	{
		if(counter == (100000000/300)){
			// Set the LED state
			XGpio_DiscreteWrite(&LED_Device, 1, LED_Val);
			if(LED_Val == 0x7)
			{
				LED_Val = 0;
			}else if(LED_Val == 0x00000000)
			{
				LED_Val = 0x7;
			}
			else{
				LED_Val = 0;
			}
			counter = 0;
		}
		counter++;
	}
}


//void *System_Ace_Check_Function(void *arg)
void System_Ace_Check_Function()
{
	Xuint32 baseaddr;
	int returned = 0;

	unsigned char Templine[] = "00000000000000000000000001111111\n";

	baseaddr = (Xuint32)baseaddr_p;

	int x = 0;
	int debugger = 0;
	SYSACE_FILE *fp_output;

	if((fp_output = sysace_fopen("a:\\test2.txt", "w" )) == NULL)
	{
		debugger = 0;
	}

	while (x < 20)
	{
		returned = sysace_fwrite(Templine, 1, sizeof(Templine), fp_output);

		if(returned == 0 || returned == -1)
			debugger = 0;
		x++;
	}
	sysace_fwrite(&x, 1, 4, fp_output);
	sysace_fclose(fp_output);
	return;
}

void Decimal_to_Bit_String(unsigned int x)
{
	memset(Bits, '0', sizeof(Bits));
	
	Bits[32] = '\n';
	
	if( x & REACTION_1_BIT ){
		Bits[31] = '1';
	}

	if( x & REACTION_2_BIT){
		Bits[30] = '1';
	}

	if( x & REACTION_3_BIT){
		Bits[29] = '1';
	}

	if( x & REACTION_4_BIT){
		Bits[28] = '1';
	}

	if( x & REACTION_5_BIT){
		Bits[27] = '1';
	}

	if( x & REACTION_6_BIT){
		Bits[26] = '1';
	}

	if( x & REACTION_7_BIT){
		Bits[25] = '1';
	}

	if( x & REACTION_8_BIT){
		Bits[24] = '1';
	}

	if( x & REACTION_9_BIT){
		Bits[23] = '1';
	}

	if( x & REACTION_10_BIT){
		Bits[22] = '1';
	}
	return;
}

void Time_to_Bit_String(time_t x)
{
	memset(TimeBits, '0', sizeof(TimeBits));

	TimeBits[sizeof(time_t)*8] = '\n';

	time_t i = 0;
	int index = (sizeof(time_t)*8) - 1;
	
	for( i = 1; index != -1; i = i << 1)
	{
		if(x & i)
		{
			TimeBits[index] = '1';
		}
		index--;
	}
	return;
}

void Integer_to_Bit_String(unsigned int x)
{
	memset(Bits, '0', sizeof(Bits));

	Bits[sizeof(unsigned int)*8] = '\n';

	long i = 0;
	int index = (sizeof(unsigned int)*8) - 1;
	
	for( i = 1; index != -1; i = i << 1)
	{
		if(x & i)
		{
			Bits[index] = '1';
		}
		index--;
	}
	return;
}
