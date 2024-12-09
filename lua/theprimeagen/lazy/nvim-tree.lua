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

                vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<leader>t", api.tree.focus, opts("Focus NvimTree"))

                -- Create a new file or directory
                -- vim.keymap.set("n", "<leader>n", api.fs.create, opts("Create New File"))
                -- vim.keymap.set("n", "<leader>N", api.fs.create_folder, opts("Create New Folder"))
                --
                -- -- Rename a file
                -- vim.keymap.set("n", "<leader>r", api.fs.rename, opts("Rename File"))
                --
                -- -- Delete a file
                -- vim.keymap.set("n", "<leader>d", api.fs.remove, opts("Delete File"))
                --
                -- -- Cut (move) a file
                -- vim.keymap.set("n", "<leader>x", api.fs.cut, opts("Cut File"))
                --
                -- -- Copy a file
                -- vim.keymap.set("n", "<leader>c", api.fs.copy, opts("Copy File"))
                --
                -- -- Paste a file
                -- vim.keymap.set("n", "<leader>v", api.fs.paste, opts("Paste File"))
                --
                -- -- Show file in terminal
                -- vim.keymap.set("n", "<leader>t", api.tree.focus, opts("Focus NvimTree"))
                -- vim.keymap.set("n", "<leader>g", api.tree.toggle_git, opts("Toggle Git"))
                --
                -- -- Refresh the file tree
                -- vim.keymap.set("n", "<leader>R", api.tree.refresh, opts("Refresh NvimTree"))

            end,

            view = { adaptive_size = true }

        })
    end,
}

