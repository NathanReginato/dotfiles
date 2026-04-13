return {
	-- the colorscheme should be available when starting Neovim
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("kanagawa").load("dragon")

			local hl = vim.api.nvim_set_hl

			local palette = require("kanagawa.lib.color")

			-- Apply colors to Pmenu (autocomplete menu)
			hl(0, "Pmenu", { fg = palette.fujiWhite, bg = palette.dragonBlack3 }) -- Regular menu
			hl(0, "PmenuSel", { fg = "none", bg = palette.dragonBlue2 }) -- Selected menu item

			-- CmpItem highlights using colors from Dragon palette
			hl(0, "CmpItemAbbrDeprecated", { fg = palette.dragonGray, bg = "none", strikethrough = true }) -- Deprecated item
			hl(0, "CmpItemAbbrMatch", { fg = palette.dragonYellow, bg = "none", bold = true }) -- Matched item
			hl(0, "CmpItemAbbrMatchFuzzy", { fg = palette.dragonYellow, bg = "none", bold = true }) -- Fuzzy matched item
			hl(0, "CmpItemMenu", { fg = palette.dragonGreen2, bg = "none", italic = true }) -- Menu text

			-- CmpItem kinds with the Dragon color scheme
			hl(0, "CmpItemKindField", { fg = palette.dragonRed, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindProperty", { fg = palette.dragonRed, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindEvent", { fg = palette.dragonRed, bg = palette.dragonBlack1 })

			hl(0, "CmpItemKindText", { fg = palette.dragonGreen, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindEnum", { fg = palette.dragonGreen, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindKeyword", { fg = palette.dragonGreen, bg = palette.dragonBlack2 })

			hl(0, "CmpItemKindConstant", { fg = palette.dragonOrange, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindConstructor", { fg = palette.dragonOrange, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindReference", { fg = palette.dragonOrange, bg = palette.dragonBlack1 })

			hl(0, "CmpItemKindFunction", { fg = palette.dragonBlue2, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindStruct", { fg = palette.dragonBlue2, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindClass", { fg = palette.dragonBlue2, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindModule", { fg = palette.dragonBlue2, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindOperator", { fg = palette.dragonPink, bg = palette.dragonBlack2 })

			hl(0, "CmpItemKindVariable", { fg = palette.dragonWhite, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindFile", { fg = palette.dragonWhite, bg = palette.dragonBlack1 })

			hl(0, "CmpItemKindUnit", { fg = palette.dragonYellow, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindSnippet", { fg = palette.dragonYellow, bg = palette.dragonBlack2 })
			hl(0, "CmpItemKindFolder", { fg = palette.dragonYellow, bg = palette.dragonBlack2 })

			hl(0, "CmpItemKindMethod", { fg = palette.dragonBlue2, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindValue", { fg = palette.dragonBlue2, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindEnumMember", { fg = palette.dragonBlue2, bg = palette.dragonBlack1 })

			hl(0, "CmpItemKindInterface", { fg = palette.dragonAqua, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindColor", { fg = palette.dragonAqua, bg = palette.dragonBlack1 })
			hl(0, "CmpItemKindTypeParameter", { fg = palette.dragonAqua, bg = palette.dragonBlack1 })

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "●",
						[vim.diagnostic.severity.WARN] = "●",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			})
		end,
	},
}
