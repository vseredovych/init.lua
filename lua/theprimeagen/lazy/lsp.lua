return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pylsp"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                -- Custom configuration for pylsp
                pylsp = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pylsp.setup {
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    -- Enable only critical errors (disable unnecessary warnings)
                                    pyflakes = { enabled = true },         -- Enable pyflakes (for error checking)
                                    pycodestyle = { enabled = false },     -- Disable pycodestyle (to avoid style warnings)
                                    pylint = {
                                        enabled = true,
                                        args = {
                                            "--disable=all",              -- Disable all checks
                                            "--enable=error",             -- Enable only error-level checks
                                            "--max-line-length=100",       -- Set max line length for error checking
                                        }
                                    },
                                    flake8 = { enabled = false },         -- Disable flake8 (style checker)
                                    mccabe = { enabled = false },         -- Disable mccabe (complexity checker)
                                    pydocstyle = { enabled = false },     -- Disable pydocstyle (docstring checker)

                                    -- Enable auto-formatting plugins
                                    black = { enabled = true, line_length = 100 },  -- Enable black (autoformatter)
                                    yapf = { enabled = true },               -- Enable yapf (formatter)
                                    autopep8 = { enabled = true },           -- Enable autopep8 (formatter)
                                    isort = { enabled = true },              -- Enable isort (sorting imports)

                                    -- Enable trailing whitespace removal
                                    trailing_whitespace = { enabled = true },                            },
                            }
                        },
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local uv = vim.loop
        local Path = require('plenary.path')
        -- -- Helper function to expand environment variables
        -- local function expand_env_vars(path)
        --     return path:gsub("%$(%w+)", function(var)
        --         return vim.fn.getenv(var) or "$" .. var
        --     end)
        -- end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- Expands the path of env variables like $HOME
                {
                    name = 'path',
                    options = {
                        get_paths = function()
                            local paths = {}
                            -- Use plenary to get paths in the current directory
                            for dir in Path:new(vim.fn.getcwd()):iter() do
                                table.insert(paths, dir)
                            end
                            return paths
                        end,
                        resolve = function(path)
                            -- Use plenary to expand environment variables
                            return Path:new(path):expand()
                        end,
                    }
                },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        -- `/` and `:` setup for command-line mode (enables path completion there too)
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' } -- Path suggestions
            }, {
                    { name = 'cmdline' }
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
