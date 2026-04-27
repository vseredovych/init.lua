return {
    -- Mason tool installer (formatters)
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "stylua",
                    "clang-format",
                    "ruff",
                },
            })
        end,
    },

    -- Conform (formatter engine)
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    python = { "ruff_format" },
                },

                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ bufnr = 0 })
            end)
        end,
    },
}
