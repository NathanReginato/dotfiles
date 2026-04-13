-- plugins/telescope.lua:
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		pickers = {
			-- Find all files in current directory and sub directories
			find_files = {
				theme = "ivy", -- lower tab search
			},
			-- Find all files in current directory and sub directories that are git acknowledged
			git_files = {
				theme = "ivy",
			},
			-- Find all instances of typed word in current directory and sub directories that are git acknowledged
			live_grep = {
				theme = "ivy",
			},
			-- Find all instances of word under cursor in current directory and sub directories that are git acknowledged
			grep_string = {
				theme = "cursor",
			},
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
		end,
	},
}
