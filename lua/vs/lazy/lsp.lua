return {
	-- Mason core (manages binaries like "ruff")
	{ "mason-org/mason.nvim", opts = {} },

	-- auto-installs & (by default) auto-enables LSP servers
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
		},

		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			vim.diagnostic.config({
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			require("fidget").setup({})
			require("mason").setup()

			require("mason-lspconfig").setup({
				-- LSP servers go here
				ensure_installed = { "lua_ls", "ruff", "basedpyright", "clangd", "groovyls" },
				-- , "groovyls"

				handlers = {
					function(server_name)
						-- print("Default handler for: " .. server_name)
						vim.lsp.config[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						vim.lsp.config.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									format = {
										-- enable = true,
										-- Put format options here
										-- NOTE: the value should be STRING!!
										defaultConfig = {
											indent_style = "space",
											indent_size = "2",
										},
									},
								},
							},
						})
					end,
					["clangd"] = function()
						vim.lsp.config.clangd.setup({
							capabilities = capabilities,
							filetypes = { "c", "cpp", "objc", "objcpp" },
							root_dir = vim.lsp.config.util.root_pattern(
								"compile_commands.json",
								"compile_flags.txt",
								".git"
							),
							cmd = { "clangd", "--background-index" }, -- optional
						})
					end,
					-- ["groovyls"] = function()
					-- 	local lspconfig = require("lspconfig")
					-- 	lspconfig.groovyls.setup({
					-- 		capabilities = capabilities,
					-- 		filetypes = { "Jenkinsfile" },
					-- 	})
					-- end,
				},
			})
		end,
	},

	-- LSP configs (data-only now; we define ruff settings via core API)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
		},

		config = function()
			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						lint = {
							enable = true,
							select = { "A", "B", "C", "E", "F", "N", "W", "PL" },
							exclude = { "*.pyi", "docs/", "tests/" },
							lineLength = 100,
							preview = true,
							ignore = { "PLR0904" },
						},
						format = {
							preview = true,
							lineLength = 100,
						},
					},
				},
			})

			-- Define Ruff server configuration once, via Neovim core API
			-- vim.lsp.config("ruff", {
			-- 	init_options = {
			-- 		settings = {
			-- 			lint = {
			-- 				enable = true,
			-- 				select = { "A", "B", "C", "E", "F", "N", "W", "PL" }, -- From pyproject.toml
			-- 				exclude = { "*.pyi", "docs/", "tests/" }, -- From pyproject.toml
			-- 				lineLength = 100, -- From pyproject.toml
			-- 				preview = true, -- Enable preview features
			-- 			},
			-- 			format = {
			-- 				preview = true, -- Enable preview formatting
			-- 				lineLength = 100,
			-- 			},
			-- 		},
			-- 	},
			-- 	-- TODO: remove? I don't remeber why it is here :)
			-- 	-- on_attach = function(client, bufnr)
			-- 	--     client.server_capabilities.codeActionProvider = true -- Enable quick fixes
			-- 	--     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
			-- 	--         vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 	--             update_in_insert = true,
			-- 	--             virtual_text = true,
			-- 	--             debounce = 50,
			-- 	--         }
			-- 	--     )
			-- 	-- end,
			-- })

			-- TODO: remove pylsp
			-- vim.lsp.config('pylsp', {
			--     settings = {
			--         pylsp = {
			--             mypy = {
			--                 enabled = true,
			--                 live_mode = true,  -- runs on file change
			--                 strict = false     -- or true if you want full strictness
			--             },
			--             -- Enable only critical errors (disable unnecessary warnings)
			--             pyflakes = { enabled = true },         -- Enable pyflakes (for error checking)
			--             pycodestyle = { enabled = false },     -- Disable pycodestyle (to avoid style warnings)
			--             pylint = {
			--                 enabled = true,
			--             },
			--             flake8 = { enabled = false },         -- Disable flake8 (style checker)
			--             mccabe = { enabled = false },         -- Disable mccabe (complexity checker)
			--             pydocstyle = { enabled = false },     -- Disable pydocstyle (docstring checker)
			--
			--             -- Enable auto-formatting plugins
			--             black = { enabled = true },  -- Enable black (autoformatter)
			--             yapf = { enabled = true },               -- Enable yapf (formatter)
			--             autopep8 = { enabled = true },           -- Enable autopep8 (formatter)
			--             isort = { enabled = true },              -- Enable isort (sorting imports)
			--
			--             -- Enable trailing whitespace removal
			--             trailing_whitespace = { enabled = true },                            },
			--
			--     }
			-- })

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						disableOrganizeImports = true, -- Ruff handles imports
						disableLanguageServices = false,

						-- analysis = {
						--     -- Ignore all files for analysis to exclusively use Ruff for linting
						--     ignore = { '*' },
						-- },
						analysis = {
							autoSearchPaths = true,
							-- useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly", -- Prevent random checks
							typeCheckingMode = "off", -- Options: "off", "basic", "strict"

							diagnosticSeverityOverrides = {
								reportMissingImports = "error",

								reportArgumentType = "hint",
								reportMissingTypeStubs = "none",
								reportUnknownMemberType = "none",
								reportOptionalSubscript = "none",
								reportOptionalMemberAccess = "none",
								reportUnusedImport = "none", -- Ruff handles this
								reportUndefinedVariable = "none",
								reportGeneralTypeIssues = "none",
								reportInvalidTypeForm = "none", -- Suppress enum type annotation errors
								reportAssignmentType = "none",
								reportReturnType = "none",
								reportOptionalIterable = "none",
								reportOptionalOperand = "none",
							},
						},
					},
				},
			})
			-- lspconfig.pyright.setup({
			-- 	settings = {
			-- 		pyright = {
			-- 			disableOrganizeImports = true, -- Ruff handles imports
			-- 			disableLanguageServices = false,
			-- 		},
			-- 		python = {
			--
			-- 			-- analysis = {
			-- 			--     -- Ignore all files for analysis to exclusively use Ruff for linting
			-- 			--     ignore = { '*' },
			-- 			-- },
			-- 			analysis = {
			-- 				autoSearchPaths = true,
			-- 				-- useLibraryCodeForTypes = true,
			-- 				diagnosticMode = "openFilesOnly", -- Prevent random checks
			-- 				typeCheckingMode = "off", -- Options: "off", "basic", "strict"
			--
			-- 				diagnosticSeverityOverrides = {
			-- 					reportMissingImports = "error",
			--
			-- 					reportMissingTypeStubs = "none",
			-- 					reportUnknownMemberType = "none",
			-- 					reportOptionalSubscript = "none",
			-- 					reportOptionalMemberAccess = "none",
			-- 					reportUnusedImport = "none", -- Ruff handles this
			-- 					reportUndefinedVariable = "none",
			-- 					reportGeneralTypeIssues = "none",
			-- 					reportInvalidTypeForm = "none", -- Suppress enum type annotation errors
			-- 					reportAssignmentType = "none",
			-- 					reportReturnType = "none",
			-- 					reportOptionalIterable = "none",
			-- 					reportOptionalOperand = "none",
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	},

	{
		"hrsh7th/nvim-cmp",

		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", max_item_count = 15 },
					{ name = "path", max_item_count = 15 },
					{ name = "luasnip", max_item_count = 15 },
				}, {
					{ name = "buffer" },
				}),
			})

			-- TODO: remove
			-- local luasnip = require("luasnip")
			-- local s = luasnip.snippet
			-- local t = luasnip.text_node
			--
			-- local foo = s("bar", t("baz"))
			-- luasnip.add_snippets("all", { foo })

			-- Command-line completion
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
