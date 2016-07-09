
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY GLYCOLYSIS IS
	PORT(
		clk 																	: IN std_logic;
		rst 																	: IN std_logic;

		Input32 																: IN std_logic_vector(31 downto 0);
		Output05																: OUT std_logic_vector(4 downto 0);

		ADDRESS_BUS																: OUT std_logic_vector(9 downto 0);
		R_W_bit																	: OUT std_logic_vector(0 downto 0);
		DATA_BUS																: OUT std_logic_vector(26 downto 0);
		LED																		: OUT std_logic_vector(4 downto 0)
	);
END GLYCOLYSIS;

ARCHITECTURE GLYCOLYSIS_REACTIONS OF GLYCOLYSIS IS
	TYPE STATE IS (
		ASSIGN_VARS,
		
		Assign_glucose,
		Assign_ATP,									Assign_glucose_6_phosphate,					Assign_ADP,
		Assign_fructose_6_phosphate,				Assign_fructose_1_6_bisphosphate,			Assign_dihydroxyacetone_phosphate,
		Assign_glyceraldehyde_3_phosphate,			Assign_bisphosphoglycerate_1_3,				Assign_phosphoglycerate_3,
		Assign_phosphoglycerate_2,					Assign_phosphoenolpyruvate,					Assign_pyruvate,
		Assign_Pi,									Assign_H2O,									Assign_NAD,
		Assign_NADH,								Assign_H,
		
		REACTION_1, 								REACTION_2, 
		REACTION_3, 								REACTION_4,									REACTION_5, 
		REACTION_6, 								REACTION_7, 								REACTION_8, 
		REACTION_9, 								REACTION_10,

		BRAM_CHECK,									LOOP_CONDITION, 							WAIT_FOR_BRAM,
		SEND_DATA_PPC0,								SEND_DATA_PPC1,
		
		REACTION_ENDED,

		WAIT_FOR_BRAM_1,							SEND_DATA_PPC0_1,							SEND_DATA_PPC1_1,
		
		SAVE_glucose,								SAVE_ATP,									SAVE_glucose_6_phosphate,					
		SAVE_ADP,									SAVE_fructose_6_phosphate,					SAVE_fructose_1_6_bisphosphate,				
		SAVE_dihydroxyacetone_phosphate,			SAVE_glyceraldehyde_3_phosphate,			SAVE_bisphosphoglycerate_1_3,				
		SAVE_phosphoglycerate_3,					SAVE_phosphoglycerate_2,					SAVE_phosphoenolpyruvate,					
		SAVE_pyruvate,								SAVE_Pi,									SAVE_H2O,									
		SAVE_NAD,									SAVE_NADH,									SAVE_H,

		WAIT_FOR_BRAM_2,							SEND_DATA_PPC0_2,							SEND_DATA_PPC1_2,
		
		Temp_Save_State,							Redirect_Final_Save,

		ALL_Finished
	);
	
	SIGNAL 											CURRENT_STATE : STATE := ASSIGN_VARS;
	SIGNAL 											NEXT_STATE : STATE := ASSIGN_VARS;
  
	SIGNAL 
	glucose_sig, 									ATP_sig, 									glucose_6_phosphate_sig, 
	ADP_sig, 										fructose_6_phosphate_sig,					fructose_1_6_bisphosphate_sig, 
	dihydroxyacetone_phosphate_sig,					glyceraldehyde_3_phosphate_sig, 			bisphosphoglycerate_1_3_sig,
	phosphoglycerate_3_sig, 						phosphoglycerate_2_sig, 					phosphoenolpyruvate_sig,
	pyruvate_sig, 									Pi_sig, 									H2O_sig, 
	NAD_sig, 										NADH_sig, 									H_sig
	: std_logic_vector(26 downto 0) := (others => '0');
	
	SIGNAL IN_REACTIONS_sig																	: std_logic_vector(0 downto 0) := (others => '0');		
	SIGNAL SAVE_DATA_sig																	: std_logic_vector(9 downto 0) := (others => '0');

	SIGNAL ADDRESS_A_sig										 							: std_logic_vector(9 downto 0) := (others => '0');
	SIGNAL DATA_IN_sig																		: std_logic_vector(26 downto 0) := (others => '0');

	SIGNAL 
	glucose_reg, 									ATP_reg, 									glucose_6_phosphate_reg, 
	ADP_reg, 										fructose_6_phosphate_reg,					fructose_1_6_bisphosphate_reg, 
	dihydroxyacetone_phosphate_reg,					glyceraldehyde_3_phosphate_reg, 			bisphosphoglycerate_1_3_reg,
	phosphoglycerate_3_reg, 						phosphoglycerate_2_reg, 					phosphoenolpyruvate_reg,
	pyruvate_reg, 									Pi_reg, 									H2O_reg, 
	NAD_reg, 										NADH_reg, 									H_reg
	: std_logic_vector(26 downto 0) := (others => '0');
	
	SIGNAL IN_REACTIONS_reg																	: std_logic_vector(0 downto 0) := (others => '0');
	SIGNAL SAVE_DATA_reg																	: std_logic_vector(9 downto 0) := (others => '0');
	SIGNAL ADDRESS_A_reg																	: std_logic_vector(9 downto 0) := (others => '0');
	SIGNAL DATA_IN_reg																		: std_logic_vector(26 downto 0) := (others => '0');
	
	-- PPC Signaling tasks
	constant glucose_PPC 																	: std_logic_vector(4 downto 0) := B"00100";
	constant ATP_PPC 																		: std_logic_vector(4 downto 0) := B"00101";
	constant glucose_6_phosphate_PPC 														: std_logic_vector(4 downto 0) := B"00110";
	constant ADP_PPC 																		: std_logic_vector(4 downto 0) := B"00111";
	constant fructose_6_phosphate_PPC 														: std_logic_vector(4 downto 0) := B"01000";
	constant fructose_1_6_bisphosphate_PPC 													: std_logic_vector(4 downto 0) := B"01001";
	constant dihydroxyacetone_phosphate_PPC 												: std_logic_vector(4 downto 0) := B"01010";
	constant glyceraldehyde_3_phosphate_PPC 												: std_logic_vector(4 downto 0) := B"01011";
	constant bisphosphoglycerate_1_3_PPC 													: std_logic_vector(4 downto 0) := B"01100";
	constant phosphoglycerate_3_PPC 														: std_logic_vector(4 downto 0) := B"01101";
	constant phosphoglycerate_2_PPC 														: std_logic_vector(4 downto 0) := B"01110";
	constant phosphoenolpyruvate_PPC 														: std_logic_vector(4 downto 0) := B"01111";
	constant pyruvate_PPC 																	: std_logic_vector(4 downto 0) := B"10000";
	constant Pi_PPC 																		: std_logic_vector(4 downto 0) := B"10001";
	constant H2O_PPC 																		: std_logic_vector(4 downto 0) := B"10010";
	constant NAD_PPC 																		: std_logic_vector(4 downto 0) := B"10011";
	constant NADH_PPC 																		: std_logic_vector(4 downto 0) := B"10100";
	constant H_PPC 																			: std_logic_vector(4 downto 0) := B"10101";
	constant BRAM_FREE_PPC																	: std_logic_vector(4 downto 0) := B"00011";
	constant Read_BRAM0_PPC																	: std_logic_vector(4 downto 0) := B"00001";
	constant Read_BRAM1_PPC																	: std_logic_vector(4 downto 0) := B"00010";
	constant FINAL_READ_Finished_PPC														: std_logic_vector(4 downto 0) := B"11010";
	constant PPC_READ_PPC																	: std_logic_vector(4 downto 0) := B"10111";
	-- FPGA Signalling tasks                  										           
	constant glucose_FPGA 																	: std_logic_vector(4 downto 0) := B"00100";
	constant ATP_FPGA 																		: std_logic_vector(4 downto 0) := B"00101";
	constant glucose_6_phosphate_FPGA 														: std_logic_vector(4 downto 0) := B"00110";
	constant ADP_FPGA 																		: std_logic_vector(4 downto 0) := B"00111";
	constant fructose_6_phosphate_FPGA 														: std_logic_vector(4 downto 0) := B"01000";
	constant fructose_1_6_bisphosphate_FPGA 												: std_logic_vector(4 downto 0) := B"01001";
	constant dihydroxyacetone_phosphate_FPGA 												: std_logic_vector(4 downto 0) := B"01010";
	constant glyceraldehyde_3_phosphate_FPGA 												: std_logic_vector(4 downto 0) := B"01011";
	constant bisphosphoglycerate_1_3_FPGA 													: std_logic_vector(4 downto 0) := B"01100";
	constant phosphoglycerate_3_FPGA 														: std_logic_vector(4 downto 0) := B"01101";
	constant phosphoglycerate_2_FPGA 														: std_logic_vector(4 downto 0) := B"01110";
	constant phosphoenolpyruvate_FPGA 														: std_logic_vector(4 downto 0) := B"01111";
	constant pyruvate_FPGA 																	: std_logic_vector(4 downto 0) := B"10000";
	constant Pi_FPGA 																		: std_logic_vector(4 downto 0) := B"10001";
	constant H2O_FPGA 																		: std_logic_vector(4 downto 0) := B"10010";
	constant NAD_FPGA 																		: std_logic_vector(4 downto 0) := B"10011";
	constant NADH_FPGA 																		: std_logic_vector(4 downto 0) := B"10100";
	constant H_FPGA 																		: std_logic_vector(4 downto 0) := B"10101";
	constant Go_FPGA 																		: std_logic_vector(4 downto 0) := B"10110";
	constant ReRunAfterBRAMclean_FPGA														: std_logic_vector(4 downto 0) := B"00011";
	constant BRAMvalue0_FPGA																: std_logic_vector(4 downto 0) := B"00001";	
	constant BRAMvalue1_FPGA																: std_logic_vector(4 downto 0) := B"00010";		
	constant OverFlowError_FPGA																: std_logic_vector(4 downto 0) := B"10111";
	constant END_PROCESS																	: std_logic_vector(4 downto 0) := B"11000";	
	constant BRAM_FULL_FPGA																	: std_logic_vector(4 downto 0) := B"11001";
	constant BRAM_FULL_FPGA_1																: std_logic_vector(4 downto 0) := B"10110";
	constant BRAM_FULL_FPGA_2																: std_logic_vector(4 downto 0) := B"11011";
	constant Final_Saving_Process_FPGA														: std_logic_vector(4 downto 0) := B"11100";
	--Checmical Bits
	constant REACTION_1_BIT																	: std_logic_vector(9 downto 0) := B"0000000001";
	constant REACTION_2_BIT 																: std_logic_vector(9 downto 0) := B"0000000010";
	constant REACTION_3_BIT 																: std_logic_vector(9 downto 0) := B"0000000100";
	constant REACTION_4_BIT 																: std_logic_vector(9 downto 0) := B"0000001000";
	constant REACTION_5_BIT 																: std_logic_vector(9 downto 0) := B"0000010000";
	constant REACTION_6_BIT 																: std_logic_vector(9 downto 0) := B"0000100000";
	constant REACTION_7_BIT 																: std_logic_vector(9 downto 0) := B"0001000000";
	constant REACTION_8_BIT 																: std_logic_vector(9 downto 0) := B"0010000000";
	constant REACTION_9_BIT 																: std_logic_vector(9 downto 0) := B"0100000000";
	constant REACTION_10_BIT 																: std_logic_vector(9 downto 0) := B"1000000000";
	
	constant zeros27 			 															: std_logic_vector(26 downto 0) := B"000000000000000000000000000";
	constant zeros10																		: std_logic_vector(9 downto 0) := B"0000000000";
	constant zeros5 																		: std_logic_vector(4 downto 0) := B"00000";
	constant All_1																			: std_logic_vector(26 downto 0) := B"111111111111111111111111111";
	

BEGIN
	--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	IGNITE : PROCESS(clk, rst) IS
	begin
		IF( rst = '1' ) THEN
			Current_State 												<= ASSIGN_VARS;
			
			glucose_reg 												<= zeros27;
			ATP_reg 													<= zeros27;
			glucose_6_phosphate_reg 									<= zeros27;
			ADP_reg 													<= zeros27;
			fructose_6_phosphate_reg 									<= zeros27;
			fructose_1_6_bisphosphate_reg 								<= zeros27;
			dihydroxyacetone_phosphate_reg 								<= zeros27;
			glyceraldehyde_3_phosphate_reg 								<= zeros27;
			bisphosphoglycerate_1_3_reg 								<= zeros27;
			phosphoglycerate_3_reg 										<= zeros27;
			phosphoglycerate_2_reg 										<= zeros27;
			phosphoenolpyruvate_reg 									<= zeros27;
			pyruvate_reg 												<= zeros27;
			Pi_reg 														<= zeros27;
			H2O_reg 													<= zeros27;
			NAD_reg 													<= zeros27;
			NADH_reg 													<= zeros27;
			H_reg 														<= zeros27;			
			--BRAM	
			ADDRESS_A_reg 												<= zeros10;
			DATA_IN_reg 												<= zeros27;
			--
			SAVE_DATA_reg												<= zeros10;
			IN_REACTIONS_reg											<= B"1";
		ELSIF (rising_edge(clk)) THEN
			Current_State 												<= Next_State;
			
			glucose_reg 												<= glucose_sig;
			ATP_reg 													<= ATP_sig;
			glucose_6_phosphate_reg 									<= glucose_6_phosphate_sig;
			ADP_reg 													<= ADP_sig;
			fructose_6_phosphate_reg 									<= fructose_6_phosphate_sig;
			fructose_1_6_bisphosphate_reg 								<= fructose_1_6_bisphosphate_sig;
			dihydroxyacetone_phosphate_reg 								<= dihydroxyacetone_phosphate_sig;
			glyceraldehyde_3_phosphate_reg 								<= glyceraldehyde_3_phosphate_sig;
			bisphosphoglycerate_1_3_reg 								<= bisphosphoglycerate_1_3_sig;
			phosphoglycerate_3_reg 										<= phosphoglycerate_3_sig;
			phosphoglycerate_2_reg 										<= phosphoglycerate_2_sig;
			phosphoenolpyruvate_reg 									<= phosphoenolpyruvate_sig;
			pyruvate_reg 												<= pyruvate_sig;
			Pi_reg 														<= Pi_sig;
			H2O_reg 													<= H2O_sig;
			NAD_reg 													<= NAD_sig;
			NADH_reg 													<= NADH_sig;
			H_reg 														<= H_sig;			
			--BRAM	
			ADDRESS_A_reg 												<= ADDRESS_A_sig;
			DATA_IN_reg 												<= DATA_IN_sig;
			--
			SAVE_DATA_reg												<= SAVE_DATA_sig;
			IN_REACTIONS_reg											<= IN_REACTIONS_sig;
		END IF;
	END PROCESS IGNITE;
	--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	--Start
	--Pure combinational method of Synthesizable VHDL Code
	CIRCUIT : PROCESS(
			Current_State,
			--Virtual Registers
			glucose_reg, 										ATP_reg, 									glucose_6_phosphate_reg,
			ADP_reg, 											fructose_6_phosphate_reg,					fructose_1_6_bisphosphate_reg,	
			dihydroxyacetone_phosphate_reg, 					glyceraldehyde_3_phosphate_reg,				bisphosphoglycerate_1_3_reg, 	
			phosphoglycerate_3_reg,								phosphoglycerate_2_reg,						phosphoenolpyruvate_reg, 		
			pyruvate_reg,										Pi_reg,										H2O_reg, 						
			NAD_reg,											NADH_reg,									H_reg, 							
			SAVE_DATA_reg,										IN_REACTIONS_reg,
			--Inputs
			Input32,
			--BRAM
			ADDRESS_A_reg,										DATA_IN_reg
			) IS -- include the one read.
	BEGIN

		Next_State 														<= Current_State;
		Output05 														<= zeros5;
		--			
		glucose_sig 													<= glucose_reg;
		ATP_sig 														<= ATP_reg;
		glucose_6_phosphate_sig 										<= glucose_6_phosphate_reg;
		ADP_sig 														<= ADP_reg;
		fructose_6_phosphate_sig 										<= fructose_6_phosphate_reg;
		fructose_1_6_bisphosphate_sig 									<= fructose_1_6_bisphosphate_reg;
		dihydroxyacetone_phosphate_sig 									<= dihydroxyacetone_phosphate_reg;
		glyceraldehyde_3_phosphate_sig 									<= glyceraldehyde_3_phosphate_reg;
		bisphosphoglycerate_1_3_sig 									<= bisphosphoglycerate_1_3_reg;
		phosphoglycerate_3_sig 											<= phosphoglycerate_3_reg;
		phosphoglycerate_2_sig 											<= phosphoglycerate_2_reg;
		phosphoenolpyruvate_sig 										<= phosphoenolpyruvate_reg;
		pyruvate_sig 													<= pyruvate_reg;
		Pi_sig 															<= Pi_reg;
		H2O_sig 														<= H2O_reg;
		NAD_sig 														<= NAD_reg;
		NADH_sig 														<= NADH_reg;
		H_sig 															<= H_reg;
		--		
		SAVE_DATA_sig													<= SAVE_DATA_reg;
		IN_REACTIONS_sig												<= IN_REACTIONS_reg;
		ADDRESS_BUS														<= ADDRESS_A_reg;
		DATA_BUS														<= DATA_IN_reg;
		R_W_bit															<= B"0";
		ADDRESS_A_sig													<= ADDRESS_A_reg;
		DATA_IN_sig														<= DATA_IN_reg;
		
		LED																<= (OTHERS => '0');

		CASE Current_State IS
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN ASSIGN_VARS =>
				Next_State 												<= Assign_glucose;
				Output05												<= glucose_FPGA;
				LED														<= glucose_FPGA;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_glucose =>
				IF(Input32(31 DOWNTO 27) = glucose_PPC) THEN
					glucose_sig											<= Input32(26 downto 0);
					Output05											<= ATP_FPGA;
					LED													<= ATP_FPGA;
					Next_State 											<= Assign_ATP;
				ELSE
					glucose_sig											<= glucose_reg;
					Output05											<= glucose_FPGA;
					LED													<= glucose_FPGA;
					Next_State 											<= Assign_glucose;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_ATP =>
				IF(Input32(31 DOWNTO 27) = ATP_PPC) THEN
					ATP_sig												<= Input32(26 downto 0);
					Output05											<= glucose_6_phosphate_FPGA;
					LED													<= glucose_6_phosphate_FPGA;
					Next_State 											<= Assign_glucose_6_phosphate;
				ELSE
					ATP_sig												<= ATP_reg;
					Output05											<= ATP_FPGA;
					LED													<= ATP_FPGA;
					Next_State 											<= Assign_ATP;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_glucose_6_phosphate =>
				IF(Input32(31 DOWNTO 27) = glucose_6_phosphate_PPC) THEN
					glucose_6_phosphate_sig								<= Input32(26 downto 0);
					Output05											<= ADP_FPGA;
					LED													<= ADP_FPGA;
					Next_State 											<= Assign_ADP;
				ELSE
					glucose_6_phosphate_sig								<= glucose_6_phosphate_reg;
					Output05											<= glucose_6_phosphate_FPGA;
					LED													<= glucose_6_phosphate_FPGA;
					Next_State 											<= Assign_glucose_6_phosphate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_ADP =>
				IF(Input32(31 DOWNTO 27) = ADP_PPC) THEN
					ADP_sig												<= Input32(26 downto 0);
					Output05											<= fructose_6_phosphate_FPGA;
					LED													<= fructose_6_phosphate_FPGA;
					Next_State 											<= Assign_fructose_6_phosphate;
				ELSE
					ADP_sig												<= ADP_reg;
					Output05											<= ADP_FPGA;
					LED													<= ADP_FPGA;
					Next_State 											<= Assign_ADP;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_fructose_6_phosphate =>
				IF(Input32(31 DOWNTO 27) = fructose_6_phosphate_PPC) THEN
					fructose_6_phosphate_sig 							<= Input32(26 downto 0);
					Output05											<= fructose_1_6_bisphosphate_FPGA;
					LED													<= fructose_1_6_bisphosphate_FPGA;
					Next_State 											<= Assign_fructose_1_6_bisphosphate;
				ELSE
					fructose_6_phosphate_sig							<= fructose_6_phosphate_reg;
					Output05											<= fructose_6_phosphate_FPGA;
					LED													<= fructose_6_phosphate_FPGA;
					Next_State 											<= Assign_fructose_6_phosphate;
				END IF;	
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_fructose_1_6_bisphosphate =>
				IF(Input32(31 DOWNTO 27) = fructose_1_6_bisphosphate_PPC) THEN
					fructose_1_6_bisphosphate_sig 						<= Input32(26 downto 0);
					Output05											<= dihydroxyacetone_phosphate_FPGA;
					LED													<= dihydroxyacetone_phosphate_FPGA;
					Next_State 											<= Assign_dihydroxyacetone_phosphate;
				ELSE
					fructose_1_6_bisphosphate_sig						<= fructose_1_6_bisphosphate_reg;
					Output05											<= fructose_1_6_bisphosphate_FPGA;
					LED													<= fructose_1_6_bisphosphate_FPGA;
					Next_State 											<= Assign_fructose_1_6_bisphosphate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_dihydroxyacetone_phosphate =>
				IF(Input32(31 DOWNTO 27) = dihydroxyacetone_phosphate_PPC) THEN
					dihydroxyacetone_phosphate_sig 						<= Input32(26 downto 0);
					Output05											<= glyceraldehyde_3_phosphate_FPGA;
					LED													<= glyceraldehyde_3_phosphate_FPGA;
					Next_State 											<= Assign_glyceraldehyde_3_phosphate;
				ELSE
					dihydroxyacetone_phosphate_sig						<= dihydroxyacetone_phosphate_reg;
					Output05											<= dihydroxyacetone_phosphate_FPGA;
					LED													<= dihydroxyacetone_phosphate_FPGA;
					Next_State 											<= Assign_dihydroxyacetone_phosphate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_glyceraldehyde_3_phosphate =>
				IF(Input32(31 DOWNTO 27) = glyceraldehyde_3_phosphate_PPC) THEN
					glyceraldehyde_3_phosphate_sig 						<= Input32(26 downto 0);
					Output05											<= bisphosphoglycerate_1_3_FPGA;
					LED													<= bisphosphoglycerate_1_3_FPGA;
					Next_State 											<= Assign_bisphosphoglycerate_1_3;
				ELSE
					glyceraldehyde_3_phosphate_sig						<= glyceraldehyde_3_phosphate_reg;
					Output05											<= glyceraldehyde_3_phosphate_FPGA;
					LED													<= glyceraldehyde_3_phosphate_FPGA;
					Next_State 											<= Assign_glyceraldehyde_3_phosphate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_bisphosphoglycerate_1_3 =>
				IF(Input32(31 DOWNTO 27) = bisphosphoglycerate_1_3_PPC) THEN
					bisphosphoglycerate_1_3_sig 						<= Input32(26 downto 0);
					Output05											<= phosphoglycerate_3_FPGA;
					LED													<= phosphoglycerate_3_FPGA;
					Next_State 											<= Assign_phosphoglycerate_3;
				ELSE
					bisphosphoglycerate_1_3_sig							<= bisphosphoglycerate_1_3_reg;
					Output05											<= bisphosphoglycerate_1_3_FPGA;
					LED													<= bisphosphoglycerate_1_3_FPGA;
					Next_State 											<= Assign_bisphosphoglycerate_1_3;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_phosphoglycerate_3 =>
				IF(Input32(31 DOWNTO 27) = phosphoglycerate_3_PPC) THEN
					phosphoglycerate_3_sig 								<= Input32(26 downto 0);
					Output05											<= phosphoglycerate_2_FPGA;
					LED													<= phosphoglycerate_2_FPGA;
					Next_State 											<= Assign_phosphoglycerate_2;
				ELSE
					phosphoglycerate_3_sig								<= phosphoglycerate_3_reg;
					Output05											<= phosphoglycerate_3_FPGA;
					LED													<= phosphoglycerate_3_FPGA;
					Next_State 											<= Assign_phosphoglycerate_3;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_phosphoglycerate_2 =>
				IF(Input32(31 DOWNTO 27) = phosphoglycerate_2_PPC) THEN
					phosphoglycerate_2_sig 								<= Input32(26 downto 0);
					Output05											<= phosphoenolpyruvate_FPGA;
					LED													<= phosphoenolpyruvate_FPGA;
					Next_State 											<= Assign_phosphoenolpyruvate;
				ELSE
					phosphoglycerate_2_sig								<= phosphoglycerate_2_reg;
					Output05											<= phosphoglycerate_2_FPGA;
					LED													<= phosphoglycerate_2_FPGA;
					Next_State 											<= Assign_phosphoglycerate_2;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_phosphoenolpyruvate =>
				IF(Input32(31 DOWNTO 27) = phosphoenolpyruvate_PPC) THEN
					phosphoenolpyruvate_sig 							<= Input32(26 downto 0);
					Output05											<= pyruvate_FPGA;
					LED													<= pyruvate_FPGA;
					Next_State 											<= Assign_pyruvate;
				ELSE
					phosphoenolpyruvate_sig								<= phosphoenolpyruvate_reg;
					Output05											<= phosphoenolpyruvate_FPGA;
					LED													<= phosphoenolpyruvate_FPGA;
					Next_State 											<= Assign_phosphoenolpyruvate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN Assign_pyruvate =>
				IF(Input32(31 DOWNTO 27) = pyruvate_PPC) THEN
					pyruvate_sig 										<= Input32(26 downto 0);
					Output05											<= Pi_FPGA;
					LED													<= Pi_FPGA;
					Next_State 											<= Assign_Pi;
				ELSE
					pyruvate_sig										<= pyruvate_reg;
					Output05											<= pyruvate_FPGA;
					LED													<= pyruvate_FPGA;
					Next_State 											<= Assign_pyruvate;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_Pi =>
				IF(Input32(31 DOWNTO 27) = Pi_PPC) THEN
					Pi_sig 												<= Input32(26 downto 0);
					Output05											<= H2O_FPGA;
					LED													<= H2O_FPGA;
					Next_State 											<= Assign_H2O;
				ELSE
					Pi_sig												<= Pi_reg;
					Output05											<= Pi_FPGA;
					LED													<= Pi_FPGA;
					Next_State 											<= Assign_Pi;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_H2O =>
				IF(Input32(31 DOWNTO 27) = H2O_PPC) THEN
					H2O_sig 											<= Input32(26 downto 0);
					Output05											<= NAD_FPGA;
					LED													<= NAD_FPGA;
					Next_State 											<= Assign_NAD;
				ELSE				
					H2O_sig												<= H2O_reg;
					Output05											<= H2O_FPGA;
					LED													<= H2O_FPGA;
					Next_State 											<= Assign_H2O;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_NAD =>
				IF(Input32(31 DOWNTO 27) = NAD_PPC) THEN
					NAD_sig 											<= Input32(26 downto 0);
					Output05											<= NADH_FPGA;
					LED													<= NADH_FPGA;
					Next_State 											<= Assign_NADH;
				ELSE				
					NAD_sig												<= NAD_reg;
					Output05											<= NAD_FPGA;
					LED													<= NAD_FPGA;
					Next_State 											<= Assign_NAD;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_NADH =>
				IF(Input32(31 DOWNTO 27) = NADH_PPC) THEN
					NADH_sig 											<= Input32(26 downto 0);
					Output05											<= H_FPGA;
					LED													<= H_FPGA;
					Next_State 											<= Assign_H;
				ELSE				
					NADH_sig											<= NADH_reg;
					Output05											<= NADH_FPGA;
					LED													<= NADH_FPGA;
					Next_State 											<= Assign_NADH;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			 WHEN Assign_H =>
				IF(Input32(31 DOWNTO 27) = H_PPC) THEN
					H_sig 												<= Input32(26 downto 0);
					Output05											<= zeros5;
					LED													<= zeros5;
					Next_State 											<= REACTION_1;
				ELSE
					H_sig												<= H_reg;
					Output05											<= H_FPGA;
					LED													<= H_FPGA;
					Next_State 											<= Assign_H;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 1
			--//glucose + ATP4- --> glucose-6-phosphate2- + ADP3- + H+
			WHEN REACTION_1=>
				IF(glucose_reg > 0) AND (ATP_reg > 0) THEN	
					glucose_sig 										<= glucose_reg - 1;
					ATP_sig 											<= ATP_reg - 1;
					
					IF(glucose_6_phosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_2;
					END IF;
					
					IF(ADP_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_2;
					END IF;
					
					IF(H_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_2;
					END IF;
					
					
					glucose_6_phosphate_sig 							<= glucose_6_phosphate_reg + 1;
					ADP_sig 											<= ADP_reg + 1;
					H_sig 												<= H_reg + 1;

					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_1_BIT;
				ELSE
					Next_State 											<= REACTION_2;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 2
			--//glucose-6-phosphate2- --> fructose-6-phosphate2-
			WHEN REACTION_2 =>
				IF(glucose_6_phosphate_reg > 0) THEN 			
					glucose_6_phosphate_sig 							<= glucose_6_phosphate_reg - 1;
					
					IF(fructose_6_phosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_3;
					END IF;
					
					fructose_6_phosphate_sig 							<= fructose_6_phosphate_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_2_BIT;	
				ELSE
					Next_State 											<= REACTION_3;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 3
			--//fructose-6-phosphate2- + ATP4- --> fructose-1,6-bisphosphate4- + ADP3- + H+
			WHEN REACTION_3 =>
				IF(fructose_6_phosphate_reg > 0) AND (ATP_reg > 0) THEN				
					fructose_6_phosphate_sig 							<= fructose_6_phosphate_reg - 1;
					ATP_sig 											<= ATP_reg - 1;
					
					IF(fructose_1_6_bisphosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_4;
					END IF;
					
					IF(ADP_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_4;
					END IF;
					
					IF(H_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_4;
					END IF;
					
					fructose_1_6_bisphosphate_sig 						<= fructose_1_6_bisphosphate_reg + 1;
					ADP_sig 											<= ADP_reg + 1;
					H_sig 												<= H_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_3_BIT;
				ELSE
					Next_State 											<= REACTION_4;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 4
			--//fructose-1,6-bisphosphate4- --> dihydroxyacetone phosphate2- + glyceraldehyde-3-phosphate2-
			WHEN REACTION_4 =>
				IF(fructose_1_6_bisphosphate_reg > 0) THEN				
					fructose_1_6_bisphosphate_sig 						<= fructose_1_6_bisphosphate_reg - 1;
					
					IF(dihydroxyacetone_phosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_5;
					END IF;
					
					IF(glyceraldehyde_3_phosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_5;
					END IF;
					
					dihydroxyacetone_phosphate_sig 						<= dihydroxyacetone_phosphate_reg + 1;
					glyceraldehyde_3_phosphate_sig 						<= glyceraldehyde_3_phosphate_reg + 1;
					
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_4_BIT;
				ELSE
					Next_State 											<= REACTION_5;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 5
			--//dihydroxyacetone phosphate2- --> glyceraldehyde-3-phosphate2-
			WHEN REACTION_5 =>
				IF(dihydroxyacetone_phosphate_reg > 0) THEN				
					dihydroxyacetone_phosphate_sig 						<= dihydroxyacetone_phosphate_reg - 1;
					
					IF(glyceraldehyde_3_phosphate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_6;
					END IF;
					
					glyceraldehyde_3_phosphate_sig 						<= glyceraldehyde_3_phosphate_reg + 1;
					
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_5_BIT;
				ELSE
					Next_State 											<= REACTION_6;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 6
			--//glyceraldehyde-3-phosphate2- + Pi2- + NAD+ --> 1,3-bisphosphoglycerate4- + NADH + H+
			WHEN REACTION_6 =>
				IF(glyceraldehyde_3_phosphate_reg > 0) AND (Pi_reg > 0) AND (NAD_reg > 0) THEN				
					glyceraldehyde_3_phosphate_sig 						<= glyceraldehyde_3_phosphate_reg - 1;
					Pi_sig 												<= Pi_reg - 1;
					NAD_sig 											<= NAD_reg - 1;
					
					IF(bisphosphoglycerate_1_3_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_7;
					END IF;
					
					IF(NADH_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_7;
					END IF;
					
					IF(H_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_7;
					END IF;
					
					bisphosphoglycerate_1_3_sig 						<= bisphosphoglycerate_1_3_reg + 1;
					NADH_sig 											<= NADH_reg + 1;
					H_sig 												<= H_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_6_BIT;
				ELSE
					Next_State 											<= REACTION_7;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 7
			--//1,3-bisphosphoglycerate4- + ADP3- --> 3-phosphoglycerate3- + ATP4-
			WHEN REACTION_7 =>
				IF(bisphosphoglycerate_1_3_reg > 0) AND (ADP_reg > 0) THEN
					bisphosphoglycerate_1_3_sig 						<= bisphosphoglycerate_1_3_reg - 1;
					ADP_sig 											<= ADP_reg - 1;
					
					IF(phosphoglycerate_3_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_8;
					END IF;
					
					IF(ATP_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_8;
					END IF;
					
					phosphoglycerate_3_sig 								<= phosphoglycerate_3_reg + 1;
					ATP_sig 											<= ATP_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_7_BIT;
				ELSE
					Next_State 											<= REACTION_8;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 8
			--//3-phosphoglycerate3- --> 2-phosphoglycerate3-
			WHEN REACTION_8 =>
				IF(phosphoglycerate_3_reg > 0) THEN-- AND ()
					phosphoglycerate_3_sig 								<= phosphoglycerate_3_reg - 1;
					
					IF(phosphoglycerate_2_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_9;
					END IF;
					
					phosphoglycerate_2_sig 								<= phosphoglycerate_2_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_8_BIT;
				ELSE
					Next_State 											<= REACTION_9;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 9
			--//2-phosphoglycerate3- --> phosphoenolpyruvate3- + H2O
			WHEN REACTION_9 =>
				IF(phosphoglycerate_3_reg > 0) THEN
					phosphoglycerate_2_sig 								<= phosphoglycerate_2_reg - 1;
					
					IF(phosphoenolpyruvate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_10;
					END IF;
					
					IF(H2O_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= REACTION_10;
					END IF;
					
					phosphoenolpyruvate_sig 							<= phosphoenolpyruvate_reg + 1;
					H2O_sig 											<= H2O_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_9_BIT;
				ELSE
					Next_State 											<= REACTION_10;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Perform Reaction 10
			--//phosphoenolpyruvate3- + ADP3- + H+ --> pyruvate- + ATP4-
			WHEN REACTION_10 =>
				IF(phosphoenolpyruvate_reg > 0) AND (ADP_reg > 0) AND (H_reg > 0) THEN
					phosphoenolpyruvate_sig 							<= phosphoenolpyruvate_reg - 1;
					ADP_sig 											<= ADP_reg - 1;
					H_sig 												<= H_reg - 1;
					
					IF(pyruvate_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= BRAM_CHECK;
					END IF;
					
					IF(ATP_reg = All_1) THEN
						Output05										<= OverFlowError_FPGA;
						LED												<= OverFlowError_FPGA;
						Next_State 										<= REACTION_ENDED;
					ELSE
						Output05										<= zeros5;
						LED												<= zeros5;
						Next_State 										<= BRAM_CHECK;
					END IF;
					
					pyruvate_sig 										<= pyruvate_reg + 1;
					ATP_sig 											<= ATP_reg + 1;
						
					SAVE_DATA_sig										<= SAVE_DATA_reg OR REACTION_10_BIT;
				ELSE
					Next_State 											<= BRAM_CHECK;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			--Checking, if BRAM is full. 
			--		If BRAM is full. Ask PPC to empty it.
			--		If not. INC the address and signal to save DATA.
			WHEN BRAM_CHECK =>
				IF(IN_REACTIONS_reg = B"1" AND ADDRESS_A_reg = B"1111111111") THEN
					Next_State 											<= WAIT_FOR_BRAM;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
					ADDRESS_BUS											<= ADDRESS_A_reg + 1;
					DATA_BUS(9 DOWNTO 0)								<= SAVE_DATA_reg;
					DATA_BUS(26 DOWNTO 10)								<= (others => '0');
					
					R_W_bit												<= B"1";
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					IN_REACTIONS_sig									<= IN_REACTIONS_reg;
				ELSIF (SAVE_DATA_reg = B"0000000000" AND ADDRESS_A_reg /= B"0000000000") THEN
					Next_State 											<= WAIT_FOR_BRAM_1;
					IN_REACTIONS_sig									<= B"0";	
					ADDRESS_BUS											<= (others => '1');
					DATA_BUS(9 downto 0)								<= ADDRESS_A_reg;
					DATA_BUS(26 downto 10)								<= (others => '0');
					R_W_bit												<= B"1";
					Output05 											<= BRAM_FULL_FPGA_1;
					LED													<= BRAM_FULL_FPGA_1;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				ELSIF (IN_REACTIONS_reg = B"1" AND ADDRESS_A_reg /= B"1111111111") THEN		
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
					ADDRESS_BUS											<= ADDRESS_A_reg + 1;
					DATA_BUS(9 DOWNTO 0)								<= SAVE_DATA_reg;
					DATA_BUS(26 DOWNTO 10)								<= (others => '0');
					R_W_bit												<= B"1";
					
					Next_State 											<= LOOP_CONDITION;
					Output05											<= zeros5;
					LED													<= zeros5;
					IN_REACTIONS_sig									<= IN_REACTIONS_reg;
				ELSE 
					IN_REACTIONS_sig									<= IN_REACTIONS_reg;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
					ADDRESS_BUS											<= ADDRESS_A_reg;
					DATA_BUS(9 DOWNTO 0)								<= SAVE_DATA_reg;
					DATA_BUS(26 DOWNTO 10)								<= (others => '0');
					R_W_bit												<= B"0";
					
					Next_State 											<= BRAM_CHECK;
					Output05											<= zeros5;
					LED													<= zeros5;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			-- Save this Reaction cycle data in BRAM
			-- Check if another cycle is possible.
			--		If another cycle is possible. Goto Reaction_1 again.
			--		Otherwise, goto REACTION_ENDED
			-- If BRAM is full. Wait for PPC to erase it.
			WHEN LOOP_CONDITION =>
				SAVE_DATA_sig											<= zeros10;
				IF(SAVE_DATA_reg = B"0000000000" AND ADDRESS_A_reg = B"0000000000") THEN	
					Next_State 											<= SAVE_glucose;--REACTION_ENDED;
					IN_REACTIONS_sig									<= B"0";
					
					ADDRESS_BUS											<= (others => '0');
					DATA_BUS											<= (others => '0');
					R_W_bit												<= B"0";
				ELSE
					Next_State 											<= REACTION_1;
					IN_REACTIONS_sig									<= IN_REACTIONS_reg;
					
					ADDRESS_BUS											<= ADDRESS_A_reg;
					DATA_BUS(9 DOWNTO 0)								<= SAVE_DATA_reg;
					DATA_BUS(26 DOWNTO 10)								<= (others => '0');
					R_W_bit												<= B"1";
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			-- Wait for PPC to empty BRAM
			WHEN WAIT_FOR_BRAM =>
				R_W_bit													<= B"0";
				IF (Input32(31 DOWNTO 27) = Read_BRAM0_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC0;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = Read_BRAM1_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC1;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSE
					Next_State 											<= WAIT_FOR_BRAM;
					ADDRESS_BUS											<= ADDRESS_A_reg;
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC0 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM1_PPC) THEN
					Next_State 												<= SEND_DATA_PPC1;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= BRAM_CHECK;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC0;
					Output05												<= BRAMvalue0_FPGA;
					LED														<= BRAMvalue0_FPGA;
					ADDRESS_BUS												<= Input32(9 DOWNTO 0);
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC1 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM0_PPC) THEN
					Next_State 												<= SEND_DATA_PPC0;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= BRAM_CHECK;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC1;
					Output05												<= BRAMvalue1_FPGA;
					LED														<= BRAMvalue1_FPGA;
					ADDRESS_BUS 											<= Input32(9 DOWNTO 0);
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			-- Reactions Ended.
			-- Store Final Chemical Data in the BRAM.
			WHEN REACTION_ENDED =>
				Next_State 												<= REACTION_ENDED;
				Output05 												<= OverFlowError_FPGA;
				LED														<= OverFlowError_FPGA;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			-- Wait for PPC to empty BRAM
			WHEN WAIT_FOR_BRAM_1 =>
				R_W_bit													<= B"1";
				DATA_BUS(9 downto 0)									<= ADDRESS_A_reg;
				DATA_BUS(26 downto 10)									<= (others => '0');
				IF (Input32(31 DOWNTO 27) = Read_BRAM0_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC0_1;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = Read_BRAM1_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC1_1;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA;
					LED													<= BRAM_FULL_FPGA;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSE
					Next_State 											<= WAIT_FOR_BRAM_1;
					ADDRESS_BUS											<= ADDRESS_A_reg;
					Output05											<= BRAM_FULL_FPGA_1;
					LED													<= BRAM_FULL_FPGA_1;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC0_1 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM1_PPC) THEN
					Next_State 												<= SEND_DATA_PPC1_1;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= Input32(9 DOWNTO 0);
					ADDRESS_A_sig											<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= SAVE_glucose;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= (others => '0');
					ADDRESS_A_sig											<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC0_1;
					Output05												<= BRAMvalue0_FPGA;
					LED														<= BRAMvalue0_FPGA;
					ADDRESS_BUS												<= ADDRESS_A_reg;
					ADDRESS_A_sig											<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC1_1 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM0_PPC) THEN
					Next_State 												<= SEND_DATA_PPC0_1;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= Input32(9 DOWNTO 0);
					ADDRESS_A_sig											<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= SAVE_glucose;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= (others => '0');
					ADDRESS_A_sig											<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC1_1;
					Output05												<= BRAMvalue1_FPGA;
					LED														<= BRAMvalue1_FPGA;
					ADDRESS_BUS 											<= ADDRESS_A_reg;
					ADDRESS_A_sig											<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_glucose =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= glucose_reg;
				DATA_BUS												<= glucose_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_ATP =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= ATP_reg;
				DATA_BUS												<= ATP_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_glucose_6_phosphate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= glucose_6_phosphate_reg;
				DATA_BUS												<= glucose_6_phosphate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_ADP =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= ADP_reg;
				DATA_BUS												<= ADP_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_fructose_6_phosphate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= fructose_6_phosphate_reg;
				DATA_BUS												<= fructose_6_phosphate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_fructose_1_6_bisphosphate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= fructose_1_6_bisphosphate_reg;
				DATA_BUS												<= fructose_1_6_bisphosphate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_dihydroxyacetone_phosphate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= dihydroxyacetone_phosphate_reg;
				DATA_BUS												<= dihydroxyacetone_phosphate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_glyceraldehyde_3_phosphate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= glyceraldehyde_3_phosphate_reg;
				DATA_BUS												<= glyceraldehyde_3_phosphate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_bisphosphoglycerate_1_3 =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= bisphosphoglycerate_1_3_reg;
				DATA_BUS												<= bisphosphoglycerate_1_3_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_phosphoglycerate_3 =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= phosphoglycerate_3_reg;
				DATA_BUS												<= phosphoglycerate_3_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_phosphoglycerate_2 =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= phosphoglycerate_2_reg;
				DATA_BUS												<= phosphoglycerate_2_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_phosphoenolpyruvate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= phosphoenolpyruvate_reg;
				DATA_BUS												<= phosphoenolpyruvate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_pyruvate =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= pyruvate_reg;
				DATA_BUS												<= pyruvate_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_Pi =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= Pi_reg;
				DATA_BUS												<= Pi_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_H2O =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= H2O_reg;
				DATA_BUS												<= H2O_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_NAD =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= NAD_reg;
				DATA_BUS												<= NAD_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_NADH =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= NADH_reg;
				DATA_BUS												<= NADH_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SAVE_H =>
				Next_State 												<= Temp_Save_State;
				ADDRESS_BUS 											<= ADDRESS_A_reg;
				DATA_IN_sig 											<= H_reg;
				DATA_BUS												<= H_reg;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			-- Wait for PPC to empty BRAM
			WHEN WAIT_FOR_BRAM_2 =>
				R_W_bit													<= B"0";
				IF (Input32(31 DOWNTO 27) = Read_BRAM0_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC0_2;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA_2;
					LED													<= BRAM_FULL_FPGA_2;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = Read_BRAM1_PPC)	THEN
					Next_State 											<= SEND_DATA_PPC1_2;
					ADDRESS_BUS											<= Input32(9 DOWNTO 0);
					Output05											<= BRAM_FULL_FPGA_2;
					LED													<= BRAM_FULL_FPGA_2;
					ADDRESS_A_sig										<= Input32(9 DOWNTO 0);
				ELSE
					Next_State 											<= WAIT_FOR_BRAM_2;
					ADDRESS_BUS											<= ADDRESS_A_reg;
					Output05											<= BRAM_FULL_FPGA_2;
					LED													<= BRAM_FULL_FPGA_2;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC0_2 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM1_PPC) THEN
					Next_State 												<= SEND_DATA_PPC1_2;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= ALL_Finished;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS												<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC0_2;
					Output05												<= BRAMvalue0_FPGA;
					LED														<= BRAMvalue0_FPGA;
					ADDRESS_BUS												<= Input32(9 DOWNTO 0);
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN SEND_DATA_PPC1_2 =>
				IF(Input32(31 DOWNTO 27) = Read_BRAM0_PPC) THEN
					Next_State 												<= SEND_DATA_PPC0_2;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= Input32(9 DOWNTO 0);
				ELSIF (Input32(31 DOWNTO 27) = BRAM_FREE_PPC) THEN
					Next_State 												<= ALL_Finished;
					Output05												<= zeros5;
					LED														<= zeros5;
					ADDRESS_BUS 											<= (others => '0');
				ELSE
					Next_State 												<= SEND_DATA_PPC1_2;
					Output05												<= BRAMvalue1_FPGA;
					LED														<= BRAMvalue1_FPGA;
					ADDRESS_BUS 											<= Input32(9 DOWNTO 0);
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN Temp_Save_State =>
				Next_State 												<= Redirect_Final_Save;
				Output05 												<= zeros5;
				LED														<= zeros5;
				R_W_bit													<= B"1";
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN Redirect_Final_Save =>
				IF(ADDRESS_A_reg = B"0000000000") THEN
					Next_State 											<= SAVE_ATP;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000001") THEN
					Next_State 											<= SAVE_glucose_6_phosphate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000010") THEN
					Next_State 											<= SAVE_ADP;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000011") THEN
					Next_State 											<= SAVE_fructose_6_phosphate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000100") THEN
					Next_State 											<= SAVE_fructose_1_6_bisphosphate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000101") THEN
					Next_State 											<= SAVE_dihydroxyacetone_phosphate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000110") THEN
					Next_State 											<= SAVE_glyceraldehyde_3_phosphate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000000111") THEN
					Next_State 											<= SAVE_bisphosphoglycerate_1_3;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001000") THEN
					Next_State 											<= SAVE_phosphoglycerate_3;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001001") THEN
					Next_State 											<= SAVE_phosphoglycerate_2;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001010") THEN
					Next_State 											<= SAVE_phosphoenolpyruvate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001011") THEN
					Next_State 											<= SAVE_pyruvate;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001100") THEN
					Next_State 											<= SAVE_Pi;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001101") THEN
					Next_State 											<= SAVE_H2O;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001110") THEN
					Next_State 											<= SAVE_NAD;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000001111") THEN
					Next_State 											<= SAVE_NADH;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000010000") THEN
					Next_State 											<= SAVE_H;
					Output05 											<= zeros5;
					LED													<= zeros5;
					ADDRESS_A_sig										<= ADDRESS_A_reg + 1;
				ELSIF(ADDRESS_A_reg = B"0000010001") THEN
					Next_State 											<= WAIT_FOR_BRAM_2;
					Output05 											<= BRAM_FULL_FPGA_2;
					LED													<= BRAM_FULL_FPGA_2;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				ELSE
					Next_State 											<= REACTION_ENDED;
					Output05 											<= OverFlowError_FPGA;
					LED													<= OverFlowError_FPGA;
					ADDRESS_A_sig										<= ADDRESS_A_reg;
				END IF;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN ALL_Finished =>
				Next_State 												<= ALL_Finished;
				Output05 												<= END_PROCESS;
				LED														<= END_PROCESS;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			WHEN OTHERS =>
				NULL;
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		END CASE;
	END PROCESS CIRCUIT;
	--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

END GLYCOLYSIS_REACTIONS;
