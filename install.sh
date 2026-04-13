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

# zsh
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME_DIR/.zshrc"
echo "  -> zsh"

# git
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME_DIR/.gitconfig"
echo "  -> git"

# scripts
mkdir -p "$HOME_DIR/.local/bin"
for script in "$DOTFILES_DIR/scripts/"*; do
    [ -f "$script" ] || continue
    name="$(basename "$script")"
    ln -sf "$script" "$HOME_DIR/.local/bin/$name"
    echo "  -> script: $name"
done

echo "Done!"
