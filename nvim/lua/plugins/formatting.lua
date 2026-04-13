return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Golang - use both goimports and go fmt
				go = { "goimports", "gofmt" },

				-- Lua
				lua = { "stylua" },

				-- All javascript file types
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },

				-- Svelte
				svelte = { "prettierd" },

				-- Misc
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				graphql = { "prettierd" },
			},
			-- The existance if this property will configure Conform to register
			-- formatters on save.
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 5000,
			},
		})
	end,
}
