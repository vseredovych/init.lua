# nvim

Personal Neovim config written in Lua. Plugins managed via [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-installed on first run).

## Prerequisites

Mason auto-installs LSP servers, formatters, and DAP adapters on first launch, but the runtimes below must be present on the system first.

| Dependency | Why |
|---|---|
| Neovim >= 0.11 | `vim.lsp.config` API |
| git | lazy.nvim bootstrap, Fugitive |
| ripgrep | Telescope live grep |
| C compiler + make | Treesitter compiles parsers natively |
| Node.js | ts_ls, html, cssls, jsonls, eslint |
| Python 3 | debugpy (DAP adapter) |
| Java JDK | groovyls (Groovy/Jenkinsfile LSP) |

### Arch Linux

```sh
# Base build tools (C compiler, make, etc.)
sudo pacman -S base-devel

# Core deps
sudo pacman -S neovim git ripgrep nodejs npm python jdk-openjdk
```

### Ubuntu

```sh
# Base build tools (C compiler, make)
sudo apt-get install -y build-essential

# Core deps
sudo apt-get install -y neovim git ripgrep nodejs npm python3 openjdk-17-jdk

# Neovim from apt is often outdated — install >= 0.11 via snap if needed
sudo snap install nvim --classic
```

### macOS

```sh
# Xcode CLI tools (C compiler, make)
xcode-select --install

# Core deps (Homebrew)
brew install neovim git ripgrep node python openjdk

# Add Java to PATH (follow the caveats printed by brew)
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
```

## Python setup (pyenv)

Mason installs Python tools (ruff, basedpyright, debugpy) via `python3 -m pip`. A working Python 3 with pip is required — system Python on macOS lacks pip by default.

```sh
pyenv install 3.12
pyenv global 3.12

# verify
python3 --version
python3 -m pip --version
```

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
