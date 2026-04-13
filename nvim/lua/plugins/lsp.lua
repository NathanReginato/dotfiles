return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		config = function()
			local on_attach = function(_, bufnr)
				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					{ noremap = true, silent = true, desc = "LSP Go to Definition" }
				)
				vim.keymap.set(
					"n",
					"<leader>ld",
					vim.diagnostic.open_float,
					{ noremap = true, silent = true, desc = "Show Line Diagnostics" }
				)
				vim.keymap.set(
					"n",
					"<leader>ln",
					vim.diagnostic.goto_next,
					{ desc = "Go to Next Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>lp",
					vim.diagnostic.goto_prev,
					{ desc = "Go to Previous Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>lq",
					vim.diagnostic.setloclist,
					{ noremap = true, silent = true, desc = "Open Diagnostics List" }
				)

				vim.keymap.set(
					"n",
					"<leader>lr",
					vim.lsp.buf.rename,
					{ noremap = true, silent = true, desc = "Rename token" }
				)

				vim.keymap.set(
					"n",
					"<leader>lR",
					vim.lsp.buf.references,
					{ noremap = true, silent = true, desc = "Find references" }
				)
				local telescope_builtin = require("telescope.builtin")

				vim.keymap.set("n", "<leader>li", function()
					telescope_builtin.lsp_implementations({
						layout_strategy = "cursor",
					})
				end, { noremap = true, silent = true, desc = "LSP Code Actions quickfix" })

				vim.keymap.set(
					"n",
					"<leader>la",
					vim.lsp.buf.code_action,
					{ noremap = true, silent = true, desc = "LSP Code Actions (Telescope)" }
				)

				require("telescope").load_extension("ui-select")
			end

			local on_attach_c_sharp = function(_, bufnr)
				vim.keymap.set(
					"n",
					"<leader>ld",
					vim.diagnostic.open_float,
					{ noremap = true, silent = true, desc = "Show Line Diagnostics" }
				)
				vim.keymap.set(
					"n",
					"<leader>ln",
					vim.diagnostic.goto_next,
					{ desc = "Go to Next Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>lp",
					vim.diagnostic.goto_prev,
					{ desc = "Go to Previous Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>li",
					vim.diagnostic.setloclist,
					{ noremap = true, silent = true, desc = "Open Diagnostics List" }
				)
				vim.keymap.set(
					"n",
					"<leader>lq",
					vim.diagnostic.setloclist,
					{ noremap = true, silent = true, desc = "Open Diagnostics List" }
				)

				vim.keymap.set(
					"n",
					"<leader>la",
					vim.lsp.buf.code_action,
					{ noremap = true, silent = true, desc = "LSP Code Actions (Telescope)" }
				)

				vim.keymap.set(
					"n",
					"<leader>lr",
					vim.lsp.buf.rename,
					{ noremap = true, silent = true, desc = "Rename token" }
				)

				vim.keymap.set("n", "gR", function()
					require("omnisharp_extended").telescope_lsp_references()
				end, { noremap = true, silent = true })

				vim.keymap.set("n", "gd", function()
					local results = require("omnisharp_extended").telescope_lsp_definition({ jump_type = "never" })
					if results and #results > 0 then
						local file_uri = results[1].uri or results[1].targetUri
						if file_uri then
							local file_path = file_uri:gsub("file://", "") -- Remove the file:// prefix
							vim.cmd("edit " .. file_path)
						end
					else
						print("No definition found")
					end
				end, { noremap = true, silent = true })

				vim.keymap.set("n", "<leader>D", function()
					require("omnisharp_extended").telescope_lsp_type_definition({ jump_type = "tabnew" })
				end, { noremap = true, silent = true })

				vim.keymap.set("n", "gi", function()
					require("omnisharp_extended").telescope_lsp_implementation({ jump_type = "tabnew" })
				end, { noremap = true, silent = true })
			end
			-- Set up the Lua language server
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Lua version (set to LuaJIT if you're using Neovim)
							version = "LuaJIT", -- 'Lua' or 'LuaJIT'
						},
						diagnostics = {
							-- Enable to get diagnostics for undefined global variables (like `vim`)
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include runtime files
						},
						format = {
							-- Allow conform to do formating
							enable = false,
						},
					},
				},
				on_attach = on_attach,
			})

			require("lspconfig").gopls.setup({
				on_attach = on_attach,
			})
			require("lspconfig").golangci_lint_ls.setup({})

			require("lspconfig").ts_ls.setup({
				on_attach = function(client, bufnr)
					-- Disable formatting for tsserver
					-- We're going to use prettier instead
					client.server_capabilities.documentFormattingProvider = false
					on_attach(client, bufnr)
				end,
			})

			-- Docker and Docker Compose
			require("lspconfig").dockerls.setup({
				on_attach = on_attach,
			})
			require("lspconfig").docker_compose_language_service.setup({
				on_attach = on_attach,
			})

			-- Terraformls should be used over terraform_lsp since it's more stable.
			require("lspconfig").terraformls.setup({
				on_attach = on_attach,
			})

			-- By default azure-pipelines-ls will only work in files named azure-pipelines.yml, this can be changed by providing additional settings like so:
			-- The Azure Pipelines LSP is a fork of yaml-language-server and as such the same settings can be passed to it as yaml-language-server.
			require("lspconfig").azure_pipelines_ls.setup({
				settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
								"/azure-pipeline*.y*l",
								"/*.azure*",
								"Azure-Pipelines/**/*.y*l",
								"Pipelines/*.y*l",
							},
							["https://raw.githubusercontent.com/sqls-server/sqls/refs/heads/master/schema.json"] = {
								"sqls.yaml",
							},
						},
					},
				},
				on_attach = on_attach,
			})

			require("lspconfig").bashls.setup({

				on_attach = on_attach,
			})
			require("lspconfig").css_variables.setup({
				on_attach = on_attach,
			})
			require("lspconfig").tailwindcss.setup({
				on_attach = on_attach,
			})

			-- Markdown functions (e.g., goto definition and reference link autocomplete)
			require("lspconfig").marksman.setup({
				on_attach = on_attach,
			})

			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						-- https://github.com/redhat-developer/yaml-language-server
						schemas = {},
					},
				},
				on_attach = on_attach,
			})

			require("lspconfig").omnisharp.setup({

				cmd = { "dotnet", "/Users/Nate/.config/nvim/omnisharp-osx-arm64-net6.0/OmniSharp.dll" },
				on_attach = on_attach_c_sharp,
				settings = {
					FormattingOptions = {
						-- Enables support for reading code style, naming convention and analyzer
						-- settings from .editorconfig.
						EnableEditorConfigSupport = true,
						-- Specifies whether 'using' directives should be grouped and sorted during
						-- document formatting.
						OrganizeImports = nil,
					},
					MsBuild = {
						-- If true, MSBuild project system will only load projects for files that
						-- were opened in the editor. This setting is useful for big C# codebases
						-- and allows for faster initialization of code navigation features only
						-- for projects that are relevant to code that is being edited. With this
						-- setting enabled OmniSharp may load fewer projects and may thus display
						-- incomplete reference lists for symbols.
						LoadProjectsOnDemand = nil,
					},
					RoslynExtensionsOptions = {
						-- Enables support for roslyn analyzers, code fixes and rulesets.
						EnableAnalyzersSupport = nil,
						-- Enables support for showing unimported types and unimported extension
						-- methods in completion lists. When committed, the appropriate using
						-- directive will be added at the top of the current file. This option can
						-- have a negative impact on initial completion responsiveness,
						-- particularly for the first few completion sessions after opening a
						-- solution.
						EnableImportCompletion = nil,
						-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
						-- true
						AnalyzeOpenDocumentsOnly = nil,
					},
					Sdk = {
						-- Specifies whether to include preview versions of the .NET SDK when
						-- determining which version to use for project loading.
						IncludePrereleases = true,
					},
				},
			})

			require("lspconfig").sqls.setup({
				cmd = { "sqls", "-config", "/Users/Nate/.config/nvim/lua/plugins/sqls.yaml" },
			})
		end,
	},
}
