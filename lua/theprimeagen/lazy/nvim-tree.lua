return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                -- Default mappings
                -- vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                -- vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
                -- vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
                -- vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
                -- vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
                -- vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
                -- vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
                -- vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
                -- vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                -- vim.keymap.set("n", "q", api.tree.close, opts("Close"))
                -- vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

                -- Add your custom mappings here
                --
                vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<leader>t", api.tree.focus, opts("Focus NvimTree"))
            end,
        })
    end,
}

