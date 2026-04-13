return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"amarakon/nvim-cmp-fonts",
		"L3MON4D3/LuaSnip",
		{ "tzachar/cmp-ai", dependencies = "nvim-lua/plenary.nvim" },
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		cmp.setup({
			view = {
				entries = "custom", -- can be "custom", "wildmenu" or "native"
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "cmp_ai" },
				{ name = "nvim_lsp_signature_help" },
			}, {
				{ name = "buffer" },
			}),
			mapping = {
				-- Confirm selection with <CR>
				["<Tab>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger completion
				["<C-Space>"] = cmp.mapping.complete(),

				-- Navigate completion items with Tab/Shift+Tab
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- Close the completion menu
				["<C-e>"] = cmp.mapping.close(),
			},
			override = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
		})

		-- Use buffer source for `/` and `?`
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':'
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- You will also need to make sure you have the OpenAI api key in you environment, OPENAI_API_KEY.
		require("cmp_ai.config"):setup({
			max_lines = 1000,
			provider = "OpenAI",
			provider_options = {
				model = "gpt-4",
			},
			notify = true,
			notify_callback = function(msg)
				vim.notify(msg)
			end,
			run_on_every_keystroke = true,
			ignored_file_types = {
				-- default is not to ignore
				-- uncomment to ignore in lua:
				-- lua = true
			},
		})
	end,
}
