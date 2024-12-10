return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "catppuccin/nvim" },

  config = function()
    -- Set the airline section to show the full file path
    vim.g.airline_section_b = "%F"

    -- Define the custom component
    local function python_env()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return "🐍 " .. venv:match("([^/]+)$")
      end
      local conda_env = os.getenv("CONDA_DEFAULT_ENV")
      if conda_env then
        return "🐍 " .. conda_env
      end
      return "" -- No environment active
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
      sections = {
        lualine_x = { python_env }, -- Use custom component
      },
    })
  end,
}

