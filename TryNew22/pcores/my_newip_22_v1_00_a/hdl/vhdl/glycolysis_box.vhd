library IEEE;

--Library UNISIM;
--use UNISIM.vcomponents.all;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY GLYCOLYSIS_BOX IS
	PORT(
		clk 															: IN std_logic;
		rst																: IN std_logic;

		INPUT 															: IN std_logic_vector(31 downto 0);
		OUTPUT															: OUT std_logic_vector(31 downto 0);
		LED																: OUT std_logic_vector(4 downto 0)
	);
END GLYCOLYSIS_BOX;

ARCHITECTURE GLYCOLYSIS_BOX_Arch OF GLYCOLYSIS_BOX IS

	SIGNAL ADDRESS_A 													: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL Write_Enabled												: STD_LOGIC_VECTOR(0 DOWNTO 0) := "0";
	SIGNAL DATA_IN														: STD_LOGIC_VECTOR(26 DOWNTO 0) := (others => '0');
	--SIGNAL Enable_Output												: STD_LOGIC;
	
	
	COMPONENT blk_mem_gen_v7_3_27bit IS
	  PORT (
		clka : IN STD_LOGIC;
		rsta : IN STD_LOGIC;
		--regcea : IN STD_LOGIC;
		wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		dina : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
		douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
	  );
	END COMPONENT;

	COMPONENT GLYCOLYSIS IS
		PORT(
			clk 																: IN std_logic;
			rst 																: IN std_logic;

			Input32 															: IN std_logic_vector(31 downto 0);
			Output05															: OUT std_logic_vector(4 downto 0);

			ADDRESS_BUS															: OUT std_logic_vector(9 downto 0);
			R_W_bit																: OUT std_logic_vector(0 downto 0);
			DATA_BUS															: OUT std_logic_vector(26 downto 0);
			LED																	: OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	-- attribute buffer_type: string;
	-- attribute buffer_type of clk: signal is "bufr";
	--attribute buffer_type of clk2: signal is "bufr";
	--attribute buffer_type of reset: signal is "|ibuf";
	
	ATTRIBUTE box_type : STRING;
	ATTRIBUTE box_type OF blk_mem_gen_v7_3_27bit : COMPONENT IS "black_box";
  
BEGIN

	-- BUFG_inst : BUFG
		-- port map (
			-- --O => O, -- Clock buffer output
			-- I => clk -- Clock buffer input
		-- );
	
	GLYCOLYSIS_CIRCUIT : GLYCOLYSIS
		PORT MAP (
			clk 			=> clk,
			rst 			=> rst,
	
			Input32			=> INPUT,
			Output05		=> OUTPUT(31 DOWNTO 27),
			--BRAM	
			ADDRESS_BUS		=> ADDRESS_A,
			R_W_bit			=> Write_Enabled,
			DATA_BUS		=> DATA_IN,
			LED				=> LED
		);
		

	BRAM_CIRCUIT : blk_mem_gen_v7_3_27bit
		PORT MAP (
			wea		=> Write_Enabled,
			addra		=> ADDRESS_A,
			dina		=> DATA_IN,
			clka		=> clk,
			rsta		=> rst,
			douta		=> OUTPUT(26 DOWNTO 0)
			--regcea		=> Enable_Output
		);
		
END GLYCOLYSIS_BOX_Arch;
