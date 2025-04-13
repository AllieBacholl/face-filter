	component bram is
		port (
			clk_clk               : in  std_logic                     := 'X';             -- clk
			reset_reset_n         : in  std_logic                     := 'X';             -- reset_n
			mem_data_2_address    : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			mem_data_2_clken      : in  std_logic                     := 'X';             -- clken
			mem_data_2_chipselect : in  std_logic                     := 'X';             -- chipselect
			mem_data_2_write      : in  std_logic                     := 'X';             -- write
			mem_data_2_readdata   : out std_logic_vector(63 downto 0);                    -- readdata
			mem_data_2_writedata  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			mem_data_2_byteenable : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			mem_data_3_address    : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			mem_data_3_chipselect : in  std_logic                     := 'X';             -- chipselect
			mem_data_3_clken      : in  std_logic                     := 'X';             -- clken
			mem_data_3_write      : in  std_logic                     := 'X';             -- write
			mem_data_3_readdata   : out std_logic_vector(63 downto 0);                    -- readdata
			mem_data_3_writedata  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			mem_data_3_byteenable : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			mem_data_1_address    : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			mem_data_1_chipselect : in  std_logic                     := 'X';             -- chipselect
			mem_data_1_clken      : in  std_logic                     := 'X';             -- clken
			mem_data_1_write      : in  std_logic                     := 'X';             -- write
			mem_data_1_readdata   : out std_logic_vector(63 downto 0);                    -- readdata
			mem_data_1_writedata  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			mem_data_1_byteenable : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			mem_data_0_address    : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			mem_data_0_clken      : in  std_logic                     := 'X';             -- clken
			mem_data_0_chipselect : in  std_logic                     := 'X';             -- chipselect
			mem_data_0_write      : in  std_logic                     := 'X';             -- write
			mem_data_0_readdata   : out std_logic_vector(63 downto 0);                    -- readdata
			mem_data_0_writedata  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			mem_data_0_byteenable : in  std_logic_vector(7 downto 0)  := (others => 'X')  -- byteenable
		);
	end component bram;

	u0 : component bram
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --        clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --      reset.reset_n
			mem_data_2_address    => CONNECTED_TO_mem_data_2_address,    -- mem_data_2.address
			mem_data_2_clken      => CONNECTED_TO_mem_data_2_clken,      --           .clken
			mem_data_2_chipselect => CONNECTED_TO_mem_data_2_chipselect, --           .chipselect
			mem_data_2_write      => CONNECTED_TO_mem_data_2_write,      --           .write
			mem_data_2_readdata   => CONNECTED_TO_mem_data_2_readdata,   --           .readdata
			mem_data_2_writedata  => CONNECTED_TO_mem_data_2_writedata,  --           .writedata
			mem_data_2_byteenable => CONNECTED_TO_mem_data_2_byteenable, --           .byteenable
			mem_data_3_address    => CONNECTED_TO_mem_data_3_address,    -- mem_data_3.address
			mem_data_3_chipselect => CONNECTED_TO_mem_data_3_chipselect, --           .chipselect
			mem_data_3_clken      => CONNECTED_TO_mem_data_3_clken,      --           .clken
			mem_data_3_write      => CONNECTED_TO_mem_data_3_write,      --           .write
			mem_data_3_readdata   => CONNECTED_TO_mem_data_3_readdata,   --           .readdata
			mem_data_3_writedata  => CONNECTED_TO_mem_data_3_writedata,  --           .writedata
			mem_data_3_byteenable => CONNECTED_TO_mem_data_3_byteenable, --           .byteenable
			mem_data_1_address    => CONNECTED_TO_mem_data_1_address,    -- mem_data_1.address
			mem_data_1_chipselect => CONNECTED_TO_mem_data_1_chipselect, --           .chipselect
			mem_data_1_clken      => CONNECTED_TO_mem_data_1_clken,      --           .clken
			mem_data_1_write      => CONNECTED_TO_mem_data_1_write,      --           .write
			mem_data_1_readdata   => CONNECTED_TO_mem_data_1_readdata,   --           .readdata
			mem_data_1_writedata  => CONNECTED_TO_mem_data_1_writedata,  --           .writedata
			mem_data_1_byteenable => CONNECTED_TO_mem_data_1_byteenable, --           .byteenable
			mem_data_0_address    => CONNECTED_TO_mem_data_0_address,    -- mem_data_0.address
			mem_data_0_clken      => CONNECTED_TO_mem_data_0_clken,      --           .clken
			mem_data_0_chipselect => CONNECTED_TO_mem_data_0_chipselect, --           .chipselect
			mem_data_0_write      => CONNECTED_TO_mem_data_0_write,      --           .write
			mem_data_0_readdata   => CONNECTED_TO_mem_data_0_readdata,   --           .readdata
			mem_data_0_writedata  => CONNECTED_TO_mem_data_0_writedata,  --           .writedata
			mem_data_0_byteenable => CONNECTED_TO_mem_data_0_byteenable  --           .byteenable
		);

