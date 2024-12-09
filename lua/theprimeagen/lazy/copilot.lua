return {
    "github/copilot.vim",
    config = function()
        -- Enable Copilot
        vim.g.copilot_enabled = 1

        -- Keybinding to trigger Copilot suggestions manually
        vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true })

        -- Keybinding to open Copilot's suggestion panel
        vim.api.nvim_set_keymap("n", "<leader>cp", ":Copilot panel<CR>", { noremap = true, silent = true })
    end
}
