return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        -- ideas to test
        vim.keymap.set('n', '<leader>pR', function()
            require('telescope.builtin').grep_string({
                search = vim.fn.input("Grep > "),
                search_dirs = { vim.fn.getcwd(), "$HOME/repos" }, -- Current dir + additional dirs
            })
        end)

        vim.keymap.set('n', '<leader>pr', function()
            require('telescope.builtin').find_files({
                search_dirs = { vim.fn.getcwd(), "$HOME/repos" }, -- Replace with paths you want
            })

        end, {}

        )   end
}

