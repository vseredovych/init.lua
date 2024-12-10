return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "catppuccin/nvim" },

  config = function()
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
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_x = { python_env }, -- Use custom component
      },
    })
  end,
}

