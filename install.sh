#!/bin/bash
# Symlink dotfiles into the home directory.
# Run from inside the container where the dotfiles repo is mounted.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

echo "Installing dotfiles from $DOTFILES_DIR"

# Neovim
mkdir -p "$HOME_DIR/.config"
ln -sfn "$DOTFILES_DIR/nvim" "$HOME_DIR/.config/nvim"
echo "  -> nvim"

# tmux
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME_DIR/.tmux.conf"
echo "  -> tmux"

# spotify-player
mkdir -p "$HOME_DIR/.config/spotify-player"
ln -sf "$DOTFILES_DIR/spotify-player/app.toml" "$HOME_DIR/.config/spotify-player/app.toml"
ln -sf "$DOTFILES_DIR/spotify-player/theme.toml" "$HOME_DIR/.config/spotify-player/theme.toml"
echo "  -> spotify-player"

# zsh
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME_DIR/.zshrc"
echo "  -> zsh"

# git
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME_DIR/.gitconfig"
echo "  -> git"

# claude code
mkdir -p "$HOME_DIR/.claude/marketplaces"
ln -sf "$DOTFILES_DIR/claude/settings.json" "$HOME_DIR/.claude/settings.json"
ln -sf "$DOTFILES_DIR/claude/statusline-command.sh" "$HOME_DIR/.claude/statusline-command.sh"
ln -sfn "$DOTFILES_DIR/claude/marketplaces/marksman" "$HOME_DIR/.claude/marketplaces/marksman"
# Register the local marketplace per machine so no absolute path lives in settings.json
if command -v claude >/dev/null 2>&1; then
    claude plugin marketplace add "$HOME_DIR/.claude/marketplaces/marksman" >/dev/null 2>&1 || true
fi
echo "  -> claude"

# scripts
mkdir -p "$HOME_DIR/.local/bin"
for script in "$DOTFILES_DIR/scripts/"*; do
    [ -f "$script" ] || continue
    name="$(basename "$script")"
    ln -sf "$script" "$HOME_DIR/.local/bin/$name"
    echo "  -> script: $name"
done

echo "Done!"
