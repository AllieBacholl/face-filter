	component regFile is
		port (
			clk_clk        : in  std_logic                     := 'X';             -- clk
			reset_reset_n  : in  std_logic                     := 'X';             -- reset_n
			mem_address    : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- address
			mem_clken      : in  std_logic                     := 'X';             -- clken
			mem_chipselect : in  std_logic                     := 'X';             -- chipselect
			mem_write      : in  std_logic                     := 'X';             -- write
			mem_readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			mem_writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			mem_byteenable : in  std_logic_vector(3 downto 0)  := (others => 'X')  -- byteenable
		);
	end component regFile;

	u0 : component regFile
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --   clk.clk
			reset_reset_n  => CONNECTED_TO_reset_reset_n,  -- reset.reset_n
			mem_address    => CONNECTED_TO_mem_address,    --   mem.address
			mem_clken      => CONNECTED_TO_mem_clken,      --      .clken
			mem_chipselect => CONNECTED_TO_mem_chipselect, --      .chipselect
			mem_write      => CONNECTED_TO_mem_write,      --      .write
			mem_readdata   => CONNECTED_TO_mem_readdata,   --      .readdata
			mem_writedata  => CONNECTED_TO_mem_writedata,  --      .writedata
			mem_byteenable => CONNECTED_TO_mem_byteenable  --      .byteenable
		);

