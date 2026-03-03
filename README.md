# nvim

Personal Neovim config written in Lua. Plugins managed via [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-installed on first run).

## Requirements

- Neovim >= 0.9
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Setup

```sh
git clone <repo> ~/.config/nvim
nvim  # lazy.nvim bootstraps and installs plugins automatically
```

## Plugins

- **Telescope** — fuzzy finder
- **Treesitter** — syntax highlighting
- **Harpoon** — quick file navigation
- **LSP** (nvim-lspconfig + mason) — language server support
- **Conform** — formatting
- **DAP** — debugging
- **Fugitive** — git integration
- **Undotree** — undo history
- **Trouble** — diagnostics list
- **Abolish** — word variants & substitution
- **Cloak** — mask secrets in files
