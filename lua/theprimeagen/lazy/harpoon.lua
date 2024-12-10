return {
    "theprimeagen/harpoon",
    config = function()
        require("harpoon").setup({
            menu = {
                width = math.floor(vim.o.columns * 0.6), -- 80% of the screen width
                height = math.floor(vim.o.lines * 0.3), -- 30% of the screen height
            },
        })

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- Key mappings for Harpoon
        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Toggle menu" })

        vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon: Navigate to file 1" })
        vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Harpoon: Navigate to file 2" })
        vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon: Navigate to file 3" })
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon: Navigate to file 4" })
    end,
}

