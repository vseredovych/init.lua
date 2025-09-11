return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "stylua",
                    "clang-format"
                },
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_fix", "ruff_format" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    lua = { "stylua" },
                    -- javascript = { "prettier" },
                    -- typescript = { "prettier" },
                },
                formatters = {
                    ["clang-format"] = {
                        prepend_args = { "-style=file", "-fallback-style=LLVM" },
                    },
                },
                format_on_save = { timeout_ms = 500, lsp_fallback = false }
            })

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ bufnr = 0 })
            end)
        end,
    }
}
