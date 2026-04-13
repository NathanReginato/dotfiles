# Dotfiles

Configuration files for Neovim, tmux, zsh, git, WezTerm, and utility scripts.

Designed to be mounted into a [Spaceship](https://github.com/NathanReginato/Spaceship) dev container and symlinked into place.

## Structure

```
dotfiles/
├── nvim/           # Neovim config (lazy.nvim)
├── tmux/           # tmux config (TPM + Kanagawa Dragon)
├── zsh/            # zshrc (oh-my-zsh)
├── git/            # gitconfig (aliases, settings)
├── wezterm/        # WezTerm config (host terminal)
├── scripts/        # Utility scripts (colors, etc.)
└── install.sh      # Symlinks everything into ~
```

## Usage

### Inside a Spaceship container

The dotfiles repo is mounted at `~/dotfiles`. On first run:

```bash
~/dotfiles/install.sh
```

This creates symlinks from `~/.config/nvim`, `~/.tmux.conf`, `~/.zshrc`, `~/.gitconfig`, and `~/.local/bin/*` into the mounted repo. Edits go directly to the repo — commit and push from inside the container.

### On the host (WezTerm)

Symlink or copy `wezterm/wezterm.lua` to `~/.config/wezterm/wezterm.lua`.

## Neovim

### Prerequisites

- Neovim >= 0.9
- Node.js and npm
- .NET SDK (for OmniSharp / C# support)
- A C compiler (for Treesitter parser compilation)
- ripgrep (for Telescope live grep)

Open Neovim after install. lazy.nvim will bootstrap itself and install all plugins automatically on first launch.

### LSP Servers (npm)

```bash
npm i -g azure-pipelines-language-server
npm i -g bash-language-server
npm i -g dockerfile-language-server-nodejs
npm i -g @microsoft/compose-language-service
npm i -g css-variables-language-server
npm i -g @tailwindcss/language-server
npm i -g typescript typescript-language-server
npm i -g yaml-language-server
```

### LSP Servers (Go)

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/sqls-server/sqls@latest
```

### Formatters

```bash
# Lua
cargo install stylua

# Go
go install golang.org/x/tools/cmd/goimports@latest

# Prettier (JS/TS/CSS/HTML/JSON/YAML/Markdown/GraphQL)
npm i -g @fsouza/prettierd
```

### AI Completion

The `cmp-ai` plugin requires an OpenAI API key:

```bash
export OPENAI_API_KEY="your-key-here"
```
