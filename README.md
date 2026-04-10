# Neovim Configuration

## Prerequisites

- [Neovim](https://neovim.io/) >= 0.9
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) and npm
- [Go](https://go.dev/) (for Go LSP and formatters)
- [.NET SDK](https://dotnet.microsoft.com/) (for OmniSharp / C# support)
- A C compiler (for Treesitter parser compilation)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)

## Installation

Clone this repository to your Neovim config directory:

```bash
# Linux / macOS
git clone https://github.com/<your-user>/nvim.git ~/.config/nvim

# Windows
git clone https://github.com/<your-user>/nvim.git $env:LOCALAPPDATA\nvim
```

Open Neovim. lazy.nvim will bootstrap itself and install all plugins automatically on first launch.

## External Dependencies

Plugins are managed by lazy.nvim and install automatically on startup. The tools below must be installed separately.

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

### LSP Servers (other)

```bash
# Lua language server
# Install lua-language-server from https://github.com/LuaLS/lua-language-server

# Terraform
# Install terraform-ls from https://github.com/hashicorp/terraform-ls

# Markdown
# Install marksman from https://github.com/artempyanykh/marksman

# C# / .NET (OmniSharp)
# Install OmniSharp from https://github.com/OmniSharp/omnisharp-roslyn
# Update the path in lua/plugins/lsp.lua to match your OmniSharp install location
```

### Formatters

```bash
# Lua
cargo install stylua
# or: brew install stylua

# Go
go install golang.org/x/tools/cmd/goimports@latest
# gofmt ships with the Go toolchain

# Prettier (JS/TS/CSS/HTML/JSON/YAML/Markdown/GraphQL)
npm i -g @fsouza/prettierd
```

### AI Completion

The `cmp-ai` plugin requires an OpenAI API key:

```bash
export OPENAI_API_KEY="your-key-here"
```
